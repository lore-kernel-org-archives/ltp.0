Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3278FC4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 09:49:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C96D3CBC4B
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 10:49:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2F643CBC0A
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 10:49:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E527140013F
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 10:49:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83C7933E68;
 Fri, 16 Dec 2022 09:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671184157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jj4UxEGb0jODJEwcjPT+pPSnjiamUpObYfB34uGLvsA=;
 b=Ot3WJHXoT/IpFAxS1h3QE/N7JVxUi3uOZUomjrH/pmx6fawGqt9H4dbURumqpkaDGuAv6A
 dMpCgh8L9+xfSHTAiDCa6wGokVdcsuIEl2l7qDvRpuOe84ZNCMUx5IgueaqZyCHMklN2wv
 QPOiK3lOOcirYT4i8YbD1zZKL3hf6xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671184157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jj4UxEGb0jODJEwcjPT+pPSnjiamUpObYfB34uGLvsA=;
 b=T8FCAfE1HBs0XVBZIVuBZCxvhIRFpKfSX24maMBucYIDPS6Ph+3DTkY3hr9s4C5BXbMTaf
 DeiqprPK4W4j9KAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60A50138F0;
 Fri, 16 Dec 2022 09:49:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PPSgFR0/nGMaWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 09:49:17 +0000
Date: Fri, 16 Dec 2022 10:49:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y5w/G2UiR/x6phkQ@pevik>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671166923-2173-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1671166923-2173-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/7] doc/shell-test-api.txt
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

Hi Xu,

> Update tst_kvcmp usage.

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  doc/shell-test-api.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index 73c9eff91..f35561e54 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -652,13 +652,15 @@ tst_kvcmp
>  +++++++++

>  This command compares the currently running kernel version given conditions
> -with syntax similar to the shell test command.
> +with syntax similar to the shell test command. Now, the oldest supported kernel
> +version for ltp is 3.0, so we don't need this if comparing with very old version
               ^ upper case please (LTP)
> +ie 2.6.8 .
           ^ please remove this space.

I'm not a native speaker, but

with syntax similar to the shell test command. The oldest supported kernel
version for LTP is 3.0, therefore we don't need this if comparing with very old version
e.g. 2.6.8.

But is it really needed? Nobody will add these check nowadays.
Instead this I sent a patch to add this to doc/supported-kernel-libc-versions.txt
https://patchwork.ozlabs.org/project/ltp/patch/20221216094611.2924-2-pvorel@suse.cz/
(I also pinged few people + automated-testing@lists.yoctoproject.org in the
patchset to get some audience for minimal version - maybe we could raise higher.)

>  [source,sh]
>  -------------------------------------------------------------------------------
> -# Exit the test if kernel version is older or equal to 2.6.8
> -if tst_kvcmp -le 2.6.8; then
> -	tst_brk TCONF "Kernel newer than 2.6.8 is needed"
> +# Exit the test if kernel version is older or equal to 4.0.0
> +if tst_kvcmp -le 4.0.0; then
> +	tst_brk TCONF "Kernel newer than 4.0.0 is needed"
>  fi

Updating example is obviously correct.
Reviewed-by: Petr Vorel <pvorel@suse.cz>
for this part only.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
