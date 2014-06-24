Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WzRJb-0003D4-97
	for ltp-list@lists.sourceforge.net; Tue, 24 Jun 2014 14:03:15 +0000
Date: Tue, 24 Jun 2014 16:02:58 +0200
From: chrubis@suse.cz
Message-ID: <20140624140258.GA9159@rei>
References: <1398079016-9193-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1402989991-19613-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402989991-19613-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/2] renameat/renameat01.c: cleanup
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Add renameat.h to encapsulate renameat syscall.
> Delete some useless comments.
> Use some SAFE_* macros.
> Move the test body from main() to renameat_verify().

Pushed with folling changes, thanks.
(because it's important to check not only the errno but the return value
 as well)

 /*
  * Copyright (c) International Business Machines  Corp., 2006
+ *  Author: Yi Yang <yyangcdl@cn.ibm.com>
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -150,6 +151,16 @@ static void renameat_verify(const struct test_case_t *tc)
 	TEST(renameat(*(tc->oldfdptr), tc->oldpath,
 			*(tc->newfdptr), tc->newpath));
 
+	if (tc->exp_errno && TEST_RETURN != -1) {
+		tst_resm(TFAIL, "renameat() succeeded unexpectedly");
+		return;
+	}
+
+	if (tc->exp_errno == 0 && TEST_RETURN != 0) {
+		tst_resm(TFAIL | TTERRNO, "renameat() failed unexpectedly");
+		return;
+	}
+
 	if (TEST_ERRNO == tc->exp_errno) {
 		tst_resm(TPASS | TTERRNO,
 		"renameat() returned the expected value");

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
