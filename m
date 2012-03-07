Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <a2zpavani@gmail.com>) id 1S5GGu-0003zX-PH
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 12:47:12 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1S5GGp-0001hy-8Y
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 12:47:12 +0000
Received: by yenm3 with SMTP id m3so3279668yen.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 07 Mar 2012 04:47:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F56FAA2.30302@cn.fujitsu.com>
References: <CAB_zjmWr7tSNwfMrEd_FX6BOtjLhqKCJm7F1vf6kNW5DTfWCLw@mail.gmail.com>
	<4F56FAA2.30302@cn.fujitsu.com>
Date: Wed, 7 Mar 2012 18:17:01 +0530
Message-ID: <CAB_zjmXaN37Ur7Lc=3Xk7U3kzjRGkT5ifr72gy7W3g1TSU2n2w@mail.gmail.com>
From: pavani pavani <a2zpavani@gmail.com>
Subject: Re: [LTP] cron_allow01 failure on 3.2.6 kernel
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0963834315707720348=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

--===============0963834315707720348==
Content-Type: multipart/alternative; boundary=e89a8fb205bc50817304baa68e32

--e89a8fb205bc50817304baa68e32
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 7, 2012 at 11:35 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com>wrote:

> On 03/07/2012 12:14 AM, pavani pavani wrote:
>
> > Hi All ,
> >
> >         On 3.2.6 kernel ,found the "cron_allo01" was failing .
>


Appologies , please find the correct log

NFO: Restricted to cron_allow01
LOG File: /opt/ltp/results/LTP_RUN_ON-2012_Mar_07-01h_20m_06s.log
FAILED COMMAND File:
/opt/ltp/output/LTP_RUN_ON-2012_Mar_07-01h_20m_06s.failed
Running tests.......
<<<test_start>>>
tag=cron_allow01 stime=1331063406
cmdline="cron_allow01"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
su: user ca_user1 does not exist
su: user ca_user2 does not exist
userdel: Unknown user `ca_user1'.
userdel: Unknown user `ca_user2'.
TEST: /var/spool/cron/allow should only allow those in the file to
run cron jobs.
(1) TEST THAT PERSON IN /var/spool/cron/allow IS ABLE TO RUN JOB.
backup crontab....
no crontab for ca_user1
sleeping for 130 seconds....
Cron allowed user to execute test job, TEST PASSED
restore old crontab...
(2) TEST THAT PERSON NOT IN /var/spool/cron/allow IS NOT ABLE TO RUN JOB.
backup crontab....
no crontab for ca_user2
sleeping for 130 seconds....
Cron allowed user to execute test job, TEST FAILED
restore old crontab...
no crontab for ca_user1
no crontab for ca_user2
<<<execution_status>>>
initiation_status="ok"
duration=262 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=2
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20120104



> Thanks
>
Pavani

>
> The log below seems not for cron_allow01?
>
> Thanks,
> Wanlong Gao
>
> >
> >
> > mail_tests::mail01    0  TINFO  :  Test #1: user on local machine.
> > mail_tests::mail01    1  TPASS  :  Test #1: Mail was sent to root & was
> received
> > mail_tests::mail02    0  TINFO  :  Test #2: mail user@bad-domain will
> result in failure
> > mail_tests::mail02    0  TINFO  :  Test #2: to deliver the mail. Mailer
> daemon should
> > mail_tests::mail02    0  TINFO  :  Test #2: report this failure.
> > mail_tests::mail02    2  TFAIL  :  Test #2: No new mail for root. Reason:
> > No mail for root
> > mail_tests::mail03    0  TINFO  :  Test #3: mail
> non_existent_user@localhost will fail
> > mail_tests::mail03    0  TINFO  :  Test #3: to deliver the mail. Mailer
> daemon should
> > mail_tests::mail03    0  TINFO  :  Test #3: report this failure.
> > Heirloom mailx version 12.2 01/07/07.  Type ? for help.
> > mail_tests::mail03    3  TFAIL  :  Test #3: Mailer-Daemon failed to
> report delivery failure. Reason:
> > Heirloom mailx version 12.2 01/07/07.  Type ? for help.
> > "/var/mail/root": 1 message 1 new
> >>N  1 MAILER-DAEMON@linu Wed Mar  7 01:17   72/2352  Undelivered Mail
> Returned
> > mail_tests::mail04    0  TINFO  :  Test #4: Test that mail -c user@domainwill
> > mail_tests::mail04    0  TINFO  :  Test #4: carbon copy user@domain
> > mail_tests::mail04    4  TPASS  :  Test #4: Mail was carbon copied to
> user mail_test
> > mail_tests::mail05    0  TINFO  :  Test #5: Test that mail -b user@domainwill
> > mail_tests::mail05    0  TINFO  :  Test #5: blind carbon copy user@domain
> > mail_tests::mail05    5  TPASS  :  Test #5: Mail was blind copied to
> user mail_test
> > mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary files
> from /tmp
> > mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary user
> mail_test
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=30 termination_type=exited termination_id=2 corefile=no
> > cutime=0 cstime=2
> > <<<test_end>>>
> > INFO: ltp-pan reported some tests FAIL
> > LTP Version: LTP-20120104
> >
> > suggest if anyone is facing the similar error.
> >
> > Thanks
> > Pavani
> >
> >
> >
> >
> ------------------------------------------------------------------------------
> > Keep Your Developer Skills Current with LearnDevNow!
> > The most comprehensive online learning library for Microsoft developers
> > is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> > Metro Style Apps, more. Free future releases when you subscribe now!
> > http://p.sf.net/sfu/learndevnow-d2d
> >
> >
> >
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>
>

--e89a8fb205bc50817304baa68e32
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Mar 7, 2012 at 11:35 AM, Wanlong=
 Gao <span dir=3D"ltr">&lt;<a href=3D"mailto:gaowanlong@cn.fujitsu.com">gao=
wanlong@cn.fujitsu.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<div class=3D"im">On 03/07/2012 12:14 AM, pavani pavani wrote:<br>
<br>
&gt; Hi All ,<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 On 3.2.6 kernel ,found the &quot;cron_allo01&quot; was=
 failing .<br></div></blockquote><div><br><br>Appologies , please find the =
correct log<br><br>NFO: Restricted to cron_allow01<br>LOG File: /opt/ltp/re=
sults/LTP_RUN_ON-2012_Mar_07-01h_20m_06s.log<br>
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2012_Mar_07-01h_20m_06s.fai=
led<br>Running tests.......<br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3D=
cron_allow01 stime=3D1331063406<br>cmdline=3D&quot;cron_allow01&quot;<br>co=
ntacts=3D&quot;&quot;<br>
analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>incrementing stop=
<br>su: user ca_user1 does not exist<br>su: user ca_user2 does not exist<br=
>userdel: Unknown user `ca_user1&#39;.<br>userdel: Unknown user `ca_user2&#=
39;.<br>
TEST: /var/spool/cron/allow should only allow those in the file to<br>run c=
ron jobs.<br>(1) TEST THAT PERSON IN /var/spool/cron/allow IS ABLE TO RUN J=
OB.<br>backup crontab....<br>no crontab for ca_user1<br>sleeping for 130 se=
conds....<br>
Cron allowed user to execute test job, TEST PASSED<br>restore old crontab..=
.<br>(2) TEST THAT PERSON NOT IN /var/spool/cron/allow IS NOT ABLE TO RUN J=
OB.<br>backup crontab....<br>no crontab for ca_user2<br>sleeping for 130 se=
conds....<br>
Cron allowed user to execute test job, TEST FAILED<br>restore old crontab..=
.<br>no crontab for ca_user1<br>no crontab for ca_user2<br>&lt;&lt;&lt;exec=
ution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&quot;<br>duration=
=3D262 termination_type=3Dexited termination_id=3D1 corefile=3Dno<br>
cutime=3D1 cstime=3D2<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>INFO: ltp-pan =
reported some tests FAIL<br>LTP Version: LTP-20120104<br><br>=A0<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"im">
Thanks<br></div></blockquote><div>Pavani <br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div class=3D"im">
<br>
</div>The log below seems not for cron_allow01?<br>
<br>
Thanks,<br>
Wanlong Gao<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt; mail_tests::mail01 =A0 =A00 =A0TINFO =A0: =A0Test #1: user on local ma=
chine.<br>
&gt; mail_tests::mail01 =A0 =A01 =A0TPASS =A0: =A0Test #1: Mail was sent to=
 root &amp; was received<br>
&gt; mail_tests::mail02 =A0 =A00 =A0TINFO =A0: =A0Test #2: mail user@bad-do=
main will result in failure<br>
&gt; mail_tests::mail02 =A0 =A00 =A0TINFO =A0: =A0Test #2: to deliver the m=
ail. Mailer daemon should<br>
&gt; mail_tests::mail02 =A0 =A00 =A0TINFO =A0: =A0Test #2: report this fail=
ure.<br>
&gt; mail_tests::mail02 =A0 =A02 =A0TFAIL =A0: =A0Test #2: No new mail for =
root. Reason:<br>
&gt; No mail for root<br>
&gt; mail_tests::mail03 =A0 =A00 =A0TINFO =A0: =A0Test #3: mail non_existen=
t_user@localhost will fail<br>
&gt; mail_tests::mail03 =A0 =A00 =A0TINFO =A0: =A0Test #3: to deliver the m=
ail. Mailer daemon should<br>
&gt; mail_tests::mail03 =A0 =A00 =A0TINFO =A0: =A0Test #3: report this fail=
ure.<br>
&gt; Heirloom mailx version 12.2 01/07/07. =A0Type ? for help.<br>
&gt; mail_tests::mail03 =A0 =A03 =A0TFAIL =A0: =A0Test #3: Mailer-Daemon fa=
iled to report delivery failure. Reason:<br>
&gt; Heirloom mailx version 12.2 01/07/07. =A0Type ? for help.<br>
&gt; &quot;/var/mail/root&quot;: 1 message 1 new<br>
&gt;&gt;N =A01 MAILER-DAEMON@linu Wed Mar =A07 01:17 =A0 72/2352 =A0Undeliv=
ered Mail Returned<br>
&gt; mail_tests::mail04 =A0 =A00 =A0TINFO =A0: =A0Test #4: Test that mail -=
c user@domain will<br>
&gt; mail_tests::mail04 =A0 =A00 =A0TINFO =A0: =A0Test #4: carbon copy user=
@domain<br>
&gt; mail_tests::mail04 =A0 =A04 =A0TPASS =A0: =A0Test #4: Mail was carbon =
copied to user mail_test<br>
&gt; mail_tests::mail05 =A0 =A00 =A0TINFO =A0: =A0Test #5: Test that mail -=
b user@domain will<br>
&gt; mail_tests::mail05 =A0 =A00 =A0TINFO =A0: =A0Test #5: blind carbon cop=
y user@domain<br>
&gt; mail_tests::mail05 =A0 =A05 =A0TPASS =A0: =A0Test #5: Mail was blind c=
opied to user mail_test<br>
&gt; mail_tests::cleanup =A0 =A00 =A0TINFO =A0: =A0Test CLEAN: Removing tem=
porary files from /tmp<br>
&gt; mail_tests::cleanup =A0 =A00 =A0TINFO =A0: =A0Test CLEAN: Removing tem=
porary user mail_test<br>
&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
&gt; initiation_status=3D&quot;ok&quot;<br>
&gt; duration=3D30 termination_type=3Dexited termination_id=3D2 corefile=3D=
no<br>
&gt; cutime=3D0 cstime=3D2<br>
&gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; INFO: ltp-pan reported some tests FAIL<br>
&gt; LTP Version: LTP-20120104<br>
&gt;<br>
&gt; suggest if anyone is facing the similar error.<br>
&gt;<br>
&gt; Thanks<br>
&gt; Pavani<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div>&gt; ----------------------------------------------------------=
--------------------<br>
&gt; Keep Your Developer Skills Current with LearnDevNow!<br>
&gt; The most comprehensive online learning library for Microsoft developer=
s<br>
&gt; is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC=
3,<br>
&gt; Metro Style Apps, more. Free future releases when you subscribe now!<b=
r>
&gt; <a href=3D"http://p.sf.net/sfu/learndevnow-d2d" target=3D"_blank">http=
://p.sf.net/sfu/learndevnow-d2d</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; <a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourc=
eforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br>
<br>
</blockquote></div><br>

--e89a8fb205bc50817304baa68e32--


--===============0963834315707720348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--===============0963834315707720348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0963834315707720348==--

