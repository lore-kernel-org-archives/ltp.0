Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E279CA1002
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 09:08:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE0503CD3F7
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 11:08:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FCB63CCEBC
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 11:07:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 82E4A1400772
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 11:07:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4DA2C33FCB;
 Thu,  4 Sep 2025 09:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756976867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gw/kkLcJxSxtu85j3zyufaHFg/3FGsP3ZJjFn88KySg=;
 b=0xK7RsauV0lJzn+/eHlLqXGZmUbTFRV03uSHtT3UcqRRQ0raTN8pyyPtdXcCq4/Twr3EOP
 MikOl+3mutV/k2IzXNbIM5neor70YlG9ztAX4LqPg/ZU+chzq1li4CC+oDuIo2QoI1NEwH
 huszURNWsVbtEvfQn+rrIm+Rw78OXhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756976867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gw/kkLcJxSxtu85j3zyufaHFg/3FGsP3ZJjFn88KySg=;
 b=/L4giC05kmIGGkrPJajJtY/44dGM9zwDW/sJK7IWoCFc5ZtQI8bdDBdS6Wi6F8+pXjlbzI
 2dA++TCB+yeCU2DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756976867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gw/kkLcJxSxtu85j3zyufaHFg/3FGsP3ZJjFn88KySg=;
 b=0xK7RsauV0lJzn+/eHlLqXGZmUbTFRV03uSHtT3UcqRRQ0raTN8pyyPtdXcCq4/Twr3EOP
 MikOl+3mutV/k2IzXNbIM5neor70YlG9ztAX4LqPg/ZU+chzq1li4CC+oDuIo2QoI1NEwH
 huszURNWsVbtEvfQn+rrIm+Rw78OXhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756976867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gw/kkLcJxSxtu85j3zyufaHFg/3FGsP3ZJjFn88KySg=;
 b=/L4giC05kmIGGkrPJajJtY/44dGM9zwDW/sJK7IWoCFc5ZtQI8bdDBdS6Wi6F8+pXjlbzI
 2dA++TCB+yeCU2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2741313675;
 Thu,  4 Sep 2025 09:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id et6gB+NWuWg6FQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Sep 2025 09:07:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Sep 2025 11:07:39 +0200
Message-ID: <20250904090739.50326-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ima_kexec.sh: Detect kexec --reuse-cmdline support
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

For some arch support for --reuse-cmdline was added recently (i.e.
ppc64le in v2.0.27 in Aug 2023), therefore older supported systems does
not have it. Detect the support and skip if not available.

While at it log kexec version.

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

a candidate for a release fix.
Tested on various kernel versions and archs.

Kind regards,
Petr

 .../kernel/security/integrity/ima/tests/ima_kexec.sh  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 9093ba2d64..d6eb0829d8 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -68,6 +68,13 @@ setup()
 	fi
 
 	tst_res TINFO "using kernel $IMA_KEXEC_IMAGE"
+
+	tst_res TINFO "$(kexec -v)"
+
+	REUSE_CMDLINE_SUPPORTED=
+	if kexec -h 2>&1 | grep -q reuse-cmdline; then
+		REUSE_CMDLINE_SUPPORTED=1
+	fi
 }
 
 kexec_failure_hint()
@@ -100,6 +107,10 @@ kexec_test()
 
 	kexec_cmd="$param=$cmdline"
 	if [ "$param" = '--reuse-cmdline' ]; then
+		if [ "$REUSE_CMDLINE_SUPPORTED" != 1 ]; then
+			tst_res TCONF "--reuse-cmdline not supported"
+			return
+		fi
 		cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
 		kexec_cmd="$param"
 	fi
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
