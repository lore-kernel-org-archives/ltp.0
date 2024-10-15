Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA77CFC293
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 11:51:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4813C3C66BF
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 13:51:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E24903C65EA
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 13:51:31 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 180AE1000D19
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 13:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728993089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3oh9eR7iYJ6Sd8TdotQ1fEMJSZpQ+Y21GJ8t2IEjy4=;
 b=aK0nT/D89WhvE6cru6vJhhW2WKjk/cFOEPy5GIzUZ1Fqyy/ZU3SBIjqx6pLwTRkDSsyOlU
 /MlO4RBpiuu65F8643tVGQ00BXwjY+mVvx5I7b5qaP+pPr/fBN8PwvVNZ2XMgA0vj8ArAM
 JAXnalhTsw3RquXwIc6wDywA0ATFMGI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-7sLUgcFYONSrAD3rPNVfww-1; Tue, 15 Oct 2024 07:51:27 -0400
X-MC-Unique: 7sLUgcFYONSrAD3rPNVfww-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5e56a096565so1550860eaf.2
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 04:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728993087; x=1729597887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3oh9eR7iYJ6Sd8TdotQ1fEMJSZpQ+Y21GJ8t2IEjy4=;
 b=JJxaZ53kKjL30I8tL9quERR1qfXFmDtswyJWro1p62K6nSfi8u/ENZrzW+g0J2+GDL
 fWOWXliLjhTwxzGVJKvPR5tneAh2skSzaqcJgi2O+ZkUiCFhzM62spLmOLZ4omVIBkBS
 WypCp8yjgcmq9esZCR474SL2cZwiyaFtretlTaSmhxieO7ubWXX3Y7UPsgYjlRxt1OQa
 P4gWjRDvQ13oDklGr0EnjmQ3H5ystJ2EHwK6kRVGjg8nQs+t3EiQXp1OtsrVeQkKdA9m
 gl8NIXvIiq+VfIxGv4AIHJbUBgG54Cgjz+/uY2xxrAn6E15pedszKt69/p+VJUxvVt3K
 M7tA==
X-Gm-Message-State: AOJu0YwR4gPPK9H6faEhhkgE1/HwJ7pI8HoEbnOZQcpfVnWGV4bGurCd
 dnbhSRPxNO8tgWPc6p3nnbuDZaytGnqPMaujPIuXAcwgAUXlS7bsdwKKjimXnWyKhojWn0dV8tB
 nvnZnA9krONvjIX5KjOjNp40L/9l6Ph0rs7T89d1zLM0/uUAtMTUZuwAs5bahjfEIaDNxClcbOP
 k8aD51moELjYZivgisXoBF6xCGuHa3PWg=
X-Received: by 2002:a05:6870:ec8b:b0:288:5ae1:7318 with SMTP id
 586e51a60fabf-28887376af2mr5963218fac.22.1728993087097; 
 Tue, 15 Oct 2024 04:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIgY8dmVlSHpL1JWZ9vpZWw/aXfcFesJKSHYV5MSZc7rcFyPkKhOAzLUA5vb/B9ydWTOx+vUAyfXHL6s4+z0I=
X-Received: by 2002:a05:6870:ec8b:b0:288:5ae1:7318 with SMTP id
 586e51a60fabf-28887376af2mr5963215fac.22.1728993086812; Tue, 15 Oct 2024
 04:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
 <Zw46_xyBaWFPMShv@yuki.lan>
 <CAASaF6wY8AHH76YVf+UtJrcXtRL9d+UcR4rDf6S96EJiroPnKg@mail.gmail.com>
 <Zw5LLGMX0R9qKfRM@yuki.lan>
In-Reply-To: <Zw5LLGMX0R9qKfRM@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Oct 2024 13:51:10 +0200
Message-ID: <CAASaF6wzPrDqgkS2odZVMXHP7fJzH3EpUuUEf1S3qbm4WHH9LQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statmount07: drop "invalid buffer size"
 test
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

T24gVHVlLCBPY3QgMTUsIDIwMjQgYXQgMTowMeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gPiA+IFRoaXMgY2hlY2sgcmVsaWVzIG9uIGFjY2Vz
c19vaygpIGNoZWNrLCB3aGljaCBjYW4gYmUgc2tpcHBlZAo+ID4gPiA+IG9uIHNvbWUgYXJjaGVz
L2NvbmZpZ3MsIGZvciBleGFtcGxlIG9uIHMzOTB4IHdpdGgKPiA+ID4gPiBDT05GSUdfQUxURVJO
QVRFX1VTRVJfQUREUkVTU19TUEFDRT15LiBUZXN0IHRoZW4gZmFpbHMgd2l0aDoKPiA+ID4gPiAg
IHN0YXRtb3VudDA3LmM6MTE3OiBURkFJTDogaW52YWxpZCBidWZmZXIgc2l6ZSBzdWNjZWVkZWQK
PiA+ID4KPiA+ID4gQW5kIGRvZXMgaXQgZmFpbCBsYXRlciBvbiBpbiB0aGUgY29weV90b191c2Vy
KCkgaWYgdGhlIGJ1ZmZlciBpcwo+ID4gPiBwaHlzaWNhbGx5IG5vdCBhY2Nlc2libGU/Cj4gPiA+
Cj4gPiA+IFdlIG1heSBhZGQgYSB0ZXN0IHRoYXQgd291bGQgbG9vayBsaWtlOgo+ID4gPgo+ID4g
PiB8IHBhZ2UgbWFwcGVkIHJ3IHwgcGFnZSBtYXBwZWQgcmVhZCBvbmx5IHwKPiA+ID4gICAgICAg
ICAgICAgIF4KPiA+ID4gICAgICAgICAgICAgIGJ1ZiBwb2ludGVyIHN0YXJ0cyBoZXJlCj4gPiA+
Cj4gPiA+IFdoYXQgZG8geW91IHRoaW5rPwo+ID4KPiA+IHdlIGNhbiBhZGQgdGhhdCwgaXQgd291
bGQgYmUgdmFyaWF0aW9uIG9mICJpbnZhbGlkIGJ1ZmZlciBwb2ludGVyIiB0ZXN0Cj4KPiBMb29r
aW5nIGF0IGtlcm5lbCBfX2NoZWNrX29iamVjdF9zaXplKCkgdGhlcmUgc2VlbXMgdG8gYmUgYSBz
cGVjaWFsIGNhc2UKPiBmb3IgYSBOVUxMIHBvaW50ZXIgaW4gY2hlY2tfYm9ndXNfYWRkcmVzcygp
LiBUaGUgcGFydCB0aGF0IHdvdWxkIGNoZWNrCj4gaWYgdGhlIHBhZ2UgaXMgd3JpdGVhYmxlIGlz
IGRvbmUgbGF0ZXIuIFRoZXJlIGFyZSBzb21lIGNoZWNrcyBpbgo+IGNoZWNrX2hlYXBfb2JqZWN0
KCkgYnV0IEknbSBub3QgMTAwJSBzdXJlIHdoYXQgdGhlc2UgZG8uIElmIEknbSByZWFkaW5nCj4g
aXQgcmlnaHQgaXQgd2lsbCBhYm9ydCB0aGUgb3BlcmF0aW9uIGlmIHRoZSBtZW1vcnkgaXMgbm90
IG9uZSBjb250aW51b3VzCj4gdm1hLCB3aGljaCBpcyBwcm9iYWJseSB0aGUgY2FzZSBpZiB3ZSBo
YXZlIHR3byBwYWdlcyB3aXRoIGRpZmZlcmVudAo+IGFjY2VzcyBuZXh0IHRvIGVhY2ggb3RoZXIu
CgpBcmVuJ3QgYWxsIHRob3NlIGNoZWNrcyBmb3IgdGhlICJmcm9tIiBhZGRyZXNzPyBXZSBvbmx5
IGNhcmUgYWJvdXQgInRvIiwKd2hlbiBjb3B5aW5nIHRvIHVzZXItc3BhY2UuIEkgc2VudCB2MiB3
aXRoIHlvdXIgc3VnZ2VzdGlvbiB0byB1c2UgYSBidWZmZXIKdGhhdCBjcm9zc2VzIGludG8gUFJP
VF9OT05FLgoKPgo+IEl0IG1heSBiZSBpbnRlcmVzdGluZyB0byBnbyBvdmVyIHRoZSBjb3B5X3Rv
X3VzZXIoKSBjb2RlIHdpdGggc29tZW9uZQo+IHdobyB1bmRlcnN0YW5kcyBtbSBhbmQgZmluZCBh
IGZldyBjYXNlcyB0byB0ZXN0Lgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2Uu
Y3oKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
