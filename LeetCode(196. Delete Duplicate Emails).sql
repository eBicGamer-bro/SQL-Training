DELETE P1
FROM person P1 full join person P2
on P1.email = P2.email
where P1.id > P2.id;