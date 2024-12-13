Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A84BE7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 22:21:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F188E3EB884
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 23:21:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99E983E9757
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:19 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F558215592
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DB0821137;
 Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WydU/QQar/N9B7tlfpvzCBpnM6HuAvTIztO6LfvbG4k=;
 b=YlUfEUYR3aXte9qAeNQtPswuPAXz7lOMhVHNjFJ2q9BD3lM6zLet9OFsM9l2mtyjz6Yl4D
 gxoGHxkQ1Bemc1q7Q1N04H9L49ABH2/mebjL7iIiM3tKlsJYc4hWDLrW6v2pUkOesStnIs
 zxTQCayM3tNm/bb3ycJqplxnYpY40xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WydU/QQar/N9B7tlfpvzCBpnM6HuAvTIztO6LfvbG4k=;
 b=B4Q80ktEBGYZQRaqdcj1YpX0fEbGth4IYjdzo5syh8wRYN0DKYmtvz32vMFlqcbOxNcADf
 18xCG0Xgaro0iwBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WydU/QQar/N9B7tlfpvzCBpnM6HuAvTIztO6LfvbG4k=;
 b=YlUfEUYR3aXte9qAeNQtPswuPAXz7lOMhVHNjFJ2q9BD3lM6zLet9OFsM9l2mtyjz6Yl4D
 gxoGHxkQ1Bemc1q7Q1N04H9L49ABH2/mebjL7iIiM3tKlsJYc4hWDLrW6v2pUkOesStnIs
 zxTQCayM3tNm/bb3ycJqplxnYpY40xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WydU/QQar/N9B7tlfpvzCBpnM6HuAvTIztO6LfvbG4k=;
 b=B4Q80ktEBGYZQRaqdcj1YpX0fEbGth4IYjdzo5syh8wRYN0DKYmtvz32vMFlqcbOxNcADf
 18xCG0Xgaro0iwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31BD313AD6;
 Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qOQ6CyKzXGf5QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Dec 2024 23:20:10 +0100
Message-ID: <20241213222014.1580991-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213222014.1580991-1-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/8] ima_setup: Print warning when policy not
 readable
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

check_ima_policy_content() now prints TINFO message when policy is not
readable and it does not return 1 in this case. Therefore
"'func=KEXEC_KERNEL_CHECK' appraise policy loaded, kernel image may not
be signed" TWARN message in ima_kexec.sh is not printed when policy is
not readable.

This is better because in previous case test always failed due TWARN but
result is actually unknown (e.g. don't expect missing policy, return 1
as failure only when policy is readable and checking with grep failed).

Fixes: 3843e2d6fb ("IMA: Add policy related helpers")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index cf769ac751..e958dd3334 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -94,8 +94,11 @@ check_ima_policy_content()
 	local pattern="$1"
 	local grep_params="${2--q}"
 
-	check_policy_readable || return 1
-	grep $grep_params "$pattern" $IMA_POLICY
+	if check_policy_readable; then
+		grep $grep_params "$pattern" $IMA_POLICY
+	else
+		tst_res TINFO "WARNING: policy not readable, can't check policy for '$pattern' (possible false positives)"
+	fi
 }
 
 require_ima_policy_content()
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
