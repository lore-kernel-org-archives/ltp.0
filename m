Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3E4CE7A81
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 20:29:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A68F03CDE60
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 22:29:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 877993CA115
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 22:29:14 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ABD821000551
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 22:29:13 +0200 (CEST)
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-49378c80465so293308e0c.1
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695414552; x=1696019352; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=73tHw0CMoHa2yBD5QRPPCPXz/XyR1oSIiCaT5uYARP0=;
 b=M10XKXb7gFNyT14CMGfghBWu37cIRhIb63Xpk/0ggQCBbP9/247hnQkp5XZ37i5UBc
 bBMq2GbCRjGIgIM3p3XR1tFa7JoyvFmFfEV77w+ZpUh5U3YJswW4wNNfb4Ye4JvBpXv/
 Vb5SyVuUcSphqa3VDDE50/u0TLsukshFRoyNkKZEfQBBzswnOlElmouqtRc/Y0OEEjh9
 YCQAKvPQIikzin95iByctWbcM3O8vDBP/0F53elu8oHsFxwMMN2Zjb6IKO0lyD9ktxbr
 Hqn8zKVsTLxubIWbdwfXR4joiMRTRreqvty0aUBVx1lgN8pEQSqDptJqH7YcPtdAjjec
 REYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695414552; x=1696019352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73tHw0CMoHa2yBD5QRPPCPXz/XyR1oSIiCaT5uYARP0=;
 b=WUQR4rmcfyXGTdoJFIdiKpMLlvRL2PgqJklSnIKMfhsV7DhwQt69K7+sRepCv9cyc5
 /8SLN50CuE/Rb4XBlBpB7IGOAUGdGNZ5wC/w6Diz233MUchUcv9BAuSj+wsIML5MF/V4
 X/hKlReB3FCZcJWYnd2jByFogrQAP9pqHQ1OKKwQqeDLQGk9pw7zsUM3+FjaKhqTg/Qg
 77t9/38t+lORGOmcAlTkeZUG6ki7BakE0oz/nOgreCunV8h1tWzfhpJDsjU5K2YMYBaQ
 OZ7ex6P2GaKa19S8quU+0ekeJWic8/D8aaU/V+K49pFFoiICliHFS5+rpZb1XOcdIxbT
 xn5g==
X-Gm-Message-State: AOJu0YxR+k4V9nKtvbVe9XWS1f4vbJqp7wbyW/heKo58Vuv4SOt2sjL6
 KXAUatrdhV1KJpmasV7IpNqOeG1kP5T/OWZQRFg=
X-Google-Smtp-Source: AGHT+IFzVtqk4tjsHfcPZ1JMES65pjRB1bovei8DR1nAV7fdgsyfjSojCt+fxBgJhNNhnOhyhCJvecNnX9DXhVyj49k=
X-Received: by 2002:a05:6102:212e:b0:452:508f:fd42 with SMTP id
 f14-20020a056102212e00b00452508ffd42mr490220vsg.2.1695414552396; Fri, 22 Sep
 2023 13:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
In-Reply-To: <ZQ1Z_JHMPE3hrzv5@yuki>
From: Reuben Hawkins <reubenhwk@gmail.com>
Date: Fri, 22 Sep 2023 15:29:01 -0500
Message-ID: <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 oe-lkp@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgNDowOeKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBhY2suICBXaWxsIHRyeSB0byB0ZXN0LiAgTXkgVWJ1
bnR1IDIyLjA0IHN5c3RlbSB3YXNuJ3QgYWJsZSB0byBmaW5kCj4gPiBwYWNrYWdlcyBjYWxsZWQK
PiA+IGZvciBieSB0aGUgdGVzdCBjYXNlLCBzbyBpdCdsbCB0YWtlIG1lIGEgbGl0dGxlIHdoaWxl
IHRvIGZpZ3VyZSBvdXQgaG93Cj4gdG8KPiA+IGdldCB0aGUKPiA+IHRlc3QgY2FzZSB3b3JraW5n
Li4uCj4KPiBIdWg/IFRoZSB0ZXN0IGlzIGEgc2ltcGxlIEMgYmluYXJ5IHlvdSBzaG91bGRuJ3Qg
bmVlZCBhbnl0aGluZyBtb3JlCj4gdGhhbjoKPgo+ICQgZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHVi
LmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwLmdpdAo+ICQgY2QgbHRwCj4gJCBtYWtlIGF1dG90
b29scwo+ICQgLi9jb25maWd1cmUKPgo+ICQgY2QgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9y
ZWFkYWhlYWQKPiAkIG1ha2UKPiAkIC4vcmVhZGFoZWFkMDEKPgo+IEFuZCB0aGlzIGlzIHdlbGwg
ZGVzY3JpYmVkIGluIHRoZSByZWFkbWUgYXQ6Cj4KPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgt
dGVzdC1wcm9qZWN0L2x0cC8KPgo+IEFuZCB0aGUgcGFja2FnZXMgcmVxdWlyZWQgZm9yIHRoZSBj
b21waWxhdGlvbiBhcmUgbWFrZSwgQyBjb21waWxlciBhbmQKPiBhdXRvdG9vbHMgbm90aGluZyBl
eHRyYW9yZGluYXJ5Lgo+Cj4gQXdlc29tZS4gIFRoYXQgd2FzIHNpbXBsZXIgdGhhbiB3aGF0ZXZl
ciBpdCB3YXMgSSB3YXMgdHJ5aW5nLiAgSSd2ZQpyZXByb2R1Y2VkIHRoZSBmYWlsZWQgdGVzdCBh
bmQgd2lsbCB0cnkgYSBmZXcgdmFyaWF0aW9ucyBvbiB0aGUgcGF0Y2guClRoYW5rcyEKCj4gLS0K
PiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
