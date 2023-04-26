Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0971CC7618E
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 21:57:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 747193CDE22
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 23:57:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43D883C9ADC
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 23:57:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C70B1400055
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 23:56:59 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B8FD861C5B;
 Wed, 26 Apr 2023 21:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13487C433EF;
 Wed, 26 Apr 2023 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682546217;
 bh=FCfCDqv8uKxmxtgMbnWjiKTjYckIXIkNle5QWYkp2F0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hbBpEOugW9aexln/Posku41U86g2bUsa3EpVkiY9Z553+PisutEzHg9scfGHZ7x4y
 WRINNQ150oGVmD8v8QCJ3UHUqy6xDAuWJiRUTY6RYizbuCPb0wsrpw2L2ydII/eJzH
 /5L4iuCztCn+Zb7Q2tbrKVesUi7GsXvM9IBNkWvhj1Siir4yQlEI8KidPr8EAemuYn
 ly8Snm6NoL7mIuZbzRpRx34XAfPwuwRaDfOIcbT+bG+5wrL/5TWxN/nWB0waXNQ6JO
 wI0gWB+klFwnyY6yxLndshHYjPynnxyFXWtf81RtkY3HA3wonOI2sUUmbKS+hPgAOL
 ggfj3rdShT5dg==
Date: Wed, 26 Apr 2023 14:56:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230426215655.GC58528@sol.localdomain>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1680759622-8738-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] lapi/stat.h: Remove deprecated STATX_ALL
 macro
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

On Thu, Apr 06, 2023 at 01:40:22PM +0800, Yang Xu wrote:
> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> index b13c11f72..c798c7a10 100644
> --- a/testcases/kernel/syscalls/statx/statx07.c
> +++ b/testcases/kernel/syscalls/statx/statx07.c
> @@ -62,15 +62,15 @@ static int get_mode(char *file_name, int flag_type, char *flag_name)
>  {
>  	struct statx buf;
>  
> -	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buf));
> +	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_BASIC_STATS | STATX_BTIME, &buf));
>  
>  	if (TST_RET == -1) {
>  		tst_brk(TFAIL | TST_ERR,
> -			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buf)",
> +			"statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS | STATX_BTIME, &buf)",
>  			file_name, flag_name);
>  	}
>  
> -	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buf) = %o",
> +	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_BASIC_STATS | STATX_BTIME, &buf) = %o",
>  		file_name, flag_name, buf.stx_mode);
>  
>  	return buf.stx_mode;

Looks like this place just wants STATX_BASIC_STATS.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
