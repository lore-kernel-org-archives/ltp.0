Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F233ECD13CF
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 12:47:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77C673C4F85
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 14:47:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 024D73C4CA6
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 14:46:51 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 98EA4600D56
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 14:46:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43CC2219B1;
 Tue,  3 Sep 2024 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725367609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JAizlldSSP+IFnCrfs+NAMJ3ua8EX7U43eVVkDlWvk=;
 b=oja74Fsd8MSHkkVFtYmZTozR/0OvZeZUUF1LA8/DKx0koeWvwcUQCgdFukF3nUIG94Ww35
 RQjwiwJB/QkmRV9R8QdfkRqQfmquVuWgphBsM/8o1Qbf0dHFjTf1WX5en0uNh0tmvs+K0I
 9DvBodsr6nsXVo1963qW4Z1HzGzBoa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725367609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JAizlldSSP+IFnCrfs+NAMJ3ua8EX7U43eVVkDlWvk=;
 b=oAmy36IVgDpaGJ60GhcWjzNKGpXSZBr78J7FOKepyHMc7mWp7mN3/AlQQ7s8fWSo9KNL5r
 TC3HfKm3OcYpClAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725367609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JAizlldSSP+IFnCrfs+NAMJ3ua8EX7U43eVVkDlWvk=;
 b=oja74Fsd8MSHkkVFtYmZTozR/0OvZeZUUF1LA8/DKx0koeWvwcUQCgdFukF3nUIG94Ww35
 RQjwiwJB/QkmRV9R8QdfkRqQfmquVuWgphBsM/8o1Qbf0dHFjTf1WX5en0uNh0tmvs+K0I
 9DvBodsr6nsXVo1963qW4Z1HzGzBoa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725367609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JAizlldSSP+IFnCrfs+NAMJ3ua8EX7U43eVVkDlWvk=;
 b=oAmy36IVgDpaGJ60GhcWjzNKGpXSZBr78J7FOKepyHMc7mWp7mN3/AlQQ7s8fWSo9KNL5r
 TC3HfKm3OcYpClAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E07213AF0;
 Tue,  3 Sep 2024 12:46:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +IU1BjkF12a4OgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 12:46:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Sep 2024 14:46:44 +0200
Message-ID: <20240903124644.757127-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903124644.757127-1-pvorel@suse.cz>
References: <20240903124644.757127-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.cz:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] runltp: Print deprecated warnings to STDERR
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Probably more change people will notice

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runltp | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/runltp b/runltp
index 4b0bd08f15..0d90625691 100755
--- a/runltp
+++ b/runltp
@@ -70,10 +70,10 @@
 
 deprecated()
 {
-    echo "-------------------------------------------"
-    echo "INFO: runltp script is deprecated, try kirk"
-    echo "https://github.com/linux-test-project/kirk"
-    echo "-------------------------------------------"
+    echo "-------------------------------------------" >&2
+    echo "INFO: runltp script is deprecated, try kirk" >&2
+    echo "https://github.com/linux-test-project/kirk" >&2
+    echo "-------------------------------------------" >&2
 }
 
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
