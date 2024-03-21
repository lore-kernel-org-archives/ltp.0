Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447A0C54E58
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 10:25:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 878443CF5A9
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 11:25:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 960AB3CD7F2
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 11:24:52 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5CA56003BC
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 11:24:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711016690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ymQNteazcn0i2gckWSExNpOHRJNHgjTYBuDVTBKq/uQ=;
 b=BNAhyompl5FQQTs+uyJjlSbrIgXYHY2QfUxhOUsBz2utqa5QdSNyAln2rP+oR5LWjGU+oU
 3ptYmpkPPYnvBMPwnRK4ppj/AicohzNZH2Ykmq3vW9CTkiCF0Jv6goucQROTEysjyvt0V1
 bSNM1cSL3YRE2Wo3nBIRMJq5m34hDJI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-rp6H4VjIM8Wuw-iEZj1Lkw-1; Thu, 21 Mar 2024 06:24:48 -0400
X-MC-Unique: rp6H4VjIM8Wuw-iEZj1Lkw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29feefd1a95so622596a91.2
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 03:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711016687; x=1711621487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ymQNteazcn0i2gckWSExNpOHRJNHgjTYBuDVTBKq/uQ=;
 b=e/i3V+maPj4R9jxRnAu4g1ZlqFReqR/qDzfTGNBvyvAH14PFiyY6MvFWUKeVGUcd+e
 YsG956ck9oWGJhzz6IsZWv4JQ1GG2Ddb/9Ffiwh8Kr1sZTFR60ng9lCpfoVuAOzESG1j
 IwibfxHQt5B2dUfzwQXxExS+8Hx6pJKS5JEeJReKLityg/FYHFh0eMYgTwhsJTEqovUg
 DQ7xL0pPxFsYk8vCtmPa0Ak26kYc1m+q3w/qc5PckPEmPLbQFghpZyedFvGeP1hdkZ5p
 Cb1UYyj9VJos6CZbyp7KS+aww6etRn2o4dlWEhmL5nSbIWJPs1GFnJEnmgsF8OUq94yB
 XyDQ==
X-Gm-Message-State: AOJu0YwIywBGzEYZ8MECpA/yhKchu+/XXpPfuI/Gg5IQrWttuJmRxJ1G
 mV09Y79SNc7MHJOswQpH28iJYs6YDoehwfTqU+7bjOibTGKvw4+XQtcpM9bcC1+OxHD5CA3462L
 jzJSOw8bQOLDsytX7jIukPGBKcgKExd4nsWTOjN2PJiKSAeLtlecrDAnihl+TvGTW5L315SYXoA
 +HEjHUgJyCq2MGmK2KwwIMCik=
X-Received: by 2002:a17:90a:4b02:b0:29e:c3d:c3fc with SMTP id
 g2-20020a17090a4b0200b0029e0c3dc3fcmr1591269pjh.18.1711016687168; 
 Thu, 21 Mar 2024 03:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLHWH9RaKSq3i1DuOAnwMDc/ta+Hhfva6blEhvE1qnL09GkXbT76KNQlXjYUXtzc8s/wjfSQFZoIUf3IR1xUE=
X-Received: by 2002:a17:90a:4b02:b0:29e:c3d:c3fc with SMTP id
 g2-20020a17090a4b0200b0029e0c3dc3fcmr1591259pjh.18.1711016686858; Thu, 21 Mar
 2024 03:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240321025951.3263265-1-liwang@redhat.com>
 <20240321074642.GA535207@pevik>
In-Reply-To: <20240321074642.GA535207@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Mar 2024 18:24:35 +0800
Message-ID: <CAEemH2fVW6sT1TCbU6KHWz-ysdwp7Qnhq_PJbpiW3NhAke0GQw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] madvise06: set max_runtime to 60
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
Cc: Fendy Tjahjadi <ftjahjad@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXIgMjEsIDIwMjQgYXQgMzo0NuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEZlbmR5LAo+Cj4gPiBUaGUgbWFkdmlzZTA2IHRlc3QgaW5j
bHVkZXMgdHdvIGxvb3BzLCBlYWNoIHBvdGVudGlhbGx5IHdhaXRpbmcgdXAKPiA+IHRvIDEwIHNl
Y29uZHMuIEluIHNjZW5hcmlvcyB3aXRoIHNsb3cgSS9PLCB0aGVzZSBsb29wcyBjYW4gbGVhZCB0
bwo+ID4gdGhlIHRlc3QgZXhjZWVkaW5nIHRoZSBkZWZhdWx0IG1heGltdW0gcnVudGltZSBvZiAz
MCBzZWNvbmRzLgo+Cj4gPiBUbyBwcmV2ZW50IHRoZSB0ZXN0IGZyb20gZmFpbGluZyB1bmRlciB0
aGVzZSBjb25kaXRpb25zLCB0aGlzIHBhdGNoCj4gPiBpbmNyZWFzZXMgdGhlIGBtYXhfcnVudGlt
ZWAgcGFyYW1ldGVyIGZyb20gMzAgc2Vjb25kcyB0byA2MCBzZWNvbmRzLAo+ID4gcHJvdmlkaW5n
IGFtcGxlIHRpbWUgZm9yIGNvbXBsZXRpb24gZXZlbiBvbiBzeXN0ZW1zIHdpdGggc2xvdyBJL08u
Cj4KPiBBbHRob3VnaCB3ZSBoYXZlIExUUF9USU1FT1VUX01VTCwgbGV0J3MgYmUgbW9yZSBmbGV4
aWJsZS4KPgo+IEFja2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKUGF0Y2gg
bWVyZ2VkLCB0aGFua3MhCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
