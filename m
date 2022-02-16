Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD19C433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 09:08:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4D983CA098
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 10:08:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 628D83C9564
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:08:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 633B8201034
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:08:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44492212C5;
 Wed, 16 Feb 2022 09:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645002486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fBawKUvorDfTqslYACgJfbcq5WmfnNCuKY/DNG+7qAg=;
 b=1OoOy1M4uaIXMq+7fyBDb7cKBch3Kv5GnY+EhbFARVLv6Nd1mtfs4qYl/tJqhPDq/47zKa
 RA6CIk0ktGINw2EzNbUnC7064I/M6qoV8wkN24HKArPAgdVWYtEj1ITFNzJgZEAwHicTyA
 QGDZb00YCFRolbmBGHaa+M5LXpCcfGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645002486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fBawKUvorDfTqslYACgJfbcq5WmfnNCuKY/DNG+7qAg=;
 b=h1vJRMv6PTMdv/9U8HrWJcSKxvN3lxN/KoEh680NnXwz+pybrLoaGElC8nsMlHseYgl4QP
 7A57jaEcZwJjT3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2144B13A95;
 Wed, 16 Feb 2022 09:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 47MqBva+DGLRYwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 16 Feb 2022 09:08:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Feb 2022 10:08:01 +0100
Message-Id: <20220216090801.31400-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] ustat: Add missing space in known-fail
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

Although testinfo.pl in a7b6c94503 adds extra space for producing doc,
space was missing when printing after test run:

$ ./ustat01
...
HINT: You _MAY_ be hit by known kernel failures:

ustat() is known to fail with EINVAL on Btrfs, seehttps://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
We might just remove the space from docparse/testinfo.pl which is now
useless:

diff --git docparse/testinfo.pl docparse/testinfo.pl
index 67e435d794..fa77b53cc5 100755
--- docparse/testinfo.pl
+++ docparse/testinfo.pl
@@ -456,7 +456,7 @@ sub content_all_tests
 			# tag value value can be split into more lines if too long
 			# i.e. URL in known-fail
 			for (@$tag[2 .. $#$tag]) {
-				$v .= " $_";
+				$v .= $_;
 			}
 
 			$content .= "\n|" . reference($k) . "\n|$v\n";

 testcases/kernel/syscalls/ustat/ustat01.c | 2 +-
 testcases/kernel/syscalls/ustat/ustat02.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 66dbc0b184..70a44adb46 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -45,7 +45,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.tags = (const struct tst_tag[]) {
-		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see"
+		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
 			"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
 		},
 		{}
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index 55bdcaedf8..a5b0cc1b68 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -64,7 +64,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tc),
 	.tags = (const struct tst_tag[]) {
-		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see"
+		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
 			"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
 		},
 		{}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
