Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8CDC531DC
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 11:43:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 022FB3D2332
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 13:43:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21E383D233A
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 13:42:28 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6EFD7200BC4
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 13:42:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 749BD22671;
 Fri, 23 Aug 2024 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724413345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ait+wNCRcH2Tm2zWi5dvKsy5LFrswU0Zgs34ZLQzGw4=;
 b=MNHEVW6XTiC8X6FO9U7pzzPP/f2Lp8tcqjoNKd6dhAKVUpaqP24nMtbPxYcTdD055uBlNT
 iL0A6J5y2kGYdOepAhUVWuU80YPG2eEdcqKFV0MtdjSD8FWsY3V/DWj5Ni05d20hKT9lkL
 MNEoufLK/G6OeLenN7ng+eMrTxfEx5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724413345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ait+wNCRcH2Tm2zWi5dvKsy5LFrswU0Zgs34ZLQzGw4=;
 b=u2Wx8SAJfbJmdM6ks/iFQcc/aPz2RhlXeaRmD93CUZVMXFcQBRo6qhg8GI3+snq1Vp+u1m
 u6m5fgrxlSZocLBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724413345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ait+wNCRcH2Tm2zWi5dvKsy5LFrswU0Zgs34ZLQzGw4=;
 b=MNHEVW6XTiC8X6FO9U7pzzPP/f2Lp8tcqjoNKd6dhAKVUpaqP24nMtbPxYcTdD055uBlNT
 iL0A6J5y2kGYdOepAhUVWuU80YPG2eEdcqKFV0MtdjSD8FWsY3V/DWj5Ni05d20hKT9lkL
 MNEoufLK/G6OeLenN7ng+eMrTxfEx5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724413345;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ait+wNCRcH2Tm2zWi5dvKsy5LFrswU0Zgs34ZLQzGw4=;
 b=u2Wx8SAJfbJmdM6ks/iFQcc/aPz2RhlXeaRmD93CUZVMXFcQBRo6qhg8GI3+snq1Vp+u1m
 u6m5fgrxlSZocLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D8F71398B;
 Fri, 23 Aug 2024 11:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oLCmDaF1yGbeRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 11:42:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 23 Aug 2024 13:42:17 +0200
Message-ID: <20240823114217.1261861-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823114217.1261861-1-pvorel@suse.cz>
References: <20240823114217.1261861-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] ci/debian.sh: Make dependencies really minimal
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

Remove most of the optional library headers.

LTP should be compilable without linux-libc-dev, but we expect kernel
headers.

libc6-dev and libtirpc-dev are hard dependencies for gcc toolchain.
Removing libtirpc-dev removes build-essential and that in the end
removes libc6-dev, which has /usr/lib/x86_64-linux-gnu/crti.o and
/usr/lib/x86_64-linux-gnu/Scrt1.o. That would cause toolchain to fail:

    configure:4088: gcc -Wformat -Werror=format-security \
	-Werror=implicit-function-declaration -Werror=return-type \
	-fno-common   conftest.c  >&5
    /usr/bin/ld: cannot find Scrt1.o: No such file or directory
    /usr/bin/ld: cannot find crti.o: No such file or directory
    collect2: error: ld returned 1 exit status

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/debian.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ci/debian.sh b/ci/debian.sh
index 68cf1509fc..fc1c1b3ec6 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -14,8 +14,9 @@ export DEBIAN_FRONTEND="noninteractive"
 install="apt install -y --no-install-recommends"
 remove="apt remove -y"
 
+# libc6-dev and libtirpc-dev are hard dependencies for gcc toolchain
+# LTP should be compilable without linux-libc-dev, but we expect kernel headers.
 pkg_minimal="
-	acl-dev
 	autoconf
 	automake
 	build-essential
@@ -26,8 +27,6 @@ pkg_minimal="
 	git
 	iproute2
 	libc6-dev
-	libjson-perl
-	libmnl-dev
 	libtirpc-dev
 	linux-libc-dev
 	lsb-release
@@ -35,14 +34,17 @@ pkg_minimal="
 "
 
 pkg_nonessential="
+	acl-dev
 	asciidoc-base
 	asciidoc-dblatex
 	asciidoctor
 	libacl1-dev
 	libaio-dev
 	libcap-dev
+	libjson-perl
 	libkeyutils-dev
 	libnuma-dev
+	libmnl-dev
 	libselinux1-dev
 	libsepol-dev
 	libssl-dev
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
