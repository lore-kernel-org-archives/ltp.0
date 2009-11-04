Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <markver@us.ibm.com>) id 1N5YcU-0004fC-I1
	for ltp-list@lists.sourceforge.net; Wed, 04 Nov 2009 05:41:22 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5YcN-00011W-7b
	for ltp-list@lists.sourceforge.net; Wed, 04 Nov 2009 05:41:22 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA45bUT7019149
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Nov 2009 00:37:30 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA45f9Vm102078
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Nov 2009 00:41:09 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA3JeC3w021981
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Nov 2009 14:40:12 -0500
Received: from d01ml096.pok.ibm.com (d01ml096.pok.ibm.com [9.63.10.19])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	nA3JeCnm021978
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Nov 2009 14:40:12 -0500
In-Reply-To: <mailman.103093.1257283106.5825.ltp-list@lists.sourceforge.net>
References: <mailman.103093.1257283106.5825.ltp-list@lists.sourceforge.net>
MIME-Version: 1.0
From: Mark Ver <markver@us.ibm.com>
Message-ID: <OFB7192512.13ED74E7-ON85257664.001981A6-85257664.001F3BB6@us.ibm.com>
Date: Wed, 4 Nov 2009 00:41:07 -0500
Subject: Re: [LTP] Build Fails on some archs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5468177223005686181=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.
--===============5468177223005686181==
Content-Type: multipart/alternative;
	boundary="=_alternative 001F3A9B85257664_="

This is a multipart message in MIME format.
--=_alternative 001F3A9B85257664_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I seem to be getting 2 different build problems on s390x:

On SLES-10 SP3, the make attempt gets nowhere (still need to check if=20
reproducible on a different system):
...
config.status: executing depfiles commands
config.status: executing libtool commands
h91distr02:~/ltp-full-20091031 # make all
make: *** No rule to make target `/$*', needed by `pan-all'.  Stop.
h91distr02:~/ltp-full-20091031 #


On RHEL5.4 and SLES-11 am getting build problem with the controllers=20
subdirs,  ex:

SLES-11:
...
make[3]: Entering directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers'
make[4]: Entering directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers/cgroup'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall=20
-I/root/ltp-full-20091031/testcases/kernel/include=20
-I/root/ltp-full-20091031/testcases/kernel/controllers/cgroup/../libcontrol=
lers=20
-I../../../../include -I../../../../include=20
-L/root/ltp-full-20091031/testcases/kernel/controllers/cgroup/../libcontrol=
lers=20
-L../../../../lib  fork=5Fprocesses.c   -lltp -lcontrollers -o=20
fork=5Fprocesses
/usr/lib64/gcc/s390x-suse-linux/4.3/../../../../s390x-suse-linux/bin/ld:=20
cannot find -lcontrollers
collect2: ld returned 1 exit status
make[4]: *** [fork=5Fprocesses] Error 1
make[4]: Leaving directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers/cgroup'
make[3]: *** [all] Error 2
make[3]: Leaving directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/ltp-full-20091031/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ltp-full-20091031/testcases'
make: *** [testcases-all] Error 2

RHEL5.4:
...
make[3]: Entering directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers'
make[4]: Entering directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers/cgroup=5Ffj'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall=20
-I/root/ltp-full-20091031/testcases/kernel/include=20
-I/root/ltp-full-20091031/testcases/kernel/controllers/cgroup=5Ffj/../libco=
ntrollers=20
-Wall -O2 -Wextra -I../../../../include -I../../../../include=20
-L/root/ltp-full-20091031/testcases/kernel/controllers/cgroup=5Ffj/../libco=
ntrollers=20
-L../../../../lib  cgroup=5Ffj=5Fproc.c   -lltp -lcontrollers -o=20
cgroup=5Ffj=5Fproc
/usr/bin/ld: cannot find -lcontrollers
collect2: ld returned 1 exit status
make[4]: *** [cgroup=5Ffj=5Fproc] Error 1
make[4]: Leaving directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers/cgroup=5Ffj'
make[3]: *** [all] Error 2
make[3]: Leaving directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/ltp-full-20091031/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ltp-full-20091031/testcases'
make: *** [testcases-all] Error 2

Also should I expect the same result if I retry the compile with the=20
following?
        make clean
        make autotools
        ./configure
        make all

Cause RHEL5.4 and SLES-11 get the same error but a different complaint=20
than what they got on the original build attempt:
...
make[5]: Entering directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers/cpuset/cpuset=5Fsysca=
ll=5Ftest'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall=20
-I/root/ltp-full-20091031/testcases/kernel/include=20
-I../../../../../include -I../../../../../include=20
-L/root/ltp-full-20091031/testcases/kernel/controllers/cpuset/cpuset=5Fsysc=
all=5Ftest/../cpuset=5Flib=20
-L../../../../../lib  cpuset=5Fsyscall=5Ftest.c   -lltp -lcpu=5Fset -o=20
cpuset=5Fsyscall=5Ftest
cpuset=5Fsyscall=5Ftest.c: In function =E2get=5Fmempolicy=E2:
cpuset=5Fsyscall=5Ftest.c:67: error: =E2=5F=5FNR=5Fget=5Fmempolicy=E2 undec=
lared (first=20
use in this function)
cpuset=5Fsyscall=5Ftest.c:67: error: (Each undeclared identifier is reporte=
d=20
only once
cpuset=5Fsyscall=5Ftest.c:67: error: for each function it appears in.)
cpuset=5Fsyscall=5Ftest.c: In function =E2mbind=E2:
cpuset=5Fsyscall=5Ftest.c:73: error: =E2=5F=5FNR=5Fmbind=E2 undeclared (fir=
st use in=20
this function)
cpuset=5Fsyscall=5Ftest.c: In function =E2set=5Fmempolicy=E2:
cpuset=5Fsyscall=5Ftest.c:78: error: =E2=5F=5FNR=5Fset=5Fmempolicy=E2 undec=
lared (first=20
use in this function)
cpuset=5Fsyscall=5Ftest.c: In function =E2process=5Foptions=E2:
cpuset=5Fsyscall=5Ftest.c:100: warning: unused variable =E2file=E2
cpuset=5Fsyscall=5Ftest.c: In function =E2test=5Fmbind=E2:
cpuset=5Fsyscall=5Ftest.c:177: warning: format =E2%lx=E2 expects type =E2lo=
ng=20
unsigned int=E2, but argument 2 has type =E2void *=E2
make[5]: *** [cpuset=5Fsyscall=5Ftest] Error 1
make[5]: Leaving directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers/cpuset/cpuset=5Fsysca=
ll=5Ftest'
make[4]: *** [all] Error 2
make[4]: Leaving directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers/cpuset'
make[3]: *** [all] Error 2
make[3]: Leaving directory=20
`/root/ltp-full-20091031/testcases/kernel/controllers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/ltp-full-20091031/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ltp-full-20091031/testcases'
make: *** [testcases-all] Error 2


- Mark Ver

office:  Building 710 / Room 2-RF-10
phone: (845) 435-7794  [tie 8 295-7794]

--=_alternative 001F3A9B85257664_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">I seem to be getting 2 different bui=
ld
problems on s390x:</font>
<br>
<br><font size=3D2 face=3D"sans-serif">On SLES-10 SP3, the make attempt gets
nowhere (still need to check if reproducible on a different system):</font>
<br><font size=3D2 face=3D"sans-serif">...</font>
<br><font size=3D2 face=3D"sans-serif">config.status: executing depfiles co=
mmands</font>
<br><font size=3D2 face=3D"sans-serif">config.status: executing libtool com=
mands</font>
<br><font size=3D2 face=3D"sans-serif">h91distr02:~/ltp-full-20091031 # make
all</font>
<br><font size=3D2 face=3D"sans-serif">make: *** No rule to make target `/$=
*',
needed by `pan-all'. &nbsp;Stop.</font>
<br><font size=3D2 face=3D"sans-serif">h91distr02:~/ltp-full-20091031 #</fo=
nt>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">On RHEL5.4 and SLES-11 am getting bu=
ild
problem with the controllers subdirs, &nbsp;ex:</font>
<br>
<br><font size=3D2 face=3D"sans-serif">SLES-11:</font>
<br><font size=3D2 face=3D"sans-serif">...</font>
<br><font size=3D2 face=3D"sans-serif">make[3]: Entering directory `/root/l=
tp-full-20091031/testcases/kernel/controllers'</font>
<br><font size=3D2 face=3D"sans-serif">make[4]: Entering directory `/root/l=
tp-full-20091031/testcases/kernel/controllers/cgroup'</font>
<br><font size=3D2 face=3D"sans-serif">gcc -g -O2 -g -O2 -fno-strict-aliasi=
ng
-pipe -Wall &nbsp;-I/root/ltp-full-20091031/testcases/kernel/include -I/roo=
t/ltp-full-20091031/testcases/kernel/controllers/cgroup/../libcontrollers
-I../../../../include -I../../../../include &nbsp; -L/root/ltp-full-2009103=
1/testcases/kernel/controllers/cgroup/../libcontrollers
-L../../../../lib &nbsp;fork=5Fprocesses.c &nbsp; -lltp -lcontrollers -o
fork=5Fprocesses</font>
<br><font size=3D2 face=3D"sans-serif">/usr/lib64/gcc/s390x-suse-linux/4.3/=
../../../../s390x-suse-linux/bin/ld:
cannot find -lcontrollers</font>
<br><font size=3D2 face=3D"sans-serif">collect2: ld returned 1 exit status<=
/font>
<br><font size=3D2 face=3D"sans-serif">make[4]: *** [fork=5Fprocesses] Error
1</font>
<br><font size=3D2 face=3D"sans-serif">make[4]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel/controllers/cgroup'</font>
<br><font size=3D2 face=3D"sans-serif">make[3]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[3]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel/controllers'</font>
<br><font size=3D2 face=3D"sans-serif">make[2]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[2]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel'</font>
<br><font size=3D2 face=3D"sans-serif">make[1]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[1]: Leaving directory `/root/lt=
p-full-20091031/testcases'</font>
<br><font size=3D2 face=3D"sans-serif">make: *** [testcases-all] Error 2</f=
ont>
<br>
<br><font size=3D2 face=3D"sans-serif">RHEL5.4:</font>
<br><font size=3D2 face=3D"sans-serif">...</font>
<br><font size=3D2 face=3D"sans-serif">make[3]: Entering directory `/root/l=
tp-full-20091031/testcases/kernel/controllers'</font>
<br><font size=3D2 face=3D"sans-serif">make[4]: Entering directory `/root/l=
tp-full-20091031/testcases/kernel/controllers/cgroup=5Ffj'</font>
<br><font size=3D2 face=3D"sans-serif">gcc -g -O2 -g -O2 -fno-strict-aliasi=
ng
-pipe -Wall &nbsp;-I/root/ltp-full-20091031/testcases/kernel/include -I/roo=
t/ltp-full-20091031/testcases/kernel/controllers/cgroup=5Ffj/../libcontroll=
ers
-Wall -O2 -Wextra -I../../../../include -I../../../../include &nbsp; -L/roo=
t/ltp-full-20091031/testcases/kernel/controllers/cgroup=5Ffj/../libcontroll=
ers
-L../../../../lib &nbsp;cgroup=5Ffj=5Fproc.c &nbsp; -lltp -lcontrollers -o
cgroup=5Ffj=5Fproc</font>
<br><font size=3D2 face=3D"sans-serif">/usr/bin/ld: cannot find -lcontrolle=
rs</font>
<br><font size=3D2 face=3D"sans-serif">collect2: ld returned 1 exit status<=
/font>
<br><font size=3D2 face=3D"sans-serif">make[4]: *** [cgroup=5Ffj=5Fproc] Er=
ror
1</font>
<br><font size=3D2 face=3D"sans-serif">make[4]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel/controllers/cgroup=5Ffj'</font>
<br><font size=3D2 face=3D"sans-serif">make[3]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[3]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel/controllers'</font>
<br><font size=3D2 face=3D"sans-serif">make[2]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[2]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel'</font>
<br><font size=3D2 face=3D"sans-serif">make[1]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[1]: Leaving directory `/root/lt=
p-full-20091031/testcases'</font>
<br><font size=3D2 face=3D"sans-serif">make: *** [testcases-all] Error 2</f=
ont>
<br>
<br><font size=3D2 face=3D"sans-serif">Also should I expect the same result
if I retry the compile with the following?</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; make
clean</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; make
autotools</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; ./config=
ure</font>
<br><font size=3D2 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; make
all</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Cause RHEL5.4 and SLES-11 get the sa=
me
error but a different complaint than what they got on the original build
attempt:</font>
<br><font size=3D2 face=3D"sans-serif">...</font>
<br><font size=3D2 face=3D"sans-serif">make[5]: Entering directory `/root/l=
tp-full-20091031/testcases/kernel/controllers/cpuset/cpuset=5Fsyscall=5Ftes=
t'</font>
<br><font size=3D2 face=3D"sans-serif">gcc -g -O2 -g -O2 -fno-strict-aliasi=
ng
-pipe -Wall &nbsp;-I/root/ltp-full-20091031/testcases/kernel/include -I../.=
./../../../include
-I../../../../../include &nbsp; -L/root/ltp-full-20091031/testcases/kernel/=
controllers/cpuset/cpuset=5Fsyscall=5Ftest/../cpuset=5Flib
-L../../../../../lib &nbsp;cpuset=5Fsyscall=5Ftest.c &nbsp; -lltp -lcpu=5Fs=
et
-o cpuset=5Fsyscall=5Ftest</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c: In functi=
on =E2get=5Fmempolicy=E2:</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c:67: error:=
 =E2=5F=5FNR=5Fget=5Fmempolicy=E2
undeclared (first use in this function)</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c:67: error:=
 (Each
undeclared identifier is reported only once</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c:67: error:=
 for
each function it appears in.)</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c: In functi=
on =E2mbind=E2:</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c:73: error:=
 =E2=5F=5FNR=5Fmbind=E2
undeclared (first use in this function)</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c: In functi=
on =E2set=5Fmempolicy=E2:</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c:78: error:=
 =E2=5F=5FNR=5Fset=5Fmempolicy=E2
undeclared (first use in this function)</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c: In functi=
on =E2process=5Foptions=E2:</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c:100: warni=
ng:
unused variable =E2file=E2</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c: In functi=
on =E2test=5Fmbind=E2:</font>
<br><font size=3D2 face=3D"sans-serif">cpuset=5Fsyscall=5Ftest.c:177: warni=
ng:
format =E2%lx=E2 expects type =E2long unsigned int=E2, but argument 2 has t=
ype
=E2void *=E2</font>
<br><font size=3D2 face=3D"sans-serif">make[5]: *** [cpuset=5Fsyscall=5Ftes=
t] Error
1</font>
<br><font size=3D2 face=3D"sans-serif">make[5]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel/controllers/cpuset/cpuset=5Fsyscall=5Ftest=
'</font>
<br><font size=3D2 face=3D"sans-serif">make[4]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[4]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel/controllers/cpuset'</font>
<br><font size=3D2 face=3D"sans-serif">make[3]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[3]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel/controllers'</font>
<br><font size=3D2 face=3D"sans-serif">make[2]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[2]: Leaving directory `/root/lt=
p-full-20091031/testcases/kernel'</font>
<br><font size=3D2 face=3D"sans-serif">make[1]: *** [all] Error 2</font>
<br><font size=3D2 face=3D"sans-serif">make[1]: Leaving directory `/root/lt=
p-full-20091031/testcases'</font>
<br><font size=3D2 face=3D"sans-serif">make: *** [testcases-all] Error 2</f=
ont>
<br>
<br><font size=3D2 face=3D"sans-serif"><br>
- Mark Ver<br>
<br>
office: &nbsp;Building 710 / Room 2-RF-10<br>
phone: (845) 435-7794 &nbsp;[tie 8 295-7794]<br>
</font>
--=_alternative 001F3A9B85257664_=--


--===============5468177223005686181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5468177223005686181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5468177223005686181==--

