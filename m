Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC90CDB482
	for <ltp@archiver.kernel.org>; Sat, 14 Oct 2023 03:31:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49AC93CF607
	for <ltp@archiver.kernel.org>; Sat, 14 Oct 2023 05:31:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C00BC3C8874
 for <ltp@lists.linux.it>; Sat, 14 Oct 2023 05:31:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 02A4D1A00F64
 for <ltp@lists.linux.it>; Sat, 14 Oct 2023 05:31:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB73F1FDE8;
 Sat, 14 Oct 2023 03:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1697254273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpQxvakd5O40FGzzukI2cSQ4tk5oidb/Yqo0SBnD9xk=;
 b=t852ol83PSGh31Bn87IGuSH8JykpkWP4KvOGxatuRuqALMH6otBgcfE5Sk2QztRjfxCQ0e
 E0Qoru1Frk6efJdya1bUYFCnoYBOSVbsHjoplLlD4Bq/BvKMKLyGgkGZWsAW27QjYRrOWu
 dpchOefnQjW+OYNuC65LP4REewPkRVU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4577A1358F;
 Sat, 14 Oct 2023 03:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UKk6CIELKmW5dwAAMHmgww
 (envelope-from <wegao@suse.com>); Sat, 14 Oct 2023 03:31:13 +0000
To: ltp@lists.linux.it
Date: Fri, 13 Oct 2023 23:31:04 -0400
Message-Id: <20231014033104.31424-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231012112548.6887-1-wegao@suse.com>
References: <20231012112548.6887-1-wegao@suse.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.99%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add test for UI_GET_NAME ioctl
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix:#573
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/input/input_helper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
index 09530fb4d..b9dc50a7f 100644
--- a/testcases/kernel/input/input_helper.c
+++ b/testcases/kernel/input/input_helper.c
@@ -32,6 +32,7 @@
 
 static int uinput_loaded;
 static int check_device(void);
+static void check_ui_get_sysname_ioctl(int fd);
 
 static int try_open_device(void)
 {
@@ -185,6 +186,22 @@ void send_rel_move(int fd, int x, int y)
 	send_event(fd, EV_SYN, 0, 0);
 }
 
+static void check_ui_get_sysname_ioctl(int fd)
+{
+	char sys_name[256];
+	char dev_name[256];
+	char *path;
+
+	SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(sys_name)), sys_name, NULL);
+	SAFE_ASPRINTF(NULL, &path, "/sys/devices/virtual/input/%s/name", sys_name);
+	SAFE_FILE_SCANF(NULL, path, "%s", dev_name);
+
+	if (strcmp(VIRTUAL_DEVICE, dev_name)) {
+		tst_brkm(TBROK, NULL, "Unable to find the input device through ioctl");
+	}
+	free(path);
+}
+
 void create_device(int fd)
 {
 	int nb;
@@ -202,8 +219,10 @@ void create_device(int fd)
 	SAFE_IOCTL(NULL, fd, UI_DEV_CREATE, NULL);
 
 	for (nb = 100; nb > 0; nb--) {
-		if (check_device())
+		if (check_device()) {
+			check_ui_get_sysname_ioctl(fd);
 			return;
+		}
 		usleep(10000);
 	}
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
