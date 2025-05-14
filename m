Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B01C3ABC3
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 01:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747185317; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=q9qUtVIjr0mcH8aV1AX5IahVHYDmt4O4CTbz7xTayW0=;
 b=c4U1bZr+4Kv/eJBoV49Wh8fCzhZCVWBMoWQmZGXl4SuweQt+Hsl2zM+0WJd8Ma/IXHiJ/
 Ma2E8ITu4uxCesjoo/k3e+xMEsFfliEa0E5P0DOT+YU5jf3H9zI1NvuocR4khmw6wxlmDsp
 JyXFRyi66eODS+OrQuJcdV3AlsXI544=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D7963CC35D
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 03:15:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 126773C4C04
 for <ltp@lists.linux.it>; Wed, 14 May 2025 03:14:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7CE37600C51
 for <ltp@lists.linux.it>; Wed, 14 May 2025 03:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747185291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWju0adKib45DsjO1cHeK+oYG+Tzb2b2GZoPQ4+qZrQ=;
 b=aPT0cwGoRX5OVNaacZ5drBXKSYAbt+QSl9ioalyYhgy7Y1tffVxs9tUcSeu6T3gR7V1ngk
 x9SruY8jd4hueUU6hyd2/Slks6yuZ2rX022tpEvA+Ste3f1QvoNrKHqrhLG6NNCewNOjUB
 U0Brev9/95HnnNVw7W/HSp7ijoplyos=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-0KUJeQ7qOwSB80Hq09ECmg-1; Tue, 13 May 2025 21:14:50 -0400
X-MC-Unique: 0KUJeQ7qOwSB80Hq09ECmg-1
X-Mimecast-MFC-AGG-ID: 0KUJeQ7qOwSB80Hq09ECmg_1747185289
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22e39ff4ad4so80836655ad.3
 for <ltp@lists.linux.it>; Tue, 13 May 2025 18:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747185289; x=1747790089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWju0adKib45DsjO1cHeK+oYG+Tzb2b2GZoPQ4+qZrQ=;
 b=XksCWp85fBwxSRNrMTQJqjnYXf4uSEIt1O2OBlaE6e3Zd36f5vLct1ddp530p3b7qT
 2SXT19SnVUD0scWZoLZG6BSlVKxrXLw7flYZQuSnPQe/XY7n4zwvHB5pgMb1drNd+ITe
 rSuclSCb3la9Zu6IanUOrhkFZnljULnE/Yn1/p9myRIKic0etOmbDCeRCX26LhxtXdwH
 +DBlwbKjOlIi674S8vs1j6aklHzczvvv4HD2FswyZAj666ZowsUz1vYV11o7FCvSjDfA
 5AbTTibJA7+osTItcsGMNelRnKaq3+SEdAmT/asmFFbTzuguJlZVTkk/K09+cFcOCvwk
 nQKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnZqSs/OevOXB45Zz6ALFJfmXguiNJbZBnAb/bO4LOU0QSuJpLnElLdfxrBDSm/VdT+wo=@lists.linux.it
X-Gm-Message-State: AOJu0YxijsZf54hTYiNEUnckGzpSpYn3aecdEGIX8MIM9gFgpDev41fo
 bSiL4rXdItDnV5+B1Ivu/3+EhhgVNQccjHYOM4Ni5k4QEdNroIqzVzkjAKwznscX8I8/a1UftZP
 uqEepeTCqxoQw20J+Rh1xAtn/2b3rfS1d3AP1y3OfISxuE74IFDKZ0b/OSsoKRXR/pB2EC7kouN
 I2HZs8X5g10CNV94mUr6Gd4V8=
X-Gm-Gg: ASbGncte0hYsThhb2kw8vvY6l0TAPNCleZ/XiMjJWBruxtxpSOIqq0GwAckfyoRKoXC
 KuowAzEIORw5jeCSnv6Kjc8nVCRLqkrTapJd2GwP//IaIUT9K4siZoxznMAlCUIKASlgE+g==
X-Received: by 2002:a17:902:ef06:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-2319810e004mr22985545ad.5.1747185288900; 
 Tue, 13 May 2025 18:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE9dKBJxkX+rC6NNm2xVnb92jw53rvtz2fyiS8QRaC6E0bwBxYqHJ3rz1AJdZUHrfv+bSuAdFWw0dtxJqAqUE=
X-Received: by 2002:a17:902:ef06:b0:223:5a6e:b16 with SMTP id
 d9443c01a7336-2319810e004mr22985225ad.5.1747185288453; Tue, 13 May 2025
 18:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250513050530.47541-1-liwang@redhat.com>
 <aCM2PrCrCdPqNIGc@yuki.lan> <20250513125148.GA244619@pevik>
 <CAEemH2dng7ZaxVgYUFLcqy0aamgFstoCogdOKkA2+DPJWctpig@mail.gmail.com>
 <CAEemH2f2qUqOxxEoaGhgvMWn4Y_EfDNMod=bAETWXBDZFQFRgw@mail.gmail.com>
 <20250513154159.GA378903@pevik>
In-Reply-To: <20250513154159.GA378903@pevik>
Date: Wed, 14 May 2025 09:14:36 +0800
X-Gm-Features: AX0GCFux3lT3hh7XVjwJFSEHM1FhX0KU8krWN_4hq28rRTYOCPyvv6SDoisOw_M
Message-ID: <CAEemH2c9CKTNFNs8DgOBc8nbcC4DHZbAL9QK54kHbAgXy0feuQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JdPIBxBmL8NWwzEm57udzfssqPVnHOicUiHmrhwjtGo_1747185289
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
 setup_ipc
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

T24gVHVlLCBNYXkgMTMsIDIwMjUgYXQgMTE6NDLigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiA+IE9uIFR1ZSwgTWF5IDEzLCAyMDI1IGF0IDk6MDLigK9QTSBMaSBX
YW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiA+ID4gT24gVHVlLCBNYXkgMTMsIDIw
MjUgYXQgODo1MuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ID4g
PiA+IEhpIGFsbCwKPgo+ID4gPiA+IC4uLgo+ID4gPiA+ID4gPiArKysgYi9saWIvdHN0X3Rlc3Qu
Ywo+ID4gPiA+ID4gPiBAQCAtNTksNyArNTksNiBAQCBzdGF0aWMgY29uc3QgY2hhciAqdGlkOwo+
ID4gPiA+ID4gPiAgc3RhdGljIGludCBpdGVyYXRpb25zID0gMTsKPiA+ID4gPiA+ID4gIHN0YXRp
YyBmbG9hdCBkdXJhdGlvbiA9IC0xOwo+ID4gPiA+ID4gPiAgc3RhdGljIGZsb2F0IHRpbWVvdXRf
bXVsID0gLTE7Cj4gPiA+ID4gPiA+IC1zdGF0aWMgcGlkX3QgbGliX3BpZDsKPiA+ID4gPiA+ID4g
IHN0YXRpYyBpbnQgbW50cG9pbnRfbW91bnRlZDsKPiA+ID4gPiA+ID4gIHN0YXRpYyBpbnQgb3Zs
X21vdW50ZWQ7Cj4gPiA+ID4gPiA+ICBzdGF0aWMgc3RydWN0IHRpbWVzcGVjIHRzdF9zdGFydF90
aW1lOyAvKiB2YWxpZCBvbmx5IGZvciB0ZXN0IHBpZCAqLwo+ID4gPiA+ID4gPiBAQCAtMTQzLDcg
KzE0Miw5IEBAIHN0YXRpYyB2b2lkIHNldHVwX2lwYyh2b2lkKQo+ID4gPiA+ID4gPiAgICAgICAg
ICAgICB0c3RfZnV0ZXhlcyA9IChjaGFyICopcmVzdWx0cyArIHNpemVvZihzdHJ1Y3QgcmVzdWx0
cyk7Cj4gPiA+ID4gPiA+ICAgICAgICAgICAgIHRzdF9tYXhfZnV0ZXhlcyA9IChzaXplIC0gc2l6
ZW9mKHN0cnVjdCByZXN1bHRzKSkvc2l6ZW9mKGZ1dGV4X3QpOwo+ID4gPiA+ID4gPiAgICAgfQo+
ID4gPiA+ID4gPiAtICAgcmVzdWx0cy0+bGliX3BpZCA9IGxpYl9waWQ7Cj4gPiA+ID4gPiA+ICsK
PiA+ID4gPiA+ID4gKyAgIHJlc3VsdHMtPmxpYl9waWQgPSAwOwo+ID4gPiA+ID4gPiArICAgcmVz
dWx0cy0+bWFpbl9waWQgPSAwOwo+Cj4gPiA+ID4gbml0OiBJcyBpdCByZWFsbHkgbmVlZGVkIHRv
IGludCB0aGVtIHRvIDA/IEJlY2F1c2UgdGhleSBzaG91bGQgYmUgMCBkdWUgdGhlCj4gPiA+ID4g
ZGVmYXVsdCBzdHJ1Y3QgdmFsdWUsIHJpZ2h0Pwo+Cj4gPiBUaGUgcmVzdWx0cyBzdHJ1Y3R1cmUg
bWVtb3J5IHdhcyBkeW5hbWljYWxseSBhbGxvY2F0ZWQgdmlhCj4gPiBtbWFwIHNvIHRoZSBkZWZh
dWx0IHZhbHVlIG1pZ2h0IG5vdCBiZSB6ZXJvLiBVbmxlc3Mgd2UgZG8KPiA+IGV4cGxpY2l0bHkg
Y2FsbCBtZW1zZXQoLCAwLCAuLi4pLgo+Cj4gVGhhbmtzIGZvciBpbmZvLiBPciBqdXN0IHVzZSB7
fSBpbnN0ZWFkIG9mIG1lbXNldD8KClRoaXMgb25seSBhcHBsaWVzIHRvIGF1dG9tYXRpYyAoc3Rh
Y2spIG9yIHN0YXRpYyBhbGxvY2F0aW9uLgpBcyB3ZSdyZSBkZWFsaW5nIHdpdGggZHluYW1pY2Fs
bHkgYWxsb2NhdGVkIG1lbW9yeSB2aWEgbW1hcCgpLAp3ZSBzdGlsbCBuZWVkIG1lbXNldCgpIG9y
IG1hbnVhbGx5IGluaXRpYWxpemUgaXQuCgpJbiBzZXR1cF9pcGMoKToKCnJlc3VsdHMgPSBTQUZF
X01NQVAoTlVMTCwgc2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwgTUFQX1NIQVJFRCwgaXBj
X2ZkLCAwKTsKCj4KPiBzdHJ1Y3QgcmVzdWx0cyBzYXZlZF9yZXN1bHRzID0ge307Cj4KPiBUaW55
IGRldGFpbCwganVzdCBpdCdzIG1vcmUgcmVhZGFibGUgdG8gbWUuCj4KPiBLaW5kIHJlZ2FyZHMs
Cj4gUGV0cgo+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
