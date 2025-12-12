Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5A9D4922D
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 15:12:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38F463C9E6B
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 16:12:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 524E23C5373
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 16:12:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AAB3A1000DBD
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 16:12:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07311338F0;
 Fri, 12 Dec 2025 15:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765552319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCm40Onp5aTckklHcOVAaGC9RUQruiGHZbGWqzXQWLA=;
 b=hKNdrdMtFhsDETqlAvNSoGdOSzM+XMbe1ayjMsnlBrndrXDSVRFi/kjJqhiPl3ORE7GHea
 R8WVA9sKi7fBfl2lkI0g8ras0CFTl8X5GcrqgFKtepE0AtvVI/+skUQgLjAyRicHOw4dKc
 /qjnemE8MhyDjwDABGVd3JQ3Mr0vge0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765552319;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCm40Onp5aTckklHcOVAaGC9RUQruiGHZbGWqzXQWLA=;
 b=dHK2csMj9XnsLoMZfN0Q784Ylo6PE23YLki1OtgU1XI9+Dr1f9ImBb4N12dqJfyRiFC6OX
 gmBqWqj2p8q6mfDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="O8/siHZa";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HuleXgEm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765552318;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCm40Onp5aTckklHcOVAaGC9RUQruiGHZbGWqzXQWLA=;
 b=O8/siHZaFz1xToVkOQA/q5nBgU4uXh+66tvF/+gSRuwt+9nmIVXgGpI5RmBPRnnrCd0kTW
 hd4+DhGNSbXXh6x5AcwvlYhXZ8pGdSE+oJWPhTDx1SjemdjKeHCb4MmvB/xXkLTFyeGmNz
 55qn5x5lCOUSsUGgutv7U2nNBz5Lq+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765552318;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCm40Onp5aTckklHcOVAaGC9RUQruiGHZbGWqzXQWLA=;
 b=HuleXgEmGAd3otGt2uXWQ0T3MRNlJ63SH74fmi0I1nfsT8KuA0NMoaDbFlXxn+7Mcqu7H/
 +jd0ZGhy7KozbcAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D373A3EA63;
 Fri, 12 Dec 2025 15:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Wny6Mr0wPGmCagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Dec 2025 15:11:57 +0000
Date: Fri, 12 Dec 2025 16:11:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Wei Gao <wegao@suse.com>,
 ltp@lists.linux.it, Li Wang <liwang@redhat.com>
Message-ID: <20251212151156.GF125889@pevik>
References: <20251211015915.1086-1-wegao@suse.com>
 <20251212115244.2027-1-wegao@suse.com>
 <20251212122827.GC125889@pevik> <aTwREz2-YroAAyl_@yuki.lan>
 <20251212142045.GD125889@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251212142045.GD125889@pevik>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 07311338F0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi!
> > > > -#ifndef HAVE_STRUCT_MNT_ID_REQ
> > > > -struct mnt_id_req {
> > > > +struct mnt_id_req_fallback {
> > > >  	uint32_t size;
> > > > -	uint32_t spare;
> > > > +	uint32_t mnt_ns_fd;
> > > >  	uint64_t mnt_id;
> > > >  	uint64_t param;
> > > >  	uint64_t mnt_ns_id;
> > > >  };
> > > > +
> > > > +#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > > Shouldn't be !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > > !defined(HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD) ?

> > > Also, this patchset introduces compilation error on old systems:

> > > In file included from listmount03.c:13:0:
> > > listmount.h:20:4: error: 'struct mnt_id_req' has no member named 'mnt_id'
> > >    .mnt_id = mnt_id,

> > > Obviously some definition is wrong.

> > That looks like we need configure check for mnt_id too however that
> > happens in a different test.

> Yes:

Actually no, the problem was that typedef expects using pointer.
And we now need to use it in all tests, therefore listmount.h needs to be
updated.

Below is diff (without handling different errno).

Kind regards,
Petr

diff --git configure.ac configure.ac
index fcff907991..2866ee981d 100644
--- configure.ac
+++ configure.ac
@@ -172,6 +172,9 @@ AC_CHECK_FUNCS_ONCE([ \
 ])
 AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
 
+# Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
+AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
+
 AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
 AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
 AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
@@ -261,9 +264,6 @@ AC_CHECK_TYPES([struct mount_attr],,,[
 AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
 AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
 
-# Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
-AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
-AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
 #include <linux/mount.h>])
diff --git include/lapi/mount.h include/lapi/mount.h
index 7b1c4ca0fe..5d9ccde28d 100644
--- include/lapi/mount.h
+++ include/lapi/mount.h
@@ -53,7 +53,7 @@ struct mnt_id_req_fallback {
 	uint64_t mnt_ns_id;
 };
 
-#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
+#ifndef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_ID
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
