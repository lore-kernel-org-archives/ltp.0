Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A191FE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 06:56:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 044C23C1D37
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 07:56:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BE403C1C38
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 07:56:26 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A1F0B606728
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 07:56:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736405783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CA1WJvDv36cG4bITJFQWwoW/4ZN1xNbmv5BmC8Uz5HQ=;
 b=LXma98df15UVlNESSiMXM3BR1q8JTnv/3moQ8yEdv6WltEXFNVAmV6VmW4sGpk3xYQ5hqY
 z5ojw0BFLOKtXF80NJqTc1ZsrLyA4VGH6Y8p8Fs/9qqqvGBfM5s/cA7wuuq2UrlDbwHq1B
 QE7qXr3jf9gjUfLiJkJTL0xTjAePLKI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-FvgPxnujPcyI59Qexhv-Yg-1; Thu, 09 Jan 2025 01:56:21 -0500
X-MC-Unique: FvgPxnujPcyI59Qexhv-Yg-1
X-Mimecast-MFC-AGG-ID: FvgPxnujPcyI59Qexhv-Yg
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa68b4b957fso55609066b.3
 for <ltp@lists.linux.it>; Wed, 08 Jan 2025 22:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736405780; x=1737010580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CA1WJvDv36cG4bITJFQWwoW/4ZN1xNbmv5BmC8Uz5HQ=;
 b=JflqU41VhNXhgLBTHfZZpJsEcKm2RNU6u88ghqkQpdaYgYI9EhEo8ZR7jlQ/9NnB1R
 mc1cQfWXVt+pzGl3utAulNZWHzoIcJ8tgcxtKd3locTfjG/ybEHRA/e0LHqqnaqE9Uc3
 Yrauqww9/xPGBR+kGoZyyhamL4rP/EqOGTN+7ED8ifH26oibDI+3OgDfQBJZ9wy/2aB+
 nh0R+6qGlWmLc/ozC+Pau1WPcEN/dN9Z3hk2bXMbTY/qxZXbGeQcHlbVr+uk0/2SteBT
 BxxTmYOeptaJ1nBJWu+Jm43oNVSBe1eKwM7A4OLiamp7GaRUiScuwMyqzY7zrDVRugk/
 4uwA==
X-Gm-Message-State: AOJu0Yx88Mfz5WvI0L666ix+UErT7JcMYWe14aYbiW0I1LvvKbk+bH6b
 Jr066yjTiEtCqIVqR6+RLHwZ9pZ0M/GkOeOgEuXZtrilwsgErbAA0/W31l28cA586wBfAxQBhik
 Vtzb10Us8fMMbWhLviHFJTyGVkHDuKl3YRnQ/s3F37xuECtCqS8DeJpuO0IDN/7RjzoQcIQVcSZ
 jHFlzZLbkwue9h8G0JNEf4I6Y=
X-Gm-Gg: ASbGnct8OVXWH+VvQ/p9/BJlIuqaTjMy3W1b1oEpVZ6QyBAORGlWQgc7Bvy5ixpIGzY
 gCX87qVFeF3yXBEYXoY3OrqH3LwRWVq2dkbmR0c4=
X-Received: by 2002:a17:907:948d:b0:a9a:9df:5580 with SMTP id
 a640c23a62f3a-ab2ab6fd625mr513096966b.19.1736405780504; 
 Wed, 08 Jan 2025 22:56:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7JYNtC5q7BWJfxMhks3S0cIE0gUF3xQfXnsgKuIcqXzLkHMVBs+kr0rdX7kA/BDSoy0sXFj+PrZB2YcY6mkE=
X-Received: by 2002:a17:907:948d:b0:a9a:9df:5580 with SMTP id
 a640c23a62f3a-ab2ab6fd625mr513095966b.19.1736405780124; Wed, 08 Jan 2025
 22:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20250109065129.169932-1-pvorel@suse.cz>
In-Reply-To: <20250109065129.169932-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 14:56:06 +0800
X-Gm-Features: AbW1kvZKqpl2cn_Ys1CwyIrpziD1ZA8vKV_EdVr8kmEp7wwnyIXhS-7rj3tnXrM
Message-ID: <CAEemH2fd6FyjcV2QtakRgDmGNhUt=h1Sfzm_eVwOwt-Hd+Sw+Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B-pDekYD-GNhSctireJ3JoxPyDB0asSfI3kyhsDYVWs_1736405781
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] fanotify22: Add 76486b104168 tag
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

T24gVGh1LCBKYW4gOSwgMjAyNSBhdCAyOjUx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBOZXcgdGFnIGZvciBjb21taXQgZnJvbSB2Ni4xMy1yYzEgd2hpY2ggZml4
ZXMgcHJvYmxlbSBmcm9tIHY2LjEyLXJjMS4KPgo+IENsb3NlczogaHR0cHM6Ly9naXRodWIuY29t
L2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvaXNzdWVzLzEyMDYKPiBTaWduZWQtb2ZmLWJ5OiBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0By
ZWRoYXQuY29tPgoKLS0tCj4gSGksCj4KPiBLZXJuZWwgNi4xMy1yYzYgaGFzIGJlZW4gcmVsZWFz
ZWQsIGl0IHNob3VsZCBiZSBzYWZlIHRvIGFkZCB0aGUgdGFnLgo+IFdlIGNhbiB3YWl0IHRpbGwg
Ni4xMyBmaW5hbCByZWxlYXNlLCBidXQgdGhpcyB0YWcgc2hvdWxkIGdldCBpbnRvCj4gdXBjb21p
bmcgTFRQIHJlbGVhc2UuCj4KCisxCgoKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMi5jIHwgMSArCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMi5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjIuYwo+IGluZGV4IDE5ZDQzN2I5NDUuLjFjNzIxMDEz
NjkgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5v
dGlmeTIyLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90
aWZ5MjIuYwo+IEBAIC0zMjUsNiArMzI1LDcgQEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0
ID0gewo+ICAgICAgICAgfSwKPiAgICAgICAgIC50YWdzID0gKGNvbnN0IHN0cnVjdCB0c3RfdGFn
W10pIHsKPiAgICAgICAgICAgICAgICAgeyJsaW51eC1naXQiLCAiMTI0ZTdjNjFkZWIyIn0sCj4g
KyAgICAgICAgICAgICAgIHsibGludXgtZ2l0IiwgIjc2NDg2YjEwNDE2OCJ9LAo+ICAgICAgICAg
ICAgICAgICB7fQo+ICAgICAgICAgfSwKPiAgICAgICAgIC5uZWVkc19jbWRzID0gKGNvbnN0IGNo
YXIgKltdKSB7Cj4gLS0KPiAyLjQ3LjEKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
