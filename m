Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E96C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 15:20:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80D3E3CE710
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 16:20:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6E8F3CE5CE
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 38A21602AED
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:03 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43CD122111;
 Thu, 14 Dec 2023 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXPCe7qENdtfO80DihSNa8wx4FfKFVX3Sz68X3pKf7s=;
 b=uRZ+0GNf29EDPDkIsWvfvo0z4yET9HEKE+s3uyr5M2jUZ733rRBJD/fFNgmuKw7jd2A6p+
 WuVJDcbG3MBAdsXKyNQTAjagw2KrKxQWi0ft7TKo83865y8ZlY5naZnjKFMHoys49noO4b
 4vofMbcwoGMQtBCnOoOdid1Kli4AOUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXPCe7qENdtfO80DihSNa8wx4FfKFVX3Sz68X3pKf7s=;
 b=FNVIdl4WHLTaV0xYZfMExcj7010fu5CW1xmeP4PTIAYNZa1ltzuqiimAuAxoztm8JfFNgy
 n41Px1fhGYroEjDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXPCe7qENdtfO80DihSNa8wx4FfKFVX3Sz68X3pKf7s=;
 b=uRZ+0GNf29EDPDkIsWvfvo0z4yET9HEKE+s3uyr5M2jUZ733rRBJD/fFNgmuKw7jd2A6p+
 WuVJDcbG3MBAdsXKyNQTAjagw2KrKxQWi0ft7TKo83865y8ZlY5naZnjKFMHoys49noO4b
 4vofMbcwoGMQtBCnOoOdid1Kli4AOUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXPCe7qENdtfO80DihSNa8wx4FfKFVX3Sz68X3pKf7s=;
 b=FNVIdl4WHLTaV0xYZfMExcj7010fu5CW1xmeP4PTIAYNZa1ltzuqiimAuAxoztm8JfFNgy
 n41Px1fhGYroEjDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C5A7F134B0;
 Thu, 14 Dec 2023 15:20:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id UO5NLSAde2WpJwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 15:20:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 16:19:46 +0100
Message-ID: <20231214151954.840244-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214151954.840244-1-pvorel@suse.cz>
References: <20231214151954.840244-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.976]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[31.54%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 02/10] tst_test.sh/tst_brk(): Convert only TBROK to
 TWARN in cleanup
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

C API specifies (since 6440c5d0d):

    WARNING: Calling tst_brk() in test cleanup() does not exit the test as well
	     and TBROK is converted to TWARN.

But shell API 1) changed *anything* to TWARN 2) do change only in exit.
Unify with C API => change also on cleanup() and convert only TBROK.

Also, TBROK in cleanup() was printed 2x (as TBROK and then as TWARN).
Fixing it requires TST_DO_CLEANUP to be unset *before* running cleanup
function ($TST_CLEANUP).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b5b38f524..a6a5d82a4 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -28,6 +28,7 @@ _tst_do_cleanup()
 {
 	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
 		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
+			TST_DO_CLEANUP=
 			$TST_CLEANUP
 		else
 			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
@@ -126,8 +127,10 @@ tst_brk()
 	local res=$1
 	shift
 
-	if [ "$TST_DO_EXIT" = 1 ]; then
+	# TBROK => TWARN on cleanup or exit
+	if [ "$res" = TBROK ] && [ "$TST_DO_EXIT" = 1 -o -z "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" ]; then
 		tst_res TWARN "$@"
+		TST_DO_CLEANUP=
 		return
 	fi
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
