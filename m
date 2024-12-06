Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547B2E77173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 09:50:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26D0D3E6861
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 10:50:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E41303E626C
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:49:58 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D05861828D
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 10:49:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A19EC1F397;
 Fri,  6 Dec 2024 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733478597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5JgDnGHk182X7dwaw4MvDFTGnpwKIbCoVygiKzXcvo=;
 b=NGs7PNmcjKXw8+92kGezAli7RKt8pCOr1rTExe7oUhMO0wn80xzVB+GbK3Blskr0Vd3skw
 S4sCJfnwHAUquF+LGjILk2dXRC8MfhJFj88v/wFAtH1IbS422fdzKv9nQyIWXuz01J0Hmr
 FUIfOYoIjcn5dvjc/GVjLtlbyT+NYz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733478597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5JgDnGHk182X7dwaw4MvDFTGnpwKIbCoVygiKzXcvo=;
 b=ZfVITeOPBXqcWQhzdH77dR9G3NX5JGBelGZrPhLwUc8+Emqb9Ez1Fp4sKn9S60bpUt2RRE
 awtLluV/ejZvPDBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733478597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5JgDnGHk182X7dwaw4MvDFTGnpwKIbCoVygiKzXcvo=;
 b=NGs7PNmcjKXw8+92kGezAli7RKt8pCOr1rTExe7oUhMO0wn80xzVB+GbK3Blskr0Vd3skw
 S4sCJfnwHAUquF+LGjILk2dXRC8MfhJFj88v/wFAtH1IbS422fdzKv9nQyIWXuz01J0Hmr
 FUIfOYoIjcn5dvjc/GVjLtlbyT+NYz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733478597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5JgDnGHk182X7dwaw4MvDFTGnpwKIbCoVygiKzXcvo=;
 b=ZfVITeOPBXqcWQhzdH77dR9G3NX5JGBelGZrPhLwUc8+Emqb9Ez1Fp4sKn9S60bpUt2RRE
 awtLluV/ejZvPDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81BB313647;
 Fri,  6 Dec 2024 09:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sCNeHsXIUmehEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Dec 2024 09:49:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  6 Dec 2024 10:49:37 +0100
Message-ID: <20241206094938.92895-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206094938.92895-1-pvorel@suse.cz>
References: <20241206094938.92895-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] build.sh: Allow to run shell loader tests
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
 build.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/build.sh b/build.sh
index 7bd0d38592..47a5a7b050 100755
--- a/build.sh
+++ b/build.sh
@@ -173,13 +173,14 @@ cross    cross-compile build (requires set compiler via -c switch)
 native   native build
 
 RUN:
-autotools   run only 'make autotools'
-configure   run only 'configure'
-build       run only 'make'
-test        run only 'make test' (not supported for cross-compile build)
-test-c      run only 'make test-c' (not supported for cross-compile build)
-test-shell  run only 'make test-shell' (not supported for cross-compile build)
-install     run only 'make install'
+autotools          run only 'make autotools'
+configure          run only 'configure'
+build              run only 'make'
+test               run only 'make test' (not supported for cross-compile build)
+test-c             run only 'make test-c' (not supported for cross-compile build)
+test-shell         run only 'make test-shell' (not supported for cross-compile build)
+test-shell-loader  run only 'make test-shell-loader' (not supported for cross-compile build)
+install            run only 'make install'
 
 Default configure options:
 in-tree:    $CONFIGURE_OPTS_IN_TREE
@@ -206,7 +207,7 @@ while getopts "c:hio:p:r:t:" opt; do
 		esac;;
 	p) prefix="$OPTARG";;
 	r) case "$OPTARG" in
-		autotools|configure|build|test|test-c|test-shell|install) run="$OPTARG";;
+		autotools|configure|build|test|test-c|test-shell|test-shell-loader|install) run="$OPTARG";;
 		*) echo "Wrong run type '$OPTARG'" >&2; usage; exit 1;;
 		esac;;
 	t) case "$OPTARG" in
@@ -232,7 +233,7 @@ if [ -z "$run" -o "$run" = "build" ]; then
 	eval build_${tree}_tree
 fi
 
-if [ -z "$run" -o "$run" = "test" -o "$run" = "test-c" -o "$run" = "test-shell" ]; then
+if [ -z "$run" -o "$run" = "test" -o "$run" = "test-c" -o "$run" = "test-shell" -o "$run" = "test-shell-loader" ]; then
 	if [ "$build" = "cross" ]; then
 		echo "cross-compile build, skipping running tests" >&2
 	else
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
