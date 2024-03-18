Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B93C54E58
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 06:33:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 924943CFC1C
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 07:33:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64ED73CC817
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 07:32:59 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 92CAA1A00CC6
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 07:32:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710743576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kbc4RV+1OTjpGcgeZKe3nNshfJ1+OCkT5Vehl2MvKn8=;
 b=VJUvj+LcGDJrpjifDdyglKqK2RBlUM7QeLI3H/FbXz7wEdi+Bn7EyvDEoO51sNG3hXLJ7v
 0AoQEfKqvNRKHGkQo8LS3uFEt+826lSNM26M9pNhGb++sWkUQBkY7WTH5T6o0Am3JEh0hk
 EION3Du2RZHzUkrFZhAV7hY0DMOx9UM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-Q9S3SRGtNQCl68vjkmkPVg-1; Mon, 18 Mar 2024 02:32:54 -0400
X-MC-Unique: Q9S3SRGtNQCl68vjkmkPVg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29ddc8a7bb3so3007927a91.2
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 23:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710743573; x=1711348373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kbc4RV+1OTjpGcgeZKe3nNshfJ1+OCkT5Vehl2MvKn8=;
 b=PMxNnNNaOIzt/MmmtKnjpm+mPD9JgemZ18ll08PddHpAfwKFzPLYtwUOLamxtf+aef
 SwaewoZq5LUw1uvsHwFR/XBKoHrzKlay+bb5g8/6trx7KwICKZkHXWAbPaGcxxFYvPRw
 /ut8kqr4YlmSBqAS6Dd2vevsdLEekf+qrDCMmaagjZvdo79x7S16zrJZgJv0aafInSUH
 D80MoIyigewJ2g5I1SUqMjH1cWiRIyg8TjFVGvDZxX4Rf7zQI/F5jQr1UxTMsKXDNPad
 4BiMXIFZz4VDkrf7PWug0J2lLkJBj5zz3VDDIQwysQRecrcCDPYQKmpa9BsXbsmTVpcu
 60PA==
X-Gm-Message-State: AOJu0YxUGEmnZ/uwDMrlcmNsHBl5YbtX61QSFPbdM8w/9ljPabFMOrUG
 vbo2evWfPIoLtTtAoUNLIDFmq8FokzBJHy+FkbDuyEntfxOAi7fHrilcz5x6TE10Y+qNZQkWIRt
 QGbOnmmoflNl9/ttsgNAveZI8mjzSRt1ukxmzTocg5WZNxIubqr9gcRfcf3wGsveugXo/kUthaR
 13gR+9MzZ4+Y8adv4uu/vAksc=
X-Received: by 2002:a17:90b:617:b0:29b:fa9f:af9f with SMTP id
 gb23-20020a17090b061700b0029bfa9faf9fmr9809624pjb.18.1710743573324; 
 Sun, 17 Mar 2024 23:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhhf46EH8q8z0+ZNY1MdIEFhDs0EFrU6PCPIkJvuq8jiQlZeL4YpGwkuLfVGeB+DBWob9uF73hYaeNhJ2+08I=
X-Received: by 2002:a17:90b:617:b0:29b:fa9f:af9f with SMTP id
 gb23-20020a17090b061700b0029bfa9faf9fmr9809611pjb.18.1710743573063; Sun, 17
 Mar 2024 23:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2cTzLuJ1uTBNbUB-E7kJPeHjx3sPi1crkqTCJ6h4DgSbg@mail.gmail.com>
 <20240315062448.3181177-1-liwang@redhat.com>
 <ZfP8YEwKpLGweAe1@wegao.29.253.26>
 <CAEemH2e5BB=L6-uT25ppcjGnXqJu7U-MmTCNdFsu8FE3sGv=Lw@mail.gmail.com>
 <ZfQoVC7xBfGHNsgI@wegao.157.234.177>
 <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
 <ZfezDUSKwUdoSamA@wegao.215.20.80>
In-Reply-To: <ZfezDUSKwUdoSamA@wegao.215.20.80>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Mar 2024 14:32:41 +0800
Message-ID: <CAEemH2cLfO9nMnOdB3wTuK6bmkfsPJp_fdQOXSFU-SfHfdQSZA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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

T24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgMTE6MjDigK9BTSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNv
bT4gd3JvdGU6Cgo+IE9uIFN1biwgTWFyIDE3LCAyMDI0IGF0IDA1OjUyOjAxUE0gKzA4MDAsIExp
IFdhbmcgd3JvdGU6Cj4gPiBIaSBXZWksCj4gPgo+ID4gQ2FuIHlvdSB0cnkgdGhpcyBvbmUgYW5k
IHBvc3QgdGhlIHRlc3QgbG9nIGhlcmU/Cj4gPgo+ID4gQW5kIGFnYWluLCBpdCdkIGJlIGhlbHBm
dWwgdG8ga25vdyB0aGUgY29uZmlnIG9mIHlvdXIgU1VULgo+ID4gZS5nLiBgZnJlZSAtaGAgIGBs
c2NwdWAgIGB1bmFtZSAtcmAgIGluZm9mb3JtYXRpb24KPiA+Cj4gPgo+ID4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4gQEAgLTM3LDExICszNywyMCBA
QCBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9uKHZvaWQpCj4gPgo+ID4gIHN0YXRpYyB2b2lkIHNl
dHVwKHZvaWQpCj4gPiAgewo+ID4gKyAgICAgICB0c3RfZW5hYmxlX29vbV9wcm90ZWN0aW9uKDAp
Owo+ID4gICAgICAgICBpc19zd2FwX3N1cHBvcnRlZChTV0FQX0ZJTEUpOwo+ID4gLSAgICAgICBt
YWtlX3N3YXBmaWxlKFNXQVBfRklMRSwgMTAsIDApOwo+ID4gKyAgICAgICBtYWtlX3N3YXBmaWxl
KFNXQVBfRklMRSwgMTAyNCwgMCk7Cj4gPgo+ID4gICAgICAgICBTQUZFX0NHX1BSSU5URih0c3Rf
Y2csICJjZ3JvdXAucHJvY3MiLCAiJWQiLCBnZXRwaWQoKSk7Cj4gPiAgICAgICAgIFNBRkVfQ0df
UFJJTlRGKHRzdF9jZywgIm1lbW9yeS5tYXgiLCAiJWx1IiwgVEVTVE1FTSk7Cj4gPiArCj4gPiAr
ICAgICAgIGlmIChTQUZFX0NHX0hBUyh0c3RfY2csICJtZW1vcnkuc3dhcC5tYXgiKSkKPiA+ICsg
ICAgICAgICAgICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJtZW1vcnkuc3dhcC5tYXgiLCAi
JWxkIiwgVEVTVE1FTQo+ICoKPiA+IDIpOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgdm9pZCBj
bGVhbnVwKHZvaWQpCj4gPiArewo+ID4gKyAgICAgICB0c3RfZGlzYWJsZV9vb21fcHJvdGVjdGlv
bigwKTsKPiA+ICB9Cj4gPgo+ID4gIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+
IEBAIC01MSw1ICs2MCw2IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ICAg
ICAgICAgLmFsbF9maWxlc3lzdGVtcyA9IDEsCj4gPiAgICAgICAgIC5uZWVkc19jZ3JvdXBfY3Ry
bHMgPSAoY29uc3QgY2hhciAqY29uc3QgW10peyAibWVtb3J5IiwgTlVMTCB9LAo+ID4gICAgICAg
ICAudGVzdF9hbGwgPSB2ZXJpZnlfc3dhcG9uLAo+ID4gLSAgICAgICAuc2V0dXAgPSBzZXR1cAo+
ID4gKyAgICAgICAuc2V0dXAgPSBzZXR1cCwKPiA+ICsgICAgICAgLmNsZWFudXAgPSBjbGVhbnVw
Cj4gPiAgfTsKPiA+Cj4gPgoKCgo+Cj4gbG9jYWxob3N0On4gIyBmcmVlIC1oIDw8PDwgYmVmb3Jl
IHJ1bm5pbmcgY2FzZQo+ICAgICAgICAgICAgICAgIHRvdGFsICAgICAgICB1c2VkICAgICAgICBm
cmVlICAgICAgc2hhcmVkICBidWZmL2NhY2hlCj4gIGF2YWlsYWJsZQo+IE1lbTogICAgICAgICAg
IDMuOEdpICAgICAgIDQ3OE1pICAgICAgIDMuM0dpICAgICAgIDkuME1pICAgICAgIDM0Nk1pCj4g
IDMuNEdpCj4gU3dhcDogICAgICAgICAgICAgMEIgICAgICAgICAgMEIgICAgICAgICAgMEIKPgoK
SSBzZWUsIGl0IGlzIHZlcnkgbGlrZWx5IHRoYXQgeW91ciBzeXN0ZW0gaGFzIG5vIHN3YXAgc3Bh
Y2UKc28gdGhhdCB0aGUgVEVTVE1FTSgxR0IpIGNhbiBub3QgYmUgc3dhcHBlZCBvdXQsIHRoZW4K
T09NIGtpbGxlciBoYXMgdG8gYmUgY2FsbGVkIG91dC4KCkkgY2FuIHJlcHJvZHVjZSB5b3VyIHBy
b2JsZW0gYnkgZGlzYWJsaW5nIGFsbCBzd2FwIGZpbGVzIG9uIG15IHN5c3RlbS4KClNvIHRoZSBw
b3NzaWJsZSBmaXggd2F5IGlzIHRvIHJlZHVjZSB0aGUgVEVTVE1FTSBzaXplIGFuZCBpbmNyZWFz
ZQp0aGUgdGVzdGVkIHN3YXBmaWxlLgoKSSBndWVzcyB0aGlzIHBhdGNoIGNhbiB3b3JrIGZvciB5
b3UsIGhhdmUgYSB0cnk/CgotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9z
d2Fwb24wMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAx
LmMKQEAgLTIwLDcgKzIwLDcgQEAKCiAjZGVmaW5lIE1OVFBPSU5UICAgICAgICJtbnRwb2ludCIK
ICNkZWZpbmUgU1dBUF9GSUxFICAgICAgTU5UUE9JTlQiL3N3YXBmaWxlMDEiCi0jZGVmaW5lIFRF
U1RNRU0gICAgICAgICAgICAgICAgKDFVTDw8MzApCisjZGVmaW5lIFRFU1RNRU0gICAgICAgICAg
ICAgICAgKDFVTDw8MjQpICAvKiAxNk1CICovCgogc3RhdGljIHZvaWQgdmVyaWZ5X3N3YXBvbih2
b2lkKQogewpAQCAtMzgsNyArMzgsNyBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9uKHZvaWQp
CiBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQogewogICAgICAgIGlzX3N3YXBfc3VwcG9ydGVkKFNX
QVBfRklMRSk7Ci0gICAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDEwLCAwKTsKKyAgICAg
ICBtYWtlX3N3YXBmaWxlKFNXQVBfRklMRSwgNDA5NiwgMCk7CgogICAgICAgIFNBRkVfQ0dfUFJJ
TlRGKHRzdF9jZywgImNncm91cC5wcm9jcyIsICIlZCIsIGdldHBpZCgpKTsKICAgICAgICBTQUZF
X0NHX1BSSU5URih0c3RfY2csICJtZW1vcnkubWF4IiwgIiVsdSIsIFRFU1RNRU0pOwoKCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
