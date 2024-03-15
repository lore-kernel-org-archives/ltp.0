Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C5EC54E66
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 03:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710474302; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=OEJwUVKmMmLFisjI3Glwkkz531tzS+EuEVMQWR8/gjY=;
 b=P+++7qZM9H4yAvcJ5Xvzpyd+6WeEG/r+0Q06UH0Z6bx5VsaigcRCoQBfN9itrmw8d1SI7
 erYNfrx1IHzaSvKvdDCdWmK/2/EFo6HIMw39HN1VA2bMp3lhtMM5mAj287DopX6ha109/eF
 qXjDxLVOapG6k/Ezr0pCWzU73Z1BtCg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 557DB3D02EB
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 04:45:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46BC63CD7F4
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 04:44:41 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48BCF60048C
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 04:44:40 +0100 (CET)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-513d9176cf9so316559e87.1
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 20:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710474279; x=1711079079; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PnAc8HiKgST1FY5SX2elDbZ8tgd6KEuZG0yfiuD4qis=;
 b=Ty3OoMs+gDvdrRRFgnU0h2lG+4gvBuFHv5spFCfPTsrJt8/VOsZ6TOKbrPTedUBnw/
 fPGjsQMfM9s61WZaE2ZKoe4vIUe5fH+q4RhSmcBurOg4LWZXRT40BCWp8jSCEgjQ0XTy
 JD21gWJPyrXvBwdGzpTKXO7ewCh8axFiWYaHxm/eu0/pIC8KOZP/hAQUw37D0oDVM++2
 w+x8jjgi39OlhRnhPkJgOe9sGCqN7B77zoCynbzzgCTabS9oFztrzeny3YNPwYGeKTWk
 voG6hs95fLVlPVt5rFVrB7nd2FyUOciftPcLmD6gcRC15f8IZydYLS8FKG6dlG5yWMtO
 w3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710474279; x=1711079079;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PnAc8HiKgST1FY5SX2elDbZ8tgd6KEuZG0yfiuD4qis=;
 b=SejKKxt7R29i9TwslWH8c0pANl8EmpPqfsnV3NbNhWUAdj0YIApsVWXMjqIK9REIK6
 k8vhTnQLvtx6yolDnQZRsu7InWUdbqLyp7oGY3AZFsRv42fLp8a+D/CGDdvtRIzD07ry
 IR/A6r71NNXigPFJsrinHPT1hEK/DGjJS5Y/bWV1HnJE7TgQL/zbLO95VgiHvE1Rn5tN
 uY/C85QPZDPceWTd1/fOx/dVLFj2g3+oZzuuQCVbMAZPP+uDvZldIlhmI/VByaKtG3uE
 UsAFNADixYfN/ZUVS5L+cLb1qmm4vynThEzU2RqNpII5LZJrRwINtrJfDNPQOM6g4x6n
 zcww==
X-Gm-Message-State: AOJu0Yw6tN5VP62lUf3VV4lT9+Cv5BjvTBrQBVITdvQLCRtv+PMilgAF
 05AD+FanhCHxkKq8y3yGQG6+XOuUxNjGkJ8B+NKIRen1IFuxaet11spvUeSYkQ==
X-Google-Smtp-Source: AGHT+IH0EDR8aiketmYUICSoti/cZuHGebGjBJ6CnZqz1Cz+Z/IDNmHcnloz2EW0o+iedK4s8mdDVw==
X-Received: by 2002:a19:914e:0:b0:513:93dd:9ecd with SMTP id
 y14-20020a19914e000000b0051393dd9ecdmr1299125lfj.21.1710474279474; 
 Thu, 14 Mar 2024 20:44:39 -0700 (PDT)
Received: from wegao.185.0.200 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 fd11-20020a056402388b00b0056887c3ce6bsm1251657edb.65.2024.03.14.20.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 20:44:39 -0700 (PDT)
Date: Thu, 14 Mar 2024 23:44:28 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <ZfPEHJNRH16jRQAU@wegao.185.0.200>
References: <20240314013320.5536-1-wegao@suse.com>
 <CAEemH2dn7zRijqq-ZmxsS7CSh2__dzVzpP9ZsPh3APmYWvu=mg@mail.gmail.com>
 <ZfOkrcg5Kt9l59Ss@wegao.68.199.193>
 <CAEemH2dgxRPG1xRQRFdyFPjr+awKL33Fp5xgdMAA=3=t-K19VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dgxRPG1xRQRFdyFPjr+awKL33Fp5xgdMAA=3=t-K19VQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapon01.c: Apply a margin to avoid oom
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMTUsIDIwMjQgYXQgMTE6MTc6MDFBTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBGcmksIE1hciAxNSwgMjAyNCBhdCA5OjMw4oCvQU0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5j
b20+IHdyb3RlOgo+IAo+ID4gT24gVGh1LCBNYXIgMTQsIDIwMjQgYXQgMDI6NDA6NDBQTSArMDgw
MCwgTGkgV2FuZyB3cm90ZToKPiA+ID4gSGkgV2VpLAo+ID4gPgo+ID4gPiBPbiBUaHUsIE1hciAx
NCwgMjAyNCBhdCA5OjMz4oCvQU0gV2VpIEdhbyB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+
Cj4gPiB3cm90ZToKPiA+ID4KPiA+ID4gPiBEdXJpbmcgb3VyIHRlc3QgaSBmaW5kIGEgb29tIGVy
cm9yIGR1cmluZyB0ZXN0IHdoaWNoIHRyaWdnZXJlZCBieQo+ID4gPiA+IHRzdF9wb2xsdXRlX21l
bW9yeS4KPiA+ID4gPgo+ID4gPiA+IGtlcm5lbDoKPiA+ID4gPgo+ID4gb29tLWtpbGw6Y29uc3Ry
YWludD1DT05TVFJBSU5UX01FTUNHLG5vZGVtYXNrPShudWxsKSxjcHVzZXQ9LyxtZW1zX2FsbG93
ZWQ9MC0xLG9vbV9tZW1jZz0vbHRwL3Rlc3QtOTU1Mix0YXNrX21lbWNnPS9sdHAvdGVzdC05NTUy
MAo+ID4gPiA+IGtlcm5lbDogTWVtb3J5IGNncm91cCBvdXQgb2YgbWVtb3J5OiBLaWxsZWQgcHJv
Y2VzcyA5NTc1IChzd2Fwb24wMSkKPiA+ID4gPiB0b3RhbC12bToxMDUxNDg0a0IsIGFub24tcnNz
OjEwNDY1NzJrQiwgZmlsZS1yc3M6MTI4MGtCLCBzaG1lbS1yc3M6MGswCj4gPiA+ID4KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiA+ID4gPiAtLS0KPiA+
ID4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYyB8IDQgKysr
LQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cj4gPiA+ID4KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9z
d2Fwb24vc3dhcG9uMDEuYwo+ID4gPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fw
b24vc3dhcG9uMDEuYwo+ID4gPiA+IGluZGV4IGQ0MDZlNGJkOS4uMzU3OTkyNTI1IDEwMDY0NAo+
ID4gPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMK
PiA+ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5j
Cj4gPiA+ID4gQEAgLTQxLDcgKzQxLDkgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiA+ID4g
PiAgICAgICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAxMCwgMCk7Cj4gPiA+ID4KPiA+ID4g
PiAgICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgImNncm91cC5wcm9jcyIsICIlZCIsIGdl
dHBpZCgpKTsKPiA+ID4gPiAtICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5t
YXgiLCAiJWx1IiwgVEVTVE1FTSk7Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICAgICAgLyogQXBwbHkg
YSBtYXJnaW4gdG8gYXZvaWQgb29tIGR1cmluZyB0c3RfcG9sbHV0ZV9tZW1vcnkgKi8KPiA+ID4g
PiArICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5tYXgiLCAiJWx1IiwgVEVT
VE1FTSArCj4gPiBURVNUTUVNLzEwMCk7Cj4gPiA+ID4KPiA+ID4KPiA+ID4gRXZlbiB3aXRoIGEg
Yml0IG9mIG1hcmdpbiBhZGRlZCB0aGVyZSBpcyBzdGlsbCBub3QgZ3VhcmFudGVlIHRvIGF2b2lk
IE9PTQo+ID4gPiBjb21wbGV0ZWx5Lgo+ID4gPgo+ID4gPiBBcyB0aGUgQ2dyb3VwIFYxIGFuZCBW
MiB0cmFjayBtZW1vcnkgYW5kIHN3YXAgaW4gdHdvIHdheXMsIGlmIHRoZSBtYXJnaW4KPiA+IGlz
Cj4gPiA+IHRvbyBsYXJnZSB0aGF0IG1pZ2h0IG5vdCBtYWtlIHRoZSBzd2FwIGhhcHBlbiB3aGlj
aCBpcyBub3Qgb3VyCj4gPiBleHBlY3RhdGlvbi4KPiA+ID4KPiA+ID4gU28gb3RoZXIgbWV0aG9k
IEkgY2FuIHRoaW5rIG9mIGlzIHRvIGRpc2FibGUgdGhlIE9PTSBpbiBDZ291cCwKPiA+ID4gICAg
IGVjaG8gMSA+IG1lbW9yeS5vb21fY29udHJvbAo+ID4gVGhpcyBvcHRpb24gbm90IGV4aXN0IGlu
IGNncm91cHYyLCBpdCBzZWVtcyBubyBkaXJlY3Qgb29tIGNvbnRyb2wgZm9yCj4gPiBjZ3JvdXB2
Mgo+ID4KPiAKPiBPaywgd2hpY2ggdmVyc2lvbiAoZm91bmQgdGhlIE9PTSBpc3N1ZSkgZGlkIHlv
dSB0ZXN0IG9uPwptb3VudCB8IGdyZXAgY2dyb3VwCmNncm91cDIgb24gL3N5cy9mcy9jZ3JvdXAg
dHlwZSBjZ3JvdXAyIChydyxub3N1aWQsbm9kZXYsbm9leGVjLHJlbGF0aW1lLG5zZGVsZWdhdGUs
bWVtb3J5X3JlY3Vyc2l2ZXByb3QpCj4gTWF5YmUgaGVyZSB3ZSBoYXZlIHRvIHNwbGl0IHRoZSBj
b250cm9sIHdvcmsgaW50byB0d28gcGFydHMgKFYxIGFuZCBWMikuCkhvdyB0byBkaXNhYmxlIE9P
TSBhbmQgYWxzbyBsZXQgc3dhcCBhY3Rpb24gaGFwcGVuIGF0IHRoZSBzYW1lIHRpbWUgZm9yIGNn
cm91cCBWMj8KClRoYW5rcyBmb3IgeW91ciBzdWNoIHF1aWNrIGZlZWRiYWNrIDopCj4gCj4gCj4g
Cj4gPiA+IG9yLCBzZXQgYG92ZXJjb21taXRfbWVtb3J5YCB0byAyIHRvIHByZXZlbnQgdGhlIE9P
TSBmcm9tIG9jY3VycmluZy4KPiA+ID4gICAgIGVjaG8gMiA+IC9wcm9jL3N5cy92bS9vdmVyY29t
bWl0X21lbW9yeQo+ID4gSSBoYXZlIHRyaWVkIHRoaXMgb3B0aW9uLCBvb20gc3RpbGwgaGFwcGVu
Lgo+ID4KPiAKPiBXZWxsLCBpdCBsb29rcyBsaWtlIG92ZXJjb21taXQgY29udHJvbGxlZCBieSBv
dmVyY29tbWl0X21lbW9yeSBpcwo+IGFsbG93ZWQgZm9yIHRoZSBlbnRpcmUgc3lzdGVtLCBub3Qg
anVzdCB0aGUgQ2dyb3VwLgo+IAo+IAo+IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
