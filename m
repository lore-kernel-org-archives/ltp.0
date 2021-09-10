Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B34C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:09:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7294E61153
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 13:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7294E61153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 098CC3C8C6F
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 15:09:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D76F3C8C74
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C4C131A0115E
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 15:08:30 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 74B3A20218;
 Fri, 10 Sep 2021 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631279310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LzlYApoRywjdk4j+dQfprpLu6F/4ms/bWpTWfgeo9w=;
 b=ZTL7b0Vr4xOzBJJa+ycSa8zuAfCa9Q+vIsP2xeX7fPPgHHCDiTDF9SL4rSLxZCaRtTENo6
 uLZI6Int6MnU1ORjMZHB2iISYC1oX/DCO2KwVE34HfSG49KiSPCtNvWa2QtM+z/Aw2Wmvh
 NdgaPx/e39RykwTPXFBgg5Hu3TJ46Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631279310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LzlYApoRywjdk4j+dQfprpLu6F/4ms/bWpTWfgeo9w=;
 b=Oa6Y3vhpYZ1YyB17lCUGliyPk5pphIUNdcq+0CmNCz7rH2OKJZKbWBKMNuF96f14ldiJD/
 DPVv3FQz0+OgaFAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4772F133D0;
 Fri, 10 Sep 2021 13:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id cFgtD85YO2HKdAAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 10 Sep 2021 13:08:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Sep 2021 15:08:20 +0200
Message-ID: <20210910130820.21141-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/7] sched/process.c: Remove useless TRUE FALSE
 definitions
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
Message-ID: <20210910130820.83lv5KnxyJdeMOhLI-Xs4UFSApz6OlcBK_pFVIAd_Is@z>

FALSE is not used at all and replace TRUE with 1 (there is no point
trying to use true from <stdbool.h> just for while).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/sched/process_stress/process.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index b66908e7a..9075305e1 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -46,13 +46,6 @@
 #define MAXBVAL 70
 #define MAXDVAL 11
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 #ifdef DEBUG
 #define prtln()	printf("At line number: %d\n", __LINE__); \
 		fflush(NULL)
@@ -200,7 +193,7 @@ int send_message(int id, mtyp_t type, char *text)
 
 	strcpy(sndbuf.mtext, text);
 	sndbuf.mtyp = type;
-	while (TRUE) {
+	while (1) {
 		rc = msgsnd(id, &sndbuf, sizeof(struct messagebuf), IPC_NOWAIT);
 		if (rc == -1 && errno == EAGAIN) {
 			debugout("msgqueue %d of mtyp %d not ready to send\n",
@@ -992,7 +985,7 @@ void messenger(void)
 	 *  Infinite loop used to receive error messages from children and
 	 *  to terminate process tree.
 	 */
-	while (TRUE) {
+	while (1) {
 		rc = msgrcv(msgerr, &rcvbuf, sizeof(struct messagebuf), 0, 0);
 		if (rc == -1) {
 			switch (errno) {
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
