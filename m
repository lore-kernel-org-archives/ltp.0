Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E4C001B0
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 09:43:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9179F3CCD8F
	for <ltp@archiver.kernel.org>; Tue, 15 Aug 2023 11:43:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A94083CCD76
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 11:43:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6169A1400172
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 11:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692092610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWXwSSHLbgRwmnewmLJlt3X2XOgVklYgYVwWooQEUUk=;
 b=GP1lj7E+zUw1XHCf44T1tBLVB2Me+XpcVD21UdafuHHDXBlE3euu2h1F9O8ZzKfn6eq/8g
 rDfxLyDqpVZpWzTM7Ks+BYA2qJIxzn3fnqCS2lpbg2PPgMREGrISelUu+pDcsYT9lt0Xsi
 0sSiIw22WIuK9yO+13mUH9uOref6Apk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ZjaTxu9CPUCqkuEAblYN5Q-1; Tue, 15 Aug 2023 05:43:28 -0400
X-MC-Unique: ZjaTxu9CPUCqkuEAblYN5Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9bf493456so50945351fa.0
 for <ltp@lists.linux.it>; Tue, 15 Aug 2023 02:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692092606; x=1692697406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fWXwSSHLbgRwmnewmLJlt3X2XOgVklYgYVwWooQEUUk=;
 b=il3wDFhukTFQXVahMpWW7Q1kWFO6dAT4RiQVFJd45GpL1qqTpcxfrNB6eNUd0fguh2
 jnUAtA8ohQU5JLfRyZBTL7yJiQElZ901GWUgpvEMWAArHM3nHs8V6l6oYeB8bm8PcJ0B
 ge26kAZXEsNyhAYQVtMvd1IJk9z4qY2mHA2Wola6DeJ2dJ5syHj/KQrvMXb0hDiZ8Fj1
 NsSl9G+0xYM6M1q9FlNvcbhhheSuZ3oD9iKdOZcNTdfAiOuMgTXCzdpsgnvenxxT4Mwm
 vvL5QKVj/ShAjv5qOtFdMvUwXCqqw9nkNUlNNme8OSQRwxkAKHHKs9D7lLhziznKs9XZ
 EOxg==
X-Gm-Message-State: AOJu0YwHS8PV6deObzWDanPb1LkoC9RzKw7PVzdECewSHhcGeYWkYy7L
 ztOfkqQwNjPSaJ3PaacIHoBlNR0f1HhwrSAg39wLgRfoiB/LKrrHd1nF8YffyosOAZKdOMOsO6b
 OCZua2WB8PcmtfO+edeSc2BBygyye4XDKBAd2xm3nJXo=
X-Received: by 2002:a2e:2c09:0:b0:2b9:c046:8617 with SMTP id
 s9-20020a2e2c09000000b002b9c0468617mr8214379ljs.5.1692092605911; 
 Tue, 15 Aug 2023 02:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH47BN8cpfvUqai4u6ZKqZqpgjTB3HcIZisy/m5GMTZoa59GnA5+z+hRCoHVgagrug6tcIsa5tXg4rLWE7HxtQ=
X-Received: by 2002:a2e:2c09:0:b0:2b9:c046:8617 with SMTP id
 s9-20020a2e2c09000000b002b9c0468617mr8214365ljs.5.1692092605508; Tue, 15 Aug
 2023 02:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230811115647.32387-1-chrubis@suse.cz>
 <20230811115647.32387-2-chrubis@suse.cz>
In-Reply-To: <20230811115647.32387-2-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Aug 2023 17:43:13 +0800
Message-ID: <CAEemH2fCOye2v8yL7AR6JO7Ar4tW83sB4Fi=YzJUuSCzhmtkiQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/6] lib: tst_buffers: Add bufs .str and
 tst_aprintf()
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

T24gRnJpLCBBdWcgMTEsIDIwMjMgYXQgNzo1NuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+Cj4gLS0tCj4gIGluY2x1ZGUvdHN0X2J1ZmZlcnMuaCB8IDExICsrKysrKysrKysrCj4g
IGxpYi90c3RfYnVmZmVycy5jICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X2J1ZmZlcnMuaCBiL2luY2x1ZGUvdHN0X2J1ZmZlcnMu
aAo+IGluZGV4IGQxOWFjOGNmMC4uYjVmMzU1ZjBmIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0
X2J1ZmZlcnMuaAo+ICsrKyBiL2luY2x1ZGUvdHN0X2J1ZmZlcnMuaAo+IEBAIC0yNSw2ICsyNSwx
MSBAQCBzdHJ1Y3QgdHN0X2J1ZmZlcnMgewo+ICAgICAgICAgICogQXJyYXkgb2YgaW92IGJ1ZmZl
ciBzaXplcyB0ZXJtaW5hdGVkIGJ5IC0xLgo+ICAgICAgICAgICovCj4gICAgICAgICBpbnQgKmlv
dl9zaXplczsKPiArICAgICAgIC8qCj4gKyAgICAgICAgKiBJZiBzaXplIGFuZCBpb3Zfc2l6ZXMg
aXMgTlVMTCB0aGlzIGlzIHRoZSBzdHJpbmcgd2Ugd2FudCB0bwo+IHN0cmR1cCgpCj4gKyAgICAg
ICAgKiBpbnRvIHRoZSBidWZmZXIuCj4gKyAgICAgICAgKi8KPiArICAgICAgIGNoYXIgKnN0cjsK
PiAgfTsKPgo+ICAvKgo+IEBAIC00Niw2ICs1MSwxMiBAQCBjaGFyICp0c3Rfc3RyZHVwKGNvbnN0
IGNoYXIgKnN0cik7Cj4gICAqLwo+ICB2b2lkICp0c3RfYWxsb2Moc2l6ZV90IHNpemUpOwo+Cj4g
Ky8qCj4gKyAqIFByaW50ZiBpbnRvIGEgZ3VhcmRlZCBidWZmZXIuCj4gKyAqLwo+ICtjaGFyICp0
c3RfYXByaW50Zihjb25zdCBjaGFyICpmbXQsIC4uLikKPiArICAgICAgX19hdHRyaWJ1dGVfXygo
Zm9ybWF0IChwcmludGYsIDEsIDIpKSk7Cj4gKwo+ICAvKgo+ICAgKiBBbGxvY2F0ZXMgaW92ZWMg
c3RydWN0dXJlIGluY2x1ZGluZyB0aGUgYnVmZmVycy4KPiAgICoKPiBkaWZmIC0tZ2l0IGEvbGli
L3RzdF9idWZmZXJzLmMgYi9saWIvdHN0X2J1ZmZlcnMuYwo+IGluZGV4IGI4YjU5N2ExMi4uYjBi
ZDM1OWViIDEwMDY0NAo+IC0tLSBhL2xpYi90c3RfYnVmZmVycy5jCj4gKysrIGIvbGliL3RzdF9i
dWZmZXJzLmMKPiBAQCAtNSw2ICs1LDcgQEAKPgo+ICAjaW5jbHVkZSA8c3lzL21tYW4uaD4KPiAg
I2luY2x1ZGUgPHN0ZGxpYi5oPgo+ICsjaW5jbHVkZSA8c3RkaW8uaD4KPiAgI2RlZmluZSBUU1Rf
Tk9fREVGQVVMVF9NQUlOCj4gICNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+Cj4gQEAgLTc2LDYgKzc3
LDI1IEBAIHZvaWQgKnRzdF9hbGxvYyhzaXplX3Qgc2l6ZSkKPiAgICAgICAgIHJldHVybiByZXQg
KyBtYXAtPmJ1Zl9zaGlmdDsKPiAgfQo+Cj4gK2NoYXIgKnRzdF9hcHJpbnRmKGNvbnN0IGNoYXIg
KmZtdCwgLi4uKQo+CgpJIGRpZG4ndCBzZWUgYW55IHBsYWNlIHRvIGludm9rZSB0aGlzIGZ1bmN0
aW9uIGluIHRoZSBwYXRjaHNldCwKZG9lcyBpdCBwcmVwYXJlIGZvciB0aGUgY29taW5nIGNhc2Ug
b3Igb3RoZXJzPwoKQW55d2F5LCB0aGUgd2hvbGUgcGF0Y2ggc2V0IGxvb2tzIHByZXR0eSBnb29k
IHRvIG1lLgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCgo+ICt7
Cj4gKyAgICAgICB2YV9saXN0IHZhOwo+ICsgICAgICAgaW50IGxlbjsKPiArICAgICAgIGNoYXIg
KnJldDsKPiArCj4gKyAgICAgICAgdmFfc3RhcnQodmEsIGZtdCk7Cj4gKyAgICAgICAgbGVuID0g
dnNucHJpbnRmKE5VTEwsIDAsIGZtdCwgdmEpKzE7Cj4gKyAgICAgICAgdmFfZW5kKHZhKTsKPiAr
Cj4gKyAgICAgICByZXQgPSB0c3RfYWxsb2MobGVuKTsKPiArCj4gKyAgICAgICB2YV9zdGFydCh2
YSwgZm10KTsKPiArICAgICAgICB2c3ByaW50ZihyZXQsIGZtdCwgdmEpOwo+ICsgICAgICAgIHZh
X2VuZCh2YSk7Cj4gKwo+ICsgICAgICAgcmV0dXJuIHJldDsKPiArfQo+ICsKPiAgc3RhdGljIGlu
dCBjb3VudF9pb3ZlYyhpbnQgKnNpemVzKQo+ICB7Cj4gICAgICAgICBpbnQgcmV0ID0gMDsKPiBA
QCAtMTE1LDE1ICsxMzUsMTcgQEAgdm9pZCB0c3RfYnVmZmVyc19hbGxvYyhzdHJ1Y3QgdHN0X2J1
ZmZlcnMgYnVmc1tdKQo+ICAgICAgICAgZm9yIChpID0gMDsgYnVmc1tpXS5wdHI7IGkrKykgewo+
ICAgICAgICAgICAgICAgICBpZiAoYnVmc1tpXS5zaXplKQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICooKHZvaWQqKilidWZzW2ldLnB0cikgPSB0c3RfYWxsb2MoYnVmc1tpXS5zaXplKTsKPiAt
ICAgICAgICAgICAgICAgZWxzZQo+ICsgICAgICAgICAgICAgICBlbHNlIGlmIChidWZzW2ldLmlv
dl9zaXplcykKPiAgICAgICAgICAgICAgICAgICAgICAgICAqKCh2b2lkKiopYnVmc1tpXS5wdHIp
ID0KPiB0c3RfaW92ZWNfYWxsb2MoYnVmc1tpXS5pb3Zfc2l6ZXMpOwo+ICsgICAgICAgICAgICAg
ICBlbHNlCj4gKyAgICAgICAgICAgICAgICAgICAgICAgKigodm9pZCoqKWJ1ZnNbaV0ucHRyKSA9
IHRzdF9zdHJkdXAoYnVmc1tpXS5zdHIpOwo+ICAgICAgICAgfQo+ICB9Cj4KPiAgY2hhciAqdHN0
X3N0cmR1cChjb25zdCBjaGFyICpzdHIpCj4gIHsKPiAtICAgICAgIHNpemVfdCBsZW4gPSBzdHJs
ZW4oc3RyKTsKPiAtICAgICAgIGNoYXIgKnJldCA9IHRzdF9hbGxvYyhsZW4gKyAxKTsKPiArICAg
ICAgIGNoYXIgKnJldCA9IHRzdF9hbGxvYyhzdHJsZW4oc3RyKSArIDEpOwo+ICsKPiAgICAgICAg
IHJldHVybiBzdHJjcHkocmV0LCBzdHIpOwo+ICB9Cj4KPiAtLQo+IDIuNDEuMAo+Cj4KPiAtLQo+
IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+
Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
