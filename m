Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8718DECAAD8
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 11:26:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E0903CAC61
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 13:26:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCEF03CAC4B
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 13:26:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7F6B66011B7
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 13:26:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D758D1F747;
 Wed, 21 Sep 2022 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663759566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYNiPSpCkfBqJ1HoT0fNHoIpL8Qr+Kd2PtmNIrfKCnE=;
 b=xCC/i4OSVQjMBxfM2PzRi0CXK5Rz5wad/LxLUkHuvEUjJZ6sJnpdK7DhFBXQLJJZ9cV84a
 XZnU6O2jvsaEqR51YbdLjJZcfEKTE6smRbtnuxmdSsNhiuR9eOzxw+gWqOcs7blHoYBbj0
 1LHVu5hEjWv8jqOwy3GVYdrQzZrtSL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663759566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYNiPSpCkfBqJ1HoT0fNHoIpL8Qr+Kd2PtmNIrfKCnE=;
 b=jjZXfN6YCm/wuATg1u58RYJBrMdipmoW6jOyun1xByGTnbX9DECuz6PHsW0pnCsvXHOt8K
 LSvlKe9GojaM70Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65FFB13A89;
 Wed, 21 Sep 2022 11:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kRjOFc70KmNJAQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Sep 2022 11:26:06 +0000
Date: Wed, 21 Sep 2022 13:26:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yyr0zCD3iJqALkoP@pevik>
References: <1662008249-2227-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YxCR7+dkGxPvCQDn@pevik>
 <98263d58-cf08-0c70-c642-2a95a727659f@fujitsu.com>
 <313ec802-8e48-667b-6327-071e25acb8b5@jv-coder.de>
 <d7639dba-7157-461e-dedc-fd800600370b@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d7639dba-7157-461e-dedc-fd800600370b@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] README: Add missing configure in openposix step
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "Joerg.Vehlow@aox.de" <Joerg.Vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Joerg

> > Hi,

> > sorry for the late reply, I was on vacation.

> > Am 9/2/2022 um 9:31 AM schrieb xuyang2018.jy@fujitsu.com:
> >> Hi Petr

> >>> Hi Xu,

> >>> [ Cc Joerg ]

> >>>> Since 8071ba7("openposix: Setup autoconf and fix installation layout")
> >>>> , we need to use configure firstly.

> >>> nit: there should be Fixes: below:
> >>> Fixes: 8071ba7 ("openposix: Setup autoconf and fix installation layout")

> >>> Then you can use just 8071ba7 in the text.

> >>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> >>>> ---
> >>>>    README.md | 6 ++++--
> >>>>    1 file changed, 4 insertions(+), 2 deletions(-)

> >>>> diff --git a/README.md b/README.md
> >>>> index d45d1ee44..d0ca5f4d4 100644
> >>>> --- a/README.md
> >>>> +++ b/README.md
> >>>> @@ -79,11 +79,13 @@ $ cd ../commands/foo
> >>>>    $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
> >>>>    ```

> >>>> -Open Posix Testsuite has it's own build system which needs Makefiles to be
> >>>> -generated first, then compilation should work in subdirectories as well.
> >>>> +Open Posix Testsuite has it's own configure and build system which needs
> >>>> +Makefiles to be generated first, then compilation should work in subdirectories
> >>>> +as well.

> >>>>    ```
> >>>>    $ cd testcases/open_posix_testsuite/

> >>> You miss:
> >>> $ make autotools
> >>> as this creates configure

> >>>> +$ ./configure
> >>> But if you run make autotools && ./configure in the top level, none of these two
> >>> is needed to be run in open posix directory.

> >> I have called them on top directory, but configure still be needed in
> >> open posix directory.
> > Did you run configure with --with-open-posix-testsuite? Otherwise
> > configure is not executed in the open posix directory.

> Oh,  yes, I don't use this option. I only see the documentation said we 
> can use ./configure and make instead of make all in the openposix 
> direcotry. But miss this  --with-open-posix-testsuite option .


> I think we should mention this option in README ie


> ./configure --with-open-posix-testsuite --with-realtime-testsuite
> diff --git a/README.md b/README.md
> index d45d1ee44..7da393e37 100644
> --- a/README.md
> +++ b/README.md
> @@ -51,6 +51,13 @@ $ make autotools
>   $ ./configure
>   ```

> +If you want to include open posix testsuite or realtime testsuite, the 
> chances are
> +the following will work:
> +
> +```
> +$ ./configure --with-open-posix-testsuite --with-realtime-testsuite
> +```
> +
>   Now you can continue either with compiling and r

I guess all people who has been using open posix by now knows
--with-open-posix-testsuite is needed. I mean, it does not harm to document it,
but there are other options. I suppose people run ./configure --help on project
they don't know.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
