Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF49CCD183
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 11:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760353670; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=/xI2nKWPvQJIXXpeGO3VmfIFC8LZk1t6QaUHiSolIVw=;
 b=qSfdG1xy8LHAtrjJpHN4+veb+8aPWQSDimjMvlNjeWMFfrVnaNrOA6U5487cZtoV2Oeq0
 hSG8YkS5Tbzy+Rjewg0BFq6ScgTh6pLIk22u2GTF4iODpy2ucHyqo+Hly4Ia7xKGy5jQUq9
 eUKtGvmdQI4sOjiZI20912yIfFYnwRk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0194E3CEB8C
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 13:07:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4E23CE321
 for <ltp@lists.linux.it>; Thu,  9 Oct 2025 05:34:37 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2552D600479
 for <ltp@lists.linux.it>; Thu,  9 Oct 2025 05:34:36 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2413C611E9;
 Thu,  9 Oct 2025 03:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ECBC4CEE7;
 Thu,  9 Oct 2025 03:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759980874;
 bh=zQySicJyzHQVgMUqKbwHP7OwMs25Xmyd6FMcON63clo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=RH6h/V4LzvAFQvOGHVQ2ReUSAztcIIgNnTZI6HgBtL0oY+CicvyhuIYatvy14xFwk
 P8GGaviitDQx6U9ns/eFTL9bVRAO/XRdBj8Zy5mk78UQO+37ZJAiH5f6Rd8gsWNxVI
 JhyUe/KdUPA1EoitSXFo1DWJGzJ7tPdVk5Mo3lKgzS3U7FZ6kYHCRxaK8cD0DgkJOe
 Q72WWEZuGiS3QzAmDQgxX8/9Y5MXwPvNppIckVU8/pCIyTozmyF5IbD2gDwj4MLfFa
 rusQJx87owxAw7+zASR5N84tZG/hgmInIH75Yv3bHxIGsKAVw+YrMEAft510JQM1H5
 65UG6A9ZmxYdg==
Message-ID: <e6feb193-0d3d-4cbc-857b-7576db25e929@kernel.org>
Date: Thu, 9 Oct 2025 11:34:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
References: <202509301450.138b448f-lkp@intel.com>
 <20250930232957.14361-1-mjguzik@gmail.com>
Content-Language: en-US
In-Reply-To: <20250930232957.14361-1-mjguzik@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 13 Oct 2025 13:07:28 +0200
Subject: Re: [LTP] [f2fs-dev] [PATCH] f2fs: don't call iput() from
 f2fs_drop_inode()
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
From: Chao Yu via ltp <ltp@lists.linux.it>
Reply-To: Chao Yu <chao@kernel.org>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev, josef@toxicpanda.com,
 ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 10/1/2025 7:29 AM, Mateusz Guzik wrote:
> iput() calls the problematic routine, which does a ->i_count inc/dec
> cycle. Undoing it with iput() recurses into the problem.
> 
> Note f2fs should not be playing games with the refcount to begin with,
> but that will be handled later. Right now solve the immediate
> regression.
> 
> Fixes: bc986b1d756482a ("fs: stop accessing ->i_count directly in f2fs and gfs2")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202509301450.138b448f-lkp@intel.com
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
