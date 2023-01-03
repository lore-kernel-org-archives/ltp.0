Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DE9C3DA7D
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 12:45:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C8663CCEC2
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 13:45:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E39D53CB6A2
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 13:45:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4312C140076D
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 13:45:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D96D671E6;
 Tue,  3 Jan 2023 12:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672749911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6V8Rg3ubmfMdl/XchNiNFn9McRH4hY1CCR4qsVeVsM=;
 b=pm7y2asCnKc481CwhXhMV4LB5xe3nHjyRTjpk9gSS3uedg9Uwo3le/qyoEzTfNnu2H7uMc
 Mi4FLpSE5pgc7+fvjsrjmo0iKRqv9u93+ObzVRBFypkXMJKx6ULj2SRy9hl1TAYQjjnKIH
 Ua6euy+Bi1qbtv7CWvQmAOM2ejrng+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672749911;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6V8Rg3ubmfMdl/XchNiNFn9McRH4hY1CCR4qsVeVsM=;
 b=Kjf6jYENxdBS1EU4F2vwNd6DVqIyjkbgBONbs3AqZqsFAVCnKVOUOcPN4DObf1b85A4sa2
 u6RhB/9BGFKDDlCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E47D11392B;
 Tue,  3 Jan 2023 12:45:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YMTsNFYjtGMZEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 Jan 2023 12:45:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jan 2023 13:45:05 +0100
Message-Id: <20230103124505.6611-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103124505.6611-1-pvorel@suse.cz>
References: <20230103124505.6611-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] configure.ac: Update AC_PROG_AR related comment
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
Cc: Zack Weinberg <zackw@panix.com>, Mike Frysinger <vapier@gentoo.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

AC_PROG_AR was added much later: in v2.72a [1]. Also it looks like that
redefinition is not a problem thus not wrapping with m4_ifndef([AC_PROG_AR].

NOTE: missing 'ar' don't fail configure (isn't the check useless then?):
$ rm -rf autom4te.cache/; ma autotools && ./configure; echo $?
...
configure:4878: checking for ar
configure:4913: result: no
...
0

[1] https://git.savannah.gnu.org/cgit/autoconf.git/commit/?id=c48fdb81191c8b7c7c0dde6141b861b178a6a284

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                    | 3 +--
 testcases/realtime/configure.ac | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index c2b0f48e79..edf00687f2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,8 +20,7 @@ AM_MAINTAINER_MODE([enable])
 AC_CANONICAL_HOST
 
 AC_PROG_CC
-# <= autoconf 2.61 doesn't have AC_PROG_AR, but 2.63 has it. Not sure about
-# 2.62.
+# autoconf >= v2.72a
 AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])
 AC_PROG_AR
 AC_PROG_RANLIB
diff --git a/testcases/realtime/configure.ac b/testcases/realtime/configure.ac
index 6f50f1490f..39f16f1779 100644
--- a/testcases/realtime/configure.ac
+++ b/testcases/realtime/configure.ac
@@ -12,8 +12,7 @@ AC_CHECK_HEADERS_ONCE([ \
 AC_CANONICAL_HOST
 
 AC_PROG_CC
-# <= autoconf 2.61 doesn't have AC_PROG_AR, but 2.63 has it. Not sure about
-# 2.62.
+# autoconf >= v2.72a
 AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])
 AC_PROG_AR
 AC_PROG_RANLIB
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
