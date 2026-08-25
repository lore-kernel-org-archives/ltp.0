Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602F7C61DB6
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787643553; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AEBY2x+7wPZvPn/9wEm7rN5HS8vGCJtCEKEsCmnU8Xc=;
 b=TtdnlsdDskv/GtWfTJ3aaKH8R1r2W6jJiEAoUmdZ+c4+XeN6icR/o3jn3j7FS7cGGi3f4
 6RCxY6MEli+9bS5mZKwCB/EZY60dblFfTaDd8uW8XjUhUdRvIuNGDYQlrvlaLrdjC8QZn4E
 MP68gcRsesQkH1VpiWGqipmRd+ePbXg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 502203D0FB7
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 09:39:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AA6F3CC02A
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 09:38:52 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9C116100095D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 09:38:51 +0200 (CEST)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-841f1dfc30fso7252477b3.1
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 00:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787643530; cv=none;
 d=google.com; s=arc-20260327;
 b=oqhILDdrA7s/xL9qq1KJ4lFO7eRmpncF78YRRbFIH6f0/W6P4D8MOc0B28In3WIgg0
 V3KON2wFWQXIhSu3J4Yia8Pot7faBVOsmIKCKHk2f4yz5XQGNCuZJ+p2xDLMiqxeWbEl
 6jpzKoqk2orcv8RhP1d1WiFoyj0Ek2aFKGpK8wL2LTa13ZRRnuqt59AR5aXdnd6dFflO
 yx2RCyA5gI+Q91JrPpCGjLkx5kReR+tv4NPX5t9O25e0zuCXthx1CC61w87gc8ALr+eJ
 LT70xA/Sy3OHbGUTIhlFOWxMyC0UPED/DI1iUgELp3LX/s+QldvgO3AbuTOBruTBS3Vc
 WK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fdh/pkR8U0XnQo5y6iAllbC3IgjwRZ0YSwv3J8DBvpA=;
 fh=ECLrvgdsFEgC/uMN8H1bU83vCVGiXkN09AH4447a9Mc=;
 b=IMRG1g0aCyRtQAJi0/7in2bfKEfrbaEyVSRwp/tIwLatZBXUSFas1Scf/p3wZNUfG2
 AiB25ZorkW/fw+0EPByBwqb7A7EsJWVwyJHvL1gBSB3x/SlVQSJ2v2CeiMuM0LWCG7oB
 xw3I/NMHqSaRurkbnL8eiRFKrCxQcDyIAtkQFg53zby1q4LQ2L/J+tLB02C2ivFQt3p3
 BtaJAx9/u56RtuGFQ6PkLyvcMpcm2yR+QZ0W1XIccwxiyf17exSi6o7jFscPXcPHdVkS
 HDjarXD80WBvjTWMSx5rnHJUAmIN9ae/8UB3zNGjSiKmYkCF6EK/4EpDQwQqJ6zGjIwL
 tBHQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787643530; x=1788248330; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fdh/pkR8U0XnQo5y6iAllbC3IgjwRZ0YSwv3J8DBvpA=;
 b=H2HsPx+x9QshHbY2DMkXfnSrhPkhBerYGMLqHxNa+CyTwqNfX60xK/7iBIi9O57V05
 YeVJSm2G5/9owEyVjPpvCXhgd98bes1OosP6RsDshNBP/a4F/SxIbgbfYrICxG1gFH7L
 NqRoI2RnK9vLjJA/Pye1GiNq0Qc8R1McWt2yTURcvhVMyYxFZdKJ241WNS9GISNJNsbC
 jypaWI7AbdpNcZPC/h8NO25EbIaWNKLLXjVJIqM6UFZ+C+WhSupPeKSvSmONCWuIdTqj
 7VYh2H91+NzhXGC7A523oQCJtbTqaIPY0YkO2LEUEvPdwXlpusXznPVa54gU37P8dQdD
 YCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643530; x=1788248330;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fdh/pkR8U0XnQo5y6iAllbC3IgjwRZ0YSwv3J8DBvpA=;
 b=QIED7iHSbZVHHKHf4/yblMyBar5XJIH7XQBQgwYfRVxhmvgwH9HPbmdkUHiFwRr72J
 JAibHDEDpWfBBRN97TRHkfIF+0xGg8gUnYfJogdZJNGeW1CwQ07JonZ053f2F2+OaDHf
 2pOBEy073u9H1AFXooCsEJ229DgrsmQZrPmoJjhkNSsR8b2VCa5BL3/20Xzh3H3DvK9r
 PcgEgbdu0k878WC4Nyg624/wqX8MVIM006LN2KwuWJZ7YyuXfAzTHunAimzrWnqIPW8s
 03AcKkF/oJbfT7Hjgitc2VfxuMVFz9BA56OHlhbddiPaZE2e+t+tv4OSlJg+5IGBTYkX
 M5Mw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6vGQWs/YDwjxh0oaxRHWz4R3nrchKWs64+sTjvA0G7EzMtHNUEutFKKp2kWMB6CuSKI8=@lists.linux.it
X-Gm-Message-State: AFuF++mS2ZDn683Jg7iwUhQRwt5xq9nNbSaDIJlyGsKcjFX32EUbCH+k
 n13FKSWEtT1hWC0cPk20c4RLCnadLKg6YazXynTKQxbO73fWkwQdDGoFyu+3lIYs1B5R39vb2B4
 ZKQvDepDCAK2Av3iLsaEI65tGoYs6wZHwq2eTLmkS
X-Gm-Gg: AR+sD13jznQT+AKZ48+5xiT9h6J5pNcD2Cm9oMzIVrTQhNLJMf5iw3nL9O6ShSu3ywG
 hr0vK2h1KTJmd7BYNI9jYVa7J9+BrdpSDPvSNNK3ytEZXbaIzpy2CmMj9b22yAOl6QGrdjOTO0j
 m4W/imx/iMpBFdqZRT77dIoRu0jw2Svf27nV1X5vFAHiIzcFEEuOqCGTlpWT/7T0DwOi+81b4cJ
 auUPU1MX6PR9pVdJBJ0wbnI0Dl1ihhpxyP1K4bUmPDiHMLhXR47XczCiZm+2zJWoELHMvdYG7/J
 2uSYnrSPMbtLQshM26dfZYAGw9X74hj3KB2+k1Ajt9Z0rkbFUEEwNPIp9bkXfpeVLuNinBYu9FE
 GZmHg
X-Received: by 2002:a05:690c:e1d3:10b0:853:954e:3552 with SMTP id
 00721157ae682-85473bb11a1mr15609517b3.9.1787643528973; Tue, 25 Aug 2026
 00:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260824085640.3514442-1-wakel@google.com>
 <f9ff4fd3-5d0c-4fb1-8aba-65d5f266c600@suse.com>
In-Reply-To: <f9ff4fd3-5d0c-4fb1-8aba-65d5f266c600@suse.com>
Date: Tue, 25 Aug 2026 15:38:13 +0800
X-Gm-Features: AcwNN1VHG-x-4FvP409KK-JEyaF0Bz_fnxM4bJ6ugwK8I9iZl_As29VH06NNofk
Message-ID: <CAOcRiAGhXKU=9T2rrKivxW_cwk=C1q0yVkDbbdc-egDkZoO-0Q@mail.gmail.com>
To: Avinesh Kumar <avinesh.kumar@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inode01: Increase dev_min_size to prevent ENOSPC
 on exfat
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

R290IGl0LCB0aGFua3MhCgpPbiBNb24sIEF1ZyAyNCwgMjAyNiBhdCA2OjE44oCvUE0gQXZpbmVz
aCBLdW1hciA8YXZpbmVzaC5rdW1hckBzdXNlLmNvbT4gd3JvdGU6Cj4KPiBIaSwKPgo+IFRoaXMg
aXNzdWUgaXMgYWxyZWRheSBiZWluZyBkaXNjdXNzZWQgaW4gdGhpcyBQUjoKPiBodHRwczovL2dp
dGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9wdWxsLzEzNDAKPgo+IFRoYW5rcywKPiBB
dmluZXNoCj4KPiBPbiA4LzI0LzI2IDEwOjU2IEFNLCBXYWtlIExpdSB3cm90ZToKPiA+IFRoZSBw
YXJhbGxlbCBzY2VuYXJpbyBjb25jdXJyZW50bHkgc3Bhd25zIG11bHRpcGxlIHdvcmtlcnMgKGRl
ZmF1bHQgNSksCj4gPiBlYWNoIGNyZWF0aW5nIDIsMTg1IGZpbGVzIGFuZCBkaXJlY3Rvcmllcywg
dG90YWxpbmcgMTAsOTI1IG9iamVjdHMuCj4gPgo+ID4gT24gZXhmYXQsIGVhY2ggZmlsZSBhbmQg
ZGlyZWN0b3J5IG9jY3VwaWVzIGF0IGxlYXN0IG9uZSBjbHVzdGVyIChkZWZhdWx0Cj4gPiAzMiBL
QiBmb3Igdm9sdW1lcyA+IDI1NiBNQiksIHdoaWNoIHJlcXVpcmVzIH4zNTAgTUIgb2YgZGF0YSBj
bHVzdGVycy4KPiA+IFdpdGggZmlsZXN5c3RlbSBtZXRhZGF0YSAoRkFULCBhbGxvY2F0aW9uIGJp
dG1hcCwgdXBjYXNlIHRhYmxlKSwKPiA+IGRpcmVjdG9yeSBncm93dGgsIGJvdW5kYXJ5IGFsaWdu
bWVudCwgYW5kIG11bHRpLXdvcmtlciBjb25jdXJyZW50Cj4gPiBhbGxvY2F0aW9uIGZyYWdtZW50
YXRpb24sIHRoZSBjdXJyZW50IDUxMiBNQiBkZXZpY2Ugc2l6ZSBpcyBlYXNpbHkKPiA+IGV4aGF1
c3RlZCwgbGVhZGluZyB0byBFTk9TUEMgZmFpbHVyZXMgZHVyaW5nIHdyaXRlKCkgb3IgbWtkaXIo
KToKPiA+Cj4gPiAgICBpbm9kZTAxLmM6NjE6IFRCUk9LOiB3cml0ZSgzLC4uLikgZmFpbGVkOiBF
Tk9TUEMgKDI4KQo+ID4gICAgaW5vZGUwMS5jOjY0OiBUQlJPSzogbWtkaXIoLi4uKSBmYWlsZWQ6
IEVOT1NQQyAoMjgpCj4gPgo+ID4gSW5jcmVhc2UgZGV2X21pbl9zaXplIHRvIDEwMjQgTUIgdG8g
cHJvdmlkZSBzdWZmaWNpZW50IGhlYWRyb29tIGZvciB0aGUKPiA+IHBhcmFsbGVsIHNjZW5hcmlv
IG9uIGV4ZmF0Lgo+ID4KPiA+IEZpeGVzOiBlY2Y0MTg3MjI3ODAgKCJpbm9kZTAxOiBpbmNyZWFz
ZSBkZXZfbWluX3NpemUgdG8gZml0IHRoZSBwZWFrIHVzYWdlIGluIHBhcmFsbGVsIHNjZW5hcmlv
IikKPiA+IFNpZ25lZC1vZmYtYnk6IFdha2UgTGl1IDx3YWtlbEBnb29nbGUuY29tPgo+ID4gLS0t
Cj4gPiAgIHRlc3RjYXNlcy9rZXJuZWwvZnMvaW5vZGUvaW5vZGUwMS5jIHwgNCArKy0tCj4gPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvZnMvaW5vZGUvaW5vZGUwMS5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9mcy9pbm9kZS9pbm9kZTAxLmMKPiA+IGluZGV4IGQ0MWZmMmM2Mi4uODdlZTA3
NjEyIDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9mcy9pbm9kZS9pbm9kZTAxLmMK
PiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvaW5vZGUvaW5vZGUwMS5jCj4gPiBAQCAtNjgs
NyArNjgsNyBAQCBzdGF0aWMgdm9pZCBjcmVhdGVfdHJlZShjb25zdCBzdHJ1Y3QgdGNhc2UgKnRj
LCBjb25zdCBjaGFyICpwYXJlbnQsCj4gPiAgIH0KPiA+Cj4gPiAgIHN0YXRpYyB2b2lkIHJlY29y
ZF9pbm9kZShzdHJ1Y3QgaW5vZGVfaW5mbyAqaW5vZGVzLCB1bnNpZ25lZCBpbnQgaWR4LAo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpwYXRoLCBpbm9fdCBpbm8pCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnBhdGgsIHVpbnQ2NF90IGlubykKPiA+
ICAgewo+ID4gICAgICAgaW5vZGVzW2lkeF0uaW5vID0gaW5vOwo+ID4gICAgICAgc25wcmludGYo
aW5vZGVzW2lkeF0ucGF0aCwgc2l6ZW9mKGlub2Rlc1tpZHhdLnBhdGgpLCAiJXMiLCBwYXRoKTsK
PiA+IEBAIC0yNTYsNyArMjU2LDcgQEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+
ID4gICAgICAgLm1vdW50X2RldmljZSA9IDEsCj4gPiAgICAgICAuYWxsX2ZpbGVzeXN0ZW1zID0g
MSwKPiA+ICAgICAgIC5uZWVkc19yb290ID0gMSwKPiA+IC0gICAgIC5kZXZfbWluX3NpemUgPSA1
MTIsCj4gPiArICAgICAuZGV2X21pbl9zaXplID0gMTAyNCwKPiA+ICAgICAgIC5mb3Jrc19jaGls
ZCA9IDEsCj4gPiAgICAgICAubmVlZHNfY2hlY2twb2ludHMgPSAxLAo+ID4gICAgICAgLnRpbWVv
dXQgPSAzMDAsCj4KCgotLSAKQmVzdCBSZWdhcmRzLApXYWtlIExpdQoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
