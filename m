Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7270FC77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 21:56:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A86F23CDA4C
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 23:56:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 091463C9ADC
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 23:56:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE96C600703
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 23:56:25 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 68A6C62F19;
 Wed, 26 Apr 2023 21:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F2AC433EF;
 Wed, 26 Apr 2023 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682546181;
 bh=ltbFtChyUsNx+9OoDo1UmrYqg/tGP2NIyNLTtd3mv94=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k2go1pazwjedMkrwDQV3+s/owBQM3AIkZw9hcOBgWdh1t05zuDVoe86z+f4LsRyWR
 6r/w7/QaTvEVFlCI1N0jxBcGAUUGYzM1fclR+ddBnHchUNWAMjiQWiPpuWjY/G8QyN
 zAMLak3FxQhRnXBqQf5uGUaGa4muEpDg3efriAbkJw5wEsoyX0odnyQqmZCj+k5eE8
 dPMOO6wV7e0B7LVj4fpmxe2qFv2yH5IUSlaOAgzjVSdjubjhLlLkiQhK9tCGG1/L0j
 xJOuuzJeuI9eIHOXOB7YOmceZcoFJT7PnKHRAlZPIJ0FmcWxD9mu+xv3BLzjJXzpVx
 MJJa9NtJceACA==
Date: Wed, 26 Apr 2023 14:56:20 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230426215620.GB58528@sol.localdomain>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] lapi/stat.h: Add STATX_DIOALIGN related
 definition
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

On Thu, Apr 06, 2023 at 01:40:19PM +0800, Yang Xu wrote:
> Also add missing stx_mnt_id.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  include/lapi/stat.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index ce1f2b678..c2db8a589 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -97,7 +97,11 @@ struct statx {
>  	uint32_t	stx_dev_major;
>  	uint32_t	stx_dev_minor;
>  	/* 0x90 */
> -	uint64_t	__spare2[14];
> +	uint64_t	stx_mnt_id;
> +	uint32_t	stx_dio_mem_align;
> +	uint32_t	stx_dio_offset_align;
> +	/* 0xa0 */
> +	uint64_t	__spare1[12];
>  	/* 0x100 */
>  };

Not like it matters, but the kernel header has __spare3, not __spare1.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
