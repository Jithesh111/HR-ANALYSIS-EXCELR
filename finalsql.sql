create database hr_attrition;
use hr_attrition;



select * from hr_attrition;
select * from hr_2;

drop table hr_1;
drop table hr_2;

SELECT * FROM hr_attrition
JOIN hr_2 
ON hr_attrition.EmployeeNumber = hr_2.Employee_ID;

### 1.Average Attrition Rate for All departments###

select Department,(SELECT COUNT(ATTRITION) FROM hr_attrition where attrition="Yes")/
(SELECT COUNT(ATTRITION) FROM hr_attrition group by department) as "Attrition_rate" from hr_attrition;

SELECT department, COUNT(Attrition)/ (SELECT COUNT(Attrition) FROM Attrition) * 100 AS Attrition_rate
FROM hr_attrition
WHERE Attrition = 'Yes'
GROUP BY department;


####2.Average Hourly rate of all male research scientist####

select avg(HourlyRate),Gender,JobRole from hr_attrition where jobRole="Research Scientist" and Gender="Male" group by Gender;

###3. Attrition  rate Vs monthly income stats###

select((SELECT COUNT(ATTRITION) FROM hr_attrition where attrition="Yes")/(SELECT COUNT(ATTRITION) FROM hr_attrition group by department))*100 as "Attrition_rate",
(case when monthlyincome>=1000 and monthlyincome<=10000 then "1000-10000"
when monthlyincome>=11000 and monthlyincome<=20000 then "11000-20000"
when monthlyincome>=21000 and monthlyincome<=30000 then "21000-30000"
when monthlyincome>=31000 and monthlyincome<=40000 then "31000-40000"
when monthlyincome>=41000 and monthlyincome<=50000 then "41000-50000"
 end) as monthlyincome_status
 from hr_attrition
join hr_2
on hr_attrition.employeenumber=hr_2.employee_ID group by monthlyincome_status;




###4. Average working years for each department###

select department,avg(totalworkingyears)
from hr_attrition
join hr_2
on hr_attrition.employeenumber=hr_2.employee_ID group by department;


###5.Job role vs Worklife balance###


select jobrole, 
(case when worklifebalance=1 then "Excellent"
	when worklifebalance=2 then "Good"
    when worklifebalance=3 then "Average"
    when worklifebalance=4 then "Poor"
    end) as worklifebalance_status
    from hr_attrition
    join hr_2
    on hr_attrition.employeenumber=hr_2.employee_Id ;
    
###6.attrition rate Vs year since last promotion relation###

select((SELECT COUNT(ATTRITION) FROM hr_attrition where attrition="Yes")/(SELECT COUNT(ATTRITION) FROM hr_attrition))*100 as "Attrition_rate", yearssincelastpromotion
from hr_attrition
join hr_2
on hr_attrition.employeenumber=hr_2.employee_Id group by yearssincelastpromotion;
