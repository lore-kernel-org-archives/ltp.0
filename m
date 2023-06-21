Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778D8EB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 00:20:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 183B93CD332
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 02:20:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F04DA3C9E39
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 02:19:54 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 12C116008F2
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 02:19:53 +0200 (CEST)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-657c4bcad0bso1347818b3a.1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1687306791;
 x=1689898791; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3q3hGm1/rA/oV9/LGyRhu6H8Xm1iYKfwz3h42BNGMNM=;
 b=304PBjjLI2x1M0qkYx1V1nIz3sIobE1bB/x7+Tp3RLQuWQg9KvVDS0Q7TAS5mcYxk9
 eeymLTOHq1QIWkKfgKZtMAxZMtqfCW0Q0dmz4pnLb7ILFEyTk7QSaDgVY5jd9LTgSR+z
 wuKMcAa85DqLNtftuFaj6DPbSztxOmZJ064uxo8q37MNM0d/yWWppDuP8RcpH2wi+T/D
 58VvcgHvj4UXYXBGVr78jfMDlgbWHZzGWxgRPbXISsrde7v1d7ewSzFcOfVDo58QMgRW
 RyD7HvAbfuqH9Dzd7VQATDVlA1DDsJUBNg79+evZs5Bzzwpv9hJ8ap9wkERl5mAtw5bM
 qcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687306791; x=1689898791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3q3hGm1/rA/oV9/LGyRhu6H8Xm1iYKfwz3h42BNGMNM=;
 b=CJnu01JAa2gmyXNHIYBhK4rX2y9AX2laqYVDwpGomExHaGq7nUhAMmMto8EOrcdSQU
 4k7CKx4+gatA9sQJGWIGztKsm+O+sjh+DYeVF/LHvUH/kAni5U+I8rsAEDKTZJH5c9JU
 +FqIVuhCoHXWi/eL0iSQAhpHJDRFe7YB9sLBSi0UKqkwGmu+HVb+pDdXZbIzApHx0BWu
 NT5QKNUuTpXkSpbzWZSmaGIBekezmHBaTbtMVAxUQJUzkRnrSxRJbeeFBJ6d8buMcMKT
 MVpz+FZrIyQHiskOxHvObnU7krOkPBGCdv4SdBtTyRHsP4myd3MjBUprLu5h9XhvsXQs
 GjAw==
X-Gm-Message-State: AC+VfDzVk9U0HYN0uDvM/YaBQk3PS9t7AeQHTXH6btNLvmz4C3S1Zumi
 2RKUZxjQsCYK6mKV9LeAzGxfoHtxgDtlDbhZ5vrXmg==
X-Google-Smtp-Source: ACHHUZ63i3MZtxA3Ssj19N/dfahs+ucDgrSxPn6ElerBw1Z02BVQOiYdlMX3s8/CopF1iongCSRJon1j0KyK5uGV0sA=
X-Received: by 2002:a17:90b:4d85:b0:25b:88bc:bb6b with SMTP id
 oj5-20020a17090b4d8500b0025b88bcbb6bmr17244840pjb.2.1687306791273; Tue, 20
 Jun 2023 17:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
 <CAEemH2doFsjjQwDA2P_-_vDrFSBtNoCXLXh3U__3W6jED4mhTw@mail.gmail.com>
 <20230620210826.GB334441@pevik>
In-Reply-To: <20230620210826.GB334441@pevik>
From: =?UTF-8?B?5rKz5Y6f6aKv5aSq?= <souta.kawahara@miraclelinux.com>
Date: Wed, 21 Jun 2023 09:19:16 +0900
Message-ID: <CAC+q_wVtSBGqa+FEY=3zDrj_hFqOo__Vs3xiL4iw55uwioS3fw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] runtest/cve: Add some existing CVE tests
 to runtest file
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLgoKVGhhbmt5b3UgZm9yIGFsbCB5b3VyIHJldmlldyEKCjIwMjPlubQ25pyIMjHml6Uo
5rC0KSA2OjA4IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PjoKPgo+IEhpIExpLCBhbGwsCj4K
PiAuLi4KPiA+ID4gK2N2ZS0yMDE3LTU2Njkgc2htYXQwMwo+Cj4gPiBUaGlzIG9uZSBsb29rcyBs
aWtlIGJlaW5nIGRyb3BwZWQgZnJvbSB0aGUgQ1ZFIGxpc3QgcHVycG9zZWx5LAo+ID4gYWNjb3Jk
aW5nIHRvOgo+Cj4gPiBjb21taXQgMjU4OGRhZmQ0NjUxNzA2ZWQ3YWUzNGFlM2I3NDRiMGVlOGNk
NjM4NAo+ID4gQXV0aG9yOiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiA+IERhdGU6
ICAgV2VkIEF1ZyAxNCAxNDoxMzoyOCAyMDE5ICswMjAwCj4KPiA+ICAgICBzeXNjYWxscy9zaG1h
dDAzOiBSZW1vdmUgaXQgZnJvbSBydW50ZXN0L2N2ZQo+Cj4gPiAgICAgVGhlIG9yaWdpbmFsIFBP
Q1sxXSBhbmQgQ1ZFLTIwMTctNTY2OSBhcmUgbm90IHRlc3RlZCBieSB0aGlzIHRlc3QKPiA+ICAg
ICBhbnltb3JlIGFzIGl0IHR1cm5lZCBvdXQgdGhhdCB0aGUgQ1ZFIHdhcyBib2d1cy4gU2VlOgo+
Cj4gPiAgICAgaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtbW0mbT0xNTI1MTA5NzgxMjM3NTUm
dz0yCj4KPiA+ICAgICBBbmQgdGhlIHRlc3QgYmVjYW1lIHJlZ3Jlc3Npb24gdGVzdCBmb3I6Cj4K
PiA+ICAgICBjb21taXQgOGY4OWMwMDdiNmRlYzE2YTE3OTNjYjg4ZGU4OGZjYzAyMTE3YmJiYwo+
ID4gICAgIEF1dGhvcjogRGF2aWRsb2hyIEJ1ZXNvIDxkYXZlQHN0Z29sYWJzLm5ldD4KPiA+ICAg
ICBEYXRlOiAgIEZyaSBNYXkgMjUgMTQ6NDc6MzAgMjAxOCAtMDcwMAo+Cj4gPiAgICAgICAgIGlw
Yy9zaG06IGZpeCBzaG1hdCgpIG5pbCBhZGRyZXNzIGFmdGVyIHJvdW5kLWRvd24gd2hlbiByZW1h
cHBpbmcKPgo+ID4gICAgIEhlbmNlIHdlIHdpbGwga2VlcCB0aGUgdGVzdCBidXQgcmVtb3ZlIGl0
IGZyb20gdGhlIENWRSBydW50ZXN0IGZpbGUgYW5kCj4KPiBHb29kIGNhdGNoLCBMaS4gSSdtIGZv
ciBtZXJnaW5nIHRoaXMgd2l0aG91dCAiY3ZlLTIwMTctNTY2OSBzaG1hdDAzIiBsaW5lLgo+IFdp
dGggdGhpcyBjaGFuZ2U6Cj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
Pgo+Cj4gPiBhZGp1c3QKPiA+ICAgICB0aGUgdG9wIGxldmVsIGNvbW1lbnQgaW4gdGhlIHRlc3Qg
Y29kZS4KPiBEbyB5b3UgcGxhbiB0byBkbyB0aGlzPwoKVGhpcyBzZWVtcyB0byBoYXZlIGFscmVh
ZHkgYmVlbiBkb25lLgoKYWNjb3JkaW5nIHRvIHRoZSBkaWZmIHBhcnQgb2YgIjI1ODhkYWZkNDY1
MTcwNmVkN2FlMzRhZTNiNzQ0YjBlZThjZDYzODQiOgoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvaXBjL3NobWF0L3NobWF0MDMuYwpiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvaXBjL3NobWF0L3NobWF0MDMuYwppbmRleCAxM2VhMzljNjMuLjE4ZDNkYjAyOCAxMDA2
NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvc2htYXQvc2htYXQwMy5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL3NobWF0L3NobWF0MDMuYwpAQCAtNCwy
NiArNCwyOCBAQAogICogQ29weXJpZ2h0IChjKSAyMDE3IEZ1aml0c3UgTHRkLiAoWGlhbyBZYW5n
IDx5YW5neC5qeUBjbi5mdWppdHN1LmNvbT4pCiAgKi8KIC8qCi0gKiBUZXN0IGZvciBDVkUtMjAx
Ny01NjY5IHdoaWNoIGFsbG93cyB1cyB0byBtYXAgdGhlIG5pbCBwYWdlIHVzaW5nIHNobWF0Lgor
ICogT3JpZ2luYXRlZCBhcyBhIHRlc3QgZm9yIENWRS0yMDE3LTU2NjkgYnV0IGFzIGl0IHR1cm5z
IG91dCB0aGUgQ1ZFIHdhcyBib2d1cworICogdG8gYmVnaW4gd2l0aCBhbmQgdGhlIHRlc3Qgd2Fz
IGNoYW5nZWQgaW50byBhIHJlZ3Jlc3Npb24gdGVzdCBmb3IgY29tbWl0OgogICoKClJlZ2FyZHMs
ClNvdXRhIEthd2FoYXJhIDxzb3V0YS5rYXdhaGFyYUBtaXJhY2xlbGludXguY29tPgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
