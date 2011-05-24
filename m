Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sandipb@yahoo-inc.com>) id 1QOsSQ-0002SI-RI
	for ltp-list@lists.sourceforge.net; Tue, 24 May 2011 14:19:38 +0000
Received: from mrout3.yahoo.com ([216.145.54.173])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QOsSQ-0006zJ-4t
	for ltp-list@lists.sourceforge.net; Tue, 24 May 2011 14:19:38 +0000
Received: from orthus.eglbp.corp.yahoo.com
	(hurtsnowdance-dr.eglbp.corp.yahoo.com [10.66.78.119])
	by mrout3.yahoo.com (8.13.8/8.13.8/y.out) with ESMTP id p4ODwMM8046040
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 May 2011 06:58:22 -0700 (PDT)
Received: from [10.66.104.24] (vpn-client-104-24.eglbp.corp.yahoo.com
	[10.66.104.24])
	by orthus.eglbp.corp.yahoo.com (Postfix) with ESMTP id 7AB891BD8034
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 May 2011 06:58:21 -0700 (PDT)
Message-ID: <4DDBB97C.1050202@yahoo-inc.com>
Date: Tue, 24 May 2011 19:28:20 +0530
From: Sandip Bhattacharya <sandipb@yahoo-inc.com>
MIME-Version: 1.0
Subject: [LTP] su01 test case failure
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
To: ltp-list@lists.sourceforge.net

The expect script /opt/ltp/testcases/bin/su01_s1 expects an environment
variable PASSWD, but /opt/ltp/testcases/bin/su01 doesn't setup such a
variable.

Since this test always fails for me on the RHEL machines I run this on,
I wanted to ask if the LTP test framework itself passed this environment
variable to the tests or is there something wrong with this test.

My test output is normally like this:

    <<<test_start>>>
    tag=su01 stime=1305746477
    cmdline="export TCbin=$LTPROOT/testcases/bin;su01"
    contacts=""
    analysis=exit
    <<<test_output>>>
    Machine type is: redhat-linux

    userdel: user su_usr1 does not exist
    userdel: user su_usr2 does not exist
    YOU NEED TO SET ENVIROMENT VARIABLE PASSWD.
    <<<execution_status>>>
    initiation_status="ok"
    duration=4 termination_type=exited termination_id=1 corefile=no
    cutime=13 cstime=35
    <<<test_end>>>


TIA,
  Sandip

------------------------------------------------------------------------------
vRanger cuts backup time in half-while increasing security.
With the market-leading solution for virtual backup and recovery, 
you get blazing-fast, flexible, and affordable data protection.
Download your free trial now. 
http://p.sf.net/sfu/quest-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
