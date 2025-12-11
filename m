Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6660DD41C09
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 09:24:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 315F13CF3E5
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 10:24:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F0F63CF002
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 10:24:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D33E21A008BC
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 10:24:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 013495BDD6;
 Thu, 11 Dec 2025 09:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765445051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oXUh0/1WjGkK+91bfjBj45ZJDAAMJim+xphnIxY6J+U=;
 b=dI5vnPe5ENsJR8wkMLqRdLxZkI9PJiLXo5RoFuXH3dyCOccU+6zZZlZbryXxnejNBL0FRV
 tY+hSzE2zW3udJ9A+QTaDdChU+hWbGb0yKyPayP3YnYkrBhEi86oc7ui08Yyvloj8jojeg
 XozFKUrDPbwg3TAJJ+MS1xc3dZH1HFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765445051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oXUh0/1WjGkK+91bfjBj45ZJDAAMJim+xphnIxY6J+U=;
 b=JJ5TQUrqgpwpMXanA/gswRtZ30bX3aVvQSNtSVFDeagfaMUIt451sdJ+wRZfYFwVneh5ca
 WsL3Y69TlMYL7tCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765445050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oXUh0/1WjGkK+91bfjBj45ZJDAAMJim+xphnIxY6J+U=;
 b=OM+9SbcIIAOHCJnpBcAzRK+MyU9Wd4XKequUTGny7kaYmlTISepYcaKQh5dP/1BmD96kuM
 G8jUPT3O8OeCxcwo+lthVsUZ71Z17Y9MsAwKWFro/wfpVhFPTi/0NXKTQsRdxz5ah6DrrL
 7sOAR4pLLMTFyrMJ8V04tygn7PyFLTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765445050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oXUh0/1WjGkK+91bfjBj45ZJDAAMJim+xphnIxY6J+U=;
 b=Ik5hbVKFEko7s/mv0xErLMJs58u1LFl+zm7dMQiTgkZcajH9j6jqA2mTFncaw4RepdhVJ0
 uYtkd5SUiaVxXoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5B833EA63;
 Thu, 11 Dec 2025 09:24:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xdWKMrmNOmnhdgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Dec 2025 09:24:09 +0000
Date: Thu, 11 Dec 2025 10:25:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aTqN9fjQhDe4WU45@yuki.lan>
References: <20251210061957.32631-1-wegao@suse.com>
 <20251211015915.1086-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251211015915.1086-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] listmount04.c: Update case support
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  #define _GNU_SOURCE
>  
> +#include "config.h"
>  #include "tst_test.h"
>  #include "lapi/mount.h"
>  #include "lapi/syscalls.h"
> @@ -26,7 +27,11 @@ static uint64_t mnt_ids[MNT_SIZE];
>  static struct tcase {
>  	int req_usage;
>  	uint32_t size;
> +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> +	uint32_t mnt_ns_fd;
> +#else
>  	uint32_t spare;
> +#endif
>  	uint64_t mnt_id;
>  	uint64_t param;
>  	uint64_t *mnt_ids;
> @@ -73,12 +78,21 @@ static struct tcase {
>  	{
>  		.req_usage = 1,
>  		.size = MNT_ID_REQ_SIZE_VER0,
> +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> +		.mnt_ns_fd = -1,
> +#else
>  		.spare = -1,
> +#endif
>  		.mnt_id = LSMT_ROOT,
>  		.mnt_ids = mnt_ids,
>  		.nr_mnt_ids = MNT_SIZE,
> +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> +		.exp_errno = EBADF,
> +		.msg = "invalid mnt_id_req.mnt_ns_fd bad file descriptor",
> +#else
>  		.exp_errno = EINVAL,
>  		.msg = "invalid mnt_id_req.spare",
> +#endif
>
>  	},
>  	{
>  		.req_usage = 1,
> @@ -122,7 +136,17 @@ static void run(unsigned int n)
>  		req->mnt_id = tc->mnt_id;
>  		req->param = tc->param;
>  		req->size = tc->size;
> -		req->spare = tc->spare;
> +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> +		if ((tst_kvercmp(6, 18, 0)) >= 0)
> +			req->mnt_ns_fd = tc->mnt_ns_fd;
> +		else
> +			tst_brk(TCONF, "Skipping test, kernel version should be >= 6.18");
> +#else
> +		if ((tst_kvercmp(6, 18, 0)) >= 0)
> +			tst_brk(TCONF, "Skipping test, kernel version should be < 6.18");
> +		else
> +			req->spare = tc->spare;
> +#endif

I do not like this solution. Here we disable the test on newer kernel if
it was compiled on older headers and vice versa.

There are actually two problems to be solved and they are independent of
each other and we shouldn't mix these two.

First problem is that the mnt_ns_fd is not defined on older headers.
That should be fixed by a fallback defintion in lapi/. The spare in
lapi/mount.h in struct mnt_id_req should be renamed to mnt_ns_fd. And we
should use that structure if mnt_id_req is not defined in system
headers. I guess that we can use typedef for that and do something as:

struct mnt_id_req_fallback {
	uint32_t size;
	...
};

#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
typedef struct mnt_id_req_fallback mnt_id_req
#else
typedef struct mnd_id_req mnt_id_req
#endif

And then use mnt_id_req in test with the guarantee that the mnt_ns_fd is
always there.

The second problem is the expected errno. That should be just set once
based on the kernel version in the test setup().

>  	}
>  
>  	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
