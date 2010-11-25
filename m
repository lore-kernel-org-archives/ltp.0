Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PLUtt-0007H7-M9
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 06:01:45 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLUts-0003uF-Bk
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 06:01:45 +0000
Date: Thu, 25 Nov 2010 01:01:38 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1303921694.438401290664898120.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1236809510.438331290664492921.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] extend the '-I' options
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6957674363584621261=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6957674363584621261==
Content-Type: multipart/alternative; 
	boundary="----=_Part_24127_1311541386.1290664898119"

------=_Part_24127_1311541386.1290664898119
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,all 
I found it just support a small value for -I option. 
when I run '#./hugemmap04 -I 3600 -H /var/hugetlbfs',the test returned immediately. 
the -I option details: 
-I x Execute test for x seconds 
And if you give a much bigger value to -I option such as 3600 or larger, you will find the -I option disabled, 
so I changed the lib/parse_opts.c file, and just modified the stop_time variable type from 'int' to 'double', 
after changed, it can support a very bigger value for -I option. 
this patch is in the following : 

Signed-off-by: Zhouping Liu < zliu@redhat@redhat.com > 
--- 
lib/parse_opts.c | 6 +++--- 
1 files changed, 3 insertions(+), 3 deletions(-) 

diff --git a/lib/parse_opts.c b/lib/parse_opts.c 
index e4de709..da75df5 100644 
--- a/lib/parse_opts.c 
+++ b/lib/parse_opts.c 
@@ -699,7 +699,7 @@ usc_test_looping(counter) 
int counter; 
{ 
static int first_time = 1; 
- static int stop_time = 0; /* stop time in rtc or usecs */ 
+ static double stop_time = 0; /* stop time in rtc or usecs */ 
static int delay; /* delay in clocks or usecs */ 
int hertz=0; /* clocks per second or usecs per second */ 
int ct, end; /* current time, end delay time */ 
@@ -724,7 +724,7 @@ int counter; 

if ( STD_LOOP_DURATION) { 
ct=get_current_time(); 
- stop_time=(int)((float)hertz * STD_LOOP_DURATION) + ct; 
+ stop_time = (double)hertz * (double)STD_LOOP_DURATION + (double)ct; 
} 

/* 
@@ -769,7 +769,7 @@ int counter; 
keepgoing++; 
} 

- if ( STD_LOOP_DURATION != 0.0 && get_current_time() < stop_time ) { 
+ if ( STD_LOOP_DURATION != 0.0 && (double)get_current_time() < stop_time ) { 
keepgoing++; 
} 

-- 
1.7.2.3 


-- 
Name: Zhouping Liu 

------=_Part_24127_1311541386.1290664898119
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
>Hi,all<br>I found it just support a small value for -I option.<br>when I r=
un '#./hugemmap04 -I 3600 -H /var/hugetlbfs',the test returned immediately.=
<br>the -I option details:<br>-I x &nbsp; &nbsp;Execute test for x seconds =
<br>And if you give a much bigger value to -I option such as 3600 or larger=
, you will find the -I option disabled,<br>so I changed the lib/parse_opts.=
c file, and just modified the stop_time variable type from 'int' to 'double=
',<br>after changed, it can support a very bigger value for -I option.<br>t=
his patch is in the following : <br><br>Signed-off-by: Zhouping Liu &lt;<sp=
an class=3D"Object" id=3D"OBJ_PREFIX_DWT574"><span class=3D"Object" id=3D"O=
BJ_PREFIX_DWT575">zliu@redhat@redhat.com</span></span>&gt;<br>---<br>&nbsp;=
lib/parse_opts.c |&nbsp;&nbsp;&nbsp; 6 +++---<br>&nbsp;1 files changed, 3 i=
nsertions(+), 3 deletions(-)<br><br>diff --git a/lib/parse_opts.c b/lib/par=
se_opts.c<br>index e4de709..da75df5 100644<br>--- a/lib/parse_opts.c<br>+++=
 b/lib/parse_opts.c<br>@@ -699,7 +699,7 @@ usc_test_looping(counter)<br>&nb=
sp;int counter;<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp; static int first_tim=
e =3D 1;<br>-&nbsp;&nbsp;&nbsp; static int stop_time =3D 0;&nbsp;&nbsp;&nbs=
p; /* stop time in rtc or usecs */<br>+&nbsp;&nbsp;&nbsp; static double sto=
p_time =3D 0;&nbsp;&nbsp;&nbsp; /* stop time in rtc or usecs */<br>&nbsp;&n=
bsp;&nbsp;&nbsp; static int delay;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* =
delay in clocks or usecs&nbsp; */<br>&nbsp;&nbsp;&nbsp;&nbsp; int hertz=3D0=
;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* clocks per sec=
ond or usecs per second */<br>&nbsp;&nbsp;&nbsp;&nbsp; int ct, end;&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; /* current time, end delay time */<br>@@ -724=
,7 +724,7 @@ int counter;<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; if ( STD_LO=
OP_DURATION) {<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ct=3Dget_curr=
ent_time();<br>-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; stop_time=3D(int)((fl=
oat)hertz * STD_LOOP_DURATION) + ct;<br>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; stop_time =3D (double)hertz * (double)STD_LOOP_DURATION + (double)ct;<b=
r>&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; /*<br>@@=
 -769,7 +769,7 @@ int counter;<br>&nbsp;&nbsp;&nbsp;&nbsp; keepgoing++;<br>=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;<br>-&nbsp;&nbsp;&nbsp; if ( STD_LOOP_D=
URATION !=3D 0.0 &amp;&amp; get_current_time() &lt; stop_time ) {<br>+&nbsp=
;&nbsp;&nbsp; if ( STD_LOOP_DURATION !=3D 0.0 &amp;&amp; (double)get_curren=
t_time() &lt; stop_time ) {<br>&nbsp;&nbsp;&nbsp;&nbsp; keepgoing++;<br>&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;<br>-- <br>1.7.2.3<br><br><br>-- <br>Name:=
 Zhouping Liu<br></div></body></html>
------=_Part_24127_1311541386.1290664898119--


--===============6957674363584621261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
--===============6957674363584621261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6957674363584621261==--

