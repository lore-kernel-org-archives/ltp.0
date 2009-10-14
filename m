Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My8ci-0004F1-4Q
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:30:56 +0000
Received: from mail-px0-f180.google.com ([209.85.216.180])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My8cd-0001Fl-M0
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:30:56 +0000
Received: by pxi10 with SMTP id 10so10034pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 11:30:44 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 11:30:44 -0700
Message-ID: <364299f40910141130wfac08a7tc69a49ecea707fd5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 10] mail requires useradd to function
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

As seen below useradd is required for mail to function:

<<<test_start>>>
tag=mail stime=1255544778
cmdline="export TCdat=$LTPROOT/testcases/bin; mail_tests.sh"
contacts=""
analysis=exit
<<<test_output>>>
SETUP       0  TINFO  :  INIT: Adding temporary user mail_test
SETUP       1  TBROK  :  Test INIT: Failed adding user mail_test. Reason:
/tests/ltp/testcases/bin/mail_tests.sh: line 75: useradd: command not found
SETUP       2  TBROK  :  Remaining cases broken
SETUP       3  TBROK  :  Remaining cases broken
SETUP       4  TBROK  :  Remaining cases broken
SETUP       5  TBROK  :  Remaining cases broken
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=2 cstime=2
<<<test_end>>>

But this should // could be done by echoing to /etc/passwd //
/etc/group for systems that don't come equipped with useradd.

Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
