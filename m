Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFAAC433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 12:30:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D3DD3C9C85
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 13:30:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0F473C9C2E
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 13:29:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 485FD1A011C3
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 13:29:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7421F210FA;
 Wed,  9 Feb 2022 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644409798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sgwU8ScuSSPOj4vSldnAmF/5MG8jsYxJd11Jbap1aHY=;
 b=u0/t4fQ0398O82xqhw28q/JH11XCE8D1a1n/dkSEgl/WqyokoYMhmDSYtysEHFsVImYeg4
 xSM7OzlkhoJxlPaxqBCjcOGnQ8ID2cinO5TjGnmHQMKkWk8/3xOkTNySKFI8+afT9s8nUh
 We7IbLe8OacZYISGlZtp0CKXMFwooaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644409798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sgwU8ScuSSPOj4vSldnAmF/5MG8jsYxJd11Jbap1aHY=;
 b=u80xLCV33217MwBWv+pYiDwDwQkfW2oDQpHa9QTB4+UnHMwjM56j3IKnpHtQ1pLZHnjMeU
 lHZesjagui4lErDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5312C13D2F;
 Wed,  9 Feb 2022 12:29:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wqi0EsazA2L+JwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Feb 2022 12:29:58 +0000
Date: Wed, 9 Feb 2022 13:29:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YgOzwASHXaQZtFII@rei>
References: <20220127094925.1619-1-andrea.cervesato@suse.de>
 <YgOXUL6S8yien+Xn@rei>
 <CAASaF6y3=gRaqxA8FnJ2DnA6sXhox7g1e40un6mvvrriDv2RvA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6y3=gRaqxA8FnJ2DnA6sXhox7g1e40un6mvvrriDv2RvA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite process_vm_readv03.c test with new LTP
 API
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > -static void gen_random_arr(int *arr, int arr_sz)
> > > +static void create_data_size(int *arr, int arr_sz, int buffsize)
> > >  {
> > >       long bufsz_left, bufsz_single;
> > >       int i;
> > >
> > > -     bufsz_left = bufsz;
> > > +     bufsz_left = buffsize;
> > >       for (i = 0; i < arr_sz - 1; i++) {
> > > -             bufsz_single = rand() % (bufsz_left / 2) + 1;
> > > +             bufsz_single = rand() % ((bufsz_left / 2) + 1);
> >
> > It was correct before you added the parenthesis, the + 1 was there to
> > make sure we do not end up with an empty buffer if rand() returned
> > multiple of bufsz_left/2.
> 
> I think that was to avoid the case you described below (modulo by zero),
> zero iov_len appears allowed, so it may be interesting to let it be tested too.
> (if bufsize and nriovecs allow such combination as you pointed out)

The iovec can work with zero len buffers just fine, I would add a
special handling for when the buffer is allocated though.

Also the changes of getting zero size buffer is very low unless we have
a case where the bufsize is close to nriovec. So I would really be for
adding a table with different combinations of bufsize, local_iovec,
remote_iovec and let the test loop over that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
