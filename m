Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1999C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 08:29:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4992D3C8C3E
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 09:29:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11FC93C0B90
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 09:29:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7E72060206C
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 09:29:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 593F01F3C3;
 Tue, 14 Dec 2021 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639470583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWYeIOYqzBTTDgRtxYoOh57UWJHc9Z2LidTScD+Nuzg=;
 b=iQQcn1nYPOyW2TR7znqMF7nEpLBd/hT15pz3wculNhbnPBQbjI54twxlxvucN/0oBCiBZO
 G0ZukBaurUldzB8zBBmi2fFGDHqWowCWm6iUo+da3W1k/p4A6lmr7BmalWrGdyV1+196rv
 ApvhPxAc71aiWG5aeN3Zvi8Nl0RlCe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639470583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWYeIOYqzBTTDgRtxYoOh57UWJHc9Z2LidTScD+Nuzg=;
 b=IQOuCgnyr7bLqJ9IRykvp+MQqSi6wFW4rutYfMhrWE5jxQcaa10y0REChAPttufB2VQgHz
 Bny4P5jGLILAzDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 378BC13A1E;
 Tue, 14 Dec 2021 08:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T3zQC/dVuGG1EwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Dec 2021 08:29:43 +0000
Date: Tue, 14 Dec 2021 09:29:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YbhV9VIv/8o97O6r@pevik>
References: <20211213193419.13414-1-pvorel@suse.cz>
 <CAEemH2dp55yFvaXhq_5e77k6QBnY0aFU5fhz4TjW82bkbwwDiA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dp55yFvaXhq_5e77k6QBnY0aFU5fhz4TjW82bkbwwDiA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Add support for debugging
 .all_filesystems
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> On Tue, Dec 14, 2021 at 3:34 AM Petr Vorel <pvorel@suse.cz> wrote:

> > LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE environment variable tests only that
> > filesystem instead of all supported filesystems.

...
> > +++ b/doc/user-guide.txt
...
> > 'TST_NEEDS_DEVICE=1').
> > +| 'LTP_ALL_FILESYSTEMS_ONLY_FS_TYPE' | Testing only specified filesystem
> > instead all
> > +                          supported (for tests with '.all_filesystems').

> My only concern is that the variable name is too long and not easy
> to remember/understand usage. Can we find a better name?
>     LTP_ONE_FS_TYPE
>     LTP_ASGD_FD_TYPE
>     LTP_FS_TYPE_DEBUG
Yes, it's too long. LTP_FS_TYPE_DEBUG sounds best to me, but no strong opinion
about it.

If we agree we want this, we can consider to use some switch instead or print
this variable in help output (-h), with other variables from
https://github.com/linux-test-project/ltp/wiki/User-Guidelines.

> or some else.

> P.s.
> And btw I often use .skip_filesystems skip other FS for debugging :).
I do use it as well, but it's I wanted to have way to debug single filesystem
without having to recompile (easier on embedded or non-intel platforms run via
some frameworks).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
