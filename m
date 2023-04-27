Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF4CC77B61
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 08:37:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B042E3CE4A6
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 10:37:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0F473C995A
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 10:37:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B2DE52000D4
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 10:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682584637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3MY7MVT69Y6ogDFhNT0gsX59naN0DyWCcPPWBiw9l4=;
 b=XZps5F4DZH0XL5H6mkzPMJxp3RT7WWN1Ys/BO2HiSpyO1Go26dE7OlKnsXoBO1ScXLxIAJ
 T8Hcvmd20s9AlTqntSCWGZIBKDPOnEDrNiOYklLZywz+BfHp7G55PLHBvUWsnn4nx9XmJ1
 seV1IKjNcLPbXrQ1bUrPiiTxB3b+doA=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-JnC2Uxo5NZyxG-3FP7IHpA-1; Thu, 27 Apr 2023 04:37:15 -0400
X-MC-Unique: JnC2Uxo5NZyxG-3FP7IHpA-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-42e38b93668so2112057137.0
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 01:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682584635; x=1685176635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3MY7MVT69Y6ogDFhNT0gsX59naN0DyWCcPPWBiw9l4=;
 b=CRROozjLfTgbmqDOhImHxp8UTCSDk4RTMYGOexqQhvO1j4Qo3bugOpLgAnGj4VPSoD
 k4R6Hdj86u6s2VYL9ULJHyey1JWfXnVO0qIHlXTTOwQWgkuXCv6+oLIdxuY4aly7lkyB
 ERIHhYwGAMSqI6s1KGUpHKXWfmbwTVL2jC+EA3wYadPBpJM0ARPbFPCI0gqvjPJJNK8k
 GT48qHqgvqoKv1jXRG4H6QMvNgickRVpzdBCZ5XuxUDndbHBsc1O2O9atPzvHTBTjx+Q
 7R+93WEYDi0ogzGH6D0RqAzWmFe4fs2hIBS5c603hdRTF7qPVcUoUwHEV7TLjIXIXaVL
 QEzw==
X-Gm-Message-State: AC+VfDxSoYdiOOcFDW/bYdsP4FWA+5NDifQIPksySl4JRPrLWMrz/7w7
 RqsDVjzDGpiWMeb6QOGxJVVdirUPT5FoCqEWoTZeyqbAacwFMn+Nwj4q2v8b0tlY/XKOBl7rH2H
 aQ3YfHUBsc1/2nroTZTJfMe1zjEU=
X-Received: by 2002:a67:e909:0:b0:42f:fae5:3b98 with SMTP id
 c9-20020a67e909000000b0042ffae53b98mr303058vso.14.1682584634958; 
 Thu, 27 Apr 2023 01:37:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UPX/u7yaoQ4q2SefrH1PiMpMqaY22n0NCsv+t1Abm4NCuljDXgFyxZYfwOQCKrd9q2wRBLMyCbqhkF4eHugw=
X-Received: by 2002:a67:e909:0:b0:42f:fae5:3b98 with SMTP id
 c9-20020a67e909000000b0042ffae53b98mr303049vso.14.1682584634507; Thu, 27 Apr
 2023 01:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230427034039.46512-1-liwang@redhat.com>
In-Reply-To: <20230427034039.46512-1-liwang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 27 Apr 2023 10:37:10 +0200
Message-ID: <CAASaF6xujKxK+7Enp5uCk5CZuioc3TjUMjuYe4C6UdWMC6_X+A@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap24: increase the baseline of
 slice_boundary according to hpage size
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
Cc: ltp@lists.linux.it, Fanhui Meng <mengfanhui@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgMjcsIDIwMjMgYXQgNTo0MOKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IFRoaXMgaXMgdG8gYXZvaWQgZXJyb3IgaGFwcGVucyBvbiBzeXN0ZW0g
KGFhcmNoNjQ6IDUxMk1CKSB3aXRoIGxhcmdlIGh1Z2UgcGFnZToKPgo+ICAgIyAuL2h1Z2VtbWFw
MjQKPiAgIHRzdF9odWdlcGFnZS5jOjgzOiBUSU5GTzogNyBodWdlcGFnZShzKSByZXNlcnZlZAo+
ICAgdHN0X3Rlc3QuYzoxNTYwOiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMK
PiAgIGh1Z2VtbWFwMjQuYzo1NzogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHgx
MDAwMDAwMDogRUlOVkFMICgyMikKPiAgIGh1Z2VtbWFwMjQuYzo1NzogVElORk86IGNhbid0IHVz
ZSBzbGljZV9ib3VuZGFyeTogMHgyMDAwMDAwMDogRU5PTUVNICgxMikKPiAgIGh1Z2VtbWFwMjQu
Yzo1NzogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHgzMDAwMDAwMDogRUlOVkFM
ICgyMikKPiAgIHRzdF90ZXN0LmM6MTYxODogVEJST0s6IFRlc3Qga2lsbGVkIGJ5IFNJR1NFR1Yh
Cj4KPiAgICMgc3RyYWNlIC1mIC4vaHVnZW1tYXAyNO+8mgo+ICAgLi4uCj4gICBbcGlkIDg2NTgw
XSBtbWFwKDB4ZmZmZmZmZmZmMDAwMDAwMCwgMjE0NzQ4MzY0OCwgUFJPVF9SRUFELCBNQVBfU0hB
UkVEfE1BUF9GSVhFRCwgMywgMCkgPSAtMSBFSU5WQUwKPiAgIFtwaWQgODY1ODBdIHdyaXRlKDIs
ICJodWdlbW1hcDI0LmM6NTc6IFwzM1sxOzM0bVRJTkZPOiBcMzMiLi4uLCA4NWh1Z2VtbWFwMjQu
Yzo1NzogVElORk86IGNhbid0IHVzZSBzbGljZV9ib3VuZGFyeTogMHgzMDAwMDAwMDogRUlOVkFM
ICgyMikpID0gODUKPiAgIFtwaWQgODY1ODBdIG1tYXAoTlVMTCwgMjE0NzQ4MzY0OCwgUFJPVF9S
RUFELCBNQVBfU0hBUkVEfE1BUF9GSVhFRCwgMywgMCkgPSAwCj4gICBbcGlkIDg2NTgwXSAtLS0g
U0lHU0VHViB7c2lfc2lnbm89U0lHU0VHViwgc2lfY29kZT1TRUdWX0FDQ0VSUiwgc2lfYWRkcj0w
eDQwNDMzOH0gLS0tCj4gICBbcGlkIDg2NTgwXSArKysga2lsbGVkIGJ5IFNJR1NFR1YgKGNvcmUg
ZHVtcGVkKSArKysKPgo+ICAgIyBjYXQgL3Byb2MvbWVtaW5mbwo+ICAgSHVnZXBhZ2VzaXplOiA1
MjQyODgga0IKPgo+IE5vdGU6Cj4gICBUaGlzIGlzIGJhc2ljYWxseSBhbiBpbXByb3ZlZCBwYXRj
aCBiYXNlZCBvbiBKYW4ncyB3b3JrLCB0aGUgb25seQo+ICAgZGlmZmVyZW5jZSBpcyB0aGF0IHRv
IGJ5cGFzcyB0aGUgaGVhcCBhbmQgYXZvaWQgc29tZSBwb3RlbnRpYWwKPiAgIG1tYXAgY29sbGlz
aW9ucy4KPgo+ICAgUGF0Y2ggZ2V0IHBhc3NlZCBvbiBSSEVMLTcvOC85IGFjcm9zcyBtYW55IGFy
Y2hlcy4KPiAgICh4ODZfNjQsIHBwYzY0bGUsIHBwYzY0LCBhYXJjaDY0LCBzMzkweCkKCkl0J3Mg
YW4gaW1wcm92ZW1lbnQsIGJ1dCB0aGUgaXNzdWUgb2YgdXNhZ2Ugb2YgTUFQX0ZJWEVEIHJlbWFp
bnMuCk5vIGhhcm0gdGFraW5nIHRoZSBwYXRjaCwgYnV0IHdlIHNob3VsZCBsaWtlbHkgc3RpbGwg
cmV3cml0ZSB0aGlzIHRlc3QuCgpBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhh
dC5jb20+Cgo+Cj4gQ2xvc2VzOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0
L2x0cC9pc3N1ZXMvMTAyMgo+IERpc2N1c3M6IGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJt
YWlsL2x0cC8yMDIzLU1hcmNoLzAzMzExNy5odG1sCj4KPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5n
IDxsaXdhbmdAcmVkaGF0LmNvbT4KPiBDYzogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5j
b20+Cj4gQ2M6IFRhcnVuIFNhaHUgPHRzYWh1QGxpbnV4LmlibS5jb20+Cj4gQ2M6IEZhbmh1aSBN
ZW5nIDxtZW5nZmFuaHVpQGt5bGlub3MuY24+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvbWVt
L2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAyNC5jIHwgOSArKysrKysrKy0KPiAgMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAyNC5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDI0LmMKPiBpbmRleCBhNDY1
YWFkZWMuLjE1OGEwMzAxMCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdl
dGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMjQuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1
Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAyNC5jCj4gQEAgLTIzLDcgKzIzLDcgQEAKPgo+ICBzdGF0
aWMgaW50ICBmZCA9IC0xOwo+ICBzdGF0aWMgdW5zaWduZWQgbG9uZyBzbGljZV9ib3VuZGFyeTsK
PiAtc3RhdGljIGxvbmcgaHBhZ2Vfc2l6ZSwgcGFnZV9zaXplOwo+ICtzdGF0aWMgdW5zaWduZWQg
bG9uZyBocGFnZV9zaXplLCBwYWdlX3NpemU7Cj4KPiAgc3RhdGljIGludCBpbml0X3NsaWNlX2Jv
dW5kYXJ5KGludCBmZCkKPiAgewo+IEBAIC00NCw2ICs0NCwxMyBAQCBzdGF0aWMgaW50IGluaXRf
c2xpY2VfYm91bmRhcnkoaW50IGZkKQo+ICAgICAgICAgaGVhcCA9IG1hbGxvYygxKTsKPiAgICAg
ICAgIGZyZWUoaGVhcCk7Cj4KPiArICAgICAgICAvKiBBdm9pZCB1bmRlcmZsb3cgb24gc3lzdGVt
cyB3aXRoIGxhcmdlIGh1Z2UgcGFnZXMuCj4gKyAgICAgICAgICogVGhlIGFkZGl0aW9uYWxseSBw
bHVzIGhlYXAgYWRkcmVzcyBpcyB0byByZWR1Y2UgdGhlIHBvc3NpYmlsaXR5Cj4gKyAgICAgICAg
ICogb2YgTUFQX0ZJWEVEIHN0b21wIG92ZXIgZXhpc3RpbmcgbWFwcGluZ3MuCj4gKyAgICAgICAg
ICovCj4gKyAgICAgICB3aGlsZSAoc2xpY2VfYm91bmRhcnkgKyBzbGljZV9zaXplIDwgKHVuc2ln
bmVkIGxvbmcpaGVhcCArIDIqaHBhZ2Vfc2l6ZSkKPiArICAgICAgICAgICAgICAgc2xpY2VfYm91
bmRhcnkgKz0gc2xpY2Vfc2l6ZTsKPiArCj4gICAgICAgICAvKiBGaW5kIDIgbmVpZ2hib3VyIHNs
aWNlcyB3aXRoIGNvdXBsZSBodWdlIHBhZ2VzIGZyZWUKPiAgICAgICAgICAqIGFyb3VuZCBzbGlj
ZSBib3VuZGFyeS4KPiAgICAgICAgICAqIDE2IGlzIHRoZSBtYXhpbXVtIG51bWJlciBvZiBzbGlj
ZXMgKGxvdy9oaWdoKQo+IC0tCj4gMi40MC4wCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
