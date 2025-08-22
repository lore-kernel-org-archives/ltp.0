Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724C8CA0EFA
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 01:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755827020; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=eTvxAkG6cDX7yAZx+vZZZT06egtO7a4eF6mcQ6gKfe8=;
 b=SNNH0KYjSjXuQ9vjY/9EmQwisS6if/EjyeAmOqZuQreMuDF2qxOOA1hEGL/S3/VV9HkMy
 X6p9tSa8TTLPEtI7GOIu3unajghMA+QTR90KzB5vs7aMFFzioVLU14raiorMsM/Yrejg1sK
 JvNRHwM48W/wfgiZh6Wqy1CF7j8VTK8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA5693CCC03
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 03:43:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76A133C07BB
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 03:43:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED9FF1000254
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 03:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755826997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGnxftLlX7kUbUpVMut4J0PeWv40qMsLv4DftKhRyXE=;
 b=fVseooUsMxTNLXt/lsxrchYQj2ZAeIg0pl7eyKWIbMH4h8fTfZFi+q1rsGrgzLbRW4nQuy
 oEtNBVlz44/usvKlEPR3eRZx7MX7JupQWhjDcpIZlYYqeezkqeiBavUqag07Sz2bydTcJz
 LfQ8QRwPPquHp4peSFAKPKteIplaCg0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-YL6iJCrOPwi2AzfYiRJIfQ-1; Thu, 21 Aug 2025 21:43:14 -0400
X-MC-Unique: YL6iJCrOPwi2AzfYiRJIfQ-1
X-Mimecast-MFC-AGG-ID: YL6iJCrOPwi2AzfYiRJIfQ_1755826993
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-76e2e60221fso3375256b3a.0
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 18:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755826992; x=1756431792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nGnxftLlX7kUbUpVMut4J0PeWv40qMsLv4DftKhRyXE=;
 b=lIzcIZB7fdn4eATWpMHEd7bgpynh0M0tPGaJI8Oe1qMoslczV1iEPLObLkCN3f8yIp
 eTgruWphsJMmuvpIrA/0wHnrsG0tDNNZHNaXk7myDJwJxD9raLq9O/BwCcUReqhHfEsg
 NNbAY45SDYgvFZ19mid1ZoKIqYNXgx+BmZXkmoAhPVwabCp389oRXwou1wSZX5VPK2XU
 3N+mFW0JCY7s3YqgOiV4ciCvuOwFS57TBMd9Vffs1ODdTlHuzeHsZf55l9ATVitZ+4yP
 7IAJNcj5awa+lK+kGj8dyj4+tQ/U78p77gI8IVJUsGYDgjuMvUYuA0UIJAFx4UWsU+Wi
 EvTQ==
X-Gm-Message-State: AOJu0Yw7uG98sU0ie1gd9bJrYxX2+v8JC4gaRyT1+Rtvt/6dNYijPWUM
 HKiCT4WMlZLyWymo+8NGssjkzSxSct6L5Ls7i416iqAeXUk0xnWO5qA6TKVPuckANABrDTPGQC7
 GH4nFhxMVhm3g6MyR7wHOZikIUM5IfWdy3jKccpvCIZag7pYBJqEiXsOf26A5F9XoaIP+YePW5u
 96wt4Zc1oEYR/rjU9OM9sChbvVz8Y=
X-Gm-Gg: ASbGncu/h3fBsvIT0bihtHtN7dLq5c8gJP4HtQxsvjOgxnkp5iouGQIpyfaIdfRKYDQ
 WgZrBZ29QR9FnbLTQi5S9Tbzc/eSlMX1zEg3032v2yWksPGiVYYfJkbu0IT57N9daJkrW5eHPUQ
 8bYHV/Qn5LOYK/Em1KSdboeA==
X-Received: by 2002:a05:6a21:339a:b0:240:7ed:402d with SMTP id
 adf61e73a8af0-24340e1c3b3mr1714883637.31.1755826991639; 
 Thu, 21 Aug 2025 18:43:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0sURicmfdb+DJyuTy68IMxGwW7qQNcR3SwcD6X4NlpvHI9HDC1GLw1fS5Xej0KB3sCCMttWg16XDdpWcatHE=
X-Received: by 2002:a05:6a21:339a:b0:240:7ed:402d with SMTP id
 adf61e73a8af0-24340e1c3b3mr1714861637.31.1755826991195; Thu, 21 Aug 2025
 18:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250605142943.229010-1-wegao@suse.com>
 <20250610221435.1680891-1-wegao@suse.com>
 <CAEemH2ehxd7kpQa090hO2f_8jLCKY+pp5BHiZTafOgfWzxEBgw@mail.gmail.com>
In-Reply-To: <CAEemH2ehxd7kpQa090hO2f_8jLCKY+pp5BHiZTafOgfWzxEBgw@mail.gmail.com>
Date: Fri, 22 Aug 2025 09:42:58 +0800
X-Gm-Features: Ac12FXzqjZz9Q4fOROC_3T9UK46xiAYwonXCRNNE18qtYLScq18qqhRWeESEKpA
Message-ID: <CAEemH2e0-ESoLRPpPs_m5fJiZCkLvt78ZodEUPe6N5z4bGisNg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SzpTkWeiDWqVqTRBNh2lrdvlWQ3BdnDJOQ4JfQ3LUvc_1755826993
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_cgroup.c: Skip cases which testing cgroup
 v2 with CONFIG_RT_GROUP_SCHED=y
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: mkoutny@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMjIsIDIwMjUgYXQgOTozOOKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4KPgo+IE9uIFR1ZSwgSnVuIDEwLCAyMDI1IGF0IDY6MTXigK9QTSBXZWkg
R2FvIHZpYSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdD4KPiB3cm90ZToKPgo+PiBSVF9HUk9VUCBz
Y2hlZHVsaW5nIGlzIGNncm91cCB2MSBmZWF0dXJlIGFzIG9mIG5vdy4gU28gd2UgbmVlZCBza2lw
IHRlc3QKPj4gY2FzZXMKPj4gZm9yIGNncm91cCB2MiB3aXRoIENPTkZJR19SVF9HUk9VUF9TQ0hF
RD15Lgo+Pgo+PiBTa2lwIGNhc2VzIGxpc3Q6Cj4+IHNjaGVkX3JyX2dldF9pbnRlcnZhbDAxCj4+
IHNjaGVkX3JyX2dldF9pbnRlcnZhbDAyCj4+IHNjaGVkX3JyX2dldF9pbnRlcnZhbDAzCj4+IHNj
aGVkX3NldHBhcmFtMDIKPj4gc2NoZWRfZ2V0c2NoZWR1bGVyMDEKPj4KPj4gRml4ZXM6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy8xMjQ1Cj4+IFNpZ25l
ZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+PiAtLS0KPj4gIGluY2x1ZGUvdHN0
X2Nncm91cC5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKysKPj4gIGxp
Yi90c3RfY2dyb3VwLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTEg
KysrKysrKysrKysKPj4gIC4uLi9zY2hlZF9nZXRzY2hlZHVsZXIvc2NoZWRfZ2V0c2NoZWR1bGVy
MDEuYyAgICAgICAgIHwgIDIgKysKPj4gIC4uLi9zY2hlZF9ycl9nZXRfaW50ZXJ2YWwvc2NoZWRf
cnJfZ2V0X2ludGVydmFsMDEuYyAgIHwgIDIgKysKPj4gIC4uLi9zY2hlZF9ycl9nZXRfaW50ZXJ2
YWwvc2NoZWRfcnJfZ2V0X2ludGVydmFsMDIuYyAgIHwgIDIgKysKPj4gIC4uLi9zY2hlZF9ycl9n
ZXRfaW50ZXJ2YWwvc2NoZWRfcnJfZ2V0X2ludGVydmFsMDMuYyAgIHwgIDIgKysKPj4gIC4uLi9r
ZXJuZWwvc3lzY2FsbHMvc2NoZWRfc2V0cGFyYW0vc2NoZWRfc2V0cGFyYW0wMi5jIHwgIDIgKysK
Pj4gIDcgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS90c3RfY2dyb3VwLmggYi9pbmNsdWRlL3RzdF9jZ3JvdXAuaAo+PiBpbmRleCBkMmI1
MjI0YTAuLjBmMGY0NGVjMyAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS90c3RfY2dyb3VwLmgKPj4g
KysrIGIvaW5jbHVkZS90c3RfY2dyb3VwLmgKPj4gQEAgLTI1Niw0ICsyNTYsNiBAQCBpbnQgc2Fm
ZV9jZ19vY2N1cnNpbihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQKPj4gbGluZW5vLAo+Pgo+
PiAgaW50IHRzdF9jZ19tZW1vcnlfcmVjdXJzaXZlcHJvdChzdHJ1Y3QgdHN0X2NnX2dyb3VwICpj
Zyk7Cj4+Cj4+ICt2b2lkIHRzdF9jaGVja19ydF9ncm91cF9zY2hlZF9zdXBwb3J0KHZvaWQpOwo+
PiArCj4+ICAjZW5kaWYgLyogVFNUX0NHUk9VUF9IICovCj4+IGRpZmYgLS1naXQgYS9saWIvdHN0
X2Nncm91cC5jIGIvbGliL3RzdF9jZ3JvdXAuYwo+PiBpbmRleCAzNjYwMjQwMmQuLjRlYmRmNzAx
ZiAxMDA2NDQKPj4gLS0tIGEvbGliL3RzdF9jZ3JvdXAuYwo+PiArKysgYi9saWIvdHN0X2Nncm91
cC5jCj4+IEBAIC0xNiw2ICsxNiw3IEBACj4+ICAjaW5jbHVkZSAibGFwaS9mY250bC5oIgo+PiAg
I2luY2x1ZGUgImxhcGkvbW91bnQuaCIKPj4gICNpbmNsdWRlICJ0c3Rfc2FmZV9maWxlX2F0Lmgi
Cj4+ICsjaW5jbHVkZSAidHN0X2tjb25maWcuaCIKPj4KPj4gIHN0cnVjdCBjZ3JvdXBfcm9vdDsK
Pj4KPj4gQEAgLTE1MzEsMyArMTUzMiwxMyBAQCBpbnQgdHN0X2NnX21lbW9yeV9yZWN1cnNpdmVw
cm90KHN0cnVjdAo+PiB0c3RfY2dfZ3JvdXAgKmNnKQo+PiAgICAgICAgICAgICAgICAgcmV0dXJu
Cj4+IGNnLT5kaXJzX2J5X2N0cmxbMF0tPmRpcl9yb290LT5tZW1vcnlfcmVjdXJzaXZlcHJvdDsK
Pj4gICAgICAgICByZXR1cm4gMDsKPj4gIH0KPj4gKwo+PiArdm9pZCB0c3RfY2hlY2tfcnRfZ3Jv
dXBfc2NoZWRfc3VwcG9ydCh2b2lkKQo+PiArewo+PiArICAgICAgIHN0YXRpYyBjb25zdCBjaGFy
ICogY29uc3Qga2NvbmZbXSA9IHsiQ09ORklHX1JUX0dST1VQX1NDSEVEPXkiLAo+PiBOVUxMfTsK
Pj4gKwo+PiArICAgICAgIGlmICgoYWNjZXNzKCIvc3lzL2ZzL2Nncm91cC9jZ3JvdXAuY29udHJv
bGxlcnMiLCBGX09LKSA9PSAwKSAmJgo+PiAhdHN0X2tjb25maWdfY2hlY2soa2NvbmYpKSB7Cj4+
Cj4KPiBIZXJlIGlzIHdoYXQgd2UgYXNzdW1lIHRoZSBjZ3J1cCB2MiBkZWZhdWx0IG1vdW50IHBh
dGgsIGJ1dAo+IGJldHRlciB0byB1c2UgY2dyb3VwX3YyX21vdW50ZWQoKSBpbiBjYXNlIHNvbWUg
dGVzdCBlbnYgaXMgbm90Cj4gbW91bnQgY2dyb3VwIG9uIHRoZSBwYXRoLgo+Cj4gSSBtYWRlIHRo
ZSBiZWxvdyBjaGFuZ2UgYW5kIHB1c2hlZDoKPgo+IC0tLSBhL2xpYi90c3RfY2dyb3VwLmMKPiAr
KysgYi9saWIvdHN0X2Nncm91cC5jCj4gQEAgLTE1MzcsNyArMTUzNyw5IEBAIHZvaWQgdHN0X2No
ZWNrX3J0X2dyb3VwX3NjaGVkX3N1cHBvcnQodm9pZCkKPiAgewo+ICAgICAgICAgc3RhdGljIGNv
bnN0IGNoYXIgKiBjb25zdCBrY29uZltdID0geyJDT05GSUdfUlRfR1JPVVBfU0NIRUQ9eSIsCj4g
TlVMTH07Cj4KPiAtICAgICAgIGlmIChjZ3JvdXBfdjJfbW91bnRlZCgpICYmICF0c3Rfa2NvbmZp
Z19jaGVjayhrY29uZikpIHsKPiArICAgICAgIHRzdF9jZ19zY2FuKCk7Cj4gKwo+ICsgICAgICAg
aWYgKGNncm91cF92Ml9tb3VudGVkKCkgJiYgdHN0X2tjb25maWdfY2hlY2soa2NvbmYpKSB7Cj4g
ICAgICAgICAgICAgICAgIHRzdF9icmsoVENPTkYsICJDT05GSUdfUlRfR1JPVVBfU0NIRUQgbm90
IHN1cHBvcnQgb24KPiBjZ3JvdXB2MiIpOwo+ICAgICAgICAgfQo+CgpTb3JyeSwgSSBjb3BpZWQg
dGhlIHdyb25nIGNvbnRlbnQgZnJvbSBteSB0ZXN0IG1hY2hpbmUsCnRoZSBtZXJnZWQgcGF0Y2gg
aXMgYWN0dWFsbHkgbGlrZToKCmh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3Qv
bHRwL2NvbW1pdC8xYmRkZGUxMmYxZDdiOTZkNWM3YTIxNTc4NzczMzBiYmViOWIyNmQ5CgoKCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
