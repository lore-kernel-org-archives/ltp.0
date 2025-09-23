Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490E0CAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 12:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758629383; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=wFTsl47QyD8BNX/9+JzjCB8rCFkvvhFSyTKrdEQ9UoU=;
 b=O+GUhB2ty3SI7qMMHqgfmFnsOxhCy0FScGUKk95PuV1Hl5vaYtF8v5831eakVcE/xNNI4
 q5aNLnmjIR2hGih/udG3DyWeFfbubmK3v2xXBUTMuvihOzx4WHWAiPw/XbCwy0OZGTXIJ5t
 nPtQNHk3JpzghXxg3rn9zfgCZfcRtDQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B14E23CDEB4
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 14:09:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2773C3C2566
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 14:09:23 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 29457140075C
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 14:09:23 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-631793a68b9so5308443a12.1
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 05:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758629362; x=1759234162; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QEOInB8RrcMUvuh1DpGXyT2eK/8tI06KH3d9slKTTo0=;
 b=JDSWzuefre78U3lDRmb87DJbUas8d8Ol0k3A1fRKJFo8j79x6EqqW1XHqJxTkVDJ4M
 DP10c1iMONfJNgYSELMj+YLQEh3+VGI1MFsJScRkXnjg+bAUAnfPAWroRVTtTDQh/9Ys
 WVsXIR/21JpOXSD7uSN3973mIyDxrZe2Ea9jPbmU5X+FD4CYvVHk8F3XG5QHGXX/aAxP
 51crAggKjaybEe7xNt69e5yp8aDYdVL7fiRLlF0B8CDzkDozowS/Uu2RGpxH0y1VnRR+
 lzj3VK4WdpBwpUviuEP/PEOXYi9K9isqS9Qh6F5DZq5CvZSahjX0xHpgO3xYTfL5mso8
 eg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758629362; x=1759234162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QEOInB8RrcMUvuh1DpGXyT2eK/8tI06KH3d9slKTTo0=;
 b=IpiHUyu4sMtiFoSwbrqJ36DW8Og/U9Q9YGyWJSB//aykqoWvkOu+F0wJq7Q9RBc/J7
 UqJ/P13tFKnAfhBqT4o7U2nCgnMye3A4VXRsKdjNbEDBvpQ+L/TXbMx5oHlwmom+ZNXI
 I3xSpXIoBAxx/TW1tyTkfX2QW5kuoigJ+OPbOOwhgx2P8Ocx6pLrcwlslnjziWBLMB5k
 baR8ASd6tPTEYQZ6t3Q+yrgtDuQW7lUDakXTlAdEBSCPA+vu117HTwf/fHRNXvKYG78W
 jz27znoXbxi89uTkt8U34j1B2hUr2a52igtvPSwT28hmg2waZ28ZeZdQgoLAoJNbT4jG
 Qbyg==
X-Gm-Message-State: AOJu0YxXQAb9yvs2FQuWEz+K4sNCgxbZbGs7tiKS5LSUKwnrPpMymtmj
 /qtd37gEIl02P0kTVB+jGJrgWsZ+gmXGTJw6TLhSMUFPI99qtt4k2Pdwx3JFXpwxlwqk5AcvQuh
 V8lVE
X-Gm-Gg: ASbGnctiR4h7XYwd6o4rVjISHYRN/xDBhuah0SUeu0Uk7YSHRBrIHRC9iEMP5M0hVpf
 OMyLROQkzdWxjDCbgA0L6uljHoqEnCQQ8zuoODHX+e2xWjhuYkcWakZpzJCSOrFNr1mJzIxGPfc
 3YsTc1JEpus2mi+yNfAUQZwlDXO9Gk5punTcAygAgTMFt+jUckP5VCbLY3jjR4Yh29OgIeOxnl4
 eBzCzobSWtcpKDrpSmryysjJrv9IJ/nqOoFSp2ZRtLsTVvVN1qvcOI5H51zQ3Y+jGC8ZRAyg05U
 4MWUmJ3KrqlV5aQAsTbxLCYjXEgyQrUBkd3521wbwOQluMJmYvLReNGKMNAcqcRdsILNUtiG8Xs
 8sZ+0/qEdffOgn0rDLMsmdTTp0ZaOajTm2w==
X-Google-Smtp-Source: AGHT+IFGplO/hxaTwiAMNy9sL0OkuAoKpuPK29ZReVb14ZhU7/LjFqAlwdY5hEJ/AJI4gKodZm9nNQ==
X-Received: by 2002:a05:6402:3488:b0:632:eb2c:923b with SMTP id
 4fb4d7f45d1cf-6346782af38mr1921155a12.31.1758629362316; 
 Tue, 23 Sep 2025 05:09:22 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6344d2f9358sm2979257a12.47.2025.09.23.05.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 05:09:22 -0700 (PDT)
Message-ID: <87878992-ee9a-48a3-93a5-7e38bcd65bc1@suse.com>
Date: Tue, 23 Sep 2025 14:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250923-cve-2025-21756-v2-0-3bb1a6363123@suse.com>
 <20250923-cve-2025-21756-v2-2-3bb1a6363123@suse.com>
 <aNKKtXeaxoAfTsT8@yuki.lan>
Content-Language: en-US
In-Reply-To: <aNKKtXeaxoAfTsT8@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] cve: add test reproducer for cve-2025-21756
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 9/23/25 1:55 PM, Cyril Hrubis wrote:
> So this generally works all the way back to the oldest LTP supported
> kernel? I would expect that we would need an EINVAL check here.

AF_VSOCK were defined in 3.10 (d021c344051a VSOCK: Introduce VM 
Sockets), so I guess we are pretty safe.
Should I merge it after the Review-by, or we should wait for the release?

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
