Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7DEC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 07:36:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E03943CE101
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 08:36:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74D323C4DB7
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 08:35:13 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A96091400E0E
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 08:35:12 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A48522033;
 Tue, 30 Jan 2024 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706600112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a85kVBRL96ekAwz5fBmkPkTy6YEvbDheWeYTJ69UYTo=;
 b=MsmTDAXAaEXKhV11WqiExuIXLpOp1M6Oy90pxHzOw4hOcx2H8tZrN6OttHjZ/j7plL7FfC
 u+TXWd7fx8HgKCGt9ejuw700vrblUjWjRXs1BGH7rrBaja5tur33VL58V8aC1MT4iCt3J6
 CGxsg4SKxstkT4F1iSwCqoq2ZmnEplY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706600112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a85kVBRL96ekAwz5fBmkPkTy6YEvbDheWeYTJ69UYTo=;
 b=6nOJAFfkUGoKV/r07C4djt0Q6XzNc32WvAfGhmH2R/W7y7wUpoUhDtwnKMLaemz0L/dWLa
 VRhUA3YhWni3ErCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706600111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a85kVBRL96ekAwz5fBmkPkTy6YEvbDheWeYTJ69UYTo=;
 b=XZbsBvdGcXbdotBI9ffffk/XGPuxpE/GM26WUxxq1beXY7lGOfKeVBw9NYxRJyzC0OsSUA
 EJmNc/obWcajWTqfa4c3nyfg4arn5auELZ05xa7Vrf9C9TtnEkhl0VF+gr3xwptCaKzg+p
 xrX6kr9l4GfLJDONnUvAAtAJe5tr8q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706600111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a85kVBRL96ekAwz5fBmkPkTy6YEvbDheWeYTJ69UYTo=;
 b=ZceI+RDKnrRIEFTVHePQSzkIrVp0nChPK54fSGT7dZIS+HLzMBOSeoRHp+pHC9BfI+psqk
 GHKMKmRaqmlQ9jDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E5431376E;
 Tue, 30 Jan 2024 07:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 6CMqBq+muGVjTwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 07:35:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Jan 2024 08:35:05 +0100
Message-ID: <20240130073507.662414-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130073507.662414-1-pvorel@suse.cz>
References: <20240130073507.662414-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.85 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.05)[59.32%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] runtest: Move capability related tests to new
 capability
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

Move cap_bounds content to syscalls

runtest/cap_bounds and runtest/filecaps had both only single entry.
That's a waste of starting SUT, therefore create new runtest file
capability and move it there. Add there also runtest/securebits.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Maybe it'd be safer to verify if the tests are still relevant now.
Because name is more promising than the actual content :).
Also we have other tests which use libcap.
Alternatively, we could just move them to syscalls.

 runtest/cap_bounds                 | 2 --
 runtest/{securebits => capability} | 5 ++++-
 runtest/filecaps                   | 2 --
 3 files changed, 4 insertions(+), 5 deletions(-)
 delete mode 100644 runtest/cap_bounds
 rename runtest/{securebits => capability} (53%)
 delete mode 100644 runtest/filecaps

diff --git a/runtest/cap_bounds b/runtest/cap_bounds
deleted file mode 100644
index 518d1e3ab..000000000
--- a/runtest/cap_bounds
+++ /dev/null
@@ -1,2 +0,0 @@
-#DESCRIPTION:Posix capability bounding set
-Cap_bounds	run_capbounds.sh
diff --git a/runtest/securebits b/runtest/capability
similarity index 53%
rename from runtest/securebits
rename to runtest/capability
index 64e6e0a0d..c7af1235e 100644
--- a/runtest/securebits
+++ b/runtest/capability
@@ -1,4 +1,7 @@
-#DESCRIPTION:securebits tests
+# various capability related tests
+cap_bounds run_capbounds.sh
+filecaps filecapstest.sh
+
 check_keepcaps01 check_keepcaps 1
 check_keepcaps02 check_keepcaps 2
 check_keepcaps03 check_keepcaps 3
diff --git a/runtest/filecaps b/runtest/filecaps
deleted file mode 100644
index 1872c0bc5..000000000
--- a/runtest/filecaps
+++ /dev/null
@@ -1,2 +0,0 @@
-#DESCRIPTION:file capabilities
-Filecaps	filecapstest.sh
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
