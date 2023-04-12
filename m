Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22857C77B73
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 05:22:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E91623CC630
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 07:22:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4CE33CAF7C
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 07:22:21 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 080291A00719
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 07:22:20 +0200 (CEST)
Received: by mail-pj1-x1031.google.com with SMTP id
 e18-20020a17090ac21200b00246952d917fso8893193pjt.4
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 22:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1681276939; x=1683868939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vr0icSpVKCPnLZQ+tFOCmycAfMELwVjpmQ0R9TC0vwk=;
 b=ZSDqFJzAkHdOHaJpK/c++c7+MNJKFrMWsazHnM6d16yiNovPw2IMnBruK2tQMOI+Ls
 wKToLOB/nKT3MeFKkM/SnbJ8RPUOJGiy/EVamGm+xSjJqWl+SsnMIet9sv9FcLHiZ0+V
 nLRhSsjOlM5YoiUXi8Q3kfBHRx+g8wx6BrtmXcviRwfY2z8f0oESNZsO+R3zI124XV2G
 5p1kHDL/78u1bcHOjoQ3VGb6+6wbeNwqnzxuiiyfZhWo6XYL71NXX8n03tTo5QtbBwjb
 w0kRxVe8+/LI/I1+yEBuzJycrzB+2b/Kv/1vhyizFJ8Az7cXNDN+vdl9qbv3to3wdjyV
 3eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681276939; x=1683868939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vr0icSpVKCPnLZQ+tFOCmycAfMELwVjpmQ0R9TC0vwk=;
 b=MtWJr5LHso5oPi31L+fsnyCaHjDIsUg20PUvIh7nPw6Jck35BlLKPhqzJC7X6uuVdW
 r8BdGCeJVYCMMXIj7IEfFAq4rmMEZGhkjU1oMTNo7duXxyIQNPDgzg8hL9s0GWn2xSC4
 WkiaaxwQcpUOTZQSED3292ElDtvCKlwRn4FZPLib2wauIBQT8aQKyynWpotPO1VzLcxv
 EA5RkPzIIlDFkHRxT/vmS8jOoX6BclymfQc+43CK1o8tNGBNMTpyayfmkjYufY9aoZlh
 6BQEunNx2gSz/cGKyg0IMANzU/ENAr3TEtpnFwoMC9K31uXGH0phUmYVXe5Y44JreUR0
 NyHQ==
X-Gm-Message-State: AAQBX9daSRoZUx1GJIpAex3w7sunvJ7zH9B9gaXnWxetbii57g/C2XyI
 An+ZdY/69ECCZ65jWNBgeZZVmGqQI+LR/gjx820s6Q==
X-Google-Smtp-Source: AKy350bkRZs1ZX6Oh5+Gsg2Qibg56wnyWJGpkgLYAS/bhRh/XSkX6czFQ0/G3I4jW1R5shP7dCprZCMFrO3y07axuZQ=
X-Received: by 2002:a17:902:db0e:b0:1a2:73b3:b398 with SMTP id
 m14-20020a170902db0e00b001a273b3b398mr4642252plx.6.1681276939148; Tue, 11 Apr
 2023 22:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
 <20230411220811.GA1798729@pevik>
In-Reply-To: <20230411220811.GA1798729@pevik>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Tue, 11 Apr 2023 23:22:07 -0600
Message-ID: <CAEUSe7_JvM8SD15DVnXOsSyPhS+sF=9JEDzV+NW2XZ=MwVMBUw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: list of failures on 32bit and compat mode
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
Cc: Benjamin Copeland <ben.copeland@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8hCgpPbiBUdWUsIDExIEFwciAyMDIzIGF0IDE2OjA4LCBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4gd3JvdGU6Cj4KPiA+IE9uIFRodSwgNiBBcHIgMjAyMyBhdCAxNjoyNiwgUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gPiA+ID4gT24gVGh1LCBBcHIgNiwgMjAy
MywgYXQgMTE6MTEsIE5hcmVzaCBLYW1ib2p1IHdyb3RlOgo+ID4gPiA+ID4gRm9sbG93aW5nIExU
UCBzeXNjYWxscyBmYWlsZWQgb24gdGhlIGkzODYgYW5kIGFybSBlbnZpcm9ubWVudHMgd2l0aAo+
ID4gPiA+ID4gTGludXggbmV4dCAvIG1haW5saW5lIGtlcm5lbHMuIFRoZSB1c2Vyc3BhY2UgaXMg
Y29taW5nIGZyb20gT3Blbgo+ID4gPiA+ID4gRW1iZWRkZWQga2lya3N0b25lLgo+Cj4gPiA+ID4g
VGhhbmtzIGZvciB0aGUgcmVwb3J0IGFuZCBzdW1tYXJ5ISBJIHdlbnQgdGhyb3VnaCB0aGUgbGlz
dCBhbmQgZm91bmQKPiA+ID4gPiB0aGF0IG1vc3QgaWYgbm90IGFsbCBvZiB0aGUgYnVncyBsb29r
cyBsaWtlIGluY29tcGF0aWJpbGl0aWVzCj4gPiA+ID4gd2l0aCBtdXNsLCBub3Qgd2l0aCAzMi1i
aXQuIEl0J3MgcHJvYmFibHkgbm90IHdlbGwgdGVzdGVkIHdpdGgKPiA+ID4gPiBtdXNsLgo+Cj4g
PiA+ID4gQ2FuIHlvdSB0cnkgYWdhaW4gd2l0aCBnbGliYyBhbmQgc2VlIGlmIHRoZXJlIGFyZSBh
bnkgcmVtYWluaW5nCj4gPiA+ID4gaXNzdWVzIHRoZW4/IExUUCBzaG91bGQgcHJvYmFibHkgYmUg
Zml4ZWQgdG8gd29yayB3aXRoIGJvdGgsIGJ1dAo+ID4gPiA+IGlmIG5vYm9keSBoYXMgZG9uZSB0
aGF0IHNvIGZhciwgaXQncyBsaWtlbHkgdGhhdCB0aGlzIGhhcyBjb21lCj4gPiA+ID4gdXAgaW4g
dGhlIHBhc3QgYnV0IHJhbiBpbnRvIHByb2JsZW1zIHVwc3RyZWFtaW5nIHRoZSBmaXhlcy4KPgo+
ID4gPiA+ID4gQW55b25lIHNlZWluZyB0aGlzIHByb2JsZW0gb24gMzItYml0IGkzODYgb3IgYXJt
ID8KPiA+ID4gPiA+IFlvdSBnZXQgdG8gc2VlICJzZWdmYXVsdCIgaW4gdGhlIGZvbGxvd2luZyBs
b2dzIHRoYXQgaGF2ZSBiZWVuIG5vdGljZWQKPiA+ID4gPiA+IG9uIGkzODYgb25seS4KPgo+ID4g
PiA+ID4gVGhpcyBpcyBub3QgYSBuZXcgcHJvYmxlbS4gV2UgaGF2ZSBiZWVuIG5vdGljaW5nIHRo
ZXNlIGZhaWx1cmVzIGZvciBhCj4gPiA+ID4gPiByZWFsbHkgbG9uZyB0aW1lLgo+ID4gPiA+ID4g
V291bGQgaXQgYmUgd29ydGggaW52ZXN0aWdhdGluZyB0aGUgcmVhc29uIGZvciBmYWlsdXJlcyBv
biAzMmJpdCBhcmNoaXRlY3R1cmVzID8KPgo+ID4gPiA+ID4gVGVzdCBsb2dzLAo+ID4gPiA+ID4g
LS0tLS0KPiA+ID4gPiA+IFsgICAgMC4wMDAwMDBdIExpbnV4IHZlcnNpb24gNi4zLjAtcmM1LW5l
eHQtMjAyMzA0MDYgKHR1eG1ha2VAdHV4bWFrZSkKPiA+ID4gPiA+IChpNjg2LWxpbnV4LWdudS1n
Y2MgKERlYmlhbiAxMS4zLjAtMTEpIDExLjMuMCwgR05VIGxkIChHTlUgQmludXRpbHMKPiA+ID4g
PiA+IGZvciBEZWJpYW4pIDIuNDApICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgQDE2ODA3NTkzODkK
Pgo+Cj4gPiA+ID4gPiBUZXN0IGVudmlyb25tZW50OiBpMzg2Cj4gPiA+ID4gPiBTdWl0ZTogbHRw
LXN5c2NhbGxzCj4gPiA+ID4gPiBUb29sY2hhaW46IGdjYy0xMQo+Cj4KPiA+ID4gPiA+IGZzdGF0
ZnMwMgo+ID4gPiA+ID4gZnN0YXRmczAyICAgIDEgIFRQQVNTICA6ICBleHBlY3RlZCBmYWlsdXJl
IC0gZXJybm8gPSA5IDogQmFkIGZpbGUgZGVzY3JpcHRvcgo+ID4gPiA+ID4gZnN0YXRmczAyICAg
IDIgIFRCUk9LICA6ICB0c3Rfc2lnLmM6MjMyOiB1bmV4cGVjdGVkIHNpZ25hbCBTSUdTRUdWKDEx
KQo+ID4gPiA+ID4gcmVjZWl2ZWQgKHBpZCA9IDE3ODQxKS4KPiA+ID4gPiA+IGZzdGF0ZnMwMiAg
ICAzICBUQlJPSyAgOiAgdHN0X3NpZy5jOjIzMjogUmVtYWluaW5nIGNhc2VzIGJyb2tlbgo+ID4g
PiBUaGlzIGlzIElNSE8gdXNpbmcgdGhlIG9sZCBMVFAgQVBJLgo+ID4gPiB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2ZzdGF0ZnMvZnN0YXRmczAyLmMgd2FzIGNvbnZlcnRlZCB0byBuZXcgTFRQ
IEFQSSBpbgo+ID4gPiA1YThmODlkMzUgKCJzeXNjYWxscy9zdGF0ZnMwMiwgZnN0YXRmczAyOiBD
b252ZXJ0IHRvIG5ldyBBUEkiKSwgd2hpY2ggd2FzCj4gPiA+IHJlbGVhc2VkIGluIDIwMjIwOTMw
LiBUaGVyZSBpcyBhbHJlYWR5IG5ld2VyIHJlbGVhc2UgMjAyMzAxMjcuCj4gPiA+IEdlbmVyYWxs
eSBpdCdzIHNhZmVyIHRvIHRlc3QgbWFpbmxpbmUga2VybmVsIHdpdGggTFRQIG1hc3RlciwKPiA+
ID4gYnV0IHRoaXMgZml4IGhhcyBhbHJlYWR5IGJlZW4gaW4gdGhlIGxhdGVzdCBMVFAgcmVsZWFz
ZSAyMDIzMDEyNy4KPiA+ID4gQW5kIHRoaXMgZXJyb3IgaGFzIGJlZW4gbGF0ZXIgZml4ZWQgd2l0
aAo+ID4gPiA0OTI1NDIwNzIgKCJzeXNjYWxscy9zdGF0ZnMwMiwgZnN0YXRmczAyOiBBY2NlcHQg
c2VnZmF1bHQgaW5zdGVhZCBvZiBFRkFVTFQiKQo+IEknbSBzb3JyeSwgSSB3YXMgd3Jvbmcgc3Rh
dGluZyB0aGF0IHVuZXhwZWN0ZWQgc2lnbmFsIFNJR1NFR1YoMTEpCj4gZXJyb3Igd2FzIGZpeGVk
IGJ5IDQ5MjU0MjA3Mi4KPgo+ID4gVGhhbmtzIGZvciBpbnNpdGUgYWJvdXQgdGhlIGZhaWxlZCB0
ZXN0IGludmVzdGlnYXRpb25zLgo+Cj4KPiA+ID4gQE5hcmVzaCB3aGljaCBMVFAgZG8geW91IHVz
ZSBmb3IgdGVzdGluZz8gSXQgbXVzdCBiZSBzb21lIG9sZGVyIExUUCA6KC4KPgo+ID4gT3VyIGJ1
aWxkIHN5c3RlbSBzdGFydGVkIHJ1bm5pbmcgTFRQIHZlcnNpb24gMjAyMzAxMjcuCj4gSSdtIHNv
cnJ5LCBJIG9idmlvdXNseSBtaXNpbnRlcnByZXRlZCB0aGUgdGVzdCBvdXRwdXQgYXMgb2xkIExU
UCBjb2RlLgoKTm8sIHlvdSB3ZXJlIHJpZ2h0ISBXZSB3ZXJlIHJ1bm5pbmcgYW4gb2xkZXIgdmVy
c2lvbiBhbmQgYmVjYXVzZSBvZgp0aGlzIGRpc2N1c3Npb24gd2UgaGF2ZSBub3cgdXBkYXRlZCB0
byAyMDIzMDEyNyBpbiBLaXJrc3RvbmUuIFRoaXMKdXBkYXRlIGZyb20gTmFyZXNoIGFuZCB0aGVz
ZSBmaW5kaW5ncyBhcmUgd2l0aCAyMDIzMDEyNy4KClRoYW5rcyBmb3IgbG9va2luZyBpbnRvIHRo
aXMhIEdyZWV0aW5ncyEKCkRhbmllbCBEw61hegpkYW5pZWwuZGlhekBsaW5hcm8ub3JnCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
