Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F414C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 05:57:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1BDC3E27A7
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:57:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B06D03E2868
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 610791000993
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C0FF176604;
 Fri, 10 Jul 2026 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/oKFD+kr1AFCfby4FoyvThJiVEiIN2OGyb4zFwzQRA=;
 b=EwmoFh6BC6jmYHcCcsewZeV2TQWdiI5hBOiYrN/8bX2rzQdsznKTNEb9S+q6oQigFEw/hm
 9tBHL8DkJP/ryT596VX5Ho7hOuAMPzeHZB59hbZJOxlDYTOPQqkPBHtXp6sD8btw0byYEW
 TXYnJGeOdxtBtgz0kwQYwFXB5s1Pz3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/oKFD+kr1AFCfby4FoyvThJiVEiIN2OGyb4zFwzQRA=;
 b=CGAOi8KJy0Gjq7ocESV4SxlCSELVeCqoZiVy8TlVhiSWvGTEIJBHsrEicPlY5NyABkJOFy
 AcqyUUBzcG1ql4Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/oKFD+kr1AFCfby4FoyvThJiVEiIN2OGyb4zFwzQRA=;
 b=EwmoFh6BC6jmYHcCcsewZeV2TQWdiI5hBOiYrN/8bX2rzQdsznKTNEb9S+q6oQigFEw/hm
 9tBHL8DkJP/ryT596VX5Ho7hOuAMPzeHZB59hbZJOxlDYTOPQqkPBHtXp6sD8btw0byYEW
 TXYnJGeOdxtBtgz0kwQYwFXB5s1Pz3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/oKFD+kr1AFCfby4FoyvThJiVEiIN2OGyb4zFwzQRA=;
 b=CGAOi8KJy0Gjq7ocESV4SxlCSELVeCqoZiVy8TlVhiSWvGTEIJBHsrEicPlY5NyABkJOFy
 AcqyUUBzcG1ql4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9CD8779BE;
 Fri, 10 Jul 2026 05:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yF7ZJ3CJUGp7TwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 05:56:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 07:55:54 +0200
Message-ID: <20260710055556.1109220-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710055556.1109220-1-pvorel@suse.cz>
References: <20260710055556.1109220-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/8] build.sh: Add support for test-metadata
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
* The same as in v1

 build.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/build.sh b/build.sh
index 47a5a7b050..57bb9e904c 100755
--- a/build.sh
+++ b/build.sh
@@ -178,6 +178,7 @@ configure          run only 'configure'
 build              run only 'make'
 test               run only 'make test' (not supported for cross-compile build)
 test-c             run only 'make test-c' (not supported for cross-compile build)
+test-metadata      run only 'make test-metadata' (not supported for cross-compile build)
 test-shell         run only 'make test-shell' (not supported for cross-compile build)
 test-shell-loader  run only 'make test-shell-loader' (not supported for cross-compile build)
 install            run only 'make install'
@@ -207,7 +208,7 @@ while getopts "c:hio:p:r:t:" opt; do
 		esac;;
 	p) prefix="$OPTARG";;
 	r) case "$OPTARG" in
-		autotools|configure|build|test|test-c|test-shell|test-shell-loader|install) run="$OPTARG";;
+		autotools|configure|build|test|test-c|test-metadata|test-shell|test-shell-loader|install) run="$OPTARG";;
 		*) echo "Wrong run type '$OPTARG'" >&2; usage; exit 1;;
 		esac;;
 	t) case "$OPTARG" in
@@ -233,7 +234,7 @@ if [ -z "$run" -o "$run" = "build" ]; then
 	eval build_${tree}_tree
 fi
 
-if [ -z "$run" -o "$run" = "test" -o "$run" = "test-c" -o "$run" = "test-shell" -o "$run" = "test-shell-loader" ]; then
+if [ -z "$run" -o "$run" = "test" -o "$run" = "test-c" -o "$run" = "test-metadata" -o "$run" = "test-shell" -o "$run" = "test-shell-loader" ]; then
 	if [ "$build" = "cross" ]; then
 		echo "cross-compile build, skipping running tests" >&2
 	else
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
