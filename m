Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <wangyong2009@cn.fujitsu.com>) id 1MT525-0003mp-7i
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 02:24:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MT51q-0002w4-Ub
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 02:24:40 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 9E22A17015D
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 10:45:46 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n6L2vhDM016538
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 10:57:43 +0800
Received: from [127.0.0.1] (unknown [10.167.141.107])
	by fnst.cn.fujitsu.com (Postfix) with ESMTP id 9FA30D403E
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 10:25:32 +0800 (CST)
Message-ID: <4A652715.4090103@cn.fujitsu.com>
Date: Tue, 21 Jul 2009 10:25:25 +0800
From: Wang Yong <wangyong2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]   [PATCH] Fix failure of the utimes01 test
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
To: LTP <ltp-list@lists.sourceforge.net>

This patch also fixed the path which we pass to setup_file(). If
progdir is not a absolute pathname of the working directory, the file
open will fail.

Signed-off-by: WangYong <wangyong2009@cn.fujitsu.com>

--- a/testcases/kernel/syscalls/utimes/utimes01.c	2009-07-21 08:51:05.000000000 +0800
+++ b/testcases/kernel/syscalls/utimes/utimes01.c	2009-07-21 08:55:01.000000000 +0800
@@ -138,7 +138,6 @@ void setup() {
  */
 static int opt_debug;
 static char *progname;
-static char *progdir;
 
 enum test_type {
 		NORMAL,
@@ -232,7 +231,7 @@ static int do_test(struct test_case *tc)
         struct stat st;
         uid_t old_uid;
 
-        TEST(rc = setup_file(progdir, "test.file", fpath));
+        TEST(rc = setup_file(TESTDIR, "test.file", fpath));
         if (rc < 0)
                 return 1;
 
@@ -339,8 +338,6 @@ int main(int ac, char **av) {
 	progname = strchr(av[0], '/');
         progname = progname ? progname + 1 : av[0];	
 	
-	progdir = strdup(av[0]);
-        progdir = dirname(progdir);
 	
         /* parse standard options */
         if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char *)NULL){




------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
