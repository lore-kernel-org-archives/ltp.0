Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235D1C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 16:32:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 546363CC806
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 17:32:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C53A43CA488
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 17:32:13 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 116DE14060C0
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 17:32:13 +0100 (CET)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53eeb28e8e5so12683a12.1
 for <ltp@lists.linux.it>; Fri, 03 Nov 2023 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699029132; x=1699633932; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quMTU5eMCt50ZA71Rv/f0q7gIocra6g1IKk6ffCVVoU=;
 b=XPRj1qr9q1MJeH4Ulca00I1uZnlAxjj05ifH7unueXwbWKOnrmd+5QhmPiNP+DK+zw
 6STQyJ9l/1OrNprOMQde459x8KEetnAsqeOmcGvEV54R1WxEMq8IXlP4vrB6+5NfB1Y0
 lu37YTRfTSUHhqGA+VLEWfpRHxgjorw1x8ksmRAbLQGq7gzuRRJIvjMyFJM6HuVomiUY
 JOa/tFvkfUiYdYW5AL9qfvzeDCP75qGvghi6C56/AyF0lF3I4jtIygQYfmbBvFzMb4xf
 FoIaF+huO+E9nIuUjM8x1WeiY3mLr9LPZ4Myp6e5pfFWs/+gTzZkbF94JcpoKC8J6IaV
 54BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699029132; x=1699633932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=quMTU5eMCt50ZA71Rv/f0q7gIocra6g1IKk6ffCVVoU=;
 b=fLF7MDCXIOxp6ZGmCxJGHfPzUVhCERjAPJICkVapQURcPHfL4Lky9LoBNrDDZtCxML
 WsgQf+lwHAmT/QRVcC56SBknKULICj9PPBfsN2a2LBSJjAh5ibWJoK9/ZEeOGpQ9f/Ni
 wimPFwrJij5OHctmeJT3Zbmbg4GHVmsX+0GALqJa19WD/m83DIhbjJe8JI6ri1/nut5S
 k5zpEmOMeFF3MEt/CDbz7WQEXjR/CX9PvV2yGJeFQ3xuxfQ0H1h/0j4WtFyaEKYXXqfl
 p0iMhk+MJspgnXsDwP4LbAdkzqniOhr+smFuh71YfzKF8OJjNCBEudPf/m8PW4bx/bif
 S9Pg==
X-Gm-Message-State: AOJu0Yy1fuX+6hRpMEHKxtuCGZ7wKC23Znqyq3Huq3nUGshvx7fevM5j
 zw8zyMObIxdnrAYi2Sy9WBMF81w660xMWP8WTvCXbQ==
X-Google-Smtp-Source: AGHT+IGlpEYgcdTQGZqfZBo6sBqfhsN0QKy1lvOOL78m2V21Q5khUxDbaxZ8WzgEzX0kLT9l7NbG+NkNf1pOd4PPt9c=
X-Received: by 2002:a50:951e:0:b0:542:d737:dc7e with SMTP id
 u30-20020a50951e000000b00542d737dc7emr722eda.0.1699029132318; Fri, 03 Nov
 2023 09:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz>
 <ZUJ8K9nna0Poa9FS@yuki> <ZUJ-N8ji_KdOOfyr@yuki>
 <20231103155409.GB1087887@pevik>
In-Reply-To: <20231103155409.GB1087887@pevik>
Date: Fri, 3 Nov 2023 09:31:44 -0700
Message-ID: <CAG4es9VRd3N7qwHnKKdNs2rfZGCCnJjn9tnnkq9ZHRHNHJjHCQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIEZyaSwgTm92IDMsIDIwMjMgYXQgODo1NOKAr0FNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ID4gSGkhCj4gPiA+ID4gICBpZiAodHN0X3Rlc3QtPm1v
dW50X2RldmljZSkKPiA+ID4gPiAgICAgICAgICAgdHN0X3Rlc3QtPmZvcm1hdF9kZXZpY2UgPSAx
Owo+Cj4gPiA+ID4gQEAgLTEzNjIsNiArMTQwMiwxOSBAQCBzdGF0aWMgdm9pZCBkb19jbGVhbnVw
KHZvaWQpCj4KPiA+ID4gPiAgIHRzdF9zeXNfY29uZl9yZXN0b3JlKDApOwo+Cj4gPiA+ID4gKyBp
ZiAodHN0X3Rlc3QtPm1vZHByb2JlKSB7Cj4gPiA+ID4gKyAgICAgICAgIGNvbnN0IGNoYXIgKm5h
bWU7Cj4gPiA+ID4gKyAgICAgICAgIGludCBpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgICAgICAg
Zm9yIChpID0gMDsgKG5hbWUgPSB0c3RfdGVzdC0+bW9kcHJvYmVbaV0pOyArK2kpIHsKPiA+ID4g
PiArICAgICAgICAgICAgICAgICBpZiAoIW1vZHVsZXNfbG9hZGVkW2ldKQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgIGNvbnN0IGNoYXIgKmNvbnN0IGNtZF9ybW1vZFtdID0geyJybW1vZCIsIG5hbWUs
IE5VTEx9Owo+Cj4gPiA+IG1vZHByb2JlIC1yIHBsZWFzZSwgcm1tb2QgaGFzIGJlZW4gZGVwcmVj
YXRlZCBmb3IgYWdlcy4KPgo+ID4gQW5kIG9uZSBtb3JlIG1pbm9yIHBvaW50LCB3ZSBzaG91bGQg
YXR0ZW1wdCB0byByZW1vdmUgdGhlIG1vZHVsZSBvbmx5IGlmCj4gPiBpdCBoYXMgc2hvd24gdXAg
aW4gdGhlIC9wcm9jL21vZHVsZXMuCj4KPiArMQo+Cj4gPiBBc3N1bWluZyB0aGF0IHdlIHdhbnQg
dG8gc2tpcCB0aGUgdHN0X21vZHVsZV9pc19idWlsZGluKCkgY2hlY2sgb24gc29tZQo+ID4gc3lz
dGVtcyBhcyBSaXRjaGllIHN1Z2dlc3RlZCB3ZSB3b3VsZCBhdHRlbXB0IHRvIHJlbW92ZSBidWls
ZCBpbiBtb2R1bGVzCj4gPiBoZXJlIGlmIHdlIGJsaW5kbHkgdHJ1c3RlZCB0aGUgcmV0dXJuIHZh
bHVlIGZyb20gbW9kcHByb2JlLgo+Cj4gSSBndWVzcyBmb3IgbW9zdCBvZiBkaXN0cm9zIHRzdF9j
aGVja19idWlsdGluX2RyaXZlcigpICh3aGljaCByZWFkcwo+IG1vZHVsZXMuYnVpbHRpbikgbWFr
ZXMgc2Vuc2UuIEFuZCB3aXRoIGl0IHdlIHdpbGwgaGF2ZSB2YWxpZCBpbmZvIGlmIHdlIHNob3Vs
ZAo+IHJlbW92ZSBtb2R1bGUgb3Igbm90Lgo+Cj4gVGhlbiB0aGVyZSBpczoKPgo+IDEpIEFPU1Ag
KEFuZHJvaWQpLCB3ZSBzaG91bGQgYXNrIEVkd2FyZCB3aGF0IG1ha2VzIHNlbnNlIGluIEFuZHJv
aWQuCj4gSU1ITyBvbGQgQU9TUCB2ZXJzaW9ucyB1c2VkIGluc21vZCBhbmQgcm1tb2QsIGJ1dCBu
ZXdlciBjb3VsZCBzdXBwb3J0IGl0IFsyXS4KPiBARWR3YXJkLCBhbSBJIGNvcnJlY3Q/IEFsc28g
ZG8gQU9TUCBldmVuIGNhcmUgYWJvdXQgdGVzdHMgd2hpY2ggdXNlCj4gdHN0X21vZHVsZV91bmxv
YWQoKT8KCkFuZHJvaWQgc3VwcG9ydHMgbW9kcHJvYmUgLXIsIGJ1dCB3ZSdyZSBub3QgY3VycmVu
dGx5IHJ1bm5pbmcgYW55IG9mCnRoZSB0ZXN0cyB0aGF0IHVzZSB0c3RfbW9kdWxlX3VubG9hZCBi
ZWNhdXNlIHdlJ3JlIG5vdCBidWlsZGluZyB0aGUKdGVzdCBtb2R1bGVzLiAgSSdsbCBzZWUgaWYg
SSBjYW4gZml4IHRoYXQsIHRob3VnaC4KCj4KPiAyKSBOaXhPUwo+IFRoaXMgc2hvdWxkIGJlIElN
SE8gZml4ZWQgYnkgY2hlY2tpbmcgYWxzbyB0aGUgY29ycmVjdCBkaXJlY3RvcnkgKGlkZWFsbHkK
PiB3cmFwcGVkIGJ5IHNvbWUgI2lmZGVmLCBidXQgY2FuIGJlIGV2ZW4gd2l0aG91dCBpdCwgaWYg
dGhlcmUgaXMgbm9uZSkuCj4KPiBCVFcsIHRoZXJlIGlzIGFsc28gL3Byb2Mvc3lzL2tlcm5lbC9t
b2R1bGVzX2Rpc2FibGVkIFsxXSwgSSdtIG5vdCBzdXJlIGlmIHdlCj4gd2FudCB0byBqdXN0IGln
bm9yZSBpdC4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiBbMV0gaHR0cHM6Ly93d3cua2Vy
bmVsLm9yZy9kb2MvRG9jdW1lbnRhdGlvbi9zeXNjdGwva2VybmVsLnR4dAo+IFsyXSBodHRwczov
L3NvdXJjZS5hbmRyb2lkLmNvbS9kb2NzL2NvcmUvYXJjaGl0ZWN0dXJlL2tlcm5lbC9sb2FkYWJs
ZS1rZXJuZWwtbW9kdWxlcwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
