Return-Path: <SRS0=xZdR=PI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E442C433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 06:12:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F32860F0F
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 06:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F32860F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BD1A3C4FA8
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 08:12:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C9313C3077
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 08:12:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 08A5F20108A
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 08:12:22 +0200 (CEST)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8165240002
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 06:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634710339;
 bh=SlQWP0PiFCyldBmS9KMGmJEqC/mj8npse86orPFdvM8=;
 h=Subject:To:References:From:Message-ID:Date:MIME-Version:
 In-Reply-To:Content-Type;
 b=sqwmhgUVsAls4k2Q1Xs1dqXSYbdF1CBmfjbC46wai5S+bgq9gmOOqKYH9KAhHZOqU
 72A2JKFOX2+Gts/YnlzV+TrEU/QjX1uVAlKT1eUNWJrvU2DIZv2CJTJAPA56lqCLiP
 QlH1pt+lv4oCgm0a+TFnVWckUdluV7EWxzhLq7JGq1Cpl6YK8IzwA7KqgtUNyYgrAJ
 kD8U4EwtwzPwmOPTU57eMII0wFpiRgHcWo8CchfuJvxvRr+oipA7fS/BaezD7SUur0
 sgwdfSkG6F9LCrraTAPI+vJIWehJ30PGzXHPzsJoO93tfqvSqUqlkNvhjgblEHI9FP
 RRLBe3Msc8AFA==
Received: by mail-lf1-f72.google.com with SMTP id
 bi16-20020a0565120e9000b003fd56ef5a94so2649963lfb.3
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 23:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SlQWP0PiFCyldBmS9KMGmJEqC/mj8npse86orPFdvM8=;
 b=QN8cQR8UVHNl2EGRwuTGQ5RzAa+ZmuQtkVNOnTt41oqeTMr2hZsy78+EF/kdXs6KhQ
 USWrTPFB5+BcpZ1wYYX+rt6ll4913mUNPxwCXW8HNu3bwxFqML73FU3okNJ4YG0CSO7T
 3KM6CgZiZ4BJPBv8LoKbI2YN3vHpJRlFsDo6PFH/3emHeYC7Sa85M2OXmHfk2E0Y1mLa
 ZeIttsz5Mag6d3+Pw9/kxk+Ufu1Cy9T6bExn/CVFFL8iicJ9jKbxxztybTvdT1SFCdAr
 5v9/O4AKVkyuNtjsx9yZTd85rl126ALtXDVil+r/oKx+o1fScTxA57DQYPiHvaxtaY0I
 iACQ==
X-Gm-Message-State: AOAM533sL3JzdyTOFtS3/J/4dliDX7Wfs2bkygrJJTTeDwbj/l9lubnv
 2ahHOUycyOdvLS7XYc4KAyuQFvba85Ug+eLveUd0TYQY1laWyKxGoOZqhPFp15hxRFilyUabdpx
 PpDPDVvF6bkVszwUmb8gQv8Uu375A
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr11857110ljm.169.1634710338608; 
 Tue, 19 Oct 2021 23:12:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFVDp/AminlZirFW4tLfRb4rpLXjZtQ2YZxIzqJIsWuAArHxkoBSxX+2yWUnkbKwWGj98d5g==
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr11857088ljm.169.1634710338377; 
 Tue, 19 Oct 2021 23:12:18 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id n5sm107494lfu.126.2021.10.19.23.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 23:12:17 -0700 (PDT)
To: "liuxp11@chinatelecom.cn" <liuxp11@chinatelecom.cn>,
 ltp <ltp@lists.linux.it>
References: <20211019150206.90335-1-krzysztof.kozlowski@canonical.com>
 <202110201356480826324@chinatelecom.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <41804f1c-c4e1-ef7f-c2b7-b2c963695285@canonical.com>
Date: Wed, 20 Oct 2021 08:12:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202110201356480826324@chinatelecom.cn>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: memutils: respect minimum memory watermark
 when polluting memory
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAvMTAvMjAyMSAwNzo1NiwgbGl1eHAxMUBjaGluYXRlbGVjb20uY24gd3JvdGU6Cj4gU2Vy
dmVyYWwgbW9udGhzIGFnbyxpIHJlcG9ydCB0aGlzIGlzc3VlLkkgc3VnZ2VzdCB0byB1c2XCoGF2
YWlsYWJsZSBtZW1vcnkuCj4gWW91IGNhbiB0ZXN0IHdpdGggYXZhaWxhYmxlIG1lbW9yeSBpbnN0
ZWFkIG9mwqBmcmVlcmFtLEl0IHdpbGwgYmUgT0suCj4gCj4gUmVwb3J0LWJ5OsKgTGl1IFhpbnBl
bmcgPGxpdXhwMTFAY2hpbmF0ZWxlY29tLmNuIDxtYWlsdG86bGl3YW5nQHJlZGhhdC5jb20+Pgo+
IFJldmlld2VkLWJ5OiBMaXUgWGlucGVuZyA8bGl1eHAxMUBjaGluYXRlbGVjb20uY24KPiA8bWFp
bHRvOmxpd2FuZ0ByZWRoYXQuY29tPj4KPiAKCkRvbid0IHJlc3BvbmQgd2l0aCBIVE1MLCBwbGVh
c2UuCgpJdCB3YXMgcmVwb3J0ZWQgYSB5ZWFyIGFnbyBhbHNvIGhlcmU6Cmh0dHBzOi8vYnVncy5s
YXVuY2hwYWQubmV0L3VidW50dS1rZXJuZWwtdGVzdHMvK2J1Zy8xODk5NDEzCgpVc2luZyBNZW1B
dmFpbGFibGUgc2VlbXMgdG8gYmUgaW5jb3JyZWN0IGFzIGl0IHJldHVybnMgdG9vIG11Y2ggbWVt
b3J5CmF2YWlsYWJsZS4gSXQgZG9lcyBub3QgcmVzcGVjdCBtaW4gd2F0ZXJtYXJrLgoKCkJlc3Qg
cmVnYXJkcywKS3J6eXN6dG9mCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
