Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C9DC02184
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 11:31:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 507843C7A27
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 12:31:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57A373C7A28
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:29:26 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02356638FF9
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:29:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A08B71F441;
 Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbSNLSUZ3waUTk6RAkd2Tl7h7KSHJSs2a5nCnCUFWqo=;
 b=e87wnBD069QGVRv73KQIsk4y3icyNsTJconDpXiPk/1ylsP3cH66XT6sameoHomuJ72CUq
 f1AI6d0KL1l42J+zaTNN8aJiERYwmwlBhquT5uIQMzHPuunvCIVSN6aPXB6b62LjrYtYP2
 7p8QG8pedBLYw64thcJnhjFwHK6Nqc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736854165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbSNLSUZ3waUTk6RAkd2Tl7h7KSHJSs2a5nCnCUFWqo=;
 b=n+Ey4BbVP7wUzXHvXJypFgPOPL8zKUpnrxciYlIEIEsgWuVxkkL6Wf8xpSzFDe6aRiprn9
 yVL3iJ65xcdfRRAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbSNLSUZ3waUTk6RAkd2Tl7h7KSHJSs2a5nCnCUFWqo=;
 b=e87wnBD069QGVRv73KQIsk4y3icyNsTJconDpXiPk/1ylsP3cH66XT6sameoHomuJ72CUq
 f1AI6d0KL1l42J+zaTNN8aJiERYwmwlBhquT5uIQMzHPuunvCIVSN6aPXB6b62LjrYtYP2
 7p8QG8pedBLYw64thcJnhjFwHK6Nqc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736854165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbSNLSUZ3waUTk6RAkd2Tl7h7KSHJSs2a5nCnCUFWqo=;
 b=n+Ey4BbVP7wUzXHvXJypFgPOPL8zKUpnrxciYlIEIEsgWuVxkkL6Wf8xpSzFDe6aRiprn9
 yVL3iJ65xcdfRRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77FCD139CB;
 Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QDX7G5VKhmeMIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Jan 2025 12:29:14 +0100
Message-ID: <20250114112915.610297-10-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLqxawhspxxs4naamnp9m5ipny)];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 09/10] ima_measurements.sh: Check policy for test3
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

First two tests are working with ima_policy=tcb,
but 3rd test requires more specific policy.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_measurements.sh  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index c42c31c898..35acc6ea78 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -77,6 +77,11 @@ test3()
 	tst_res TINFO "verify not measuring user files"
 	tst_check_cmds sudo || return
 
+	if [ "$IMA_POLICY_CHECKED" != 1 ]; then
+		tst_res TCONF "test requires specific policy, try load it with LTP_IMA_LOAD_POLICY=1"
+		return
+	fi
+
 	if ! id $user >/dev/null 2>/dev/null; then
 		tst_res TCONF "missing system user $user (wrong installation)"
 		return
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
