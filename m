Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75B4C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 07:41:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B706109E
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 07:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3B706109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C1513C69EB
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:41:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDFA33C6730
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 09:41:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70DFF2013BE
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 09:41:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A750E2195A
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635320463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xLqA1pvNd1oLf/sxVpAtnTlKAHzs/YUmfFYIBoPoVPg=;
 b=yu+SM8JAlFqN7LIzBFerIXpq2TWXV2kj7ckD9jwsvVtal/FJr326DMKahAlMpJS6Sk+LDj
 Zwj4eLgqdzbm+20nJ+1CXaRKk4fwoqKdU/TEK6e+LNnWUKW7IfgVH/IdY4NYO3FS3xvxqG
 Rz+3Mr7ELzlwd92oqnwAfYKgKN/Recs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635320463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xLqA1pvNd1oLf/sxVpAtnTlKAHzs/YUmfFYIBoPoVPg=;
 b=ShFqaYpfb/iUCHGTk4W+NSdxC1PeJkAVu3mLHoq2Br6jkAYwDftuVyvIqWIrKht5UCgJGw
 uKEVxMBnlK9fnCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 860FA13FE6
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 07:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EaNaHo8CeWFqdwAAMHmgww
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 07:41:03 +0000
Date: Wed, 27 Oct 2021 09:41:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YXkCjfUloIauZK6x@pevik>
References: <20211027073719.15922-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211027073719.15922-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ver_linux: Print filesystems
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

> both available and mounted.

> -T option is not implemented on all df implementations
> (on busybox only with IF_FEATURE_HUMAN_READABLE, also aosp toybox does
> not support it), thus fallback without it.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  ver_linux | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

> diff --git a/ver_linux b/ver_linux
> index 824c39510..abaa30a4c 100755
> --- a/ver_linux
> +++ b/ver_linux
> @@ -138,6 +138,18 @@ echo
>  echo 'cpuinfo:'
>  tst_cmd_run lscpu || cat /proc/cpuinfo

> +echo
> +echo 'available filesystems:'
> +echo $(cut -f2 -d$'\t' /proc/filesystems | sort -u)
Actually cut uses tab delimiter as the default
=> it can be just
cut -f2 /proc/filesystems

> +
> +echo
> +echo 'mounted filesystems (/proc/mounts):'
> +cat /proc/mounts
> +
> +echo
> +echo 'mounted filesystems (df):'
> +df -hT 2>/dev/null || df -h
> +
>  echo
>  if is_enabled /sys/module/apparmor/parameters/enabled; then
>  	echo 'AppArmor enabled'

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
