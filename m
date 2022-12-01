Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E1FC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 10:46:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C80A23CC4B7
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 11:46:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA8473CC47D
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 11:45:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 06E451402FB1
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 11:45:49 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E602621B21;
 Thu,  1 Dec 2022 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669891548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FH7aVibHeItSk7/pqNeJ0f6jxDKLqXOtGXSczejCTbo=;
 b=M2xw5LKWOEN4y1o4CqOtRuCfHlLE1AOQWMzJZRVLuctSo3VN+suv1DiBXC0YzSs59kjb+3
 33sqeavjW9jfwVw3lX3OT3iPK9MQD3TOn3iS56m8mUyhpTRuOqiHUEsWcq/Ao58oq4Dxzb
 zK6YaVOHhmAmevo4tz4mjg7q/fWd4l0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669891548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FH7aVibHeItSk7/pqNeJ0f6jxDKLqXOtGXSczejCTbo=;
 b=gdfi1iJfHpHUyGnyimKsiZ7Bx4SHrlhb4qSCumzcymRNGWpzUm1vIhKWklIy5Ma/m4SGDU
 ssLnrgI4WxpJdxDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B5A6B13503;
 Thu,  1 Dec 2022 10:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id Qi66KtyFiGP+NwAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Thu, 01 Dec 2022 10:45:48 +0000
Date: Thu, 1 Dec 2022 11:45:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwan@redhat.com>
Message-ID: <Y4iF2t/RNARHqJp4@pevik>
References: <87r0xmt3ts.fsf@suse.de> <Y4cZxK/SqTtpQb07@pevik>
 <Y4cnbaAtMAtw3IWC@pevik> <1774275.JVTEKzzMJm@localhost>
 <CAEemH2eDBmac9hSZ+n_hQhLjaHOtxqSAj+QfJ_Sc_+4jd4hDww@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eDBmac9hSZ+n_hQhLjaHOtxqSAj+QfJ_Sc_+4jd4hDww@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statvfs01: Convert to new LTP API
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Avinesh Kumar <akumar@suse.de> wrote:

> > How about
> > > 1) don't skip exfat and vfat but just skip creating file with valid
> > name? or

> > > 2) Add #define NLS_MAX_CHARSET_SIZE 6 and for vfat and exfat calculate
> > > length as: buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1 ?



> > Thank you for the review and research on vfat, exfat scenarios.
> > I have adopted the option 1 for now and sent a v3 of this patch.


> I thought option_1 meant to skip creating a valide-file when
> detecting on "vfat,exfat" FS, but not skip for others.

> Or probably I misunderstood Petr's words.
No, you understood me well. I wanted this to be in v3,
but it's not there :).

Kind regards,
Petr

> Anyway, don't hurry to send V3 until we get an agreement :).

> --- a/testcases/kernel/syscalls/statvfs/statvfs01.c
> +++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
> @@ -30,7 +30,10 @@ static void run(void)
>         memset(valid_fname, 'a', buf.f_namemax - 1);
>         memset(invalid_fname, 'b', buf.f_namemax + 1);

> -       TST_EXP_FD(creat(valid_fname, 0444));
> +       long fs_type = tst_fs_type(TEST_PATH);
> +       if  (fs_type != TST_VFAT_MAGIC && fs_type != TST_EXFAT_MAGIC)
> +               TST_EXP_FD(creat(valid_fname, 0444));
> +
>         TST_EXP_FAIL(creat(invalid_fname, 0444), ENAMETOOLONG);
>  }

> @@ -46,9 +49,4 @@ static struct tst_test test = {
>         .mount_device = 1,
>         .mntpoint = MNT_POINT,
>         .all_filesystems = 1,
> -       .skip_filesystems = (const char *const[]) {
> -               "vfat",
> -               "exfat",
> -               NULL
> -       }
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
