Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE934CF6C11
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767776050; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GHC46mIR4fjyB8mKe/jBgqLjZKWAxZ33Is7GQFrednA=;
 b=VTahIh8RdCiWGI3aI7zDicbjYEYsg2e/q2lfF85YeY1cE/SCcy/b/qLJOAatwUHO5YatJ
 a66ksX8n9aqlVdMENR882GvZ/L58G2IT5X1h2SV3Kmk76SysbTgDuMsPb1aXBtLQKg0D/jV
 Ex1+3rjhAz46W4ejGNBQLg5JsGq5JeQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 551B13C2CC1
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 09:54:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 029233C0756
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 09:53:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 351EC200076
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 09:53:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767776021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlzPlmO5KAVYHMTJh+slOOKt1EX7EnKQIXI0P0G4qdM=;
 b=IWB8uoTPLDXpbmGtg7zSaoUzStnPhKWuZ7Ilgg6bcxH+aKAQfsVzTLFtQrabejdAwTy1aA
 oqBx+5h9WbVhnXZnPc+QwI3SnhW2m+cyC8PCR1nOUAWNnj4EGF+fblb5FMTUvthd4w4Ar1
 biOJsebW9kDf5pmcaSHcWQGRSajCnZs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-pAPCSwgWPY-TKnnSh71C1g-1; Wed, 07 Jan 2026 03:53:40 -0500
X-MC-Unique: pAPCSwgWPY-TKnnSh71C1g-1
X-Mimecast-MFC-AGG-ID: pAPCSwgWPY-TKnnSh71C1g_1767776019
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477b8a667bcso21366765e9.2
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 00:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767776019; x=1768380819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlzPlmO5KAVYHMTJh+slOOKt1EX7EnKQIXI0P0G4qdM=;
 b=Hxr3zfxpfBuD+xAG+9PrFEc2q6SEjGopQyUn64VGCbuHOy6uZ7fBZ/u4ICi8Majr+P
 xpiCELEmOQdWnkDyTwrzkiYvga6o7fq2nIFYd7NYO54Hgyz/txRDPslRA8RE9TbmqGqU
 L70RnhtzSI5LDrCtr6vcJoYmBmxln0LeMkvqYP1eFnN39XeWvkZP56XU8JSU0EA6k9ht
 eSGyPY2sByv4fmovJLUkXasSDPvay6PUicFTHVlBUJvYWPOTwnZw4umQAh6cPPY5WFth
 KH3WbzTttzeLRIqSlw1YQ/Vsyv3D30+tSRdXhX/62m70NzgWoxeHczHGD5WymzoNqa/g
 A+HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVln5NACbrYRLvxdCPWovbhhPjdawFicl1bUqUfZV/XVZ8d0fyhmsgDrjsXBeBG6VyLn+s=@lists.linux.it
X-Gm-Message-State: AOJu0YxnTbkhrlLzvuAO9aWkqXxMp0RN3gaPLfN4BSPE5fjcIdov4LXV
 vVSZOqENpyQCiDK7GGl8dWMhu6ut4LjyrfJXAnhXYFmhZobkcLvbgWGrACs50dBW3w3Btu0e6oj
 pqNZuPMkezWJaF6xDFMd9G97+l7HmUtUoRsOpHweRzhc840BF35f/lKdUb9rnVVmN/Hppf5pM7+
 pfXfYeKkphlIoXZSr+QGJtCJEu3tw=
X-Gm-Gg: AY/fxX47PYHMZacTZMFCsHQ3i5vnc3PXsXBgnnD4OaenRieDNSKqMSora1j5akr/he6
 g4GS1q4MNRZIst7JqxYkzLRhLQJf/bt41R1VZfXrxFOsszaiap46WocMMO+H8G/t5VYSGyweD4+
 gpqPgspe4v1Q4fyMnE/zes9i6ZJzzapT3Dq9QEQekHCxGTOYhIM2gbDsCTdD0MDbW9
X-Received: by 2002:a05:600c:a08:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-47d84b4900bmr15440505e9.30.1767776019068; 
 Wed, 07 Jan 2026 00:53:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYt0DLUfTkyBr6R5l/314PJH5QGqc5Un0PBsXpwMXXz0lUeExc8YGFU7MSWDvIw0qYgITDjYUYUFbUGD/tsHo=
X-Received: by 2002:a05:600c:a08:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-47d84b4900bmr15440125e9.30.1767776018631; Wed, 07 Jan 2026
 00:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20251022020509.6945-1-wegao@suse.com>
 <20251224085004.10267-1-wegao@suse.com>
 <DFGO5L1W0DED.2G5VJDLYAJM7L@suse.com>
 <aVyrMIHYwxncN6J_@autotest-wegao.qe.prg2.suse.org>
 <20260106083947.GA687576@pevik>
In-Reply-To: <20260106083947.GA687576@pevik>
Date: Wed, 7 Jan 2026 09:53:22 +0100
X-Gm-Features: AQt7F2qlr5TPbTXW6hnzpztgcGFmHAD_e0OeC48WS2VSS-MNrypRBzXrYc_yW50
Message-ID: <CAASaF6xBr3q1Wo1h60s3ujUmu_HSw2uuzj7Nob7Z7f_oA_qVxA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EBhKSmVkNu9Kr7k8All7ZtoJFs2xLi0lFpLyhLwmO_g_1767776019
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] io_submit04: Add test case for RWF_NOWAIT flag
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKYW4gNiwgMjAyNiBhdCA5OjM54oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gSGkgYWxsLAo+Cj4gLi4uCj4gPiA+ID4gK3N0YXRpYyB2b2lkIHJ1bih2
b2lkKQo+ID4gPiA+ICt7Cj4gPiA+ID4gKyBzdHJ1Y3QgaW9fZXZlbnQgZXZidWY7Cj4gPiA+ID4g
KyBzdHJ1Y3QgdGltZXNwZWMgdGltZW91dCA9IHsgLnR2X3NlYyA9IDEgfTsKPiA+ID4gPiArIGxv
bmcgbnIgPSAxOwo+ID4gPiA+ICsKPiA+ID4gPiArIFRFU1QodHN0X3N5c2NhbGwoX19OUl9pb19z
dWJtaXQsIGN0eCwgbnIsIGlvY2JzKSk7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgaWYgKFRTVF9SRVQg
PT0gbnIpCj4gPiA+ID4gKyAgICAgICAgIHRzdF9yZXMoVFBBU1MsICJpb19zdWJtaXQoKSBwYXNz
Iik7Cj4gPiA+ID4gKyBlbHNlCj4gPiA+ID4gKyAgICAgICAgIHRzdF9yZXMoVEZBSUwgfCBUVEVS
Uk5PLCAiaW9fc3VibWl0KCkgcmV0dXJucyAlbGQsIGV4cGVjdGVkICVsZCIsIFRTVF9SRVQsIG5y
KTsKPgo+ID4gPiBPdXIgZ29hbCBpcyB0byB2ZXJpZnkgdGhhdCBpb19nZXRldmVudHMoKSByZXR1
cm5zIEVBR0FJTiwgc28gd2UgY2FuIGp1c3Q6Cj4KPiA+ID4gaWYgKFRTVF9SRVQgIT0gbnIpIHsK
PiA+ID4gICAgIHRzdF9yZXMoVEJST0sgfCBUVEVSUk5PLCAiaW9fc3VibWl0KCkgcmV0dXJucyAl
bGQsIGV4cGVjdGVkICVsZCIsIFRTVF9SRVQsIG5yKTsKPiA+ID4gICAgIHJldHVybjsKPiA+ID4g
fQo+Cj4gPiA+IFdlIHJldHVybiBiZWNhdXNlIGlmIGlvX3N1Ym1pdCgpIGZhaWxzIHRoZXJlJ3Mg
bm90aGluZyB0byBkbyBtb3JlLgo+ID4gdHN0X3JlcyhUQlJPSyB3aWxsIHRyaWdnZXIgZXJyb3Ig
c3VjaCBhcyA6Cj4gPiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvd2VnYW8vbHRw
L2xpYicKPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF90
ZXN0Lmg6MjAsCj4gPiAgICAgICAgICAgICAgICAgIGZyb20gaW9fc3VibWl0MDQuYzoxNDoKPiA+
IGlvX3N1Ym1pdDA0LmM6IEluIGZ1bmN0aW9uIOKAmHJ1buKAmToKPiA+IC4uLy4uLy4uLy4uL2lu
Y2x1ZGUvdHN0X2NvbW1vbi5oOjgwOjMyOiBlcnJvcjogc2l6ZSBvZiB1bm5hbWVkIGFycmF5IGlz
IG5lZ2F0aXZlCj4gPiAgICA4MCB8ICAgICAgICAgZG8geyAoKHZvaWQpc2l6ZW9mKGNoYXJbMSAt
IDIgKiAhIShjb25kaXRpb24pXSkpOyB9IHdoaWxlICgwKQo+ID4gICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXgo+ID4gLi4vLi4vLi4vLi4vaW5jbHVkZS90c3RfY29tbW9u
Lmg6ODM6OTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFRTVF9CVUlMRF9CVUdfT07i
gJkKPiA+ICAgIDgzIHwgICAgICAgICBUU1RfQlVJTERfQlVHX09OKGNvbmRpdGlvbikKPiA+ICAg
ICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+Cj4gPiAuLi8uLi8uLi8uLi9pbmNsdWRlL3Rz
dF90ZXN0Lmg6NzE6MTc6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhUU1RfUkVTX1NV
UFBPUlRTX1RDT05GX1RERUJVR19URkFJTF9USU5GT19UUEFTU19UV0FSTuKAmQo+ID4gICAgNzEg
fCAgICAgICAgICAgICAgICAgVFNUX1JFU19TVVBQT1JUU19UQ09ORl9UREVCVUdfVEZBSUxfVElO
Rk9fVFBBU1NfVFdBUk4oXAo+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiA+IGlvX3N1Ym1pdDA0
LmM6NjM6MTc6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJh0c3RfcmVz4oCZCj4gPiAg
ICA2MyB8ICAgICAgICAgICAgICAgICB0c3RfcmVzKFRCUk9LIHwgVFRFUlJOTywgImlvX3N1Ym1p
dCgpIHJldHVybnMgJWxkLCBleHBlY3RlZCAlbGQiLAo+ID4gICAgICAgfCAgICAgICAgICAgICAg
ICAgXn5+fn5+fgo+ID4gbWFrZTogKioqIFsuLi8uLi8uLi8uLi9pbmNsdWRlL21rL3J1bGVzLm1r
OjQ4OiBpb19zdWJtaXQwNF0gRXJyb3IgMQo+ID4gLWJhc2g6IC4vaW9fc3VibWl0MDQ6IE5vIHN1
Y2ggZmlsZSBvciBkaXJlY3RvcnkKPgo+ID4gU28gaSBzdXBwb3NlIHdlIG5lZWQgdXNlICJ0c3Rf
YnJrKFRCUk9LIiB3aXRob3V0IHJldHVybiwgY29ycmVjdD8KPgo+IFllcywgdGhhdCdzIGEgbWFj
cm8gd2hpY2ggZW5mb3JjZXMgdXNpbmcgVEJST0sgb25seSB3aXRoIHRzdF9icmsoKS4KPgo+IEBD
eXJpbCBATGkgQEphbiBJIHdvbmRlciBpZiB3ZSBzdGlsbCBuZWVkIHRoaXMgZW5mb3JjZW1lbnQg
YWZ0ZXIgQ3lyaWwncyBjaGFuZ2UKPiBhMWY4MjcwNGMyICgibGliL3RzdF90ZXN0LmM6IEZpeCB0
c3RfYnJrKCkgaGFuZGxpbmciKQoKTG9va2luZyBhdCBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRzdF9y
ZXNfKCkgYW5kIHRzdF92YnJrXygpICwgdmJya18gaGFzCnNvbWUgYWRkaXRpb25hbCBjbGVhbnVw
IGNhbGxzCnNvIHRoZXkgZG9uJ3QgbG9vayB0byBiZSBleGFjdGx5IGlkZW50aWNhbC4gSSdkIGtl
ZXAgaXQgdG8gZW5jb3VyYWdlCnVzYWdlIG9mIHRzdF9icmsoKSBpZiB5b3UgbmVlZAp0byBhYm9y
dCB0aGUgdGVzdCAoZnJvbSBhbnkgY29udGV4dDogbGlicmFyeSwgdGVzdCwgdGVzdCBjaGlsZHJl
bikuCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
