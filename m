Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DA5D49230
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 14:21:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D6693CD3FA
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 15:21:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9FD93C7F80
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 15:20:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 619D0200DA7
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 15:20:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EEB7338F0;
 Fri, 12 Dec 2025 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765549248;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qs5Voq1ulp6OodfAF4ITwVTdhftqPVZuDIoJBdj/5D0=;
 b=T3UJ6B7pJTZOtK3KV7nM+T64jf/rLER0VN77zS+Y9SFAzUTbzxHAumKuB+flrweG5Dz225
 Cry3ST3ELZ/f01tK5LbPlPy/B5KWhRdGu1FepDqGu3PqL/Bar3xXCBKYqJzx5EeTJyUvc+
 /ZANaylKR6BaCWXzKu3WmlbIxVbgADY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765549248;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qs5Voq1ulp6OodfAF4ITwVTdhftqPVZuDIoJBdj/5D0=;
 b=+oqSJD38/XqSrSJz8tsyzrBz+pBu+3J0i2Es16Cjgb/L+O6HxhQNE+2piJIbakKyXh/6bN
 QQaDyYdbnoBmQmCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eiuULfcO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/elAeXdW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765549247;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qs5Voq1ulp6OodfAF4ITwVTdhftqPVZuDIoJBdj/5D0=;
 b=eiuULfcOzLNRuObXvSwQiVLp6Nuyi+sB7cU2CMmwzlbM1GQZ7tvEBpiGLqbDBvCt2XQk3L
 m5G7FtNeyBMeqG8P8CrXpdziHHgq76UNbJs5bKQAnrQ/tU9sNDP3tj17GNQS88BEc+jjBc
 uV6l0tO9v9nB3U2/t/vLjCre22OFjXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765549247;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qs5Voq1ulp6OodfAF4ITwVTdhftqPVZuDIoJBdj/5D0=;
 b=/elAeXdWmIj1cej9z1ZhuPq0ethinsxt/S7v3XFvRurQ9z3Rsi3FCk3Xz/2cR+LYghknp7
 +h+Tgx3PTTTamrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FA3A3EA63;
 Fri, 12 Dec 2025 14:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qt4LBr8kPGn+OwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Dec 2025 14:20:47 +0000
Date: Fri, 12 Dec 2025 15:20:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251212142045.GD125889@pevik>
References: <20251211015915.1086-1-wegao@suse.com>
 <20251212115244.2027-1-wegao@suse.com>
 <20251212122827.GC125889@pevik> <aTwREz2-YroAAyl_@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aTwREz2-YroAAyl_@yuki.lan>
X-Rspamd-Queue-Id: 4EEB7338F0
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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

> Hi!
> > > -#ifndef HAVE_STRUCT_MNT_ID_REQ
> > > -struct mnt_id_req {
> > > +struct mnt_id_req_fallback {
> > >  	uint32_t size;
> > > -	uint32_t spare;
> > > +	uint32_t mnt_ns_fd;
> > >  	uint64_t mnt_id;
> > >  	uint64_t param;
> > >  	uint64_t mnt_ns_id;
> > >  };
> > > +
> > > +#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > Shouldn't be !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > !defined(HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD) ?

> > Also, this patchset introduces compilation error on old systems:

> > In file included from listmount03.c:13:0:
> > listmount.h:20:4: error: 'struct mnt_id_req' has no member named 'mnt_id'
> >    .mnt_id = mnt_id,

> > Obviously some definition is wrong.

> That looks like we need configure check for mnt_id too however that
> happens in a different test.

Yes:


Do we still need the check for the struct mnt_id_req now? I'd say no:

-AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
+AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd, struct mnt_id_req.mnt_id],,,[#include <sys/mount.h>])

-#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+#if !defined(HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD) || !defined(HAVE_STRUCT_MNT_ID_REQ_MNT_ID)

But we also need to change listmount.h to use the struct fallback. Full diff is
at the end.

> > https://github.com/pevik/ltp/actions/runs/20166087670/job/57889711762

> > (CI does not work, therefore I pushed you patchset.)

> > > +typedef struct mnt_id_req_fallback mnt_id_req;
> > > +#else
> > > +typedef struct mnt_id_req mnt_id_req;
> > >  #endif

> > ...
> > > +static void setup(void)
> > > +{
> > > +	if (tst_kvercmp(6, 18, 0) >= 0) {
> > > +		tcases[4].exp_errno = EBADF;
> > > +		tcases[4].msg = "invalid mnt_id_req.mnt_ns_fd (EBADF)";

> > Hardcoding array index is asking for problems in the future.

> > That's why I suggested more complicated code in previous version.
> > https://lore.kernel.org/ltp/20251211115111.GA63924@pevik/

> Another solution would be to define testcases for both for EINVAL and
> EBADF and add a flag which should be enabled on newer kernel:

> #define BEFORE_6_18 1
> #define AFTER_6_18 2

> ...
> 	{
>                 .req_usage = 1,
>                 .size = MNT_ID_REQ_SIZE_VER0,
>                 .spare = -1,
>                 .mnt_id = LSMT_ROOT,
>                 .mnt_ids = mnt_ids,
>                 .nr_mnt_ids = MNT_SIZE,
>                 .exp_errno = EINVAL,
>                 .msg = "invalid mnt_id_req.spare",
> 		.kver = BEFORE_6_18,
>         },
> 	{
>                 .req_usage = 1,
>                 .size = MNT_ID_REQ_SIZE_VER0,
>                 .spare = -1,
>                 .mnt_id = LSMT_ROOT,
>                 .mnt_ids = mnt_ids,
>                 .nr_mnt_ids = MNT_SIZE,
>                 .exp_errno = EBADF,
>                 .msg = "invalid mnt_id_req.mnt_nf_fd",
> 		.kver = AFTER_6_18,
>         },
> ...

> static void run(...)
> {
> 	...

> 	if (tc->kver && tc->kver != kver)
> 		return;

Yeah that would work as well, but I suppose TCONF will be needed
due check for results.

> 	...
> }

> static void setup(void)
> {
> 	if (tst_kvercmp(6, 18, 0) >= 0)
> 		kver = AFTER_6_18;
> 	else
> 		kver = BEFORE_6_18;
> }

Kind regards,
Petr

Diff without kernel version change.

+++ configure.ac
@@ -262,8 +262,8 @@ AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
 AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
 
 # Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
-AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
-AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
+#AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
+AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd, struct mnt_id_req.mnt_id],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
 #include <linux/mount.h>])
diff --git include/lapi/mount.h include/lapi/mount.h
index 7b1c4ca0fe..8bde0e563a 100644
--- include/lapi/mount.h
+++ include/lapi/mount.h
@@ -53,7 +53,7 @@ struct mnt_id_req_fallback {
 	uint64_t mnt_ns_id;
 };
 
-#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+#if !defined(HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD) || !defined(HAVE_STRUCT_MNT_ID_REQ_MNT_NS_ID)
 typedef struct mnt_id_req_fallback mnt_id_req;
 #else
 typedef struct mnt_id_req mnt_id_req;
diff --git testcases/kernel/syscalls/listmount/listmount.h testcases/kernel/syscalls/listmount/listmount.h
index aad927f714..74f334c74e 100644
--- testcases/kernel/syscalls/listmount/listmount.h
+++ testcases/kernel/syscalls/listmount/listmount.h
@@ -8,6 +8,7 @@
 
 #define _GNU_SOURCE
 
+#include "config.h"
 #include "tst_test.h"
 #include "lapi/mount.h"
 #include "lapi/syscalls.h"
@@ -15,11 +16,10 @@
 static inline ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
 			 uint64_t list[], size_t num, unsigned int flags)
 {
-	struct mnt_id_req req = {
-		.size = MNT_ID_REQ_SIZE_VER0,
-		.mnt_id = mnt_id,
-		.param = last_mnt_id,
-	};
+	mnt_id_req *req = NULL;
+	req->size = MNT_ID_REQ_SIZE_VER0;
+	req->mnt_id = mnt_id;
+	req->param = last_mnt_id;
 
 	return tst_syscall(__NR_listmount, &req, list, num, flags);
 }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
