Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB2AC54EBC
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 05:06:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3B823CDCC2
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 06:05:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FBF73CB55B
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 06:05:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 50B5A1A007EF
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 06:05:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5360737370;
 Thu, 12 Jan 2023 05:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1673499948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yZHeyT2aNEM8ycFfh5JB9/rSzMunzkMP5tuur22/z4I=;
 b=ou3sLBem+YsSZjxOpcLQBVle+JqpZRJdKq8St6ktYJ6tvMplL9FDKH8k9CLryq+6fDPsHY
 ePuiKtJFvts+ZBofsXLdOo7ymMLl1Bj8D5inmIZ+tLBDW+u9lxENbc9/ADZ2CVd2pYghaV
 lOxhuspR2p786LpUb0Epzs/epxt9awA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F08C4134AF;
 Thu, 12 Jan 2023 05:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pV4tLSqVv2NzGwAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 12 Jan 2023 05:05:46 +0000
To: ltp@lists.linux.it
Date: Wed, 11 Jan 2023 13:18:26 -0500
Message-Id: <20230111181826.9395-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Fix coding style issue
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
From: WEI GAO via ltp <ltp@lists.linux.it>
Reply-To: WEI GAO <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: WEI GAO <wegao@suse.com>
---
 testcases/kernel/syscalls/readahead/readahead02.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 3ed88c005..4eef353a8 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -69,7 +69,7 @@ static struct tcase {
 	int use_overlay;
 	int use_fadvise;
 	/* Use either readahead() syscall or POSIX_FADV_WILLNEED */
-	int (*readahead)(int, off_t, size_t);
+	int (*readahead)(int fd, off_t offset, size_t len);
 } tcases[] = {
 	{ "readahead on file", 0, 0, libc_readahead },
 	{ "readahead on overlayfs file", 1, 0, libc_readahead },
@@ -224,7 +224,7 @@ static void test_readahead(unsigned int n)
 
 	if (tc->use_overlay && !ovl_mounted) {
 		tst_res(TCONF,
-		        "overlayfs is not configured in this kernel.");
+		"overlayfs is not configured in this kernel.");
 		return;
 	}
 
@@ -252,7 +252,7 @@ static void test_readahead(unsigned int n)
 	cached_low = get_cached_size();
 	tst_res(TINFO, "read_testfile(1)");
 	ret = read_testfile(tc, 1, testfile, testfile_size, &read_bytes_ra,
-		            &usec_ra, &cached_ra);
+			    &usec_ra, &cached_ra);
 
 	if (ret == EINVAL) {
 		if (tc->use_fadvise &&
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
