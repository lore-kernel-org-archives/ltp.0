Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC70C982FF
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 08:55:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D53A3E6C71
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 10:55:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E65523E5DB9
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 10:55:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 04F5E10009EF
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 10:55:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80BFF1FF80;
 Tue, 22 Sep 2026 08:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790067324;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qEytLNZpglr3EqTj+04Tp5WaBRHvRmfajN16SCS0V5U=;
 b=xyKcQNE7W2l550lSBkLXycD08Ej6amoshILhJfuWuq0tQf3Z1c0YDDExKVspuk1IED9eSg
 uhx1UexssXjmgYmFM/AQ9cc+pLhZPLlTpzkQUPxlFm+oDefEoXJUkLBNaN+1/0XmEieZPL
 d5vFweSn1qigA1rmyuZ9+xEJRezn8gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790067324;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qEytLNZpglr3EqTj+04Tp5WaBRHvRmfajN16SCS0V5U=;
 b=zUyyLkyKod70WLI3V73Xjp/jHlOJvUlG/aRnR5i7caLZKi6bicIqVag3yti4bn0A9aapfp
 Nnp84NaCL+ELEfDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zPxhDnKI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pXZQwEeq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790067320;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qEytLNZpglr3EqTj+04Tp5WaBRHvRmfajN16SCS0V5U=;
 b=zPxhDnKIu1bXQhWFT8Y41BLiccaVginepYMCKoegFSMQ2H4LnM5bqJgdnzCKAOrcfgXeDJ
 Gq7TI6nhVE6PBIvEZveRCWq+A8Bx41P+IZpX2YRU7esgBNzvEDDZfqC5CoXLoJNSz+BCY6
 0/d2RTZ4cdNyE0WC9+q98j8GzelsIp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790067320;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qEytLNZpglr3EqTj+04Tp5WaBRHvRmfajN16SCS0V5U=;
 b=pXZQwEeqoSL65MWMRHneHNJoUaH/se5HgneI3g5UoBZWaph68m5MzqGAzxLCDjc8WXATIr
 eyEwxGTrLykMVsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12C27139EE;
 Tue, 22 Sep 2026 08:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GjtsMndCsmr+PwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 08:55:20 +0000
Date: Tue, 22 Sep 2026 10:55:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Li Wang <li.wang@linux.dev>, Avinesh Kumar <avinesh.kumar@suse.com>,
 Wei Gao <wegao@suse.com>, Andrea Cervesato <andrea.cervesato@suse.com>,
 linuxtestproject.agent@gmail.com
Message-ID: <20260922085514.GA2150285@pevik>
References: <20260921111407.2137467-1-pvorel@suse.cz>
 <arEagQKsecxyn8dy@yuki.lan> <20260921133613.GA2143203@pevik>
 <20260921134111.GB2143203@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260921134111.GB2143203@pevik>
X-Rspamd-Queue-Id: 80BFF1FF80
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[suse.cz,lists.linux.it,linux.dev,suse.com,gmail.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCPT_COUNT_SEVEN(0.00)[8];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lapi/keyctl.h: Fix compilation on old kernel
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > > Hi!
> > > > diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
> > > > index fdb68d1725..e1e46b7865 100644
> > > > --- a/include/lapi/keyctl.h
> > > > +++ b/include/lapi/keyctl.h
> > > > @@ -69,6 +69,12 @@ struct keyctl_dh_params {
> > > >  };
> > > >  #endif

> > > > +/* Fix for kernel < v4.20 */
> > > > +#if defined(HAVE_STRUCT_KEYCTL_DH_PARAMS) && \
> > > > +	!defined(HAVE_STRUCT_KEYCTL_DH_PARAMS_PRIV)
> > > > +# define priv private
> > > > +#endif

> > > I do not like this one, we may end up redefining wrong priv and break
> > > everything.

> > > Given that the private stil exists in the structure for C code:

> > > (/usr/include/linux/keyctl.h)
> > > /* keyctl structures */
> > > struct keyctl_dh_params {
> > >         union {
> > > #ifndef __cplusplus
> > >                 __s32 private;
> > > #endif
> > >                 __s32 priv;
> > >         };
> > >         __s32 prime;
> > >         __s32 base;
> > > };

FYI the userspace keyutils.h uses only priv [1]:

struct keyctl_dh_params {
	key_serial_t priv;
	key_serial_t prime;
	key_serial_t base;
};

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/tree/keyutils.h

> > > We may as well use private in the tests consistently and update our
> > > fallback with the union as well.

Thinking about it twice, I think the original solution is safe enough, based on
autotools check. As I wrote before if you really don't want it, we'd need to
vendor the struct. At that point we don't need private.

Look at the diff I posted (I can post it officially as v2). The cons is
maintaining the struct (but we do it for the fallback anyway). Pros is getting
rid some of autotools checks (small speedup).

WDYT?

Kind regards,
Petr

> > When I looked in the struct in UAPI I considered define better, but indeed
> > mirroring UAPI the same way is really better.

> > I'll retest it and send v2.

> Just the only thing - we will need to have to use our custom struct
> e.g.  ltp_keyctl_dh_params (similarly to ltp_statx), because the problem is on
> the code which defines struct keyctl_dh_params, but without that fallback.

> Kind regards,
> Petr

> > Kind regards,
> > Petr

diff --git include/lapi/keyctl.h include/lapi/keyctl.h
index fdb68d1725..d1cea85aba 100644
--- include/lapi/keyctl.h
+++ include/lapi/keyctl.h
@@ -61,13 +61,11 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 
 #endif /* defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS) */
 
-#ifndef HAVE_STRUCT_KEYCTL_DH_PARAMS
-struct keyctl_dh_params {
+struct ltp_keyctl_dh_params {
 	int32_t priv;
 	int32_t prime;
 	int32_t base;
 };
-#endif
 
 #ifndef HAVE_STRUCT_KEYCTL_KDF_PARAMS
 struct keyctl_kdf_params {
diff --git m4/ltp-keyutils.m4 m4/ltp-keyutils.m4
index 35bad783e5..b073183405 100644
--- m4/ltp-keyutils.m4
+++ m4/ltp-keyutils.m4
@@ -9,9 +9,6 @@ AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
 	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.])
 	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
 
-	AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
-			struct keyctl_pkey_query, struct keyctl_pkey_params],,,
+	AC_CHECK_TYPES([struct keyctl_kdf_params, struct keyctl_pkey_query, struct keyctl_pkey_params],,,
 			[#include <linux/keyctl.h>])
-
-	AC_CHECK_MEMBERS([struct keyctl_dh_params.priv],,,[#include <linux/keyctl.h>])
 ])
diff --git testcases/kernel/syscalls/keyctl/keyctl25.c testcases/kernel/syscalls/keyctl/keyctl25.c
index d1aa3425d4..a99503183a 100644
--- testcases/kernel/syscalls/keyctl/keyctl25.c
+++ testcases/kernel/syscalls/keyctl/keyctl25.c
@@ -15,7 +15,7 @@
 #include "keyctl_common.h"
 #include "keyctl_dh_data.h"
 
-static struct keyctl_dh_params *dh_params;
+static struct ltp_keyctl_dh_params *dh_params;
 static unsigned char out_buf[256];
 
 static void setup(void)
diff --git testcases/kernel/syscalls/keyctl/keyctl26.c testcases/kernel/syscalls/keyctl/keyctl26.c
index bdd852fb4c..df80aadb6c 100644
--- testcases/kernel/syscalls/keyctl/keyctl26.c
+++ testcases/kernel/syscalls/keyctl/keyctl26.c
@@ -15,7 +15,7 @@
 #include "keyctl_common.h"
 #include "keyctl_dh_data.h"
 
-static struct keyctl_dh_params *dh_params;
+static struct ltp_keyctl_dh_params *dh_params;
 
 static void setup(void)
 {
diff --git testcases/kernel/syscalls/keyctl/keyctl27.c testcases/kernel/syscalls/keyctl/keyctl27.c
index 13a1538ce6..0ecf7dc389 100644
--- testcases/kernel/syscalls/keyctl/keyctl27.c
+++ testcases/kernel/syscalls/keyctl/keyctl27.c
@@ -19,7 +19,7 @@
 
 #define KDF_OTHERINFO	"LTP-KDF-TEST-INFO"
 
-static struct keyctl_dh_params *dh_params;
+static struct ltp_keyctl_dh_params *dh_params;
 static struct keyctl_kdf_params *kdf_params;
 static unsigned char out_buf[32];
 
diff --git testcases/kernel/syscalls/keyctl/keyctl28.c testcases/kernel/syscalls/keyctl/keyctl28.c
index 4c7f6be17e..53a59322b4 100644
--- testcases/kernel/syscalls/keyctl/keyctl28.c
+++ testcases/kernel/syscalls/keyctl/keyctl28.c
@@ -21,9 +21,9 @@
 #include "keyctl_common.h"
 #include "keyctl_dh_data.h"
 
-static struct keyctl_dh_params *dh_params;
-static struct keyctl_dh_params *dh_bogus_prime;
-static struct keyctl_dh_params *dh_nonuser_prime;
+static struct ltp_keyctl_dh_params *dh_params;
+static struct ltp_keyctl_dh_params *dh_bogus_prime;
+static struct ltp_keyctl_dh_params *dh_nonuser_prime;
 
 static struct keyctl_kdf_params *kdf_valid;
 static struct keyctl_kdf_params *kdf_spare_nonzero;
@@ -33,7 +33,7 @@ static struct keyctl_kdf_params *kdf_unknown_hash;
 static unsigned char out_buf[1025];
 
 static struct tcase {
-	struct keyctl_dh_params **params;
+	struct ltp_keyctl_dh_params **params;
 	void *buffer;
 	size_t buflen;
 	struct keyctl_kdf_params **kdf;
@@ -105,7 +105,7 @@ static void setup(void)
 static void verify_negative(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
-	struct keyctl_dh_params *p = *tc->params;
+	struct ltp_keyctl_dh_params *p = *tc->params;
 	struct keyctl_kdf_params *kdf = tc->kdf ? *tc->kdf : NULL;
 
 	TST_EXP_FAIL2(keyctl(KEYCTL_DH_COMPUTE, (unsigned long)p,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
