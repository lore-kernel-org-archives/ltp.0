Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2BFD6DDF8
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 13:13:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1A3E3D76DA
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 14:13:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61B9A3D7649
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 14:13:32 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 435BD62FB87
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 14:13:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731676409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkn5YizQSF9gzFXdrkROu5vPTUJ1s1hU192nIGE0l1M=;
 b=KYqvwZ0TsN99EF2wGhK7gTsDXMeyx0A5NnxM5l8rd4W1PjsYGQEdEuZ3fk+A2lwBRl24Yo
 oFpYmfn/fdtGxi6hB0/N3wBok3HHZ5ZRQS6ZJ3VgcLdRDtaiypxFxyXpLWzJxxIXXLQOOe
 Bs3Sp7GqWMGrBfnOG8jZbmh9Thn3g9k=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-Gg-K_SrhPoOT_W6S8wp5sA-1; Fri, 15 Nov 2024 08:13:27 -0500
X-MC-Unique: Gg-K_SrhPoOT_W6S8wp5sA-1
X-Mimecast-MFC-AGG-ID: Gg-K_SrhPoOT_W6S8wp5sA
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-296207afc2dso723212fac.0
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 05:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731676407; x=1732281207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkn5YizQSF9gzFXdrkROu5vPTUJ1s1hU192nIGE0l1M=;
 b=hHTCo+xOppJPMbnjIgO3nTF6yIRG+fGNp6mWDTv21940aE0vn9iOYPdjw9QaGRe2rV
 Q3Jvwx4M1/kqB01Yr0kvyoQPkvDYTlH9nD7q/COB5MpzYkFND76SwSQSLx3SVUpBF8Mm
 cfDEZebswUaYpxUTlvWkEi3/OO85Zn+EoxKeG24MlVfbAcXVhdxGw/UdzjFKgzTbb6n/
 v54PyHNtzWpc7fVchJY73s+T6dkJ71fZkfcJaDQcfGq/HbEpVXFmAohj9dcLG+Rxy3nH
 2an5q08xjhEXAFkWutscg39vIhn5Q3HflffSp30J4WsnaDTXlaoaMSmthTHKvoBRX5kx
 gvQA==
X-Gm-Message-State: AOJu0YxrAm+Ntx5TFrTDbyoasqWrzH62j6fE9ch/L+kGADJkQcp47wc5
 NMNtuT1gFsTXMg7GQqWO1vsD1R+mb6nMyY0rAtA5AyMhGhnG+GlQ4KFZ3dWA/7Ixt+vHO1wiuEM
 Lqsb/ANdS5PYE55+WcNbhf9GIonHMEvxNqd2NOUltE2Jwq4I0O2qD1HcHsSAAKfsIzaIsOpk2wz
 5yNiEGXxt5WPpgqjO/PwWF17g=
X-Received: by 2002:a05:6871:5824:b0:288:b007:2fc0 with SMTP id
 586e51a60fabf-2962dd5abfbmr2346768fac.13.1731676407148; 
 Fri, 15 Nov 2024 05:13:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPV5X9bKh0dKNt2gN+8doCtnRpJL2zhUXPcOVT6cuYhOe7Ig4fj98/oOtxGoB8d7UZL1T79Bq2VD1HD+zYbio=
X-Received: by 2002:a05:6871:5824:b0:288:b007:2fc0 with SMTP id
 586e51a60fabf-2962dd5abfbmr2346751fac.13.1731676406832; Fri, 15 Nov 2024
 05:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20241114144029.349559-1-pvorel@suse.cz>
 <20241114144029.349559-4-pvorel@suse.cz>
In-Reply-To: <20241114144029.349559-4-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Nov 2024 14:13:09 +0100
Message-ID: <CAASaF6z3quzaFkgo47SZgpPxK=Ny_2f3C07LR7=8eVFrTa6CfQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7m5jIhO2iOwgp_3FDa1VSiGwaBfsm6bZ2b4ZfN8SNUA_1731676407
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] mq_timedsend01: Workaround segfault on libc
 variant on 32 bit
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

T24gVGh1LCBOb3YgMTQsIDIwMjQgYXQgMzo0MOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEVGQVVMVCB0ZXN0IHNlZ2ZhdWx0cyBvbiBuZXdlciBrZXJuZWxzIChl
LmcuIDYuNCkgb24gbGliYyB2YXJpYW50IG9uCj4gMzJiaXQuICBTaW1pbGFybHkgdG8gMWQ0ZDVh
MDc1MCB1c2UgdHlwaWNhbCBMVFAgd29ya2Fyb3VuZCB0byB0ZXN0IGJ5Cj4gZm9ya2VkIGNoaWxk
ICsgY2hlY2tpbmcgdGhlIHRlcm1pbmF0aW5nIHNpZ25hbC4KPgo+IFNpZ25lZC1vZmYtYnk6IFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IC0tLQo+ICAuLi4vc3lzY2FsbHMvbXFfdGltZWRz
ZW5kL21xX3RpbWVkc2VuZDAxLmMgICAgfCA4NyArKysrKysrKysrKysrKy0tLS0tCj4gIDEgZmls
ZSBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21xX3RpbWVkc2VuZC9tcV90aW1lZHNlbmQw
MS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tcV90aW1lZHNlbmQvbXFfdGltZWRzZW5k
MDEuYwo+IGluZGV4IDM1YmY0NDQ1ZjUuLjJjZWM3NDlmNDggMTAwNjQ0Cj4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9tcV90aW1lZHNlbmQvbXFfdGltZWRzZW5kMDEuYwo+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXFfdGltZWRzZW5kL21xX3RpbWVkc2VuZDAxLmMK
PiBAQCAtMTQzLDM0ICsxNDMsMTUgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAgICAgICAg
IHNldHVwX2NvbW1vbigpOwo+ICB9Cj4KPiAtc3RhdGljIHZvaWQgZG9fdGVzdCh1bnNpZ25lZCBp
bnQgaSkKPiArc3RhdGljIHZvaWQgdmVyaWZ5X21xdF9zZW5kX3JlY2VpdmUodW5zaWduZWQgaW50
IGksIHBpZF90IHBpZCkKPiAgewo+ICAgICAgICAgc3RydWN0IHRpbWU2NF92YXJpYW50cyAqdHYg
PSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRdOwo+ICAgICAgICAgY29uc3Qgc3RydWN0IHRlc3RfY2Fz
ZSAqdGMgPSAmdGNhc2VbaV07Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgajsKPiAgICAgICAgIHVu
c2lnbmVkIGludCBwcmlvOwo+IC0gICAgICAgc2l6ZV90IGxlbiA9IE1BWF9NU0dTSVpFOwo+IC0g
ICAgICAgY2hhciBybXNnW2xlbl07Cj4gLSAgICAgICBwaWRfdCBwaWQgPSAtMTsKPiArICAgICAg
IGNoYXIgcm1zZ1tNQVhfTVNHU0laRV07Cj4gICAgICAgICB2b2lkICptc2dfcHRyLCAqYWJzX3Rp
bWVvdXQ7Cj4KPiAtICAgICAgIHRzdF90c19zZXRfc2VjKCZ0cywgdGMtPnR2X3NlYyk7Cj4gLSAg
ICAgICB0c3RfdHNfc2V0X25zZWMoJnRzLCB0Yy0+dHZfbnNlYyk7Cj4gLQo+IC0gICAgICAgaWYg
KHRjLT5zaWduYWwpCj4gLSAgICAgICAgICAgICAgIHBpZCA9IHNldF9zaWcodGMtPnJxLCB0di0+
Y2xvY2tfZ2V0dGltZSk7Cj4gLQo+IC0gICAgICAgaWYgKHRjLT50aW1lb3V0KQo+IC0gICAgICAg
ICAgICAgICBzZXRfdGltZW91dCh0Yy0+cnEsIHR2LT5jbG9ja19nZXR0aW1lKTsKPiAtCj4gLSAg
ICAgICBpZiAodGMtPnNlbmQpIHsKPiAtICAgICAgICAgICAgICAgZm9yIChqID0gMDsgaiA8IE1T
R19MRU5HVEg7IGorKykKPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodHYtPm1xdF9zZW5k
KCp0Yy0+ZmQsIHNtc2csIHRjLT5sZW4sIHRjLT5wcmlvLCBOVUxMKSA8IDApIHsKPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwgfCBUVEVSUk5PLCAibXFfdGlt
ZWRzZW5kKCkgZmFpbGVkIik7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm47Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgfQo+IC0gICAgICAgfQo+IC0KPiAgICAgICAg
IGlmICh0Yy0+YmFkX21zZ19hZGRyKQo+ICAgICAgICAgICAgICAgICBtc2dfcHRyID0gYmFkX2Fk
ZHI7Cj4gICAgICAgICBlbHNlCj4gQEAgLTIwMCw3ICsxODEsNyBAQCBzdGF0aWMgdm9pZCBkb190
ZXN0KHVuc2lnbmVkIGludCBpKQo+ICAgICAgICAgICAgICAgICByZXR1cm47Cj4gICAgICAgICB9
Cj4KPiAtICAgICAgIFRFU1QodHYtPm1xdF9yZWNlaXZlKCp0Yy0+ZmQsIHJtc2csIGxlbiwgJnBy
aW8sIHRzdF90c19nZXQodGMtPnJxKSkpOwo+ICsgICAgICAgVEVTVCh0di0+bXF0X3JlY2VpdmUo
KnRjLT5mZCwgcm1zZywgTUFYX01TR1NJWkUsICZwcmlvLCB0c3RfdHNfZ2V0KHRjLT5ycSkpKTsK
Pgo+ICAgICAgICAgaWYgKCp0Yy0+ZmQgPT0gZmQpCj4gICAgICAgICAgICAgICAgIGNsZWFudXBf
cXVldWUoZmQpOwo+IEBAIC0yNDEsOCArMjIyLDY2IEBAIHN0YXRpYyB2b2lkIGRvX3Rlc3QodW5z
aWduZWQgaW50IGkpCj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgIH0KPgo+IC0gICAgICAg
dHN0X3JlcyhUUEFTUywgIm1xX3RpbWVkcmVjZWl2ZSgpIHJldHVybmVkICVsZCwgcHJpb3JpdHkg
JXUsIGxlbmd0aDogJXp1IiwKPiAtICAgICAgICAgICAgICAgICAgICAgICBUU1RfUkVULCBwcmlv
LCBsZW4pOwo+ICsgICAgICAgdHN0X3JlcyhUUEFTUywgIm1xX3RpbWVkcmVjZWl2ZSgpIHJldHVy
bmVkICVsZCwgcHJpb3JpdHkgJXUsIGxlbmd0aDogJWkiLAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIFRTVF9SRVQsIHByaW8sIE1BWF9NU0dTSVpFKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQg
dGVzdF9iYWRfYWRkcih1bnNpZ25lZCBpbnQgaSkKPiArewo+ICsgICAgICAgc3RydWN0IHRpbWU2
NF92YXJpYW50cyAqdHYgPSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRdOwo+ICsgICAgICAgcGlkX3Qg
cGlkOwo+ICsgICAgICAgaW50IHN0YXR1czsKPiArCj4gKyAgICAgICBwaWQgPSBTQUZFX0ZPUkso
KTsKPiArICAgICAgIGlmICghcGlkKSB7Cj4gKyAgICAgICAgICAgICAgIHZlcmlmeV9tcXRfc2Vu
ZF9yZWNlaXZlKGksIHBpZCk7Cj4gKyAgICAgICAgICAgICAgIF9leGl0KDApOwo+ICsgICAgICAg
fQo+ICsKPiArICAgICAgIFNBRkVfV0FJVFBJRChwaWQsICZzdGF0dXMsIDApOwo+ICsKPiArICAg
ICAgIGlmIChXSUZFWElURUQoc3RhdHVzKSAmJiAhV0VYSVRTVEFUVVMoc3RhdHVzKSkKPiArICAg
ICAgICAgICAgICAgcmV0dXJuOwo+ICsKPiArICAgICAgIGlmICh0di0+dHNfdHlwZSA9PSBUU1Rf
TElCQ19USU1FU1BFQyAmJgo+ICsgICAgICAgICAgICAgICBXSUZTSUdOQUxFRChzdGF0dXMpICYm
IFdURVJNU0lHKHN0YXR1cykgPT0gU0lHU0VHVikgewo+ICsgICAgICAgICAgICAgICB0c3RfcmVz
KFRQQVNTLCAiQ2hpbGQga2lsbGVkIGJ5IGV4cGVjdGVkIHNpZ25hbCIpOwo+ICsgICAgICAgICAg
ICAgICByZXR1cm47Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgdHN0X3JlcyhURkFJTCwgIkNo
aWxkICVzIiwgdHN0X3N0cnN0YXR1cyhzdGF0dXMpKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQg
ZG9fdGVzdCh1bnNpZ25lZCBpbnQgaSkKPiArewo+ICsgICAgICAgc3RydWN0IHRpbWU2NF92YXJp
YW50cyAqdHYgPSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRdOwo+ICsgICAgICAgY29uc3Qgc3RydWN0
IHRlc3RfY2FzZSAqdGMgPSAmdGNhc2VbaV07Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgajsKPiAr
ICAgICAgIHBpZF90IHBpZCA9IC0xOwo+ICsKPiArICAgICAgIHRzdF90c19zZXRfc2VjKCZ0cywg
dGMtPnR2X3NlYyk7Cj4gKyAgICAgICB0c3RfdHNfc2V0X25zZWMoJnRzLCB0Yy0+dHZfbnNlYyk7
Cj4gKwo+ICsgICAgICAgaWYgKHRjLT5iYWRfdHNfYWRkcikgewoKV291bGQgaXQgbWFrZSBzZW5z
ZSB0byBydW4gYmFkX21zZ19hZGRyL0VGQVVMVCB0ZXN0IGFsc28gaW4gY2hpbGQ/Cgo+ICsgICAg
ICAgICAgICAgICB0ZXN0X2JhZF9hZGRyKGkpOwo+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4g
KyAgICAgICB9Cj4gKwo+ICsgICAgICAgaWYgKHRjLT5zaWduYWwpCj4gKyAgICAgICAgICAgICAg
IHBpZCA9IHNldF9zaWcodGMtPnJxLCB0di0+Y2xvY2tfZ2V0dGltZSk7Cj4gKwo+ICsgICAgICAg
aWYgKHRjLT50aW1lb3V0KQo+ICsgICAgICAgICAgICAgICBzZXRfdGltZW91dCh0Yy0+cnEsIHR2
LT5jbG9ja19nZXR0aW1lKTsKPiArCj4gKyAgICAgICBpZiAodGMtPnNlbmQpIHsKPiArICAgICAg
ICAgICAgICAgZm9yIChqID0gMDsgaiA8IE1TR19MRU5HVEg7IGorKykKPiArICAgICAgICAgICAg
ICAgICAgICAgICBpZiAodHYtPm1xdF9zZW5kKCp0Yy0+ZmQsIHNtc2csIHRjLT5sZW4sIHRjLT5w
cmlvLCBOVUxMKSA8IDApIHsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9y
ZXMoVEZBSUwgfCBUVEVSUk5PLCAibXFfdGltZWRzZW5kKCkgZmFpbGVkIik7Cj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
fQo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIHZlcmlmeV9tcXRfc2VuZF9yZWNlaXZlKGksIHBp
ZCk7Cj4gIH0KPgo+ICBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gLS0KPiAyLjQ1
LjIKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
