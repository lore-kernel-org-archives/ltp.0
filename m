Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09E6C55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:06:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFD223E7254
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:06:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCE583E7477
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:05:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 766761400324
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:05:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E4484083;
 Thu, 30 Jul 2026 13:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785416728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW0JO12SqVVJK/qLzfrPiTl2ZZIgjyXu5g1wp/nW3p0=;
 b=FBwfweiAhcM5ANbFX6IrUhNeufEaRD6TkeV+VnQi34pdcdUNRODTQDbG9XilMLHnheiOrB
 576pdF5nKuZMRJcClPxsFAucmeip1aUhEIl3Aeg/F9xx0I98+BZ2Mquva7W+yrB40I8Iri
 6f7h1sujHhpA4H5eQyYikBK1K3+WkIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785416728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW0JO12SqVVJK/qLzfrPiTl2ZZIgjyXu5g1wp/nW3p0=;
 b=C3QrwSkkG/wH3G9co0V4GEwOGZ85aw3l8sXiyZhAi8HEPZwkxSITK6IrUfU1qLuh6rVcVY
 bjxN6MgKQP+dD5Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="a0Awo/J/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="t1yC8/2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785416724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW0JO12SqVVJK/qLzfrPiTl2ZZIgjyXu5g1wp/nW3p0=;
 b=a0Awo/J/t8eaGkE5EtUO5b5ZKKmJh881ExC0GXabkA8RVl/mnN6nYFNXVSXdiyKMDY8+f8
 +vRphRDpx7qxXAfAcDpMP69T6mW0d12oavPkAhM6XLFajmO/aHUVD6q265pEhurWihDXgS
 G3rQnwwO4b/ej0H/HEJVb3qAt7vvWlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785416724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW0JO12SqVVJK/qLzfrPiTl2ZZIgjyXu5g1wp/nW3p0=;
 b=t1yC8/2+VxQoQH4oRYeR76cNO7i9gpIBjskmms7VCCEuPS9IpA1trey4pUUQMxbbXYyJCw
 uBjwqEe3uqmdruAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0109B779D0;
 Thu, 30 Jul 2026 13:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QNISOhNMa2qATQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 Jul 2026 13:05:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Jul 2026 15:05:24 +0200
MIME-Version: 1.0
Message-Id: <20260730-shell_oom_protection-v2-2-be1de2baa83d@suse.com>
References: <20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com>
In-Reply-To: <20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785416723; l=1308;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=lZQqU5TLYzy5l4kw9C/wNIRaj7IOQUav8rtWK7OFgeg=;
 b=SbecD/gt74IIkQlBBGpulOW9owWOG3MzdidiysaJpCIkoJMb/IB2y1qSPmZySu1gzy9EjOMwE
 HtgqiCowt4oDeAROx2WiV6P7j1i1HIofgFTkKP1y1r4ov7auIAcC14K
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 1E4484083
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] memcg_stress: survive OOM by targeting the
 stressors
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The single-cgroup subtest intentionally lets one process fault in the
whole memory budget to push the system to its memory ceiling, so hitting
the OOM killer is an expected part of the stress. The problem is that the
OOM killer could reap the driver script, turning that expected pressure
into a spurious TBROK.

Activate OOM protection so the driver script won't be the OOM victim.

Fixes: 02961a7b2bb4 ("memcg_stress_test.sh: Fix reserved mem calculate")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 47cac9af8bec970b7fb338c5469ab73d55267740..f32161f3f52a500d83cb2f6465adfb5130055dba 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -14,6 +14,7 @@ TST_CLEANUP=cleanup
 TST_CNT=2
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir grep awk cut"
+TST_OOM_PROTECTION=1
 
 # Each test case runs for 900 secs when everything fine
 # therefore the default 5 mins timeout is not enough.

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
