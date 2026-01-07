Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82B9CFD647
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE7903C32DD
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 16:58:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB8913C30CB
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:57:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 391A3200774
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:57:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B81A833BE7;
 Wed,  7 Jan 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767801460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h753lh0IfA1INWdbSt/afBGkR8ljC2rlzZ2c1c5/New=;
 b=JUctFvKXZoIpT9VvUQkussD1OkVNW3IIHw7fVvBiGcYdOT5d12iF+b2uzHziZCpqSkCAVn
 ewlpTIAFHdlGxtGbbJ8MRSGP+s59ZWBizE7R1F2uyaei/7mDzvLiXZ0Hp2OSiOivLoIEB0
 tRoSEcwGjDPP4wW04BN2BiCNgZNIwIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767801460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h753lh0IfA1INWdbSt/afBGkR8ljC2rlzZ2c1c5/New=;
 b=wJTnjI7PoZCW6Hn2A+22X8LcOFwTNxxIlY5WoBc3mWCqgQ4jW42HlyvGK1DpFvkhkCFSkw
 K+Uj4eF1d7amEFDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JUctFvKX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wJTnjI7P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767801460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h753lh0IfA1INWdbSt/afBGkR8ljC2rlzZ2c1c5/New=;
 b=JUctFvKXZoIpT9VvUQkussD1OkVNW3IIHw7fVvBiGcYdOT5d12iF+b2uzHziZCpqSkCAVn
 ewlpTIAFHdlGxtGbbJ8MRSGP+s59ZWBizE7R1F2uyaei/7mDzvLiXZ0Hp2OSiOivLoIEB0
 tRoSEcwGjDPP4wW04BN2BiCNgZNIwIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767801460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h753lh0IfA1INWdbSt/afBGkR8ljC2rlzZ2c1c5/New=;
 b=wJTnjI7PoZCW6Hn2A+22X8LcOFwTNxxIlY5WoBc3mWCqgQ4jW42HlyvGK1DpFvkhkCFSkw
 K+Uj4eF1d7amEFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E8EC3EA65;
 Wed,  7 Jan 2026 15:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KDl+G3SCXmm9HQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 15:57:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Jan 2026 16:57:36 +0100
Message-ID: <20260107155737.791588-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107155737.791588-1-pvorel@suse.cz>
References: <20260107155737.791588-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B81A833BE7
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ima_kexec.sh: Document kernel config dependencies
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CONFIG_HAVE_IMA_KEXEC=y is enough for test, ie. test is working with:

    # CONFIG_IMA_KEXEC is not set
    CONFIG_HAVE_IMA_KEXEC=y

Probably obvious as CONFIG_HAVE_IMA_KEXEC is arch specific and
CONFIG_IMA_KEXEC is "TPM PCRs are only reset on a hard reboot."
and ima_kexec.c requires CONFIG_HAVE_IMA_KEXEC (only parts are skipped
when CONFIG_IMA_KEXEC not set) but better to clarify for users.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 7688690af2..de595fcdd7 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -6,8 +6,11 @@
 #
 # Verify that kexec cmdline is measured correctly.
 # Test attempts to kexec the existing running kernel image.
+#
 # To kexec a different kernel image export IMA_KEXEC_IMAGE=<pathname>.
 # Test requires example IMA policy loadable with LTP_IMA_LOAD_POLICY=1.
+#
+# Test requires CONFIG_HAVE_IMA_KEXEC=y (CONFIG_IMA_KEXEC is not mandatory).
 
 TST_NEEDS_CMDS="grep kexec sed"
 TST_CNT=3
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
