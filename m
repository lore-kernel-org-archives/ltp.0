Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6B4C61DFD
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 02:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788228296; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gGMjH3o0K3WCkdINXtl6DfHZhIOS65PVjgh58Vj5brs=;
 b=pynk3vlZqS5FKw5uhNXdGTjnmfocrZHjDSEy94zWdHJMvqf7TxJ3M85ldf03JnQ5Kl3zq
 vir4WY/pOosKUczWXvkj7MhJOF19MoHQ2gN9UXYzgtm0uojkmG99Si/c+2qED2E8O7PLuiQ
 +uKesmi/VVEYB/zAIVRPrXPhj5m/nww=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 374A53E9A04
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 04:04:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 118B83E99FD
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 04:04:36 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 18E28600A1D
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 04:04:36 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso48113245e9.1
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 19:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788228275; x=1788833075; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2BkvDHeJH3pKQY5kWQB5Y5NQzDlPWqeg0S/bzeArJv8=;
 b=GHqf7+zBxK+nKHWeHrqO5ht5ijQpYSKOafV02XFWd9FvXyk6IDveuf4ekhl8oltvjk
 z+h4mxg/RgzdJyIexu3zxJR7Z+NCETybnE1af1+0xlZPu6paxyW0/wAnlwpwSFaV9P+S
 zq8iw0TQvUZW/1SkYuTK/omhFRTC3CvnDFp7TYKW5vmPMTBYLOjR58ioH6kUH8VcbXPH
 iLGk1MZUf40/5RfVwE7Kkz41mL3TpDTdwO/k5ENk71X5LfGblSsSFh9wsfM39JfIaMNe
 z/3ZCcuQCCCut2ky3KtNLrb5XpS4wmzmUroN8p+ogBc/nU15xhKlaU2vuK2TP81gCa0C
 P0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788228275; x=1788833075;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2BkvDHeJH3pKQY5kWQB5Y5NQzDlPWqeg0S/bzeArJv8=;
 b=hkGPj5joiWsU2WLvdiBnVrO1UvpxxTspD2obLopyjX6fX66Sq2LXotee4uHTOii+jA
 3IOIGYF7buBjFX3Ta8TvzEcEKiezSbETZue5SDjS/9ACx6KS8LROYfMAtRIbHQwWbV+l
 WcvE0y/Qj45VDoppGWFDNfN8R8F4aRd11l5qU4yE91jQvwABJslHofhx7XngsdDxsv/9
 ALZVgUt+/M+Y2qQJeUaXmVE1TFCVuvhiiyzzC6/dYM5pQ6SAR+YSYuy1bNPAXmi6kbDv
 7XqEB6TSw/wgZVZK97owq7Y35VPDRHtAxydSDHdZTsH9hfxBQDS+mMb8o6Ia1at9iWtI
 u51Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIQwhfkva85iun1iU8ysFaW7EsO6LEGRTXV9tO/n8kenJWqV7cK5sWTQhA9fQq/JkccwA=@lists.linux.it
X-Gm-Message-State: AFuF++lZzReE8LN+tLQLbbxtHPddwKk0/5urRGbRCtC2ZMCPZ0mIfVAX
 F9rxDVYB61XAZIVAofMlt6yNujzBOQHQCoMbviQiMrEQc5bJBzjCuz++612YCzEIOg==
X-Gm-Gg: AR+sD1080fhMQYViKRjaVtf35suW2t5LxeHqrYjmbgxmw3LPRG8wqVAU8p3Kt5HaeIG
 vpd764M3ZxhSp67sNElU9KR4gw9GKOrZ5/EKZh4u23ZvwTdmln9dIQYSNRVin8i3yfTtS04VbMT
 rBhaQlh4ue6uY+PwtTxNAz00SZYvweTmMsiqh4iczXmEFioHbzwdlDiiwXbEmAFGkUVo2Xf4QB1
 EhxsL1ha0EzYLxhwDmHbSKYbt/BlQkct4BMmHDLKFblNs/DUNwHfG9lV+erMSR68VWyKBy6V2ia
 O1iZQes0EcZ8LEsB/Ubw0OVewkSsgjx7krWyeI2UIvQ0AGtvk8ohtGMdUjJRtCEPrE+gM6Kes86
 q2sRsh4pWjezgDVw9usGUUA0kmTSoXvA6rnGE5Mtn4PQEL6812C7Q2hL7cmAwgSyPq0MZD/8K5z
 PUvx4i1fzQPbWZBlwmeWoXPrT4zi18TY2dmnDJE4kYxqTP7X+uUk8MJszbFxKV3/9bXK12uk3HN
 n3UdjfiDyI8tlWCInN1LcbVJPzNdNSS8RAJdeF9BxM8nvNXGf8i/sZbWHm3tA==
X-Received: by 2002:a05:600c:a48:b0:499:9eb8:a1d7 with SMTP id
 5b1f17b1804b1-49b91c3b7b6mr383510375e9.9.1788228275472; 
 Mon, 31 Aug 2026 19:04:35 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1dd0csm31548125e9.13.2026.08.31.19.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 19:04:35 -0700 (PDT)
Date: Tue, 1 Sep 2026 02:04:33 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <apYysdNBmxPxyn3z@autotest-wegao.qe.prg2.suse.org>
References: <ao7sDiRA4JguwRUl@autotest-wegao.qe.prg2.suse.org>
 <6a8ff007.b1f9e4c6.15919c.5636@mx.google.com>
 <apBH_mTl9lUxbGdZ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <apBH_mTl9lUxbGdZ@yuki.lan>
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

On Thu, Aug 27, 2026 at 04:21:50PM +0200, Cyril Hrubis wrote:
> Hi!
> > yes, basically we re-implement some sort of OOM-killer/memory.reclaim
> > inside the code, instead of using them directly. That means we need to
> > disable OOM killer, loop over the current swap status and eventually
> > raise an error if after N iterations pages are not swapped.
> > 
> > But I feel it's not deterministic because on a really slow device we
> > might run out of iterations. I still think memory.reclaim is the best
> > choice for v2 in this case, because it will wait until a certain amount
> > of memory has been reclaimed and eventually raise an error.
> > 
> > @Cyril do you have any idea on how to proceed here?	
> 
> If the goal is to make sure that kernel swaps when memory.max is reached
> we may as well slow down the dirtying loop so that it dirties memory
> with speed 20MB/s when it gets close to the limit.
> 
> Something as:
> 
> diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
> index 4e6023399..2c0c6fb02 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress06.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
> @@ -59,8 +59,9 @@ static void run_test(void)
>  
>                 for (size_t i = 0; i < map_size; i += page_size) {
>                         mmapaddr[i] = 'a';
> -                       if ((i % (2 * 1024 * 1024)) == 0)
> -                               usleep(1000);
> +
> +                       if (i >= mem_limit && !(i % (2 * 1024 * 1024)))
> +                               usleep(100000);
>                 }
> 
> The testrun increses to 6s from 1s but it makes the OOM very unlikely to
> happen.
Thanks for your suggestion.
I have tested above solution in our openqa setup but still encounter failure, 3 test cases
still failure with oom after run 100 cases. Maybe slow down dirty loop
is still too late?

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
