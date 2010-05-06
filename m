Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v2l-0007hD-Ck
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:58:47 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v2k-0001Wj-Bw
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:58:47 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466pKL7010358
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:51:20 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466weWl128858
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:58:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o466wdTp002929
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:58:40 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:28:31 +0530
Message-Id: <20100506065830.23879.79824.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [10/12 FAILURE] LTPX ar01 fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2811702355751415213=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============2811702355751415213==

Subject: LTP�� ar01 fails

Issue Description Below:
===============================
# vi runtest/ar01
ar export TCdat=$LTPROOT/testcases/bin; ar01
<EOF>

Run LTP with the following command:
# ./runltp -f ar01
<<<test_start>>>
tag=ar stime=1272004502
cmdline="export TCdat=$LTPROOT/testcases/bin; ar01"
contacts=""
analysis=exit
<<<test_output>>>
-------System test for ar command, Loop 1----
-)1
-)2
-)3
-)4
-)5
-)6
-)7
-)8
-)9
-)10
-)11
-)12
-)13
-)14
-)15
-)16
-)17 SKIPPED due to binutils ar automatically adds a symbol.
-)18
-)19 SKIPPED due to binutils ar automatically adds a symbol.
-)20
-)21
4,6c4,6
< -rwxrwxr-x.;0/0;17;Apr;23;12:05;file1.in
< -rwxrwxr-x.;0/0;17;Apr;23;12:05;file2.in
< -rwxrwxr-x.;0/0;19;Apr;23;12:05;file3.in
---
> -rwxrwxr-x;0/0;17;Apr;23;12:05;file1.in
> -rwxrwxr-x;0/0;17;Apr;23;12:05;file2.in
> -rwxrwxr-x;0/0;19;Apr;23;12:05;file3.in
FAIL - ar with -v failed to produce a verbose out put
-)23
-)24
-)25
-)26 SKIPPED UNDER PAN
ar: creating /tmp/ar01-9909/lib.a
-)27
ar: creating /tmp/ar01-9909/lib.a
-)28
ar: creating /tmp/ar01-9909/lib.a
-)29
ar: creating /tmp/ar01-9909/lib.a
-)30
ar: creating /tmp/ar01-9909/lib.a
-)31
---------------ar command failed the system test-----------------
<<<execution_status>>>
initiation_status="ok"
duration=6 termination_type=exited termination_id=1 corefile=no
cutime=8 cstime=50
<<<test_end>>>

Regards--
Subrata



--===============2811702355751415213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============2811702355751415213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2811702355751415213==--
