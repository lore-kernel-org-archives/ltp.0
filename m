Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90609C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 14:01:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86CEF3CF901
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 16:01:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B6093C022E
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 16:01:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E7B56001EA
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 16:01:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 236B41FF6A;
 Wed, 25 Oct 2023 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698242477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhfkFJSMpFLN1q8e6Lr6mcGoHlmXTa3Lg3Vt/20Y2d8=;
 b=WNcIYmon6Nwr7K6UaUPKhUVsxSaLecjpbeUbyCbQB6Wft4/Up06CMqkhd93XtepyGF4EoE
 ypmGXhaf86IgnlfmnepENK3Bq/m5JO/g+15HTG421YtO7si+eRoNebUePLEOAqib3Jk3Y/
 QJQmhBu7hcAwPWBcTTMSHHbQ9WRUZZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698242477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhfkFJSMpFLN1q8e6Lr6mcGoHlmXTa3Lg3Vt/20Y2d8=;
 b=YWsmSj3gP8OQUavGvWFNx9hG6Vf0VnWT5xj9/Hn2wOooxqsaOw9nrtNArpfUYwDgYh0TIW
 8YZxaIV4AhMTuBCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D13D13A82;
 Wed, 25 Oct 2023 14:01:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MDUoCawfOWWAEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 14:01:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 16:01:09 +0200
Message-ID: <20231025140109.340441-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025140109.340441-1-pvorel@suse.cz>
References: <20231025140109.340441-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc/support: Update the latest tested distros
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
Cc: Ulrich Hecht <uli@kernel.org>, Richard Palethorpe <rpalethorpe@suse.com>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Update changes from previous commit (CentOS 7 replaced by Ubuntu 16.04
LTS xenial and openSUSE Leap 42.2).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/Supported-kernel,-libc,-toolchain-versions.asciidoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc b/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
index e3d9cd92f..d935fe6f1 100644
--- a/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
+++ b/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
@@ -21,7 +21,7 @@ NOTE: GitHub Actions does only build testing, passing the CI means only that
 [align="center",options="header"]
 |==============================================================
 | Distro                       | kernel  | glibc | gcc   | clang
-| CentOS 7                     | 3.10    | 2.17  | 4.8.5 | -
+| openSUSE Leap 42.2           | 4.4     | 2.22  | 4.8.5 | -
 | Ubuntu 18.04 LTS bionic      | 4.15    | 2.27  | 7.3.0 | -
 | Debian 10 oldstable (buster) | 4.19.37 | 2.28  | 8.3.0 | 7.0
 |==============================================================
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
