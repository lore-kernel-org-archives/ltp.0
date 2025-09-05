Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BD3CA1013
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757073063; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=n0gYAs10iIP7La2yRwME6P8DjEDcUnhByXdwOfZrdyo=;
 b=VKdaYjp6gazCyXuxOzHiIyVm47uUijugGeDP47A5DnaG2v86hT+AFg1VTl7HQBkEzWm75
 8M36pMdBWHIqaBCLTWbhrinjyMKgVfcl1KjhbQxCfqymN5rfDqUBZdMbifOw5PzaY+kqDJN
 nLHik13mfEazBCMnCVn0BWmX/z8P/Gc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B39E83CD4EC
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 13:51:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CA973CD4AB
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 13:50:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 33587600196
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 13:50:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757073040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W2mE1HK19pZmqkADHTnQYb1cWjzEYJEcsrIoewT7IMw=;
 b=Z87jXJZii0C7/3VWeezGDKceF54jGc4WqqxGSRv0/ea2s7k6FiQPGlOs9lEyh+30y9fR5+
 cPXj6wPCUUTKLdx+Dr+A05WyLk6J+8K/UOrCOhOhw280Cd5rdhQciq2BL5P6CAgM8TZZma
 Rr9CNleCieRaZzvIrS8teNVfR2IoVDA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-BSEawxmrOl-gxfUMB2GlSQ-1; Fri, 05 Sep 2025 07:50:38 -0400
X-MC-Unique: BSEawxmrOl-gxfUMB2GlSQ-1
X-Mimecast-MFC-AGG-ID: BSEawxmrOl-gxfUMB2GlSQ_1757073037
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24e04a4f706so5454115ad.2
 for <ltp@lists.linux.it>; Fri, 05 Sep 2025 04:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073037; x=1757677837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W2mE1HK19pZmqkADHTnQYb1cWjzEYJEcsrIoewT7IMw=;
 b=cdLSxw/+eJhJ0maw37u2vsTlPBzcz1YnsBMfvM4rl2wWCf9BVGFafn1YjmTrULqKJx
 Oh4W2Yyvx9B1Z45b40VCQPtfy6pQLNJnZdAFeQ/R7L9NFFw3IieXNJGJ9h6HpkzuwJ2A
 p/vNVDKM2paOKQHDNB5NLkgjt8+SZOnLCojBGfDWrAd3Idh+65JSGT+F7LpQg8OeCeKJ
 e+Jm1HHx66CROt9aG8pKMJEv5DZf1oxPW/O/Rd4n95ZgqyawNXlgHk+OBOgXjbSmM4eS
 v9TgRvlR3MQVvtP6E6uTDyWYHQbV1KmcK+hSKT5eWJR7Ihj2G0QhumKQo2aC8fEEuWrK
 LZcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/4B/5gZdhNGsgMqm/UOJDvxcNP0mpowDkEkVpT0JLvnuza+SRFfCLTQfrUudaeOXEEKo=@lists.linux.it
X-Gm-Message-State: AOJu0YxpgizGdWAG6LjbHTx01c1KBX8SxbxldRPlM6ZG7N4WvhDxuj6i
 1Ltn51yh+azVf1SFz+OoJPfLnnFhzKIlqdmrtlj4KuuL7BJK7BHT/7eOAvGy5M2frKApw4S1xo4
 ewpPh+AhJnRvkUbNN2BrHCl7J3O1pf4HQbVz3nirDgHbtrbZmQAe+mC0aonYSVLDQUNKXx3pCSw
 NcjAld06nqGudpy5N1JU0nnN30Tlw=
X-Gm-Gg: ASbGnctZU0FPU3YoLf/LDAURsBpOqBHEnwfyoXGCREehK9QKttYBFw8iW34yl5OyMb8
 2i3Xdmg4tnPHFX6C2h0RvFWKc8EuwA93fjmc276bQ3iKtbN5uOMPhevj+vbq+eCQ0eKtMrEFY2A
 /K1bZmoru3kba/XVXbpdebtA==
X-Received: by 2002:a17:902:ea07:b0:24a:def1:175b with SMTP id
 d9443c01a7336-24adef11943mr236847775ad.54.1757073037319; 
 Fri, 05 Sep 2025 04:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv6OTPW7frGt3bxrLe/teoTrsNoljuNHGjYfaj4RnrDe15N/T1DEumstt98vz37fc+dtvvxaQeMCdaFtVX/48=
X-Received: by 2002:a17:902:ea07:b0:24a:def1:175b with SMTP id
 d9443c01a7336-24adef11943mr236847365ad.54.1757073036832; Fri, 05 Sep 2025
 04:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
 <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
 <aLqq9o9Dkbhr957V@yuki.lan>
In-Reply-To: <aLqq9o9Dkbhr957V@yuki.lan>
Date: Fri, 5 Sep 2025 19:50:22 +0800
X-Gm-Features: Ac12FXy7adRj_ISH13b91gPtXi5ZHx34xeqJHl_JDcHvlR-_g5YUWsNAMDbTH1E
Message-ID: <CAEemH2cRQVq4N-SdRTFEuUzyUbqfCVg_mpQ58t1BeaNSO9NuvQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r0phO1w_EFTwR-927jKkBIznlMAOiqgMWjSrLN2uau4_1757073037
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBTZXAgNSwgMjAyNSBhdCA1OjE44oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IENoZWNraW5nIHRoZSBjb25maWd1cmF0aW9ucyBvZiB0
aGUgc3RvY2sga2VybmVsIGFuZCB0aGUgcmVhbC10aW1lCj4gPiBrZXJuZWwsIHRoZSBzdG9jayBr
ZXJuZWwgdXNlcyAiQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZPXksIgo+ID4gd2hpY2ggb25seSBw
cm92aWRlcyB2b2x1bnRhcnkgcHJlZW1wdGlvbi4KPiA+Cj4gPiBUaGlzIHByZWVtcHRpb24gbW9k
ZWwgaXMgZGVzaWduZWQgdG8gc3RyaWtlIGEgYmFsYW5jZSBiZXR3ZWVuIHRocm91Z2hwdXQKPiA+
IGFuZCBsYXRlbmN5LiBJdCBvbmx5IGFsbG93cyB0aGUga2VybmVsIHRvIGJlIHByZWVtcHRlZCBh
dCBzcGVjaWZpYywgd2VsbAo+ID4gZGVmaW5lZAo+ID4gInNhZmUgcG9pbnRzLCIgcG90ZW50aWFs
bHkgcmVzdWx0aW5nIGluIGxvbmcsIHVuYm91bmRlZCBsYXRlbmNpZXMuCj4gPgo+ID4gSG93ZXZl
ciwgdGhlIHNjaGVkX2Zvb3RiYWxsIHRlc3Qgd2FzIG1vc3QgbGlrZWx5IGRlc2lnbmVkIHRvIG1l
YXN1cmUgb3IKPiA+IHN0cmVzcy10ZXN0IHRoZSBkZXRlcm1pbmlzdGljLCBsb3ctbGF0ZW5jeSBz
Y2hlZHVsaW5nIGJlaGF2aW9yIHRoYXQgaXMKPiA+IGNoYXJhY3RlcmlzdGljIG9mIHJlYWwtdGlt
ZSAoUlQpIGtlcm5lbC4KPiA+Cj4gPiBTbywgSSB0ZW5kIHRvIGJlbGlldmUgdGhlIHRlc3QncyBm
YWlsdXJlIG9uIHRoZSBzdG9jayBrZXJuZWwgaXMKPiBhY2NlcHRhYmxlLgo+Cj4gSSBzdGlsbCBm
aW5kIGl0IGEgYml0IHVuZXhwZWN0ZWQgdGhvdWdoLiBUaGUgcHJlZXB0aW9uIG1vZGVscyBhcHBs
eSBvbmx5Cj4gdG8ga2VybmVsIGNvZGUuIFRoZSB1c2VyIHNwYWNlIGNvZGUgY2FuIGJlIHN0aWwg
cHJlZW1wdGVkIGF0IGFueSBwb2ludCwKPiBzbyB0aGUgb2ZmZW5zZSB0aHJlYWRzIHNob3VsZCBi
ZSBwcmVlbXB0ZWQgYW5kIHJlcGxhY2VkIGJ5IGhpZ2ggcHJpb3JpdHkKPiB0YXNrcyBhbmQgbmV2
ZXIgZXhlY3V0ZWQgYWdhaW4gc2luY2Ugd2UgZG8gbm90IGNhbGwgdG8gdGhlIGtlcm5lbCB0aGVy
ZQo+IGF0IGFsbCwgd2UganVzdCBydW4gYSBsb29wIHRoYXQgaW5jcmVtZW50cyBhbiBpbnRlZ2Vy
IHRoZXJlLiBJIGd1ZXNzCj4gdGhhdCBvbmUgcG9zc2liaWxpdHkgaXMgdGhhdCB3ZSBzYXR1cmF0
ZSB0aGUgbWFjaGluZSB3aXRoIHJlYWwtdGltZQo+IHRhc2tzIHRvIHRoZSBleHRlbmQgdGhhdCBz
Y2hlZHVsbGVyIGNvZGUgaW4ga2VybmVsIGRvZXMgbm90IGdldCB0bwo+IGRpc3RyaWJ1dGUgdGhl
IHByb2Nlc3Nlcy4gSWYgdGhhdCBpcyBhIHByb2JsZW0gd2UgbmVlZCB0byBnaXZlIGtlcm5lbAo+
IGNoYW5jZSB0byBzaHVmZmxlIHRoZSBwcm9jZXNzZXMgd2hlbiB3ZSB3YWl0IGZvciB0aGUga2lj
a29mZiBmbGFnLgo+Cj4gRG9lcyB0aGluZ3Mgc3RhcnQgdG8gd29yayBpZiB3ZSBjaGFuZ2UgdGhl
IGxvb3BzIHRoYXQgd2FpdCBmb3IgdGhlIGZpbmFsCj4ga2lja29mZiB0bzoKPgo+ICAgICAgICB3
aGlsZSAoIXRzdF9hdG9taWNfbG9hZCgma2lja29mZl9mbGFnKSkKPiAgICAgICAgICAgICAgICBz
Y2hlZF95aWVsZCgpOwo+CgpUaGlzIGhhcyBpbXByb3ZlZCBzb21ldGhpbmcsIGJ1dCBzdGlsbCBv
YnNlcnZlcyBzcG9yYWRpYyBmYWlsIG9uIFJIRUwgc3RvY2sKa2VybmVsLgpIb3dldmVyLCBib3Ro
IHRoZSBSSEVMIFJULWtlcm5lbCBhbmQgdGhlIG1haW5saW5lIHY2LjE3LXJjNCBzdG9jayBrZXJu
ZWwKcGFzcy4KCkJlbG93IGlzIG15IGNvbXBsZXRlIHRlc3QgcGF0Y2gsIGNhbiB5b3UgZ3V5cyB0
cnkgaXQgb24gU1VTRSBzdG9jayBrZXJuZWw/CgotLS0gYS90ZXN0Y2FzZXMvcmVhbHRpbWUvZnVu
Yy9zY2hlZF9mb290YmFsbC9zY2hlZF9mb290YmFsbC5jCisrKyBiL3Rlc3RjYXNlcy9yZWFsdGlt
ZS9mdW5jL3NjaGVkX2Zvb3RiYWxsL3NjaGVkX2Zvb3RiYWxsLmMKQEAgLTQ0LDYgKzQ0LDcgQEAK
IHN0YXRpYyB0c3RfYXRvbWljX3QgdGhlX2JhbGw7CiBzdGF0aWMgaW50IHBsYXllcnNfcGVyX3Rl
YW0gPSAwOwogc3RhdGljIGludCBnYW1lX2xlbmd0aCA9IERFRl9HQU1FX0xFTkdUSDsKK3N0YXRp
YyB0c3RfYXRvbWljX3Qga2lja29mZl9mbGFnOwogc3RhdGljIHRzdF9hdG9taWNfdCBnYW1lX292
ZXI7Cgogc3RhdGljIGNoYXIgKnN0cl9nYW1lX2xlbmd0aDsKQEAgLTU1LDYgKzU2LDkgQEAgdm9p
ZCAqdGhyZWFkX2Zhbih2b2lkICphcmcgTFRQX0FUVFJJQlVURV9VTlVTRUQpCiB7CiAgICAgICAg
cHJjdGwoUFJfU0VUX05BTUUsICJjcmF6eV9mYW4iLCAwLCAwLCAwKTsKICAgICAgICBwdGhyZWFk
X2JhcnJpZXJfd2FpdCgmc3RhcnRfYmFycmllcik7CisgICAgICAgd2hpbGUgKCF0c3RfYXRvbWlj
X2xvYWQoJmtpY2tvZmZfZmxhZykpCisgICAgICAgICAgICAgICBzY2hlZF95aWVsZCgpOworCiAg
ICAgICAgLypvY2Nhc2lvbmFsbHkgd2FrZSB1cCBhbmQgcnVuIGFjcm9zcyB0aGUgZmllbGQgKi8K
ICAgICAgICB3aGlsZSAoIXRzdF9hdG9taWNfbG9hZCgmZ2FtZV9vdmVyKSkgewogICAgICAgICAg
ICAgICAgc3RydWN0IHRpbWVzcGVjIHN0YXJ0LCBzdG9wOwpAQCAtODAsNiArODQsOSBAQCB2b2lk
ICp0aHJlYWRfZGVmZW5zZSh2b2lkICphcmcgTFRQX0FUVFJJQlVURV9VTlVTRUQpCiB7CiAgICAg
ICAgcHJjdGwoUFJfU0VUX05BTUUsICJkZWZlbnNlIiwgMCwgMCwgMCk7CiAgICAgICAgcHRocmVh
ZF9iYXJyaWVyX3dhaXQoJnN0YXJ0X2JhcnJpZXIpOworICAgICAgIHdoaWxlICghdHN0X2F0b21p
Y19sb2FkKCZraWNrb2ZmX2ZsYWcpKQorICAgICAgICAgICAgICAgc2NoZWRfeWllbGQoKTsKKwog
ICAgICAgIC8qa2VlcCB0aGUgYmFsbCBmcm9tIGJlaW5nIG1vdmVkICovCiAgICAgICAgd2hpbGUg
KCF0c3RfYXRvbWljX2xvYWQoJmdhbWVfb3ZlcikpIHsKICAgICAgICB9CkBAIC05Miw2ICs5OSw5
IEBAIHZvaWQgKnRocmVhZF9vZmZlbnNlKHZvaWQgKmFyZyBMVFBfQVRUUklCVVRFX1VOVVNFRCkK
IHsKICAgICAgICBwcmN0bChQUl9TRVRfTkFNRSwgIm9mZmVuc2UiLCAwLCAwLCAwKTsKICAgICAg
ICBwdGhyZWFkX2JhcnJpZXJfd2FpdCgmc3RhcnRfYmFycmllcik7CisgICAgICAgd2hpbGUgKCF0
c3RfYXRvbWljX2xvYWQoJmtpY2tvZmZfZmxhZykpCisgICAgICAgICAgICAgICBzY2hlZF95aWVs
ZCgpOworCiAgICAgICAgd2hpbGUgKCF0c3RfYXRvbWljX2xvYWQoJmdhbWVfb3ZlcikpIHsKICAg
ICAgICAgICAgICAgIHRzdF9hdG9taWNfYWRkX3JldHVybigxLCAmdGhlX2JhbGwpOyAvKiBtb3Zl
IHRoZSBiYWxsIGFoZWFkCm9uZSB5YXJkICovCiAgICAgICAgfQpAQCAtMTE1LDkgKzEyNSwxNSBA
QCB2b2lkIHJlZmVyZWUoaW50IGdhbWVfbGVuZ3RoKQogICAgICAgIG5vdyA9IHN0YXJ0OwoKICAg
ICAgICAvKiBTdGFydCB0aGUgZ2FtZSEgKi8KLSAgICAgICB0c3RfYXRvbWljX3N0b3JlKDAsICZ0
aGVfYmFsbCk7Ci0gICAgICAgcHRocmVhZF9iYXJyaWVyX3dhaXQoJnN0YXJ0X2JhcnJpZXIpOwog
ICAgICAgIGF0cmFjZV9tYXJrZXJfd3JpdGUoInNjaGVkX2Zvb3RiYWxsIiwgIkdhbWVfc3RhcnRl
ZCEiKTsKKyAgICAgICBwdGhyZWFkX2JhcnJpZXJfd2FpdCgmc3RhcnRfYmFycmllcik7CisgICAg
ICAgdHN0X2F0b21pY19zdG9yZSgwLCAmdGhlX2JhbGwpOworICAgICAgIHRzdF9hdG9taWNfc3Rv
cmUoMSwgJmtpY2tvZmZfZmxhZyk7CisKKyAgICAgICBpZiAodHN0X2NoZWNrX3ByZWVtcHRfcnQo
KSkKKyAgICAgICAgICAgICAgIHVzbGVlcCgyMDAwMCk7CisgICAgICAgZWxzZQorICAgICAgICAg
ICAgICAgdXNsZWVwKDIwMDAwMDApOwoKICAgICAgICAvKiBXYXRjaCB0aGUgZ2FtZSAqLwogICAg
ICAgIHdoaWxlICgobm93LnR2X3NlYyAtIHN0YXJ0LnR2X3NlYykgPCBnYW1lX2xlbmd0aCkgewpA
QCAtMTI1LDE0ICsxNDEsMTQgQEAgdm9pZCByZWZlcmVlKGludCBnYW1lX2xlbmd0aCkKICAgICAg
ICAgICAgICAgIGdldHRpbWVvZmRheSgmbm93LCBOVUxMKTsKICAgICAgICB9CgotICAgICAgIC8q
IFN0b3AgdGhlIGdhbWUhICovCi0gICAgICAgdHN0X2F0b21pY19zdG9yZSgxLCAmZ2FtZV9vdmVy
KTsKLSAgICAgICBhdHJhY2VfbWFya2VyX3dyaXRlKCJzY2hlZF9mb290YmFsbCIsICJHYW1lX092
ZXIhIik7Ci0KICAgICAgICAvKiBCbG93IHRoZSB3aGlzdGxlICovCiAgICAgICAgZmluYWxfYmFs
bCA9IHRzdF9hdG9taWNfbG9hZCgmdGhlX2JhbGwpOwogICAgICAgIHRzdF9yZXMoVElORk8sICJG
aW5hbCBiYWxsIHBvc2l0aW9uOiAlZCIsIGZpbmFsX2JhbGwpOwoKKyAgICAgICAvKiBTdG9wIHRo
ZSBnYW1lISAqLworICAgICAgIHRzdF9hdG9taWNfc3RvcmUoMSwgJmdhbWVfb3Zlcik7CisgICAg
ICAgYXRyYWNlX21hcmtlcl93cml0ZSgic2NoZWRfZm9vdGJhbGwiLCAiR2FtZV9PdmVyISIpOwor
CiAgICAgICAgVFNUX0VYUF9FWFBSKGZpbmFsX2JhbGwgPT0gMCk7CiB9CgpAQCAtMTU0LDYgKzE3
MCw3IEBAIHN0YXRpYyB2b2lkIGRvX3Rlc3Qodm9pZCkKICAgICAgICAvKiBXZSdyZSB0aGUgcmVm
LCBzbyBzZXQgb3VyIHByaW9yaXR5IHJpZ2h0ICovCiAgICAgICAgcGFyYW0uc2NoZWRfcHJpb3Jp
dHkgPSBzY2hlZF9nZXRfcHJpb3JpdHlfbWluKFNDSEVEX0ZJRk8pICsgODA7CiAgICAgICAgc2No
ZWRfc2V0c2NoZWR1bGVyKDAsIFNDSEVEX0ZJRk8sICZwYXJhbSk7CisgICAgICAgdHN0X2F0b21p
Y19zdG9yZSgwLCAma2lja29mZl9mbGFnKTsKCiAgICAgICAgLyoKICAgICAgICAgKiBTdGFydCB0
aGUgb2ZmZW5zZQoKCj4gVGhpcyBzaG91bGQgdHJpZ2dlciB0aGUgc2NoZWR1bGxlciBjb2RlIHRv
IGJlIGV4ZWN1dGVkIHNvIHRoYXQgaXQgaGFzCj4gY2hhbmNlIHRvIGRpc3RyaWJ1dGUgdGhlIHBy
b2Nlc3NlcyBhcm91bmQuCj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+
Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
