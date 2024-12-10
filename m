Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44087E77180
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 14:13:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B11CD3E8E2E
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 15:13:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75B9B3E8D7E
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 15:13:34 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D71CF1B621B3
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 15:13:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20ACA1F441
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733840013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GjFOep+TB6F3Ir0ZBfx8Gc5+GDdd4U3721h6pN6qFtI=;
 b=uRVNb9IlnByHTSfWwDc/kSsLcfYMJfDGJexwn2hK8bs/FSks/m8RlnSXzRieEbNZEziYPF
 gJcZvhn3rRHzrCG0FVesL+t7Go/OQbP8LqD1v6icFynUhYFFNjj+DzqEck4+MME6YfnfQt
 COtI+EmePCt78RQtK7ShJoUevupfOfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733840013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GjFOep+TB6F3Ir0ZBfx8Gc5+GDdd4U3721h6pN6qFtI=;
 b=mZzMyzs23JxdZ4ytxV7PvyaJjR7dFCdwPSr+4mLsHywoWfaLUfeApgTUPZ7Kg4Zs1PDKOu
 r9+B47Xs/Ij8mcDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733840013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GjFOep+TB6F3Ir0ZBfx8Gc5+GDdd4U3721h6pN6qFtI=;
 b=uRVNb9IlnByHTSfWwDc/kSsLcfYMJfDGJexwn2hK8bs/FSks/m8RlnSXzRieEbNZEziYPF
 gJcZvhn3rRHzrCG0FVesL+t7Go/OQbP8LqD1v6icFynUhYFFNjj+DzqEck4+MME6YfnfQt
 COtI+EmePCt78RQtK7ShJoUevupfOfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733840013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GjFOep+TB6F3Ir0ZBfx8Gc5+GDdd4U3721h6pN6qFtI=;
 b=mZzMyzs23JxdZ4ytxV7PvyaJjR7dFCdwPSr+4mLsHywoWfaLUfeApgTUPZ7Kg4Zs1PDKOu
 r9+B47Xs/Ij8mcDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18E8E13A15
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 14:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rGRNBY1MWGeKEAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 14:13:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 10 Dec 2024 15:13:27 +0100
MIME-Version: 1.0
Message-Id: <20241210-fix_input_suite-v1-1-f8bb1d80d2fc@suse.com>
X-B4-Tracking: v=1; b=H4sIAIZMWGcC/x2MWwqAIBAAryL7naCLBXWViBDban9MfEQg3T3pc
 2BmKiSKTAkmUSHSzYkv30B3Atxp/UGSt8aACo1GreTOz8o+lLymwplk70aHvRmstQitCpGa8h/
 n5X0/NaTLVmEAAAA=
X-Change-ID: 20241210-fix_input_suite-5c9c2546aaa2
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733840013; l=4645;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=fCTtITtnYc4FWMZebOZJYqFPGADCT2EN66wu2Rk+aMY=;
 b=N4onqWtfYCLlWXcg3SQGumc2zKVbvpM1nJx0THhKcsd8R855ydz6vd0kiBfxbVcnmeTzCSmdK
 czUIad5uFAfAuanXw0dCxXeDagv3O5g1kzhTdTXvDCrYFgEYSwfTvnS
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Verify virtual device availability
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Virtual device is supposed to be found in /dev/uinput or
/dev/input/uinput, but in some cases this is not true. For instance, a
kernel which is not exposing any virtual device. This patch is meant to
verify that the device is available and we eventually skip test if it's
not found.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Just skip tests which cannot find any virtual device in the current
system.
---
 testcases/kernel/input/input01.c    | 3 +++
 testcases/kernel/input/input02.c    | 3 +++
 testcases/kernel/input/input03.c    | 2 ++
 testcases/kernel/input/input04.c    | 3 +++
 testcases/kernel/input/input05.c    | 3 +++
 testcases/kernel/input/input06.c    | 2 ++
 testcases/kernel/uevents/uevent03.c | 3 +++
 7 files changed, 19 insertions(+)

diff --git a/testcases/kernel/input/input01.c b/testcases/kernel/input/input01.c
index 0872204111b81fd19a1525ef7f099e8ddead9658..5e85133028e25ea4a4596475f9aa876cb913694d 100644
--- a/testcases/kernel/input/input01.c
+++ b/testcases/kernel/input/input01.c
@@ -53,6 +53,9 @@ static void run(void)
 static void setup(void)
 {
 	fd_send = open_uinput();
+	if (fd_send == -1)
+		tst_brk(TCONF, "Virtual device is not available");
+
 	setup_mouse_events(fd_send);
 	create_input_device(fd_send);
 
diff --git a/testcases/kernel/input/input02.c b/testcases/kernel/input/input02.c
index eeff54ed21cbff6eac2d90dc53c6447d379e29ed..8e48f12d9a1108c9a5b1d8452e07386d5534fbfb 100644
--- a/testcases/kernel/input/input02.c
+++ b/testcases/kernel/input/input02.c
@@ -53,6 +53,9 @@ static void run(void)
 static void setup(void)
 {
 	fd_send = open_uinput();
+	if (fd_send == -1)
+		tst_brk(TCONF, "Virtual device is not available");
+
 	setup_mouse_events(fd_send);
 	create_input_device(fd_send);
 
diff --git a/testcases/kernel/input/input03.c b/testcases/kernel/input/input03.c
index 4a3eb464ee0322b134f44158a08dbb4ed000216f..2e6161beefccc1133b654be8cf2529e97610960f 100644
--- a/testcases/kernel/input/input03.c
+++ b/testcases/kernel/input/input03.c
@@ -82,6 +82,8 @@ static void run(void)
 static void setup(void)
 {
 	fd_send = open_uinput();
+	if (fd_send == -1)
+		tst_brk(TCONF, "Virtual device is not available");
 
 	setup_mouse_events(fd_send);
 	SAFE_IOCTL(fd_send, UI_SET_EVBIT, EV_KEY);
diff --git a/testcases/kernel/input/input04.c b/testcases/kernel/input/input04.c
index 3c76d7c82ad7fe76f35f5a4ecfc78f27069d3fa0..fb13500fe6ab5eba7fed4640ed51dfbc8105cd09 100644
--- a/testcases/kernel/input/input04.c
+++ b/testcases/kernel/input/input04.c
@@ -33,6 +33,9 @@ static void run(void)
 static void setup(void)
 {
 	fd_send = open_uinput();
+	if (fd_send == -1)
+		tst_brk(TCONF, "Virtual device is not available");
+
 	setup_mouse_events(fd_send);
 	create_input_device(fd_send);
 
diff --git a/testcases/kernel/input/input05.c b/testcases/kernel/input/input05.c
index 4e5072a038ea8e4f7b8e0899d88a58bdf18e9e94..fa37ac7acb22b690b7bb35d9fe655d3e49532a61 100644
--- a/testcases/kernel/input/input05.c
+++ b/testcases/kernel/input/input05.c
@@ -38,6 +38,9 @@ static void run(void)
 static void setup(void)
 {
 	fd_send = open_uinput();
+	if (fd_send == -1)
+		tst_brk(TCONF, "Virtual device is not available");
+
 	SAFE_IOCTL(fd_send, UI_SET_EVBIT, EV_KEY);
 	SAFE_IOCTL(fd_send, UI_SET_KEYBIT, BTN_LEFT);
 	create_input_device(fd_send);
diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
index cb871cbaec0fc8e35182dc0256dc2672dae4a419..d3584a2b0b9f540b29def3d98b7c77db09faefe9 100644
--- a/testcases/kernel/input/input06.c
+++ b/testcases/kernel/input/input06.c
@@ -178,6 +178,8 @@ static void run(void)
 static void setup(void)
 {
 	fd_send = open_uinput();
+	if (fd_send == -1)
+		tst_brk(TCONF, "Virtual device is not available");
 
 	SAFE_IOCTL(fd_send, UI_SET_EVBIT, EV_KEY);
 	SAFE_IOCTL(fd_send, UI_SET_EVBIT, EV_REP);
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index 5b3dd701f0cf8f2f12a910b57d5f49d58712fe52..f7072db1c5f076e811e473438db3aa895644eaec 100644
--- a/testcases/kernel/uevents/uevent03.c
+++ b/testcases/kernel/uevents/uevent03.c
@@ -27,6 +27,9 @@ static int mouse_fd;
 static void create_uinput_mouse(void)
 {
 	mouse_fd = open_uinput();
+	if (mouse_fd == -1)
+		tst_brk(TCONF, "Virtual device is not available");
+
 	setup_mouse_events(mouse_fd);
 	create_input_device(mouse_fd);
 }

---
base-commit: b5e2ea3cc02a2466c5bee3b0e650869f4ddf438c
change-id: 20241210-fix_input_suite-5c9c2546aaa2

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
