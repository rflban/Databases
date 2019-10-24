copy parlor(address, opentime, endtime, phone)
from '/home/faris/Documents/Repositories/bmstu/Databases/lab_01/parlors.csv' delimiter ';' csv header;

copy master(fname, mname, lname, score, experience, phone, parlor_id)
from '/home/faris/Documents/Repositories/bmstu/Databases/lab_01/masters.csv' delimiter ';' csv header;

copy client(fname, mname, lname, phone)
from '/home/faris/Documents/Repositories/bmstu/Databases/lab_01/clients.csv' delimiter ';' csv header;

copy tattoo(name, price, master_id, client_id)
from '/home/faris/Documents/Repositories/bmstu/Databases/lab_01/tattooes.csv' delimiter ';' csv header;

