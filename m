Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4ECA5FAC
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 12:17:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7D523E56A6
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 14:17:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEBF73E2DBB
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 14:16:44 +0200 (CEST)
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D4F161A0091B
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 14:16:43 +0200 (CEST)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a5d8fe88f7so783936a12.1
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 05:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790770603; cv=none;
 d=google.com; s=arc-20260327;
 b=HEhkLANba15NM7kxq+Bna5okGw9afacJmxbO5pyR62qiHnhJunFMIFpCA2H6OatP27
 rrhrPRoeRVMbEVP1WJNrxLI/eKxTWoS/I3BcaRoZhQc9EPBDq21ddMsUagH24JvL+zOB
 eipP+ya5kO6vMwFUgKfQ1Ffjn50UBmid60goTA8NSgkWFtZjlxo1oU9G1zJ57t5Zcx/U
 L0EqPPDJoc+SRyDHKsr6SxMpfo8U9OgBR3eNtLKhufeiQMB7uXIu2upq8itET5+0iLep
 ordy4YoFwvoRVicwW18gqkqEU6uEDKDlcKOocfOKHRWQ3WVkB2+FKoWP91cbMRwaxy3Y
 iYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ILzQmSJ0WnsV9Aw+pjBws+cCrz+JHC1dLZQRuIX+B7Y=;
 fh=5rVajFr6pEzxGWYdr+bXx5ScH3RywqfBBFeQ5xF9kVA=;
 b=IPA8w9J6cj8rY+DQEYgQmTQpLooRxl0Ea//+4oBM4ze6QUDQ2cjZeRLjAlfHBssd/O
 vKV2AgIfztPo/QuQO9H6cjTH65syCAQFfxun8Ypk8odB76pJf2J0cpbaj12QNw5naP7h
 k0Ym6H1N/v1e+nNzotC2rJjodyA4xc1u1DgpJlPC7e/ZXyaShp3mSelhy9i0D+ZF98cG
 PPEmb8XEUP7ggZb3RGc0M8VB6HuOlbaZVbQmGH+zh852mhjA20b/OncGAUHtgx9y3tJy
 KQnshJ5yiNTKKEZG40pXNJaEW1kKf9IkoYxN8fqny9F5zdIV5PK0XgvThUfLfusrPHBj
 UlbA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790770603; x=1791375403; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ILzQmSJ0WnsV9Aw+pjBws+cCrz+JHC1dLZQRuIX+B7Y=;
 b=DoN9LP5Oh/J/iHmYjAUj9NbPR3Ukaug/4LS7DbmupPBC0fmv8HAMT01wdeiYo8NcUb
 n2UzdePTMFXm3429F83Ir0Hr6PKNDljcbGdpt4YO48RI1VSKWuNGCTMvmdLhqzpmInu6
 xbqItKaEysSijDD64Ah0/UJzdxLz3eVeh5iWcitxzR+2qsUNDznSQCkAZDY5qMudih0v
 SLVCeOAGRMrYgj6ZQJkAlwo9UbflfPBpc94+XEPTtiqfmzeaRcY3Ft7hz0uhb+k/wByn
 onJNTrE+BfkIepaeb7rqsSu+eWsj8DG900oDnn+3sP/ELsVPltFXA90jDKrMWW7ZrRRp
 32kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790770603; x=1791375403;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ILzQmSJ0WnsV9Aw+pjBws+cCrz+JHC1dLZQRuIX+B7Y=;
 b=oWQZhGuaN+W7XbvMzaG/mRqX/AWl+wf38gCRWAKY3u8zq0flOQ2V4lIH2w1+PGyc0z
 9SFzI/gah3gcRIpR6+Qpm7gnO1/ovSG2RhbEpGqyb2mSvEX6IldRG8kTfxuIwR1S293u
 aoxBrQKaDXnwZMFhfNF9/71LYeDjDdSiOEEO+HGFeDUj4s8Z4VZZosJBn9PMBPO1Zo8D
 VOkdOqKZKGKvgePQzLOc/LyQsJb1Vlo157yJd4s/29fN56J5N3r9/FmSUMyiWLpuFZGD
 LWujAYUkeKC1m7epqgSCba2mYtbZ100TzI8kuhrtjhxpV6pxOajGFOTT1cIjjw80/lu8
 QKaQ==
X-Gm-Message-State: AFq9FYKayzyEo7K3IVXDfxjj3Dha4fZdXpn2y48IVY9tWQmgyr7W/DyQ
 o6bXIxv/oS5YfrRmMrPaiVpYU8pkt0Yj5s/P4jyKmM/ZiFrNenlveBkWk5v3SXCjH2A9ySwIDG4
 l+fTU7szC0g5rIDjp58I7qwl97YPiFs3Gr+f6uTLWLw==
X-Gm-Gg: AYBFou1XmOl27O/UASpK58QL+13U5KJCgiMhs5mBumXLb7/2+Rjz/pwEe9lQDd0vLaW
 grt4MQPb+a3pKli6fBYZfIn93/rxptmYWB1xrtlnejejdqzGm5uANYE87+NapJtIdSppTrf4pM9
 nQcczj7rFrJbb+vkTGK0t0pa9C2jqIgJDY9SYNG8KkeDgiB/TLp2smYDUmlIAmepSlGMIHnI1YL
 jYDWfV6//HJsCVacjvWjvxBNSPUaOJUmyc2DtKCSympbVGNGrBbpxrZc28/e3k9BGE0/xooM/Im
 o4pHWQWgcwzb99XfinSUJCqcZGnQqQuHwmz3VXXT+HAkZcVQB0LB+4Q=
X-Received: by 2002:a05:6402:320d:b0:6aa:91c2:63b0 with SMTP id
 4fb4d7f45d1cf-6ae198c7a6emr1127578a12.2.1790770603170; Wed, 30 Sep 2026
 05:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260929084253.3093742-1-anders.roxell@linaro.org>
 <20260929142156.GB2462033@pevik>
In-Reply-To: <20260929142156.GB2462033@pevik>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 30 Sep 2026 14:16:32 +0200
X-Gm-Features: AclHuK_bU8Y2RiwbKLOPrz7vBeqYkueKMJrzgIF3UsXT2rZD8DOGOBXNJjQej20
Message-ID: <CADYN=9Jh83y=n55DbM-niXBE0kot87jECtuM778_WSo6e3p=8g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_clone: Fix child detection on sparc
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

On Tue, 29 Sept 2026 at 16:22, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Anders,
>
> > On sparc the clone syscall does not return 0 in the child. It returns
> > the parent pid, so the child thinks it is the parent.
>
> So, somebody still test sparc :). Before applying a workaround few questions.
>
> I suppose this is because we did not updated our syscalls numbers.

Yes, clone3 was missing...

>
>
> I send a patch which regenerated syscall numbers to have clone3 on sparc (both
> 32 and 64 bit) v7.0:
>
> $ include/lapi/syscalls/generate_arch.sh ../linux
>
> Can you please verify it works with clone3()? It was added this year in v7.0 in
> 2153b2e8917b7 ("sparc: Add architecture support for clone3")

Yes, it works. I tested on sparc64 in QEMU with a v7.3-rc4 kernel and
a buildroot
rootfs with LTP 20260529 + your patch only. All 94 fs_bind tests pass.

>
> Do we care about the past?

That's a good question, I think we do, because of the LTS kernels...
We run the latest LTP on the LTS kernels...

Cheers,
Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
