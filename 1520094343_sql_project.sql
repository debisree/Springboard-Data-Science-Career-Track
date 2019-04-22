/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard
	
The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECTÿ*ÿ
FROMÿ`Facilities`ÿ
WHEREÿmembercostÿ>0

 

/* Q2: How many facilities do not charge a fee to members? */

SELECTÿCOUNT(ÿ*ÿ)ÿ
FROMÿFacilities
WHEREÿmembercostÿ=0


/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */


SELECTÿfacid,ÿname,ÿmembercost,ÿmonthlymaintenance
FROMÿFacilities
WHEREÿmembercostÿ>0
ANDÿmembercostÿ/ÿmonthlymaintenanceÿ<ÿ0.2
LIMITÿ0ÿ,ÿ30
 

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECTÿ*ÿ
FROMÿFacilities
WHEREÿfacid
INÿ(ÿ1,ÿ5ÿ)ÿ
LIMITÿ0ÿ,ÿ30
 


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECTÿname,ÿmonthlymaintenance,ÿ
CASEÿWHENÿmonthlymaintenanceÿ>100
THENÿ'expensive'
ELSEÿ'cheap'
ENDÿASÿlabel
FROMÿFacilities
 
/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECTÿfirstname,ÿsurname
FROMÿMembers
WHEREÿjoindateÿ=ÿ(ÿ
SELECTÿMAX(ÿjoindateÿ)ÿ
FROMÿMembersÿ)
 
/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECTÿsub.court,ÿCONCAT(ÿsub.firstname,ÿ' ',ÿsub.surnameÿ)ÿASÿname
FROMÿ(

SELECTÿFacilities.nameÿASÿcourt,ÿMembers.firstnameÿASÿfirstname,ÿMembers.surnameÿASÿsurname
FROMÿBookings
INNERÿJOINÿFacilitiesÿONÿBookings.facidÿ=ÿFacilities.facid
ANDÿFacilities.nameÿLIKEÿ'Tennis Court%'
INNERÿJOINÿMembersÿONÿBookings.memidÿ=ÿMembers.memid
)sub
GROUPÿBYÿsub.court,ÿsub.firstname,ÿsub.surname
ORDERÿBYÿname
 

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECTÿFacilities.nameÿASÿfacility,ÿCONCAT(ÿMembers.firstname,ÿ' ',ÿMembers.surnameÿ)ÿASÿname,ÿ
CASEÿWHENÿBookings.memidÿ=0
THENÿFacilities.guestcostÿ*ÿBookings.slots
ELSEÿFacilities.membercostÿ*ÿBookings.slots
ENDÿASÿcost
FROMÿBookings
INNERÿJOINÿFacilitiesÿONÿBookings.facidÿ=ÿFacilities.facid
ANDÿBookings.starttimeÿLIKEÿ'2012-09-14%'
ANDÿ(
(
(
Bookings.memidÿ=0
)
ANDÿ(
Facilities.guestcostÿ*ÿBookings.slotsÿ>30
)
)
ORÿ(
(
Bookings.memidÿ!=0
)
ANDÿ(
Facilities.membercostÿ*ÿBookings.slotsÿ>30
)
)
)
INNERÿJOINÿMembersÿONÿBookings.memidÿ=ÿMembers.memid
ORDERÿBYÿcostÿDESCÿ
 

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECTÿ*ÿ
FROMÿ(

SELECTÿFacilities.nameÿASÿfacility,ÿCONCAT(ÿMembers.firstname,ÿ' ',ÿMembers.surnameÿ)ÿASÿname,ÿ
CASEÿWHENÿBookings.memidÿ=0
THENÿFacilities.guestcostÿ*ÿBookings.slots
ELSEÿFacilities.membercostÿ*ÿBookings.slots
ENDÿASÿcost
FROMÿBookings
INNERÿJOINÿFacilitiesÿONÿBookings.facidÿ=ÿFacilities.facid
ANDÿBookings.starttimeÿLIKEÿ'2012-09-14%'
INNERÿJOINÿMembersÿONÿBookings.memidÿ=ÿMembers.memid
)sub
WHEREÿsub.costÿ>30
ORDERÿBYÿsub.costÿDESC
 


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */


SELECTÿ*ÿ
FROMÿ(

SELECTÿsub.facility,ÿSUM(ÿsub.costÿ)ÿASÿtotal_revenue
FROMÿ(

SELECTÿFacilities.nameÿASÿfacility,ÿ
CASEÿWHENÿBookings.memidÿ=0
THENÿFacilities.guestcostÿ*ÿBookings.slots
ELSEÿFacilities.membercostÿ*ÿBookings.slots
ENDÿASÿcost
FROMÿBookings
INNERÿJOINÿFacilitiesÿONÿBookings.facidÿ=ÿFacilities.facid
INNERÿJOINÿMembersÿONÿBookings.memidÿ=ÿMembers.memid
)sub
GROUPÿBYÿsub.facility
)sub2
WHEREÿsub2.total_revenueÿ<1000

