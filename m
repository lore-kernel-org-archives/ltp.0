Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <aravindjv@motorola.com>) id 1OMFTe-0005bX-B1
	for ltp-list@lists.sourceforge.net; Wed, 09 Jun 2010 07:13:30 +0000
Received: from mail55.messagelabs.com ([216.82.241.163])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OMFTc-0001lx-1z
	for ltp-list@lists.sourceforge.net; Wed, 09 Jun 2010 07:13:30 +0000
Received: from il27exr03.cig.mot.com (il27exr03.mot.com [10.17.196.72])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id o597DLv8006076
	for <ltp-list@lists.sourceforge.net>;
	Wed, 9 Jun 2010 00:13:21 -0700 (MST)
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by il27exr03.cig.mot.com (8.13.1/Vontu) with SMTP id o597DLmh009253
	for <ltp-list@lists.sourceforge.net>;
	Wed, 9 Jun 2010 02:13:21 -0500 (CDT)
Received: from ZMY16EXM67.ds.mot.com (zmy16exm67.ap.mot.com [10.179.4.27])
	by il27exr03.cig.mot.com (8.13.1/8.13.0) with ESMTP id o597DJme009224
	for <ltp-list@lists.sourceforge.net>;
	Wed, 9 Jun 2010 02:13:20 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 9 Jun 2010 15:12:57 +0800
Message-ID: <0C2F2C9232E1244BA469CAD31CF5C31608284DA4@ZMY16EXM67.ds.mot.com>
In-Reply-To: <201006071924.CHE69736.FtHLVMFOFQOJOS@I-love.SAKURA.ne.jp>
References: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp><1275834288.7037.3.camel@subratamodak.linux.ibm.com><201006070651.o576p4S0093912@www262.sakura.ne.jp><1275901898.4851.2.camel@subratamodak.linux.ibm.com>
	<201006071924.CHE69736.FtHLVMFOFQOJOS@I-love.SAKURA.ne.jp>
From: "Vinayak Aravind-A20738" <aravindjv@motorola.com>
Subject: [LTP] Container tests failing on x86_64
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

 
Hi, 
Anyone facing this issue with Container tests ? 

pidns06     0  TINFO  :  Parent: Passing the pid of the process 11537
pidns30     0  TINFO  :  parent: successfully created posix mqueue
pidns30     1  TBROK  :  cinit: mq_open() failed (Bad address)
pidns30     0  TINFO  :  parent: successfully created posix mqueue
pidns30     1  TBROK  :  parent: container did not respond!
pidns31     1  TBROK  :  parent: mq_open() failed (Permission denied)
-------------
-------------
/opt/ltp/testcases/bin/childipv6.sh: line 72: tst_resm: command not
found
paripv6.sh    0  TINFO  :  IPv6: Pinging child from parent: PASS
par_chld_ipv6: PASS

parentns.sh    0  TINFO  :  Pinging ChildNS from ParentNS
sshd re-exec requires execution with an absolute path^M
Error: Can't login to 192.168.0.181:
ch_ftp.sh: line 40: tst_resm: command not found
Error while running the script
two_children_ns: return code is 1 ; par_chld_ftp: FAIL 1 ;

incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=46 termination_type=exited termination_id=1 corefile=no
cutime=18 cstime=45
<<<test_end>>>
initialize.sh: line 83:    44 Terminated              ( ip link delete
$netdev ) 2> /dev/null


Thanks,
Arvind

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
