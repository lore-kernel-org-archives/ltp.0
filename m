Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD75CC021BB
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 01:15:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C8AD3C9CA9
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 02:15:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52F503C2157
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 02:15:29 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=chwen@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A776662A13A
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 02:15:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740532526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtL1x0EB25BIiQk0IpPkUAcWMr6PN9s8W8nBp2jQKC8=;
 b=EqtUaUDlTiy/mkCSZQG8cbYR7bA1vYJJQv8Pwx5pNrhzNzCul7r+EjL5hLtj2E4eWvAwwv
 88wtkqs330YDlfiHe35J3/WET3gRlNeGlcE84CSaRdktOOOvcr6MEaaqz///LpOM0pOVpp
 Sgc/bACAbvy9n1Td46FZdLYHTWrLCOg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-GDriQHR3Paq-t-oaKHuC5A-1; Tue, 25 Feb 2025 20:15:24 -0500
X-MC-Unique: GDriQHR3Paq-t-oaKHuC5A-1
X-Mimecast-MFC-AGG-ID: GDriQHR3Paq-t-oaKHuC5A_1740532524
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e572cd106f7so7854664276.3
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 17:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740532523; x=1741137323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dtL1x0EB25BIiQk0IpPkUAcWMr6PN9s8W8nBp2jQKC8=;
 b=jKjhsYicwd7Emm+cMKD/RSJMU3mcPF8i/GR6qQE7or43HrEiP4CvJ2BtINjMG+TsjE
 37+f771d6YI6JbK6V2V5UpiWRCH7JEhLt2U1RL++7dwnCw45kmNM8eOXbnmt6L5y88v3
 RTJgmpREujSK68aJocRnnHgFKj93/Ac3E3zfvdXj/02HidMz8xK7+rEF5ZuEcYM+4pYU
 J0KgbNS4cZneUzIuRsGQ/LkszuC7opnHwtnK0pi7eYz6YR4I8ijzKIiLDRzH0wdsP4eP
 X9jQ3emDRIxe3Yi2WCx6/tx2VXDv6OKgNlO0ITsJv8cXY7xdEtFWTCED7l7SJ6Sjg0uw
 6Qjg==
X-Gm-Message-State: AOJu0YxeaJg/ZNJ7AAOI2axOpVHuZCI+96uce/3/mcq7Tg80KNrrd3QR
 JKJANkRRI1YtVYgRMTMFeo/Vwe+M2bYFY3Nu4XiUx6ZONaPhlL0GofDLlpk2adFQRfqyRnxI6uv
 TcmLgXpDJQm+nLMIOFlbXi2aF6w8UcMlDp2e/myiGr0TK0WTerr9iCl4Ttk9D4BeKfOSlz6GVXw
 m+ji9SMFtpmaLwV/eLFlJbSVhQnY/nIu/n5g==
X-Gm-Gg: ASbGncsKDm0vsZcQ4QyepEr2o4aXKFLnGLb8DYueBTlB6iueClCKyXjvAJ5dHR5DzaE
 iKC/ls0PEebMJNjekk7G9zxWfXbTFliIap19ccEWvA0qoeuMUQcLH6Mf7BDs1op7WffYy6NpY2w
 ==
X-Received: by 2002:a05:6902:cc4:b0:e5e:23b1:cc23 with SMTP id
 3f1490d57ef6-e5e86452c21mr14614671276.4.1740532523035; 
 Tue, 25 Feb 2025 17:15:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE6E8zkYRuOIdjjyALRG8/ieJ+m37hu8Hq58IdLCgFv4JJJVVST2nku+7C1ehDGu15W57RivjMfOsXndsgg1U=
X-Received: by 2002:a05:6902:cc4:b0:e5e:23b1:cc23 with SMTP id
 3f1490d57ef6-e5e86452c21mr14614660276.4.1740532522673; Tue, 25 Feb 2025
 17:15:22 -0800 (PST)
MIME-Version: 1.0
References: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
 <20250224030743.1567840-1-chwen@redhat.com>
In-Reply-To: <20250224030743.1567840-1-chwen@redhat.com>
From: Chunfu Wen <chwen@redhat.com>
Date: Wed, 26 Feb 2025 09:15:10 +0800
X-Gm-Features: AWEUYZnxKxUouPyVA8amGfbvoRRyeZWxjvlJkYeHTMEgfECm_0buL-KeEH6puAY
Message-ID: <CAAA2g-1m5Hfq9nygiCnFFwt6Axgxjj3dO=2Ei_-cgSw3dT60Bg@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d0mUiwy0qNqDXFdq_sF7ZA4Q0IOM2tZypjmBV_ktZsc_1740532524
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Add test case to cover the setting resource
 limit64 for process
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
Cc: Charles Shi <cheshi@redhat.com>, Li Wang <liwan@redhat.com>,
 Irene Diez <idiez@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gTWFpbnRhaW5lcnMsCgpDb3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgcmV2aWV3IHRoZSBW
NCBwYXRjaCB3aGVuIHlvdSBoYXZlIHRpbWU/CgpCZXN0IFJlZ2FyZHMsCgpDaHVuZnUgV2VuCgoK
T24gTW9uLCBGZWIgMjQsIDIwMjUgYXQgMTE6MDfigK9BTSBDaHVuZnUgV2VuIDxjaHdlbkByZWRo
YXQuY29tPiB3cm90ZToKCj4gRnJvbTogY2h1bmZ1d2VuIDxjaHdlbkByZWRoYXQuY29tPgo+Cj4g
VGhlIHRlc3QgZW5zdXJlcyB0aGF0IHRoZSBwcm9jZXNzIGdldHMgdGhlIGNvcnJlY3Qgc2lnbmFs
cyBpbiB0aGUgY29ycmVjdAo+IG9yZGVyOgo+Cj4gRmlyc3QsIGl0IHNob3VsZCBnZXQgU0lHWENQ
VSBhZnRlciByZWFjaGluZyB0aGUgc29mdCBDUFUgdGltZSBsaW1pdDY0Lgo+IFRoZW4sIGlmIHRo
ZSBDUFUgdGltZSBleGNlZWRzIHRoZSBoYXJkIGxpbWl0LCBpdCBzaG91bGQgcmVjZWl2ZSBTSUdL
SUxMCj4KPiBTaWduZWQtb2ZmLWJ5OiBjaHVuZnV3ZW4gPGNod2VuQHJlZGhhdC5jb20+Cj4gLS0t
Cj4gIGluY2x1ZGUvbGFwaS9yZXNvdXJjZS5oICAgICAgICAgICAgICAgICAgICAgICB8IDI4ICsr
KysrKysrKysrKwo+ICAuLi4va2VybmVsL3N5c2NhbGxzL3NldHJsaW1pdC9zZXRybGltaXQwNi5j
ICAgfCA0NCArKysrKysrKysrKysrKy0tLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0
aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xh
cGkvcmVzb3VyY2UuaAo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9yZXNvdXJjZS5oIGIv
aW5jbHVkZS9sYXBpL3Jlc291cmNlLmgKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAw
MDAwMDAwMC4uYTliYzU3YTBhCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2luY2x1ZGUvbGFwaS9y
ZXNvdXJjZS5oCj4gQEAgLTAsMCArMSwyOCBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUgUmVkIEhh
dCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCj4gKyAqIEF1dGhvcjogQ2h1bmZ1IFdlbiA8Y2h3
ZW5AcmVkaGF0LmNvbT4KPiArICovCj4gKwo+ICsjaWZuZGVmIExBUElfUkVTT1VSQ0VfSF9fCj4g
KyNkZWZpbmUgTEFQSV9SRVNPVVJDRV9IX18KPiArCj4gKyNkZWZpbmUgX0dOVV9TT1VSQ0UKPiAr
Cj4gKyNpbmNsdWRlICJjb25maWcuaCIKPiArI2luY2x1ZGUgPHN5cy9yZXNvdXJjZS5oPgo+ICsj
aW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIgo+ICsKPiArI2lmbmRlZiBIQVZFX1NUUlVDVF9STElN
SVQ2NAo+ICtzdHJ1Y3QgcmxpbWl0NjQgewo+ICsgICAgICAgIHVpbnQ2NF90IHJsaW1fY3VyOwo+
ICsgICAgICAgIHVpbnQ2NF90IHJsaW1fbWF4Owo+ICt9Owo+ICsjZW5kaWYKPiArCj4gK3N0YXRp
YyBpbnQgc2V0cmxpbWl0X3U2NChpbnQgcmVzb3VyY2UsIGNvbnN0IHN0cnVjdCBybGltaXQ2NCAq
cmxpbSkKPiArewo+ICsgICAgICAgIHJldHVybiB0c3Rfc3lzY2FsbChfX05SX3BybGltaXQ2NCwg
MCwgcmVzb3VyY2UsIHJsaW0sIE5VTEwpOwo+ICt9Cj4gKwo+ICsjZW5kaWYgLyogTEFQSV9SRVNP
VVJDRV9IX18gKi8KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRy
bGltaXQvc2V0cmxpbWl0MDYuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRybGlt
aXQvc2V0cmxpbWl0MDYuYwo+IGluZGV4IDlmZjUxNWQ4MS4uZGVkNTUwOTczIDEwMDY0NAo+IC0t
LSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0cmxpbWl0L3NldHJsaW1pdDA2LmMKPiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHJsaW1pdC9zZXRybGltaXQwNi5jCj4g
QEAgLTQsMTIgKzQsMTIgQEAKPiAgICogQXV0aG9yOiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGNuLmZ1
aml0c3UuY29tPgo+ICAgKi8KPgo+IC0vKgo+IC0gKiBEZXNjcmlwdGlvbjoKPiArLypcCj4gICAq
IFNldCBDUFUgdGltZSBsaW1pdCBmb3IgYSBwcm9jZXNzIGFuZCBjaGVjayBpdHMgYmVoYXZpb3IK
PiAtICogYWZ0ZXIgcmVhY2hpbmcgQ1BVIHRpbWUgbGltaXQuCj4gLSAqIDEpIFByb2Nlc3MgZ290
IFNJR1hDUFUgYWZ0ZXIgcmVhY2hpbmcgc29mdCBsaW1pdCBvZiBDUFUgdGltZS4KPiAtICogMikg
UHJvY2VzcyBnb3QgU0lHS0lMTCBhZnRlciByZWFjaGluZyBoYXJkIGxpbWl0IG9mIENQVSB0aW1l
Lgo+ICsgKiBhZnRlciByZWFjaGluZyBDUFUgdGltZSBsaW1pdAo+ICsgKgo+ICsgKiAtIFByb2Nl
c3MgZ290IFNJR1hDUFUgYWZ0ZXIgcmVhY2hpbmcgc29mdCBsaW1pdCBvZiBDUFUgdGltZQo+ICsg
KiAtIFByb2Nlc3MgZ290IFNJR0tJTEwgYWZ0ZXIgcmVhY2hpbmcgaGFyZCBsaW1pdCBvZiBDUFUg
dGltZQo+ICAgKgo+ICAgKiBOb3RlOgo+ICAgKiBUaGlzIGlzIGFsc28gYSByZWdyZXNzaW9uIHRl
c3QgZm9yIHRoZSBmb2xsb3dpbmcga2VybmVsIGJ1ZzoKPiBAQCAtMjcsNiArMjcsMTIgQEAKPiAg
I2luY2x1ZGUgPHN5cy9tbWFuLmg+Cj4KPiAgI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gKyNpbmNs
dWRlICJsYXBpL3Jlc291cmNlLmgiCj4gKwo+ICsjZGVmaW5lIFRFU1RfVkFSSUFOVFMgMgo+ICsK
PiArc3RhdGljIHN0cnVjdCBybGltaXQgKnJsaW07Cj4gK3N0YXRpYyBzdHJ1Y3QgcmxpbWl0NjQg
KnJsaW1fNjQ7Cj4KPiAgc3RhdGljIGludCAqZW5kOwo+Cj4gQEAgLTM3LDYgKzQzLDExIEBAIHN0
YXRpYyB2b2lkIHNpZ2hhbmRsZXIoaW50IHNpZykKPgo+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lk
KQo+ICB7Cj4gKyAgICAgICBybGltLT5ybGltX2N1ciA9IDE7Cj4gKyAgICAgICBybGltLT5ybGlt
X21heCA9IDI7Cj4gKyAgICAgICBybGltXzY0LT5ybGltX2N1ciA9IDE7Cj4gKyAgICAgICBybGlt
XzY0LT5ybGltX21heCA9IDI7Cj4gKwo+ICAgICAgICAgU0FGRV9TSUdOQUwoU0lHWENQVSwgc2ln
aGFuZGxlcik7Cj4KPiAgICAgICAgIGVuZCA9IFNBRkVfTU1BUChOVUxMLCBzaXplb2YoaW50KSwg
UFJPVF9SRUFEIHwgUFJPVF9XUklURSwKPiBAQCAtNTgsMTIgKzY5LDE0IEBAIHN0YXRpYyB2b2lk
IHZlcmlmeV9zZXRybGltaXQodm9pZCkKPgo+ICAgICAgICAgcGlkID0gU0FGRV9GT1JLKCk7Cj4g
ICAgICAgICBpZiAoIXBpZCkgewo+IC0gICAgICAgICAgICAgICBzdHJ1Y3QgcmxpbWl0IHJsaW0g
PSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgLnJsaW1fY3VyID0gMSwKPiAtICAgICAgICAg
ICAgICAgICAgICAgICAucmxpbV9tYXggPSAyLAo+IC0gICAgICAgICAgICAgICB9Owo+IC0KPiAt
ICAgICAgICAgICAgICAgVEVTVChzZXRybGltaXQoUkxJTUlUX0NQVSwgJnJsaW0pKTsKPiArICAg
ICAgICAgICAgICAgc3dpdGNoICh0c3RfdmFyaWFudCkgewo+ICsgICAgICAgICAgICAgICBjYXNl
IDA6Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgVEVTVChzZXRybGltaXQoUkxJTUlUX0NQVSwg
cmxpbSkpOwo+ICsgICAgICAgICAgICAgICBicmVhazsKPiArICAgICAgICAgICAgICAgY2FzZSAx
Ogo+ICsgICAgICAgICAgICAgICAgICAgICAgIFRFU1Qoc2V0cmxpbWl0X3U2NChSTElNSVRfQ1BV
LCBybGltXzY0KSk7Cj4gKyAgICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICB9
Cj4gICAgICAgICAgICAgICAgIGlmIChUU1RfUkVUID09IC0xKSB7Cj4gICAgICAgICAgICAgICAg
ICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRURVJSTk8sCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAic2V0cmxpbWl0KFJMSU1JVF9DUFUpIGZhaWxlZCIpOwo+IEBAIC03Miw3ICs4
NSw4IEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9zZXRybGltaXQodm9pZCkKPgo+ICAgICAgICAgICAg
ICAgICBhbGFybSgyMCk7Cj4KPiAtICAgICAgICAgICAgICAgd2hpbGUgKDEpOwo+ICsgICAgICAg
ICAgICAgICB3aGlsZSAoMSkKPiArICAgICAgICAgICAgICAgICAgICAgICA7Cj4gICAgICAgICB9
Cj4KPiAgICAgICAgIFNBRkVfV0FJVFBJRChwaWQsICZzdGF0dXMsIDApOwo+IEBAIC0xMTIsNiAr
MTI2LDEyIEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9zZXRybGltaXQodm9pZCkKPiAgc3RhdGljIHN0
cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgLnRlc3RfYWxsID0gdmVyaWZ5X3NldHJs
aW1pdCwKPiAgICAgICAgIC5zZXR1cCA9IHNldHVwLAo+ICsgICAgICAgLnRlc3RfdmFyaWFudHMg
PSBURVNUX1ZBUklBTlRTLAo+ICsgICAgICAgLmJ1ZnMgPSAoc3RydWN0IHRzdF9idWZmZXJzIFtd
KSB7Cj4gKyAgICAgICAgICAgICAgIHsmcmxpbSwgLnNpemUgPSBzaXplb2YoKnJsaW0pfSwKPiAr
ICAgICAgICAgICAgICAgeyZybGltXzY0LCAuc2l6ZSA9IHNpemVvZigqcmxpbV82NCl9LAo+ICsg
ICAgICAgICAgICAgICB7fQo+ICsgICAgICAgfSwKPiAgICAgICAgIC5jbGVhbnVwID0gY2xlYW51
cCwKPiAgICAgICAgIC5mb3Jrc19jaGlsZCA9IDEsCj4gICAgICAgICAudGFncyA9IChjb25zdCBz
dHJ1Y3QgdHN0X3RhZ1tdKSB7Cj4gLS0KPiAyLjQzLjUKPgo+CgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
