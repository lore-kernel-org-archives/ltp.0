Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3645C3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 09:15:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 350F13CD615
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 10:15:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 222733CD427
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 04:44:27 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 58F171A00EA5
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 04:44:26 +0100 (CET)
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-680a13af19bso5906206d6.0
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 19:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704426265; x=1705031065;
 darn=lists.linux.it; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h9Mf84xFuyY+KXEL0NxI6rgus6ihvZvZ8KwrTqLyjZE=;
 b=GVdlivdoQIaROUR8PU7U4vP2aDtWAsrRnueFlnJJJbTsRnmku/D0RmGiT5IUdFM6Lg
 Pa4MTlm6JfeZ7obXRRFHn4/Gp0GYrdvIbR3kxc4R5Ez0ycyEr+HDIuD3i6fQoV7rWvZR
 Ra4I1xQqt1d+h1e0bTR1OBDp0eqlBEMSv24t3SFlO60IJqmMgAAmcxLCBlkDTQCmRnrl
 mNg2Scdox1qNECW/FNfwUdwDkmmJ60hKt7JZKgpyb9DM0tLwC2GBjOUfA07ITlaEGv+I
 gLMvWnDmQ+z9FoA6uXqZCsWh65K3b+fyUX2dkgeVyjoVd8YyWCDlFP2EGScrNvyx8OLM
 iN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704426265; x=1705031065;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h9Mf84xFuyY+KXEL0NxI6rgus6ihvZvZ8KwrTqLyjZE=;
 b=MZq4f8RXFWpQhSSuv3AxCMC51qlrZweW7fSqroVLJaaXE6HgICJlF2UuL81pX3JzrQ
 nFVnuj/pfFoM+KvgQictdbc5xRvW1ITA3isuh3TU9myfJDmfvw/B8EOcdNqpssykYm3I
 LXFaxQU7+fdJWWkvybw8GJAb9wpfhyIbNltkQO3NyjuNR/oBmQ34IqLqTC1H6RV6OTnb
 +59XF32UhfVTL84UFHb81/m65IOQqobBkCAsev+4Fv0E5EcjxLlfFBvcrwVr73L13W3B
 yUIOFQK1poz5YsGTXHy1WpfUt9BsXQkx1pmZp2cyOHfGgqETLjGL458iACISPtlMQfPp
 683Q==
X-Gm-Message-State: AOJu0Yy3PrOD28owq5zmaMpsuB2LXacW0pzxYLGf+/SuU2rnhEpilFLY
 Tl/4UJk+YWpPQT42fhsl7KhrKVNE8VfT7A==
X-Google-Smtp-Source: AGHT+IE5c+alCyX1IwIj3VnIvG0UA9lij+ign+WLiqw65B1fGZND/Aeym1T7qiFm3gDYxSCgN4CMSg==
X-Received: by 2002:a05:6214:2602:b0:67f:5660:3e4 with SMTP id
 gu2-20020a056214260200b0067f566003e4mr1707272qvb.67.1704426264997; 
 Thu, 04 Jan 2024 19:44:24 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
 by smtp.gmail.com with ESMTPSA id
 eh17-20020a056214187100b0067f70cc986asm297636qvb.92.2024.01.04.19.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 19:44:24 -0800 (PST)
Message-ID: <8131b56d-937d-d7a9-0bab-99599617ad74@landley.net>
Date: Thu, 4 Jan 2024 21:50:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>, Petr Vorel <pvorel@suse.cz>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jan 2024 10:15:32 +0100
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

CgpPbiAxLzMvMjQgMDM6NDYsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToKPiBIaSBQZXRyLAo+
IAo+IENDIG90aGVyIHVDbGludXggYXJjaCBsaXN0cwo+IAo+IE9uIFdlZCwgSmFuIDMsIDIwMjQg
YXQgMjo1MuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPj4gVUNMSU5V
WCBpcyBicm9rZW4gaW4gTFRQIGFuZCBub2JvZHkgcmVhbGx5IGNhcmVzLiBBY3R1YWxseSBJIGRh
cmUgdG8KPj4gc2F5IFVDTElOVVggaXMgZGVhZC4gVGhlcmVmb3JlIEkgcHJlcGFyZWQgcGF0Y2hz
ZXQgdG8gcmVtb3ZlIFVDTElOVVgKPj4gZnJvbSBMVFAuIFdlIGhhdmUgYmVlbiBhY3RpdmVseSBy
ZW1vdmluZyBVQ0xJTlVYIGZyb20gTFRQIGR1cmluZyByZXdyaXRlCj4+IHRlc3RzIHRvIG5ldyBM
VFAgQVBJLiBUaGlzIHJlbW92ZXMgdGhlIHJlc3QgZnJvbSB0aGUgb2xkIHRlc3RzICh3aGljaAo+
PiB3aWxsIGJlIHNvb25lciBvciBsYXRlciByZXdyaXR0ZW4gdG8gbmV3IEFQSSkuCj4+Cj4+IEJl
Y2F1c2UgdGhlIHBhdGNoc2V0IGlzIHF1aXRlIGJpZywgSSBkaWQgbm90IHdhbnQgdG8gc2VuZCBp
dCB0byBtYWlsaW5nCj4+IGxpc3RzIChidXQgSSBjYW4gZG8gaXQgaWYgeW91IHdhbnQpLgo+Pgo+
PiBDYW4geW91IHBsZWFzZSBoYXZlIGxvb2sgYXQgbXkgZm9yayBvbiBnaXRsYWIsIGJyYW5jaDog
cmVtb3ZlLVVDTElOVVgKPj4gaHR0cHM6Ly9naXRsYWIuY29tL3BldmlrL2x0cC8tL2NvbW1pdHMv
cmVtb3ZlLVVDTElOVVg/cmVmX3R5cGU9aGVhZHMKPj4KPj4gQnVpbGQgdGVzdDoKPj4gaHR0cHM6
Ly9naXRodWIuY29tL3BldmlrL2x0cC9hY3Rpb25zL3J1bnMvNzM5MjQ3MDIxNQo+IAo+IFRoYW5r
cyBmb3IgeW91ciBzZXJpZXMhCj4gCj4gSSBzZWUgeW91IG9ubHkgQ0NlZCBsaW51eC1tNjhrLCBi
dXQgQUZBSUssIHVDbGludXggaXMgbm90IHJlc3RyaWN0ZWQKPiB0byBtNjhrL2NvbGRmaXJlLCBi
dXQgYWxzbyBhdmFpbGFibGUgb24gYXJtMzIsIHJpc2N2LCBzaCwgYW5kIHh0ZW5zYS4KCkRvIHlv
dSBtZWFuICJub21tdSBzdXBwb3J0Iiwgb3IgZG8geW91IG1lYW4gdGhlIGFuY2llbnQgZGlzdHJv
IEplZmYgRGlvbm5lCnN0b3BwZWQgbWFpbnRhaW5pbmcgaW4gMjAwMz8KCkJlY2F1c2UgSSd2ZSBi
ZWVuIGRvaW5nIG5vbW11IG11c2wtbGliYyBzeXN0ZW1zIGZvciBhIGZldyB5ZWFycyBub3cuIFdv
cmtzIGZvciBtZS4uLgoKUm9iCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
