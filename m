Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B92C54E5D
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 06:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D50A23CE6C6
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 07:19:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0C1A3CC8BF
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 07:19:14 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5AD696008D6
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 07:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710742751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FoJV+NP6eNiWmtdv61SQVzelRkKPQx3Upo6Uo4l906k=;
 b=M9v4wldg4XiQEe4OtCIQ+ssVk7JJ4n7DJzpzdLjUhf4iBr1RMsbjwp/3AS6GwjzKyXOZhg
 UvjJ17o4KoQQMhVYag5KByISdWLYywmbwbF8f6TOWYNAMKTP+EXEQ2zPEszfT6k0XWFSt6
 TCeUyxACwTRqGwTO+hPq4DHwv+QejiY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-1lPRS6YvOl2YF9BlA6DyNg-1; Mon, 18 Mar 2024 02:19:09 -0400
X-MC-Unique: 1lPRS6YvOl2YF9BlA6DyNg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29bd6f4329cso3532432a91.2
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 23:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710742747; x=1711347547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FoJV+NP6eNiWmtdv61SQVzelRkKPQx3Upo6Uo4l906k=;
 b=AaG8lngwPLtYyDuIBlNqFG6ViTz9+wxzEgSPf3qnWfctXOdwiVWbDgcxP4njTXaHKU
 J4B0vqkkDAzYD4k1B9NCIJ2XD+1Itm0WZor7EQ6BbAjSoVxFNydLXvRXeyoDRSxSaXeP
 cD302T4yI8as2ZX6b/xVDKsAGA2pIDijo4Jpcwo/3sLhA72l6OGHoBIcJGtncvVuegBD
 Oh6USQNyIHypUc+lOhAKI2XZZp6pd73OhlvozqoUZe3Fsw3ZDaJv81WNjHwBZNE45G6L
 3Cq3RdLtvDp0w2dnSGTaSO2mJz/yqfSIiCpnfKpmn+D40dmLv0uFwnCHP9pobAdqmlwP
 zcdg==
X-Gm-Message-State: AOJu0YxJf3r4ycudun+blCj5pTeZAZ91D6jEo2rXig7xvcP8BLe3HPh0
 p4KHOYQrX/qFC/HXTBJP1fcWfh+znH/hWt0kkLIcfOmKcCaS0y8Bv+jkqmSYG/Xc/fWobIxTm4Q
 gwS3WDTvBD+p6C43abAe3MphEvuwOudVESElEeiizzE710qOFESDrC9bcbi6zF5PZYXbDcEDvXG
 CUm9b+b0RXnGDqc9OFvhNEcmQW6kWT4vo=
X-Received: by 2002:a17:90a:1308:b0:29b:bff0:d424 with SMTP id
 h8-20020a17090a130800b0029bbff0d424mr7864864pja.14.1710742747337; 
 Sun, 17 Mar 2024 23:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr/DP7G+N0GTL0QO7UsIDnyTU6SJryqjKwsxnPyyxXKcRwH66WbIMEIc6wQzzrgCKSDBzVfohQa4FVS6i3uyU=
X-Received: by 2002:a17:90a:1308:b0:29b:bff0:d424 with SMTP id
 h8-20020a17090a130800b0029bbff0d424mr7864857pja.14.1710742746990; Sun, 17 Mar
 2024 23:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240317093901.3212684-1-liwang@redhat.com>
 <20240317093901.3212684-2-liwang@redhat.com>
 <20240317211002.GB358991@pevik>
In-Reply-To: <20240317211002.GB358991@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Mar 2024 14:18:55 +0800
Message-ID: <CAEemH2eXDO2rKjukFMu-kCx4YoY+_Tk84xAi09uYMbGufpcrQA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/3] kconfig: add funtion to parse /proc/cmdline
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

T24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgNToxMOKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IEEgbmV3IHN0cnVjdHVyZSB0c3Rfa2NtZGxpbmVf
dmFyIGlzIGRlZmluZWQgdG8gaG9sZCBhIGNvbW1hbmQtbGluZQo+ID4gYXJndW1lbnQncyBrZXkg
YW5kIGEgZml4ZWQtc2l6ZSB2YWx1ZS4gRnVydGhlcm1vcmUsIGZ1bmN0aW9uCj4gPiB0c3Rfa2Nt
ZGxpbmVfcGFyc2UgaXMgYWRkZWQgdG8gdGhlIGNvcnJlc3BvbmRpbmcgLmMgZmlsZSwgd2hpY2gK
PiA+IHJlYWRzIGZyb20gL3Byb2MvY21kbGluZSwgcGFyc2VzIHRoZSBjb21tYW5kLWxpbmUgYXJn
dW1lbnRzLCBhbmQKPiA+IHBvcHVsYXRlcyB0aGUgdHN0X2tjbWRsaW5lX3ZhciBhcnJheSB3aXRo
IHRoZSBvYnRhaW5lZCBrZXktdmFsdWUKPiA+IHBhaXJzLCBlbnN1cmluZyBzYWZlIGZpbGUgb3Bl
cmF0aW9ucyBhbmQgYnVmZmVyIHNpemUgY2hlY2tzLgo+Cj4gTmljZS4gSnVzdCBjb21waWxlciB3
YXJuaW5nIGFuZCBmb3JtYXR0aW5nIG5pdHMgYmVsb3cgKGp1c3QgZml4IHRoZW0KPiBiZWZvcmUg
bWVyZ2UpLgo+IFRoYW5rcyBhIGxvdCBmb3IgYWRkaW5nIGEgdGVzdC4KPgo+IFJldmlld2VkLWJ5
OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+ID4gU2lnbmVkLW9mZi1ieTogTGkgV2Fu
ZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICBpbmNsdWRlL3RzdF9rY29uZmlnLmgg
ICAgICAgICAgICAgfCAyOSArKysrKysrKysrKysrKwo+ID4gIGxpYi9uZXdsaWJfdGVzdHMvdGVz
dF9rY29uZmlnMDMuYyB8IDQwICsrKysrKysrKysrKysrKysrKysKPiA+ICBsaWIvdHN0X2tjb25m
aWcuYyAgICAgICAgICAgICAgICAgfCA2NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Cj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9ucygrKQo+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBsaWIvbmV3bGliX3Rlc3RzL3Rlc3Rfa2NvbmZpZzAzLmMKPgo+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvdHN0X2tjb25maWcuaCBiL2luY2x1ZGUvdHN0X2tjb25maWcuaAo+ID4gaW5k
ZXggOGIyNGE4MzgwLi5iYmI4OTk3ODQgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL3RzdF9rY29u
ZmlnLmgKPiA+ICsrKyBiL2luY2x1ZGUvdHN0X2tjb25maWcuaAo+ID4gQEAgLTYsNiArNiw4IEBA
Cj4gPiAgI2lmbmRlZiBUU1RfS0NPTkZJR19IX18KPiA+ICAjZGVmaW5lIFRTVF9LQ09ORklHX0hf
Xwo+Cj4gPiArI2luY2x1ZGUgPHN0ZGJvb2wuaD4KPiA+ICsKPiA+ICAvKioKPiA+ICAgKiBJbml0
aWFsaXphdGlvbiBoZWxwZXIgbWFjcm8gZm9yIHN0cnVjdCB0c3Rfa2NvbmZpZ192YXIuIFJlcXVp
cmVzCj4gPHN0cmluZy5oPgo+IHZlcnkgbmljOiBtaXNzaW5nIGRvdCBhdCB0aGUgZW5kLgo+ID4g
ICAqLwo+ID4gQEAgLTY0LDQgKzY2LDMxIEBAIHZvaWQgdHN0X2tjb25maWdfcmVhZChzdHJ1Y3Qg
dHN0X2tjb25maWdfdmFyIHZhcnNbXSwKPiBzaXplX3QgdmFyc19sZW4pOwo+ID4gICAqLwo+ID4g
IGludCB0c3Rfa2NvbmZpZ19jaGVjayhjb25zdCBjaGFyICpjb25zdCBrY29uZmlnc1tdKTsKPgo+
ID4gKy8qKgo+ID4gKyAqIE1hY3JvIHRvIGluaXRpYWxpemUgYSB0c3Rfa2NtZGxpbmVfdmFyIHN0
cnVjdHVyZSB3aXRoIGEgc3BlY2lmaWVkCj4gcGFyYW1ldGVyCj4gPiArICogbmFtZSBhbmQgYW4g
ZW1wdHkgdmFsdWUuIFRoaXMgaXMgdXNlZnVsIGZvciBzZXR0aW5nIHVwIGFuIGFycmF5IG9mCj4g
cGFyYW1ldGVyCj4gPiArICogc3RydWN0dXJlcyBiZWZvcmUgcGFyc2luZyB0aGUgYWN0dWFsIGNv
bW1hbmQtbGluZSBhcmd1bWVudHMuCj4gPiArICovCj4gPiArI2RlZmluZSBUU1RfS0NNRExJTkVf
SU5JVChwYXJhbmFtZSkgeyBcCj4gPiArICAgICAua2V5ID0gcGFyYW5hbWUsIFwKPiA+ICsgICAg
IC52YWx1ZSA9ICIiLCBcCj4gPiArICAgICAuZm91bmQgPSBmYWxzZSBcCj4gPiArfQo+ID4gKwo+
ID4gKy8qKgo+ID4gKyAqIFN0cnVjdHVyZSBmb3Igc3RvcmluZyBjb21tYW5kLWxpbmUgcGFyYW1l
dGVyIGtleSBhbmQgaXRzCj4gY29ycmVzcG9uZGluZyB2YWx1ZQo+IGFuZCBoZXJlLgo+Cj4gPiAr
ICovCj4gPiArc3RydWN0IHRzdF9rY21kbGluZV92YXIgewo+ID4gKyAgICAgY29uc3QgY2hhciAq
a2V5Owo+ID4gKyAgICAgY2hhciB2YWx1ZVsxMjhdOwo+ID4gKyAgICAgYm9vbCBmb3VuZDsKPiA+
ICt9Owo+ID4gKwo+ID4gKy8qKgo+ID4gKyAqIFBhcnNlcyBjb21tYW5kLWxpbmUgcGFyYW1ldGVy
cyBmcm9tIC9wcm9jL2NtZGxpbmUgYW5kIHN0b3JlcyB0aGVtIGluCj4gcGFyYW1zIGFycmF5Lgo+
ID4gKyAqIHBhcmFtczogVGhlIGFycmF5IG9mIHRzdF9rY21kbGluZV92YXIgc3RydWN0dXJlcyB0
byBiZSBmaWxsZWQgd2l0aAo+IHBhcnNlZCBrZXktdmFsdWUgcGFpcnMuCj4gPiArICogcGFyYW1z
X2xlbjogVGhlIGxlbmd0aCBvZiB0aGUgcGFyYW1zIGFycmF5LCBpbmRpY2F0aW5nIGhvdyBtYW55
Cj4gcGFyYW1ldGVycyB0byBwYXJzZS4KPiA+ICsgKi8KPiA+ICt2b2lkIHRzdF9rY21kbGluZV9w
YXJzZShzdHJ1Y3QgdHN0X2tjbWRsaW5lX3ZhciBwYXJhbXNbXSwgc2l6ZV90Cj4gcGFyYW1zX2xl
bik7Cj4gPiArCj4gPiAgI2VuZGlmICAgICAgIC8qIFRTVF9LQ09ORklHX0hfXyAqLwo+ID4gZGlm
ZiAtLWdpdCBhL2xpYi9uZXdsaWJfdGVzdHMvdGVzdF9rY29uZmlnMDMuYwo+IGIvbGliL25ld2xp
Yl90ZXN0cy90ZXN0X2tjb25maWcwMy5jCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5k
ZXggMDAwMDAwMDAwLi45MzdjMmIyOWMKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsrKyBiL2xpYi9u
ZXdsaWJfdGVzdHMvdGVzdF9rY29uZmlnMDMuYwo+ID4gQEAgLTAsMCArMSw0MCBAQAo+ID4gKy8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gPiArLyoKPiA+ICsg
KiBDb3B5cmlnaHQgKGMpIDIwMjQgTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiArICov
Cj4gPiArCj4gPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gPiArI2luY2x1ZGUgInRzdF9rY29u
ZmlnLmgiCj4gPiArCj4gPiArc3RhdGljIHN0cnVjdCB0c3Rfa2NtZGxpbmVfdmFyIHBhcmFtc1td
ID0gewo+ID4gKyAgICAgVFNUX0tDTURMSU5FX0lOSVQoIkJPT1RfSU1BR0UiKSwKPiA+ICsgICAg
IFRTVF9LQ01ETElORV9JTklUKCJyb290IiksCj4gPiArICAgICBUU1RfS0NNRExJTkVfSU5JVCgi
Zm9vIikKPiA+ICt9Owo+ID4gKwo+ID4gK3N0YXRpYyB2b2lkIGRvX3Rlc3Qodm9pZCkKPiA+ICt7
Cj4gPiArICAgICBpbnQgaSwgTjsKPiA+ICsKPiA+ICsgICAgIE4gPSAoaW50KSBBUlJBWV9TSVpF
KHBhcmFtcyk7Cj4gPiArCj4gPiArICAgICB0c3Rfa2NtZGxpbmVfcGFyc2UocGFyYW1zLCBOKTsK
PiA+ICsKPiA+ICsgICAgIGZvciAoaSA9IDA7IGkgPCBOOyBpKyspIHsKPiA+ICsgICAgICAgICAg
ICAgaWYgKHBhcmFtc1tpXS5mb3VuZCkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChw
YXJhbXNbaV0udmFsdWUpCj4KPiB0ZXN0X2tjb25maWcwMy5jOjI1OjI5OiB3YXJuaW5nOiB0aGUg
Y29tcGFyaXNvbiB3aWxsIGFsd2F5cyBldmFsdWF0ZSBhcwo+IOKAmHRydWXigJkgZm9yIHRoZSBh
ZGRyZXNzIG9mIOKAmHZhbHVl4oCZIHdpbGwgbmV2ZXIgYmUgTlVMTCBbLVdhZGRyZXNzXQo+ICAg
IDI1IHwgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHBhcmFtc1tpXS52YWx1ZSkKPiAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn4KPiBJbiBmaWxlIGluY2x1ZGVk
IGZyb20gdGVzdF9rY29uZmlnMDMuYzo3Ogo+IC4uLy4uL2luY2x1ZGUvdHN0X2tjb25maWcuaDo4
NToxNDogbm90ZTog4oCYdmFsdWXigJkgZGVjbGFyZWQgaGVyZQo+ICAgIDg1IHwgICAgICAgICBj
aGFyIHZhbHVlWzEyOF07Cj4KPiBJdCBtdXN0IGJlOgo+IGlmIChwYXJhbXNbaV0udmFsdWVbMF0g
IT0gJ1wwJykKPgo+IE9yIGp1c3Qgd2l0aG91dCBlbHNlIGF0IGFsbDoKPgo+ICAgICAgICAgZm9y
IChpID0gMDsgaSA8IE47IGkrKykgewo+ICAgICAgICAgICAgICAgICBpZiAocGFyYW1zW2ldLmZv
dW5kKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgdHN0X3JlcyhUUEFTUywgInBhcmFtc1sl
ZF0gPSB7JXMsICVzfSIsIGksCj4gcGFyYW1zW2ldLmtleSwgcGFyYW1zW2ldLnZhbHVlKTsKPiAg
ICAgICAgICAgICAgICAgfSBlbHNlIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXN0
cmNtcChwYXJhbXNbaV0ua2V5LCAiZm9vIikpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB0c3RfcmVzKFRQQVNTLCAiJXMgaXMgbm90IGZvdW5kIGluCj4gL3Byb2MvY21kbGluZSIs
IHBhcmFtc1tpXS5rZXkpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2UKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwsICIlcyBpcyBub3QgZm91bmQg
aW4KPiAvcHJvYy9jbWRsaW5lIiwgcGFyYW1zW2ldLmtleSk7Cj4gICAgICAgICAgICAgICAgIH0K
PgoKTG9va3MgZ29vZCwgUGF0Y2ggYXBwbGllZCB3aXRoIHlvdXIgc3VnZ2VzdGlvbi4gVGhhbmtz
IQoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
