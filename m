Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0513C53219
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785154937; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=K886DqCNI/50CQUzAZ2tdclY7i/Oj2WJdNi6LabVvr4=;
 b=h/8lvLSgxyYCBaC0be9PTw/TrwfBxS1BP1QC7q9XsmY8+qctQdUKHFLVwDeSO6SiONvAp
 HczhawOUMuuRInMM9Eez4Rn99q25l5gJ38sJIL2gM+vA/TgLmqZTVuNUl8JHqLMixDmbQGw
 Djj2KW0hIC2xquJ7B4d4N7gFv4G5XVk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6C9B3E65B9
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 14:22:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 029BE3E5278
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 14:21:57 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6CDA51000785
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 14:21:57 +0200 (CEST)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6685483aad2so3238802d50.0
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 05:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785154916; cv=none;
 d=google.com; s=arc-20260327;
 b=ZIqW0ywPnltMA9gIne4Evl7rKFEIy3CCHffpjorggXZ0I8D4xCRWHRRzsI9R6SGhyx
 k7wYBcZ1Z+vNFB6pE42g0rFwU444fheAg+jooEP1jmX6MoL/joXdpyS5+WYnmN5WSfgG
 ZunvoNFPbHFBCVTZzMw15ifTbPbNypAu4D64nwbxcomrLCYCxl7y5I6U3KeTLFnYaXj5
 E1mr0gGzgllym1HeB7IbUwmGiLoLtDqBF65mBGfdPg1dVinAxVjTgjaVLOHeKt0K2aTD
 0XcyqkLWl6Hf2x7S5WSGcWkA1Qjzh+1xkiQDTMKTHFNeANjoFenVTA37SHBXhkCy8Q3X
 /GmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+llmaMlWpAHIZaPqAfJxlNVhk3g2wZ3JW+34Ah/AdPI=;
 fh=N9bUlhF3ThpKYITf0XF/maeL4tEEMgTPBOdm0GXjzqI=;
 b=sG/FyKvyyTjhiCleDT/eeMYs7xk5IP80RfUygWXgaVsWexJ8oAHA4UI938xB6UbqZe
 lArBrF6blloSYuOcMjpoC/zCAT4z9fw6xE0csuwzDd8HtdCVtsEiXOWFt4g7kT14wyQ+
 Kfg6f5UhfN8IFu7YS5Rij0UW5XIMsoKONmZcJ2txKCBaXw3AeO/+ZjklxfA9zRi0hTfI
 iv9prphzGuIvBSekXxqgRkPB9XzPy/izpSsoVXL1zBy5zcjyF1arI4ay4ZgCh/MtBRD5
 aPxhTQ6zgtCEAcPEQM4D+gcf8v+mFREUk+dWzHEIS8VsOE0vltmtlkbaTToVpnKfiNES
 8eJw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785154916; x=1785759716; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+llmaMlWpAHIZaPqAfJxlNVhk3g2wZ3JW+34Ah/AdPI=;
 b=bH0xdU1H61Hu+EDVXP4O8QYUFpikx9gqbG7+6Weno2R4JRoM6iB3QDtKzBBUEqZTL0
 hJBYSDzANj9QCbxN9feILBnGTY1+exwMRtcUM0z1zn85cSnYSRDyIYBiosSqY8si6uxf
 qiXLy/y9L2M7P0aLF8rrpUZu7sNoA+cz719L+ieMV2D5/MiENlWcc0MN5/PUaQDOiy5R
 J8cYk7eHnUEJfpdGXpLGEzzaG0VhV5tkat9HQnYwEK+/LmbwMdN8eif60qPhuBqihCZM
 Kii2HR2F2RV5LTMCCuYAnDdfJJvjM1Y+DUkVJQn0v73z8TR1APkgHxA4EXfQiD+MSyn3
 4UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785154916; x=1785759716;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+llmaMlWpAHIZaPqAfJxlNVhk3g2wZ3JW+34Ah/AdPI=;
 b=Y6AV12H6i3S5WzBe5X1rZvOgaM5pqDnOTyo3wN5EEJ2oOa5ydpMl0j0H8AtTl4iJ9F
 5FrnmGbKY02ZMBF5mcG4191PtWSBuJpPRtYWuP9FPocsj40D41jUoVo5QyeTlJALfyLJ
 6MTeOwahGyD5H/Xy29Dd1SABogzoqlQb5122MxM4XNlh0wFhXK5dccK9vaSL61QwjXu5
 +yG5Oz7TFdXeHqp41ktgyvNiloljjf+rcZIiRexcG3fBS+lnsIviQAt5e40LBv69Wc8W
 xbn9VmfibAMl3oxDmYAF8MknWAMn4rjUQFpzMy8kizhhxhL42TMbqh0Xd6TRrB8wGwMS
 1aAg==
X-Gm-Message-State: AOJu0Ywep8UtK/oewlrN3I145LOiisvoJarIrSc7JUTLfRY3g/y2BbwI
 hoqiqGRij7HXwPRoFkk8RTUKLUiiNai7oFb065SWmZUzvlEWId5mFXlV0Ol2QrFcHqM04xmx680
 UTdiTNjg3BWwB1bCvlZyGr8g7zpR/tOsfqmucExSN
X-Gm-Gg: AR+sD11mzVzT/HQfNQFpFIB81s6uWjTdykmcY39ZqAp9+X/h99EeHZmge84zoyuif8U
 lh47XeJUZPX8xGrXKGs66+Ww0i6G3iDwUWT10D37Evsf8SPAaRzoGdJVdB/gMFgJTKgMfaQHYuZ
 iN2vVdV7ByK4iGiM4513PoiHIb8B+6Zpdy/thdFBeabmn+qImZkyBPrNUHyPdyfoJwQ3R+XtEbb
 aYPHGFEE6XlVtIiMpJaqL3uIdhFyNf91I8yWz7Yc3FBpJgxbMnSO9AHToPsGiJtWTKekbs9X/Li
 bgpm4vGabqn/6yu2
X-Received: by 2002:a05:690e:b8e:b0:667:af58:8d6d with SMTP id
 956f58d0204a3-668ce49d69emr1888914d50.12.1785154915410; Mon, 27 Jul 2026
 05:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260724095737.3631000-1-wakel@google.com>
 <20260724121114.GB983347@pevik>
In-Reply-To: <20260724121114.GB983347@pevik>
Date: Mon, 27 Jul 2026 20:21:19 +0800
X-Gm-Features: AUfX_my2L9nAW0an1JD6NqbfpgXCNzl0XQ_XGWb1vU1f3h8GL_prGeIrLhIpqgY
Message-ID: <CAOcRiAG48VW3EqxSdAauBx0PFUQcXMy8b52B1Vnr=hjLcgNS=w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] listmount04: Detect EBADF behavior dynamically at
 runtime
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClRoYW5rcyBmb3IgdGhlIHJldmlldy4gSSd2ZSBqdXN0IHNlbnQgb3V0IHYyLgoK
VG8gYWRkcmVzcyB5b3VyIGNvbW1lbnRzOgotIGxpc3Rtb3VudCgpIGhlbHBlcjogV2UgY2FuJ3Qg
dXNlIGl0IGhlcmUgYmVjYXVzZSBpdCBjb25zdHJ1Y3RzIHRoZQpyZXF1ZXN0IHN0cnVjdCBpbnRl
cm5hbGx5IHdpdGggYG1udF9uc19mZCA9IDBgLiBXZSBuZWVkIHRvIHNldApgbW50X25zX2ZkID0g
LTFgIHRvIHRyaWdnZXIgdGhlIGVycm9yIGJlaGF2aW9yIHdlIGFyZSBwcm9iaW5nLgotIE1hY3Jv
IHJlbmFtZTogUmVuYW1lZCBCRUZPUkUvQUZURVJfNl8xN185IHRvIEJFRk9SRS9BRlRFUl82XzE4
IGFuZAphZGRlZCBhIG5vdGUgYWJvdXQgc3RhYmxlIGJhY2twb3J0cy4KLSBFTk9TWVMgY2hlY2s6
IFJlbW92ZWQgc2luY2UgYC5taW5fa3ZlciA9ICI2LjExImAgZ3VhcmFudGVlcyBsaXN0bW91bnQg
c3VwcG9ydC4KCkJlc3QgcmVnYXJkcywKV2FrZQoKCk9uIEZyaSwgSnVsIDI0LCAyMDI2IGF0IDg6
MTHigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+IFVwc3RyZWFt
IGNvbW1pdCA3OGYwZTMzY2Q2YzkgKCJmcy9uYW1lc3BhY2U6IGNvcnJlY3RseSBoYW5kbGUgZXJy
b3JzCj4gPiByZXR1cm5lZCBieSBncmFiX3JlcXVlc3RlZF9tbnRfbnMiKSBjaGFuZ2VkIHRoZSBl
cnJubyBmcm9tIEVJTlZBTCB0bwo+ID4gRUJBREYgd2hlbiBhbiBpbnZhbGlkIG1vdW50IG5hbWVz
cGFjZSBmaWxlIGRlc2NyaXB0b3IgaXMgcGFzc2VkIHRvCj4gPiBsaXN0bW91bnQoKS4gVGhpcyBj
aGFuZ2UgaGFzIGJlZW4gYmFja3BvcnRlZCB0byB2YXJpb3VzIHN0YWJsZSBrZXJuZWxzCj4gPiAo
ZS5nLiwgNi4xMi41OSBMVFMpLgo+Cj4gPiBJbnN0ZWFkIG9mIGhhcmRjb2RpbmcgdmVyc2lvbiBj
aGVja3MgZm9yIGV2ZXJ5IHN0YWJsZSBiYWNrcG9ydCwgcHJvYmUKPiA+IHRoZSBiZWhhdmlvciBk
eW5hbWljYWxseSBpbiBzZXR1cCgpIGJ5IGNhbGxpbmcgbGlzdG1vdW50KCkgd2l0aCBhbgo+ID4g
aW52YWxpZCBmZCAoLTEpIGFuZCBjaGVja2luZyB0aGUgcmV0dXJuZWQgZXJybm8uCj4KPiA+IFNp
Z25lZC1vZmYtYnk6IFdha2UgTGl1IDx3YWtlbEBnb29nbGUuY29tPgo+ID4gLS0tCj4gPiAgLi4u
L2tlcm5lbC9zeXNjYWxscy9saXN0bW91bnQvbGlzdG1vdW50MDQuYyAgIHwgMjcgKysrKysrKysr
KysrKysrKy0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQo+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saXN0
bW91bnQvbGlzdG1vdW50MDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGlzdG1vdW50
L2xpc3Rtb3VudDA0LmMKPiA+IGluZGV4IDkxOWY0Yzg1NC4uZjczNDM2MDhmIDEwMDY0NAo+ID4g
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saXN0bW91bnQvbGlzdG1vdW50MDQuYwo+
ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saXN0bW91bnQvbGlzdG1vdW50MDQu
Ywo+ID4gQEAgLTE1MywxNiArMTUzLDM1IEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQg
bikKPiA+ICAgICAgIH0KPgo+ID4gICAgICAgVFNUX0VYUF9GQUlMKHRzdF9zeXNjYWxsKF9fTlJf
bGlzdG1vdW50LCByZXEsIHRjLT5tbnRfaWRzLAo+ID4gLSAgICAgICAgICAgICB0Yy0+bnJfbW50
X2lkcywgdGMtPmZsYWdzKSwgdGMtPmV4cF9lcnJubywKPiA+IC0gICAgICAgICAgICAgIiVzIiwg
dGMtPm1zZyk7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGMtPm5yX21udF9p
ZHMsIHRjLT5mbGFncyksCj4gPiArICAgICAgICAgICAgICAgICAgdGMtPmV4cF9lcnJubywKPiA+
ICsgICAgICAgICAgICAgICAgICAiJXMiLCB0Yy0+bXNnKTsKPiA+ICB9Cj4KPiA+ICBzdGF0aWMg
dm9pZCBzZXR1cCh2b2lkKQo+ID4gIHsKPiA+IC0gICAgIGlmICh0c3Rfa3ZlcmNtcCg2LCAxNywg
OSkgPj0gMCkKPiA+ICsgICAgIG1udF9pZF9yZXEgcmVxID0gewo+ID4gKyAgICAgICAgICAgICAu
c2l6ZSA9IE1OVF9JRF9SRVFfU0laRV9WRVIwLAo+ID4gKyAgICAgICAgICAgICAubW50X2lkID0g
TFNNVF9ST09ULAo+ID4gKyAgICAgICAgICAgICAubW50X25zX2ZkID0gLTEsCj4gPiArICAgICB9
Owo+ID4gKyAgICAgdWludDY0X3QgaWRzW01OVF9TSVpFXTsKPiA+ICsKPiA+ICsgICAgIFRFU1Qo
dHN0X3N5c2NhbGwoX19OUl9saXN0bW91bnQsICZyZXEsIGlkcywgTU5UX1NJWkUsIDApKTsKPiBJ
IHdvbmRlciBpZiB3ZSBzaG91bGQgdXNlIGxpc3Rtb3VudCgpIGZyb20gbGlzdG1vdW50LmguCj4K
PiA+ICsgICAgIGlmIChUU1RfUkVUID49IDApCj4gPiArICAgICAgICAgICAgIHRzdF9icmsoVEJS
T0ssICJsaXN0bW91bnQoKSBzdWNjZWVkZWQgdW5leHBlY3RlZGx5IHdpdGggaW52YWxpZCBmZCIp
Owo+IE1heWJlIHdlIGNvdWxkIGhhdmUgVFNUX0VYUF9GQUlMX0FSUl9TSUxFTlRfQlJLKCkgaW4g
dGhlIGZ1dHVyZSA6KQo+Cj4gPiArCj4gPiArICAgICBpZiAoVFNUX0VSUiA9PSBFQkFERikgewo+
ID4gICAgICAgICAgICAgICBrdmVyID0gQUZURVJfNl8xN185Owo+IEF0IHRoaXMgcG9pbnQgd2Ug
bWF5IHJlbmFtZSBtYWNyb3MgYmFjayB0byBBRlRFUl82XzE4IGFuZCBCRUZPUkVfNl8xOCwgd2l0
aAo+IGtlZXBpbmcgbm90ZSB0aGF0IGl0IGdvdCBiYWNrcG9ydGVkIGludG8gc3RhYmxlLgo+Cj4g
PiAtICAgICBlbHNlCj4gPiArICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJEZXRlY3RlZCBr
ZXJuZWwgd2l0aCBFQkFERiBiZWhhdmlvciBmb3IgaW52YWxpZCBtbnRfbnNfZmQiKTsKPiA+ICsg
ICAgIH0gZWxzZSBpZiAoVFNUX0VSUiA9PSBFSU5WQUwpIHsKPiA+ICAgICAgICAgICAgICAga3Zl
ciA9IEJFRk9SRV82XzE3Xzk7Cj4gPiArICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJEZXRl
Y3RlZCBrZXJuZWwgd2l0aCBFSU5WQUwgYmVoYXZpb3IgZm9yIGludmFsaWQgbW50X25zX2ZkIik7
Cj4gPiArICAgICB9IGVsc2UgaWYgKFRTVF9FUlIgPT0gRU5PU1lTKSB7Cj4gPiArICAgICAgICAg
ICAgIHRzdF9icmsoVENPTkYsICJsaXN0bW91bnQoKSBzeXNjYWxsIG5vdCBzdXBwb3J0ZWQiKTsK
PiBUaGlzIGlzIElNSE8gbm90IHN1cHBvcnRlZCwgYmVjYXVzZSBpdCdzIHBhcnQgb2YgdHN0X3N5
c2NhbGwoKS4KPiBPdGhlciB0aGFuIHRoaXMgTEdUTS4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Cj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gPiArICAgICB9
IGVsc2Ugewo+ID4gKyAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LIHwgVFRFUlJOTywgIlVuZXhw
ZWN0ZWQgZXJyb3IgZHVyaW5nIHByb2JlIik7Cj4gPiArICAgICB9CgoKCi0tIApCZXN0IFJlZ2Fy
ZHMsCldha2UgTGl1CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
