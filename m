Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D76EC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:31:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59D023C921B
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 12:30:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBDBE3C0E02
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 12:30:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E7BD140123E
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 12:30:48 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 60550212C9;
 Tue, 21 Dec 2021 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1640086248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vbsv6NNlS6wpnluMEy/TYMFbs5+BQJvgrNLZ+RjOoDQ=;
 b=NYY5vfPQVbFu6a988vD5JcI+jjptg0v+yTy0y5q2AbJU+ksgvzltOQw30HldVQhKi2zCWl
 0pmCk7f6FKXEUhaF0O04G7EYX9F5QkHsCMjZRwCviu76PAh2B0tkPHNTqMwwitNX4lTUpv
 4N+CicFH0TZ/Fj4Vzpb79jWOyRFkwA4=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id 2A21CA3B83;
 Tue, 21 Dec 2021 11:30:48 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 21 Dec 2021 11:30:42 +0000
Message-Id: <20211221113042.21357-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211220180748.36A90A3B8E@relay2.suse.de>
References: <20211220180748.36A90A3B8E@relay2.suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH] API: Allow testing of kernel features in
 development
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add an unstable kernel ABI flag and a runtest file for unstable
tests. This means we can add tests which are likely to be broken by
changes in the kernel ABI. Without disrupting LTP releases which are
required to be stable.

Users who require stability can filter the tests with this flag
or not schedule the unstable runtest file(s).

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

How about adding this to the fanotify22 patch?

 include/tst_test.h        | 12 ++++++++++++
 lib/tst_test.c            |  6 ++++++
 runtest/syscalls-unstable |  3 +++
 3 files changed, 21 insertions(+)
 create mode 100644 runtest/syscalls-unstable

diff --git a/include/tst_test.h b/include/tst_test.h
index 450ddf086..ff31e972e 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -174,6 +174,18 @@ struct tst_test {
 	int skip_in_lockdown:1;
 	int skip_in_compat:1;
 
+	/*
+	 * Test is for a feature that has not been added to the stable
+	 * kernel ABI. That is, it's for a feature only available in
+	 * linux-next, an RC or some other development branch.
+	 *
+	 * This string should be set to some text describing the
+	 * kernel branch and version the test was developed
+	 * against. e.g. "5.16 RC2", "linux-next-20211220",
+	 * "net-next".
+	 */
+	const char *const unstable_abi_version;
+
 	/*
 	 * The skip_filesystem is a NULL terminated list of filesystems the
 	 * test does not support. It can also be used to disable whole class of
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 9b51bb5be..babb250d0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1013,6 +1013,12 @@ static void do_setup(int argc, char *argv[])
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
 
+	if (tst_test->unstable_abi_version) {
+		tst_res(TINFO,
+			"This test was developed against pre-release kernel: %s",
+			tst_test->unstable_abi_version);
+	}
+
 	if (tst_test->tconf_msg)
 		tst_brk(TCONF, "%s", tst_test->tconf_msg);
 
diff --git a/runtest/syscalls-unstable b/runtest/syscalls-unstable
new file mode 100644
index 000000000..a87284afe
--- /dev/null
+++ b/runtest/syscalls-unstable
@@ -0,0 +1,3 @@
+# Tests for kernel features which are not finalized
+
+fanotify22 fanotify22
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
