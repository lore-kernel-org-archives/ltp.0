Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443BBC433F5
	for <ltp@archiver.kernel.org>; Tue, 24 May 2022 08:36:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B93243CAC23
	for <ltp@archiver.kernel.org>; Tue, 24 May 2022 10:36:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 199A63C0775
 for <ltp@lists.linux.it>; Tue, 24 May 2022 10:36:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE36A60045E
 for <ltp@lists.linux.it>; Tue, 24 May 2022 10:36:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 897A921A1D;
 Tue, 24 May 2022 08:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653381362;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brV+e9mLW3BpBSiKe712xuHPnU81rIFnxD8pY9JZi08=;
 b=aUcp8ASb/GqOI+4LoVaBxxg+GRKLWVX+vT5KRugt5qqru8qdIW3zDebJDzcXtYQXSt/IQY
 wSeEveoBQgDwhoSNTLDGaRZmantE5xFxdmTxVhlTmLVANVhmU+TtT1IFau5hfjDodrNan8
 dpBSVVbZdeFf56XQyky5sGsYmIvdrV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653381362;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=brV+e9mLW3BpBSiKe712xuHPnU81rIFnxD8pY9JZi08=;
 b=cYnXjxfOwM7gVaNHVKO9wjHKztE4cf6lHmarOwn/42ePiKYa9CfvxNkrkB8DMsunhV89Sk
 Euxliv0YrTyOVMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5523813AE3;
 Tue, 24 May 2022 08:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u/YcEvKYjGIEaQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 May 2022 08:36:02 +0000
Date: Tue, 24 May 2022 10:36:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YoyY8BQRAF4pDKru@pevik>
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-27-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512123816.24399-27-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 26/29] ltp-aiodio/dio_read: Convert to runtime
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> +++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
> @@ -51,6 +51,9 @@ static void do_buffered_writes(int fd, char *bufptr, long long fsize, long long
>  			tst_brk(TBROK, "pwrite: wrote %lld bytes out of %lld", w, wsize);

>  		SAFE_FSYNC(fd);
> +
> +		if (!tst_remaining_runtime())
> +			return;
>  	}
>  }

> @@ -75,6 +78,11 @@ static int do_direct_reads(char *filename, char *bufptr, long long fsize, long l
>  				goto exit;
>  			}

> +			if (!tst_remaining_runtime()) {
> +				tst_res(TINFO, "Test out of runtime, exitting");
nit: s/exitting/exiting/

Kind regards,
Petr

> +				goto exit;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
