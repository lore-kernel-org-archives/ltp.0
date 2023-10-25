Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7F2C25B47
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 14:54:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 679143CF4D3
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 16:54:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 117333CCC4D
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 16:54:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 098411A00E0C
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 16:54:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A797321DDD;
 Wed, 25 Oct 2023 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698245665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1i91X8krjEwBuiKKgCzS1ekFDdhJOGHAldpNzRMzOP0=;
 b=3V2sYaU+DRsOdYQft+lswnmRTHZnR1gotPEVoIU1gTHeMaIQuT8FZ7r91V3sI8h18Alupf
 mMlvLK5v7L3MKaBCPAVqMkTsdLnrWHN7yL7QIgMDAG3M1tK0QwmsrNpZnnlFywqyqVXOYR
 zPIZyyBQKIRN+7PKvMteDk1BCHtm9kQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698245665;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1i91X8krjEwBuiKKgCzS1ekFDdhJOGHAldpNzRMzOP0=;
 b=i7liUPdB6cKOVUoeHy8BH/brYgBb8zX4zxhPdsorSDggFzzIvznYnO9q+ewCnG/rPGcsEa
 pAzkzLnM2W3p+/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C378F138E9;
 Wed, 25 Oct 2023 14:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5xsALiAsOWWzKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 14:54:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 16:54:14 +0200
Message-ID: <20231025145414.345239-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[15];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.99%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] doc/support: Update the oldest tested distros
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

Also remove note about Debian 10 oldstable (buster), because since
June 2023, when Debian 12 bookworm was released as Debian stable,
the oldstable release codename alias points to Debian 11 bullseye
which uses quite new software (kernel 5.10, glibc: 2.31, gcc 10.2)
therefore not mentioned in the table.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Add xenial (left by accident)
* Remove outdated buster record.

I'm sorry for the noise.

Kind regards,
Petr

 doc/Supported-kernel,-libc,-toolchain-versions.asciidoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc b/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
index e3d9cd92f..dcc0cb79c 100644
--- a/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
+++ b/doc/Supported-kernel,-libc,-toolchain-versions.asciidoc
@@ -21,9 +21,9 @@ NOTE: GitHub Actions does only build testing, passing the CI means only that
 [align="center",options="header"]
 |==============================================================
 | Distro                       | kernel  | glibc | gcc   | clang
-| CentOS 7                     | 3.10    | 2.17  | 4.8.5 | -
+| openSUSE Leap 42.2           | 4.4     | 2.22  | 4.8.5 | -
+| Ubuntu 16.04 LTS xenial      | 4.4     | 2.23  | 5.3.1 | -
 | Ubuntu 18.04 LTS bionic      | 4.15    | 2.27  | 7.3.0 | -
-| Debian 10 oldstable (buster) | 4.19.37 | 2.28  | 8.3.0 | 7.0
 |==============================================================
 
 Older distributions are not officially supported, which means that it
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
