Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12A7C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 16:01:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA6993CA14D
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 17:01:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32C5C3C9ABC
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 17:00:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F5C114044BA
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 17:00:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A64F219AA;
 Fri, 18 Feb 2022 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645200051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tVCvCY71mtpRLi7Rpzu1pu9VFCXB03iU3U0fD8bjQW8=;
 b=uojZqXFOYChcCvU4AzzfE5AxwhJhOdv0Ct0IEfVak5d/nTegGZcGQm02z11csO4VooK4ZB
 3FzpBASjR7QQCtNl0vOs1iroSbVWQKlbjKC2xa4V13LQrQCJRfCl2Voe6Y8qav+dJHPI2m
 0gwOdYV/U3Xhrp8LBePR43EO+8qWQic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645200051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tVCvCY71mtpRLi7Rpzu1pu9VFCXB03iU3U0fD8bjQW8=;
 b=SYZdfWWMzMxVlneGdAjsFYOHdd0S95oXgHoUs21MWkyGDymH7Lr8ASUEs56kvHGMFt6zVj
 HtYScvopkWnZeqBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E622A13C9C;
 Fri, 18 Feb 2022 16:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I74QNbLCD2LIMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 16:00:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 18 Feb 2022 17:00:35 +0100
Message-Id: <20220218160035.4121-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] netstress: Workaround race between SETSID() and
 exit(0)
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There is a race between the SETSID() and exit(0) in move_to_background()
caused by "Killed the leftover descendant processes" introduced in
72b172867 ("Terminate leftover subprocesses when main test process
crashes").

If the main test process calls exit(0) before the newly forked child
managed to do SETSID() it's killed by the test library because it's
still in the old process group. Therefore kill mask SIGUSR1 with dummy
handler to avoid heartbeat_handler() doing the cleanup.

Link: https://lore.kernel.org/ltp/Yg+RXbUTOxK56iZa@pevik/

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/netstress/netstress.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 0914c65bd4..51daa72c6d 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -38,6 +38,10 @@ static int rand_r(LTP_ATTRIBUTE_UNUSED unsigned int *seed)
 }
 #endif
 
+static void sig_handler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+}
+
 static const int max_msg_len = (1 << 16) - 1;
 static const int min_msg_len = 5;
 
@@ -713,11 +717,15 @@ static void server_cleanup(void)
 
 static void move_to_background(void)
 {
-	if (SAFE_FORK())
+	if (SAFE_FORK()) {
+		pause();
 		exit(0);
+	}
 
 	SAFE_SETSID();
 
+	SAFE_KILL(getppid(), SIGUSR1);
+
 	close(STDIN_FILENO);
 	SAFE_OPEN("/dev/null", O_RDONLY);
 	close(STDOUT_FILENO);
@@ -843,6 +851,8 @@ static void set_protocol_type(void)
 
 static void setup(void)
 {
+	SAFE_SIGNAL(SIGUSR1, sig_handler);
+
 	if (tst_parse_int(aarg, &clients_num, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid client number '%s'", aarg);
 	if (tst_parse_int(rarg, &client_max_requests, 1, INT_MAX))
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
