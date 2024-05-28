Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C5DC25B7C
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 12:06:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7262A3D0535
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 14:06:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CE413C67E5
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:06:03 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F568602805
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:06:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D132227F8;
 Tue, 28 May 2024 12:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716897961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Ril5vGTa+gAanEeRGBucoGNHr96iOHt7ICgJ+dVa/E=;
 b=e+dhLnAcpv6/cjLlE1RA7aDt9LL3iFLCqP0e1Kinc/rp1sdymS2GR2QOYzIzc6AXVNkzxf
 sPFRpSDXwVHNoL1fFU4vrAnnBgKTHZsDgE0MOp9x943CEcfJ4IuufgVnKUalJy3SOmWcCr
 kWD15u/o8XWPIkfng3H+7j+VrQCnq6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716897961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Ril5vGTa+gAanEeRGBucoGNHr96iOHt7ICgJ+dVa/E=;
 b=ycjou0owa61eLIe4YAGJXNBmpc6eNrS4esDVnCQSnZ039PFlPU702U+8BICpUbkkRgfgti
 rZnChH7g/6i5PwAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716897961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Ril5vGTa+gAanEeRGBucoGNHr96iOHt7ICgJ+dVa/E=;
 b=e+dhLnAcpv6/cjLlE1RA7aDt9LL3iFLCqP0e1Kinc/rp1sdymS2GR2QOYzIzc6AXVNkzxf
 sPFRpSDXwVHNoL1fFU4vrAnnBgKTHZsDgE0MOp9x943CEcfJ4IuufgVnKUalJy3SOmWcCr
 kWD15u/o8XWPIkfng3H+7j+VrQCnq6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716897961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Ril5vGTa+gAanEeRGBucoGNHr96iOHt7ICgJ+dVa/E=;
 b=ycjou0owa61eLIe4YAGJXNBmpc6eNrS4esDVnCQSnZ039PFlPU702U+8BICpUbkkRgfgti
 rZnChH7g/6i5PwAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A26C13A8A;
 Tue, 28 May 2024 12:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AGKoBKnIVWYjTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 May 2024 12:06:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 May 2024 14:05:54 +0200
Message-ID: <20240528120554.433874-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528120554.433874-1-pvorel@suse.cz>
References: <20240528120554.433874-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tree: Use TINFO_WARN
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_supported_fs_types.c                    | 2 +-
 testcases/kernel/mem/hugetlb/lib/hugetlb.c      | 4 ++--
 testcases/kernel/syscalls/ipc/semctl/semctl08.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index bbbb8df19..8b8cf213a 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -158,7 +158,7 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 	only_fs = getenv("LTP_SINGLE_FS_TYPE");
 
 	if (only_fs) {
-		tst_res(TINFO, "WARNING: testing only %s", only_fs);
+		tst_res(TINFO_WARN, "testing only %s", only_fs);
 		if (tst_fs_is_supported(only_fs))
 			fs_types[0] = only_fs;
 		return fs_types;
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 43a677ce9..c612bf2d2 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -106,8 +106,8 @@ void rm_shm(int shm_id)
 	 * check for # of attaches ?
 	 */
 	if (shmctl(shm_id, IPC_RMID, NULL) == -1) {
-		tst_res(TINFO, "WARNING: shared memory deletion failed.");
-		tst_res(TINFO, "This could lead to IPC resource problems.");
+		tst_res(TINFO_WARN, "shared memory deletion failed");
+		tst_res(TINFO, "This could lead to IPC resource problems");
 		tst_res(TINFO, "id = %d", shm_id);
 	}
 }
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
index 1878bd49d..aacdcf6a5 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
@@ -40,7 +40,7 @@ static void run(void)
 		tst_res(TPASS, "time_high fields cleared by the kernel");
 
 	if (semctl(semid, 0, IPC_RMID, arg) == -1)
-		tst_res(TINFO, "WARNING: semaphore deletion failed.");
+		tst_res(TINFO_WARN, "semaphore deletion failed");
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
