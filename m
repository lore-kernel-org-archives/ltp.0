Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1D8C8303D
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 01:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751419642; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Rp/bC0OcnlZE8EiEqdG+fozpjn+6B6sR6T0ZkNsOrj4=;
 b=ohFtMZv1MMb3zgk9y/qZg1Zq/6wmmCzJ9RVAEzMXjtztyiOLKUwTNUSdvP1LYVTpCS3c2
 uIcUOi9WGieGok/ZkJpY7pK7BNRLsok+kXkQFk2knSfF1G0IWTtHgpRZJGLVmEDFZc5edOR
 1GaiQFu6jFLM+Xx+NoJAy+lKhq6RNmw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BECDC3C6B28
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 03:27:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 590193C6B28
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 03:27:00 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 44D251000360
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 03:26:59 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so5294897f8f.1
 for <ltp@lists.linux.it>; Tue, 01 Jul 2025 18:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751419618; x=1752024418; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cigNymLcVEKYQrWBGnYDN2fyrmwRSNjTvoFmIFuQZmY=;
 b=XJD1L4lWECVKJa6xYUEqnat1ftysAxgdiP402xPSdkmTMH+siN8G6ufO5JjsGsrBCC
 GHEgrDo9pP0QlrymV++i2ClB2iGWw316YgYhxtSQ+4Z0xvT+b7pAS5KK/3Zvyy6v07kr
 097wsNm/mjj7u71CDEzmC4VkAJDX0B7HRLRPbW++y2520BZBDAJYT3rbty1v1PykqWsm
 Q2ucUp+OdB5v1eLYYO3B40qHBuqSDzmiavAFxPXrKpywIk927BVHd8StK3cMrZnkQHEI
 lJjjWXs4nJVdjGSC2Lh8GRs0T3hLDJOUvHaC73Fw/Jnl2CG+fHAsZlZfdG6yk+GvPUSr
 QGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751419618; x=1752024418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cigNymLcVEKYQrWBGnYDN2fyrmwRSNjTvoFmIFuQZmY=;
 b=PCDer/nRDkSPefGp3pWFVR92qmnKVKr7vWYQIGSARBJojXVdnSGXN5ANJVwM8mEw5r
 /Op/xpIruBGeANPeb61bV4kB0kk7DSHEssOB7XkpJk5+X1+xKJJr7o/RFSt1rkgW2CDB
 CRJWsdsdfQ/SYTu7k8YfjzGPI6GP9A/b7JHO6iGsheu1CdjAisPrtyvCVv4UmP8GLZ4E
 0BNpZ2NEnA0HjWniJKReu41569hFtxck5/nylHwSc1TWEMGRM7+sXJQJOEkxjPlyImkQ
 uRN6UMOtgzsifpt8I1rkhBdEinfdet9lHdIeLojX3at9yCrIv2eLx/17Vs3H+6NPVYRG
 YIcA==
X-Gm-Message-State: AOJu0YxV4zn3aoOflQ/MbFWYCwmZb2UETMNxlcASPTZbeDqKWev3yEb9
 iLlADK4eqIieAhSF2tC+fTM0RkGIrwNrfMXPmie4dWGB5HsZYbhP/Hkv8elXamhLFw==
X-Gm-Gg: ASbGncu6W3gQlY3Qocv9PksTclhlWgn/5hU76PWqQB9DDLoDC8IV1K3oiKTwFpk0RbX
 DnAgi0vAS+6OhIm++oPAVFxsIHrgBpiZNk4UoJ/FxJdwF58U8WXRGL94/GPjVPRkQyEvo+n/bFG
 gKFBXA3aGNJGhskd3MI0FlCzqo8+Wmnt0kcbLA6NzA+2MgBA4fwD8sM1u2BK4RyQKD9PVARgAQp
 0vzo5dW3gVqGh08zr3KitK/w6vibIsfQXrqlUDiqEMtMqfNmAP5hOIJIu3HMRQ86MH+i7+4ml67
 fqzrXpVkQomXwzBS305t1WBPgLi8LcBLYkRyu9K1xjxeY551BQt0XK+aJv77iw==
X-Google-Smtp-Source: AGHT+IHb76yd9VYkHCcer+96gDHQkFMPlxo9qqJp+ojYGqZpFFRTj+vWsk2gcu9RSdo/FrAOWslr/A==
X-Received: by 2002:adf:e18d:0:b0:3a5:39a8:199c with SMTP id
 ffacd0b85a97d-3b20120377fmr473487f8f.53.1751419618586; 
 Tue, 01 Jul 2025 18:26:58 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39bb7dsm116435865ad.90.2025.07.01.18.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:26:58 -0700 (PDT)
Date: Wed, 2 Jul 2025 09:26:23 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aGUzfw0Ex1TmffpK@MiWiFi-CR6608-srv>
References: <20250630153205.19017-1-chrubis@suse.cz>
 <20250630153205.19017-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250630153205.19017-2-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/statmount06: Fix and enable the test
 on FUSE
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 30, 2025 at 05:32:05PM +0200, Cyril Hrubis wrote:
> Reported-by: Jan Polensky <japo@linux.ibm.com>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/statmount/statmount06.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statmount/statmount06.c b/testcases/kernel/syscalls/statmount/statmount06.c
> index fe41d5b87..89717a3fb 100644
> --- a/testcases/kernel/syscalls/statmount/statmount06.c
> +++ b/testcases/kernel/syscalls/statmount/statmount06.c
> @@ -36,8 +36,10 @@ static void run(void)
>  	if (!TST_PASS)
>  		return;
>  
> +	const char *fs_type = tst_device->is_fuse ? "fuseblk" : tst_device->fs_type;
> +
>  	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_FS_TYPE);
> -	TST_EXP_EQ_STR(st_mount->str + st_mount->fs_type, tst_device->fs_type);
> +	TST_EXP_EQ_STR(st_mount->str + st_mount->fs_type, fs_type);
>  }
>  
>  static void setup(void)
> @@ -55,10 +57,6 @@ static struct tst_test test = {
>  	.mount_device = 1,
>  	.mntpoint = MNTPOINT,
>  	.all_filesystems = 1,
> -	.skip_filesystems = (const char *const []) {
> -		"fuse",
> -		NULL
> -	},
>  	.bufs = (struct tst_buffers []) {
>  		{&st_mount, .size = SM_SIZE},
>  		{}
> -- 
> 2.49.0
Reviewed-by: Wei Gao <wegao@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
