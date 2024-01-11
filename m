Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA0BC47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 09:45:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFA7A3CE458
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 10:45:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E077F3CB828
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 10:45:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 26C021001141
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 10:45:41 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 739102217C;
 Thu, 11 Jan 2024 09:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704966326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=95D7/sbF17/6LVq7JfUkUwUVd8ew1iJFsA+RJlLXufw=;
 b=xRyo/tGLOvhzpGra7NVKtvk5sw7IDkkNR/GYJcF/wW/TM3wDPrfCdnuBCIfzMtAGp3hqOh
 G5zijWxxX4TJ/ytdi05sSU+vaOaaEFsbexsVCGC/fjcQ1gQR8D2wzGb5OTpEiDB10NYhf6
 9PrnYMWiEpPizaq2jARZ5VR6fBJgsZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704966326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=95D7/sbF17/6LVq7JfUkUwUVd8ew1iJFsA+RJlLXufw=;
 b=VQ7arDHJGV8FhYVxA0Nj3HEznpagytcjYAL7tb2/Cb7AWOKLAgOWhnf37GeEoJrgOc2GdN
 rbm2R63ybjs4SNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704966326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=95D7/sbF17/6LVq7JfUkUwUVd8ew1iJFsA+RJlLXufw=;
 b=xRyo/tGLOvhzpGra7NVKtvk5sw7IDkkNR/GYJcF/wW/TM3wDPrfCdnuBCIfzMtAGp3hqOh
 G5zijWxxX4TJ/ytdi05sSU+vaOaaEFsbexsVCGC/fjcQ1gQR8D2wzGb5OTpEiDB10NYhf6
 9PrnYMWiEpPizaq2jARZ5VR6fBJgsZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704966326;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=95D7/sbF17/6LVq7JfUkUwUVd8ew1iJFsA+RJlLXufw=;
 b=VQ7arDHJGV8FhYVxA0Nj3HEznpagytcjYAL7tb2/Cb7AWOKLAgOWhnf37GeEoJrgOc2GdN
 rbm2R63ybjs4SNCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DB6BC138E5;
 Thu, 11 Jan 2024 09:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 69VuNGm4n2VQMQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jan 2024 09:44:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Jan 2024 10:45:30 +0100
Message-ID: <20240111094530.1893262-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-0.998]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[23.19%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] keyctl05: Add modprobe dns_resolver
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

This avoids TCONF when module not loaded:
keyctl05.c:99: TCONF: kernel doesn't support key type 'dns_resolver'

There is no way to trigger module loading automatically.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

a candidate to merge before release (simple enough).

I'll try to send a patchset for .modprobe_module before the release, but
I suppose we should merge it after the release anyway. That's why I
added this simple patch. And therefore I don't bother with 'modprobe -r',
neither with requiring modprobe (will be in .modprobe_module).

Kind regards,
Petr

 testcases/kernel/syscalls/keyctl/keyctl05.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index f0e09fe5d..a79a5763b 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -34,6 +34,8 @@
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 
+#define MODULE "dns_resolver"
+
 /*
  * A valid payload for the "asymmetric" key type.  This is an x509 certificate
  * in DER format, generated using:
@@ -193,6 +195,9 @@ static void test_update_setperm_race(void)
 
 static void setup(void)
 {
+	/* There is no way to trigger automatic dns_resolver module loading. */
+	tst_cmd((const char*[]){"modprobe", MODULE, NULL}, NULL, NULL, 0);
+
 	fips_enabled = tst_fips_enabled();
 }
 
@@ -213,7 +218,7 @@ static void do_test(unsigned int i)
 					 x509_cert, sizeof(x509_cert));
 		break;
 	case 1:
-		test_update_nonupdatable("dns_resolver", dns_res_payload,
+		test_update_nonupdatable(MODULE, dns_res_payload,
 			sizeof(dns_res_payload));
 		break;
 	case 2:
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
