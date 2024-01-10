Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3AEC4707B
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 18:29:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BF0E3CBDE5
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 19:29:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B037E3C1CE0
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 19:29:22 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E25391400F84
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 19:29:21 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D13422318;
 Wed, 10 Jan 2024 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704911346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtKaVyuen+Aci8laMy+IfzdISUqeT25VQXDN7CnTucw=;
 b=tv+xigUKmb9jVDDGX/ftdOMbeiFDgMdczel32Wzd6WHIvY/krx9NRylJMx83UU2HAKHNib
 OlZHgzneOGmKWBG+AGvSCEy2PaUCoKo1czL9xyhtz1Z1NISXYupaIvNRoT9vWa2VVjgE3U
 Z2zwKIGgKFH3EZw0vwakwmkWUq7Jalc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704911346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtKaVyuen+Aci8laMy+IfzdISUqeT25VQXDN7CnTucw=;
 b=2OE9SKZZ2YgtC6mYJUc/m3t5Z1xuiXCw7uoQF7/baJX5vtgg6aAGSevVNNdiGCZoYzHq9y
 TRRALAaTTeBpGcBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704911269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtKaVyuen+Aci8laMy+IfzdISUqeT25VQXDN7CnTucw=;
 b=EFoTuUGAcPTfXUnJuCswju8+0F1SxagUiDIqDrQPEdHp7a/4JLPTazFUvky/FHuS9gzgNT
 6upraIp4tN6Rz7CsQKOxme/YjASr/JxPJZoJ9Es8aLNSASi602Tov5lErno0BQuQ5ZfdEi
 iwy2bEW/hVXbJTeMpZp04cP5MP6sF6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704911269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtKaVyuen+Aci8laMy+IfzdISUqeT25VQXDN7CnTucw=;
 b=KKyOSFEy8xooFqGusJhNKm7ImmxvGkkYhS/JNR3gxt6HIcv3TFYRTG32x6BtVOJCAfHoPN
 9NNjpOCsdM+71UCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E2C86139C6;
 Wed, 10 Jan 2024 18:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id qJVnNKThnmUiGwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 10 Jan 2024 18:27:48 +0000
Date: Wed, 10 Jan 2024 19:29:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <20240110182913.GA1768734@pevik>
References: <20240109095026.792527-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240109095026.792527-1-ruansy.fnst@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,fujitsu.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] dup06: Convert to new API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Shiyang,

> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  testcases/kernel/syscalls/dup/dup06.c | 141 ++++++++++----------------
>  1 file changed, 52 insertions(+), 89 deletions(-)

> diff --git a/testcases/kernel/syscalls/dup/dup06.c b/testcases/kernel/syscalls/dup/dup06.c
> index e3f8070bf..84fc260a1 100644
> --- a/testcases/kernel/syscalls/dup/dup06.c
> +++ b/testcases/kernel/syscalls/dup/dup06.c
> @@ -1,42 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *   Copyright (c) International Business Machines  Corp., 2002
> - *    ported from SPIE, section2/iosuite/dup1.c, by Airong Zhang
> - *   Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
...
> + * Copyright (c) International Business Machines  Corp., 2002
> + *  ported from SPIE, section2/iosuite/dup1.c, by Airong Zhang
> + * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
Could you please also add your or LTP copyright for this rewrite?
E.g.
* Copyright (c) Linux Test Project, 2003-2015
+ your copyright, or just:
* Copyright (c) Linux Test Project, 2003-2024

$ make check-dup06
CHECK testcases/kernel/syscalls/dup/dup06.c
dup06.c:28: ERROR: return is not a function, parentheses are not required
dup06.c:53: ERROR: do not use assignment in if condition
dup06.c:56: WARNING: braces {} are not necessary for any arm of this statement

Therefore I'm going to merge with following change (+ please let me know if you
want to add your copyright).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

diff --git testcases/kernel/syscalls/dup/dup06.c testcases/kernel/syscalls/dup/dup06.c
index 84fc260a1..e7e27b8f9 100644
--- testcases/kernel/syscalls/dup/dup06.c
+++ testcases/kernel/syscalls/dup/dup06.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2002
- *  ported from SPIE, section2/iosuite/dup1.c, by Airong Zhang
+ * ported from SPIE, section2/iosuite/dup1.c, by Airong Zhang
  * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2003-2024
  */
 
 /*\
@@ -17,6 +18,7 @@
 static int *pfildes;
 static int minfd, maxfd, freefds;
 static char pfilname[40];
+
 static int cnt_free_fds(int maxfd)
 {
 	int freefds = 0;
@@ -25,7 +27,7 @@ static int cnt_free_fds(int maxfd)
 		if (fcntl(maxfd, F_GETFD) == -1 && errno == EBADF)
 			freefds++;
 
-	return (freefds);
+	return freefds;
 }
 
 static void setup(void)
@@ -50,16 +52,17 @@ static void run(void)
 
 	pfildes[0] = SAFE_CREAT(pfilname, 0666);
 	for (i = 1; i < maxfd; i++) {
-		if ((pfildes[i] = dup(pfildes[i - 1])) == -1)
+		pfildes[i] = dup(pfildes[i - 1]);
+		if (pfildes[i] == -1)
 			break;
 	}
-	if (i < freefds) {
+
+	if (i < freefds)
 		tst_res(TFAIL, "Not enough files duped");
-	} else if (i > freefds) {
+	else if (i > freefds)
 		tst_res(TFAIL, "Too many files duped");
-	} else {
-		tst_res(TPASS, "Test passed.");
-	}
+	else
+		tst_res(TPASS, "Test passed");
 
 	SAFE_UNLINK(pfilname);
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
