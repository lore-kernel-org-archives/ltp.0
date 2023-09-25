Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079D8CE7AA3
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 16:52:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35EEA3CDD33
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 18:52:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8926F3CD38C
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 18:52:00 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03D672005DD
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 18:52:00 +0200 (CEST)
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7ab30cee473so1683630241.2
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695660718; x=1696265518; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eh7n/+cLzjpARLvCjBzHgGhMYKtXqlHu85WkcQo8HuA=;
 b=jGTth/xNd+tOlUlstqZD4ON3lFAwTE0bGhiHPMollmoGWKuw1AhOipkMU4khyDC3eQ
 ys4lo5O+4t2hHJaQc16VVtdde0j1K8gQzR+MpURb3vwpL2PzJzzJayCDhvLv4DYotYsd
 tYq9nq+XB/S1HIRkHXpTw1JsEK0cZLVPLijL3L/Sb34MVpSYVjhTTzscENMbI6tk/nOJ
 LlLUcqHsoV1gHS4Dw2F7WgeK3hJA+egERh6vWdXtJc8h18UyQcTfwCP/kc8ZerYy/Ml4
 RV2oWktbiEy3jvETMMFky0vJA9P0goLEHkDxushptXrTQIY0LNzSRFVqJ3NqI8TTW0nk
 g3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695660718; x=1696265518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eh7n/+cLzjpARLvCjBzHgGhMYKtXqlHu85WkcQo8HuA=;
 b=vq7Fv5hMNtdA9x00Ekh1cFt1IS8LCkDJxzBYRB4MNrFTmw6zcgFTRqElA8FHb+EPlL
 ndCLevrptfKfaTAV5MXIqFgYhFGi22+MXfHv/olDpxM3GLDN4vIgx0Dl+5UQKv7cxBeA
 WMgpOwvtT4aIZfldm6lvs+idL1IflU4EqPoOEo8nn4bPt5+FT3Qp3NcvDObi8Vc5x0cM
 6hptf25H8aZpg/FswKO4yn9jwD9FqXAwctp8oRbfLGvMVWo44jOknPPEasjxrTOofGnM
 gboL56HZ6sDquPJ7IRy2XCPRdQoo7Ekz7DtOiq7kMB5qrRQKYLRCYScL5y1g77i7E4xs
 4nWw==
X-Gm-Message-State: AOJu0YxORfYsru0rCMyp1s6xf+awAXiTJjhLzlOttPQjBFAlZSE8Fhxg
 TfZCY6ERVM2Sm/GJjyWmvGAJEEY0Xk2YS8k1yNE=
X-Google-Smtp-Source: AGHT+IEEmKdeOkRNHmFizLT4hteSLXS/hMqmxgDmpUHuLNG/fZUm7J1RrjZ5mr7E3Qxx981iIDFT1lf1k0exV2dnk28=
X-Received: by 2002:a67:fb18:0:b0:452:78ea:4aec with SMTP id
 d24-20020a67fb18000000b0045278ea4aecmr3118054vsr.7.1695660718605; Mon, 25 Sep
 2023 09:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org>
 <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
 <ZREr3M32aIPfdem7@casper.infradead.org>
 <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
 <CAD_8n+QeGwf+CGNW_WnyRNQMu9G2_HJ4RSwJGq-b4CERpaA4uQ@mail.gmail.com>
In-Reply-To: <CAD_8n+QeGwf+CGNW_WnyRNQMu9G2_HJ4RSwJGq-b4CERpaA4uQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Sep 2023 19:51:47 +0300
Message-ID: <CAOQ4uxh7+avP=m8DW_u14Ea4Hrk1xhyuT--t2XX868CBquOCaA@mail.gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 lkp@intel.com, Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgNjozNuKAr1BNIFJldWJlbiBIYXdraW5zIDxyZXViZW5o
d2tAZ21haWwuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiBNb24sIFNlcCAyNSwgMjAyMyBhdCA0OjQz
4oCvQU0gQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Cj4+IE9u
IE1vbiwgU2VwIDI1LCAyMDIzIGF0IDk6NDLigK9BTSBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6Cj4+ID4KPj4gPiBPbiBTdW4sIFNlcCAyNCwgMjAyMyBhdCAxMToz
NTo0OFBNIC0wNTAwLCBSZXViZW4gSGF3a2lucyB3cm90ZToKPj4gPiA+IFRoZSB2MiBwYXRjaCBk
b2VzIE5PVCByZXR1cm4gRVNQSVBFIG9uIGEgc29ja2V0LiAgSXQgc3VjY2VlZHMuCj4+ID4gPgo+
PiA+ID4gcmVhZGFoZWFkMDEuYzo1NDogVElORk86IHRlc3RfaW52YWxpZF9mZCBwaXBlCj4+ID4g
PiByZWFkYWhlYWQwMS5jOjU2OiBURkFJTDogcmVhZGFoZWFkKGZkWzBdLCAwLCBnZXRwYWdlc2l6
ZSgpKSBleHBlY3RlZAo+PiA+ID4gRUlOVkFMOiBFU1BJUEUgKDI5KQo+PiA+ID4gcmVhZGFoZWFk
MDEuYzo2MDogVElORk86IHRlc3RfaW52YWxpZF9mZCBzb2NrZXQKPj4gPiA+IHJlYWRhaGVhZDAx
LmM6NjI6IFRGQUlMOiByZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2VzaXplKCkpIHN1Y2NlZWRl
ZAo+PiA+ID4gPC0tLS0tLS1oZXJlCj4+ID4KPj4gPiBUaGFua3MhICBJIGFtIG9mIHRoZSB2aWV3
IHRoYXQgdGhpcyBpcyB3cm9uZyAoYWx0aG91Z2ggcHJvYmFibHkKPj4gPiBoYXJtbGVzcykuICBJ
IHN1c3BlY3Qgd2hhdCBoYXBwZW5zIGlzIHRoYXQgd2UgdGFrZSB0aGUKPj4gPiAnYmRpID09ICZu
b29wX2JhY2tpbmdfZGV2X2luZm8nIGNvbmRpdGlvbiBpbiBnZW5lcmljX2ZhZHZpc2UoKQo+PiA+
IChzaW5jZSBJIGRvbid0IHNlZSBhbnl3aGVyZSBpbiBuZXQvIHNldHRpbmcgZl9vcC0+ZmFkdmlz
ZSkgYW5kIHNvCj4+ID4gcmV0dXJuIDAgd2l0aG91dCBkb2luZyBhbnkgd29yay4KPj4gPgo+PiA+
IFRoZSBjb3JyZWN0IHNvbHV0aW9uIGlzIHByb2JhYmx5IHlvdXIgdjIsIGNvbWJpbmVkIHdpdGg6
Cj4+ID4KPj4gPiAgICAgICAgIGlub2RlID0gZmlsZV9pbm9kZShmaWxlKTsKPj4gPiAtICAgICAg
IGlmIChTX0lTRklGTyhpbm9kZS0+aV9tb2RlKSkKPj4gPiArICAgICAgIGlmIChTX0lTRklGTyhp
bm9kZS0+aV9tb2RlKSB8fCBTX0lTU09DSyhpbm9kZS0+aV9tb2RlKSkKPj4gPiAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FU1BJUEU7Cj4+ID4KPj4gPiBpbiBnZW5lcmljX2ZhZHZpc2UoKSwgYnV0
IHRoYXQgdGhlbiBjaGFuZ2VzIHRoZSByZXR1cm4gdmFsdWUgZnJvbQo+PiA+IHBvc2l4X2ZhZHZp
c2UoKSwgYXMgSSBvdXRsaW5lZCBpbiBteSBwcmV2aW91cyBlbWFpbC4gIEFuZCBJJ20gT0sgd2l0
aAo+PiA+IHRoYXQsIGJlY2F1c2UgSSB0aGluayBpdCdzIHdoYXQgUE9TSVggaW50ZW5kZWQuICBB
bWlyIG1heSB3ZWxsIGRpc2FncmVlCj4+ID4gOy0pCj4+Cj4+IEkgcmVhbGx5IGhhdmUgbm8gcHJv
YmxlbSB3aXRoIHRoYXQgY2hhbmdlIHRvIHBvc2l4X2ZhZHZpc2UoKS4KPj4gSSBvbmx5IG1lYW50
IHRvIHNheSB0aGF0IHdlIGFyZSBub3QgZ29pbmcgdG8gYXNrIFJldWJlbiB0byB0YWxrIHRvCj4+
IHRoZSBzdGFuZGFyZCBjb21taXR0ZWUsIGJ1dCB0aGF0J3Mgb2J2aW91cyA7LSkKPj4gQSBwYXRj
aCB0byBtYW4tcGFnZXMsIHRoYXQgSSB3b3VsZCByZWNvbW1lbmQgYXMgYSBmb2xsb3cgdXAuCj4+
Cj4+IEZXSVcsIEkgY2hlY2tlZCBhbmQgdGhlcmUgaXMgY3VycmVudGx5IG5vIHRlc3QgZm9yCj4+
IHBvc2l4X2ZhZHZpc2UoKSBvbiBzb2NrZXQgaW4gTFRQIEFGQUlLLgo+PiBNYXliZSBDeXJpbCB3
aWxsIGZvbGxvdyB5b3VyIHN1Z2dlc3Rpb24gYW5kIHRoaXMgd2lsbCBhZGQgdGVzdAo+PiBjb3Zl
cmFnZSBmb3Igc29ja2V0IGluIHBvc2l4X2ZhZHZpc2UoKS4KPj4KPj4gUmV1YmVuLAo+Pgo+PiBU
aGUgYWN0aW9uYWJsZSBpdGVtLCBpZiBhbGwgYWdyZWUgd2l0aCBNYXR0aGV3J3MgcHJvcG9zYWws
IGlzCj4+IG5vdCB0byBjaGFuZ2UgdGhlIHYyIHBhdGNoIHRvIHJlYWRhaGVhZCgpLCBidXQgdG8g
c2VuZCBhIG5ldwo+PiBwYXRjaCBmb3IgZ2VuZXJpY19mYWR2aXNlKCkuCj4+Cj4+IFdoZW4geW91
IHNlbmQgdGhlIHBhdGNoIHRvIENocmlzdGlhbiwgeW91IHNob3VsZCBzcGVjaWZ5Cj4+IHRoZSBk
ZXBlbmRlbmN5IC0gaXQgbmVlZHMgdG8gYmUgYXBwbGllZCBiZWZvcmUgdGhlIHJlYWRhaGVhZAo+
PiBwYXRjaC4KPgo+Cj4gSSdtIGhhdmluZyBhIGJpdCBvZiBhIHRpbWUgY29taW5nIHVwIHdpdGgg
YSBjb21taXQgbWVzc2FnZSBmb3IgdGhpcwo+IGNoYW5nZSB0byBmYWR2aXNlLi4uSXQganVzdCBk
b2Vzbid0IHNvdW5kIGxpa2Ugc29tZXRoaW5nIEkgd291bGQgd2FudAo+IHRvIG1lcmdlLi4uCj4K
PiAiQ2hhbmdlIGZhZHZpc2UgdG8gcmV0dXJuIC1FU1BJUEUgZm9yIHNvY2tldHMuICBUaGlzIGlz
IGEgbmV3IGZhaWx1cmUKPiBtb2RlIHRoYXQgZGlkbid0IHByZXZpb3VzbHkgZXhpc3QuICBBcHBs
aWNhdGlvbnMgX21heV8gaGF2ZSB0byBhZGQgbmV3Cj4gZXJyb3IgaGFuZGxpbmcgbG9naWMgdG8g
YWNjb21tb2RhdGUgdGhlIG5ldyByZXR1cm4gdmFsdWUuICBJdCBuZWVkcyB0bwo+IGJlIGZpeGVk
IGluIGZhZHZpc2Ugc28gdGhhdCByZWFkYWhlYWQgd2lsbCBhbHNvIHJldHVybiBuZXcvdW5leHBl
Y3RlZAo+IGVycm9yIGNvZGVzLiIKPgo+IEl0IGp1c3QgZG9lc24ndCBmZWVsIHJpZ2h0LiAgTm9u
ZXRoZWxlc3MsIGhlcmUncyB0aGUgdGVzdCByZXN1bHRzIHdpdGgKPiB0aGUgZmFkdmlzZSBjaGFu
Z2UgKyB0aGUgdjIgcmVhZGFoZWFkIHBhdGNoLi4uCj4KPiByZWFkYWhlYWQwMS5jOjU0OiBUSU5G
TzogdGVzdF9pbnZhbGlkX2ZkIHBpcGUKPiByZWFkYWhlYWQwMS5jOjU2OiBURkFJTDogcmVhZGFo
ZWFkKGZkWzBdLCAwLCBnZXRwYWdlc2l6ZSgpKSBleHBlY3RlZCBFSU5WQUw6IEVTUElQRSAoMjkp
Cj4gcmVhZGFoZWFkMDEuYzo2MDogVElORk86IHRlc3RfaW52YWxpZF9mZCBzb2NrZXQKPiByZWFk
YWhlYWQwMS5jOjYyOiBURkFJTDogcmVhZGFoZWFkKGZkWzBdLCAwLCBnZXRwYWdlc2l6ZSgpKSBl
eHBlY3RlZCBFSU5WQUw6IEVTUElQRSAoMjkpCj4KPiBJdCBzZWVtcyB0byBtZSBsaWtlIEkgZml4
ZWQgc29tZXRoaW5nIGluIHJlYWRhaGVhZCB0aGF0IG9uY2Ugd29ya2VkLAo+IHJlYWRhaGVhZCBv
biBibG9jayBkZXZpY2VzLCBhbmQgSSdtIG5vdyBleGNoYW5naW5nIHRoYXQgb25jZSB3b3JraW5n
Cj4gYmVoYXZpb3IgdG8gYSBuZXcgZmFpbHVyZSB0byBzb2NrZXQsIHdoaWNoIHByZXZpb3VzbHkg
c3VjY2VlZGVkLi4uZXZlbgo+IGlmIGl0IGRpZG4ndCBkbyBhbnl0aGluZy4KPgo+IFNob3VsZCBJ
IGluc3RlYWQganVzdCBjaGVjayBmb3IgU19JU1NPQ0sgaW4gcmVhZGFoZWFkIHNvIHRoYXQgYm90
aCBwaXBlcwo+IGFuZCBzb2NrZXRzIHdpbGwgcmV0dXJuIEVJTlZBTCBpbiByZWFkYWhlYWQsIGFu
ZCBsZWF2ZSBmYWR2aXNlIGFzIGlzPwo+CgpXaGF0IHlvdSBhcmUgc2F5aW5nIG1ha2VzIHNlbnNl
LgpBbmQgaWYgd2UgYXJlIGJlaW5nIGhvbmVzdCwgSSB0aGluayB0aGF0IHRoZSByaWdodCB0aGlu
ZyB0byBkbyBmcm9tIHRoZQpiZWdpbm5pbmcgd2FzIHRvIHNlcGFyYXRlIHRoZSBidWcgZml4IGNv
bW1pdCBmcm9tIHRoZSBVQVBJIGNoYW5nZS4KClRoZSBtaW5pbWFsIGJ1ZyBmaXggaXMgU19JU1JF
RyB8fCBTX0lTQkxLLCB3aGljaAptZW50aW9ucyB0aGUgRml4ZXMgY29tbWl0IGFuZCB3aWxsIGJl
IHBpY2tlZCBmb3Igc3RhYmxlIGtlcm5lbHMuCgpGb2xsb3dpbmcgdXAgd2l0aCBhbm90aGVyIG9u
ZSBvciB0d28gcGF0Y2hlcyB0aGF0IGNoYW5nZQp0aGUgYmVoYXZpb3Igb2YgcG9zaXhfZmFkdmlz
ZSBvbiBzb2NrZXQgYW5kIHJlYWRhaGVhZCBvbgpzb2NrZXQgYW5kIHBpcGUuCgpUaGUgVUFQSSBj
aGFuZ2UgaXMgbm90IHNvbWV0aGluZyB0aGF0IGhhcyB0byBnbyB0byBzdGFibGUKYW5kIGl0IHNo
b3VsZCBiZSBlYXNpbHkgcmV2ZXJ0YWJsZSBpbmRlcGVuZGVudGx5IG9mIHRoZSBidWcgZml4LgpE
b2luZyBpdCBvdGhlcndpc2Ugd291bGQgbWFrZSBvdXIgbGl2ZXMgbXVjaCBoYXJkZXIgaWYgcmVn
cmVzc2lvbnMKdHVybiB1cCBmcm9tIHRoZSBVQVBJIGNoYW5nZS4KCkNocmlzdGlhbiwgTWF0dGhl
dywKCkRvIHlvdSBhZ3JlZT8KCj4+Cj4+Cj4+IElmIHRoZSByZWFkYWhlYWQgcGF0Y2ggd2FzIG5v
dCBhbHJlYWR5IGluIHRoZSB2ZnMgdHJlZSwgeW91Cj4+IHdvdWxkIGhhdmUgbmVlZGVkIHRvIHNl
bmQgYSBwYXRjaCBzZXJpZXMgd2l0aCBhIGNvdmVyIGxldHRlciwKPj4gd2hlcmUgeW91IHdvdWxk
IGxlYXZlIHRoZSBSZXZpZXdlZC1ieSBvbiB0aGUgdW5jaGFuZ2VkCj4+IFsyLzJdIHJlYWRhaGVh
ZCBwYXRjaC4KPj4KPj4gU2VuZGluZyBhIHBhdGNoIHNlcmllcyBpcyBhIGdvb2QgdGhpbmcgdG8g
cHJhY3RpY2UsIGJ1dCBpdCBpcwo+PiBub3Qgc3RyaWN0bHkgbmVlZGVkIGluIHRoaXMgY2FzZSwg
c28gSSdsbCBsZWF2ZSBpdCB1cCB0byB5b3UgdG8gZGVjaWRlLgo+PgoKUmV1YmVuLAoKSWYgdGhl
cmUgaXMgYWdyZWVtZW50IG9uIHRoZSBhYm92ZSwgeW91IG1heSBzdGlsbCBnZXQgeW91ciBjaGFu
Y2UKdG8gc2VuZCBhIHBhdGNoIHNldCA7KQoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
