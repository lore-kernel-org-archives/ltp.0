Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A622EB64D8
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 10:06:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 631B33CD97D
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 12:06:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B59983C9A31
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 12:06:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3BBDF1000228
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 12:06:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E198A20495;
 Thu, 22 Jun 2023 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687428360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMyf5boxSq5m9L4E97uoyk9mpqLdH9FxZusTLkKwVNY=;
 b=KWpfwmftw1gyZBz2YLpje82Ue4XQBjygsy8t8rz8dK7MeHh1430wBaENOcq3ijUZc7DvL4
 CtkPpTyiJcBMRhxw0wSqnqtU9GUXjgAdmwlgh6g4h7PfWeUs9tRKX2LqW5x6WLs/coRZv3
 INFWZfQf2fS1K+TTVMJGlRe3CxnaQPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687428360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMyf5boxSq5m9L4E97uoyk9mpqLdH9FxZusTLkKwVNY=;
 b=BcMI6kio3fQ/17wpcPIafpBEpizT5hHHNRcHDGnlpIVhITA+H+3SPIG7qF5Gwv6GyFpB2R
 eIKfR5ZmfGjlXiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B363E13905;
 Thu, 22 Jun 2023 10:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XfuxKAgdlGRmNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Jun 2023 10:06:00 +0000
Date: Thu, 22 Jun 2023 12:05:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230622100559.GC482307@pevik>
References: <20230601105127.55155-1-liwang@redhat.com>
 <20230621083506.GC361973@pevik>
 <CAEemH2dQwL10cg3M8Pe3e=Q6X8nmVKtkpSZdv7X6ZFh4gFUNgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dQwL10cg3M8Pe3e=Q6X8nmVKtkpSZdv7X6ZFh4gFUNgQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mem: make use of save_restore to simplify code
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

Hi Li,

...
> > Also third parameter of set_sys_tune() (check) is 0.


> The checks inside set_sys_tuen() can NOT guarantee the
> "overcommit_memory" knob is exist or not, it only examines if the
> value was being set correctly, because set_sys_tune has first use
> SAFE_FILE_PRINTF which will TBROK directly when the knob non-exist.

Ah, thanks for correcting me.


> > > -     if (old_overcommit_ratio != -1)
> > > -             set_sys_tune("overcommit_ratio", old_overcommit_ratio, 0);
> > > -}
> > > -
> > >  static void overcommit_memory_test(void)
> > >  {

> > > @@ -269,6 +255,10 @@ static struct tst_test test = {
> > >               {}
> > >       },
> > >       .setup = setup,
> > > -     .cleanup = cleanup,
> > >       .test_all = overcommit_memory_test,
> > > +     .save_restore = (const struct tst_path_val[]) {
> > > +             {"/proc/sys/vm/overcommit_memory", NULL, TST_SR_TBROK},
> > > +             {"/proc/sys/vm/overcommit_ratio", NULL, TST_SR_TBROK},
> > => shouldn't be here TST_SR_TCONF instead of TST_SR_TBROK?


> It doesn't matter, I indeed consider this before, but after looking
> through the rest mm tests they all use the function get|set_sys_tune()
> which checks the knob mandatorily and run smoothly for past
> many years and nobody ever complains about that.

+1

> So I think it's safe to convert this one using TBROK too, it essentially
> has no difference from other oom-tests. 'overcommit_ratio' and
> 'overcommit_memory' are quite basic on Linux distribution.

+1
=> go ahead and merge.


> > I also wonder if testcases/kernel/mem/tunable/max_map_count.c
> > can replace old_max_map_count with .save_restore (with TST_SR_TCONF).


> +1


> > Also testcases/kernel/mem/tunable/min_free_kbytes.c could use
> > .save_restore on panic_on_oom and min_free_kbytes, right?


> No, 'panic_on_oom' is a different scenario, min_free_kbytes.c test
> just checks if that was being set to 1, if yes, we have to skip the whole
> test unconditionally in case of the system occurs panic.

+1


> > But these two can be done as a separate effort.


> Yes, the rest two suggestions sound good.

I see you already post a patch, thx!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
