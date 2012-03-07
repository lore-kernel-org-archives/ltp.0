Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <a2zpavani@gmail.com>) id 1S5EMV-0002xu-AV
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 10:44:51 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S5EMQ-0008Mp-D7
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 10:44:51 +0000
Received: by obqv19 with SMTP id v19so9952840obq.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 07 Mar 2012 02:44:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <mailman.239579.1331109525.11409.ltp-list@lists.sourceforge.net>
References: <mailman.239579.1331109525.11409.ltp-list@lists.sourceforge.net>
Date: Wed, 7 Mar 2012 11:44:40 +0100
Message-ID: <CAB_zjmX1CfyG0Ged-_tHk+ZXUobxCtDWX+mrNviS8CXqJpWewA@mail.gmail.com>
From: pavani pavani <a2zpavani@gmail.com>
Subject: Re: [LTP] Ltp-list Digest, Vol 70, Issue 6
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2263829181950201705=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: nagamanimantha@huawei.com

--===============2263829181950201705==
Content-Type: multipart/alternative; boundary=e89a8fb205bcc1b1b604baa4d85d

--e89a8fb205bcc1b1b604baa4d85d
Content-Type: text/plain; charset=ISO-8859-1

Hi,
This is regarding the issue 3 : cron_allow01
Please find the correct log files attached along with the mail.

INFO: Restricted to cron_allow01
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
       ###############################################################"
            Done executing testcases."
            LTP Version:  LTP-20120104
       ###############################################################"
Kernel version is :: 3.2.6 kernel

Thanks and Regards,
Pavani

On Wed, Mar 7, 2012 at 9:38 AM, <ltp-list-request@lists.sourceforge.net>wrote:

> Send Ltp-list mailing list submissions to
>        ltp-list@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        https://lists.sourceforge.net/lists/listinfo/ltp-list
> or, via email, send a message with subject or body 'help' to
>        ltp-list-request@lists.sourceforge.net
>
> You can reach the person managing the list at
>        ltp-list-owner@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Ltp-list digest..."
>
>
> Today's Topics:
>
>   1. Re: [PATCH] runltp: Remove excess quotes from final message
>      (Wanlong Gao)
>   2. Re: [PATCH] runltp: Remove excess quotes from final message
>      (Caspar Zhang)
>   3. Re: cron_allow01 failure on 3.2.6 kernel (Wanlong Gao)
>   4. Re: mail test failure on kernel 3.2.6 (Wanlong Gao)
>   5. LTP Installation Help ..! (Vinoth Kumar S)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 07 Mar 2012 09:02:18 +0800
> From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Subject: Re: [LTP] [PATCH] runltp: Remove excess quotes from final
>        message
> To: Markos Chandras <markos.chandras@imgtec.com>
> Cc: ltp-list@lists.sourceforge.net
> Message-ID: <4F56B39A.1080709@cn.fujitsu.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> On 03/06/2012 10:45 PM, Garrett Cooper wrote:
>
> > On Tue, Mar 6, 2012 at 2:28 AM, Markos Chandras
> > <markos.chandras@imgtec.com> wrote:
> >> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> >> ---
> >>  runltp |    6 +++---
> >>  1 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/runltp b/runltp
> >> index 4ef8b38..fc3515b 100755
> >> --- a/runltp
> >> +++ b/runltp
> >> @@ -948,11 +948,11 @@ main()
> >>     {
> >>     cat <<-EOF >&1
> >>
> >> -       ###############################################################"
> >> +       ###############################################################
> >>
> >> -            Done executing testcases."
> >> +            Done executing testcases.
> >>             LTP Version:  $version_date
> >> -       ###############################################################"
> >> +       ###############################################################
> >>
> >>        EOF
> >>     }
> >
> > Reviewed-by: Garrett Cooper <yanegomi@gmail.com>
>
>
> Picked to my tree, thanks
>
> -Wanlong Gao
>
> >
> >
> ------------------------------------------------------------------------------
> > Keep Your Developer Skills Current with LearnDevNow!
> > The most comprehensive online learning library for Microsoft developers
> > is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> > Metro Style Apps, more. Free future releases when you subscribe now!
> > http://p.sf.net/sfu/learndevnow-d2d
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >
>
>
>
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 07 Mar 2012 10:51:23 +0800
> From: Caspar Zhang <caspar@casparzhang.com>
> Subject: Re: [LTP] [PATCH] runltp: Remove excess quotes from final
>        message
> To: Markos Chandras <markos.chandras@imgtec.com>
> Cc: ltp-list@lists.sourceforge.net
> Message-ID: <4F56CD2B.8060308@casparzhang.com>
> Content-Type: text/plain; charset=UTF-8
>
> On 03/06/2012 06:28 PM, Markos Chandras wrote:
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > ---
> >  runltp |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/runltp b/runltp
> > index 4ef8b38..fc3515b 100755
> > --- a/runltp
> > +++ b/runltp
> > @@ -948,11 +948,11 @@ main()
> >      {
> >      cat <<-EOF >&1
> >
> > -       ###############################################################"
> > +       ###############################################################
> >
> > -            Done executing testcases."
> > +            Done executing testcases.
> >              LTP Version:  $version_date
> > -       ###############################################################"
> > +       ###############################################################
> >
> >       EOF
> >      }
>
> Hi, Committed.
>
> Thanks,
> Caspar
>
>
>
> ------------------------------
>
> Message: 3
> Date: Wed, 07 Mar 2012 14:05:22 +0800
> From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Subject: Re: [LTP] cron_allow01 failure on 3.2.6 kernel
> To: pavani pavani <a2zpavani@gmail.com>
> Cc: ltp-list@lists.sourceforge.net
> Message-ID: <4F56FAA2.30302@cn.fujitsu.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> On 03/07/2012 12:14 AM, pavani pavani wrote:
>
> > Hi All ,
> >
> >         On 3.2.6 kernel ,found the "cron_allo01" was failing .
>
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
>
>
> ------------------------------
>
> Message: 4
> Date: Wed, 07 Mar 2012 14:07:22 +0800
> From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Subject: Re: [LTP] mail test failure on kernel 3.2.6
> To: pavani pavani <a2zpavani@gmail.com>
> Cc: ltp-list@lists.sourceforge.net
> Message-ID: <4F56FB1A.8090601@cn.fujitsu.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> On 03/06/2012 11:59 PM, pavani pavani wrote:
>
> > Hi All,
> >       Executed  the the Jan release of LTP ( 20120104 )  on kernel 3.2.6
> kernel , getting the  error below .
> > .
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
>
>
> The "MAILER-DAEMON@linu" here seems odd.
>
> Thanks,
> Wanlong Gao
>
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
> > Wondering did anyone has come across this problem ?
> >
> > Regards,
> > Pavani
> >
> >
> >
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
>
>
> ------------------------------
>
> Message: 5
> Date: Tue, 6 Mar 2012 16:23:23 +0530 (IST)
> From: Vinoth Kumar S <vinothkumar.s@jasmin-infotech.com>
> Subject: [LTP] LTP Installation Help ..!
> To: ltp-list@lists.sf.net
> Message-ID:
>        <
> 10037582.6002.1331031202959.JavaMail.root@zimbra.jasmin-infotech.com>
> Content-Type: text/plain; charset="utf-8"
>
> Dear Sir,
>
> It would be very helpful if you guide me with the installation of Linux
> test Project.
>
> I followed below steps...
>
> cd ltp-yyyymmdd
>
> ./configure --host=bfin-linux-uclibc
>
> Edited the Makefile as
> UCLINUX ?= 1
>
> make
>
> I got the below error....
>
>
> parse_opts.c:142: warning: ?STD_LP_sbrk? defined but not used
> parse_opts.c:143: warning: ?STD_start_break? defined but not used
> tlibio.c: In function ?lio_write_buffer?:
> tlibio.c:551: warning: unused variable ?listio_cmd?
> tlibio.c:550: warning: unused variable ?omethod?
> tlibio.c: In function ?lio_read_buffer?:
> tlibio.c:1100: warning: unused variable ?omethod?
> tlibio.c:1099: warning: unused variable ?listio_cmd?
> tlibio.c: At top level:
> tlibio.c:429: warning: ?lio_async_signal_handler? defined but not used
> tst_res.c: In function ?tst_brkm?:
> tst_res.c:671: warning: ?noreturn? function does return
> access03.c:109: warning: ?setup? declared ?static? but never defined
> access03.c:110: warning: ?cleanup? declared ?static? but never defined
> cacheflush01.c:74:1: warning: "__NR_cacheflush" redefined
> In file included from
> /opt/uClinux-2010R1/bfin-linux-uclibc/bin/../bfin-linux-uclibc/runtime/usr/include/sys/syscall.h:32,
> from
> /home/thangaraj/vinod/Linux_Test_Project/ltp-full-20120104/testcases/kernel/include/linux_syscall_numbers.h:17,
> from cacheflush01.c:63:
> /opt/uClinux-2010R1/bfin-linux-uclibc/bin/../bfin-linux-uclibc/runtime/usr/include/bits/sysnum.h:935:1:
> warning: this is the location of the previous definition
> clock_nanosleep01.c: In function ?do_test?:
> clock_nanosleep01.c:310: warning: implicit declaration of function
> ?clock_nanosleep?
> /tmp/cconrC48.o: In function `do_test':
> /home/thangaraj/vinod/Linux_Test_Project/ltp-full-20120104/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c:312:
> undefined reference to `_clock_nanosleep'
> collect2: ld returned 1 exit status
> make[4]: *** [clock_nanosleep01] Error 1
> make[3]: *** [all] Error 2
> make[2]: *** [all] Error 2
> make[1]: *** [all] Error 2
> make: *** [testcases-all] Error 2
>
>
> How to resolve this error... ?
>
> Thanks
>
> Regards
> Vinoth Kumar S
> Jasmin Infotech Pvt. Ltd .
> Plot 119, Velachery Tambaram Road, Pallikaranai,
> Chennai 600 100
> India
>
> -------------- next part --------------
> An HTML attachment was scrubbed...
>
> ------------------------------
>
>
> ------------------------------------------------------------------------------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
>
> ------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>
> End of Ltp-list Digest, Vol 70, Issue 6
> ***************************************
>

--e89a8fb205bcc1b1b604baa4d85d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>This is regarding the issue 3 : cron_allow01</div>
<div>Please find the correct log files attached along with the mail.</div>
<div>=A0</div>
<div>INFO: Restricted to cron_allow01 <br>LOG File: /opt/ltp/results/LTP_RU=
N_ON-2012_Mar_07-01h_20m_06s.log <br>FAILED COMMAND File: /opt/ltp/output/L=
TP_RUN_ON-2012_Mar_07-01h_20m_06s.failed <br>Running tests....... <br>
&lt;&lt;&lt;test_start&gt;&gt;&gt; <br>tag=3Dcron_allow01 stime=3D133106340=
6 <br>cmdline=3D&quot;cron_allow01&quot; <br>contacts=3D&quot;&quot; <br>an=
alysis=3Dexit <br>&lt;&lt;&lt;test_output&gt;&gt;&gt; <br>incrementing stop=
 <br>su: user ca_user1 does not exist <br>
su: user ca_user2 does not exist <br>userdel: Unknown user `ca_user1&#39;. =
<br>userdel: Unknown user `ca_user2&#39;. <br>TEST: /var/spool/cron/allow s=
hould only allow those in the file to <br>run cron jobs. <br>(1) TEST THAT =
PERSON IN /var/spool/cron/allow IS ABLE TO RUN JOB. <br>
backup crontab.... <br>no crontab for ca_user1 <br>sleeping for 130 seconds=
.... <br>Cron allowed user to execute test job, TEST PASSED <br>restore old=
 crontab... <br>(2) TEST THAT PERSON NOT IN /var/spool/cron/allow IS NOT AB=
LE TO RUN JOB. <br>
backup crontab.... <br>no crontab for ca_user2 <br>sleeping for 130 seconds=
.... <br>Cron allowed user to execute test job, TEST FAILED <br>restore old=
 crontab... <br>no crontab for ca_user1 <br>no crontab for ca_user2 <br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt; <br>initiation_status=3D&quot;ok&q=
uot; <br>duration=3D262 termination_type=3Dexited termination_id=3D1 corefi=
le=3Dno <br>cutime=3D1 cstime=3D2 <br>&lt;&lt;&lt;test_end&gt;&gt;&gt; <br>=
INFO: ltp-pan reported some tests FAIL <br>
LTP Version: LTP-20120104 </div>
<div>=A0=A0=A0=A0=A0=A0 ###################################################=
############&quot; </div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Done executing testcases.&quot; <br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 LTP Version:=A0 LTP-20120104 <br>=A0=A0=
=A0=A0=A0=A0 ##############################################################=
#&quot; </div>
<div>Kernel version is :: 3.2.6 kernel </div>
<div>=A0</div>
<div>Thanks and Regards,</div>
<div>Pavani<br><br></div>
<div class=3D"gmail_quote">On Wed, Mar 7, 2012 at 9:38 AM, <span dir=3D"ltr=
">&lt;<a href=3D"mailto:ltp-list-request@lists.sourceforge.net">ltp-list-re=
quest@lists.sourceforge.net</a>&gt;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT:#ccc 1px solid;MARGIN:0px 0px 0px 0.8ex;PA=
DDING-LEFT:1ex" class=3D"gmail_quote">Send Ltp-list mailing list submission=
s to<br>=A0 =A0 =A0 =A0<a href=3D"mailto:ltp-list@lists.sourceforge.net">lt=
p-list@lists.sourceforge.net</a><br>
<br>To subscribe or unsubscribe via the World Wide Web, visit<br>=A0 =A0 =
=A0 =A0<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" ta=
rget=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><b=
r>or, via email, send a message with subject or body &#39;help&#39; to<br>
=A0 =A0 =A0 =A0<a href=3D"mailto:ltp-list-request@lists.sourceforge.net">lt=
p-list-request@lists.sourceforge.net</a><br><br>You can reach the person ma=
naging the list at<br>=A0 =A0 =A0 =A0<a href=3D"mailto:ltp-list-owner@lists=
.sourceforge.net">ltp-list-owner@lists.sourceforge.net</a><br>
<br>When replying, please edit your Subject line so it is more specific<br>=
than &quot;Re: Contents of Ltp-list digest...&quot;<br><br><br>Today&#39;s =
Topics:<br><br>=A0 1. Re: [PATCH] runltp: Remove excess quotes from final m=
essage<br>
=A0 =A0 =A0(Wanlong Gao)<br>=A0 2. Re: [PATCH] runltp: Remove excess quotes=
 from final message<br>=A0 =A0 =A0(Caspar Zhang)<br>=A0 3. Re: cron_allow01=
 failure on 3.2.6 kernel (Wanlong Gao)<br>=A0 4. Re: mail test failure on k=
ernel 3.2.6 (Wanlong Gao)<br>
=A0 5. LTP Installation Help ..! (Vinoth Kumar S)<br><br><br>--------------=
--------------------------------------------------------<br><br>Message: 1<=
br>Date: Wed, 07 Mar 2012 09:02:18 +0800<br>From: Wanlong Gao &lt;<a href=
=3D"mailto:gaowanlong@cn.fujitsu.com">gaowanlong@cn.fujitsu.com</a>&gt;<br>
Subject: Re: [LTP] [PATCH] runltp: Remove excess quotes from final<br>=A0 =
=A0 =A0 =A0message<br>To: Markos Chandras &lt;<a href=3D"mailto:markos.chan=
dras@imgtec.com">markos.chandras@imgtec.com</a>&gt;<br>Cc: <a href=3D"mailt=
o:ltp-list@lists.sourceforge.net">ltp-list@lists.sourceforge.net</a><br>
Message-ID: &lt;<a href=3D"mailto:4F56B39A.1080709@cn.fujitsu.com">4F56B39A=
.1080709@cn.fujitsu.com</a>&gt;<br>Content-Type: text/plain; charset=3DISO-=
8859-1<br><br>On 03/06/2012 10:45 PM, Garrett Cooper wrote:<br><br>&gt; On =
Tue, Mar 6, 2012 at 2:28 AM, Markos Chandras<br>
&gt; &lt;<a href=3D"mailto:markos.chandras@imgtec.com">markos.chandras@imgt=
ec.com</a>&gt; wrote:<br>&gt;&gt; Signed-off-by: Markos Chandras &lt;<a hre=
f=3D"mailto:markos.chandras@imgtec.com">markos.chandras@imgtec.com</a>&gt;<=
br>
&gt;&gt; ---<br>&gt;&gt; =A0runltp | =A0 =A06 +++---<br>&gt;&gt; =A01 files=
 changed, 3 insertions(+), 3 deletions(-)<br>&gt;&gt;<br>&gt;&gt; diff --gi=
t a/runltp b/runltp<br>&gt;&gt; index 4ef8b38..fc3515b 100755<br>&gt;&gt; -=
-- a/runltp<br>
&gt;&gt; +++ b/runltp<br>&gt;&gt; @@ -948,11 +948,11 @@ main()<br>&gt;&gt; =
=A0 =A0 {<br>&gt;&gt; =A0 =A0 cat &lt;&lt;-EOF &gt;&amp;1<br>&gt;&gt;<br>&g=
t;&gt; - =A0 =A0 =A0 ######################################################=
#########&quot;<br>
&gt;&gt; + =A0 =A0 =A0 ####################################################=
###########<br>&gt;&gt;<br>&gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0Done executing=
 testcases.&quot;<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0Done executing testc=
ases.<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 LTP Version: =A0$version_date<br>
&gt;&gt; - =A0 =A0 =A0 ####################################################=
###########&quot;<br>&gt;&gt; + =A0 =A0 =A0 ###############################=
################################<br>&gt;&gt;<br>&gt;&gt; =A0 =A0 =A0 =A0EOF=
<br>&gt;&gt; =A0 =A0 }<br>
&gt;<br>&gt; Reviewed-by: Garrett Cooper &lt;<a href=3D"mailto:yanegomi@gma=
il.com">yanegomi@gmail.com</a>&gt;<br><br><br>Picked to my tree, thanks<br>=
<br>-Wanlong Gao<br><br>&gt;<br>&gt; --------------------------------------=
----------------------------------------<br>
&gt; Keep Your Developer Skills Current with LearnDevNow!<br>&gt; The most =
comprehensive online learning library for Microsoft developers<br>&gt; is j=
ust $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,<br>
&gt; Metro Style Apps, more. Free future releases when you subscribe now!<b=
r>&gt; <a href=3D"http://p.sf.net/sfu/learndevnow-d2d" target=3D"_blank">ht=
tp://p.sf.net/sfu/learndevnow-d2d</a><br>&gt; _____________________________=
__________________<br>
&gt; Ltp-list mailing list<br>&gt; <a href=3D"mailto:Ltp-list@lists.sourcef=
orge.net">Ltp-list@lists.sourceforge.net</a><br>&gt; <a href=3D"https://lis=
ts.sourceforge.net/lists/listinfo/ltp-list" target=3D"_blank">https://lists=
.sourceforge.net/lists/listinfo/ltp-list</a><br>
&gt;<br><br><br><br><br><br>------------------------------<br><br>Message: =
2<br>Date: Wed, 07 Mar 2012 10:51:23 +0800<br>From: Caspar Zhang &lt;<a hre=
f=3D"mailto:caspar@casparzhang.com">caspar@casparzhang.com</a>&gt;<br>Subje=
ct: Re: [LTP] [PATCH] runltp: Remove excess quotes from final<br>
=A0 =A0 =A0 =A0message<br>To: Markos Chandras &lt;<a href=3D"mailto:markos.=
chandras@imgtec.com">markos.chandras@imgtec.com</a>&gt;<br>Cc: <a href=3D"m=
ailto:ltp-list@lists.sourceforge.net">ltp-list@lists.sourceforge.net</a><br=
>Message-ID: &lt;<a href=3D"mailto:4F56CD2B.8060308@casparzhang.com">4F56CD=
2B.8060308@casparzhang.com</a>&gt;<br>
Content-Type: text/plain; charset=3DUTF-8<br><br>On 03/06/2012 06:28 PM, Ma=
rkos Chandras wrote:<br>&gt; Signed-off-by: Markos Chandras &lt;<a href=3D"=
mailto:markos.chandras@imgtec.com">markos.chandras@imgtec.com</a>&gt;<br>&g=
t; ---<br>
&gt; =A0runltp | =A0 =A06 +++---<br>&gt; =A01 files changed, 3 insertions(+=
), 3 deletions(-)<br>&gt;<br>&gt; diff --git a/runltp b/runltp<br>&gt; inde=
x 4ef8b38..fc3515b 100755<br>&gt; --- a/runltp<br>&gt; +++ b/runltp<br>&gt;=
 @@ -948,11 +948,11 @@ main()<br>
&gt; =A0 =A0 =A0{<br>&gt; =A0 =A0 =A0cat &lt;&lt;-EOF &gt;&amp;1<br>&gt;<br=
>&gt; - =A0 =A0 =A0 #######################################################=
########&quot;<br>&gt; + =A0 =A0 =A0 ######################################=
#########################<br>
&gt;<br>&gt; - =A0 =A0 =A0 =A0 =A0 =A0Done executing testcases.&quot;<br>&g=
t; + =A0 =A0 =A0 =A0 =A0 =A0Done executing testcases.<br>&gt; =A0 =A0 =A0 =
=A0 =A0 =A0 =A0LTP Version: =A0$version_date<br>&gt; - =A0 =A0 =A0 ########=
#######################################################&quot;<br>
&gt; + =A0 =A0 =A0 ########################################################=
#######<br>&gt;<br>&gt; =A0 =A0 =A0 EOF<br>&gt; =A0 =A0 =A0}<br><br>Hi, Com=
mitted.<br><br>Thanks,<br>Caspar<br><br><br><br>---------------------------=
---<br><br>Message: 3<br>
Date: Wed, 07 Mar 2012 14:05:22 +0800<br>From: Wanlong Gao &lt;<a href=3D"m=
ailto:gaowanlong@cn.fujitsu.com">gaowanlong@cn.fujitsu.com</a>&gt;<br>Subje=
ct: Re: [LTP] cron_allow01 failure on 3.2.6 kernel<br>To: pavani pavani &lt=
;<a href=3D"mailto:a2zpavani@gmail.com">a2zpavani@gmail.com</a>&gt;<br>
Cc: <a href=3D"mailto:ltp-list@lists.sourceforge.net">ltp-list@lists.source=
forge.net</a><br>Message-ID: &lt;<a href=3D"mailto:4F56FAA2.30302@cn.fujits=
u.com">4F56FAA2.30302@cn.fujitsu.com</a>&gt;<br>Content-Type: text/plain; c=
harset=3DISO-8859-1<br>
<br>On 03/07/2012 12:14 AM, pavani pavani wrote:<br><br>&gt; Hi All ,<br>&g=
t;<br>&gt; =A0 =A0 =A0 =A0 On 3.2.6 kernel ,found the &quot;cron_allo01&quo=
t; was failing .<br><br><br>The log below seems not for cron_allow01?<br><b=
r>Thanks,<br>
Wanlong Gao<br><br>&gt;<br>&gt;<br>&gt; mail_tests::mail01 =A0 =A00 =A0TINF=
O =A0: =A0Test #1: user on local machine.<br>&gt; mail_tests::mail01 =A0 =
=A01 =A0TPASS =A0: =A0Test #1: Mail was sent to root &amp; was received<br>=
&gt; mail_tests::mail02 =A0 =A00 =A0TINFO =A0: =A0Test #2: mail user@bad-do=
main will result in failure<br>
&gt; mail_tests::mail02 =A0 =A00 =A0TINFO =A0: =A0Test #2: to deliver the m=
ail. Mailer daemon should<br>&gt; mail_tests::mail02 =A0 =A00 =A0TINFO =A0:=
 =A0Test #2: report this failure.<br>&gt; mail_tests::mail02 =A0 =A02 =A0TF=
AIL =A0: =A0Test #2: No new mail for root. Reason:<br>
&gt; No mail for root<br>&gt; mail_tests::mail03 =A0 =A00 =A0TINFO =A0: =A0=
Test #3: mail non_existent_user@localhost will fail<br>&gt; mail_tests::mai=
l03 =A0 =A00 =A0TINFO =A0: =A0Test #3: to deliver the mail. Mailer daemon s=
hould<br>&gt; mail_tests::mail03 =A0 =A00 =A0TINFO =A0: =A0Test #3: report =
this failure.<br>
&gt; Heirloom mailx version 12.2 01/07/07. =A0Type ? for help.<br>&gt; mail=
_tests::mail03 =A0 =A03 =A0TFAIL =A0: =A0Test #3: Mailer-Daemon failed to r=
eport delivery failure. Reason:<br>&gt; Heirloom mailx version 12.2 01/07/0=
7. =A0Type ? for help.<br>
&gt; &quot;/var/mail/root&quot;: 1 message 1 new<br>&gt;&gt;N =A01 MAILER-D=
AEMON@linu Wed Mar =A07 01:17 =A0 72/2352 =A0Undelivered Mail Returned<br>&=
gt; mail_tests::mail04 =A0 =A00 =A0TINFO =A0: =A0Test #4: Test that mail -c=
 user@domain will<br>
&gt; mail_tests::mail04 =A0 =A00 =A0TINFO =A0: =A0Test #4: carbon copy user=
@domain<br>&gt; mail_tests::mail04 =A0 =A04 =A0TPASS =A0: =A0Test #4: Mail =
was carbon copied to user mail_test<br>&gt; mail_tests::mail05 =A0 =A00 =A0=
TINFO =A0: =A0Test #5: Test that mail -b user@domain will<br>
&gt; mail_tests::mail05 =A0 =A00 =A0TINFO =A0: =A0Test #5: blind carbon cop=
y user@domain<br>&gt; mail_tests::mail05 =A0 =A05 =A0TPASS =A0: =A0Test #5:=
 Mail was blind copied to user mail_test<br>&gt; mail_tests::cleanup =A0 =
=A00 =A0TINFO =A0: =A0Test CLEAN: Removing temporary files from /tmp<br>
&gt; mail_tests::cleanup =A0 =A00 =A0TINFO =A0: =A0Test CLEAN: Removing tem=
porary user mail_test<br>&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&=
gt; initiation_status=3D&quot;ok&quot;<br>&gt; duration=3D30 termination_ty=
pe=3Dexited termination_id=3D2 corefile=3Dno<br>
&gt; cutime=3D0 cstime=3D2<br>&gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&gt;=
 INFO: ltp-pan reported some tests FAIL<br>&gt; LTP Version: LTP-20120104<b=
r>&gt;<br>&gt; suggest if anyone is facing the similar error.<br>&gt;<br>&g=
t; Thanks<br>
&gt; Pavani<br>&gt;<br>&gt;<br>&gt;<br>&gt; -------------------------------=
-----------------------------------------------<br>&gt; Keep Your Developer=
 Skills Current with LearnDevNow!<br>&gt; The most comprehensive online lea=
rning library for Microsoft developers<br>
&gt; is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC=
3,<br>&gt; Metro Style Apps, more. Free future releases when you subscribe =
now!<br>&gt; <a href=3D"http://p.sf.net/sfu/learndevnow-d2d" target=3D"_bla=
nk">http://p.sf.net/sfu/learndevnow-d2d</a><br>
&gt;<br>&gt;<br>&gt;<br>&gt; ______________________________________________=
_<br>&gt; Ltp-list mailing list<br>&gt; <a href=3D"mailto:Ltp-list@lists.so=
urceforge.net">Ltp-list@lists.sourceforge.net</a><br>&gt; <a href=3D"https:=
//lists.sourceforge.net/lists/listinfo/ltp-list" target=3D"_blank">https://=
lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br><br><br><br><br>------------------------------<br><br>Message: 4<br>Dat=
e: Wed, 07 Mar 2012 14:07:22 +0800<br>From: Wanlong Gao &lt;<a href=3D"mail=
to:gaowanlong@cn.fujitsu.com">gaowanlong@cn.fujitsu.com</a>&gt;<br>Subject:=
 Re: [LTP] mail test failure on kernel 3.2.6<br>
To: pavani pavani &lt;<a href=3D"mailto:a2zpavani@gmail.com">a2zpavani@gmai=
l.com</a>&gt;<br>Cc: <a href=3D"mailto:ltp-list@lists.sourceforge.net">ltp-=
list@lists.sourceforge.net</a><br>Message-ID: &lt;<a href=3D"mailto:4F56FB1=
A.8090601@cn.fujitsu.com">4F56FB1A.8090601@cn.fujitsu.com</a>&gt;<br>
Content-Type: text/plain; charset=3DISO-8859-1<br><br>On 03/06/2012 11:59 P=
M, pavani pavani wrote:<br><br>&gt; Hi All,<br>&gt; =A0 =A0 =A0 Executed =
=A0the the Jan release of LTP ( 20120104 ) =A0on kernel 3.2.6 kernel , gett=
ing the =A0error below .<br>
&gt; .<br>&gt; mail_tests::mail01 =A0 =A00 =A0TINFO =A0: =A0Test #1: user o=
n local machine.<br>&gt; mail_tests::mail01 =A0 =A01 =A0TPASS =A0: =A0Test =
#1: Mail was sent to root &amp; was received<br>&gt; mail_tests::mail02 =A0=
 =A00 =A0TINFO =A0: =A0Test #2: mail user@bad-domain will result in failure=
<br>
&gt; mail_tests::mail02 =A0 =A00 =A0TINFO =A0: =A0Test #2: to deliver the m=
ail. Mailer daemon should<br>&gt; mail_tests::mail02 =A0 =A00 =A0TINFO =A0:=
 =A0Test #2: report this failure.<br>&gt; mail_tests::mail02 =A0 =A02 =A0TF=
AIL =A0: =A0Test #2: No new mail for root. Reason:<br>
&gt; No mail for root<br>&gt; mail_tests::mail03 =A0 =A00 =A0TINFO =A0: =A0=
Test #3: mail non_existent_user@localhost will fail<br>&gt; mail_tests::mai=
l03 =A0 =A00 =A0TINFO =A0: =A0Test #3: to deliver the mail. Mailer daemon s=
hould<br>&gt; mail_tests::mail03 =A0 =A00 =A0TINFO =A0: =A0Test #3: report =
this failure.<br>
&gt; Heirloom mailx version 12.2 01/07/07. =A0Type ? for help.<br>&gt; mail=
_tests::mail03 =A0 =A03 =A0TFAIL =A0: =A0Test #3: Mailer-Daemon failed to r=
eport delivery failure. Reason:<br>&gt; Heirloom mailx version 12.2 01/07/0=
7. =A0Type ? for help.<br>
&gt; &quot;/var/mail/root&quot;: 1 message 1 new<br>&gt;&gt;N =A01 MAILER-D=
AEMON@linu Wed Mar =A07 01:17 =A0 72/2352 =A0Undelivered Mail Returned<br><=
br><br>The &quot;MAILER-DAEMON@linu&quot; here seems odd.<br><br>Thanks,<br=
>Wanlong Gao<br>
<br>&gt; mail_tests::mail04 =A0 =A00 =A0TINFO =A0: =A0Test #4: Test that ma=
il -c user@domain will<br>&gt; mail_tests::mail04 =A0 =A00 =A0TINFO =A0: =
=A0Test #4: carbon copy user@domain<br>&gt; mail_tests::mail04 =A0 =A04 =A0=
TPASS =A0: =A0Test #4: Mail was carbon copied to user mail_test<br>
&gt; mail_tests::mail05 =A0 =A00 =A0TINFO =A0: =A0Test #5: Test that mail -=
b user@domain will<br>&gt; mail_tests::mail05 =A0 =A00 =A0TINFO =A0: =A0Tes=
t #5: blind carbon copy user@domain<br>&gt; mail_tests::mail05 =A0 =A05 =A0=
TPASS =A0: =A0Test #5: Mail was blind copied to user mail_test<br>
&gt; mail_tests::cleanup =A0 =A00 =A0TINFO =A0: =A0Test CLEAN: Removing tem=
porary files from /tmp<br>&gt; mail_tests::cleanup =A0 =A00 =A0TINFO =A0: =
=A0Test CLEAN: Removing temporary user mail_test<br>&gt; &lt;&lt;&lt;execut=
ion_status&gt;&gt;&gt;<br>
&gt; initiation_status=3D&quot;ok&quot;<br>&gt; duration=3D30 termination_t=
ype=3Dexited termination_id=3D2 corefile=3Dno<br>&gt; cutime=3D0 cstime=3D2=
<br>&gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&gt; INFO: ltp-pan reported so=
me tests FAIL<br>
&gt; LTP Version: LTP-20120104<br>&gt;<br>&gt; Wondering did anyone has com=
e across this problem ?<br>&gt;<br>&gt; Regards,<br>&gt; Pavani<br>&gt;<br>=
&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; ------------------------------=
------------------------------------------------<br>
&gt; Keep Your Developer Skills Current with LearnDevNow!<br>&gt; The most =
comprehensive online learning library for Microsoft developers<br>&gt; is j=
ust $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,<br>
&gt; Metro Style Apps, more. Free future releases when you subscribe now!<b=
r>&gt; <a href=3D"http://p.sf.net/sfu/learndevnow-d2d" target=3D"_blank">ht=
tp://p.sf.net/sfu/learndevnow-d2d</a><br>&gt;<br>&gt;<br>&gt;<br>&gt; _____=
__________________________________________<br>
&gt; Ltp-list mailing list<br>&gt; <a href=3D"mailto:Ltp-list@lists.sourcef=
orge.net">Ltp-list@lists.sourceforge.net</a><br>&gt; <a href=3D"https://lis=
ts.sourceforge.net/lists/listinfo/ltp-list" target=3D"_blank">https://lists=
.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br><br><br><br><br>------------------------------<br><br>Message: 5<br>Dat=
e: Tue, 6 Mar 2012 16:23:23 +0530 (IST)<br>From: Vinoth Kumar S &lt;<a href=
=3D"mailto:vinothkumar.s@jasmin-infotech.com">vinothkumar.s@jasmin-infotech=
.com</a>&gt;<br>
Subject: [LTP] LTP Installation Help ..!<br>To: <a href=3D"mailto:ltp-list@=
lists.sf.net">ltp-list@lists.sf.net</a><br>Message-ID:<br>=A0 =A0 =A0 =A0&l=
t;<a href=3D"mailto:10037582.6002.1331031202959.JavaMail.root@zimbra.jasmin=
-infotech.com">10037582.6002.1331031202959.JavaMail.root@zimbra.jasmin-info=
tech.com</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br><br>Dear Sir,<br><=
br>It would be very helpful if you guide me with the installation of Linux =
test Project.<br><br>I followed below steps...<br><br>cd ltp-yyyymmdd<br>
<br>./configure --host=3Dbfin-linux-uclibc<br><br>Edited the Makefile as<br=
>UCLINUX ?=3D 1<br><br>make<br><br>I got the below error....<br><br><br>par=
se_opts.c:142: warning: ?STD_LP_sbrk? defined but not used<br>parse_opts.c:=
143: warning: ?STD_start_break? defined but not used<br>
tlibio.c: In function ?lio_write_buffer?:<br>tlibio.c:551: warning: unused =
variable ?listio_cmd?<br>tlibio.c:550: warning: unused variable ?omethod?<b=
r>tlibio.c: In function ?lio_read_buffer?:<br>tlibio.c:1100: warning: unuse=
d variable ?omethod?<br>
tlibio.c:1099: warning: unused variable ?listio_cmd?<br>tlibio.c: At top le=
vel:<br>tlibio.c:429: warning: ?lio_async_signal_handler? defined but not u=
sed<br>tst_res.c: In function ?tst_brkm?:<br>tst_res.c:671: warning: ?noret=
urn? function does return<br>
access03.c:109: warning: ?setup? declared ?static? but never defined<br>acc=
ess03.c:110: warning: ?cleanup? declared ?static? but never defined<br>cach=
eflush01.c:74:1: warning: &quot;__NR_cacheflush&quot; redefined<br>In file =
included from /opt/uClinux-2010R1/bfin-linux-uclibc/bin/../bfin-linux-uclib=
c/runtime/usr/include/sys/syscall.h:32,<br>
from /home/thangaraj/vinod/Linux_Test_Project/ltp-full-20120104/testcases/k=
ernel/include/linux_syscall_numbers.h:17,<br>from cacheflush01.c:63:<br>/op=
t/uClinux-2010R1/bfin-linux-uclibc/bin/../bfin-linux-uclibc/runtime/usr/inc=
lude/bits/sysnum.h:935:1: warning: this is the location of the previous def=
inition<br>
clock_nanosleep01.c: In function ?do_test?:<br>clock_nanosleep01.c:310: war=
ning: implicit declaration of function ?clock_nanosleep?<br>/tmp/cconrC48.o=
: In function `do_test&#39;:<br>/home/thangaraj/vinod/Linux_Test_Project/lt=
p-full-20120104/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01=
.c:312: undefined reference to `_clock_nanosleep&#39;<br>
collect2: ld returned 1 exit status<br>make[4]: *** [clock_nanosleep01] Err=
or 1<br>make[3]: *** [all] Error 2<br>make[2]: *** [all] Error 2<br>make[1]=
: *** [all] Error 2<br>make: *** [testcases-all] Error 2<br><br><br>How to =
resolve this error... ?<br>
<br>Thanks<br><br>Regards<br>Vinoth Kumar S<br>Jasmin Infotech Pvt. Ltd .<b=
r>Plot 119, Velachery Tambaram Road, Pallikaranai,<br>Chennai 600 100<br>In=
dia<br><br>-------------- next part --------------<br>An HTML attachment wa=
s scrubbed...<br>
<br>------------------------------<br><br>---------------------------------=
---------------------------------------------<br>Virtualization &amp; Cloud=
 Management Using Capacity Planning<br>Cloud computing makes use of virtual=
ization - but cloud computing<br>
also focuses on allowing computing to be delivered as a service.<br><a href=
=3D"http://www.accelacomm.com/jaw/sfnl/114/51521223/" target=3D"_blank">htt=
p://www.accelacomm.com/jaw/sfnl/114/51521223/</a><br><br>------------------=
------------<br>
<br>_______________________________________________<br>Ltp-list mailing lis=
t<br><a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourc=
eforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/l=
tp-list" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp=
-list</a><br>
<br><br>End of Ltp-list Digest, Vol 70, Issue 6<br>************************=
***************<br></blockquote></div><br>

--e89a8fb205bcc1b1b604baa4d85d--


--===============2263829181950201705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--===============2263829181950201705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2263829181950201705==--

