Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C909FC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 11:54:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 276973CE785
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 12:54:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A06BA3C8122
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 12:54:24 +0100 (CET)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DBFA620090D
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 12:54:23 +0100 (CET)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-5e7c1012a42so85157577b3.3
 for <ltp@lists.linux.it>; Wed, 03 Jan 2024 03:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704282862; x=1704887662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZdpDg9MgC1yCbq1bYlsWWXIuzgecTcvyQdn+DaFzA4=;
 b=wmxCf58IffuNWjeZmMQ74en9bGhVWpVmYer/nv+/rD2q8WuVB23axDIIULFp1rCZZs
 RzjByJSma6YZXY0Jof4D0Ifx8Wzil6XiH25CoolYpwGUvHbRMAG7sEn5nvAtKJJ2Q5yo
 k9rxm+HFhctSlGhb5hfcGCWKLbIBbfHUiVHl6GJV7gO1Dc7zT7SdtFfeSwaHoSofNVwp
 +XhFpRA//odiW0EG3bFTJzHKYNvJg5pRbMxTxT318JdBDkfB6myDDY6HsrXAAWxGHdIc
 fflixDiq8ic6h9pkruesfsA0/UIMetp6MoVjXM9DsZYaYvbjmOQtspuPfHUvMs5lfCZL
 oTLQ==
X-Gm-Message-State: AOJu0Yx3ZQWRKh+QOvn9fP3HXVQEtChcqCYqTUozchZGpm/e3PFZZxuO
 xxnzL2Ob8wzWel9kGMaZDAwc/wn89gltBQ==
X-Google-Smtp-Source: AGHT+IHtVl98aLIBo0mwi8UfrJNhm2Yse1NiQVF/ft3hBUK7H/ZGDPShflRa7MysRbVmXzFA0iUAzA==
X-Received: by 2002:a05:690c:2b02:b0:5ed:a4e8:4ba with SMTP id
 em2-20020a05690c2b0200b005eda4e804bamr6202632ywb.29.1704282862552; 
 Wed, 03 Jan 2024 03:54:22 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com.
 [209.85.128.172]) by smtp.gmail.com with ESMTPSA id
 m187-20020a8171c4000000b005d781a2e123sm12887329ywc.109.2024.01.03.03.54.19
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 03:54:19 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-5e811c5c1adso85183457b3.2
 for <ltp@lists.linux.it>; Wed, 03 Jan 2024 03:54:19 -0800 (PST)
X-Received: by 2002:a81:8742:0:b0:5e7:7964:c1ea with SMTP id
 x63-20020a818742000000b005e77964c1eamr12605669ywf.46.1704282859111; Wed, 03
 Jan 2024 03:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
In-Reply-To: <20240103114957.GD1073466@pevik>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Jan 2024 12:54:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
Message-ID: <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/36] Remove UCLINUX from LTP
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
Cc: Jonathan Corbet <corbet@lwn.net>, Linux-sh list <linux-sh@vger.kernel.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFdlZCwgSmFuIDMsIDIwMjQgYXQgMTI6NTDigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4gPiBPbiBXZWQsIEphbiAzLCAyMDI0IGF0IDI6NTLigK9B
TSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4gPiA+IFVDTElOVVggaXMgYnJv
a2VuIGluIExUUCBhbmQgbm9ib2R5IHJlYWxseSBjYXJlcy4gQWN0dWFsbHkgSSBkYXJlIHRvCj4g
PiA+IHNheSBVQ0xJTlVYIGlzIGRlYWQuIFRoZXJlZm9yZSBJIHByZXBhcmVkIHBhdGNoc2V0IHRv
IHJlbW92ZSBVQ0xJTlVYCj4gPiA+IGZyb20gTFRQLiBXZSBoYXZlIGJlZW4gYWN0aXZlbHkgcmVt
b3ZpbmcgVUNMSU5VWCBmcm9tIExUUCBkdXJpbmcgcmV3cml0ZQo+ID4gPiB0ZXN0cyB0byBuZXcg
TFRQIEFQSS4gVGhpcyByZW1vdmVzIHRoZSByZXN0IGZyb20gdGhlIG9sZCB0ZXN0cyAod2hpY2gK
PiA+ID4gd2lsbCBiZSBzb29uZXIgb3IgbGF0ZXIgcmV3cml0dGVuIHRvIG5ldyBBUEkpLgo+Cj4g
PiA+IEJlY2F1c2UgdGhlIHBhdGNoc2V0IGlzIHF1aXRlIGJpZywgSSBkaWQgbm90IHdhbnQgdG8g
c2VuZCBpdCB0byBtYWlsaW5nCj4gPiA+IGxpc3RzIChidXQgSSBjYW4gZG8gaXQgaWYgeW91IHdh
bnQpLgo+Cj4gPiA+IENhbiB5b3UgcGxlYXNlIGhhdmUgbG9vayBhdCBteSBmb3JrIG9uIGdpdGxh
YiwgYnJhbmNoOiByZW1vdmUtVUNMSU5VWAo+ID4gPiBodHRwczovL2dpdGxhYi5jb20vcGV2aWsv
bHRwLy0vY29tbWl0cy9yZW1vdmUtVUNMSU5VWD9yZWZfdHlwZT1oZWFkcwo+Cj4gPiA+IEJ1aWxk
IHRlc3Q6Cj4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9wZXZpay9sdHAvYWN0aW9ucy9ydW5zLzcz
OTI0NzAyMTUKPgo+ID4gVGhhbmtzIGZvciB5b3VyIHNlcmllcyEKPgo+IFRoYW5rIHlvdSBmb3Ig
eW91ciBmZWVkYmFjay4gIE1heSBJIGFkZCB5b3VyIEFja2VkLWJ5OiB0YWcgdG8gdGhlIHNlcmll
cyB3aGVuIHdlCj4gYWdyZWUgdG8gbWVyZ2U/CgpJIGFtIG5vdCBzdXJlIEkgYWdyZWUgd2l0aCB0
aGlzIHNlcmllcy4KUmVtb3Zpbmcgc3VwcG9ydCBmb3IgVUNMSU5VWCBmcm9tIExUUCBpcyBhbG1v
c3QgYSBndWFyYW50ZWUgZm9yCm5vdCBub3RpY2luZyB3aGVuIG1vcmUgYnJlYWthZ2UgaXMgaW50
cm9kdWNlZC4KCkhvdyBleGFjdGx5IGlzIFVDTElOVVggYnJva2VuIGluIExUUD8KClRoYW5rcyEK
Ckdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApH
ZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0t
IGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVj
aG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtp
bmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxp
a2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxk
cwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
