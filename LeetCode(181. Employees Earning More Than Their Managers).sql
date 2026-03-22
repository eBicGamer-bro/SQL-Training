Select e.name as Employee from Employee e inner join Employee m
on e.ManagerID = m.ID 
where e.Salary > m.Salary