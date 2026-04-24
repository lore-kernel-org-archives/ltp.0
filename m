Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54B4FB44B3
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 06:22:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49B413E25EC
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 08:22:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E458B3C0E3B
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 08:21:41 +0200 (CEST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0533B14002BB
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 08:21:40 +0200 (CEST)
Date: Fri, 24 Apr 2026 14:21:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777011699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kno3dAGd7L7ePiTsr3tKd/3a7YpLpEJ1WbaZrc4XJc0=;
 b=lDgbh4eQj9kKJSeNiye+KQHAx/qYb65zGTT8pHmKc6baATJeUF1s7+FCzEiRtnW3hd7LSo
 4OcKgVbIIBaHLMGhGIHaUIdUoGYpkni/snOAMvnRUGgIAguP50bhG7RoMws2rdGhe9+rt5
 hfSDW6MRdZrjL7Zda38OLXDe0O59XJk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aesL6YSphAi5vJbO@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20260424060543.462475-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424060543.462475-1-pvorel@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl_pidfd06: Update kernel version
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

Hi Petr, Wei,

Petr Vorel wrote:

> Kernel commit ab89060fbc92e ("pidfs: return -EREMOTE when PIDFD_GET_INFO
> is called on another ns") from v7.0 was backported into stable/LTS
> kernels v6.18.14 (7446125afb6d9) and v6.19.10 (2920abaf56c09).

Is this backport just a single stable kernel or a range of version?

> Reported-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> index 0f24d4741f..cc66d54cf4 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> @@ -54,7 +54,7 @@ static void setup(void)
>  	if (!ioctl_pidfd_info_exit_supported())
>  		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
>  
> -	if (tst_kvercmp(7, 0, 0) >= 0)
> +	if (tst_kvercmp(6, 18, 14) >= 0)

What will happen if this test is run on kernel range: v6.19.0 ~ v6.19.9?


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
