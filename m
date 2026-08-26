Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DA4C61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787728411; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lLjtMBMVGgzKJv9OZZooG3bs9BZeHTJYHbJqz/RXcVc=;
 b=IIy9pzTy6f2DLLnkE5gXJ5/3V2W0FLfinZISlqHc9S7UfNOjaHKIabatJRiK2v3brS2iE
 I++7HPqu8VeUJOspasayOMYifJKEbsEaXd6j1SdNXid832P3lRZfmcsfRrXTiAjVR8JLuMD
 oyYKjBBjoKIkg0Wrnhi4JcVnNxbMeLQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F07D73CB850
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 09:13:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C7403C8484
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 09:13:05 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 36D29600A2C
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 09:13:05 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a17211b9ecso1358475a12.2
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 00:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787728384; x=1788333184; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ozDMdkTRa/YMJEITQFPoswLzExIJcPwb3EQ+k8c6JN0=;
 b=Rf4fWD1XUuzhqzJuNl2+tu6LWXLcQBucBVMtztgfNJa/8JBFVVGHLoNII30Rcs+HCz
 CVAyjMLtdkt3L8hJ8GBrL+LP82BM9kxNqJWMd4apADdLAJ6D85D0ZC6ZfjUO90/9Hdp7
 dIXCOr4IbzQ973cty2bsOaqCJjBpL+jFeRyQI1DrvyzbXE5irCUYytGlXGXZmye62RFH
 Jg8GN0FMBNntk3NdYyIWnbkZBrsGACrDbVOlw8Xr1hQbpJzv2k4TUiTF65+OCGZV4Gyw
 toi++SLgRy95FqkJiQYa9Lagxil3655dPsDnGl3wlcjMqgV4h4zhQSBrxy2JOIiUj5Of
 l2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787728384; x=1788333184;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ozDMdkTRa/YMJEITQFPoswLzExIJcPwb3EQ+k8c6JN0=;
 b=rjofJJ+wO06KUhna6H3OsrX/3js7Tq3m67ng9NhrEV2PwKOh0R+qBa+lJq7AtQ3KDy
 gIrwRLqyhmvyDpndBioyjqITKybNMdgkKouUfOGizsthoPwSxA/BjOgbtrSNKolKmQ3I
 aYMdMb+eFl5bKUjcjUHEaugAG1W7YAWPKqmrTM7Gi2N0ieK7GWqjSapG/pmyVsywsrVM
 GBfxFS00WLCoKh6W50B0pYE7EWoURxoKNydf7pKq4oAW8GNJiVp8pExf366lkrYOCbAf
 Epm8MQglJKM5FN+J4W4t053ntqMuFj6ndDPuwa+wOZ6WPWWOgRu8z3UYawFX9MdyE7fj
 hzSQ==
X-Gm-Message-State: AFuF++lpVcOgFkF/uyRlh9Mkv7+3GpqzeC7Ov6BUY+WGIwDVWLtdOPxK
 VtIfSSt1nKckTzAuiSWWXvBIsDTgu0is2pAppUF6NtVedOH9Mif42h0oSFsfZnAKiwu7ebSKtuO
 Jg5k=
X-Gm-Gg: AR+sD10AXeMIjfYGfbodkFcSrItr+mJRmpE8totVDxOg3S6fahI90G4oem+zePm7bp2
 upYy8JXYfdJrysFRliOpu8OOIvDIrYk0Who4Ce1zsN5Hp8PBE5PXBAK9outTUbPvtjtqvnpi1vQ
 BVcz77mhCvjCL+NbdU5TmKxOIPBaFsYhoRrMZg1w//kF9yEYjn2hDbqfgY/CL+HKaUqoqD8o5tq
 xYJsSnvZJ3VVJn5CUsMjPtd5cI9sTdImdduWmIIp9g32uRwxu+I8vjw6B2R3ByibQpGg9kubDXZ
 JVr3mQ8P0q+2UTrEVXw7j8pnGE97HDx9Ko6cZvSZ+GTd55gvu21iVM3KIOQbVRcVBLNQkjR8pkj
 fO8ORjXYNstUuBrc/PouRlDjCi+80JzH2O4fMhEoyKeXhMPuAFe5e2S4FxVq+A9FxClC9N/lT3N
 GYw+Yjd5nXd1+nzbd+UPh8h905CDyUlU0YiIXxIXc0XyOFGm2l0lxtPESnyx26t5w7fV0x3hCGU
 eGFz4vwSZGeBFMr5Pf21x3UBv1/0l038SAs/O0L9f48VVCmfHpDXj4WrxevCQ==
X-Received: by 2002:a05:6402:21d5:b0:69c:811f:8f5 with SMTP id
 4fb4d7f45d1cf-6a5df5d005fmr5282652a12.6.1787728384049; 
 Wed, 26 Aug 2026 00:13:04 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b641fsm3262923a12.3.2026.08.26.00.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:13:03 -0700 (PDT)
Date: Wed, 26 Aug 2026 07:13:02 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ao6R_qZC1ged_wzE@autotest-wegao.qe.prg2.suse.org>
References: <20260825022926.9649-1-wegao@suse.com>
 <6a8d8789.e23a4405.3c1b2a.58c7@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a8d8789.e23a4405.3c1b2a.58c7@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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

On Tue, Aug 25, 2026 at 12:16:08PM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> > Reduce the throttling interval from 2 MB to 64 KB (usleep for 200us
> > every 64 KB) in the page-dirtying loop. This smooths out allocation
> > spikes and gives asynchronous swap writeback time to catch up under
> > slower VM storage environments, avoiding unexpected MemCG OOM-kills.
> 
> Unfortunately this is not a solution but a workaround, we need to make
> sure that we are able to see any change to the swap memory while
> allocating dirty pages close to the memory.max. This is probably a
> fix for a specific target rather than complete fix.
> 
> We need to find an another way to ensure that OOM killer won't kick in.
> That is caused by the time between releasing swap and storing swapped
> data inside the hard disk. If that is not gonna happen for a certain
> amount of times, the OOM killer kicks. By reducing the throttling
> interval, we simply pause more time over 256MB of memory, but an even
> slower machine won't fit into these intervals of 64KB.
> 
> There's not a "clean" solution, but we can use the v2 cgroup support
> for `memory.reclaim` and request enough data while we are swapping it.
The goal of this test is to reach memory.max and trigger kernel-driven 
swapping as a direct result of hitting that limit.
Proactively calling memory.reclaim forces swapping before reaching memory.max, 
meaning the memory limit is never actually reached. Furthermore, if calling memory.reclaim 
after hitting memory.max is too late to prevent OOM-kills on slow storage.
So i do not think `memory.reclaim` solution can help on our oom failure.

> 
> On v1 we can either disable the cgroup OOM killer via memory.oom_control
> so the child blocks instead of being killed, or keep the loop unthrottled
> (the kernel already blocks faults in direct reclaim at memory.max) and
> report an OOM kill as TBROK via the child's exit status.
> 
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
