Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40129CE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 14:42:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 044A53CE217
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 16:42:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA46D3CBD0D
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 16:42:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3326A60151E
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 16:42:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 452A51F74A;
 Mon, 25 Sep 2023 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695652928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=q0fgsYsShvlpPLtITBmootePr7Jqi1N5GaEpLDH+DwI=;
 b=at146Ql0GaS8fm8XivyccUfpVrzZO2e4XpLowIiZ7xnqp68540+D2DB359HDJm/U/TWzgZ
 jYJgHzd0mop4uOOHCi//grz/5ksKIvFa2crOiMS6ITelbisRE8pfTuU79o5Vmje+gSZhnV
 ia5YCKvKBg83B4ACimnmEqCLRnwXbsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695652928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=q0fgsYsShvlpPLtITBmootePr7Jqi1N5GaEpLDH+DwI=;
 b=/X4RSZn2KBXC1P8f5h5YipZ6jvr/kpsdoXlm5dd6C5M8d4N/AbluvvjH8yJJQL4Bcyue4S
 IuxTSAIqB7ah60Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DD8D13580;
 Mon, 25 Sep 2023 14:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gmxPCkCcEWXfOwAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 25 Sep 2023 14:42:08 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 25 Sep 2023 16:42:06 +0200
Message-ID: <20230925144206.16895-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Skip cgroup-related tests if `/sys/fs/cgroup`
 readonly
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

Otherwise clone303 fails with TBROK when `/sys/fs/cgroup` is mounted as
read-only which is normal in a container. The test result should better
be TCONF like it is already done in case of a permission error.

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 lib/tst_cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index fdeac6059..5240aadaa 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -383,6 +383,9 @@ static void cgroup_dir_mk(const struct cgroup_dir *const parent,
 		tst_brk(TCONF | TERRNO,
 			"Lack permission to make '%s/%s'; premake it or run as root",
 			dpath, dir_name);
+	} else if (errno == EROFS) {
+		tst_brk(TCONF | TERRNO, "'%s/%s' must not be read-only",
+			dpath, dir_name);
 	} else {
 		tst_brk(TBROK | TERRNO,
 			"mkdirat(%d<%s>, '%s', 0777)",
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
