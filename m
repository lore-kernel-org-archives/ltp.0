Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140AE10D14A8
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 12:10:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59B533E54ED
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 14:10:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BEF63C5410
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 14:10:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 785401A009B4
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 14:10:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 971785BD39;
 Mon, 30 Mar 2026 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774872632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKMOGeGNnujog0/+eLmcJm3jCGBLN4fT77l//Fctt7Q=;
 b=E+841L3zVhW727i2HY+xpNwQRoIo3YQhAvrZn8V6n1vHkTwtuPCUZT9Xjy7zRNRCeMwhj/
 iNQr8qy/frtRInaoj00bEWgSiWvkS1DAe31Z55pNeurql5RpKC9KYiw64Ly1/P3vHoXmZb
 ttiH9ikjNbh0FUDfSVONeOPAX358/7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774872632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKMOGeGNnujog0/+eLmcJm3jCGBLN4fT77l//Fctt7Q=;
 b=7UES7K7wTU3ZXNOi3fzQj3v5bhc0kedoYY46AIQ4C/lzXzeUv7MM7Qe6eaDuPrFSnuME9C
 w397tXfPSarRNHDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774872632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKMOGeGNnujog0/+eLmcJm3jCGBLN4fT77l//Fctt7Q=;
 b=E+841L3zVhW727i2HY+xpNwQRoIo3YQhAvrZn8V6n1vHkTwtuPCUZT9Xjy7zRNRCeMwhj/
 iNQr8qy/frtRInaoj00bEWgSiWvkS1DAe31Z55pNeurql5RpKC9KYiw64Ly1/P3vHoXmZb
 ttiH9ikjNbh0FUDfSVONeOPAX358/7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774872632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKMOGeGNnujog0/+eLmcJm3jCGBLN4fT77l//Fctt7Q=;
 b=7UES7K7wTU3ZXNOi3fzQj3v5bhc0kedoYY46AIQ4C/lzXzeUv7MM7Qe6eaDuPrFSnuME9C
 w397tXfPSarRNHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C2324A0A2;
 Mon, 30 Mar 2026 12:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e3+gHDhoymlfSgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 30 Mar 2026 12:10:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 30 Mar 2026 14:10:32 +0200
MIME-Version: 1.0
Message-Id: <20260330-kirk_4-1-0-v1-1-bc4fd68edaf1@suse.com>
X-B4-Tracking: v=1; b=H4sIADdoymkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY2MD3ezMoux4E11DXQNdAwMTc3NTi+SUNENDJaCGgqLUtMwKsGHRsbW
 1AM470ipcAAAA
X-Change-ID: 20260330-kirk_4-1-0-0047758cdf11
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774872632; l=949;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=SoNqAdHXCVRqlPpdwpMXW24YU5aRN+Dkz+6a241Z660=;
 b=4T9k54FralAqXX2bRgEmLtKmPEOY/YRtkM0U3n1VGGE8Oi5iPFXvbeGYvmDuIQ3esD8qO0dfr
 GiI9ZRzUXFACGF4csnwFA7SyphH6I/lf/ayfBx/RgcKvhK2dHM8aatl
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kirk: upgrade version to 4.1.0
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

- ltp: support network tests configurations by @acerv in #95
- ltp: Remove unused PASSWD, RUSER variables by @pevik in #96
- monitor: fix mismatch between event and its name
- minor fixes and code stabilization

Link: https://github.com/linux-test-project/kirk/releases/tag/v4.1.0
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 tools/kirk/kirk-src | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
index 6b0f87c6df90b87a8c32648c94169a83b4e58024..7d4234c4305ab8b7b4ec27e911798b5e7f65ef88 160000
--- a/tools/kirk/kirk-src
+++ b/tools/kirk/kirk-src
@@ -1 +1 @@
-Subproject commit 6b0f87c6df90b87a8c32648c94169a83b4e58024
+Subproject commit 7d4234c4305ab8b7b4ec27e911798b5e7f65ef88

---
base-commit: 4688c20c01eece869b59e05ca3dd68c43e0d6af7
change-id: 20260330-kirk_4-1-0-0047758cdf11

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
