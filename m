Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0E8C4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 23:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714432526; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=UoU46RNAM4mSzOl0V3qrI1woSLAEBzlmNr2zKgK1wx8=;
 b=P/z2rNC/pey9jO8hUvAsA37D4eaaDjQz7zgaWN6++QyLAQV6HkexSw+RJDSBHcrJtxUR3
 LOPF3r5VgYQP0A3f6wTcHwPV/n74smSw4J789RGWzTDhSM3Xv3aOQjaMHOtEiJtBZja16JG
 CXhFNHoUtzICd6oR3wZcFzBR3gkpXUk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42A633C8964
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 01:15:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 991603C86CF
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 01:15:04 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2221C1A00A3A
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 01:15:04 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5722eb4f852so3130a12.0
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 16:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714432503; x=1715037303; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAeiLh3Bz48nAf6zSRsb2BvPC3osNAij9Ose3VIFjR4=;
 b=H8gpuIVrGDDOaGAlfss+BxFPbP7zQDLH0jQYRN0oEIaZz7CrAoPvddW0iKlScEN/ri
 NcrKmGMXNlXtqIq9KfQ1HVTJq0S/h9IUx+3tzrHEUgcTwvg7kbxl5Zcroa1SRdw3SoXZ
 ZgRsfPt5H8f5bgFaJrBgSdzop4wlimhrGx6HtzXd1bNvgNnM3hWqV0E69GhRwSS7LD4s
 TxzQc8tg61V1NfCvutkwx/UqKELnucnUpDpAWqiRqz8+vVvX2mjCETsnLlFr0YUzs5OP
 3vQ2diH6R6UKvFXOU2sXK5J5g4vuLJzTRFgDvaUEojt2mb0QIH7rZIbs3iXIgE+TEg8z
 AGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714432503; x=1715037303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAeiLh3Bz48nAf6zSRsb2BvPC3osNAij9Ose3VIFjR4=;
 b=r38cSGPWvsrzfo9OqUGL/A4YJ4calsGLZ/8LVre6NuGg+KpIRMc9vhCsXkWcTwD30b
 OzPnVA4up2lwmlGBMPm9g3/0OsGgtXf+EIqjVgXAUzT4XvNbXndnBQGbhddfY1e4wEe+
 HMQXkXZS1BsUNngl7CAhDeqBovmZMnQZi4avzELHLfaV3Ww7VkWW3toaCVyziCvO/5/A
 MyMQGwXIAC/uZ1HDrac8RC+I9jtUIkPGADGqB+YCp4dHA90CZ450iMAXgszvuK7wxO/x
 f33CISOk39VZMoVuocxnKDdLRhwghZybSdGP2CtLVJKrLVrq9cckaEDnJxUrnJrb8Lxq
 H0XA==
X-Gm-Message-State: AOJu0YwnU5cJO8T5OzckVT6DWJz8VXK3G95N61L5NbSGBb/RQD3kXPiH
 TzHz7cF3KVvmxn30i7TwjZedP1SKBiJgfcvLSqigOjqAT81zOltax19L7B5qKrSQ5Ni9uACpxA6
 WPkFUJ2PVK4RGye2EGIHgVZs4gUHRcpVQ5cw=
X-Google-Smtp-Source: AGHT+IG5UmU89JkMQj492k9F4jv3ZYIfKjk/MFVzIcg6Ie6r9+oDwsixxbaCNhw20wiKJVJWfq2D5waJnEe2yJCKCkk=
X-Received: by 2002:a05:6402:1619:b0:572:7dc8:7140 with SMTP id
 f25-20020a056402161900b005727dc87140mr45176edv.1.1714432503400; Mon, 29 Apr
 2024 16:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-7-jstultz@google.com>
 <Zi9lo1ubVkGJHzrF@yuki>
In-Reply-To: <Zi9lo1ubVkGJHzrF@yuki>
Date: Mon, 29 Apr 2024 16:14:51 -0700
Message-ID: <CANDhNCoypwtwDc_ZTXDppO=DewUx6J7+Hw8bnWvGYEeqQz=WBQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] sched_football: Add trace_marker messages if
 we're tracing
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBcHIgMjksIDIwMjQgYXQgMjoxOOKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPiA+ICsgICAgIHNwcmludGYoYnVmLCAiSXwlaXxHYW1lX092ZXIhXG4i
LCBnZXRwaWQoKSk7Cj4gPiArICAgICBpZiAoZmQgPiAwKQo+ID4gKyAgICAgICAgICAgICByZXQg
PSB3cml0ZShmZCwgYnVmLCBzdHJubGVuKGJ1ZiwgQlVGX0xFTikpOwo+Cj4gSSBrbm93IHRoYXQg
d2UgaGF2cmUgb25seSB0d28gdXNhZ2VzIG5vdywgYnV0IGl0IHdvdWxkIGJlIGEgYml0IGNsZWFu
ZXIKPiBhbmQgcmVhZGFibGUgdG8gaGF2ZSBhIGZ1bmN0aW9uIHRvIHByaW50IHRoZSBtZXNzYWdl
cywgZS5nLgo+Cj4gc3RhdGljIHZvaWQgdHJhY2VyX3dyaXRlKGNvbnN0IGNoYXIgKm1zZyk7Cj4K
PiBBbmQgd2Ugd291bGQgZG86Cj4KPiAgICAgICAgIHRyYWNlcl93cml0ZSgiR2FtZV9TdGFydGVk
ISIpOwoKU3VyZS4gRm9yIG5vdyBJJ2xsIGFkZCBpdCB0byB0aGUgbGlicnR0ZXN0IGNvZGUsIGJ1
dCBJJ20gaGFwcHkgdG8gcHVsbAppdCBvdXQgdG8gbW9yZSBnZW5lcmljIGxvZ2ljIG9uY2UgdGhl
cmUncyBhIGdvb2QgYXBwcm9hY2ggdG8gdGhlCmNvbmZpZyBjb25mbGljdHMgaW4gdGhlIHN1YnN5
c3RlbSBoZWFkZXJzLgoKPiBJdCB3b3VsZCBiZSBhIGdvb2QgaWRlYSB0byBhZGQgdGhlIHRlc3Qg
bmFtZSB0byB0aGUgbWVzc2FnZSBhcyB3ZWxsLAo+IG1heWJlIGFzOgo+Cj4gICAgICAgICBzcHJp
bnRmKGJ1ZiwgInNjaGVkX2Zvb3RiYWxsfCVpfCVzXG4iLCBnZXRwaWQoKSwgbXNnKTsKPgoKSG93
IGFib3V0IHNwcmludGYoYnVmLCAiSXwlaXwlczogJXNcbiIsIGdldHBpZCgpLCB0ZXN0X3RhZywg
bXNnKSA/CgpUaGlzIGlzIG1vc3RseSBiZWNhdXNlIEknbSB1c2luZyB0aGUgdHJhY2VfbWFya2Vy
IGZvcm1hdCB0aGF0IHBlcmZldHRvCnVuZGVyc3RhbmRzLCBhbmQgY2FuIHZpc3VhbGl6ZS4KCnRo
YW5rcwotam9obgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
