Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039BEC982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 13:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34A5A3E6CD4
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 15:55:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9659C3E5DB9
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 15:55:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F22A1400DF5
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 15:55:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5931B21D0B;
 Tue, 22 Sep 2026 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790085323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiarFwrQg+RNcVliPLeiVTZtSNfW8a2dXirnyfAmliU=;
 b=HYMPp5FO2MNOYdBEtgNkNzUw8tLbGpzsZnJUv3IHiLfvdGnMIvGyOV/j5stNlgz0C6qWL3
 wpjUcpEJgBqLqy1Vz9h3PY/KPv1DjaaY+wxXxw9a+BU2ZSCd4qwb+WJx0wZ9bfKFtNaBgz
 kFKnufDXiNNEH2IuezXd5HN6wKIKdk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790085323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiarFwrQg+RNcVliPLeiVTZtSNfW8a2dXirnyfAmliU=;
 b=dVCyuByOrUvOI12J8PzXlVD74DB92LeJAACwtPuHwNndygSgh4D685u5aBYhsTJ0X2RXOo
 M2tVVNV3NytWefBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790085319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiarFwrQg+RNcVliPLeiVTZtSNfW8a2dXirnyfAmliU=;
 b=aBH91YL2bhqkY11Ji2FeDkcfqlcmxAKtl2P0vqkjqY4IcB2Rdh1brs8LXnG61HgZui50HF
 hczHmJdR4J+lX/R0YUA7Q2dx0QARpUEOmuCl0RGfQqwXEulhBoFjTtTWc7FaqItC3CA0aj
 doNuIV61gdu3yljyRcUzehwCryyPzJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790085319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiarFwrQg+RNcVliPLeiVTZtSNfW8a2dXirnyfAmliU=;
 b=FrxYZ4gJZ4KJ+JHi4GulqjvtTawOdo1+5fc8sOgyCVxTIcEAliYYc2XxRHj/fLzZo3Of/w
 lMVJ3F1HMqIrs6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B8BE132D3;
 Tue, 22 Sep 2026 13:55:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kXhaAseIsmqoFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 22 Sep 2026 13:55:19 +0000
Date: Tue, 22 Sep 2026 15:55:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arKIz5Oygb57INup@yuki.lan>
References: <20260922095126.2169599-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922095126.2169599-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,linux.dev,suse.com,suse.cz,gmail.com];
 RCPT_COUNT_SEVEN(0.00)[8]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] keyctl: Vendor struct keyctl_dh_params
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I think that we should simplify this by including only
include/linux/keyctl.h and do not ever include the include/keyutils.h
from keyutils package.

This should do the trick:

diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index fdb68d172..90ebf88c1 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -10,15 +10,13 @@

 #include <stdint.h>

-#if defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS)
-# include <keyutils.h>
-#else
-# ifdef HAVE_LINUX_KEYCTL_H
-#  include <linux/keyctl.h>
-# endif /* HAVE_LINUX_KEYCTL_H */
-
-# include <stdarg.h>
-# include "lapi/syscalls.h"
+#ifdef HAVE_LINUX_KEYCTL_H
+# include <linux/keyctl.h>
+#endif /* HAVE_LINUX_KEYCTL_H */
+
+#include <stdarg.h>
+#include "lapi/syscalls.h"
+
 typedef int32_t key_serial_t;

 static inline key_serial_t add_key(const char *type,
@@ -59,11 +57,12 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
        return keyctl(KEYCTL_JOIN_SESSION_KEYRING, name);
 }

-#endif /* defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS) */
-
 #ifndef HAVE_STRUCT_KEYCTL_DH_PARAMS
 struct keyctl_dh_params {
-       int32_t priv;
+       union {
+               int32_t priv;
+               int32_t private;
+       };
        int32_t prime;
        int32_t base;
 };

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
