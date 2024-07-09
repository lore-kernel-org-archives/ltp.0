Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A84C3DA41
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 11:56:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 274033D3927
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 13:56:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D8C13D0681
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 13:56:13 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4ADD5600809
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 13:56:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 934571FCD6;
 Tue,  9 Jul 2024 11:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720526171;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dydRSxFc/lF7eY3+F/laXwo57pPwItUY3/pdHcawK34=;
 b=3LccNkxw/mCPkCBfM2iHg/aQfpaWFdqVh9a2z4Rl//BcL6QK7u51/TIMe+RdOWCbInOdMO
 0f6onjM0dX/QDm29ByTTu94Ph8s0tgkaFK7jAosPhGWMQ+jJm0z0h2kZ/IExBvTXYZLxLG
 lyToery5q5dxF3SIISln3m3TsZLlHck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720526171;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dydRSxFc/lF7eY3+F/laXwo57pPwItUY3/pdHcawK34=;
 b=zWeTc2bzhCvvpcSRHtVbStfQk847Iph/N4Z4tFU8GPLRR+fNuQcLxZBgHkrpmhzi3YtsYQ
 gcGQ1VNybU9OUFAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720526171;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dydRSxFc/lF7eY3+F/laXwo57pPwItUY3/pdHcawK34=;
 b=3LccNkxw/mCPkCBfM2iHg/aQfpaWFdqVh9a2z4Rl//BcL6QK7u51/TIMe+RdOWCbInOdMO
 0f6onjM0dX/QDm29ByTTu94Ph8s0tgkaFK7jAosPhGWMQ+jJm0z0h2kZ/IExBvTXYZLxLG
 lyToery5q5dxF3SIISln3m3TsZLlHck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720526171;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dydRSxFc/lF7eY3+F/laXwo57pPwItUY3/pdHcawK34=;
 b=zWeTc2bzhCvvpcSRHtVbStfQk847Iph/N4Z4tFU8GPLRR+fNuQcLxZBgHkrpmhzi3YtsYQ
 gcGQ1VNybU9OUFAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DE441396E;
 Tue,  9 Jul 2024 11:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tfuYDFsljWZUawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Jul 2024 11:56:11 +0000
Date: Tue, 9 Jul 2024 13:56:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240709115609.GB198566@pevik>
References: <20240709103324.183993-1-pvorel@suse.cz> <Zo0ZiWT01NFENPaz@yuki>
 <20240709111847.GA198566@pevik> <Zo0gfRp0MblEL_oq@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zo0gfRp0MblEL_oq@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test: Fix tests using device without
 .filesystems
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
> > > +       fs = fs ? &dummy : fs;

> This is a stupid typo, it should be fs = fs ? fs : &dummy instead.

Ah, obviously. I was blind not notice this.

> > This looks more elegant, but I get coredump.
> > I also think you need to have count_fs_descs() <= 1 and maybe define fs_type
> > (not sure about it).

> You need count_fs_descs() <= 1 but the fs type is used from the
> tst_device structure instead. So the whole patch should be:

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b49c248ae..c6ed5d562 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1101,6 +1101,9 @@ static void prepare_device(struct tst_fs *fs)
>  {
>         const char *mnt_data;
>         char buf[1024];
> +       struct tst_fs dummy = {};
> +
> +       fs = fs ? fs: &dummy;

nit: FYI shorten syntax works even on 4.8.5:
	fs = fs ?: &dummy;

>         const char *const extra[] = {fs->mkfs_size_opt, NULL};

> @@ -1355,8 +1358,8 @@ static void do_setup(int argc, char *argv[])

>                 tdev.fs_type = default_fs_type();

> -               if (!tst_test->all_filesystems && count_fs_descs() == 1)
> -                       prepare_device(&tst_test->filesystems[0]);
> +               if (!tst_test->all_filesystems && count_fs_descs() <= 1)
> +                       prepare_device(tst_test->filesystems);
>         }

>         if (tst_test->needs_overlay && !tst_test->mount_device)

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Feel free to merge it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
