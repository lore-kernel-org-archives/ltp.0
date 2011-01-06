Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PanNl-0006CH-Ke
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 10:47:49 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PanNj-0003tP-SC
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 10:47:49 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id CAA7B17012C
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 18:47:40 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06AgYvd018885
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 18:42:35 +0800
Message-ID: <4D259E4A.2050704@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 18:49:46 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 00/13]Fix a few syntax error
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

There are several small bugs making LTP unable to be built, most of 
which are syntax errors.

1. Add missing parameters for tst_brkm() in 
testcases/kernel/syscalls/fchmod/fchmod03.c
2. Add missing parameters for tst_brkm() in 
testcases/kernel/syscalls/flock/flock04.c
3. Add missing ";" in testcases/kernel/syscalls/getpagesize/getpagesize01.c
4. Correct the parameters' names for parse_opts() in 
testcases/kernel/syscalls/lchown/lchown02.c
5. Add some preprocessor variables in /testcases/kernel/mem/ksm/ksm01.c 
bacause KSM is not supported on RHEL5
6. Add missing operators for parse_opts() in 
testcases/kernel/syscalls/msync/msync04.c
7. Fix an wrong using of macro WTERMSIG in 
testcases/kernel/syscalls/pipe/pipe04.c
8. Fix the wrong variable name of wtstatus in 
testcases/kernel/syscalls/pipe/pipe09.c
9. Add a missing ")" in testcases/kernel/syscalls/pread/pread03.c
10. Remove a redundant "{" in 
testcases/kernel/syscalls/sched_getparam/sched_getparam02.c
11. Fix the wrong using of perror() in 
testcases/kernel/syscalls/sched_setparam/sched_setparam03.c
12. Add a missing variable TST_TOTAL in 
testcases/kernel/syscalls/socketpair/socketpair02.c
13. Add missing parameters for tst_brkm() in 
testcases/kernel/syscalls/statfs/statfs03.c

-- 
Best Regards,
Tang chen
--------------------------------------------------
Tang Chen



------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
