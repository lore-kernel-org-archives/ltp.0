Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92E0C3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 14:50:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A57833C0574
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 16:50:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC2FE3CB52D
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 16:50:30 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.212.18;
 helo=bisque.elm.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from bisque.elm.relay.mailchannels.net
 (bisque.elm.relay.mailchannels.net [23.83.212.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CC023140017A
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 16:50:26 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 7336E183960;
 Thu, 10 Apr 2025 14:50:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com
 (100-96-135-11.trex-nlb.outbound.svc.cluster.local [100.96.135.11])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id C77ED1830B8;
 Thu, 10 Apr 2025 14:50:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744296624; a=rsa-sha256;
 cv=none;
 b=tc2lpFbwk8jnNlzZxhTdJR+0tUlm/N8biAgLfXipx+ENhsK603Lp70iydt6Nr8ip+CHez2
 jMu+SjKN3bRNBBW2DA5eMcMn8ikjr93P7NnEG0ESZUOuYpJSF+Kq/N2FaNHJSUH1FxNj8V
 2U0MEC77oBrcTmqGML2cF/6wYcxyxYouQ6Ge7kxSILwB2bQuOO8sblZURUtwGyV8fr0G6v
 JStO1ZcAAxNtitPUcVk88VwuNyjRA6Oq2vEAWbt50rWgqzUtcurq+DvifcS1JXA5HPEnON
 qsdlqTLu166RnRxg+zvAl4zk554kpocCSfz1cs17BOtB7PmR9vsoWNew8PVZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1744296623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=tM3k07OgqcktIgsgr6W4e15TL9iSkIgjQ0VcMjmJlIE=;
 b=b083zWSupTIMvcwMjQSk9ZC/Ank+lrsNl8ml9OVm+EeX3dwJzT7XQz8LzN21JQ9+Kcnhbl
 EzfMfQfagaxRwIc6Qs72KyCBm9EYgpfD9dXVBzUk/Z3WKPNnTNw/j7ELwG79iwka988FEs
 xQToBO28s+FbkfTGzOnq3YNlSrg3qB4ljpcek7bxI6LyMvVT3Lvm/xJuIQJr0J8vFtNTMZ
 dHCEpKVul61VCY7USq5t75G9J3tRBqriJ7RwxWqqhsZCjiJ5rfoixxL6h95D+d4SUGjLre
 C39zWb7XUblQkq1IpyD0sZyuK8cbDNw9CnwRZzdrgZp7a9sY8mkHXfwRpayNeg==
ARC-Authentication-Results: i=1; rspamd-6c89d5bdcb-xtnfc;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Absorbed: 24fcf4da2d501f8b_1744296624205_4102630143
X-MC-Loop-Signature: 1744296624205:2165414224
X-MC-Ingress-Time: 1744296624204
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.135.11 (trex/7.0.3); Thu, 10 Apr 2025 14:50:24 +0000
Received: from [192.168.0.135] (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4ZYN5q1XRpz8T; 
 Thu, 10 Apr 2025 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1744296623;
 bh=tM3k07OgqcktIgsgr6W4e15TL9iSkIgjQ0VcMjmJlIE=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=JQxzIOGpSP6L3ymCUDh7ssfBbSmyfyfzTarE78gL5pcRfFIpNbRQ+sRNxEICtx/r5
 ijDaRujy6QToAaaGOOAaR/1E+PWBbB0vCJC/e12454aD+O2CMvMlgPem/fmi0/3JNi
 N+DKgj4ZXax2hGo3Q8pWkdlV2nQ6bmQTtJX4zSvCK9P0t2ifTjDn12ZnlLl7a/AVRq
 Imb3pKpfmSe0rKttwkB2la0iSciGauwb6l68LN0vcxO2Gn9SxAVoKI0oqZ6MQWqolJ
 WUnwQktRkeBPiqwVluHoEB14zObNZIxMzZx3idhZAX2iMyXioZIJ10Yy5TdjDioj3Z
 IZMA/vEpQl6rQ==
Message-ID: <87116021-5a21-4248-ac4a-6da24dac26dd@gotplt.org>
Date: Thu, 10 Apr 2025 10:50:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250407102448.2605506-1-siddhesh@gotplt.org>
 <20250407102448.2605506-3-siddhesh@gotplt.org> <20250407111343.GA83774@pevik>
 <ea5bf29e-cfe8-411c-bccc-0a586231e4f7@gotplt.org>
 <CAEemH2e_vqHjCmwCDhK444=RGMvcG69Bv2GYgGXP7d=OqYrG1A@mail.gmail.com>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <CAEemH2e_vqHjCmwCDhK444=RGMvcG69Bv2GYgGXP7d=OqYrG1A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add centos10 to test matrix
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2025-04-09 23:03, Li Wang wrote:
> Hi Petr, Siddhesh,
> 
> Siddhesh's words make sense, but considering we (RedHat) already test
> Fedora-ELN [1] internally with the LTP latest branch, so it's not necessary
> to enable CentOS-10 stream in GitHub CI again.
> 
> [1] Acts as a testing ground for RHEL's next major version (e.g., RHEL 10).
> 
> @Siddhesh, you can find the Fedora-ELN test in CKI system, which plays
> an important role in testing LTP master branch.

Ahh ok, that's fair.  I wasn't aware that LTP tests were run on ELN.

Thanks,
Sid

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
