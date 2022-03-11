Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D88CC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 09:48:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E1963C8CAB
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 10:48:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04D373C0653
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 10:48:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5E4A61A01116
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 10:48:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BF2C218FB
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646992123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7fiqCMQ3Z9D43ZH0k+4IxHonS7NiTCK6bIeZrkRfqbI=;
 b=WVwIT0dSjE/gUyOBWg11CrEf/s0J/LC6DvsEdvPtmVksGFQd8AnItApjwObUQz82J2ji+e
 QjjzKBL7GFIkSeYHC9wwsoKbOF0FqvRyCYMTIwyMFoJXK4wIBcnnULXAYz2RLl5e9HNLVa
 JwKNo5g5pcaSPwgutpc5EDUN2G/EhnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646992123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7fiqCMQ3Z9D43ZH0k+4IxHonS7NiTCK6bIeZrkRfqbI=;
 b=YRcv0nWghYTkeNP4oHJz6PfUabekjRp1JOZ84AX7QtXiMka1AgR35N0lqurXeN2ewhS3s9
 f8WL2INZYZ8V6MBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27FD813A82
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 09:48:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SHu/CPsaK2KmYAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 09:48:43 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Mar 2022 10:51:01 +0100
Message-Id: <20220311095101.10112-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pty/pty07: Restore active console after the testrun
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

The test, as a side effect, switches to a different console during the
run, which may confuse both users and automated test systems.

Fix that by saving the console active at the start of the test and
restore it in the test cleanup.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/pty/pty07.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/pty/pty07.c b/testcases/kernel/pty/pty07.c
index 462569c4a..af2dccb32 100644
--- a/testcases/kernel/pty/pty07.c
+++ b/testcases/kernel/pty/pty07.c
@@ -40,6 +40,8 @@ static int test_tty_port = 8;
 static int fd = -1;
 static struct tst_fzsync_pair fzp;
 
+static unsigned short vt_active;
+
 static void *open_close(void *unused)
 {
 	int i;
@@ -76,16 +78,27 @@ static void do_test(void)
 
 static void setup(void)
 {
+	struct vt_stat stat;
+
 	sprintf(tty_path, "/dev/tty%d", test_tty_port);
 	fd = SAFE_OPEN(tty_path, O_RDWR);
+	SAFE_IOCTL(fd, VT_GETSTATE, &stat);
+	vt_active = stat.v_active;
+
+	tst_res(TINFO, "Saving active console %i", vt_active);
+
 	tst_fzsync_pair_init(&fzp);
 }
 
 static void cleanup(void)
 {
-	tst_fzsync_pair_cleanup(&fzp);
-	if (fd >= 0)
+	if (fd >= 0) {
+		tst_res(TINFO, "Restoring active console");
+		SAFE_IOCTL(fd, VT_ACTIVATE, vt_active);
 		SAFE_CLOSE(fd);
+	}
+
+	tst_fzsync_pair_cleanup(&fzp);
 }
 
 static struct tst_test test = {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
