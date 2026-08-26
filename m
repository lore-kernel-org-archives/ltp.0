Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2350C61DC2
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 09:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787736727; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EZPyWXAq1y10MWylqaVK5xhJmqtjw6GYJqLuwl802Fo=;
 b=V7wiA/kVSQHNOrUc1/p3wg7KPAeSfckXy96/JQ+nn+36qf4SWoCyG1jBhzPxOE0OFx8r8
 VisMRVWFB7OaGOAsgKz6IMZoTi3lj9+ZvO+kzVvoG/z/gsD4fB+5S0gDCVfg6j1szdUzbd3
 MelmlV0TJaAkmX0JLD5oS97Pz8rSd18=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D291E3CC018
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 11:32:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17F653C6F71
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 11:31:47 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A58CC1A0092A
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 11:31:46 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so826585a12.2
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 02:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787736706; x=1788341506; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=auvzwMiCS1azQpcvrJ/8HiOvZnTDTg5/pKfbJphfmq0=;
 b=FaCtFM7qOtc4jC2gm8gHO8W0sueC+Skb2s7O/p2VtaWWqLemcopGghFleBLQr0NZbk
 Ox+XK7YTb092pVRZTXx0O5kOPVcIPcdZ4xZSh9TPl5DoU5OPoFSQvP0C4igxxi3pPQr8
 +lzevV1gQcrQCbdcVwOc482fBRoZ0Drx6qmn9/DJ65ic/Avit/WnnlF20zJz89TEUF0y
 PAfVGSzunQ7Pyf8fEKPxjPfbUhva5MsKSNOTPFhqx0q4g3aulf0Nu7PMzeoQYr6NuEed
 XK1snVGAWEuV356YrQUEFod4S1fv2+0OKqt1S6eBdDYqXVydh4nE75HYyeU/NiAap3ZT
 XKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787736706; x=1788341506;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=auvzwMiCS1azQpcvrJ/8HiOvZnTDTg5/pKfbJphfmq0=;
 b=mwbkAlGr1PM+OxnGQdXISQM9rHGD2RpSexXRWtHTWiLY9axDaBFDMwwvOtu4DWnYQF
 A5TWLMr0ziBjFbc4MwYfAeIt838dLoG+Tm8qA9NOYsh4pGZr/2B8UUPSxix8rMNoeQ22
 1d/2cYZWk2H5zO/9HTUev4eOOf7dEISmby3AC7Nh8wbtB0SAuHSXW75mW6yjxLtiZ/1U
 yW5EjlQ+k5aUldzoNe/yukKg4YHVIC7OnvTuEr7xk4x/JA1cUYOa/1nB0elg7MZoSWzO
 BBS/S3CBa8shRHmQYeLq7pD7EvvPH5CyIRtSDWcpS7tcVunsT6Ci0X80E+LQKscgMpRF
 q4Eg==
X-Gm-Message-State: AFuF++kLzrGQZse7BT2YjBDN84pZclM8eoINaL2sCKpAMjn3pRr3PzLJ
 FH9r6D2o42UumKSE10Kxnxh4gJCya1Rew4RfcxJbK8EPcNMdLIc9KxiGdpJKGez7Hg==
X-Gm-Gg: AR+sD1128JPKnn2FdMOm2ZF3Y5qqjuzjJTCxZSSAekU+LSynZgX5JQ2sB0otE0yrgI3
 YWqtoM/8VKA5YKV/9ZqiwjATY5550u9tRFtSU/jyNfmX7jJtnR8Ok4IqSPPMkkXR3ksZxmYTKI9
 LDMGk1VxlsMsiPBdGTEUldgSGmnBypK6+TClzqwrvEJn5d6i9hAyncgBBrMunH2Mgv3gLTCjF2t
 1qU8iFugT3n8477pDVP8R0BUdGakN/HuagQvfWq2NiW83LO1ACs3TnNG0d14sO9WElxLi89SA41
 88o/wLjIgOrFYUBkN+3DAF4nZXgGHte6cVecZnMFH7eE3MFRRFa8To3BR9IcsmCxfW6HKS+0SsB
 1mg1hTj+ETjCZn9Lfow2O55hioFTjscy6gR3JhD6FSNATrNfShsOnhKQWj99WoWxN1Z+X5nJYW8
 9Q+ZVstOf79K3GSVuzj4Kbpf2+pUW1phVy1GNVYsZ7VxrAVAjbDeRf/X4dSzyv6htrOT9sz9oQW
 gXvY5v/s9WI1RQrpZPfPmnaRJxH6jLbTVJ497g/UZ6rOfJG7X0tqJdmpdqbGg==
X-Received: by 2002:a05:6402:51cd:b0:6a3:6d6d:2296 with SMTP id
 4fb4d7f45d1cf-6a5df5d7af4mr6283217a12.5.1787736705900; 
 Wed, 26 Aug 2026 02:31:45 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deac24f1sm3338198a12.23.2026.08.26.02.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 02:31:45 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:31:44 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ao6ygGRQfGejamJC@autotest-wegao.qe.prg2.suse.org>
References: <ao6R_qZC1ged_wzE@autotest-wegao.qe.prg2.suse.org>
 <6a8e9cab.c5f98925.1b714b.83c7@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a8e9cab.c5f98925.1b714b.83c7@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

On Wed, Aug 26, 2026 at 07:58:34AM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> > The goal of this test is to reach memory.max and trigger kernel-driven 
> > swapping as a direct result of hitting that limit.
> > Proactively calling memory.reclaim forces swapping before reaching memory.max, 
> > meaning the memory limit is never actually reached. Furthermore, if calling memory.reclaim 
> > after hitting memory.max is too late to prevent OOM-kills on slow storage.
> > So i do not think `memory.reclaim` solution can help on our oom failure.
> 
> memory.reclaim doesn't run during the pressure, but right after we
> reached the memory limit, so OOM killer can be handled by excluding
> it from the chain and getting an error instead of an OOM kill. In this
> way we know if there's an error while swapping, instead of guessing that
> device is too slow.
> 
> That's basically what we would do if we want to implement something
> that is suitable for all the devices: we disable OOM killer in the cgroup,
> we remove any sleep, we give a max runtime and if that is reached, it
> means that after a number of attempts we are still not swapping -> TFAIL.
> 
> Just notice that what I just described is not so far from what OOM-killer
> or memory.reclaim does. The ending result is exactly the same, but we
> do things by hand.
> 
Thanks for the technical discussion, and we should find better solution
for avoid oom, but on cgroupv2(does not support disabling the OOM killer)
scenario, replacing sleep-based pacing with memory.reclaim is simply replacing 
one guess with another. In user-space, it is impossible to catch the exact 
second when memory hits memory.max. Furthermore, calling memory.reclaim proactively 
just guesses when to bypass memory.max altogether, which invalidates the 
core goal of the test.

> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
