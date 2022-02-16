Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52125C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 09:10:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94BE93CA078
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 10:10:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 271613C9564
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:10:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7D79600806
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:10:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 00673212B5
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645002622;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fAVEdqxiGb0Yh1iirl5GhqhCK64c1iRet31jw8L54tU=;
 b=C22gkMd7lI9EXPL43tarWwsOYiLQFqTbTklnGgyq9AozyEs2NA5YNjAnKiRzypxHGuZwAi
 jAZvwWEeCHrxosaTap14GjkMWutC2dpg2D0oPxDWhjWf8Qg9QxzQwfe3kBNzc8/ROd5rba
 VUFvjX/yIKAASxjX3cuJ4ZqsfvUgU/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645002622;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fAVEdqxiGb0Yh1iirl5GhqhCK64c1iRet31jw8L54tU=;
 b=ATgPnxOXTy8Z/CoHkJ1nTo14jU6fESCkQrldcPdCz/IyyjOb59oeS3qRNZatzhtWEIwIly
 MnmJrjNr/tOndPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D42D013A95
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 09:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PAOAMX2/DGLHZAAAMHmgww
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 09:10:21 +0000
Date: Wed, 16 Feb 2022 10:10:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Ygy/fJA0j5ezH7ZL@pevik>
References: <20220216090801.31400-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220216090801.31400-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH 1/1] ustat: Add missing space in
 known-fail
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Although testinfo.pl in a7b6c94503 adds extra space for producing doc,
> space was missing when printing after test run:

> $ ./ustat01
> ...
> HINT: You _MAY_ be hit by known kernel failures:

> ustat() is known to fail with EINVAL on Btrfs, seehttps://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> We might just remove the space from docparse/testinfo.pl which is now
> useless:

> diff --git docparse/testinfo.pl docparse/testinfo.pl
> index 67e435d794..fa77b53cc5 100755
> --- docparse/testinfo.pl
> +++ docparse/testinfo.pl
> @@ -456,7 +456,7 @@ sub content_all_tests
>  			# tag value value can be split into more lines if too long
>  			# i.e. URL in known-fail
>  			for (@$tag[2 .. $#$tag]) {
> -				$v .= " $_";
> +				$v .= $_;
>  			}

>  			$content .= "\n|" . reference($k) . "\n|$v\n";

Ah, I confused patchwork (patchwork bug?). The change in docparse/testinfo.pl
was just a suggestion (under first ---).

The real committed change starts below.

Kind regards,
Petr

>  testcases/kernel/syscalls/ustat/ustat01.c | 2 +-
>  testcases/kernel/syscalls/ustat/ustat02.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
> index 66dbc0b184..70a44adb46 100644
> --- a/testcases/kernel/syscalls/ustat/ustat01.c
> +++ b/testcases/kernel/syscalls/ustat/ustat01.c
> @@ -45,7 +45,7 @@ static struct tst_test test = {
>  	.test_all = run,
>  	.setup = setup,
>  	.tags = (const struct tst_tag[]) {
> -		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see"
> +		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
>  			"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
>  		},
>  		{}
> diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
> index 55bdcaedf8..a5b0cc1b68 100644
> --- a/testcases/kernel/syscalls/ustat/ustat02.c
> +++ b/testcases/kernel/syscalls/ustat/ustat02.c
> @@ -64,7 +64,7 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.tcnt = ARRAY_SIZE(tc),
>  	.tags = (const struct tst_tag[]) {
> -		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see"
> +		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
>  			"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
>  		},
>  		{}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
