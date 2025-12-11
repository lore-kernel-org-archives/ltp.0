Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB29ED3E792
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 11:51:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 317703CF5CF
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 12:51:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B96F33CF296
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 12:51:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2CBAA600697
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 12:51:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACFD85BDE5;
 Thu, 11 Dec 2025 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765453874;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EFddUhBGcXN9JA0q1wGTn5XlH81Ay9Hq5qFgYVtz16g=;
 b=KYOPmVHua8Fuw8lCzO928INZ6ajFvaBb395R+0TSe0ZkVY0OShfUwHbP/DHSXp1Btu/l40
 nGC1oHhiWBOT4Xido4U6vwSgXhLrEu7qxtRb5Vg3IR3XyKbwF1u5zrEDDwtKqcfbzDGUGz
 YR6rGMoDpADO8JyspVkXrJobbqguVVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765453874;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EFddUhBGcXN9JA0q1wGTn5XlH81Ay9Hq5qFgYVtz16g=;
 b=kPSIHiS54Rft7qvlscdt1ERYj8HV7Ep6UkTrtdVHokwIjbH/+bz2w78W67Du2trXiTosF5
 AO9pABrh9+mJoNDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765453873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EFddUhBGcXN9JA0q1wGTn5XlH81Ay9Hq5qFgYVtz16g=;
 b=NHGyBhabnSVGYRiHx30880kwSaNxLfUjjArCsO3KXCEtwmHdYOi2ipCz7n8tf3cNRXnxuH
 qR38DN8UikzJJ78HGhsvsnEvV9pefbCZCnPuAvWW1op72+NlGII/9Ixb5HHHILLaddhoF1
 DYJ/wzl9F5EVCB/yjjMznyrSm/4Xj44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765453873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EFddUhBGcXN9JA0q1wGTn5XlH81Ay9Hq5qFgYVtz16g=;
 b=8+O2ZwAOGjGfa/z2zgHW8CNz2Xa6iVa+i4UGUkOem8Gx+zdSqxecMUz1HqFKZbIL2f391q
 bjmuyewX8eEpJcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 093463EA63;
 Thu, 11 Dec 2025 11:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QWEDNzCwOmlffQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Dec 2025 11:51:12 +0000
Date: Thu, 11 Dec 2025 12:51:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251211115111.GA63924@pevik>
References: <20251210061957.32631-1-wegao@suse.com>
 <20251211015915.1086-1-wegao@suse.com> <aTqN9fjQhDe4WU45@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aTqN9fjQhDe4WU45@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > @@ -122,7 +136,17 @@ static void run(unsigned int n)
> >  		req->mnt_id = tc->mnt_id;
> >  		req->param = tc->param;
> >  		req->size = tc->size;
> > -		req->spare = tc->spare;
> > +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> > +		if ((tst_kvercmp(6, 18, 0)) >= 0)
> > +			req->mnt_ns_fd = tc->mnt_ns_fd;
> > +		else
> > +			tst_brk(TCONF, "Skipping test, kernel version should be >= 6.18");
> > +#else
> > +		if ((tst_kvercmp(6, 18, 0)) >= 0)
> > +			tst_brk(TCONF, "Skipping test, kernel version should be < 6.18");
> > +		else
> > +			req->spare = tc->spare;
> > +#endif

> I do not like this solution. Here we disable the test on newer kernel if
> it was compiled on older headers and vice versa.

Thanks for catching this up. I had a feeling something is wrong but was not sure
what.

> There are actually two problems to be solved and they are independent of
> each other and we shouldn't mix these two.

> First problem is that the mnt_ns_fd is not defined on older headers.
> That should be fixed by a fallback defintion in lapi/. The spare in
> lapi/mount.h in struct mnt_id_req should be renamed to mnt_ns_fd. And we
> should use that structure if mnt_id_req is not defined in system
> headers. I guess that we can use typedef for that and do something as:

OK, I did not realize that struct size is actually the same, only struct member
has changed so that we can happily pass that to any kernel version.

> struct mnt_id_req_fallback {
> 	uint32_t size;
> 	...
> };

> #if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> typedef struct mnt_id_req_fallback mnt_id_req
> #else
> typedef struct mnd_id_req mnt_id_req
> #endif

> And then use mnt_id_req in test with the guarantee that the mnt_ns_fd is
> always there.

> The second problem is the expected errno. That should be just set once
> based on the kernel version in the test setup().

+1. I was also thinking about moving this to setup to prevent repeated detecting
but was not sure how to do it in elegant way as errno is in the struct. I guess
you mean just to store result of tst_kvercmp(6, 18, 0), but even that is not
enough. The cleanest way looks to me to add another struct member int exp_errno_old:

static bool old_kernel = true;

static struct tcase {
	...
	int exp_errno;
	int exp_errno_old;
}

static void setup()
{
	if ((tst_kvercmp(6, 18, 0)) < 0)
		old_kernel = false;
}

static void run(unsigned int n)
{
	...
	int exp_errno = (tc->exp_errno_old && old_kernel ? tc->exp_errno_old : tc->exp_errno);

	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
		tc->nr_mnt_ids, tc->flags), exp_errno,
		"%s", tc->msg);
	}


Also when looking in the code I'd personally factor out tc->req_usage to make it
obvious	it's not called by first tcases member.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
