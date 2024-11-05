Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093AED1267E
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730803419; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gOuHAG7tDHrlk4st/yreKBovODVb7+V9r1ZBxiblRVY=;
 b=WXBHLDI3XHSu5S23O5BaEIhRAg5Y/MCpOEJdmBqIQIlzbVl0YFIG9z/YBdTUOuMpu15HI
 7Lef6Yt6+s24T3phIgK4YF5RnI1UDTeexUkwfmxXhQG//C9hclZ4A+aWy5EdD+BnIgabE84
 W6m6hInJOoNEn+UwJnJN/l0fZFXMNDY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A6623D2001
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 11:43:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C227D3D1FD9
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 11:43:18 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 249CE1037B40
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 11:43:18 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso6182866a12.3
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 02:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730803397; x=1731408197; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o8ZonbZE1w4c0uSUuD7wdboQCZBdSavVwMREcAeeK7s=;
 b=BfTU9tehGPmtyDBwJC1gMFI+g0U/qIkdu3MiiN1Fq03Hnrqv+nZExp0Zk/VVDtACvp
 gi0mMAkTegtm0o4PJHtUkEmxc4aNKjj4pgydJ8PLXFLq+H+v00Gkcy4SGa5sy1Rd70fS
 c9nDvZ/s26jRM3DXny/FDq46Otd8h7N6TGja7tqCpUKj9dA7G2aGN3B1WVopf+ACyb02
 lzYSkmA3IIzhvoaAtK0OC8qiufi7Sdoj9s/A/W4GXBGcY0pxV7Zn8hhwQDMW3WGJVDFD
 epjVY8hWAbw9c4Hc/Yh3nYyYyasA5QMm4iqy6LKvXQ2LKr2xZtj7irb44+aKUrlo/0Au
 cFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730803397; x=1731408197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8ZonbZE1w4c0uSUuD7wdboQCZBdSavVwMREcAeeK7s=;
 b=cevW0xOtipsXhitkuiHDMp3nM4qVC3jzaC/zAGMV381aVOkcv0PiTyi+OWqRG1YQhT
 DAqrjtVguReWRDLyvdDLbZ7AirhgFzEdO8XHiqNGtyXdtKGHlvUvfzoFF7yJ0HKPxhUM
 VbBALQgmiINOsPB6mxtZ4zIWxUtkK70yKncNTqqL497+jXo6xIqtR5DM+gyDZi4tsMEJ
 tcpXScu7dKAciuFnEpzwH9kiCAoJgKdBGS2VY7OCn6X7xFYPrRUBSO7TmIl0isop6/OS
 +spuHRnNmpILmtOPuEp5rbgTS5u7RZREh4zXF4EaLbuIU92cUBOXLtXRkOVEnq9MJKlQ
 5LKA==
X-Gm-Message-State: AOJu0YyMdKnXYuYoFmML0lswBhruqIBnmS+4/LtpUcMJXHv4THCUUTLv
 KjEq57tkaRAthIIXtwTb63mYx8nOmb+pw/YnQgImxyyJPGvpSOEBTXQpLuJ4mpF+cl6HndDyevU
 =
X-Google-Smtp-Source: AGHT+IF+Kp8ZlziZPrMEyPDXUrT3cxSWCBq3VlO02NB0elcWRLbYEzCRNtuNLUiCwaQETuvgW+vo+g==
X-Received: by 2002:a17:907:8689:b0:a9a:188f:efd9 with SMTP id
 a640c23a62f3a-a9de5edcfdcmr3704406066b.29.1730803397425; 
 Tue, 05 Nov 2024 02:43:17 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb17d7066sm114229466b.130.2024.11.05.02.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 02:43:17 -0800 (PST)
Date: Tue, 5 Nov 2024 05:43:12 -0500
To: Li Wang <liwang@redhat.com>
Message-ID: <Zyn2wDmgcI+ri9SH@wegao>
References: <20241105041326.18531-1-liwang@redhat.com>
 <20241105041326.18531-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241105041326.18531-2-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] landlock01: used fixed size for
 rule_small_size
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

On Tue, Nov 05, 2024 at 12:13:25PM +0800, Li Wang wrote:
> The landlock01 test is failing on kernel v6.12-rc6 with the
> following error:
> 
>   landlock01.c:49: TFAIL: Size is too small expected EINVAL: ENOMSG (42)
> 
> Previously, rule_small_size was calculated conditionally based
> on the presence of the handled_access_net field in the struct
> landlock_ruleset_attr.
> 
> However, the kernel's landlock_create_ruleset() function still uses
> the size up to handled_access_fs to determine the minimal acceptable
> size for backward compatibility, regardless of any new fields added.
> 
> According to the Landlock maintainer[1], this behavior will remain
> for backward compatibility reasons. Therefore, it's unnecessary to
> conditionally adjust rule_small_size based on new fields.
> 
> This patch simplifies the test by setting rule_small_size to
> 'sizeof(__u64) - 1', which effectively tests the minimal size based
> on handled_access_fs.
> 
> [1] https://lists.linux.it/pipermail/ltp/2024-July/039084.html
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/landlock/landlock01.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
> index 083685c64..c375e5154 100644
> --- a/testcases/kernel/syscalls/landlock/landlock01.c
> +++ b/testcases/kernel/syscalls/landlock/landlock01.c
> @@ -62,11 +62,17 @@ static void setup(void)
>  
>  	rule_size = sizeof(struct landlock_ruleset_attr);
>  
> -#ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
> -	rule_small_size = rule_size - sizeof(uint64_t) - 1;
> -#else
> -	rule_small_size = rule_size - 1;
> -#endif
Since we do not need HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET anymore, so i suppose we can remove
following change in configure.ac?
 AC_CHECK_MEMBERS([struct landlock_ruleset_attr.handled_access_net],,,[#include <linux/landlock.h>])
> +	/*
> +	 * Kernel introduces two new fields 'handled_access_net' and 'scoped'
> +	 * in the structure 'landlock_ruleset_attr'. However, in the function
> +	 * 'landlock_create_ruleset()', it still uses the first field
> +	 * 'handled_access_fs' to calculate the minimal size for backward
> +	 * compatibility reason.
> +	 *
> +	 * Therefore, here test 'sizeof(__u64) - 1' is sufficient to determine
> +	 * the minimum size for 'rule_small_size'.
> +	 */
> +	rule_small_size = sizeof(__u64) - 1;
>  
>  	rule_big_size = SAFE_SYSCONF(_SC_PAGESIZE) + 1;
>  }
> -- 
> 2.47.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
