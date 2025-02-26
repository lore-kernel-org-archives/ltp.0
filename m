Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DB0C021B8
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 14:32:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C7AA3C9CEF
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 15:31:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6BAB3C9AAE
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 15:31:22 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7BFBA2275E7
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 15:31:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2EE8421184;
 Wed, 26 Feb 2025 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740580281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mr6t/oJIEhiAKV5KthPQ84ORfLjRQbeod7L6PMsMc6A=;
 b=Aau2ongjf7HLY9sItoLd9s0sBLO90D3kjpOc1/kQs7QOLNgWwZB4xwiGe/mlD4fj/3zlsd
 C7wzwmWQqlbr0Go/i6O24V9fO+BVKWbe2bKf8/GawKH3HXjp/5d3Jm9QTHTEYwwvvXRVFO
 3zwt7V9md9vi605SwCurRNATPZmKkb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740580281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mr6t/oJIEhiAKV5KthPQ84ORfLjRQbeod7L6PMsMc6A=;
 b=yoNya59LIc/jYKw5YElqA3DPoZ30Xv6RJX/NmJ7eBfCkLOqiBoe75l2V1YQPoXgXogZhDd
 g2YR8IIsrbsV28BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740580281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mr6t/oJIEhiAKV5KthPQ84ORfLjRQbeod7L6PMsMc6A=;
 b=Aau2ongjf7HLY9sItoLd9s0sBLO90D3kjpOc1/kQs7QOLNgWwZB4xwiGe/mlD4fj/3zlsd
 C7wzwmWQqlbr0Go/i6O24V9fO+BVKWbe2bKf8/GawKH3HXjp/5d3Jm9QTHTEYwwvvXRVFO
 3zwt7V9md9vi605SwCurRNATPZmKkb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740580281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mr6t/oJIEhiAKV5KthPQ84ORfLjRQbeod7L6PMsMc6A=;
 b=yoNya59LIc/jYKw5YElqA3DPoZ30Xv6RJX/NmJ7eBfCkLOqiBoe75l2V1YQPoXgXogZhDd
 g2YR8IIsrbsV28BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDA3F13A82;
 Wed, 26 Feb 2025 14:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ID9RJ7glv2edRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 26 Feb 2025 14:31:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Feb 2025 15:31:12 +0100
Message-ID: <20250226143113.3016480-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226143113.3016480-1-pvorel@suse.cz>
References: <20250226143113.3016480-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.77 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-0.98)[-0.979]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.19)[-0.961]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 2/3] tst_test: Allow test to suggest reboot via
 $TST_REBOOT
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

Frameworks/tooling which run LTP can schedule reboot based on
environment variable.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
If useful, I should probably add it to C API as well
(at least swapoff01.c and swapon01.c print also "reboot recommended").

 doc/users/setup_tests.rst | 3 +++
 testcases/lib/tst_test.sh | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index ddcf00f027..0cdb86715f 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -85,6 +85,9 @@ users.
    * - LTP_ENABLE_DEBUG
      - Enable debug info (value ``1`` or ``y``). Equivalent of ``-D`` parameter.
 
+   * - TST_REBOOT
+     - Environment variable set by LTP test to signalize that SUT should be rebooted.
+
 Environment variables for network tests
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 See :master:`testcases/network/README.md`.
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2b797705e3..a450976f36 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -16,6 +16,7 @@ export TST_COUNT=1
 export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
+export TST_REBOOT=
 
 . tst_ansi_color.sh
 . tst_security.sh
@@ -84,6 +85,10 @@ _tst_do_exit()
 		[ -z "$TST_SKIP_LSM_WARNINGS" ] && _tst_check_security_modules
 	fi
 
+	if [ "$TST_REBOOT" = 1 ]; then
+		tst_res TINFO "WARNING: reboot recommended due test changes"
+	fi
+
 	cat >&2 << EOF
 
 Summary:
@@ -687,7 +692,7 @@ tst_run()
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
 			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
 			SKIP_FILESYSTEMS|SKIP_IN_LOCKDOWN|SKIP_IN_SECUREBOOT);;
-			DEVICE_SIZE);;
+			DEVICE_SIZE|REBOOT);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
