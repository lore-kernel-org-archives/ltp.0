Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC25FC46467
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 00:05:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 973DF3CDCE1
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 01:05:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B1683CB55B
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 01:05:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5F84D140045A
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 01:05:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B560437154;
 Thu, 12 Jan 2023 00:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673481941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wgH0IZYhSkEcTebTFerzvftY0r5N3jzGq7c7rf0pFY8=;
 b=FpkW90PCoJC+COnC8aFCkMNoU5h4QlXhdkqpuKqRdN5nZ12KKWPCFoGtfWdxPiOLvFKBmO
 lhjCzIFXvPLVnP2XTTGh596bH5zrQrwxaBKOIgBNTXScoDTk3uZvxCSFNRKzeTWqjMt3yn
 oP8Wv9fKjK3PortBHx67NzfKGEgNzRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673481941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wgH0IZYhSkEcTebTFerzvftY0r5N3jzGq7c7rf0pFY8=;
 b=xKkSLo7X7ZoTrQu+TIwRGGkfaSKhkahj/YmYvkgNXHArY+nvWtqlKsxk3HBQzfCy/A+J9k
 tVnyY9nwfz7cRPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7614E13588;
 Thu, 12 Jan 2023 00:05:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Sy22GNVOv2NuJQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 Jan 2023 00:05:41 +0000
Date: Thu, 12 Jan 2023 01:05:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <Y79O1AlWHL5SD/zJ@pevik>
References: <20230111141616.20011-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230111141616.20011-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] c-test-tutorial-simple.txt: improve documentation
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  doc/c-test-tutorial-simple.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

> diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
> index 89b0ad4e7..c5861cb36 100644
> --- a/doc/c-test-tutorial-simple.txt
> +++ b/doc/c-test-tutorial-simple.txt
> @@ -333,16 +333,16 @@ call in the +*.in+ files (e.g. +x86_64.in+) which are used to generate
>  may find the system call number is missing from the +*.in+ files and will need
>  to add it (see +include/lapi/syscalls/strip_syscall.awk+).

> -System call numbers vary between architectures, hence why there are multiple
> +System call numbers vary between architectures, hence there are multiple
>  +*.in+ files for each architecture. You can find the various values for the
> -+statx+ system call across a number of +uinstd.h+ files in the Linux kernel.
> ++statx+ system call across a number of +unistd.h+ files in the Linux kernel.

>  Note that we don't use the system-call-identifier value available in
> -+/usr/include/linux/uinstd.h+ because the kernel might be much newer than the
> ++/include/uapi/linux/unistd.h+ because the kernel might be much newer than the
NOTE: /include/uapi/linux/unistd.h does not exists. include/uapi/linux/unistd.h
is relative path in kernel git tree. The same file exists as
/usr/include/linux/unistd.h as part of kernel headers distro package.

I'd prefer to keep /usr/include/linux/unistd.h as a real path.

The other changes are good. Thank you for carefully reading docs and fixing
them!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  user land development packages.

> -For +statx+ we had to add +statx 332+ to +testcases/kernel/include/x86_64.in+,
> -+statx 383+ to +testcases/kernel/include/powerpc.in+, etc.  Now lets look at
> +For +statx+ we had to add +statx 332+ to +include/lapi/syscalls/x86_64.in+,
> ++statx 383+ to +include/lapi/syscalls/powerpc.in+, etc.  Now lets look at
>  the code, which I will explain in more detail further down.

>  [source,c]
> @@ -1007,7 +1007,7 @@ We can then send this patch with the following command sans +--dry-run+.
>  $ git send-email --dry-run output/v2-0001-tutorial-Add-a-step-by-step-C-test-tutorial.patch
>  --------------------------------------------------------------------------------

> -Git will ask some questions (which you an ignore) and then tell you what it
> +Git will ask some questions (which you can ignore) and then tell you what it
>  would do if this weren't a dry-run. In order for this to work you have to have
>  a valid SMTP server set in +.gitconfig+ and also be signed up to the LTP
>  mailing list under the same e-mail address you have configured in Git. You can

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
