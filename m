Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D88C5CFDB
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 12:50:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70DB93C72EC
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 14:50:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA0C83C71CE
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:49:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A9AB600459
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:49:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5A5982F71
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786711790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWXSIwtzpLSD5lxGznCm8h9FMKqP8pmV9HZCL9Vl2n4=;
 b=Rfg26Wy2UXH++B2jVdjSFVT242f8xmhhuCJOvsLKlpicesl3F3O/c4EI2ti33cl6XxXiZC
 XhBuHeA9aL2W3FiG8ejbxj2EEdnGkO445iox8aVou6PV/kYreWQ4eNO0sJ0pQERH9TgdnL
 m4rJBbBOJmIX1M5+/HJYuGxvRzTUHk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786711790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWXSIwtzpLSD5lxGznCm8h9FMKqP8pmV9HZCL9Vl2n4=;
 b=bVQz/cldEmErmX8Az9cBTkVldQIHI6WIMrf7P7PTUZoY87hTsIf7l0GSO0bsMl0MXFzO4m
 5B1c5op1cxjb/9AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786711785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWXSIwtzpLSD5lxGznCm8h9FMKqP8pmV9HZCL9Vl2n4=;
 b=xa1zuPkBn96jLUi0K+TF8iTAZgbO0ckCiM6gpl41pvH1/liKa6Rl10MIhYmqPLlt8UyuT7
 yfBVcYrP+63ttrVJpiKatjw0Ptf3UEZq3cQgx9l/Xif/v519Rmc06Ss6mNVs7P22VZWanD
 GCNKBmqbz9reQE2TUTKQJaA6eyXZ4OY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786711785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWXSIwtzpLSD5lxGznCm8h9FMKqP8pmV9HZCL9Vl2n4=;
 b=OSvzIkW0ozdLsFYi+nDvWHDWketF09IP5tXZfKKM8nBYpZii/QYLGqAsnruUyuf2LX5sXe
 OxxBLiqb2oAxw3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2847783B0
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YIe4LekOf2rlKgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Aug 2026 14:49:37 +0200
Message-ID: <20260814124943.36853-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814124943.36853-1-mdoucha@suse.cz>
References: <20260814124943.36853-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] refluxfs: Check kernel reflink support before
 mount
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

On some systems, mkfs.xfs can format XFS partition with reflink support
but the kernel then cannot mount it. Check for kernel reflink support
before mount.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Tested on kernel v4.12 without reflink support and v6.4 with reflink support.

 testcases/cve/refluxfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/cve/refluxfs.c b/testcases/cve/refluxfs.c
index e41f35c53..bdf5d32c9 100644
--- a/testcases/cve/refluxfs.c
+++ b/testcases/cve/refluxfs.c
@@ -210,6 +210,7 @@ static struct tst_test test = {
 	.filesystems = (struct tst_fs []) {
 		{
 			.type = "xfs",
+			.mount_check_support = 1,
 			.min_kver = "4.11",
 			.mkfs_ver = "mkfs.xfs >= 1.5.0",
 			.mkfs_opts = (const char *const []) {
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
