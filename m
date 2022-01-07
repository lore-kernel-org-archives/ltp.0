Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2262AC433EF
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 07:33:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5DFB3C91BB
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 08:33:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7F473C042E
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 08:33:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2F9281A0113A
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 08:33:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 176E9212B8;
 Fri,  7 Jan 2022 07:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641540808;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGNQhe+/HCVBoityOiEIlZzYMZOEDTyiZK44NAY/Y+8=;
 b=i2OdcizhLO5ywrt4Zxr07lpcoD/ea1nVhrqmh7QgpgswvDXfCD1AOLruo5/avzHKgS1rkC
 5Qjo/V4NQWO3Feh7LyryBOupt4TQxsoTPvNd8N0etwy0ziJEpwwvA5F+tr1mcy1/p4Q24q
 K1D7S9OTNG3pw51wgqhxNT9mU9ac7jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641540808;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGNQhe+/HCVBoityOiEIlZzYMZOEDTyiZK44NAY/Y+8=;
 b=8NnGDY082GzXrqMjfnsqIK+AFjopLtJtTbFLdzGPOgu/yiksoS0s2WVbBz9+dYLqq4mTBH
 4ca9bZ3LkBFhhOBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB6E513CA1;
 Fri,  7 Jan 2022 07:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fuvLM8fs12EdJAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jan 2022 07:33:27 +0000
Date: Fri, 7 Jan 2022 08:33:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YdfsxgQDX4Y63ZVb@pevik>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
 <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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

> Hi all,

> On Thu, Jan 6, 2022 at 7:17 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> > > +| 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).

> > > +| 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
> > > +                             default value is comma.


> > > +     for kconfig_i in $(seq $kconfig_max); do
> > > +             eval "local kconfig$kconfig_i"
> > > +             eval "kconfig$kconfig_i='$(echo "$kconfigs" | cut -d"$TST_NEEDS_KCONFIGS_IFS" -f$kconfig_i)'"
> > > +     done

> > This part is a bit ugly, I guess that it may as well be easier to
> > process in C. A long as we pass it as:

> > tst_check_kconfigs "$TST_NEEDS_KCONFIGS_IFS" "$TST_NEEDS_KCONFIGS"

> > We can easily split the TST_NEEDS_KCONFIGS with strchr() and single
> > loop.

> +1

> I even don't think we need that 'TST_NEEDS_KCONFIGS_IFS'
> variable for users. More flexible means more complicated to some
> degree, if achieve a C process,  we can handle that by accepting
> whatever the delimiter.
I suppose any string can be part of kconfig, thus it'd be safer to be able to
redefine delimiter. But yes, TST_NEEDS_KCONFIGS_IFS should be for using in tests
(thus TST_ prefix).

Kind regards,
Petr

> But strictly usage with a comma is enough for current kernel configs
> parsing I guess.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
