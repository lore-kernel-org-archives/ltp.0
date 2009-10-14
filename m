Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My8Kg-00087B-Av
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:12:18 +0000
Received: from mail-px0-f180.google.com ([209.85.216.180])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My8Ka-0006nc-Iz
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 18:12:13 +0000
Received: by pxi10 with SMTP id 10so40502pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 11:12:07 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 11:12:06 -0700
Message-ID: <364299f40910141112v7847fc77s3dbd14b5ee543090@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 8] rwtest*: iogen / rwtest needs to create
	prerequisite directory paths
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

Many of the rwtest apps fail because the directory to the path where
they're trying to generate the file doesn't already exist:

<<<test_start>>>
tag=rwtest01 stime=1255493917
cmdline="export LTPROOT; rwtest.sh -N rwtest01 -c -q -i 60s  -f sync
10%25000:rw-sync-$$ 500b:/test/growfiles/reiser/rwtest06%s"
contacts=""
analysis=exit
<<<test_output>>>
iogen(rwtest01):  Could not create/open file
/test/growfiles/reiser/rwtest067013_1: No such file or directory (2)
iogen(rwtest01) warning:  Couldn't create file
/test/growfiles/reiser/rwtest067013_1 of 256000 bytes
rwtest01    1  TPASS  :  Test passed
Test passed
<<<execution_status>>>
initiation_status="ok"
duration=68 termination_type=exited termination_id=0 corefile=no
cutime=33 cstime=158
<<<test_end>>>

I assume that this is covered with one of the testscripts/... scripts,
but this should be a common requirement of all invocations for
rwtest.sh so that running the test script beforehand for this kind of
trivial functionality isn't necessary.

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
