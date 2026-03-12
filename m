Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675A7FED2FE
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 10:43:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA72C3E2790
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 11:43:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 488383E15D8
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 11:43:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70AAF200DA8
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 11:43:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 052DE4D33F;
 Thu, 12 Mar 2026 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773312202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t7+fU0qx55OMVTjbyJt1/wljIlYCQOnht2I7rJDTQjY=;
 b=mnQWukQGrKpiaL8imTDvs12gJ4rfQ9ZqVX51ng4EOoKQaoQnVf5rX6NHMn8rUNOg1BQ+j+
 MkUB8lf7N3GGR2FaJpida0kUe31fDoeHTyo2OCN/HkbMmiYTfSTsqpvIYdFl3uu3lIHdQn
 C/Mu4MA6fqCV4CGiMlwDjVaVr9wpZQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773312202;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t7+fU0qx55OMVTjbyJt1/wljIlYCQOnht2I7rJDTQjY=;
 b=DinCeFIH7Uc5kkkLi6xZnwx8Ngbx27JCa7FYY0yVcJX3RYGEFZ2YrzY/ce656xis3GME4K
 kf5W2hBRAFJJgVBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773312202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t7+fU0qx55OMVTjbyJt1/wljIlYCQOnht2I7rJDTQjY=;
 b=mnQWukQGrKpiaL8imTDvs12gJ4rfQ9ZqVX51ng4EOoKQaoQnVf5rX6NHMn8rUNOg1BQ+j+
 MkUB8lf7N3GGR2FaJpida0kUe31fDoeHTyo2OCN/HkbMmiYTfSTsqpvIYdFl3uu3lIHdQn
 C/Mu4MA6fqCV4CGiMlwDjVaVr9wpZQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773312202;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t7+fU0qx55OMVTjbyJt1/wljIlYCQOnht2I7rJDTQjY=;
 b=DinCeFIH7Uc5kkkLi6xZnwx8Ngbx27JCa7FYY0yVcJX3RYGEFZ2YrzY/ce656xis3GME4K
 kf5W2hBRAFJJgVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E51173FF15;
 Thu, 12 Mar 2026 10:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4sLxNsmYsmnKeQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 12 Mar 2026 10:43:21 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 Mar 2026 11:43:22 +0100
Message-ID: <20260312104322.31729-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve: icmp_rate_limit: Make sure icmp_msgs_burst = 50
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
Cc: Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test is written with an assumption that the burst for icmp message
is 50 since it sends 100 messages in a batch and expects the kernel to
go over the limit. The easiest way how to fix the test is to set the
sysctl to 50 before the test and restore it later.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/cve/icmp_rate_limit01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 0305ad095..78480cea6 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -255,6 +255,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{"/proc/sys/net/ipv4/icmp_msgs_burst", "50", TST_SR_TBROK},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
