Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC292C369C2
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745323826; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ofHBJ2+Nh8SFmLRAcR5D57omIXSmI3Ze+pY0H7bD5N0=;
 b=eDxM0Lq7NtrEdrbuWHw2fnH5oJFsek00TXUMebPx1QLVMHXriadoh80mWYzfSsZ5MKhjR
 YHTKHRAXfLj5expSlFhbrdeoxye3n0WzLG6jbp/dwha2+RgGDVZQmC9f1/RqokXA8NtTqOm
 z33zz5LLZPL9Q7RFnbkIKT+gbSe2kas=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA59F3C299A
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 14:10:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B6FF3C1895
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 14:10:05 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 29AAB1400070
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 14:10:04 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ace333d5f7bso55790266b.3
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 05:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745323803; x=1745928603; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbKmj9J5kcbuhyvpBs8IN2cpBIpHDIIqi3ZKOHpeiHY=;
 b=DSp1H1GgZlJCNyTEDtKpXk0FrxGa900TUSfMLkSDZZTxJ8VeGOXYIT1zxA7cobMPbX
 OIR0YPReRhS5lH/3xwxKgraM2mV7mNxWCxqa2xmha/4hBBYUa4EAlyvNAWlqa1itqZZq
 p+V0OE3mF8GHROsEy/8pqVIhALQ7q72rpMXNEJcX4wVUu4iz8Kf9IpGCVopN1i4kzc/n
 pUss4PkQwCWG0uAynZGhfMW0qvAxpnhoitOj01c8+HmU37nLNkmF/olCIZFPrwki6gmf
 jA6bLeRnwnMXl1NuyIwv9wG7JUHUnTsNtIESS1FMnlYKpvAP5z+nLibntCj95DcuI8nl
 GJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745323803; x=1745928603;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lbKmj9J5kcbuhyvpBs8IN2cpBIpHDIIqi3ZKOHpeiHY=;
 b=qEk7hysXX7Ts5ZLjRr1vCZns1hjh4CkZuT/ecT/k9X7TLxCFV0VQtkRWyRCzwSKyzZ
 9rhLusl5lKBkNczGWVHzMXhWh0uO4nX73iPXFYYrsW9Bxx+W/0FWW3ApLnUARWLINLDT
 M71MEN4K+apP31KFx/nQgj6MmNTJ+nUyZogthTidXUV41G3sAg9B3AH+oPFEWlT89fUE
 rBnhvbylhtzP9x1v4L5hBXkCUVuezR3GLI2ivK+cyIURkT3oXW7GXXX2rJrEX8VrnLoH
 YILC+vPcd7i4dEsXmauU5kHYIX69YOPjBjSm/w5oGP4Drba7mPLR2NckX+jdXrrExM8h
 KdUA==
X-Gm-Message-State: AOJu0YyUYDuZhft7zQ2dKZKiiTMQWtt6k8uygmlBiC0OQpZYZ7E9hqw2
 JYKRaJCvsYV4Y6w2Tx4ns7KQCdUs1dFv1/eLruL59iPC0aJSITVo9xAZmig8FgU=
X-Gm-Gg: ASbGncsE4ArjJp4oXX47YVeweF/yBqd1wNjB1XGfCqZbKlG0QLvPoy8kejfwS5+x6o9
 Xze2gWVOfNtHLCa82xH4mGfpwt8B40D9zGUJM97Gl3IQc9fReSJ1DGLWMLhIHvX/Ln5G1I83usD
 7zI1fyJcz5W97jIV3mUo1yqSNwqLzHwO1vpQYfhzK7mBvApE5G0RLiJRh4osjBEd5L9if8gyrgZ
 Q0PNSyauvi/OsKd0u+Q9HDfb8ptcEDypj9EP4CPK8OjjQoRRZvgwbmFgZtqFGT1nfO5ntgqQ94X
 3cB4wdOsFiABLcdNpSQ78S7HUf6Nog==
X-Google-Smtp-Source: AGHT+IHhb8KxPkULfAmxv9lltZGfP7tZr2QDZMA6/YPfX1XqssWwACeVsswUz3bNeqK8t7qbOd4H/A==
X-Received: by 2002:a17:907:970c:b0:acb:5ec4:e944 with SMTP id
 a640c23a62f3a-acb74b2ee10mr1322436966b.15.1745323803271; 
 Tue, 22 Apr 2025 05:10:03 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3087df0bdf5sm9559565a91.15.2025.04.22.05.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 05:10:02 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 22 Apr 2025 09:09:57 -0300
Message-Id: <D9D5NFQEMMUY.1QLE0OQMTJRZG@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
 <20250414-conversions-mknod-v3-1-e08e7463bfaa@suse.com>
 <20250422105219.GA927374@pevik>
In-Reply-To: <20250422105219.GA927374@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/8] syscalls/mknod01: Fix checkpatch.pl
 warnings
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gUGV0ciEKCk9uIFR1ZSBBcHIgMjIsIDIwMjUgYXQgNzo1MiBBTSAtMDMsIFBldHIgVm9y
ZWwgd3JvdGU6Cj4gSGkgUmljYXJkbywKPgo+PiBGaXggdGhlIGZvbGxvd2luZyB3YXJuaW5nczoK
Pgo+PiAJQWxpZ25tZW50IHNob3VsZCBtYXRjaCBvcGVuIHBhcmVudGhlc2lzCj4+IAlQbGVhc2Ug
ZG9uJ3QgdXNlIG11bHRpcGxlIGJsYW5rIGxpbmVzCj4KPiBJJ20gbm90IHN1cmUgaG93IHlvdSBp
bnZva2UgY2hlY2twYXRjaC5wbC4KPiBDb3VsZCB5b3UgcGxlYXNlIHVzZSBMVFAgZW1iZWRkZWQg
dmVyc2lvbiB2aWE6Cj4KPiAkIG1ha2UgY2hlY2stbWtub2QwMQo+Cj4gT3IsIHRvIHNlZSB3aGF0
IGl0IGRvZXMgdXNlIFY9MQo+Cj4gJCBtYWtlIGNoZWNrLW1rbm9kMDEgVj0xCj4KPj4gU2lnbmVk
LW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPj4gLS0tCj4+ICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDEuYyB8IDUgKystLS0KPj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPj4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwMS5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25vZDAxLmMKPj4gaW5kZXggZmUwYTFjZmE2YTQ3
M2Y5YzJiMmE1NTQ5M2Y4MzBmMTNiODY1NjBhOC4uMzllNDAyZWU0MTJkZTM5Yzc5MjlkY2FlNjVm
ZGYzZTMwMmRlOWI0NSAxMDA2NDQKPj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
a25vZC9ta25vZDAxLmMKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9t
a25vZDAxLmMKPj4gQEAgLTI2LDcgKzI2LDYgQEAgc3RhdGljIGludCB0Y2FzZXNbXSA9IHsKPj4g
IAlTX0lGUkVHIHwgMDY3MDAsCj4+ICB9Owo+Cj4+IC0KPgo+IFRoaXMgaXMgbm90IHJlcG9ydGVk
IGJ5IG91ciBjaGVja3BhdGNoLnBsIGFuZCBpdCB3b3VsZCBiZSB1c2VmdWwuIEknbSBub3Qgc3Vy
ZQo+IGlmIHlvdSB3YW50IHRvIGJvdGhlciB0byBsb29rIHdoaWNoIGZyb20gdGhlc2UgLS1pZ25v
cmUKPiBDT05TVF9TVFJVQ1QsVk9MQVRJTEUsU1BMSVRfU1RSSU5HLEZJTEVfUEFUSF9DSEFOR0VT
IHNob3VsZCBiZSByZW1vdmVkIChvciB3aGljaAo+IG9uZSBpcyBtaXNzaW5nLCBtYXliZSBvdXIg
Y2hlY2twYXRjaC5wbCBpcyBvdXRkYXRlZCkuCj4KClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBv
dXQsIEkgZ290IHRoZXNlIHdhcm5pbmdzIGJ5IHBhc3NpbmcgYC0tc3RyaWN0YApvcHRpb24gdG8g
Y2hlY2twYXRjaC5wbC4gQWxzbywgSSByZW1vdmVkIEZJTEVfUEFUSF9DSEFOR0VTIGZyb20gdGhh
dApsaXN0IGJ1dCBJIGRvbid0IHJlbWVtYmVyIG5vdyB3aHkuCgo+PiAgc3RhdGljIHZvaWQgcnVu
KHVuc2lnbmVkIGludCBpKQo+PiAgewo+PiAgCWRldl90IGRldiA9IDA7Cj4+IEBAIC0zNSw4ICsz
NCw4IEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgaSkKPj4gIAkJZGV2ID0gbWFrZWRl
digxLCAzKTsKPgo+PiAgCVRTVF9FWFBfUEFTUyhta25vZChQQVRILCB0Y2FzZXNbaV0sIGRldiks
Cj4+IC0JCQkJIm1rbm9kKFBBVEgsICVvLCAlbGQpIiwKPj4gLQkJCQl0Y2FzZXNbaV0sIGRldik7
Cj4+ICsJCSAgICAgIm1rbm9kKFBBVEgsICVvLCAlbGQpIiwKPj4gKwkJICAgICB0Y2FzZXNbaV0s
IGRldik7Cj4KPiBJJ20gbm90IHN1cmUsIGlmIHRoaXMgaXMgd29ydGggdG8gZml4IChvdXIgY2hl
Y2twYXRjaC5wbCBzZXR1cCBkb2VzIG5vdCByZXBvcnQgaXQpLgo+CgpJbmRlZWQsIGl0cyBhIHB1
cmVseSBhZXN0aGV0aWMgcGF0Y2guCgo+IEJ1dCB3aGF0IHdvdWxkIGJlIHdvcnRoIHRvIGZpeCBp
cyAzMiBiaXQgY29tcGF0aWJpbGl0eSBlcnJvciBvbiBkZXZfdCBkZXY6Cj4KPiAkIFBLR19DT05G
SUdfTElCRElSPS91c3IvbGliL3BrZ2NvbmZpZyBDRkxBR1M9LW0zMiBMREZMQUdTPS1tMzIgLi9j
b25maWd1cmUgIyBzZWUgSU5TVEFMTAo+IC4uLgo+Cj4gbWtub2QwMS5jOjM3OjIyOiB3YXJuaW5n
OiBmb3JtYXQg4oCYJWxk4oCZIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSDigJhsb25nIGludOKA
mSwgYnV0IGFyZ3VtZW50IDYgaGFzIHR5cGUg4oCYZGV2X3TigJkge2FrYSDigJhsb25nIGxvbmcg
dW5zaWduZWQgaW504oCZfSBbLVdmb3JtYXQ9XQo+ICAgIDM3IHwgICAgICAgICAgICAgICAgICAg
ICAgIm1rbm9kKFBBVEgsICVvLCAlbGQpIiwKPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiAuLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF90ZXN0X21h
Y3Jvcy5oOjQyOjMyOiBub3RlOiBpbiBkZWZpbml0aW9uIG9mIG1hY3JvIOKAmFRTVF9GTVRf4oCZ
Cj4gICAgNDIgfCAjZGVmaW5lIFRTVF9GTVRfKEZNVCwgXzEsIC4uLikgRk1ULCAjI19fVkFfQVJH
U19fCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+Cj4gLi4vLi4v
Li4vLi4vaW5jbHVkZS90c3RfdGVzdF9tYWNyb3MuaDo0NjoyNjogbm90ZTogaW4gZXhwYW5zaW9u
IG9mIG1hY3JvIOKAmFRTVF8yX+KAmQo+ICAgIDQ2IHwgICAgICAgICAgICAgICAgIFRTVF9GTVRf
KFRTVF8yXyhkdW1teSwgIyNfX1ZBX0FSR1NfXywgU0NBTEwpIEZNVCwgX19WQV9BUkdTX18pKQo+
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgo+IC4uLy4uLy4uLy4uL2lu
Y2x1ZGUvdHN0X3Rlc3RfbWFjcm9zLmg6MjEwOjI1OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFj
cm8g4oCYVFNUX01TR1/igJkKPiAgIDIxMCB8ICAgICAgICAgICAgICAgICAgICAgICAgIFRTVF9N
U0dfKFRQQVNTLCAiIHBhc3NlZCIsICNTQ0FMTCwgIyNfX1ZBX0FSR1NfXyk7ICAgICBcCj4gICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fgo+IG1rbm9kMDEuYzozNjo5OiBu
b3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYVFNUX0VYUF9QQVNT4oCZCj4gICAgMzYgfCAg
ICAgICAgIFRTVF9FWFBfUEFTUyhta25vZChQQVRILCB0Y2FzZXNbaV0sIGRldiksCj4gICAgICAg
fCAgICAgICAgIF5+fn5+fn5+fn5+fgo+IG1rbm9kMDEuYzozNzo0MTogbm90ZTogZm9ybWF0IHN0
cmluZyBpcyBkZWZpbmVkIGhlcmUKPiAgICAzNyB8ICAgICAgICAgICAgICAgICAgICAgICJta25v
ZChQQVRILCAlbywgJWxkKSIsCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIH5+Xgo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwKPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBsb25nIGludAo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAlbGxkCj4KPiAoSXQgc2hvdWxkIGJlIHNvbHZlZCBieSBQUkl1TUFYIGFuZCBjYXN0aW5nIHRv
ICh1aW50bWF4X3QpLCBidXQgd2UgdXN1YWxseSBqdXN0Cj4gY2FzdCB0byAobG9uZyBsb25nKSBh
bmQgdXNlIGp1c3QgJWxsZC4gV2hhdGV2ZXIgeW91IHByZWZlci4KPgoKTmljZSwgSSdsbCBhZGQg
dGhhdCA6KQoKVGhhbmsgeW91LAotCVJpY2FyZG8uCgoKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgoK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
