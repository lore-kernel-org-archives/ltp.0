Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <a2zpavani@gmail.com>) id 1S5Gg4-0002lw-PZ
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 13:13:13 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S5Gfz-0002VE-4r
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 13:13:12 +0000
Received: by obqv19 with SMTP id v19so10157051obq.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 07 Mar 2012 05:13:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F56FB1A.8090601@cn.fujitsu.com>
References: <CAB_zjmVhfAKzJLE7q0eogRtaV6UoZvkgjH20EepDtykmg+e7kw@mail.gmail.com>
	<4F56FB1A.8090601@cn.fujitsu.com>
Date: Wed, 7 Mar 2012 18:43:01 +0530
Message-ID: <CAB_zjmUL=hJMbcXfzEmtOYifkBzFG9cL-hC-1HOK5CUQyjiPTQ@mail.gmail.com>
From: pavani pavani <a2zpavani@gmail.com>
Subject: Re: [LTP] mail test failure on kernel 3.2.6
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8776509638812280895=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

--===============8776509638812280895==
Content-Type: multipart/alternative; boundary=f46d0447f2d6489d1204baa6eb93

--f46d0447f2d6489d1204baa6eb93
Content-Type: text/plain; charset=ISO-8859-1

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

Any clue why it is giving the particular kind of message ?


Thanks,
Pavani


Thanks,
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

--f46d0447f2d6489d1204baa6eb93
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div class=3D"im">
&gt; Hi All,<br>
&gt; =A0 =A0 =A0 Executed =A0the the Jan release of LTP ( 20120104 ) =A0on =
kernel 3.2.6 kernel , getting the =A0error below .<br>
&gt; .<br>
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
<br>
<br>
</div>The &quot;MAILER-DAEMON@linu&quot; here seems odd.<br></blockquote><d=
iv><br>Any clue why it is giving the particular kind of message ? <br><br><=
br>Thanks,<br>Pavani<br><br><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">

Thanks,<br>
Wanlong Gao<br>
<div class=3D"im"><br>
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
&gt; Wondering did anyone has come across this problem ?<br>
&gt;<br>
&gt; Regards,<br>
&gt; Pavani<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div>&gt; ----------------------------------------------------------------=
--------------<br>
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

--f46d0447f2d6489d1204baa6eb93--


--===============8776509638812280895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--===============8776509638812280895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8776509638812280895==--

