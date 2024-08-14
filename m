Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9EEC3DA4A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 06:45:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D3D63D2131
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 08:45:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 846FF3D210F
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 08:45:32 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D03D21400BDA
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 08:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723617930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNuhH7XRzr231L/zb2L5tWd5joiezOmHdRf6uARyWSg=;
 b=f44w07NrRa7hDXLSWs4bJCMZRwy/1me1o0opl85+H/Hu7VARa5TgAg1eY1nL3hz9vWw7EE
 IfDDzDe7KagpfguFzi6Ej39qe6Xg5DSn7DigyBhdUa5GN2uWQx5FehbZN/6Lqcx5OjTs6d
 xo/qZVwwy0wvv3r+3C5HxyjMOXAwpDo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-e6GUX-UpM9aJKgS_EP21NQ-1; Wed, 14 Aug 2024 02:45:28 -0400
X-MC-Unique: e6GUX-UpM9aJKgS_EP21NQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3db12b297edso7295996b6e.0
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 23:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723617928; x=1724222728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNuhH7XRzr231L/zb2L5tWd5joiezOmHdRf6uARyWSg=;
 b=lH6/OdNF+G98RGiDzNoXg8+9BCASon/PHi3e4dLUwikgPmH75TWSAsQSp2he28Hp+d
 IpAwFdtzCMIVu1mE+Gylqdv45Xv+31siW2Yj/kjOVSVBXf4ib/sLld2+Xho/Sm45nzbn
 yx7j0M3FEygIcPInYEx/mLjmPJcbof71ddYDHYxO6vY6F3eVa4xGx5Jy0RWWU9e3s1h1
 oEv3ai2PoFSJXGYb+owm4jtklnKo8fi552oDBrgDcWuGGtp7jZKLvvnL4oNci5MUu6kb
 iadspVISaM1KKJVQY/FeqEcHUpxCWHiDqA7sWlOurPb115yr5FfV5PUrlO/yG0ILGK53
 puDg==
X-Gm-Message-State: AOJu0YzsVK9R80t6vMp5dF+D1qEU7BzF6iSAXuZV4GQfLVzM2vHqwFo5
 CSn3OBULvbpBJ7Wrfdl7qDTTNM5nPgVtlSdEaiOpzKfTu0gq8+hAUvqcw00XNy1yJq6Wv9o8+9U
 kp7KiNFU1aooNm2RWSrbVOjFNLOqWI+FOE1zVcXzOARTjx5cy/tZ+iRo85N3JrwAeKTEzZYQEwC
 ZBmadKiLheG8kyAIxnh4eQG5A=
X-Received: by 2002:a05:6871:520d:b0:261:7b0:9d66 with SMTP id
 586e51a60fabf-26fe5c8313fmr1845007fac.50.1723617927898; 
 Tue, 13 Aug 2024 23:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9NGjDo5fOoksRqVct7y7UKNHRZjbBcqvVPtqmPwoVpJfmB+iVh4431S0FdoTwqLHyZ5vVNWkQX5mKCIgMhkk=
X-Received: by 2002:a05:6871:520d:b0:261:7b0:9d66 with SMTP id
 586e51a60fabf-26fe5c8313fmr1844999fac.50.1723617927496; Tue, 13 Aug 2024
 23:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <9a9b743304c2b6ad1a045f26d33304a3350cdf4c.1723458583.git.jstancek@redhat.com>
 <CAEemH2fMVJ6KCZoFOp=aj28JFB62aE0Bfpixm1E=XGZbact-eQ@mail.gmail.com>
In-Reply-To: <CAEemH2fMVJ6KCZoFOp=aj28JFB62aE0Bfpixm1E=XGZbact-eQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 14 Aug 2024 08:45:09 +0200
Message-ID: <CAASaF6yXAi67YRfME2=ds84ma=O6m56ha8CC6FPR3CTXWWugtQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/execve04,
 creat07: skip for kernels 6.11 and later
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBBdWcgMTQsIDIwMjQgYXQgODo0MeKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+Cj4KPiBPbiBNb24sIEF1ZyAxMiwgMjAyNCBhdCA2OjMy4oCvUE0gSmFu
IFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+IHdyb3RlOgo+Pgo+PiBUaGUgYmVoYXZpb3Vy
IGlzIGFsbG93ZWQgc2luY2UgY29tbWl0Ogo+PiAgIDJhMDEwYzQxMjg1MyAoImZzOiBkb24ndCBi
bG9jayBpX3dyaXRlY291bnQgZHVyaW5nIGV4ZWMiKQo+PiB0aGF0IGxhbmRlZCBpbiA2LjExLXJj
MS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+
Cj4KPgo+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KClB1c2hlZC4K
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
