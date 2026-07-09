Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC74DC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 13:02:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32CD83E294E
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:02:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2A283E28AF
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:01:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DDB282001AC
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:01:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2F9275F30;
 Thu,  9 Jul 2026 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783602111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHu7DgR128Gr64MgZe2NBEJ9vRpm0cwit17PXKky7kA=;
 b=KRixqVe+hgUYY+Bzyd4fxhQOZh4bzW/bXCZvBy/+6mp4w8ZKCXgZcYknnPSjaTfIoeqMcK
 FiNaYGVAToxh4IINjVV6bKACErUmvwZJpIKUdnJsys5JeKyB3pn+gv8T+aaDE/AT5ENHGo
 jevzvsbC4158NgWZARy6Gui0jpooAxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783602111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHu7DgR128Gr64MgZe2NBEJ9vRpm0cwit17PXKky7kA=;
 b=xpiy8VDYEoTSf/Q8oK1GWRkcCjfSdsOtcM9dAx4Ujw2f09vdZov/mJm4nRvLti3hlzFAQ/
 pEg8URelXwxFWIBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iW4hOv7b;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9X3HjuVH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783602106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHu7DgR128Gr64MgZe2NBEJ9vRpm0cwit17PXKky7kA=;
 b=iW4hOv7bskKAJsH8PAPkn35c6uZB8DM/7x6Hf2ElV9TpaeuCS9O+Xk1BOHSZYBgIpo9+QA
 drtTVt6bm5fnEpEDceZxyohJ3HzU9T3Fs+eTzibdg/F/n0076P2H+oja2s3tJRIw7rcq9e
 u8a3DtiwUPS8e8pv5AAxZRgpXS+Rxjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783602106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHu7DgR128Gr64MgZe2NBEJ9vRpm0cwit17PXKky7kA=;
 b=9X3HjuVHdTz8FmqxggnpyEX+h3McR0bYjtL/OAc5rspYWp5qqmrpozGr41//j6emK2fsHC
 5ohU9EDOAX4DjkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3164A779AC;
 Thu,  9 Jul 2026 13:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4K+aArqbT2rtFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jul 2026 13:01:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 15:01:33 +0200
Message-ID: <20260709130135.927868-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709130135.927868-1-pvorel@suse.cz>
References: <20260709130135.927868-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D2F9275F30
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] build.sh: Add support for test-metadata
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
