Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FE2C54798
	for <ltp@archiver.kernel.org>; Sat,  9 Mar 2024 08:09:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F4BA3CE955
	for <ltp@archiver.kernel.org>; Sat,  9 Mar 2024 09:09:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B99C23C196B
 for <ltp@lists.linux.it>; Sat,  9 Mar 2024 09:09:18 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 93783201172
 for <ltp@lists.linux.it>; Sat,  9 Mar 2024 09:09:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709971755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HaZ+HMi11jovd/usTawLZvSpoR0CmOwTQJuSKgxCSJk=;
 b=WZA4XLiJe2W7ZZ281uGvmiN8xuUw1dXxXTPSVyohk2bFh2IPcr3h3cahb5Sl02MrsqseQv
 hhDsz5M8Eub5E/B7MCwDpcQoANU+p7BzCkaisp2oMRWGiI1+vNxrX2rUIfMuSWAE4lAWeb
 ENZxWGMloOdQ+ZFu1atIui6e/sbUtlc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-HCTeFu6VPXuW6Ch-L4p9dA-1; Sat, 09 Mar 2024 03:09:13 -0500
X-MC-Unique: HCTeFu6VPXuW6Ch-L4p9dA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29976f92420so2247744a91.0
 for <ltp@lists.linux.it>; Sat, 09 Mar 2024 00:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709971753; x=1710576553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HaZ+HMi11jovd/usTawLZvSpoR0CmOwTQJuSKgxCSJk=;
 b=b6p83KYZX5HtD2eCNMgX1LSsv3DxhIgQU4HH3hXiDMrtz28TnxSCYEZfXKTmIkD6iP
 yQ6PCuTdesz8ivDeN3E5t7MfaUyHAe79vsmeHemKWvwRp2Y1fYU+OF2KFA4IB/UDPy4M
 IyZsQDaCQRbpNzsfpefmlc0rSPGaaOVPDpKWM3T6mDHONlEWskmfiSjQVZ0fTq8jPtcX
 KAK4NNBc1FDml/Zmc2rpOMrp0h/87Ix8vb9CUH3epTs+e/Ksd1XH+YG5kxjZjAaGkuVX
 OaAuiKB4HfVLowtb0W6Cb5vwWK07O4xli1O2eRf1ua4xGVguOeRRQVT3dHBG0unoclx7
 +oLg==
X-Gm-Message-State: AOJu0YyMhCJPqPHcXEERbLSoRXyUQcIp+RxWgTIa0oycslj67I0BYQnM
 9wYMHbt/8u1oNdcNuOXzESK2wpojvTDErJZpTqXXUtKZMbcJF6conb4tED76RzYWEhHixC8pKlH
 MgOMGXNgp2R+7ktN43yPgAJMl0YMPp/7fx3/AKSQn3SnNfl/sGtilY6TZC3Kk69vFHWfZOCVwY1
 Pnh89n7/fOqO+sz6fOYgHQJFo=
X-Received: by 2002:a17:90a:db58:b0:29b:c31:1fe1 with SMTP id
 u24-20020a17090adb5800b0029b0c311fe1mr2054463pjx.10.1709971752834; 
 Sat, 09 Mar 2024 00:09:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKdSftUP+e265QC5zho73+nu7pUDnr1tH3yp6K1MwbrschP8qHg62PqKzFeHv0XLK4mK53DYIgkKkjegvbN7g=
X-Received: by 2002:a17:90a:db58:b0:29b:c31:1fe1 with SMTP id
 u24-20020a17090adb5800b0029b0c311fe1mr2054449pjx.10.1709971752339; Sat, 09
 Mar 2024 00:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20240308045230.3106549-1-liwang@redhat.com> <Zes9RTFfzvKJsf4N@rei>
In-Reply-To: <Zes9RTFfzvKJsf4N@rei>
From: Li Wang <liwang@redhat.com>
Date: Sat, 9 Mar 2024 16:09:00 +0800
Message-ID: <CAEemH2eBz=0v28yED+O0nXt07+uQF9=R0snuY3YW-v5i5Gk71g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/3] kconfig: add funtion to parse /proc/cmdline
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

T24gU2F0LCBNYXIgOSwgMjAyNCBhdCA0OjQ24oCvQU0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ICsvKioKPiA+ICsgKiBNYWNybyB0byBpbml0aWFsaXpl
IGEgdHN0X2tjbWRsaW5lX3BhcmFtIHN0cnVjdHVyZSB3aXRoIGEgc3BlY2lmaWVkCj4gcGFyYW1l
dGVyCj4gPiArICogbmFtZSBhbmQgYW4gZW1wdHkgdmFsdWUuIFRoaXMgaXMgdXNlZnVsIGZvciBz
ZXR0aW5nIHVwIGFuIGFycmF5IG9mCj4gcGFyYW1ldGVyCj4gPiArICogc3RydWN0dXJlcyBiZWZv
cmUgcGFyc2luZyB0aGUgYWN0dWFsIGNvbW1hbmQtbGluZSBhcmd1bWVudHMuCj4gPiArICovCj4g
PiArI2RlZmluZSBUU1RfS0NNRExJTkVfSU5JVChwYXJhbmFtZSkgeyBcCj4gPiArICAgICAua2V5
ID0gcGFyYW5hbWUsIFwKPiA+ICsgICAgIC52YWx1ZSA9ICIiIFwKPiA+ICt9Cj4gPiArCj4gPiAr
LyogU3RydWN0dXJlIGZvciBzdG9yaW5nIGNvbW1hbmQtbGluZSBwYXJhbWV0ZXIga2V5IGFuZCBp
dHMKPiBjb3JyZXNwb25kaW5nIHZhbHVlICovCj4gPiArc3RydWN0IHRzdF9rY21kbGluZV9wYXJh
bSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICBeCj4gICAgICAgICAgICAgICAgICAgICAgICBt
YXliZSB2YXIgYXMgc2hvcnQgZm9yIHZhcmlhYmxlIHdvdWxkIGJlIGJldHRlcgo+ICAgICAgICAg
ICAgICAgICAgICAgICAgbmFtZQo+ID4gKyAgICAgY29uc3QgY2hhciAqa2V5Owo+ID4gKyAgICAg
Y2hhciB2YWx1ZVsxMjhdOwo+ID4gK307Cj4gPiArCj4gPiArLyoqCj4gPiArICogUGFyc2VzIGNv
bW1hbmQtbGluZSBwYXJhbWV0ZXJzIGZyb20gL3Byb2MvY21kbGluZSBhbmQgc3RvcmVzIHRoZW0g
aW4KPiBwYXJhbXMgYXJyYXkKPiA+ICsgKiBwYXJhbXM6IFRoZSBhcnJheSBvZiB0c3Rfa2NtZGxp
bmVfcGFyYW0gc3RydWN0dXJlcyB0byBiZSBmaWxsZWQgd2l0aAo+IHBhcnNlZCBrZXktdmFsdWUg
cGFpcnMKPiA+ICsgKiBwYXJhbXNfbGVuOiBUaGUgbGVuZ3RoIG9mIHRoZSBwYXJhbXMgYXJyYXks
IGluZGljYXRpbmcgaG93IG1hbnkKPiBwYXJhbWV0ZXJzIHRvIHBhcnNlCj4gPiArICovCj4gPiAr
dm9pZCB0c3Rfa2NtZGxpbmVfcGFyc2Uoc3RydWN0IHRzdF9rY21kbGluZV9wYXJhbSBwYXJhbXNb
XSwgc2l6ZV90Cj4gcGFyYW1zX2xlbik7Cj4gPiArCj4gPiAgI2VuZGlmICAgICAgIC8qIFRTVF9L
Q09ORklHX0hfXyAqLwo+ID4gZGlmZiAtLWdpdCBhL2xpYi90c3Rfa2NvbmZpZy5jIGIvbGliL3Rz
dF9rY29uZmlnLmMKPiA+IGluZGV4IDU5NWVhNGIwOS4uZjc5ZGVhNWM2IDEwMDY0NAo+ID4gLS0t
IGEvbGliL3RzdF9rY29uZmlnLmMKPiA+ICsrKyBiL2xpYi90c3Rfa2NvbmZpZy5jCj4gPiBAQCAt
NTY1LDMgKzU2NSw0NCBAQCBjaGFyIHRzdF9rY29uZmlnX2dldChjb25zdCBjaGFyICpjb25mbmFt
ZSkKPiA+Cj4gPiAgICAgICByZXR1cm4gdmFyLmNob2ljZTsKPiA+ICB9Cj4gPiArCj4gPiArdm9p
ZCB0c3Rfa2NtZGxpbmVfcGFyc2Uoc3RydWN0IHRzdF9rY21kbGluZV9wYXJhbSBwYXJhbXNbXSwg
c2l6ZV90Cj4gcGFyYW1zX2xlbikgewo+ID4gKyAgICAgRklMRSAqcHJvY19jbWRsaW5lOwo+ID4g
KyAgICAgY2hhciBjbWRsaW5lWzQwOTZdOwo+ID4gKyAgICAgY2hhciAqdG9rZW4sICprZXksICp2
YWx1ZTsKPiA+ICsKPiA+ICsgICAgIHByb2NfY21kbGluZSA9IGZvcGVuKCIvcHJvYy9jbWRsaW5l
IiwgInIiKTsKPiA+ICsgICAgIGlmIChwcm9jX2NtZGxpbmUgPT0gTlVMTCkKPiA+ICsgICAgICAg
ICAgICAgdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgIkZhaWxlZCB0byBvcGVuIC9wcm9jL2NtZGxp
bmUgZm9yCj4gcmVhZGluZyIpOwo+ID4gKwo+ID4gKyAgICAgaWYgKGZnZXRzKGNtZGxpbmUsIHNp
emVvZihjbWRsaW5lKSwgcHJvY19jbWRsaW5lKSA9PSBOVUxMKSB7Cj4gPiArICAgICAgICAgICAg
IGZjbG9zZShwcm9jX2NtZGxpbmUpOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICBpZiAoZmVvZihw
cm9jX2NtZGxpbmUpKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJF
bmQtb2YtRmlsZSByZWFjaGVkIG9uCj4gL3Byb2MvY21kbGluZSB3aXRob3V0IHJlYWRpbmcgYW55
IGRhdGEiKTsKPiA+ICsgICAgICAgICAgICAgZWxzZQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
IHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJGYWlsZWQgdG8gcmVhZCBmcm9tCj4gL3Byb2MvY21k
bGluZSIpOwo+ID4gKyAgICAgfQo+ID4gKyAgICAgZmNsb3NlKHByb2NfY21kbGluZSk7Cj4KPiBV
ZmYsIHRoaXMgaXMgdWdseS4gV2UgaGF2ZSBGSUxFIGFuZCB0aGVuIHVzZSBpdCBhcyBpZiB3ZSBo
YWQgZmQgYW5kIHJlYWQKPiBpdCBhcyBhIHdob2xlLiBUaGUgd2hvbGUgcG9pbnQgb2YgRklMRSBp
cyB0aGF0IGdsaWJjIG1hbmFnZXMgdGhlIGJ1ZmZlcnMKPiBhbmQgcmVhZHMgc28gdGhhdCB3ZSBj
YW4gYWNjZXNzIGl0IGNoYXJhY3RlciBieSBjaGFyYWN0ZXIgd2l0aG91dCBiZWluZwo+IHNsb3cu
IEl0IHdvdWxkIGJlIHdheSBjbGVhbmVyIGlmIHdlIGp1c3QgcmVhZCB0aGUgZmlsZSBjaGFyYWN0
ZXIgYnkKPiBjaGFyYWN0ZXIgYnVpbGRpbmcgdXAgdGhlIGtleSBhbmQgdmFsdWUgd2hpbGUgd2Ug
ZG8gdGhhdC4KPgoKSW5kZWVkLCB0aGlzIGlzIG11Y2ggYmV0dGVyIHRoYW4gbXkgd2F5LiBUaGFu
a3MhCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
