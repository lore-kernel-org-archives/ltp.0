Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AA5C001DF
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 09:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B00E3CEF38
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:19:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DF6A3C9983
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:19:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66D5B1A00814
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:19:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 080DB2045D;
 Tue,  4 Jul 2023 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688462388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apVsjnglWU6Ma0XklSV+/ZrryEU9YtLoq7seiWm31Wo=;
 b=OmiVa5rza9VYRFT8uzSAyMtbhZip1nEoDsVyIa7Uos4q02t8MdAIejXpaiLdVa1z6DL+E/
 nfE4a9BJR17Hl92EANwdlYLe13vgwiKUiwnQSlbgp39bb+T/CqCTfkTIQUX4TKj+O6UCRp
 sAVwIUVtduyb3gC3LaXb4rp28w9weio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688462388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apVsjnglWU6Ma0XklSV+/ZrryEU9YtLoq7seiWm31Wo=;
 b=Q++ZncTQ/eJ7iiHJhQZg6tdh69wpSpYx37cvHF4q213mDX/adlkskdBIiYoUTBNKcEpDgV
 sGrVAJUBhlGqZ1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2D1D133F7;
 Tue,  4 Jul 2023 09:19:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QF9qMjPko2SLSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 09:19:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  4 Jul 2023 11:19:33 +0200
Message-Id: <20230704091933.496989-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704091933.496989-1-pvorel@suse.cz>
References: <20230704091933.496989-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 3/3] lib/C-API: Print LTP version at test start
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

Although -V option for printing version was added in previous commit,
having a way to always print LTP version at the beginning of the test
(makes debugging of troubleshooting reported issues even easier).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index e81a3d036..c93ef6aac 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1677,6 +1677,8 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
+	tst_res(TINFO, LTP_VERSION);
+
 	if (tst_test->max_runtime)
 		results->max_runtime = multiply_runtime(tst_test->max_runtime);
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
