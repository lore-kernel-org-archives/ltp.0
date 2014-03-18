Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WPwi3-0000GZ-VF
	for ltp-list@lists.sourceforge.net; Tue, 18 Mar 2014 16:17:48 +0000
Date: Tue, 18 Mar 2014 17:17:26 +0100
From: chrubis@suse.cz
Message-ID: <20140318161725.GB13153@rei.Home>
References: <1392951789-12569-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392951789-12569-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] msync/msync03.c: add EBUSY test for msync(2)
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Merge msync03.c, msync04.c, msync05.c into one msync03
> test, which contains EINVAL and ENOMEM error value tests.
> 
> And add new EBUSY error value test.

Pushed with minor changes:

--- a/testcases/kernel/syscalls/msync/msync03.c
+++ b/testcases/kernel/syscalls/msync/msync03.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
  *
@@ -144,7 +145,7 @@ static void setup(void)
 
 #if !defined(UCLINUX)
        /* memory pointed to by addr4 was not mapped */
-       addr4 =  get_high_address();
+       addr4 = get_high_address();
 #endif
 }
 
@@ -172,14 +173,11 @@ static void cleanup(void)
 {
        TEST_CLEANUP;
 
-       if (munmap(addr1, page_sz) < 0)
+       if (addr1 && munmap(addr1, page_sz) < 0)
                tst_resm(TWARN | TERRNO, "munmap() failed");
 
        if (fd > 0 && close(fd) < 0)
                tst_resm(TWARN | TERRNO, "close() failed");
 
-       if (unlink(TEMPFILE) < 0)
-               tst_resm(TWARN | TERRNO, "unlink(%s) failed", TEMPFILE);
-
        tst_rmdir();
 }


Please do not remove copyright headers unless the test was rewritten from
scratch. And you don't have to unlink files in tmpdir, tst_rmdir() does that
for you, you only have to close the fds.

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
