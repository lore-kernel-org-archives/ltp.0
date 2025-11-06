Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915EBCCFA05
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 16:36:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14BCF3CED7C
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 17:36:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8D8B3CED7C
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F897600D23
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB9EB21200;
 Thu,  6 Nov 2025 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1FHQGR3F9MFQLccxKUCwpWboC8X/2lZTVu16/mztTA=;
 b=uvJBEgRxh8sIkltesZ5QWUN1RP1p8ieykVI+oTo45lbO2MSnWc+9grkIt7nSasXDqmqCoF
 w9m+qFeIopNM7SCc+ybTUtqWA9ebF+EqSotpoeE8sEK6D+4JL8ReddV+833U5sUCHyC0kZ
 uXs/NoMomi3nzrhebUOMIXKZ31laYek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1FHQGR3F9MFQLccxKUCwpWboC8X/2lZTVu16/mztTA=;
 b=h4cknWIN1L8h7i9fjfv8IoeLwXie510BVqdWArhIXnMMYyo6j9D7w9+13RA3vtRmoH1GrZ
 AI6oRm/sU9mZ7RDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1FHQGR3F9MFQLccxKUCwpWboC8X/2lZTVu16/mztTA=;
 b=iEdq1jyBAxqFUhE8t9NBJe9kkgdb3Pcw61A3Y5tipXFnodWhsK+UbK3TlRGwSouJ0xQtbC
 IsilcQzd1NMpwNe2plMSY8deE5OdSGNQm9Ck5Qb9hZgpbUfEpaWLKFKT6uEKAvHUVEeNpe
 EMgRc69rqzWJq4MOo9yomCN6zyFs0Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1FHQGR3F9MFQLccxKUCwpWboC8X/2lZTVu16/mztTA=;
 b=lrgamMCZYtfU0HxUSlW8gFLvgcZ8MA7jsDIqb1T3P1DWYl9fkHDMl3Da23j2sSr0YXZJ10
 jnMikMCYKiBduiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CDEE13A4B;
 Thu,  6 Nov 2025 16:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UAosJDvODGkHRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Nov 2025 16:35:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Nov 2025 17:35:00 +0100
Message-ID: <20251106163500.1063704-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106163500.1063704-1-pvorel@suse.cz>
References: <20251106163500.1063704-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/5] swapon03: Remove grep dependency
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

Instead of relying on 'grep' run via system() parse output with C
implementation (faster, no dependency).

Also rename swap file to make sure it's more obvious that it was created
by LTP.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

 testcases/kernel/syscalls/swapon/swapon03.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index a8e0cbcdc6..91d797871f 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -31,9 +31,10 @@
 #define NUM_SWAP_FILES 15
 
 #define MNTPOINT	"mntpoint"
-#define TEST_FILE	MNTPOINT"/testswap"
+#define TEST_FILE	MNTPOINT "/LTP_" __FILE__ "_testswap"
 
 static int *swapfiles;
+static char *tmpdir;
 
 static void setup_swap(void)
 {
@@ -85,12 +86,14 @@ static void setup_swap(void)
  */
 static void check_and_swapoff(const char *filename)
 {
-	char cmd_buffer[256];
+	char buf[256];
+	int foo;
 
-	snprintf(cmd_buffer, sizeof(cmd_buffer), "grep -q '%s.*file' /proc/swaps", filename);
-
-	if (system(cmd_buffer) == 0 && swapoff(filename) != 0)
-		tst_res(TWARN, "Failed to swapoff %s", filename);
+	snprintf(buf, sizeof(buf), "%s/%s %%*s %%*s %%*s %%s", tmpdir, filename);
+	if (!FILE_LINES_SCANF("/proc/swaps", buf, &foo)) {
+		if (swapoff(filename) != 0)
+			tst_res(TWARN | TERRNO, "swapoff(%s) failed", filename);
+	}
 }
 
 /*
@@ -121,6 +124,8 @@ static void setup(void)
 
 	is_swap_supported(TEST_FILE);
 
+	tmpdir = tst_tmpdir_path();
+
 	swapfiles = SAFE_MMAP(NULL, sizeof(*swapfiles), PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 	*swapfiles = 0;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
