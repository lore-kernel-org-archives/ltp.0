Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96F3ECAAD8
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:36:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D29353CABEA
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:36:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4DEB3C1C21
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:35:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9D89600074
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:35:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C3B55CB56;
 Wed, 14 Sep 2022 09:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663148157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oiF4bRQlhmJ480WDIUOT3spNLU9nx+/jVIxiTWsDawk=;
 b=TJkBqeK/8+qi+JOW6FmX5UIaglzlVqjCIUK02UVGQ8tfka+TYxj8dtPHSdubqAbYlEVEn4
 hZKRrYqGL5vQDMa7WAHtGV2yoo2hBBWi54G0DzkT8dSKaCAa19lGmAykh2aCYVgN5RVAMZ
 Owuw9sz+3npOU5WmUSn8w2hpxRHT0xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663148157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oiF4bRQlhmJ480WDIUOT3spNLU9nx+/jVIxiTWsDawk=;
 b=m/48mCDK3Cf7pCzzxgtXp47QWfPKVkLegKtB/wJ77wmbFXf4w8+U5ckijY2hDBcb4vLCDW
 qYPZhY4FSBzE5ZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A333134B3;
 Wed, 14 Sep 2022 09:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3KJjBn2gIWNZLgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 14 Sep 2022 09:35:57 +0000
Date: Wed, 14 Sep 2022 11:37:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyGg8VilN9Jhv1lQ@yuki>
References: <20220913151907.26763-1-mdoucha@suse.cz>
 <20220913151907.26763-4-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220913151907.26763-4-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] dio_sparse: Fix child exit code
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
> dio_sparse currently ignores all child failures because children never
> exit with non-zero code. Fix child exit status.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/io/ltp-aiodio/common.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
> index 68465dc54..6265831af 100644
> --- a/testcases/kernel/io/ltp-aiodio/common.h
> +++ b/testcases/kernel/io/ltp-aiodio/common.h
> @@ -78,9 +78,9 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
>  			if (r > 0) {
>  				bufoff = check_zero(buff, r);
>  				if (bufoff) {
> -					tst_res(TINFO, "non-zero read at offset %zu",
> +					tst_brk(TBROK,
> +						"non-zero read at offset %zu",
>  						offset + (bufoff - buff));

Ah, this is the fix. I would go for tst_res(TFAIL, ""); and return 1;
otherwise this looks fine applied over the previous changes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
