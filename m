Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C05C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 07:41:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39E2B3C9B04
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 08:41:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A2D33C07BB
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 08:40:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 12EF420015B
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 08:40:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D60BC210F4;
 Mon,  7 Feb 2022 07:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644219657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejtf5S7+1Uq0qEn8KkMZjJLpigdVRtvxbfSileMTtok=;
 b=r/x9JYy3UUMLPl4IKFDQcqVv7w413XFS0s/nDnx2Dg9nl7R77/PazlW2rBAxLDN60f+Ju9
 EZpZ0AJi02tY78Dp74aqLDqkEL6Kib4kIxNp7ZXFNVXs5OISIW6MEO8R5cyexcjrsfScGj
 UM9Ffoy+YKjff5T8BqX4VAF5qwHZEtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644219657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejtf5S7+1Uq0qEn8KkMZjJLpigdVRtvxbfSileMTtok=;
 b=qXn7hGXdx6SKKrAdyaGGPBW6zzqMow3UUpJ6kjvtZTHfow5kqmjjdqRmdqoDzncp90Fy0k
 fEkTiaPyd2+FxOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A839113ABC;
 Mon,  7 Feb 2022 07:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tFsyJgnNAGITZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Feb 2022 07:40:57 +0000
Date: Mon, 7 Feb 2022 08:40:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YgDNB9v0x82mExVE@pevik>
References: <20220207040447.2803113-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207040447.2803113-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: skip on small RAM system
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

> Notes:
>     Ps. I also think we might need .min_mem_[avai|total] field but
>         not sure if it is really necessary to add that.
Is it just a single test? Than maybe not worth of it, but generally I'm for
adding tags like this into the library - it encapsulates code and gives us a
documentation in docparse.

...
> +static void setup(void)
> +{
> +	long long mem_avail = tst_available_mem();
> +
> +	if (mem_avail < 512L*1024)
> +		tst_brk(TCONF, "Needed > 512MB availabe, only have: %ld kB", mem_avail);
typo: s/availabe/available/

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
