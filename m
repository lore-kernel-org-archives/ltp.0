Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8578C678D4
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 14:55:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0E143CDAF1
	for <ltp@archiver.kernel.org>; Mon,  6 Mar 2023 15:55:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9B6F3CAFC7
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 15:55:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D1FEE6001F4
 for <ltp@lists.linux.it>; Mon,  6 Mar 2023 15:55:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57233223A0;
 Mon,  6 Mar 2023 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678114503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1FFKOv3teh7wpjpO6ZZ/XaSpcS5jnsGesY43qcB2V00=;
 b=qeqAx/LR4npiWAbX0pTtsSsfRqAwzo5kIed74iczUl5SQRk0GHV7UDFkUB8g6FJmcNpZz8
 gN7F9ziY8mTqCMLwbgJUakJRzEj1GB1lYlGZaDx+CaNlPmW7d+jLRtSbh72+4wG7Un/Vd1
 OFg4NGolhAZvQD8koevE85CCfuHfGkA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79FA313A66;
 Mon,  6 Mar 2023 14:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CdMnDcb+BWSHGAAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 06 Mar 2023 14:55:02 +0000
Date: Mon, 6 Mar 2023 09:54:58 -0500
To: Li Wang <liwang@redhat.com>
Message-ID: <20230306145458.GA21526@localhost>
References: <20230224023815.28273-1-wegao@suse.com>
 <20230305091044.25715-1-wegao@suse.com>
 <CAEemH2cQSDkdULUbVAWb2mUKn8g1UJ4vUtVeJ_KdyfoBccJ-wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cQSDkdULUbVAWb2mUKn8g1UJ4vUtVeJ_KdyfoBccJ-wQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kill01: New case cgroup kill
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

T24gTW9uLCBNYXIgMDYsIDIwMjMgYXQgMDY6MTY6MjZQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBTdW4sIE1hciA1LCAyMDIzIGF0IDU6MTTigK9QTSBXZWkgR2FvIHZpYSBsdHAgPGx0cEBs
aXN0cy5saW51eC5pdD4gd3JvdGU6Cj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdh
b0BzdXNlLmNvbT4KPiA+IC0tLQo+ID4gKyNkZWZpbmUgcGlkX251bSAxMDAKPiA+Cj4gCj4gTXkg
Y29uY2VybiBhYm91dCBkZWZpbmluZyBwaWRfbnVtIGFzIGEgZml4ZWQgdmFyaWFibGUgaXMgdGhh
dAo+IHRoZSB0ZXN0IG1heSBzcGVuZCBhIGxvbmcgdGltZSBvbiBhIHNpbmdsZV9jcHUgb3Igc2xv
d2VyIHN5c3RlbS4KPiBBIHNhbml0eSB3YXkgaXMgcHJvYmFibHkgdG8gdXNlIGEgZHluYW1pY2Fs
IG51bWJlciBhY2NvcmRpbmcKPiB0byB0aGUgdGVzdCBiZWQgYXZhaWxhYmxlIENQVXMgKGUuZy4g
dHN0X25jcHVzX2F2YWlsYWJsZSgpICsgMSkuCmdvb2QgaWRlYSEKPiAKPiAKPiAKPiA+ICtzdGF0
aWMgc3RydWN0IHRzdF9jZ19ncm91cCAqY2dfY2hpbGRfdGVzdF9zaW1wbGU7Cj4gPiArCj4gPiAr
Cj4gPiArc3RhdGljIGludCB3YWl0X2Zvcl9waWQocGlkX3QgcGlkKQo+ID4gK3sKPiA+ICsgICAg
ICAgaW50IHN0YXR1cywgcmV0Owo+ID4gKwo+ID4gK2FnYWluOgo+ID4gKyAgICAgICByZXQgPSB3
YWl0cGlkKHBpZCwgJnN0YXR1cywgMCk7Cj4gPiArICAgICAgIGlmIChyZXQgPT0gLTEpIHsKPiA+
ICsgICAgICAgICAgICAgICBpZiAoZXJybm8gPT0gRUlOVFIpCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIGFnYWluOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtMTsK
PiA+ICsgICAgICAgfQo+ID4gKwo+ID4gKyAgICAgICBpZiAoIVdJRkVYSVRFRChzdGF0dXMpKQo+
ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtMTsKPiA+ICsKPiA+ICsgICAgICAgcmV0dXJuIFdF
WElUU1RBVFVTKHN0YXR1cyk7Cj4gPiArfQo+ID4gKwo+ID4gKy8qCj4gPiArICogQSBzaW1wbGUg
cHJvY2VzcyBydW5uaW5nIGluIGEgc2xlZXAgbG9vcCB1bnRpbCBiZWluZwo+ID4gKyAqIHJlLXBh
cmVudGVkLgo+ID4gKyAqLwo+ID4gK3N0YXRpYyBpbnQgY2hpbGRfZm4odm9pZCkKPiA+ICt7Cj4g
PiArICAgICAgIGludCBwcGlkID0gZ2V0cHBpZCgpOwo+ID4gKwo+ID4gKyAgICAgICB3aGlsZSAo
Z2V0cHBpZCgpID09IHBwaWQpCj4gPiArICAgICAgICAgICAgICAgdXNsZWVwKDEwMDApOwo+ID4g
Kwo+ID4gKyAgICAgICByZXR1cm4gZ2V0cHBpZCgpID09IHBwaWQ7Cj4gPgo+IAo+IHdoeSBkbyB3
ZSBuZWVkIHRvIHJldHVybiB0aGUgdmFsdWUgb2YgdGhpcyBjb21wYXJpc29uPwo+IEkgc3VwcG9z
ZSBtb3N0IHRpbWUgdGhlIGNoaWxkIGRvZXMgX25vdF8gaGF2ZSBhIGNoYW5jZQo+IHRvIGdldCBo
ZXJlLgp5ZXMsIGNoYW5jZSB0byByZWFjaCBoZXJlIGlzIHNtYWxsIGluIG91ciBzY2VuYXJpbywg
cmVtb3ZlCnRoZSBsb2dpYyBoZXJlLgo+IAo+IAo+IAo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMg
aW50IGNnX3J1bl9ub3dhaXQoY29uc3Qgc3RydWN0IHRzdF9jZ19ncm91cCAqY29uc3QgY2csCj4g
PiArICAgICAgICAgICAgICAgICBpbnQgKCpmbikodm9pZCkpCj4gPiArewo+ID4gKyAgICAgICBp
bnQgcGlkOwo+ID4gKwo+ID4gKyAgICAgICBwaWQgPSBmb3JrKCk7Cj4gPgo+IAo+IHVzZSBTQUZF
X0ZPUksoKSBtYXliZSBiZXR0ZXIuCmdvb2QgY2F0Y2ghCj4gCj4gCj4gCj4gPiArICAgICAgIGlm
IChwaWQgPT0gMCkgewo+ID4gKyAgICAgICAgICAgICAgIFNBRkVfQ0dfUFJJTlRGKGNnLCAiY2dy
b3VwLnByb2NzIiwgIiVkIiwgZ2V0cGlkKCkpOwo+ID4gKyAgICAgICAgICAgICAgIGV4aXQoZm4o
KSk7Cj4gPiArICAgICAgIH0KPiA+ICsKPiA+ICsgICAgICAgcmV0dXJuIHBpZDsKPiA+ICt9Cj4g
PiArCj4gPiArc3RhdGljIGludCBjZ193YWl0X2Zvcl9wcm9jX2NvdW50KGNvbnN0IHN0cnVjdCB0
c3RfY2dfZ3JvdXAgKmNnLCBpbnQKPiA+IGNvdW50KQo+ID4gK3sKPiA+ICsgICAgICAgY2hhciBi
dWZbMjAgKiBwaWRfbnVtXSA9IHswfTsKPiA+ICsgICAgICAgaW50IGF0dGVtcHRzOwo+ID4gKyAg
ICAgICBjaGFyICpwdHI7Cj4gPiArCj4gPiArICAgICAgIGZvciAoYXR0ZW1wdHMgPSAxMDsgYXR0
ZW1wdHMgPj0gMDsgYXR0ZW1wdHMtLSkgewo+ID4gKyAgICAgICAgICAgICAgIGludCBuciA9IDA7
Cj4gPiArCj4gPiArICAgICAgICAgICAgICAgU0FGRV9DR19SRUFEKGNnLCAiY2dyb3VwLnByb2Nz
IiwgYnVmLCBzaXplb2YoYnVmKSk7Cj4gPiArCj4gPiArICAgICAgICAgICAgICAgZm9yIChwdHIg
PSBidWY7ICpwdHI7IHB0cisrKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCpwdHIg
PT0gJ1xuJykKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnIrKzsKPiA+ICsK
PiA+ICsgICAgICAgICAgICAgICBpZiAobnIgPj0gY291bnQpCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gMDsKPiA+ICsKPiA+ICsgICAgICAgICAgICAgICB1c2xlZXAoMTAwMDAw
KTsKPiA+Cj4gCj4gSW4gdGhpcyBsb29wLCB0aGVyZSBpcyBvbmx5IDEgc2Vjb25kIGZvciB3YWl0
aW5nIGZvciBjaGlsZHJlbiByZWFkeS4KPiBTbywgaWYgdGVzdCBvbiBhIHNsb3dlci9vdmVybG9h
ZCBtYWNoaW5lIHRoYXQgaXMgYSBiaXQgbG9uZ2VyIHRoYW4gdGhpcwo+IHRpbWUsCj4gd2hhdCB3
aWxsIGhhcHBlbj8gc2hvdWxkbid0IHdlIGhhbmRsZSB0aGlzIGFzIGEgY29ybmVyIGNhc2UgZmFp
bHVyZT8KSSB3aWxsIGluY3JlYXNlIHRvIDEwIHNlY29uZCwgdGhlbiBpZiBhbGwgdGhlIGNoaWxk
cmVuIHByb2Nlc3NlcyBjYW4gbm90IHJlYWR5IGluIGNvcnJlY3QgCmNncm91cCB3ZSB3aWxsIHRh
a2UgdGhpcyBhcyBhIGZhaWx1cmUgY2FzZS4KPiAKPiAKPiAKPiA+ICsgICAgICAgfQo+ID4gKwo+
ID4gKyAgICAgICByZXR1cm4gLTE7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyB2b2lkIHJ1bih2
b2lkKQo+ID4gK3sKPiA+ICsKPiA+ICsgICAgICAgcGlkX3QgcGlkc1sxMDBdOwo+ID4gKyAgICAg
ICBpbnQgaTsKPiA+ICsKPiA+ICsgICAgICAgY2dfY2hpbGRfdGVzdF9zaW1wbGUgPSB0c3RfY2df
Z3JvdXBfbWsodHN0X2NnLCAiY2dfdGVzdF9zaW1wbGUiKTsKPiA+ICsKPiA+ICsgICAgICAgZm9y
IChpID0gMDsgaSA8IHBpZF9udW07IGkrKykKPiA+ICsgICAgICAgICAgICAgICBwaWRzW2ldID0g
Y2dfcnVuX25vd2FpdChjZ19jaGlsZF90ZXN0X3NpbXBsZSwgY2hpbGRfZm4pOwo+ID4gKwo+ID4g
KyAgICAgICBUU1RfRVhQX1BBU1MoY2dfd2FpdF9mb3JfcHJvY19jb3VudChjZ19jaGlsZF90ZXN0
X3NpbXBsZSwKPiA+IHBpZF9udW0pKTsKPiA+ICsgICAgICAgU0FGRV9DR19QUklOVEYoY2dfY2hp
bGRfdGVzdF9zaW1wbGUsICJjZ3JvdXAua2lsbCIsICIlZCIsIDEpOwo+ID4gKwo+ID4gKyAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgcGlkX251bTsgaSsrKSB7Cj4gPiArICAgICAgICAgICAgICAgLyog
d2FpdF9mb3JfcGlkKHBpZHNbaV0pOyAqLwo+ID4gKyAgICAgICAgICAgICAgIFRTVF9FWFBfUEFT
U19TSUxFTlQod2FpdF9mb3JfcGlkKHBpZHNbaV0pID09IFNJR0tJTEwpOwo+ID4gKyAgICAgICB9
Cj4gPiArCj4gPiArICAgICAgIGNnX2NoaWxkX3Rlc3Rfc2ltcGxlID0gdHN0X2NnX2dyb3VwX3Jt
KGNnX2NoaWxkX3Rlc3Rfc2ltcGxlKTsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHN0cnVjdCB0
c3RfdGVzdCB0ZXN0ID0gewo+ID4gKyAgICAgICAudGVzdF9hbGwgPSBydW4sCj4gPiArICAgICAg
IC5mb3Jrc19jaGlsZCA9IDEsCj4gPiArICAgICAgIC5tYXhfcnVudGltZSA9IDUsCj4gPiArICAg
ICAgIC5uZWVkc19jZ3JvdXBfY3RybHMgPSAoY29uc3QgY2hhciAqY29uc3QgW10peyAibWVtb3J5
IiwgTlVMTCB9LAo+ID4gKyAgICAgICAubmVlZHNfY2dyb3VwX3ZlciA9IFRTVF9DR19WMiwKPiA+
ICt9Owo+ID4gLS0KPiA+IDIuMzUuMwo+ID4KPiA+Cj4gPiAtLQo+ID4gTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4gPgo+ID4KPiAKPiAtLSAK
PiBSZWdhcmRzLAo+IExpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
