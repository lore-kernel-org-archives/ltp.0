Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747C9C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 14:40:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC27D3C8276
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 15:40:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7733C3C0B96
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 15:40:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D3C77200E06
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 15:40:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3B872110A;
 Fri, 10 Dec 2021 14:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639147203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xz+J4UaIqTI7z4c5rvg5YOv1AHa5uf7X/10phIPfz+k=;
 b=RHtCi9sWCSBizY3en8lzA0jIeJk38T88ya0DAJIIJ2L7wX+lbE4/P8V0y9ls+6l7RZ2eGo
 vXzOfzRAMVxL3w18+I8qsemZoyW0DQZKBramRuPO8kLSPiyzVhA2aF39gjxSQQCQpxFjb7
 BgMP9cMCv9YkqXFX9UuJpNJwPZhKIiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639147203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xz+J4UaIqTI7z4c5rvg5YOv1AHa5uf7X/10phIPfz+k=;
 b=YsfOCsrmDPqPP2ZniNrFrLnXSWXStfSep4AlAHCd9PeeYFpq08HaPB16NAeRQUK3LwXmJI
 z7KE28PsBBt8JVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D626913BD5;
 Fri, 10 Dec 2021 14:40:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z3COMsNms2GcTAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Dec 2021 14:40:03 +0000
Date: Fri, 10 Dec 2021 15:41:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YbNnFDDT14rbKmCf@yuki>
References: <20211210135543.21568-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211210135543.21568-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Refactoring dio_sparse.c using LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with two minor changes, thanks.

> +static struct tst_option options[] = {
> +	{"n:", &str_numchildren, "Number of threads (default 1000)"},
> +	{"w:", &str_writesize, "Size of writing blocks (default 1K)"},
> +	{"s:", &str_filesize, "Size of file (default 100M)"},
> +	{"o:", &str_offset, "File offset (default 0)"},
> +	{}
> +};

I've moved this structure to be inline in tst_test initialization, since
otherwise our parser cannot pick it up.

I guess that we should fix that in the API documentation as well.


+ added a paragraph to the test commit message why the -a parameter has
  been removed

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
