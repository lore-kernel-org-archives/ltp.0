From: $rik@nth  <srikanth007m@gmail.com>
Date: Thu, 15 Oct 2015 19:17:36 +0530
Subject: [LTP]  getpwnam(nobody) failed
Message-ID: <CANKSX+GTDu9Ce9UUmfWo4E4+uxNi9Dh8Ek=a9J2YM1=4sAZ9Pw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello All,

Need some help in understanding the behavior of failure cases though
user 'nobody' is present. I am unable to figure it out as i am running
them on android kernel.

Few failure cases:
Line 561: fchmod02    1  TBROK  :  fchmod02.c:174: nobody not in /etc/passwd
Line 568: fchmod05    1  TBROK  :  fchmod05.c:178: Couldn't find uid
of nobody: No such file or directory
Line 588: fchown03    1  TBROK  :  safe_macros.c:122: fchown03.c:115:
getpwnam(nobody) failed: errno=ENOENT(2): No such file or directory
Line 591: fchown03_16    1  TBROK  :  safe_macros.c:122:
fchown03.c:115: getpwnam(nobody) failed: errno=ENOENT(2): No such file
or directory
Line 1318: fstat02     1  TBROK  :  safe_macros.c:122: fstat02.c:120:
getpwnam(nobody) failed: errno=ENOENT(2): No such file or directory
Line 1320: fstat02     1  TBROK  :  safe_macros.c:122: fstat02.c:120:
getpwnam(nobody) failed: errno=ENOENT(2): No such file or directory


#cat /etc/passwd
nobody:x:65534:65534:nobody::
bin:x:1:1:bin::
daemon:x:2:2:daemon::

#cat /etc/group
nobody:x:9999:
bin:x::
daemon:x::
users:x:100:
sys:x:3:


-- 
Thanks & Regards,
M.Srikanth Kumar.
