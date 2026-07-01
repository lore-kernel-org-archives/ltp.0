Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895A2C43458
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 18:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782929866; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=RvsClwYHQb2Z94fUX0OVnH8Y1sAnFtAWlL8+ll0Rl+s=;
 b=b7UMYEKp/J+1qRxF5hzG9OjnS9bhekoVVDjD6aVDR5BzCgLKzo3khEai7lz2ZwwOBoRAa
 zcs9QInlhLgQd4iDIAw2mtkTnpr5CDwNYqfzuFYbfFm5crurbGwBPTj179NK1Z2jx5rHeP2
 Hjt0+6YUI8UETtCXi11/qUaCDecf2VY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89A7B3EA697
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 20:17:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6EB13E9D10
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 20:17:25 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F25571A00A36
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 20:17:24 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so6998445e9.1
 for <ltp@lists.linux.it>; Wed, 01 Jul 2026 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782929844; x=1783534644; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DcHkyqFXT1xe36fvKxDKnxC6Rfqa1aykIxuEQiZgWLA=;
 b=OWpPUHOhqlAgxEoTEH7gOwcmmh0OK7qcDXrFkI1QYps2sCwCIibJikDuidNIW3yKJg
 hDBfs1FYRboPMgC5ZUOgeqPCZeaNhWJedvKkJzRoEdvM4ubhRBp5juTpGvzgajxOXhRZ
 FCqbUsUjnAip4OihNXETvEp+ejbGiSSLwGBmG19C/D7ymEQh5TljYmHWHUaw313/FNcq
 FDTZPXewRdgIz5kv8d3zSiBEII62C2V9Yjx3pBDEqWwU/3W/1xNDcvuLJzIIh1l67Scj
 HDVyzthJTL/T3ke1RZDmH3kyS8PsIYSmg718kfEJI24DrO+eCUQinlVMzaL9RsGYSSIk
 bFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782929844; x=1783534644;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DcHkyqFXT1xe36fvKxDKnxC6Rfqa1aykIxuEQiZgWLA=;
 b=UxZUuZq4ekAywU9SImIIEPkeKr46x1sHpQ5iITx3eJgSvsUCwFYumIKDyUrjnD9G32
 oJBZJX9d+WU+NkTpN0gcSGb6j1hvuQ2wfMm95PLkX+AnstGjzZ6C8T22yE6LKnS3jyvu
 tx6vDSIU1ZHHj2nwFatVmCy0xx08gh94y/MVxgjLszhyoCmDG0y78mP2wCGw03H/1b5e
 nVTpC2Wg20V5rLgq6Y90FslWA/LOmC065XqJ/s/R7ymrTzR/57IIVwS1ENPBr1xqOXGC
 INnmy4AgQeggvazQaWmnMdd731pJnxVa1vQT3bkdTkT8QUWRDn0iM4zeLZBAoSOfASAg
 lNyg==
X-Gm-Message-State: AOJu0YxeetRRxB60NU5JeEOgCs9xUuRezRYkfTf/ICAzrGMwdKeNlx6R
 gE5pSRQA6cKGwHrOqIQKK0uTpXLu4swSmJS7Z8AQdD0mjZogulbQ2dfOyRYFY4bjAST8OhdFSgB
 BVsR+d48=
X-Gm-Gg: AfdE7ckL3/jcEYbCb101iWGtKB5TUMOoa11L5CeS4JuTZFx4AIsVXIrv6vIOq/eybwA
 82972kOllNZuBYsic9BQmiaUH3HWCkkRmpglMCTPY1lWaWCST20qnS61D/d8npO7I1+VReYygex
 dG/SCIpxBbp7gVQoEI6x7qArPWZk+EiP0LQdVBb24Kx6WCAfqpLoYhXSF5FWRNNsdMGpbhNgs/b
 VZYp7KMuEVZ/xcbhoqdrPQLTX2QuYMM6NUcmcZE88PvTIlpLSnqpyEXinA0azCXhQOA8JHUPCaH
 FbZnaYhKrOKUmFLLkDbJrSPjCmEimzhcvKT/7jE2xLL4+27S922i5WsvNziy7BlZg4slS3aMU3b
 eI8ELkmpXhbUoR2RRXm1mqaafnt/fJrRszJ25H0xkgRmQZRSjgg0vgyvL/GRVPnO7gkMBRE2va2
 jdOLFtgRCfY3JY77E2TR0hDhP1qIBTbw==
X-Received: by 2002:a05:600c:3222:b0:493:bc92:2a2f with SMTP id
 5b1f17b1804b1-493c3cd5914mr18370505e9.1.1782929844261; 
 Wed, 01 Jul 2026 11:17:24 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be810c02sm101131525e9.11.2026.07.01.11.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 11:17:23 -0700 (PDT)
Message-ID: <beb393df-c89c-49e6-9e68-3ab9eb0d0bf2@suse.com>
Date: Wed, 1 Jul 2026 20:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
References: <20260701110038.175976-1-vasileios.almpanis@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <20260701110038.175976-1-vasileios.almpanis@virtuozzo.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] df01: detect "fuse" fstype in addition to
 "fuseblk"
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
