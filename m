Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40406FB5E8B
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 00:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773709172; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5XpjSG0Cct75QmXPLazbqDHm15TodMLZ4sPh6ot6diY=;
 b=AvaUK/TolkIV5z7Ard26VqCvf9Y+ou0xT8NitqCh4M/sVjxmxXvQfwCWv8eZs69dJKBgs
 WAQztYbizdNf1NRZt35YWZEDQk7iv5dTnra0rZWkEea3eWDsJEjG5LxFpicdugvlq9rpcyO
 OPFWQbUqhXp6qFP8wR6A42lSZZCE0Y8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D6953E0FA1
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 01:59:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AAB83C0F41
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 01:59:07 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0DE021A007A2
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 01:59:06 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so34849045e9.3
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 17:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773709146; x=1774313946; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mgaSkdkIjcN1PPjJUBlQ9jl5cVNJpF7Gim8u1WjmLtk=;
 b=Jt44pAPzM8pROdFJgw74pIVs6dw/k6CkT6vKntoJ1iDHsf1UOaITj+YN09wiWBpchB
 4HvA51o/G5YAKoJprGbGjeJlScWuiRhJ33/Rgms5ga5T4j1ew8YGWbeXgxw2djIuRyxt
 gK7ryndJlv2NkTJ5MklMYSGoZQp4yTZgav6phXfjx+0pCXeQKMbsI/ILwnUijKwqfo6v
 8Wa1Gpjv1vza0CQXALwbSyWqevjjT4Kaprp6SKGNQC/D/HmqbBrJPGBBLP/xDBRZ8fug
 5FmUaWFQcgWvRT1Iiiujr3N7zstP1d0hKNTRKhVLmBEe+VefxVSmp05pMoU6rOeikN/5
 NKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773709146; x=1774313946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgaSkdkIjcN1PPjJUBlQ9jl5cVNJpF7Gim8u1WjmLtk=;
 b=E3XB2VAnbNN40ybHX6NXGB99gKaZoRiEc/hb9hYGYBedVbTvqsA8M6T1MbQfb10+nO
 D72Wn2RmwZxNi6V/3wDnKDAqrA8kBT6MdXq3COaScBMFp27ja5ncp+DscyVCbN0ppCVm
 c0zzuV7xiVr46keGdExd3qpX3jNN/Q3I7/vKO5fw7WhMoSs18aJx8RWB6ax/IMUxkc13
 iLMyuSiUtpHsqeW9v6MslXjDEKd4ybrOrmkIwtr85eqW3KQ1Jjz+mZvfGhtQYf8jZsaG
 M7IowKEQKsNFcdHFCX8oWf6thykozcsU/6dNw0M8sREFdigcvycLDTEa1BuZTRqMHDEC
 Jq+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7emi5lF5TU9xkZj0UBf1XSYH2lMHegoXrToEreqcFH/uBTPBDQsepnAodrs4bNlq8/EI=@lists.linux.it
X-Gm-Message-State: AOJu0YzRR+6GP7J2I7zCCCzY43+UROVhvkwI7gfzyG4LIsO7+rrgwv0b
 hHX8ox+Chxn4/bGbCQc9JhxGutv82sstDDAJNPONRZtg6uWIo68mqN0Wm4uBZ6Mrhg==
X-Gm-Gg: ATEYQzw+Wj10ls8gQS0osyQd2RNimesC5q9g6KilOYja9uMBtitiyykV3zHFevn0ga4
 Cy13ZvoZNT20R+Nsxoy/FKLEWZUCuqR6mx47o07k99ZhJBtSaHpRhPXdZm+Nru4cpB2fmBtX9bs
 KmnCc/fH7GqimseU5JzHPmKJzWpCoMRsrMAVUjt3I+72TKAdjoZuABOuWfB1T9EZ+4A5HcxtfCZ
 EzPrvVqRSNj6qRAluatVjj+MG84/o8+sztmjkW0sovmgG4dYYTLEoT0kADPlTpFfWQ9VMqm8gms
 Vt9ZhevncVCNc5vdDlCQpEW8Q/dlgzMrOwgfRCITkwORmxhczAvdNxNOXP1aeI6brgbbxKHAZX+
 zxubKYEJkHmHagdQYe1F0OMqf6/Yw7sbjKDbFrWl9M12dF2H4a2AHb7Tl3/+bD3EHmrzklQiBVB
 O60mR/8rIAQBzxjoITWtn59tgO+YhhSO3Mj5qEeNgB
X-Received: by 2002:a05:600c:c162:b0:485:35ee:f836 with SMTP id
 5b1f17b1804b1-485566c94a6mr250992535e9.2.1773709146254; 
 Mon, 16 Mar 2026 17:59:06 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c66583sm110238845e9.21.2026.03.16.17.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 17:59:05 -0700 (PDT)
Date: Tue, 17 Mar 2026 00:59:04 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <abinWLt__rqCsLEO@autotest-wegao.qe.prg2.suse.org>
References: <20250526143551.1321709-1-wegao@suse.com>
 <20250603214503.3792293-1-wegao@suse.com>
 <DEW4S4LXK0U5.RSZM163LCKXN@suse.com>
 <aZ7Am0YgYLK33spn@autotest-wegao.qe.prg2.suse.org>
 <20260316084920.GA291437@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260316084920.GA291437@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fsconfig04.c: Check FSCONFIG_SET_PATH
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

On Mon, Mar 16, 2026 at 09:49:20AM +0100, Petr Vorel wrote:
> Hi Andrea, Wei,
> 
> > On Fri, Dec 12, 2025 at 10:29:35AM +0100, Andrea Cervesato wrote:
> > > Hi!
> 
> > > please, re-read the previous reviews before submitting a new version,
> > > because there are still some issues not achieved.
> 
> If you *were* a concrete what is wrong, you'd have saved Wei's and my time :).
> 
> > Thanks for take a look.
> > I think Cyril comments should be fixed in current version after recheck, so i move patch into
> > Needs Review in patchwork again.
> 
> I'd also say all issues has been fixed. What exactly do you mean?
I found patch in Changes Requested state so i change it to Needs Review
in patchwork(Since i think this patch already fix all old comments).Then 
others can continue review it and give new comments.
Correct me if this action is wrong :). 
> 
> Also, test needs rebase after Wei's and Li's changes to fix compilation.
> 
> Kind regards,
> Petr
> 
> +++ testcases/kernel/syscalls/fsconfig/fsconfig04.c
> @@ -24,7 +24,7 @@
>  
>  #include "tst_test.h"
>  #include "lapi/fsmount.h"
> -#include "old/old_device.h"
> +#include "old/tso_device.h"
>  
>  #define MNTPOINT	"mntpoint"
>  #define LOOP_DEV_SIZE 10
> @@ -150,9 +150,9 @@ static struct tst_test test = {
>  	.needs_root = 1,
>  	.format_device = 1,
>  	.mntpoint = MNTPOINT,
> -	.needs_cmds = (const char *[]) {
> -		"tune2fs",
> -		NULL
> +	.needs_cmds = (struct tst_cmd[]) {
> +		{.cmd = "tune2fs"},
> +		{}
>  	},
>  	.filesystems = (struct tst_fs []) {
>  		{.type = "ext3"},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
