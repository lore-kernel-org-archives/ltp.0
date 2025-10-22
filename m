Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23391CCD195
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 09:58:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90A673CF0CA
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 11:58:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8B923CF0A8
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 11:58:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4804E1400E07
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 11:58:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7CB91F461
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761127081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdR79QtlxlSKeE83YnlNYiMweCpEt+zw/UV2GGRlJIM=;
 b=K/GftoFEECnD3rCCHUcawZaB7SgXUyPuc+eJKTGd2LjsFpgzuYKJ1sVluXKtl7Jqcgh5Hq
 CFnhXrlPHUtn1oF9lw1LJihzlMgNmbk3jHI/S0sibTM+2DwB82mI463WuvxYG4ctKx8th+
 b6ORHvp6K9CfmGrutvhv84SIym1fW7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761127081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdR79QtlxlSKeE83YnlNYiMweCpEt+zw/UV2GGRlJIM=;
 b=Vuu8PZjgqz1Cziys08oCRM2zGjZVAyP5rssQs1TWxwCF/Oti5HZyiVOxRAM+QHxBuyeH1I
 7z7fHV5lbUmOP0AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TYhxroxc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3lSWeMF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761127077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdR79QtlxlSKeE83YnlNYiMweCpEt+zw/UV2GGRlJIM=;
 b=TYhxroxc8lOsGQGw8UTThB/As4745H4WnSM+oiLSmVrk8YptCkFkU5CDdjyObhJAIb/QWm
 DGxCRq/oYeZ9RkuPVGXucqXToPj+vR9ECEDvB3960h1HzTz5WcGhmPStf9kOo88Nj3OBgm
 B0o5N391ESFCRFoTAG2/QISY3+hz1TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761127077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdR79QtlxlSKeE83YnlNYiMweCpEt+zw/UV2GGRlJIM=;
 b=3lSWeMF62Ui9KinURail2Ym/ovgrxVF0bZ7UaGme5GqRqlZxnfSjKu7NQ4RBlZ8CwyAly1
 IZGHdTk5AajfIkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B26E813AAD
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 09:57:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +DdeK6Wq+GjDIgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 09:57:57 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Oct 2025 11:57:38 +0200
Message-ID: <20251022095740.8747-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022095740.8747-1-mdoucha@suse.cz>
References: <20251022095740.8747-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C7CB91F461
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ioctl_sg01: Print buffer contents on failure
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

This patch is a convenience feature. Feel free to reject it.

 testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 24 +++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
index 66ff980ce..dada174e0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
@@ -36,7 +36,7 @@
 #define CMD_SIZE 6
 
 static int devfd = -1;
-static char buffer[BUF_SIZE];
+static char buffer[BUF_SIZE + 1];
 static unsigned char command[CMD_SIZE];
 static struct sg_io_hdr query;
 
@@ -100,6 +100,25 @@ static const char *find_generic_scsi_device(int access_flags, int skip_usb)
 	return NULL;
 }
 
+static void dump_hex(const char *str, size_t size)
+{
+	size_t i;
+
+	for (; size && !str[size - 1]; size--)
+		;
+
+	for (i = 0; i < size; i++) {
+		if (i && (i % 32) == 0)
+			printf("\n");
+		else if (i && (i % 4) == 0)
+			printf(" ");
+
+		printf("%02x", (unsigned int)str[i]);
+	}
+
+	printf("\n");
+}
+
 static void setup(void)
 {
 	const char *devpath = find_generic_scsi_device(O_RDONLY, 1);
@@ -135,6 +154,7 @@ static void run(void)
 
 	for (i = 0; i < 100; i++) {
 		TEST(ioctl(devfd, SG_IO, &query));
+		buffer[BUF_SIZE] = '\0';
 
 		if (TST_RET != 0 && TST_RET != -1)
 			tst_brk(TBROK|TTERRNO, "Invalid ioctl() return value");
@@ -143,6 +163,8 @@ static void run(void)
 		for (j = 0; j < BUF_SIZE; j++) {
 			if (buffer[j]) {
 				tst_res(TFAIL, "Kernel memory leaked");
+				tst_res(TINFO, "Buffer contents: %s", buffer);
+				dump_hex(buffer, BUF_SIZE);
 				return;
 			}
 		}
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
