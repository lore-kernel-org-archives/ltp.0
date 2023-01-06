Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E384BC3DA7A
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 09:22:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 132753CB61B
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 10:22:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A3693C19D9
 for <ltp@lists.linux.it>; Fri,  6 Jan 2023 10:21:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F0A621400242
 for <ltp@lists.linux.it>; Fri,  6 Jan 2023 10:21:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F9AC25C4C;
 Fri,  6 Jan 2023 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672996909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XiwT8YthaHZo6zpUqqVMnXeyzvOOgcHiZipbFA/zlck=;
 b=ohMoDy7Wwst2BGxt5dBmO/ZU4hAUI4nBv+zxC+8lWkcmAyS8KJd2IQ+k/2XLqi1PX+hokK
 9U/WmQxAJfnrtdUVB24tIv4xkY8VH+0abSJGm0QBRDXrZ+oyGMQaqlOS9dSQQfF1OWtVJM
 loHNaMtT5yy9McwrSnNNglYgWZkgb/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672996909;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XiwT8YthaHZo6zpUqqVMnXeyzvOOgcHiZipbFA/zlck=;
 b=E7+gFjmcGTkokD4ECnhf0GkGuWTKclnToIreh35Ur9MXZ5DBGDt3Zeh8m+p1AwRgYMwDO1
 zdPdvIL2cLB0a/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78A6013596;
 Fri,  6 Jan 2023 09:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DvLBGy3ot2MgZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jan 2023 09:21:49 +0000
Date: Fri, 6 Jan 2023 10:21:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y7foKz4LC8cwdj6c@pevik>
References: <20230105162929.16047-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230105162929.16047-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ltp-aiodio.part4: Run DIT000 with only 1
 reader process
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

Hi Martin,

...
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
...
> +
> +	if (numchildren > 2 && !tst_kconfig_check(kconf_rt)) {
> +		tst_res(TINFO, "Warning: This test may deadlock on RT kernels");
I hate TWARN exits non-zero, thus we need to have warnings like this
(TWARN would be more visible than TINFO, but it'd always mean non-zero for RT).

I'd wish the message was TWARN on error, but because on RT test timeouts, we
would have to somehow check remaining time to print the warning before timeout.

Let's not complicate things more. Thank you for your work!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +		tst_res(TINFO, "If it does, reduce number of threads to 2");
> +	}
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
