Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863FCC3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 11:13:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C38C43CC2C3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 13:13:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E0823CC26C
 for <ltp@lists.linux.it>; Mon, 12 May 2025 13:13:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5989E600810
 for <ltp@lists.linux.it>; Mon, 12 May 2025 13:13:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9879621186;
 Mon, 12 May 2025 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747048404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=knvRdRJprZVv+ar4TbCjAgE6j36Km6BEUWe/NvWinwg=;
 b=UzfGB1xWZzK7ICk8B9tKGT+EyaAQGJkxpgIvSwJP04uSv4Z9rsgPHD9KrcBUJHKeNn6kvZ
 5OKFHfGJY3RniOS/iaiQ00RBLZV0SlfOwur94tP+UKzmg+elqDA0bqlgp2rTLapesH30WI
 0SqOx0k5CSwU3B4hg0K+LNPcjQiqGG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747048404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=knvRdRJprZVv+ar4TbCjAgE6j36Km6BEUWe/NvWinwg=;
 b=IK7EinHE/wEdR+UQQYPKj5mkYgLCYv91UKUCMn8ZjdETjLxaHlYKUzEQi0nWZdzig75h99
 iVUUFltFOVD/XbAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UzfGB1xW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IK7EinHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747048404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=knvRdRJprZVv+ar4TbCjAgE6j36Km6BEUWe/NvWinwg=;
 b=UzfGB1xWZzK7ICk8B9tKGT+EyaAQGJkxpgIvSwJP04uSv4Z9rsgPHD9KrcBUJHKeNn6kvZ
 5OKFHfGJY3RniOS/iaiQ00RBLZV0SlfOwur94tP+UKzmg+elqDA0bqlgp2rTLapesH30WI
 0SqOx0k5CSwU3B4hg0K+LNPcjQiqGG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747048404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=knvRdRJprZVv+ar4TbCjAgE6j36Km6BEUWe/NvWinwg=;
 b=IK7EinHE/wEdR+UQQYPKj5mkYgLCYv91UKUCMn8ZjdETjLxaHlYKUzEQi0nWZdzig75h99
 iVUUFltFOVD/XbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 893D1137D2;
 Mon, 12 May 2025 11:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9T9VINTXIWjGZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 12 May 2025 11:13:24 +0000
Date: Mon, 12 May 2025 13:13:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aCHX9rcKFhQKbxuM@yuki.lan>
References: <20250510205326.1353857-1-wegao@suse.com>
 <CAEemH2cJHz3aLRi0HeSvJWy=XvPMfJ_nv0F7=L7P2ubn8-zv5A@mail.gmail.com>
 <aCGyTkkA6iSQHNzg@yuki.lan>
 <CAEemH2fbbqZU0ir-9YQ6wh2v+6EXveOr3NRkjhk0MK1ipF_xkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fbbqZU0ir-9YQ6wh2v+6EXveOr3NRkjhk0MK1ipF_xkw@mail.gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9879621186
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix: dirtyc0w_shmem child process exit with
 error due to uninitialized lib_pid
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
> I think we'd better move them into a new structure dedicated to storing
> library infrastructure.

Sounds good.

> > > As LTP library already provides a tst_reinit() function for child
> > processes
> > > spawned via exec()/execlp() to restore their test context.
> > >
> > > We could consider two approaches:
> > >
> > > 1. Create a separate IPC region to store infrastructure state(e.g.,
> > > main_pid, lib_pid)
> > > in a new struct tst_meta_info. The child can then access this data via
> > > tst_reinit()
> > > without modifying the struct results.
> >
> > I would like to keep a single IPC region because we have to pass a
> > path to it to all children too.
> >
> > Also given that the minimal amount of memory we can allocate for IPC is
> > a page we can as well have two structures, one for data and one for
> > library infrastructure bits and place these structures in there
> > manually. All we need to do is to make sure that we place them at
> > aligned offsets.
> >
> 
> Yes, that was my thought as well. Something maybe like:
> 
> #define LTP_MAGIC 0x4C54504D

I suppose that we will check this in the tst_reinit() right? That is
nice improvement.

> struct context {
>         pid_t main_pid;
>         pid_t lib_pid;
>         struct timespec tst_start_time;
>         /*
>          * This is set by a call to tst_brk() with TBROK parameter and means
>          * that the test should exit immediately.
>          */
>         unsigned int runtime;
>         unsigned int overall_time;
>         int abort_flag;
>         int mntpoint_mounted;
>         int ovl_mounted;
>         int tdebug;
> };
> 
> struct results {
>         int passed;
>         int skipped;
>         int failed;
>         int warnings;
>         int broken;
> };
> 
> static struct ipc_block {
>         unsigned int magic;
>         struct context context;
>         struct results results;
>         futex_t futexes[];
> };

Maybe it would make sense to switch to the uint32_t and int32_t here
when we are doing the cleanup. Currently we we call tst_reinit() from a
32bit process and the parent was 64bit it wouldn't work at all. We do
not have tests like that at the moment but we may possibly end up in
this situation later on.

> static struct ipc_block *ipc = NULL;
> static struct context *context = NULL;
> static struct results *results = NULL;
> 
> #define TST_CONTEXT(ipc) ((struct context *)&(ipc)->context)
> #define TST_RESULTS(ipc) ((struct results *)&(ipc)->results)
> #define TST_FUTEXES(ipc) ((futex_t *)(ipc)->futexes)

Is there a reason for these macros? The types should be correct, so
there should be no need for the casts.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
