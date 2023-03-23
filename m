Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B244BC6FD1C
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 23:47:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A1423CE2FB
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 00:47:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99A593CA56D
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 00:47:30 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8E8811A00E15
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 00:47:29 +0100 (CET)
Received: by mail-yb1-xb2d.google.com with SMTP id i6so311039ybu.8
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679615248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlD1++g6Ae50GIWyjyVSV1nnF7JqCmhll/GxVUvHL8U=;
 b=UH/TL1jqrS9oCIB63In8ntHTTDx27ve/jPMv1L3vlfxh5E4N9cEzg463ByYtrsapJ7
 8lFK5tQtItsMvpg3Dqwb2kpd3Ue6xWPrflku5G0b6LjGZ9KGt6EBIC2pV7BdlY6k+bxX
 JVX0XvgEfwFiKXcC+Rp2uhPWa2O6uwDEF2srg3u9hUxNT50nKIwKEk9ltzAXeX1SOkcn
 FaJMajCo1klcqQ7XimXq50LcfZOiPZAd+S0WpEZaLTy4zly3PcmdKLZ6Z0ij9Uo6D4Kc
 beGlGRIL+kzPA/QxCYliOEw8t/RJwuzfVShAzc4IetFN8T50poMLNNHdKHKXFPZv/zna
 1+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679615248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UlD1++g6Ae50GIWyjyVSV1nnF7JqCmhll/GxVUvHL8U=;
 b=c06WpP445taisna452309cp8XU/ANXpJfLAdF9kOxxpAwYyvEcZ87I4LR0dJjA5Llb
 Qd1saOAKIZfXtfsDIb/BqDA+osZ6QmUQlRJZtErKqt0QOghYu3WUZx4f+O6g/rM6uQoz
 SoWWzSHGzSZ/BItQKF+ntMC/yoMsh7c15tMU+O/C7BX/UKtdhcs5pIegMgJsG7JFVMsY
 Qd0FasBQ25d3tXGQkX8622nGjG7vBJU8KGhTwPOhREwclfOzlzk2igOpZ267VJMhoDGl
 mBY2B3CVPvTo1g13ScZGPRbnqi7FJO2wtZCgF87aOzz7OUUmsEJ3g49ndQBckWzidP71
 3DGg==
X-Gm-Message-State: AAQBX9eerGRTZF1RZUDpINzyB4/md92/RamR5vukKTcOzfSF0wq/QInm
 IH3sJ6aSGeRNDmhYtNfFjEP/08CA01Ewp59rz61G1A==
X-Google-Smtp-Source: AKy350ZPw4+Jgt8IzJdQf+K2b+7RTRD6MZYjKhrHvJ76fQAAgVc2MRWHKjAT6JmRW0c3xc0rW1OnPpCoFifmZVOQPX4=
X-Received: by 2002:a05:6902:709:b0:ad2:3839:f49 with SMTP id
 k9-20020a056902070900b00ad238390f49mr730068ybt.5.1679615248229; Thu, 23 Mar
 2023 16:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230320235108.2058967-1-edliaw@google.com>
 <20230320235108.2058967-3-edliaw@google.com>
 <20230323085216.GC405493@pevik>
In-Reply-To: <20230323085216.GC405493@pevik>
Date: Thu, 23 Mar 2023 16:47:02 -0700
Message-ID: <CAG4es9WSByGyehAh3fvw2W0o-sh974WNBKym-1gMwJUx-V+Bcw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] set_dev_loop_path: Refactor set_dev_path
 and check return value
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com,
 Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMTo1MuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEVkd2FyZCwKPgo+ID4gdHN0X2ZpbmRfZnJlZV9sb29wZGV2IGRv
ZXMgbm90IGNoZWNrIHRoZSByZXR1cm4gdmFsdWUgb2Ygc2V0X2Rldl9wYXRoCj4gPiBhbmQgd2ls
bCByZXR1cm4gdGhlIGxhc3QgYXR0ZW1wdGVkIHBhdGggZXZlbiBpZiBpdCBkb2VzIG5vdCBwYXNz
IGEgc3RhdAo+ID4gY2hlY2suICBzZXRfZGV2X3BhdGggYWxzbyBoYXMgYSByZXR1cm4gdmFsdWUg
dGhhdCBpcyBub3QgY29uc2lzdGVudCB3aXRoCj4gPiB0aGUgb3RoZXIgZnVuY3Rpb25zIGluIHRo
aXMgZmlsZS4KPgo+IFRoaXMgY2hhbmdlIGFuZCBjaGFuZ2Ugb2YgcmV0dXJuIGlzIGEgYml0IGJ1
cmRlbiBpbiBsb29wIHJlbmFtZSBjaGFuZ2VzLgo+IEknbSBvayBpdCdzIGluIHNpbmdsZSBwYXRj
aCwgYnV0IGl0J2QgYmUgbW9yZSByZWFkYWJsZSBpZiBpdCB3ZXJlIHNlcGFyYXRlLgoKTm90IGEg
cHJvYmxlbSwgSSB3aWxsIHNwbGl0IGl0LgoKPiBzZXRfZGV2X3BhdGgoKSBpcyBnb2luZyB0byBi
ZSBjYWxsZWQgb25seSBpZiBub24tTlVMTCBwYXRoCj4gKHNlZSBpbmNsdWRlL3RzdF9kZXZpY2Uu
aCkuIEkgaGF2ZW4ndCBmb3VuZCBhIHRlc3Qgd2hpY2ggdXNlcyBpdCB0aGlzIHdheSwKPiBidXQg
c2hvdWxkbid0IGl0IGJlIGNoZWNraW5nIHBhdGgsIGluc3RlYWQgb2YgIXBhdGg/Cj4KPiAgICAg
ICAgIGlmIChwYXRoICYmIHNldF9kZXZfbG9vcF9wYXRoKHJjLCBwYXRoLCBwYXRoX2xlbikgIT0g
MCkKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCgpPb3BzLCBJIG1pc3NlZCB0aGF0IGluIHRoZSBj
b21tZW50IGFuZCB0aG91Z2h0IGEgTlVMTCBwYXRoIHNob3VsZCBiZQpjaGVja2VkIGFzIGFuIGVy
cm9yLiAgWW91IGFyZSByaWdodCwgSSB3aWxsIGNoYW5nZSBpdC4gIEFsc28sIEkgd2Fzbid0CnN1
cmUgaWYgSSBzaG91bGQgYmUgZXhwbGljaXQgd2l0aCB0aGUgIiE9IDAiLgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
