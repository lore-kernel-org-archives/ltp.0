Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA24C54E58
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 05:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710480305; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iJky8fCI0pWQxNOv8r137TYWLIl9/lDJFvStgTGCRME=;
 b=OnJXk2vH/L9wkj6AWbJk7DLjduBF8NW9P+3iLZYXuR6PJf63zOuBP5FCvFD6mqNqNFg5y
 i43XofB5S2WxGwybui16FZdqh7FWa/eHZnnXLr5e8nToEmuVvb2aYlFnYYw8U9o9hYh4AzK
 y3xcgIkUCnUKS9t5IRNdywnLaSQA6rs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B45A3CFD28
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 06:25:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDF1C3C01AF
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 06:24:41 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C45F41401238
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 06:24:40 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a466e53f8c0so203256066b.1
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 22:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710480280; x=1711085080; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1yQTbbqWc+aZKyUgNjRalI1QvND8RvESbCqwLfjAqbY=;
 b=IekwsXAjMkDuuVXFPFb910h+y9WOcnbV8r/nNNhdpRZrRmTkdVe2wGPB1f7OvqOHPl
 xF/9yqcTZFyRBkmp2bQ+eljDj5ZREX/9ig3yeksXrHh8nf+1gjNNKMKgWirAg7+bYTGn
 /pBQ2k43LMxTA+j2ug1tD6LIhklYaMBY7O9ovCIajxdgrCtNuW0Vf1gz7qYm5qN/JZvd
 Q1VhDGiaTmvI0QNw93gRNIyTQhM75PxjT369W3b4hWAx90H+EuMyG4XOE1Ukt3WSc2GY
 D8EFQSpxbp0RZbAMBHD35Apb4uqm3lz0x2N6SQIQfCoR73ZUvjzkYIta7KE2KWp7O7mg
 MV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710480280; x=1711085080;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1yQTbbqWc+aZKyUgNjRalI1QvND8RvESbCqwLfjAqbY=;
 b=Za2IuJvESJAQvudpQsI96+z4lGTG9T6MG08NXNp4fLsYJbxErH8lv7j/NiYlgBy9R6
 UcWgvN1isAGdL426UsboBuxpQ12Npq3qmw1Nkkk5Q4zT7WCgNwCtCvHM7aTwyGihzmgS
 IOtULw1nYMgq6VyNLiBMoJpjwPHHHeLiLSYwiaDrGsEhhmWEIlRSo8YMjst2Qw6XrdhO
 96lNjP9AJZPLlU6B9uSt2p+MM+NwTnXVWEKd/wQyPeq1p2LYgAsDjfEnt9DNZM/NQ9eZ
 WGaXSmVNjwNzL7dTngto1+wS09VjVjysUeUsL/89v7Rk3offLAjEPkGjEl5AgzKDuzZF
 h3nA==
X-Gm-Message-State: AOJu0Yyy1BlFBi92WPB/cqSLgCpOax4bTSh+19YkyFOSZmWGbplDYS2O
 ZtmYYiXSC6cAoe87Q7Oxn2lNkmZQrRZThbP1CRYgWKgdufHidbocgFAKxiLPX2fEmhqDzc8nLWk
 =
X-Google-Smtp-Source: AGHT+IHBEWVfOcBQT3V92rT8sfFmLlf3j9boDAT1EdyJLVtiiMDa7FYkZ1//uGGfsH4pkhhmeojAeg==
X-Received: by 2002:a17:906:24d6:b0:a46:58ac:8b55 with SMTP id
 f22-20020a17090624d600b00a4658ac8b55mr2645482ejb.15.1710480280045; 
 Thu, 14 Mar 2024 22:24:40 -0700 (PDT)
Received: from wegao.14.93.120 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 jz8-20020a17090775e800b00a461d2a3374sm1338395ejc.47.2024.03.14.22.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 22:24:39 -0700 (PDT)
Date: Fri, 15 Mar 2024 01:24:33 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <ZfPbkYq5uvwW1kSk@wegao.14.93.120>
References: <20240314013320.5536-1-wegao@suse.com>
 <CAEemH2dn7zRijqq-ZmxsS7CSh2__dzVzpP9ZsPh3APmYWvu=mg@mail.gmail.com>
 <ZfOkrcg5Kt9l59Ss@wegao.68.199.193>
 <CAEemH2dgxRPG1xRQRFdyFPjr+awKL33Fp5xgdMAA=3=t-K19VQ@mail.gmail.com>
 <ZfPEHJNRH16jRQAU@wegao.185.0.200>
 <CAEemH2erkkB5Mj_WiGjErK-Z5Dc7bY_2D7Lu-nBpsqyFeo=8sA@mail.gmail.com>
 <CAEemH2cmfS3US4ZCTeK2gGjHLm7LFgF+y9gwjcDEfEDfkRZykQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cmfS3US4ZCTeK2gGjHLm7LFgF+y9gwjcDEfEDfkRZykQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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

T24gRnJpLCBNYXIgMTUsIDIwMjQgYXQgMTI6MTk6NTJQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBGcmksIE1hciAxNSwgMjAyNCBhdCAxMjowOeKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiAKPiA+Cj4gPgo+ID4gT24gRnJpLCBNYXIgMTUsIDIwMjQgYXQgMTE6
NDTigK9BTSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4gd3JvdGU6Cj4gPgo+ID4+IE9uIEZyaSwg
TWFyIDE1LCAyMDI0IGF0IDExOjE3OjAxQU0gKzA4MDAsIExpIFdhbmcgd3JvdGU6Cj4gPj4gPiBP
biBGcmksIE1hciAxNSwgMjAyNCBhdCA5OjMw4oCvQU0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+
IHdyb3RlOgo+ID4+ID4KPiA+PiA+ID4gT24gVGh1LCBNYXIgMTQsIDIwMjQgYXQgMDI6NDA6NDBQ
TSArMDgwMCwgTGkgV2FuZyB3cm90ZToKPiA+PiA+ID4gPiBIaSBXZWksCj4gPj4gPiA+ID4KPiA+
PiA+ID4gPiBPbiBUaHUsIE1hciAxNCwgMjAyNCBhdCA5OjMz4oCvQU0gV2VpIEdhbyB2aWEgbHRw
IDxsdHBAbGlzdHMubGludXguaXQKPiA+PiA+Cj4gPj4gPiA+IHdyb3RlOgo+ID4+ID4gPiA+Cj4g
Pj4gPiA+ID4gPiBEdXJpbmcgb3VyIHRlc3QgaSBmaW5kIGEgb29tIGVycm9yIGR1cmluZyB0ZXN0
IHdoaWNoIHRyaWdnZXJlZCBieQo+ID4+ID4gPiA+ID4gdHN0X3BvbGx1dGVfbWVtb3J5Lgo+ID4+
ID4gPiA+ID4KPiA+PiA+ID4gPiA+IGtlcm5lbDoKPiA+PiA+ID4gPiA+Cj4gPj4gPiA+Cj4gPj4g
b29tLWtpbGw6Y29uc3RyYWludD1DT05TVFJBSU5UX01FTUNHLG5vZGVtYXNrPShudWxsKSxjcHVz
ZXQ9LyxtZW1zX2FsbG93ZWQ9MC0xLG9vbV9tZW1jZz0vbHRwL3Rlc3QtOTU1Mix0YXNrX21lbWNn
PS9sdHAvdGVzdC05NTUyMAo+ID4+ID4gPiA+ID4ga2VybmVsOiBNZW1vcnkgY2dyb3VwIG91dCBv
ZiBtZW1vcnk6IEtpbGxlZCBwcm9jZXNzIDk1NzUKPiA+PiAoc3dhcG9uMDEpCj4gPj4gPiA+ID4g
PiB0b3RhbC12bToxMDUxNDg0a0IsIGFub24tcnNzOjEwNDY1NzJrQiwgZmlsZS1yc3M6MTI4MGtC
LAo+ID4+IHNobWVtLXJzczowazAKPiA+PiA+ID4gPiA+Cj4gPj4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiA+PiA+ID4gPiA+IC0tLQo+ID4+ID4gPiA+
ID4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMgfCA0ICsrKy0K
PiA+PiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCj4gPj4gPiA+ID4gPgo+ID4+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMKPiA+PiA+ID4gPiA+IGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4+ID4gPiA+ID4gaW5kZXggZDQwNmU0
YmQ5Li4zNTc5OTI1MjUgMTAwNjQ0Cj4gPj4gPiA+ID4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPj4gPiA+ID4gPiArKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPj4gPiA+ID4gPiBAQCAtNDEsNyAr
NDEsOSBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4+ID4gPiA+ID4gICAgICAgICBtYWtl
X3N3YXBmaWxlKFNXQVBfRklMRSwgMTAsIDApOwo+ID4+ID4gPiA+ID4KPiA+PiA+ID4gPiA+ICAg
ICAgICAgU0FGRV9DR19QUklOVEYodHN0X2NnLCAiY2dyb3VwLnByb2NzIiwgIiVkIiwgZ2V0cGlk
KCkpOwo+ID4+ID4gPiA+ID4gLSAgICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJtZW1vcnku
bWF4IiwgIiVsdSIsIFRFU1RNRU0pOwo+ID4+ID4gPiA+ID4gKwo+ID4+ID4gPiA+ID4gKyAgICAg
ICAvKiBBcHBseSBhIG1hcmdpbiB0byBhdm9pZCBvb20gZHVyaW5nIHRzdF9wb2xsdXRlX21lbW9y
eQo+ID4+ICovCj4gPj4gPiA+ID4gPiArICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1l
bW9yeS5tYXgiLCAiJWx1IiwgVEVTVE1FTSArCj4gPj4gPiA+IFRFU1RNRU0vMTAwKTsKPiA+PiA+
ID4gPiA+Cj4gPj4gPiA+ID4KPiA+PiA+ID4gPiBFdmVuIHdpdGggYSBiaXQgb2YgbWFyZ2luIGFk
ZGVkIHRoZXJlIGlzIHN0aWxsIG5vdCBndWFyYW50ZWUgdG8KPiA+PiBhdm9pZCBPT00KPiA+PiA+
ID4gPiBjb21wbGV0ZWx5Lgo+ID4+ID4gPiA+Cj4gPj4gPiA+ID4gQXMgdGhlIENncm91cCBWMSBh
bmQgVjIgdHJhY2sgbWVtb3J5IGFuZCBzd2FwIGluIHR3byB3YXlzLCBpZiB0aGUKPiA+PiBtYXJn
aW4KPiA+PiA+ID4gaXMKPiA+PiA+ID4gPiB0b28gbGFyZ2UgdGhhdCBtaWdodCBub3QgbWFrZSB0
aGUgc3dhcCBoYXBwZW4gd2hpY2ggaXMgbm90IG91cgo+ID4+ID4gPiBleHBlY3RhdGlvbi4KPiA+
PiA+ID4gPgo+ID4+ID4gPiA+IFNvIG90aGVyIG1ldGhvZCBJIGNhbiB0aGluayBvZiBpcyB0byBk
aXNhYmxlIHRoZSBPT00gaW4gQ2dvdXAsCj4gPj4gPiA+ID4gICAgIGVjaG8gMSA+IG1lbW9yeS5v
b21fY29udHJvbAo+ID4+ID4gPiBUaGlzIG9wdGlvbiBub3QgZXhpc3QgaW4gY2dyb3VwdjIsIGl0
IHNlZW1zIG5vIGRpcmVjdCBvb20gY29udHJvbCBmb3IKPiA+PiA+ID4gY2dyb3VwdjIKPiA+PiA+
ID4KPiA+PiA+Cj4gPj4gPiBPaywgd2hpY2ggdmVyc2lvbiAoZm91bmQgdGhlIE9PTSBpc3N1ZSkg
ZGlkIHlvdSB0ZXN0IG9uPwo+ID4+IG1vdW50IHwgZ3JlcCBjZ3JvdXAKPiA+PiBjZ3JvdXAyIG9u
IC9zeXMvZnMvY2dyb3VwIHR5cGUgY2dyb3VwMgo+ID4+IChydyxub3N1aWQsbm9kZXYsbm9leGVj
LHJlbGF0aW1lLG5zZGVsZWdhdGUsbWVtb3J5X3JlY3Vyc2l2ZXByb3QpCj4gPj4gPiBNYXliZSBo
ZXJlIHdlIGhhdmUgdG8gc3BsaXQgdGhlIGNvbnRyb2wgd29yayBpbnRvIHR3byBwYXJ0cyAoVjEg
YW5kIFYyKS4KPiA+Pgo+ID4KPiA+Cj4gPj4gSG93IHRvIGRpc2FibGUgT09NIGFuZCBhbHNvIGxl
dCBzd2FwIGFjdGlvbiBoYXBwZW4gYXQgdGhlIHNhbWUgdGltZSBmb3IKPiA+PiBjZ3JvdXAgVjI/
Cj4gPj4KPiA+Cj4gPiBUaGUgQ2dyb3VwIHYyIGRvZXMgbm90IHByb3ZpZGUgYSB3YXkgdG8gZGlz
YWJsZSBPT00gaW5zaWRlIGRpcmVjdGx5Lgo+ID4KPiA+IElmIHdlIHdhbnQgdG8gYXZvaWQgT09N
IGhhcHBlbmluZywganVzdCBoYXZlIHRvIG1hbmFnZSBPT00gYmVoYXZpb3IKPiA+IGluIGNncm91
cCB2MiBieSBzZXR0aW5nIGFwcHJvcHJpYXRlIHZhbHVlcyBmb3IgJ21lbW9yeS5tYXgnLCAnbWVt
b3J5LmhpZ2gnLAo+ID4gYW5kIHVzaW5nICdtZW1vcnkub29tLmdyb3VwJyB0byBkZXRlcm1pbmUg
d2hldGhlciB0aGUgT09NIGtpbGxlciBzaG91bGQKPiA+IHRhcmdldCBpbmRpdmlkdWFsIHByb2Nl
c3NlcyBvciB0aGUgd2hvbGUgQ2dyb3VwLgo+ID4KPiA+IEFmdGVyIGxvb2tpbmcgYmFjayBhdCB0
aGlzIGNhc2UgYWdhaW4sIEkgZ3Vlc3MgdGhlIG1haW4gcmVhc29uIGlzIHRoYXQgdGhlCj4gPiBz
d2FwZmlsZSBpcyB0b28gc21hbGwgdG8gYmVhciB0aGUgbWVtb3J5IGxvYWQsIG9uZSBkaXJlY3Qg
bWV0aG9kIGlzIGxpa2UKPiA+IHlvdSB0byBlbmxhcmdlIHRoZSAnbWVtb3J5Lm1heCcgdmFsdWUs
IGJ1dCB0aGF0IHN0aWxsIGRvZXMgbm90IHJlc29sdmUKPiA+IHByb2JsZW1zIGV2ZW50dWFsbHku
Cj4gPgo+ID4gT25lIHBvc3NpYmxlIHNvbHV0aW9uIGlzIGNyYXRlIGEgYml0IGxhcmdlciBzd2Fw
ZmlsZSBmb3IgdGhlIHRlc3QsIGFuZAo+ID4gdW5saW1pdGVkCj4gPiB0aGUgc3dhcCBvdXQgc2l6
ZS4gQ2FuIHlvdSB0cnkgdGhpcyBwYXRjaCBvbiB5b3VyIHN5c3RlbT8KVGhpcyBub3Qgd29yay4K
PiA+Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5j
Cj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4g
PiBAQCAtMzgsMTAgKzM4LDE0IEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9zd2Fwb24odm9pZCkKPiA+
ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gIHsKPiA+ICAgICAgICAgaXNfc3dhcF9zdXBw
b3J0ZWQoU1dBUF9GSUxFKTsKPiA+IC0gICAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDEw
LCAwKTsKPiA+ICsgICAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDEwMjQsIDApOwo+ID4K
PiA+ICAgICAgICAgU0FGRV9DR19QUklOVEYodHN0X2NnLCAiY2dyb3VwLnByb2NzIiwgIiVkIiwg
Z2V0cGlkKCkpOwo+ID4gICAgICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJtZW1vcnkubWF4
IiwgIiVsdSIsIFRFU1RNRU0pOwo+ID4gKyAgICAgICBpZiAoVFNUX0NHX1ZFUl9JU19WMSh0c3Rf
Y2csICJtZW1vcnkiKSkKPiA+ICsgICAgICAgICAgICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2cs
ICJtZW1vcnkuc3dhcC5tYXgiLCAiJWx1IiwgfjBVTCk7Cj4gPiArICAgICAgIGVsc2UKPiA+ICsg
ICAgICAgICAgICAgICBTQUZFX0NHX1BSSU5UKHRzdF9jZywgIm1lbW9yeS5zd2FwLm1heCIsICJt
YXgiKTsKPiA+ICB9Cj4gPgo+ID4gIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+
Cj4gCj4gSWYgdGhpcyBzdGlsbCBkb2VzIG5vdCB3b3JrIGFzIGV4cGVjdGVkLCB0aGVuIHdlIG5l
ZWQgcGx1cyBhZGRpdGlvbmFsCj4gcG9saWN5IHRvIHNocmluayB0aGUgcG9sbHV0ZSBtZW1vcnkg
c2l6ZS4KPiAKPiAtICAgICAgIHRzdF9wb2xsdXRlX21lbW9yeShURVNUTUVNLCAweDQxKTsKPiAr
ICAgICAgIHRzdF9wb2xsdXRlX21lbW9yeShURVNUTUVNICogOS8xMCwgMHg0MSk7ClRoaXMgd29y
a3MuCj4gCj4gPgo+IAo+IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
