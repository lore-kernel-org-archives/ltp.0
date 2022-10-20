Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55979C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 19:09:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0170B3CB1A7
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 21:09:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CDB93CAE70
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 21:09:23 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F189B20075A
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 21:09:22 +0200 (CEST)
Received: by mail-pj1-x1030.google.com with SMTP id h12so349832pjk.0
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dCE81JZiU0pK8iRb4P7sOYYvUcmVhbTtVb/AQm8mXdY=;
 b=HLbSpa0BbjXF/gUFdlI3WqhYoXDyb6bNj0PTe/HqvJX8s/HJfCPhMVzFoNBgchV03n
 0pjz7gfohPmKKOj04rHOyT+oEgnWlPGJh6ch8cX7iadxVJZHu8cMzfImWRYbTZ9FICQD
 6/tjD+3o99f2YRo1UzNwjLJTCWyyW8bcNrCp/DPPMJ1QYcighAqos+PG1Y0+LWH3sIES
 dendFlVl5y1+H2Ad0YS8h4dvW8K0iLIItKyX+DDXdrNJ9nXJ1UPqs+WoLm4fn6xqaeH9
 7XhjTGN+SV6187McAgwgDYqvdDabXn7mTiKMnfTdhB6TM624eU3tdFbBoMV3+nkPqp4I
 z9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dCE81JZiU0pK8iRb4P7sOYYvUcmVhbTtVb/AQm8mXdY=;
 b=V1gp6t0AbZw03uE0X9Cx07dTUMZIgZYqzNhcZbuAM87F7P9D9YhnidIfyTdOVRIXtY
 w7qh5SgkMjQPvntWdymDa9GPp1VkyQCe9jRl20eM1kgTvFLcWs0uEGsObXurdFw3zUAR
 5oL8tA0txrnwg27qk9sWaOi2v6fOGV74Ps2Pmaq4R0vmztWwd03HQ6dGyisLNRtVYG0H
 CAP0JmYJTLAxdD5CjfyA8Jx6zP6WHEYkEm+nJKB5+puLZq3pwGnppbqhiZfbSOqzQ/K3
 5VpQ0VstyFl+nCD7KV0wt5kcZf/awmk0/3nAtcogPixzNV9+tuSkCyLNj78bsxK8/4wV
 7iDA==
X-Gm-Message-State: ACrzQf2cDNQGoYrNoGFvD1T67sDVGpsGaJPqIqPx52n1SaYbYh8iPCX2
 D/3nGTkzRS2fAmNojKmwrHTnEQ==
X-Google-Smtp-Source: AMsMyM4W45CtgXcx0AL+dME0tyz2xaAr66M9wXuMGvU/uOyXk7F+KBiDi9Na84KWg4bihL/vUdaWOA==
X-Received: by 2002:a17:903:1211:b0:178:a692:b1e3 with SMTP id
 l17-20020a170903121100b00178a692b1e3mr15913712plh.48.1666292961179; 
 Thu, 20 Oct 2022 12:09:21 -0700 (PDT)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419?
 ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 s3-20020aa78bc3000000b0056323de479bsm13659360pfd.120.2022.10.20.12.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Oct 2022 12:09:20 -0700 (PDT)
Message-ID: <e70f103a-b91c-6f45-4877-c5e799b6d119@daynix.com>
Date: Fri, 21 Oct 2022 04:09:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
To: Petr Vorel <pvorel@suse.cz>
References: <20221020133715.256521-1-akihiko.odaki@daynix.com>
 <Y1GFvU/ixieqDSq6@pevik>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Y1GFvU/ixieqDSq6@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_test.sh: Normalize the locale
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyMi8xMC8yMSAyOjMwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIGFsbCwKPiAKPiAKPj4g
bmV0d29yay90Y3BfY21kcy90cmFjZXBhdGgvdHJhY2VwYXRoMDEuc2ggZmFpbHMgd2l0aCBMQU5H
PWphX0pQLlVURi04Cj4+IGJlY2F1c2UgaXQgcGFyc2VzIGxvY2FsaXplZCBvdXRwdXQuIFRoZSBi
ZWxvdyBpcyBhbiBleGFtcGxlIG9mIHN1Y2gKPj4gb3V0cHV0Ogo+PiAkIHRyYWNlcGF0aCBsb2Nh
bGhvc3QKPj4gICAxPzogW0xPQ0FMSE9TVF0gICAgICAgICAgICAgICAgICAgICAgICAwLjA0MOOD
n+ODquenkiBwbXR1IDY1NTM2Cj4+ICAgMTogIGxvY2FsaG9zdCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDAuMjc044Of44Oq56eSIOWIsOmBlOOBl+OBvuOBl+OB
nwo+PiAgIDE6ICBsb2NhbGhvc3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAwLjI2MeODn+ODquenkiDliLDpgZTjgZfjgb7jgZfjgZ8KPj4gICAgICAg6KaB57SE
OiBwbXR1IDY1NTM2IOODm+ODg+ODl+aVsCAxIOaIu+OCiuODm+ODg+ODl+aVsCAxCj4gCj4+IEl0
IGlzIG5lY2Vzc2FyeSB0byBub3JtYWxpemUgdGhlIGxvY2FsZSB0byBhdm9pZCBzdWNoIGEgcHJv
YmxlbS4KPj4gVGhlcmUgYXJlIHNvbWUgdGVzdHMgZG8gdGhlIG5vcm1hbGl6YXRpb24sIGJ1dCB0
aGF0IGlzIG5vdAo+PiBjb21wcmVoZW5zaXZlLiBBZGQgY29kZSB0byBub3JtYWxpemUgdGhlIGxv
Y2FsZSB0byB0c3RfdGVzdC5zaCBzbwo+PiB0aGF0IGl0IGNhbiBjb3ZlciBtb3JlIHRlc3RzLgo+
IAo+PiBUaGUgYWRkZWQgY29kZSBkb2VzIHRoZSBub3JtYWxpemF0aW9uIGJ5IHNldHRpbmcgTENf
QUxMLCB3aGljaAo+PiB0YWtlcyBwcmVjZWRlbmNlIHRvIHRoZSBvdGhlciBsb2NhbGUtcmVsYXRl
ZCBlbnZpcm9ubWVudCB2YXJpYWJsZXMKPj4gYW5kIGRvZXMgbm90IHJlcXVpcmUgdGhhdCAibG9j
YWxlIiBjb21tYW5kIGV4aXN0cy4KPiAKPj4gU2lnbmVkLW9mZi1ieTogQWtpaGlrbyBPZGFraSA8
YWtpaGlrby5vZGFraUBkYXluaXguY29tPgo+PiAtLS0KPj4gICB0ZXN0Y2FzZXMvbGliL3RzdF90
ZXN0LnNoIHwgMiArKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiAKPj4g
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2ggYi90ZXN0Y2FzZXMvbGliL3Rz
dF90ZXN0LnNoCj4+IGluZGV4IDI4YjdkMTJiYS4uNWViYmUxZDI1IDEwMDY0NAo+PiAtLS0gYS90
ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoCj4+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Qu
c2gKPj4gQEAgLTgzMSwzICs4MzEsNSBAQCBpZiBbIC16ICIkVFNUX05PX0RFRkFVTFRfUlVOIiBd
OyB0aGVuCj4+ICAgCQlmaQo+PiAgIAlmaQo+PiAgIGZpCj4+ICsKPj4gK2V4cG9ydCBMQ19BTEw9
Qwo+IAo+IFRoaW5raW5nIGFib3V0IGl0IHR3aWNlIHRoaXMgbWlnaHQgaGF2ZSBpbXBhY3Qgb24g
b3RoZXIgdGVzdHMuCj4gTGksIEN5cmlsLCBhbnkgaWRlYSBhYm91dCBpdD8KPiAKPiBPdGhlciBv
cHRpb24gd291bGQgYmUgdG8gcHV0IHRoaXMgY2hhbmdlIGp1c3QgdG8gdHJhY2VwYXRoMDEuc2gu
Cj4gQW5kIGlmIHdlIHdhbnQgdG8gdGVzdCBqdXN0IEMgbG9jYWxlIChJJ20gcmVhbGx5IG5vdCBz
dXJlLCBzaG91bGRuJ3QKPiBpdCBiZSBhbHNvIGluIEMgQVBJPwo+IAo+IEtpbmQgcmVnYXJkcywK
PiBQZXRyCklmIHRoZSBjaGFuZ2Ugb2Ygc2NvcGUgbmVlZHMgdG8gYmUgbmFycm93ZWQsIHdlIGNh
biBwcmVmaXggdHJhY2VwYXRoIAppbnZvY2F0aW9uIHdpdGggTENfQUxMPUMgYW5kIGxpbWl0IHRo
ZSBpbXBhY3QgY29tcGxldGVseSB0byB0cmFjZXBhdGguCgpIb3dldmVyLCBJIG9wdCB0byBhZGQg
dGhpcyB0byB0c3RfdGVzdC5zaCBiZWNhdXNlLCBpbiBteSBleHBlcmllbmNlIHdpdGggCkphcGFu
ZXNlIGxvY2FsZSwgdGhpcyBraW5kIG9mIHByb2JsZW0gaGFzIGJlZW4gc28gY29tbW9uIHRoYXQg
ZXZlbiBzb21lIApKYXBhbmVzZSBwZW9wbGUgc2V0IHRoZWlyIGxvY2FsZSB0byBDIGZvciB0aGVp
ciBjb21tYW5kIGxpbmUuIEl0IGNhbiAKaGFwcGVuIGFueXdoZXJlIHVzaW5nIHNlZCwgYXdrLCBl
dGMgZm9yIGNvbW1hbmQgb3V0cHV0cyBhbmQgb2Z0ZW4gcmVtYWluIAp1bm5vdGljZWQgYmVjYXVz
ZSBvZiBpdHMgbG9jYWxlLXNwZWNpZmljIG5hdHVyZS4KClJlZ2FyZGluZyBDIEFQSSwgdGhlIHNj
b3BlIG9mIHNldGxvY2FsZSgpLCBhdmFpbGFibGUgaW4gQywgaXMgbGltaXRlZCB0byAKdGhlIHBy
b2dyYW0sIGFuZCBpcyBub3QgYXBwbGljYWJsZSB3aGVuIGludm9raW5nIGFuIGV4dGVybmFsIGNv
bW1hbmQgCmxpa2UgdHJhY2VwYXRoLiBJdCBjb3VsZCBiZSBhbiBvcHRpb24gaWYgdHJhY2VwYXRo
IGFsc28gaGFzIEMgQVBJLCBidXQgCml0IGRvZXNuJ3QsIHVuZm9ydHVuYXRlbHkuCgpSZWdhcmRz
LApBa2loaWtvIE9kYWtpCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
