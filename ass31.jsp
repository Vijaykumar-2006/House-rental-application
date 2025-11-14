<%@ page import="java.text.DecimalFormat" %>
<%
    String name = request.getParameter("name");
    String salaryStr = request.getParameter("salary");
    String loanAmountStr = request.getParameter("loanAmount");
    String creditScoreStr = request.getParameter("creditScore");

    String message = "";
    boolean isSubmitted = (name != null && salaryStr != null && loanAmountStr != null && creditScoreStr != null);

    if (isSubmitted) {
        try {
            double salary = Double.parseDouble(salaryStr);
            double loanAmount = Double.parseDouble(loanAmountStr);
            int creditScore = Integer.parseInt(creditScoreStr);
            DecimalFormat df = new DecimalFormat("#.##");

            // Validation for negative or zero values
            if (salary <= 0 || loanAmount <= 0 || creditScore <= 0) {
                message = "❌ Error: Salary, Loan Amount, and Credit Score must be greater than 0.";
            } else if (creditScore < 600) {
                message = "❌ Loan Denied: Credit score below 600.";
            } else {
                double maxLoanCap = 0;
                double interestRate = 0;

                // Determine max loan based on salary
                if (salary > 80000) maxLoanCap = 100000;
                else if (salary >= 50000) maxLoanCap = 50000;
                else if (salary >= 30000) maxLoanCap = 20000;
                else {
                    message = "❌ Loan Denied: Salary below $30,000.";
                }

                // Determine interest rate based on credit score
                if (creditScore >= 600 && creditScore < 700) interestRate = 8;
                else if (creditScore < 800) interestRate = 5;
                else interestRate = 3;

                // Final loan approval logic
                if (message.equals("")) {
                    if (loanAmount > maxLoanCap) {
                        message = "❌ Loan Denied: Requested amount exceeds allowed cap of $" + maxLoanCap + ".";
                    } else {
                        message = "Loan Approved for " + name + "!<br/>" +
                                  "Amount: $" + df.format(loanAmount) + "<br/>" +
                                  "Interest Rate: " + interestRate + "%";
                    }
                }
            }
        } catch (NumberFormatException e) {
            message = "❌ Error: Please enter valid numbers for salary, loan amount, and credit score.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Loan Eligibility Checker</title>
</head>
<body>
    <h2>Loan Eligibility Form</h2>
    <form method="post">
        Name: <input type="text" name="name" required><br/><br/>
        Salary: <input type="text" name="salary" required><br/><br/>
        Loan Amount: <input type="text" name="loanAmount" required><br/><br/>
        Credit Score: <input type="text" name="creditScore" required><br/><br/>
        <input type="submit" value="Check Eligibility">
    </form>
    <hr/>
    <div>
        <%= message %>
    </div>
</body>
</html>
