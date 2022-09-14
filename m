Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7737FECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 16:20:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B88CC3CABE1
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 18:20:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4CDA3CABE1
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 18:19:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1EECC20091B
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 18:19:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ADC6133B88
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663172371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w11TzvzSPfXZc7YlXpudY9P5SaqLL2fgKuV/T8RHGv8=;
 b=nvUhM6BUGn97hQbWBwM72jAEorrErFask7+ZmJn/p0BweCX/QKmxHJONeE6g3L5l5SEwvd
 GRXSfaGMh8q85bQ6Y8EJB2+REzAl0i1AQ+rBfMMV4a9Qme7jmbGvl/jTqQBXuvTmwtYjKJ
 n8+ilZ/e9xqhT7ooXQRMsV/yXa5rFDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663172371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w11TzvzSPfXZc7YlXpudY9P5SaqLL2fgKuV/T8RHGv8=;
 b=lW18c/J/EeqGGidxY4NVogqv9MEPaiT0LT6Ya3vXJSZVcBGWEjqCztadKzGVB3GnAnvrHn
 cz9fw8hbnGnEAkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D4CA134B3
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 16:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KA5eJRP/IWMwYgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 16:19:31 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Sep 2022 18:19:29 +0200
Message-Id: <20220914161930.27681-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914161930.27681-1-mdoucha@suse.cz>
References: <20220914161930.27681-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] readahead02: Add max_runtime
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Also calculate max_runtime dynamically if the test gets called with
non-default filesize.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Added dynamic runtime calculation for non-default filesize

 testcases/kernel/syscalls/readahead/readahead02.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 4fa8cfaf8..02e866e82 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -38,7 +38,9 @@ static char testfile[PATH_MAX] = "testfile";
 #define DROP_CACHES_FNAME "/proc/sys/vm/drop_caches"
 #define MEMINFO_FNAME "/proc/meminfo"
 #define PROC_IO_FNAME "/proc/self/io"
-static size_t testfile_size = 64 * 1024 * 1024;
+#define DEFAULT_FILESIZE (64 * 1024 * 1024)
+
+static size_t testfile_size = DEFAULT_FILESIZE;
 static char *opt_fsizestr;
 static int pagesize;
 static unsigned long cached_max;
@@ -365,8 +367,10 @@ static void setup_readahead_length(void)
 
 static void setup(void)
 {
-	if (opt_fsizestr)
+	if (opt_fsizestr) {
 		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
+		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
+	}
 
 	if (access(PROC_IO_FNAME, F_OK))
 		tst_brk(TCONF, "Requires " PROC_IO_FNAME);
@@ -406,6 +410,7 @@ static struct tst_test test = {
 	},
 	.test = test_readahead,
 	.tcnt = ARRAY_SIZE(tcases),
+	.max_runtime = 30,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b833a3660394"},
 		{"linux-git", "5b910bd615ba"},
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
