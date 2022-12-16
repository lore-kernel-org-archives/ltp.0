Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1BBC4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 09:46:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E533F3CBC11
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 10:46:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB0033CBC0A
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 10:46:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C0C31A00651
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 10:46:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A674533E65;
 Fri, 16 Dec 2022 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671183976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEkFvApWlYB5zGz1IXUfMGre8zkzsnTlcFQs26AK1+E=;
 b=rQ66/Opo4AYsX3zPkJMwVY+T6o9iZ3y2p7VzfuMeLMZuPalxmvizD+8RgTMFQO2c84a0QP
 OxxJl/eNbzqXICZVHbnJeG+lEFEjAe6vnEap5taCSw6d4vYHAZiJ0cxLLIkN8AEIpHooci
 iRNBfar+HHZSyVTlXne4JAjwPHAKE+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671183976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEkFvApWlYB5zGz1IXUfMGre8zkzsnTlcFQs26AK1+E=;
 b=HTPV3n3Hf/bHQMBYD0jT/i6ASN25tu1gonvZ00ZrL6JvfjPkrDjpBAeoetgQ+nkMH4yvC6
 RRlrgwwmqhnpSVAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D6E4138F0;
 Fri, 16 Dec 2022 09:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4PKFFWg+nGOhVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 09:46:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 16 Dec 2022 10:46:11 +0100
Message-Id: <20221216094611.2924-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221216094611.2924-1-pvorel@suse.cz>
References: <20221216094611.2924-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 2/2] doc: Document used C standard
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Khem Raj <raj.khem@gmail.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

which was added in dc7be30e25 ("config: Explicitly set gnu99")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
BTW I guess after CentOS 7 EOL we should raise std.

 doc/supported-kernel-libc-versions.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/supported-kernel-libc-versions.txt b/doc/supported-kernel-libc-versions.txt
index f89c4882fb..b5f12962b2 100644
--- a/doc/supported-kernel-libc-versions.txt
+++ b/doc/supported-kernel-libc-versions.txt
@@ -70,3 +70,8 @@ Minimal supported (although untested) kernel version is 3.0.
                                  for list of files which need to be deleted in order to compile under musl).
 | binder (Android) | Please use https://android.googlesource.com/platform/external/ltp/[AOSP fork].
 |==================================
+
+1.5 Used C standard
+~~~~~~~~~~~~~~~~~~~
+
+LTP now compiles with '-std=gnu99'.
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
