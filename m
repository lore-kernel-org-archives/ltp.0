Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1755AD6DDD8
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 12:58:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C83B3D76D2
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 13:58:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80F9C3D76B0
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 13:58:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 98F18219FD9
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 13:58:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731675485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+T2rkNoCi4juEtCtza7W+ROj3SOAD5UwWZfyGYXpGDE=;
 b=Yn7DOJjlBvXGbOEAae4OIZE/vdrC8tXVIVwFbPEgqZlKnOIw2XYEVpTyBwV5jfmF2zwB2o
 X/xbT2UkWvqkKmwt94d8DU9obavhtO5NJ1rymHmfbVe52LRK3wnYuWH82RbL1YDd2bwqCy
 y6483hpn8M7Qtp2/pAJBuvCS9DYQSDk=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-zYqV7v8kOcGWBBnjF9jqEQ-1; Fri, 15 Nov 2024 07:58:03 -0500
X-MC-Unique: zYqV7v8kOcGWBBnjF9jqEQ-1
X-Mimecast-MFC-AGG-ID: zYqV7v8kOcGWBBnjF9jqEQ
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-2961a7c2b82so1241434fac.3
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 04:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731675483; x=1732280283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+T2rkNoCi4juEtCtza7W+ROj3SOAD5UwWZfyGYXpGDE=;
 b=Qsu51UBXI6KiSA7l8nq/se6HEwdx4ecmtG4cir7YxHRWz3ZJPAqKxjjwXsR0ChQQpN
 86ecgXC1kx9LRtdEGrA2zQnaM1w4Qf0qsjH+Kj33DnH7r0Q7ykNIE48pUhhypNoInc9R
 Mx1V14hhha/kfJ9sw6fOpeM3JKAZXDaq7Qrv1IyH0N95bqpgtnG/x9Y4ufEHxs8nlURF
 f+lOdIIUv8El/2Eze4SQP+yxlARb2RF6nvkEMP4CA2P9t2DyFqpXVGRshnfZU7s9bUJ6
 Zbrk9iUaCSSdBKhvXf/gfrds5bEqpmmq5K04PMaUnFUhvEh7Dg9REKb/gKHsc0pyhnJs
 5QYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjo7fMjshobn5bDuHLPKBVp7JriPCQUGrhD5Op0aYDVtsSQpeIOoRywxKk8Drao2xxqtE=@lists.linux.it
X-Gm-Message-State: AOJu0YwU4qOvnYvILanZ91xisoYCu+GYHnaB3X8nUD0aOYgrW5crUhTk
 726iokXQNEGbhTrYrF0XyqYowWEXw2tgy4y+O8elxPQcHQDbFo7ii9D8j1ivtbtCKP4S6Q3H/U1
 kB51D5GrdnQLSxvO2ENCyBsj1q9GkY7NSylO2sCtZgWd1LmNbeASx8u8Pn+jRRFjRuF+CgXSbtm
 Msq72TVYnJ27aVSJvtXvDR9a0=
X-Received: by 2002:a05:6871:108:b0:296:13f5:80c with SMTP id
 586e51a60fabf-2962dfe8c7amr2334830fac.26.1731675482785; 
 Fri, 15 Nov 2024 04:58:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAacfhZOh1RltNv5lOyh4zxJKumRSiCbLbQifMiN5cMQ6qr12YyyVwMy+aZXFdEGZTAm+PhSmRBltMHUW9VCQ=
X-Received: by 2002:a05:6871:108:b0:296:13f5:80c with SMTP id
 586e51a60fabf-2962dfe8c7amr2334801fac.26.1731675482258; Fri, 15 Nov 2024
 04:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20241112171831.156440-1-pvorel@suse.cz>
 <20241112171831.156440-2-pvorel@suse.cz>
 <ZzQWRTZTrWWMDNDv@wegao> <20241114145301.GA349678@pevik>
In-Reply-To: <20241114145301.GA349678@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Nov 2024 13:57:44 +0100
Message-ID: <CAASaF6yDG9VfWOzaSbzEMSGq5LXrqkNfLF7UmMcdWNvqmYywtA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J-ZPmcWc12Adx3VsVn1dUxwwQ8471txl58uEgME9UFA_1731675483
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mq_timedreceive01: Workaround segfault on
 libc variant on 32 bit
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

T24gVGh1LCBOb3YgMTQsIDIwMjQgYXQgMzo1M+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+ID4gT24gVHVlLCBOb3YgMTIsIDIwMjQgYXQgMDY6
MTg6MzFQTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90ZToKPiA+ID4gRUZBVUxUIHRlc3Qgc2VnZmF1
bHRzIG9uIG5ld2VyIGtlcm5lbHMgKGUuZy4gNi40KSBvbiBsaWJjIHZhcmlhbnQgb24KPiA+ID4g
MzJiaXQuICBTaW1pbGFybHkgdG8gMWQ0ZDVhMDc1MCB1c2UgdHlwaWNhbCBMVFAgd29ya2Fyb3Vu
ZCB0byB0ZXN0IGJ5Cj4gPiA+IGZvcmtlZCBjaGlsZCArIGNoZWNraW5nIHRoZSB0ZXJtaW5hdGlu
ZyBzaWduYWwuCj4KPiAuLi4KPiA+ID4gKyAgIHVuc2lnbmVkIGludCBqOwo+ID4gPiArICAgdW5z
aWduZWQgaW50IHByaW87Cj4KPiA+ID4gICAgIGlmICh0Yy0+aW52YWxpZF9tc2cpCj4gPiA+ICAg
ICAgICAgICAgIGxlbiAtPSAxOwo+ID4gPiBAQCAtMjA4LDYgKzE5Miw2MCBAQCBzdGF0aWMgdm9p
ZCBkb190ZXN0KHVuc2lnbmVkIGludCBpKQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIFRTVF9S
RVQsIHByaW8sIGxlbik7Cj4gPiA+ICB9Cj4KPiA+ID4gK3N0YXRpYyB2b2lkIHRlc3RfYmFkX2Fk
ZHIodW5zaWduZWQgaW50IGkpCj4gPiA+ICt7Cj4gPiA+ICsgICBzdHJ1Y3QgdGltZTY0X3Zhcmlh
bnRzICp0diA9ICZ2YXJpYW50c1t0c3RfdmFyaWFudF07Cj4gPiA+ICsgICBwaWRfdCBwaWQ7Cj4g
PiA+ICsgICBpbnQgc3RhdHVzOwo+ID4gPiArCj4gPiA+ICsgICBwaWQgPSBTQUZFX0ZPUksoKTsK
PiA+ID4gKyAgIGlmICghcGlkKSB7Cj4gPiA+ICsgICAgICAgICAgIHZlcmlmeV9tcXRfcmVjZWl2
ZShpLCBwaWQpOwo+ID4gPiArICAgICAgICAgICBfZXhpdCgwKTsKPiA+IG5pdDoKPiA+IElmIHRo
aXMgaXMgYSBub3JtYWwgZXhpdCwgaSBzdWdnZXN0IHVzZSBzL19leGl0KDApL2V4aXQoMCkgPwo+
Cj4gSSBjb3B5IHBhc3RlZCB0aGlzIGZyb20gc2ltaWxhciB0ZXN0cy4gSU1ITyBib3RoIHNob3Vs
ZCB3b3JrLiBBY2NvcmRpbmcgdG8gbWFuCj4gZXhpdCgpIGNhbGxzIGZ1bmN0aW9ucyByZWdpc3Rl
cmVkIHdpdGggYXRleGl0KCkgYW5kIF9leGl0KCksIF9leGl0KCkganVzdAo+IGltbWVkaWF0ZWx5
IHRlcm1pbmF0ZXMgdGhlIHByb2Nlc3MuIEFueSBvcGVuIGZpbGUgZGVzY3JpcHRvcnMgYmVsb25n
aW5nIHRvIHRoZSBwcm9jZXNzIGFyZSBjbG9zZWQuCj4KPiBASmFuLCBAQ3lyaWwgUGxlYXNlIGNv
cnJlY3QgbWUgaWYgSSdtIHdyb25nLgoKT3VyIG1haW4gdXNhZ2Ugb2YgX2V4aXQoKSBpcyBzaWdu
YWwgaGFuZGxlcnMsIGJlY2F1c2UgZXhpdCgpIGlzIG5vdAphc3luYy1zaWduYWwtc2FmZS4KZXhp
dCgpIHdpbGwgYWxzbyBmbHVzaCBvcGVuIHN0cmVhbXMsIHdoaWNoIHNlZW1zIGRlc2lyYWJsZSBo
ZXJlLgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiA+ID4gKyAgIH0KPiA+ID4gKwo+ID4g
PiArICAgU0FGRV9XQUlUUElEKHBpZCwgJnN0YXR1cywgMCk7Cj4gPiA+ICsKPiA+ID4gKyAgIGlm
IChXSUZFWElURUQoc3RhdHVzKSAmJiAhV0VYSVRTVEFUVVMoc3RhdHVzKSkKPiA+ID4gKyAgICAg
ICAgICAgcmV0dXJuOwo+ID4gPiArCj4gPiA+ICsgICBpZiAodHYtPnRzX3R5cGUgPT0gVFNUX0xJ
QkNfVElNRVNQRUMgJiYKPiA+ID4gKyAgICAgICAgICAgV0lGU0lHTkFMRUQoc3RhdHVzKSAmJiBX
VEVSTVNJRyhzdGF0dXMpID09IFNJR1NFR1YpIHsKPiA+ID4gKyAgICAgICAgICAgdHN0X3JlcyhU
UEFTUywgIkNoaWxkIGtpbGxlZCBieSBleHBlY3RlZCBzaWduYWwiKTsKPiA+ID4gKyAgICAgICAg
ICAgcmV0dXJuOwo+ID4gPiArICAgfQo+ID4gPiArCj4gPiA+ICsgICB0c3RfcmVzKFRGQUlMLCAi
Q2hpbGQgJXMiLCB0c3Rfc3Ryc3RhdHVzKHN0YXR1cykpOwo+ID4gPiArfQo+IC4uLgo+CgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
