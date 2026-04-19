Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2068FF99C92
	for <ltp@archiver.kernel.org>; Sun, 19 Apr 2026 01:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776561751; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vCmrNmT8QUiezaMbf9WbZ8izyJwQBxJO0nxnp2UkiWs=;
 b=hh496YoxX1MxMKduV7k9PVmWlIQYFHRANBaYBQVmqQZIyX2FpKC8DO3DKYypdqseko3sY
 I89EAdYMKNEysle/MsQ/zVBMqGZ3HsefRegHevj1o7sExh3v6MryAAJRA0wvi2B0K1xQ9Ex
 KY2t0/vafQSF5oP+b0sKcjacIrFRR1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 642903E588D
	for <ltp@archiver.kernel.org>; Sun, 19 Apr 2026 03:22:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D0BD3CE729
 for <ltp@lists.linux.it>; Sun, 19 Apr 2026 03:22:07 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ACF7E600783
 for <ltp@lists.linux.it>; Sun, 19 Apr 2026 03:22:06 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so27787755e9.2
 for <ltp@lists.linux.it>; Sat, 18 Apr 2026 18:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776561726; x=1777166526; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pHOAB2sghkKBJvbhsfPKVMhflz3+vyGHwRaM93tzwtE=;
 b=R6IkS2piFodPwss5Lh/iGmIWzbhFBiMa64QWlTFyygy/THPPEEfbdY+8XFP2vs6xwn
 M6dmVUAXIyKcOikvxx48PI4pkpRee3+/DLtGsa4r73ItXuN2RkIrwznAeoF4Pfoj04mX
 oEkJN/3iqHhlvWfNyxe6QCexJpBIrn6/loAUVOcYw15HjZjgX+sUOjTcbBVG5TTZVuNV
 2xRm4TRHN7VOBc7OnJFdOHkAr7tt4HVxrC6wKSVRbeb12LnphiwRyrhoD5buHV6cAp5u
 5VgsTtbp3abUy6grDjRjMGHJZhHPW6/UX+cbYPoig85TctIiFRFTtrsDMUb/tlEP/Q0B
 ZHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776561726; x=1777166526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHOAB2sghkKBJvbhsfPKVMhflz3+vyGHwRaM93tzwtE=;
 b=AQnlIb/n0zl+RIFJLMv0pNbLkhjBBgFG2qq9fDV/wJux0tXraft7m/3vUFJYYQ7xhY
 mdacUdp1/CcGW5U/U+TzEkETeorXfE29FoVCIiil/0boVhIQq4V98lqtpmHaIJHs6moe
 1RynkS8gnAOuFNjtkY6txzMD1xfSecKzdcbwt3BVCBP6yoI3hogUpQIkt++Ndm5sHaRE
 Bu8rpNEJMGethj6gXJ35d296J5DN9JtdSN7/73AqRcfuW43ZPmxhi+mT7wH/CEbTCn5B
 aFK928IsF6iNpV2IXf1vGiTTGUduMLvOjRSJP2e2VxsCE9aExvrGwkP4pQmZJa5VM1AF
 srYA==
X-Gm-Message-State: AOJu0YxZ/zdkc9SJ+XT2Ng5X8IB1zTp6AIU67eRfRlWAXRBcwVkP25kf
 jiaq3HRiIglEkXaAsx7b1qxRBtLEwPnlHUql9UbGtMnvUadZpMVgBD04FpYf6QL8QQ==
X-Gm-Gg: AeBDieuoEXnd24QoFP1QLH/lr9VPfQrk6FGVY2bYot33sPsh9aKKaiGEXAWSmrGP1Zx
 WILaTmdlvmOKxuesmU2bUcG0pnuhFD9kzFQhMLQwWunLjEB2+nX7ZYH+6/BIeSt+IqTgpuGa/Lv
 xFxx/Q3ej8AZYlQfJEinJK8MgwL/7ODw0Iw3YD00mh1QIvNVvd69RcJeHlxaByFCWRTqXOrCrCb
 LP01bamhkrLgEcmIFJb55z+uuejv4kQ3WSuIE347MRRHkjRNYckSLRel10nlmaPTrEG1TXgBGqC
 DJN4K+rDXyaz8yfqrlEdATTAJX6yhjBMdHLbbF8bH/UzO6mmEPC+ArNOvCritYkLaKtHTPgmx5y
 Nt/Wk/ozVeuJeCshsyESMoqJdLz/bs8lrd+emHPebhX3cZHVijHd1acQyhvg/3qNvgxsYMQTiP6
 Udmb65kCGaC13odUc72VRj60Mvqi004UljqsCE5OSXIIdUuO+YjC8=
X-Received: by 2002:a05:600c:8488:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-488fb77b575mr120134495e9.25.1776561726052; 
 Sat, 18 Apr 2026 18:22:06 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb13a0sm17309350f8f.8.2026.04.18.18.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 18:22:05 -0700 (PDT)
Date: Sun, 19 Apr 2026 01:22:04 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <aeQuPHn47KoO8r_P@autotest-wegao.qe.prg2.suse.org>
References: <20260417122804.23890-1-wegao@suse.com>
 <20260417132649.3984-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260417132649.3984-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mremap07.c: New test for mremap() with MREMAP_DONTUNMAP
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Apr 17, 2026 at 01:26:49PM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wei,
> 
> On 2026-04-17, Wei Gao wrote:
> > mremap07.c: New test for mremap() with MREMAP_DONTUNMAP
> 
> > +static void *fault_handler_thread(void *arg LTP_ATTRIBUTE_UNUSED)
> > +{
> > +	struct uffd_msg msg;
> > +	struct uffdio_copy uffdio_copy;
> > +
> > +	TST_CHECKPOINT_WAIT(0);
> > +
> > +	struct pollfd pollfd;
> > +
> > +	int nready = poll(&pollfd, 1, -1);
> 
> Nit: declare all variables at the top of the block, before any statements
> (struct pollfd and int nready should move above TST_CHECKPOINT_WAIT(0)).
Unless the LTP project strictly mandates a "declarations at the top" policy for tests, 
I would prefer to keep the current implementation.
> 
> [...]
> 
> Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>
> 
> ---
> Note:
> 
> Our agent completed the review of the patch. The full review can be
> found at: <review_url>
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
