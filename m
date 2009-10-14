Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My8ar-0001tH-Iu
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:29:01 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My8aq-0000qr-N2
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:29:01 +0000
Received: by pzk26 with SMTP id 26so53307pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 11:28:55 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 11:28:54 -0700
Message-ID: <364299f40910141128p46c8b574n4c39bf4fe65fa9ec@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 9] cron* needs to check for crontab before executing
	testcases
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

crontab is required for cron01 and cron02, and should be checked at
the start of the test, but isn't:

<<<test_start>>>
tag=cron stime=1255544619
cmdline="export TCdat=$LTPROOT/testcases/bin; cron_tests.sh"
contacts=""
analysis=exit
<<<test_output>>>
cron01      0  TINFO  :  Test #1: crontab <filename> installs the crontab file
cron01      0  TINFO  :  Test #1: cron schedules the job listed in crontab file.
cron01      0  TINFO  :  Test #1: Installing cron job ...
cron01      1  TBROK  :  Test #1: crontab Broke while installing
cronjob. Reason:
/tests/ltp/testcases/bin/cron_tests.sh: line 102: crontab: command not found
cron01      2  TBROK  :  Remaining cases broken
cron01      3  TBROK  :  Remaining cases broken
cron01      0  TINFO  :  Test #1: /var/log/cron: Trying altenate log...
cron01      1  TFAIL  :  Test #1: crontab activity not recorded in
/var/log/messages.
awk: cmd. line:2: fatal: cannot open file `/tmp/tst1_cron.out' for
reading (No such file or directory)
awk: cmd. line:2: fatal: cannot open file `/tmp/tst1_cron.out' for
reading (No such file or directory)
cron01      1  TFAIL  :  Test #1: Problem with /tmp/tst1_cron.out file
cron01      1  TFAIL  :  Test #1: Cause: TS_MIN1= ; TS_MIN2=
cron01      1  TFAIL  :  Test #1: Cron did not execute every minute
cron02      0  TINFO  :  Test #2: crontab -r removes the crontab file.
cron02      0  TINFO  :  Test #2: installing crontab file.
cron02      2  TBROK  :  Test #2: crontab Broke while installing
cronjob. Reason:
/tests/ltp/testcases/bin/cron_tests.sh: line 267: crontab: command not found
cron02      3  TBROK  :  Remaining cases broken
cron02      0  TINFO  :  Test #1: /var/log/cron: alternate...
cron02      2  TFAIL  :  Test #2: crontab activity not recorded in
var/log/messages.
cron02      0  TINFO  :  Test #2: uninstalling crontab file.
cron02      2  TBROK  :  Test #2: crontab Broke while installing
cronjob. Reason:
/tests/ltp/testcases/bin/cron_tests.sh: line 299: crontab: command not found
cron02      3  TBROK  :  Remaining cases broken
cron03      0  TINFO  :  Test #3: crontab -l lists the cronjobs installed
cron03      0  TINFO  :  Test #3: installing crontab file ...
cron03      3  TBROK  :  Test #3: crontab failed while installing cronjob
/tests/ltp/testcases/bin/cron_tests.sh: line 362: crontab: command not found
cron03      3  TBROK  :  Test #3: crontab failed while listing
cronjobs installed
cron03      0  TINFO  :  Test #3: uninstalling crontab file.
cron03      3  TBROK  :  Test #3: crontab failed while removing cronjob
cron03      3  TFAIL  :  Test #3: crontab failed removing cronjob. Reason:
<<<execution_status>>>
initiation_status="ok"
duration=159 termination_type=exited termination_id=10 corefile=no
cutime=6 cstime=9
<<<test_end>>>

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
