Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFE9FE5214
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777032202; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ICKkjd4Hai4m6MCbU9gNWBGVE4fgQEG41uaiOxLuG0I=;
 b=KPWlXAHsE2H8hYO1pyP+XTRO0O0e5g3x225iZ20qBbNNrVHMmBw08ZYrkJK95PT3oiuAs
 hVLwmENvGZB6hW4G/wc4Jagw2MiwISB3qELkLt/HUXlaZ5LgYh24MzmA/9fnEaM4NVZNa7I
 WYSMeEY02C5C8BEC2zvrox7wG8P2m/k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 906C83E5348
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 14:03:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11D743E1AA2
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 14:02:56 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 78C9760049C
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 14:02:56 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so83559415e9.0
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777032176; x=1777636976; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qBlJzw0XoK4uFSZtBzeZk3bAjAIK7gnQ7gaTwsFaUcE=;
 b=PEp4K3tHjRQVZ5Yt55v5C4afiIbNhUQQeQseUp8QuOeXU2CRIdW9h9bmGdjxGaTWhs
 muAFyc3jTSkgIYc3RT05ay7w8nl2W7T3wRY3LZkv8vxDsx50xY8iETbda+OlTe5PX6Wt
 3J1Ed3KAPFQMACnBJh3M58PjEL6jg1ZobpV79WfUv3bJDC/uNtzPquUh9f1WyBG9qrrn
 cmNBD+cAqIVYl8z0j7bHUaiIiKyRc0mUpP5iWfrM78nKCpmEQptlwTRK3JqztClyou3F
 ikYduWgjdJ/pqnwM3ERDWhVCtte3jtod5kHQfnbidu0h2t8AedKRl/Pk8L0rK/MqWZu9
 q9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777032176; x=1777636976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qBlJzw0XoK4uFSZtBzeZk3bAjAIK7gnQ7gaTwsFaUcE=;
 b=fUKQ4fwuyHwT8o0e4S3DnNZj7avnDjUvp9LK0ys4wIBWhEtOfB1ZhyZoamJ1pF2UDr
 xOaVsoQqWlnCcGpZDqcM9PhytWyEMAFBntls9xRBbcbb6RsrjI7hp+RVQ/3E0Li+ciE0
 Q4e1r9U6bnKB/XtcSRaca4h0upWwxd2+Qoshj6POyZuuTVzlpPzaHauxXzGR0Idz/+fd
 1ZiU+saiijrvW712PKMZUwGfMkqR/AJOn8/mdQdbo6kpqz7Igj5Rrv70zBHgIs5zU+ls
 NgVc1OpQuNfl/DjCXwj6W7BEx6I7K5IosHz07fl/fAOYuxjdnuKwQxlWJlwMu2Y0fi9A
 DCSw==
X-Gm-Message-State: AOJu0YwOcWwlA1G941jwiltMziTkg3Inok1xwRmqZfyucMHiOqisBFDI
 YJ4b2Vv/QMMd+09Pu7RmarBScfxZxIC/iqWC/JfG2UyznlA4pCgNTOEZfvFH094jBg==
X-Gm-Gg: AeBDietU0tSSNBXk01mwmRKyp4qvKJzi8E/CRfp43Fcx/joeDI87psPb5OpHgJ5t7LG
 q/OXmYBvh8Xd6y1hqYIR5tua7wL0NBrWUvZVPlYZojLTpVm1YHXebh22lfu2l0RjOazG9B8Lh7x
 L9hoQBD0Ff4ymcGSOILfitm43Rt8Mz/QVuUTPXXSYRgMiYmGjFW+iWwoJHyNeqixGWRIjOGHpt9
 3PODVk+1/mi5bTh1bwEX6XdAjq7Ga5tAchTeYCV0Xg4ddEcBOC022DHOufLlm3YXkUOAG4hDUQg
 Rwmnx2vtNgyuxj9gHIjo4yvjLumIM31WEFkwEYNIe7RHfMRIUk8xJST484MgS0HyleF6xYXWBxF
 z1ySluJn/U3Vfsf6P/RvYqXq0FpAQ8N5JYELQDRtKyJr1C9RXBeEP1Lc3MRfXkP0wt70Sadd5f3
 nzCiCkiJTtOqdCMap2lsK+d2xbe/d0OMMSUcM3DbWvxJ1WM8YWCPIWbG3UIuWP4g==
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48a52f2a5f0mr256479945e9.18.1777032174195; 
 Fri, 24 Apr 2026 05:02:54 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm56423315f8f.32.2026.04.24.05.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 05:02:53 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:02:52 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aetb7HIEgZoZE8NO@autotest-wegao.qe.prg2.suse.org>
References: <20260406023538.14739-1-wegao@suse.com>
 <20260424102238.GC505126@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424102238.GC505126@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl_pidfd06: Accept both ESRCH and EREMOTE
 for PIDFD_GET_INFO
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

On Fri, Apr 24, 2026 at 12:22:38PM +0200, Petr Vorel wrote:
> Hi,
> 
> I have no idea what superseded this patch. But as Wai prefers it [1] I set state
> new.  Alternative patch [2] [3], with discussion under v1 [4] [5].
Thanks for change to new state.
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/ltp/20260424095900.GA500158@pevik/T/#m58cbc2ecf73d7448bcb466a4a84b6845f147c1b9
> [2] https://patchwork.ozlabs.org/project/ltp/patch/20260424101508.505501-1-pvorel@suse.cz/
> [3] https://lore.kernel.org/ltp/20260424101508.505501-1-pvorel@suse.cz/T/#u
> [4] https://patchwork.ozlabs.org/project/ltp/patch/20260424060543.462475-1-pvorel@suse.cz/
> [5] https://lore.kernel.org/ltp/20260424095900.GA500158@pevik/T/#m58cbc2ecf73d7448bcb466a4a84b6845f147c1b9

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
