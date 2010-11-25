Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PLUwE-0000hH-8U
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 06:04:10 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLUwC-0005AS-T3
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 06:04:10 +0000
Date: Thu, 25 Nov 2010 01:04:02 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <504858358.438631290665042835.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1303921694.438401290664898120.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] extend the '-I' options
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4587714254264159948=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4587714254264159948==
Content-Type: multipart/alternative; 
	boundary="----=_Part_24142_241904647.1290665042834"

------=_Part_24142_241904647.1290665042834
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


----- "Zhouping Liu" <zliu@redhat.com> wrote: 
> From: "Zhouping Liu" <zliu@redhat.com> 
> To: ltp-list@lists.sourceforge.net 
> Cc: caiqian@redhat.com, czhang@redhat.com 
> Sent: Thursday, November 25, 2010 2:01:38 PM GMT +08:00 Beijing / Chongqing / Hong Kong / Urumqi 
> Subject: [LTP] [PATCH] extend the '-I' options 
> 
> 
> Hi,all 
> I found it just support a small value for -I option. 
> when I run '#./hugemmap04 -I 3600 -H /var/hugetlbfs',the test returned immediately. 
> the -I option details: 
> -I x Execute test for x seconds 
> And if you give a much bigger value to -I option such as 3600 or larger, you will find the -I option disabled, 
> so I changed the lib/parse_opts.c file, and just modified the stop_time variable type from 'int' to 'double', 
> after changed, it can support a very bigger value for -I option. 
> this patch is in the following : 
> 
> Signed-off-by: Zhouping Liu < zliu@redhat@redhat.com > 
sorry,I wrote my email error, change it: 
Signed-off-by: Zhouping Liu < zliu@redhat.com > 
> --- 
> lib/parse_opts.c | 6 +++--- 
> 1 files changed, 3 insertions(+), 3 deletions(-) 
> 
> diff --git a/lib/parse_opts.c b/lib/parse_opts.c 
> index e4de709..da75df5 100644 
> --- a/lib/parse_opts.c 
> +++ b/lib/parse_opts.c 
> @@ -699,7 +699,7 @@ usc_test_looping(counter) 
> int counter; 
> { 
> static int first_time = 1; 
> - static int stop_time = 0; /* stop time in rtc or usecs */ 
> + static double stop_time = 0; /* stop time in rtc or usecs */ 
> static int delay; /* delay in clocks or usecs */ 
> int hertz=0; /* clocks per second or usecs per second */ 
> int ct, end; /* current time, end delay time */ 
> @@ -724,7 +724,7 @@ int counter; 
> 
> if ( STD_LOOP_DURATION) { 
> ct=get_current_time(); 
> - stop_time=(int)((float)hertz * STD_LOOP_DURATION) + ct; 
> + stop_time = (double)hertz * (double)STD_LOOP_DURATION + (double)ct; 
> } 
> 
> /* 
> @@ -769,7 +769,7 @@ int counter; 
> keepgoing++; 
> } 
> 
> - if ( STD_LOOP_DURATION != 0.0 && get_current_time() < stop_time ) { 
> + if ( STD_LOOP_DURATION != 0.0 && (double)get_current_time() < stop_time ) { 
> keepgoing++; 
> } 
> 
> -- 
> 1.7.2.3 
> 
> 
> -- 
> Name: Zhouping Liu 
> 

-- 
Name: Zhouping Liu 
Team: Kernel-QE 
Timezone: GMT+0800 (Asia/Shanghai) 
IRC: zliu @ #kernel-qe, #eng-china 
Cellphone: +86-187-0166-8285 

------=_Part_24142_241904647.1290665042834
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
><br>----- "Zhouping Liu" &lt;zliu@redhat.com&gt; wrote:
<br>&gt; From: "Zhouping Liu" &lt;zliu@redhat.com&gt;<br>&gt; To: ltp-list@=
lists.sourceforge.net<br>&gt; Cc: caiqian@redhat.com, czhang@redhat.com<br>=
&gt; Sent: Thursday, November 25, 2010 2:01:38 PM GMT +08:00 Beijing / Chon=
gqing / Hong Kong / Urumqi<br>&gt; Subject: [LTP] [PATCH] extend the '-I' o=
ptions<br>&gt;<br>&gt; <style>p { margin: 0; }</style><div style=3D"font-fa=
mily: Times New Roman; font-size: 12pt; color: rgb(0, 0, 0);">&gt; Hi,all<b=
r>&gt; I found it just support a small value for -I option.<br>&gt; when I =
run '#./hugemmap04 -I 3600 -H /var/hugetlbfs',the test returned immediately=
.<br>&gt; the -I option details:<br>&gt; -I x &nbsp; &nbsp;Execute test for=
 x seconds <br>&gt; And if you give a much bigger value to -I option such a=
s 3600 or larger, you will find the -I option disabled,<br>&gt; so I change=
d the lib/parse_opts.c file, and just modified the stop_time variable type =
from 'int' to 'double',<br>&gt; after changed, it can support a very bigger=
 value for -I option.<br>&gt; this patch is in the following : <br>&gt; <br=
>&gt; Signed-off-by: Zhouping Liu &lt;<span class=3D"Object" id=3D"OBJ_PREF=
IX_DWT574"><span class=3D"Object" id=3D"OBJ_PREFIX_DWT575">zliu@redhat@redh=
at.com</span></span>&gt;<br>sorry,I wrote my email error, change it:<br>Sig=
ned-off-by: Zhouping Liu &lt;<span class=3D"Object" id=3D"OBJ_PREFIX_DWT574=
"><span class=3D"Object" id=3D"OBJ_PREFIX_DWT575">zliu@redhat.com</span></s=
pan>&gt;<br>&gt; ---<br>&gt; &nbsp;lib/parse_opts.c |&nbsp;&nbsp;&nbsp; 6 +=
++---<br>&gt; &nbsp;1 files changed, 3 insertions(+), 3 deletions(-)<br>&gt=
; <br>&gt; diff --git a/lib/parse_opts.c b/lib/parse_opts.c<br>&gt; index e=
4de709..da75df5 100644<br>&gt; --- a/lib/parse_opts.c<br>&gt; +++ b/lib/par=
se_opts.c<br>&gt; @@ -699,7 +699,7 @@ usc_test_looping(counter)<br>&gt; &nb=
sp;int counter;<br>&gt; &nbsp;{<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp; static int=
 first_time =3D 1;<br>&gt; -&nbsp;&nbsp;&nbsp; static int stop_time =3D 0;&=
nbsp;&nbsp;&nbsp; /* stop time in rtc or usecs */<br>&gt; +&nbsp;&nbsp;&nbs=
p; static double stop_time =3D 0;&nbsp;&nbsp;&nbsp; /* stop time in rtc or =
usecs */<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp; static int delay;&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; /* delay in clocks or usecs&nbsp; */<br>&gt; &nbsp;&n=
bsp;&nbsp;&nbsp; int hertz=3D0;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; /* clocks per second or usecs per second */<br>&gt; &nbsp;&nbs=
p;&nbsp;&nbsp; int ct, end;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* current=
 time, end delay time */<br>&gt; @@ -724,7 +724,7 @@ int counter;<br>&gt; &=
nbsp;<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp; if ( STD_LOOP_DURATION) {<br>&gt; &n=
bsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ct=3Dget_current_time();<br>&gt; =
-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; stop_time=3D(int)((float)hertz * STD=
_LOOP_DURATION) + ct;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; stop_t=
ime =3D (double)hertz * (double)STD_LOOP_DURATION + (double)ct;<br>&gt; &nb=
sp;&nbsp;&nbsp;&nbsp; }<br>&gt; &nbsp;<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp; /*<=
br>&gt; @@ -769,7 +769,7 @@ int counter;<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp; k=
eepgoing++;<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt; &nbsp;<br>&gt; -&nbs=
p;&nbsp;&nbsp; if ( STD_LOOP_DURATION !=3D 0.0 &amp;&amp; get_current_time(=
) &lt; stop_time ) {<br>&gt; +&nbsp;&nbsp;&nbsp; if ( STD_LOOP_DURATION !=
=3D 0.0 &amp;&amp; (double)get_current_time() &lt; stop_time ) {<br>&gt; &n=
bsp;&nbsp;&nbsp;&nbsp; keepgoing++;<br>&gt; &nbsp;&nbsp;&nbsp;&nbsp; }<br>&=
gt; &nbsp;<br>&gt; -- <br>&gt; 1.7.2.3<br>&gt; <br>&gt; <br>&gt; -- <br>&gt=
; Name: Zhouping Liu<br>&gt; </div><br><br>-- <br>Name: Zhouping Liu<br>Tea=
m: Kernel-QE<br>Timezone: GMT+0800 (Asia/Shanghai)<br>IRC: zliu @ #kernel-q=
e, #eng-china<br>Cellphone: +86-187-0166-8285<br></div></body></html>
------=_Part_24142_241904647.1290665042834--


--===============4587714254264159948==
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
--===============4587714254264159948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4587714254264159948==--

