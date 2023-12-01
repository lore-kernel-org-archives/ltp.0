Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D342C07E97
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 11:47:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74DCC3CBDAF
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 12:47:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D0733CB29F
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 12:47:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C161F603A33
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 12:47:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701431247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O6B91z6gjzxED4lDFgctf7DnrNHVGT9cruYtrb40PJI=;
 b=Q2U7Mt+ZmWFZNmnhFciwGSPoB8AxYU5JKIIO5ah36oXp+EBl3QxhLWxz919ocquMMmvSNu
 vb5o/G7pWPmbTYCJtmipM8L2OM+cfvpTrYVj0D5knBLQM9XeleBhRSJU/TcVjuwEFiH0wk
 YXv5ETlnRrefidxzsHF1zfUrSrk0a+k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-Qykf912JOS61tdj_uD9QyA-1; Fri, 01 Dec 2023 06:47:25 -0500
X-MC-Unique: Qykf912JOS61tdj_uD9QyA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50bd93184fdso591819e87.2
 for <ltp@lists.linux.it>; Fri, 01 Dec 2023 03:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701431244; x=1702036044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6B91z6gjzxED4lDFgctf7DnrNHVGT9cruYtrb40PJI=;
 b=JqV6XaXQdleto+5sHd32NgHH7v1R7r6Lnm3ZVxbXHHkO7MHv6H2BuKpYDst97rjcaX
 YUzk+5UOYOF/eoSxhGAbeOD8OKcNb18gChE2xIPjVHn9apwSrv2u4TFrXkOMQC/fu+LC
 ZOUIkhU5eg2SeSObwVVuE0DkemgJJOMGfwwg+oKrKWfw5b4AZLsjZY1o7BQl3Dq+5Rp/
 yUAe1sARuNTKxK41ewEOlPCmQ/M8LCMmWaN3zWUGihCjuihGbGJHOXmJ8JpcNlbI8O2l
 kMRlrWH+ExEi6aUAj0oPrXv3TqR2CDyS0nJvkVqmxnsMtAzdSLNtIXf70HyfUZ+t6wDe
 5ibw==
X-Gm-Message-State: AOJu0YyUz7febZ2tlCqtz/CmcRjvK1f2cBdfToMZUMJ2IslYR/IuWgTH
 or7uu3FqkbMmJSu3HUBI1T7aMKmLa/e5mEy2Kh5fzX9MS2zYb4Pm5S2LiyBN0IFnQ4XEVvA0Pq9
 kxINlf07ag4eMLgxnDEcB4mzWnl8=
X-Received: by 2002:a05:6512:3d10:b0:50b:d764:2907 with SMTP id
 d16-20020a0565123d1000b0050bd7642907mr473119lfv.159.1701431243862; 
 Fri, 01 Dec 2023 03:47:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIzXa0UACwoBJPAyWCSAC1Y+duV3RcDtjbatRJvBPj0Vk8Qyyh0ArRw0oE6mfp11UXblo/2/cpVMmHadMy+e4=
X-Received: by 2002:a05:6512:3d10:b0:50b:d764:2907 with SMTP id
 d16-20020a0565123d1000b0050bd7642907mr473112lfv.159.1701431243518; Fri, 01
 Dec 2023 03:47:23 -0800 (PST)
MIME-Version: 1.0
References: <29d08b1d-13c7-4236-a2d5-0d7d1a0ea942@suse.com>
In-Reply-To: <29d08b1d-13c7-4236-a2d5-0d7d1a0ea942@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Dec 2023 19:47:11 +0800
Message-ID: <CAEemH2fJ+HS4pjw75uLE91XM5Ju8z9+pjeNevjwWb9WBSJ28Zw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Open monthly meeting 6th of November 09:00 UTC
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKT24gRnJpLCBEZWMgMSwgMjAyMyBhdCA3OjI14oCvUE0gQW5kcmVhIENlcnZl
c2F0byB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+Cndyb3RlOgoKPiBIZWxsbywKPgo+IHRo
aXMgaXMgYSBmcmllbmRseSByZW1pbmRlciBmb3IgdGhlIExUUCBtYWlsaW5nIGxpc3QgYWJvdXQg
bW9udGhseSBtZWV0aW5nLgo+IEFzIHByZXZpb3VzbHkgZGlzY3Vzc2VkLgo+Cj4gVGltZSBhbmQg
ZGF0ZTogRmlyc3QgV2VkbmVzZGF5IGVhY2ggbW9udGggYXQgMDk6MDAgVVRDLgo+IFBsYXRmb3Jt
OiBodHRwczovL21lZXQuaml0LnNpL2xpbnV4LXRlc3QtcHJvamVjdAoKCkRvIHdlIHBsYW4gdG8g
c3dpdGNoIHRvIEdvb2dsZSBtZWV0PyBhbmQgd2lsbCB3ZSBoYXZlIGEgdmlkZW8gcmVjb3JkaW5n
IG9mCnRoYXQ/CkknbSBhZnJhaWQgdGhpcyB0aW1lIEkgaGF2ZSB0byBiZSBhYnNlbnQgKHNpbmNl
IG5vIGxhcHRvcCBvbiBteSB0cmF2ZWxpbmcpLgoKVGhhbmtzIGEgbG90IGZvciBhcnJhbmdpbmcg
dGhpcy4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
