Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624B5CD98EA
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 16:09:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98AF83CFFF1
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 18:09:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B0683CD4E1
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:08:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8028B1BB9C11
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:08:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9316121889;
 Wed, 11 Oct 2023 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697040506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GzzLN5JYWRFDDf3PY5ZQ1IG8F/WSR3hCBhnAeTuBHXw=;
 b=PEglNJX30GQNl9K8dpN5uNWoUGIIMuRvzJkaW5NpQ6MvZ5nTp22MKQ/pMIIVjiL4eBaMRm
 afQMbZ3qYZuMOCaQKvvwRjifChBUTlusg37+VPd0LViRNLRNOk/Mpmf4gDQG72+9bl8Nth
 eE1g8U2h7+/L8aphl8QMP7oGrZow67s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697040506;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GzzLN5JYWRFDDf3PY5ZQ1IG8F/WSR3hCBhnAeTuBHXw=;
 b=vRGseK3JLoB9dKxJH3WNSdlvABhQUq5OHsJPNagsVvXdqpAP4gVRdoELmWXBWBkE0xCR7z
 xBits/uANA3aSuAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6818313A7A;
 Wed, 11 Oct 2023 16:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MJAnGHrIJmVVIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 11 Oct 2023 16:08:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 18:08:22 +0200
Message-ID: <20231011160822.578637-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011160822.578637-1-pvorel@suse.cz>
References: <20231011160822.578637-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[13.98%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] libltpswap: TCONF on EPERM
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Although tests, which use tst_fibmap() should use .needs_root = 1
to avoid EPERM, let's add a sanity check in case it's not used.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 libs/libltpswap/libswap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index a4427736f..4ef24ef5c 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -53,10 +53,14 @@ void is_swap_supported(const char *filename)
 
 	TEST(tst_syscall(__NR_swapon, filename, 0));
 	if (TST_RET == -1) {
-		if (fibmap == 1 && errno == EINVAL)
-			tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
-		else
+		if (fibmap == 1) {
+			if (errno == EINVAL)
+				tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
+			if (errno == EPERM)
+				tst_brk(TCONF, "No permission for swapon() on %s", fstype);
+		} else {
 			tst_brk(TFAIL | TTERRNO, "swapon on %s failed", fstype);
+		}
 	}
 
 	TEST(tst_syscall(__NR_swapoff, filename, 0));
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
