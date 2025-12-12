Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38587D49220
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 12:56:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9474D3C8660
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 13:56:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EF4A3C7F80
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 13:55:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 68A3A14010DD
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 13:55:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D06233922;
 Fri, 12 Dec 2025 12:55:50 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CEEF3EA63;
 Fri, 12 Dec 2025 12:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2SPsEdYQPGn/bAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Dec 2025 12:55:50 +0000
Date: Fri, 12 Dec 2025 13:56:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aTwREz2-YroAAyl_@yuki.lan>
References: <20251211015915.1086-1-wegao@suse.com>
 <20251212115244.2027-1-wegao@suse.com>
 <20251212122827.GC125889@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251212122827.GC125889@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5D06233922
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > -#ifndef HAVE_STRUCT_MNT_ID_REQ
> > -struct mnt_id_req {
> > +struct mnt_id_req_fallback {
> >  	uint32_t size;
> > -	uint32_t spare;
> > +	uint32_t mnt_ns_fd;
> >  	uint64_t mnt_id;
> >  	uint64_t param;
> >  	uint64_t mnt_ns_id;
> >  };
> > +
> > +#if !defined(HAVE_STRUCT_MNT_ID_REQ) || !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> Shouldn't be !HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> !defined(HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD) ?
> 
> Also, this patchset introduces compilation error on old systems:
> 
> In file included from listmount03.c:13:0:
> listmount.h:20:4: error: 'struct mnt_id_req' has no member named 'mnt_id'
>    .mnt_id = mnt_id,
> 
> Obviously some definition is wrong.

That looks like we need configure check for mnt_id too however that
happens in a different test.

> https://github.com/pevik/ltp/actions/runs/20166087670/job/57889711762
> 
> (CI does not work, therefore I pushed you patchset.)
> 
> > +typedef struct mnt_id_req_fallback mnt_id_req;
> > +#else
> > +typedef struct mnt_id_req mnt_id_req;
> >  #endif
> 
> ...
> > +static void setup(void)
> > +{
> > +	if (tst_kvercmp(6, 18, 0) >= 0) {
> > +		tcases[4].exp_errno = EBADF;
> > +		tcases[4].msg = "invalid mnt_id_req.mnt_ns_fd (EBADF)";
> 
> Hardcoding array index is asking for problems in the future.
> 
> That's why I suggested more complicated code in previous version.
> https://lore.kernel.org/ltp/20251211115111.GA63924@pevik/

Another solution would be to define testcases for both for EINVAL and
EBADF and add a flag which should be enabled on newer kernel:

#define BEFORE_6_18 1
#define AFTER_6_18 2

...
	{
                .req_usage = 1,
                .size = MNT_ID_REQ_SIZE_VER0,
                .spare = -1,
                .mnt_id = LSMT_ROOT,
                .mnt_ids = mnt_ids,
                .nr_mnt_ids = MNT_SIZE,
                .exp_errno = EINVAL,
                .msg = "invalid mnt_id_req.spare",
		.kver = BEFORE_6_18,
        },
	{
                .req_usage = 1,
                .size = MNT_ID_REQ_SIZE_VER0,
                .spare = -1,
                .mnt_id = LSMT_ROOT,
                .mnt_ids = mnt_ids,
                .nr_mnt_ids = MNT_SIZE,
                .exp_errno = EBADF,
                .msg = "invalid mnt_id_req.mnt_nf_fd",
		.kver = AFTER_6_18,
        },
...

static void run(...)
{
	...

	if (tc->kver && tc->kver != kver)
		return;

	...
}

static void setup(void)
{
	if (tst_kvercmp(6, 18, 0) >= 0)
		kver = AFTER_6_18;
	else
		kver = BEFORE_6_18;
}


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
