Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F216C2D0CD
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747830943; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=K6fY3sSHyvdUfKoHyhYxIDvQxnhrxDF7ErMwnjbJ4B4=;
 b=iC7Em0933v8OYLgvm9XWZGLa65F9qSRzYGel0o3q5M24tx5/wXmVBxf5KoQb0uPkeE1Gi
 XMDRx8tIqVwwO/QAtPdNoGVxov3ErSOUbb9YkulGYyPfnbPuuZmunuJI78PCAwdh2WF5fVr
 4Ju61bSy+xQ5E2ZqBpVGpmmyaW3VBXY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC6333CC7E5
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 14:35:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C8DC3CC76F
 for <ltp@lists.linux.it>; Wed, 21 May 2025 14:35:21 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E2E9A1000AF1
 for <ltp@lists.linux.it>; Wed, 21 May 2025 14:35:20 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso67539355e9.0
 for <ltp@lists.linux.it>; Wed, 21 May 2025 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747830920; x=1748435720; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4l9Yzgve/a4kU9vb85m13v90omvt3uXEVi/yp4asyCI=;
 b=FJ/Vlxl2iAdTu3jjUSI9EFoMeqhm6e1ZrPWYiX7YKuPKZOPViBYqxXhCtfHy4abGWt
 uJCQh8HYV/oMgLnzCo3587nOnDz6vcsb12Os/yTXD8w45GJaEYRwt0bLv+YtbwXHVPwx
 2PVCjS4puC3ukL/uw/RB+BTuD4DkyEpuwVH1OMUIkRJ0LbzovCAhTQHSySmvBQMHZbiz
 p9uBtUiUTXVC/9frzNwVJODaBUuyM3+RFG9YkOJU4bEYsottibeDzIDeC2AmDVfNL6x4
 yNpyM4/0aA9secFi8Yg8E37L8414bD/D/i/YB3zjv+r6wapiXrKSoaSI7JGSAInb3rJ+
 CMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747830920; x=1748435720;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4l9Yzgve/a4kU9vb85m13v90omvt3uXEVi/yp4asyCI=;
 b=i5fyi8JOoWfa+VDXXSt9cbQwHSwC03lwT0xrSM3w4iYdbJM8H0Wjgc1TfNvMnQRKhH
 Z/wYg/rfiyi5aqtyxWOG61VZXYiM2wZhMqg0w7ZJt6DUnmPW8LkyqLmHHMAHPRZBMGCN
 AlPh4SrtQC+wOmkUocr/qjKGA3KWKU+vuEAs8Nz+lh5853bzRiuE4uQu9VX5XnEBnyZv
 OsPn7RjsmOn5tL/Hgu267MBIieHxF03jBFiy4ed0D5ZmwqtC8GXfybGwsAs722rgZ+Lg
 Pfd+sZ9Kh66Nc7wYDoISdg2K51fFcbaKC+3iSy9LFdtSIAN157fg1QZj3CgJgIG3f8rZ
 VeAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgEix0F5bjcgfID5cpZVCnFxBYIL3YH2MDz9o3Oth2m3qcWPSGzSUsl3NEIC4mf1qXa9U=@lists.linux.it
X-Gm-Message-State: AOJu0YxvGl4aA3nAqfxXew33A0WQlEKMlgjmnSz9TabuEZUMaJnfPRZg
 7xtub6UB7/NapST0v2K1q+egdggC4KsqlQRgpfkLe9/ilwSolXWc3jgA9kjdhO4asQw=
X-Gm-Gg: ASbGncu7DP7ADHD+h2BWJGwfEESj3a4tmd5tdqRTWcg2w5jhd1AzNDktvgBB/Xae3os
 IBmtuEcsITAesUYSDGLMigD2CxO39IdDRqS48Q79PRUHSyF12Slz003UkXmHEvrRgxm8dNrFgkU
 fGcLQWdxVfQO4q0NWMnvphkWyTt0LNGBTuBKvsz+qPeM9W8Ah9Qc2OfwC6ZDuOrz+gpxJSTlKfJ
 lFbwX3rcLw5tzzox7jm8HvI5G6dfOUn01lQUhWJ13p/7y1ORYOT/1dh63ZMkYE45vQ6i7P0RTeo
 djseB8FQ+4MSdeqEgVbWv6MY1ccjxhzvfrmQihtaM5uA/5U29NQI51HrOlskBs+/ZYDXHajF0A9
 bB7apDWwKi8RC1Pz4yI+D8il8ijZv7zY6PgbonDw+dNQyfluEUaUAReEhhuD3JtVu30XOouEfOv
 nmoZIbfl02WKk9Vg==
X-Google-Smtp-Source: AGHT+IGE7w2RyAp2gTkSBlZ0JVvMdVI6daCLCFDmLuuInto/CzZXAU2Vh5U5O0kWUe7Vqum2rbTyXw==
X-Received: by 2002:a05:600c:5008:b0:43c:ef55:f1e8 with SMTP id
 5b1f17b1804b1-442fd622ce5mr213745315e9.13.1747830920246; 
 Wed, 21 May 2025 05:35:20 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f16:9a00:bba9:aeb9:310b:cc0d?
 (p200300ef2f169a00bba9aeb9310bcc0d.dip0.t-ipconnect.de.
 [2003:ef:2f16:9a00:bba9:aeb9:310b:cc0d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f381420fsm66950785e9.32.2025.05.21.05.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 05:35:19 -0700 (PDT)
Message-ID: <975f1d41-3185-4c96-8833-e23642a8014c@suse.com>
Date: Wed, 21 May 2025 14:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250521-fixes-modify_ldt-v1-1-1fe46dfd7b89@suse.com>
Content-Language: en-US
In-Reply-To: <20250521-fixes-modify_ldt-v1-1-1fe46dfd7b89@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ldt.h: Fix typo in modify_ldt()
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgp0aGFua3MgZm9yIGZpeGluZyBpdC4gQE1hcnRpbiBmZWVsIGZyZWUgdG8gbWVyZ2UgaWYg
eW91IHRoaW5rIGl0J3MgZmluZS4KCkFja2VkLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEu
Y2VydmVzYXRvQHN1c2UuY29tPgoKT24gNS8yMS8yNSAxMzo0MSwgUmljYXJkbyBCLiBNYXJsacOo
cmUgdmlhIGx0cCB3cm90ZToKPiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2Uu
Y29tPgo+Cj4gRml4ZXM6IDVkOGNiNWEzZWYzNyAoImxkdC5oOiBBZGQgd29ya2Fyb3VuZCBmb3Ig
eDg2XzY0IikKPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2Uu
Y29tPgo+IC0tLQo+ICAgaW5jbHVkZS9sYXBpL2xkdC5oIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9sYXBpL2xkdC5oIGIvaW5jbHVkZS9sYXBpL2xkdC5oCj4gaW5kZXggMTczMzIxZGQ5YWMzNGJh
ODdlZmYwZWVlOTYwNjM1ZjMwZDg3ODk5MS4uMzMxZjI1YjQ0NGE0OGM0YzdmMTgzM2MzNzZmYjY5
NDA0MDI5ODQ2YyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xhcGkvbGR0LmgKPiArKysgYi9pbmNs
dWRlL2xhcGkvbGR0LmgKPiBAQCAtNDYsNyArNDYsNyBAQCBzdGF0aWMgaW5saW5lIGludCBtb2Rp
ZnlfbGR0KGludCBmdW5jLCBjb25zdCBzdHJ1Y3QgdXNlcl9kZXNjICpwdHIsCj4gICAJaWYgKHJ2
YWwgPiAwICYmIChpbnQpcnZhbCA8IDApIHsKPiAgIAkJdHN0X3JlcyhUSU5GTywKPiAgIAkJCSJX
QVJOSU5HOiBMaWJjIG1pc2hhbmRsZWQgbW9kaWZ5X2xkdCgpIHJldHVybiB2YWx1ZSIpOwo+IC0J
CWVycm5vID0gLShpbnQpZXJybm87Cj4gKwkJZXJybm8gPSAtKGludClydmFsOwo+ICAgCQlydmFs
ID0gLTE7Cj4gICAJfQo+ICAgI2VuZGlmIC8qIF9feDg2XzY0X18gKi8KPgo+IC0tLQo+IGJhc2Ut
Y29tbWl0OiA1ZDhjYjVhM2VmMzc0OWViMjZlZTIyZDk2Yzk2NTRiZmRlNDMwMzBmCj4gY2hhbmdl
LWlkOiAyMDI1MDUyMS1maXhlcy1tb2RpZnlfbGR0LTllYjk5YWIxNzFlZAo+Cj4gQmVzdCByZWdh
cmRzLAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
