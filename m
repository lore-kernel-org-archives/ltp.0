Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16118C4167D
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 10:55:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2499B3CE865
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 11:55:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3349F3CC737
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 11:54:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 74B65200DCA
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 11:54:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 082472185F;
 Mon,  6 Nov 2023 10:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699268097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQ1N68q2P1jZ9rKmhkpTUS8ORBcY7eQORsGhaDdX6V4=;
 b=Ee/Psw2mJiN/vbd3lt1px405+9eRk0HKV+h56aP3eP6r8GHdOfnCcSiyU2GjDxxABgaOhy
 KLU/f/FBCaqNSNqxc7uEdb7P+OvfFiVGRaPiymbYiXMUJ4L39M8Y07WcBorwnonjdS8eKt
 v/1mencZPOFNtOFGk2sFVJhKMMTBHxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699268097;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQ1N68q2P1jZ9rKmhkpTUS8ORBcY7eQORsGhaDdX6V4=;
 b=NOeHAEqCHBM3dzBsMcMe7BEuLU60vY4rnyazym5SqrslZkUezj8m9Ir8cpgLjiOt2/WpjZ
 tWDkPevdNLD5WVBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EE9F138E5;
 Mon,  6 Nov 2023 10:54:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SPFaJQDGSGXCIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Nov 2023 10:54:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Nov 2023 11:54:17 +0100
Message-ID: <20231106105418.1240169-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106105418.1240169-1-pvorel@suse.cz>
References: <20231106105418.1240169-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] doc/support: Update the oldest tested distros
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
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Update changes from previous commit (CentOS 7 replaced by Ubuntu 16.04
LTS xenial and openSUSE Leap 42.2).

Also remove note about Debian 10 oldstable (buster), because since
June 2023, when Debian 12 bookworm was released as Debian stable,
the oldstable release codename alias points to Debian 11 bullseye
which uses quite new software (kernel 5.10, glibc: 2.31, gcc 10.2)
therefore not mentioned in the table.

Acked-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/Supported-kernel,-libc,-toolchain-versions.asciidoc | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc b/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
index e3d9cd92f..bdb3e44f3 100644
--- a/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
+++ b/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
@@ -19,12 +19,11 @@ NOTE: GitHub Actions does only build testing, passing the CI means only that
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 [align="center",options="header"]
-|==============================================================
+|===============================================================
 | Distro                       | kernel  | glibc | gcc   | clang
-| CentOS 7                     | 3.10    | 2.17  | 4.8.5 | -
+| openSUSE Leap 42.2           | 4.4     | 2.22  | 4.8.5 | -
 | Ubuntu 18.04 LTS bionic      | 4.15    | 2.27  | 7.3.0 | -
-| Debian 10 oldstable (buster) | 4.19.37 | 2.28  | 8.3.0 | 7.0
-|==============================================================
+|===============================================================
 
 Older distributions are not officially supported, which means that it
 may or may not work. It all depends on your luck. It should be possible
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
