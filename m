Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4623AC0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 11:08:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7C493CCBF2
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 13:08:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C663D3CB558
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:08:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1CD9E600A71
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:08:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 506E81FF56;
 Wed, 25 Oct 2023 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698232117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5iqANA7h+FyPdZQ/ZR+TzFpDhrqcGnVPWsjYqfoxAaM=;
 b=dAyZnh/TkTExEQHWKzQIl1Qka7OVjDDZD/aPLHJnqrR6HrayntpUZXDwDHf27ACdEMTVqM
 Iu6jSj70fm9pV4OBdhwpwQUKLvCt/AG/kouTMyOsUKtbxol/8roMQgefB4YhKiyagDtzdq
 7yLeGnqjCRlwEYyxnppuWOD4qI4SCzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698232117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5iqANA7h+FyPdZQ/ZR+TzFpDhrqcGnVPWsjYqfoxAaM=;
 b=UyyfeU7U48PPHfgOo+jlwfjAk+dzZK2QY2iyafNwxBDgFVPEtjBbkDZ+kZhQg23cQKYV1e
 y9ycoOauK2PrLiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B0B113524;
 Wed, 25 Oct 2023 11:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uOOIDTX3OGUVUgAAMHmgww
 (envelope-from <mkittler@suse.de>); Wed, 25 Oct 2023 11:08:37 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 13:08:33 +0200
Message-ID: <20231025110835.28832-3-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025110835.28832-1-mkittler@suse.de>
References: <20231025110835.28832-1-mkittler@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.99%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/4] Make checks for termio flags more strict
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

The checks for termio flags can actually use a `!=` check to
also fail when any unexpected flags are present.

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl02.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 23a52151b..cfc081e9c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -157,24 +157,21 @@ static void chk_tty_parms(void)
 		}
 	}
 
-	if (!
-	    (termio.c_lflag
-	     && (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
+	if (termio.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
+		 | NOFLSH)) {
 		tst_res(TFAIL, "lflag has incorrect value. %o",
 			 termio.c_lflag);
 		flag++;
 	}
 
-	if (!
-	    (termio.c_iflag
-	     && (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
-		 | IXOFF))) {
+	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
+		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
 		tst_res(TFAIL, "iflag has incorrect value. %o",
 			 termio.c_iflag);
 		flag++;
 	}
 
-	if (!(termio.c_oflag && (OPOST | OLCUC | ONLCR | ONOCR))) {
+	if (termio.c_oflag != (OPOST | OLCUC | ONLCR | ONOCR)) {
 		tst_res(TFAIL, "oflag has incorrect value. %o",
 			 termio.c_oflag);
 		flag++;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
