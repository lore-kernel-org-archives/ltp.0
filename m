Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FECEFB7F9
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 07:53:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 665973D0F7C
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:53:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C7E83C02F2
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 08:53:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C0E322001A0
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 08:53:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E8A573F0E1;
 Tue, 24 Feb 2026 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771919614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aRK7axrQpplI6bdzwlTQxHxqagZ5yAwoDS3nctTQY/4=;
 b=wd3yoaVpmTrGxoPPDhMUwJDU5G2was/58RbsCsXRygYa/Pb9o1FHjoJ4U/BnYyHywp4XMN
 V/7I+edkJ1CdgCLS+Bsx0THZYVwmfzvHd3rhXPcbTpoO+kEs/D+5fm5mWtIS4tPETuNqoO
 km+AOFsXWd4xOkWDsdkrMztICK8/nYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771919614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aRK7axrQpplI6bdzwlTQxHxqagZ5yAwoDS3nctTQY/4=;
 b=BxTCrnnnefqjbj4vbrhDVAq7M8jF2VgaquZepT+3TaIHE4fHP32cEoJsaK1rqHA0EWFEkG
 3ryY5WyoqPIFJmBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771919613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aRK7axrQpplI6bdzwlTQxHxqagZ5yAwoDS3nctTQY/4=;
 b=ocYvJHFR8OmUz2f/BHuoPtJV/rktWy3ie0CMx5a5R90NnAOn2t/cluw5I8+oOoCYCa/j6X
 ZK7DfoQzovZOY9VTQpE0lJ7ALGHvUKMFqpWnVt9Zfg5ybT7uY9XMcq4OQ0lDVwfeIr+k+7
 RkRFh9repsIu8lOIvdwfluq2E1D01/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771919613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aRK7axrQpplI6bdzwlTQxHxqagZ5yAwoDS3nctTQY/4=;
 b=wnR+y2OGTbz7f8fEK3RhoI8F3C1vSmdg7nTkwUxtgIxlDsraOqHXeaKEVO5En22d8cWyOX
 x2j9ME2pC1nzxTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1DEF3EA68;
 Tue, 24 Feb 2026 07:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XPSfLf1YnWn1HgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 24 Feb 2026 07:53:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 24 Feb 2026 08:53:33 +0100
MIME-Version: 1.0
Message-Id: <20260224-kirk_4-v1-1-6f706363fc4d@suse.com>
X-B4-Tracking: v=1; b=H4sIAPxYnWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMT3ezMoux4E93UJIsk80RDk1SLZCMloOKCotS0zAqwQdGxtbUAzVB
 1QlgAAAA=
X-Change-ID: 20260224-kirk_4-eb8b7a14e8c2
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771919613; l=899;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ezMTqrBdTAf2lwYmIaQauvM58U4KSG9AzZYX/78RQdI=;
 b=LzhmCJ72DNZOQ1thN4Y2VlwunY4zehNmi3xGV+EP/jyewwnObuMXrPoHdGyGc9g7Uc31S/d4W
 EmGIcZNjvAaBN79keyr3kR8UG+5CzwOVPeqTZHGCMVB4I91BUAY4xXN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kirk: version 4.0.0
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

- Remove --env option
- pyproject: include sub-packages in pip package
- libkirk: Print /proc/cmdline
- ui: simplify repor
- many bugs fixes and code optimizations

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Link: https://github.com/linux-test-project/kirk/releases/tag/v4.0.0
---
 tools/kirk/kirk-src | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
index 6ac2644e6e469b7bc7ddf35a6b10bf1994ca0929..6b0f87c6df90b87a8c32648c94169a83b4e58024 160000
--- a/tools/kirk/kirk-src
+++ b/tools/kirk/kirk-src
@@ -1 +1 @@
-Subproject commit 6ac2644e6e469b7bc7ddf35a6b10bf1994ca0929
+Subproject commit 6b0f87c6df90b87a8c32648c94169a83b4e58024

---
base-commit: f062b34785db121c841f2faed8233b0943cdff27
change-id: 20260224-kirk_4-eb8b7a14e8c2

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
