Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845A4C48BF8
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708609605; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zptICc9PzBjRhkOxDvoHJxeLtj50F3lMTlmDuGM2lmE=;
 b=rdufbeX8egcRkf3I3TaHMBapTiz2eu9VUGh/Tc5AKkA4PvUA6CRwiefPVd++iUbCqKN4P
 Wds98BNwUWv+lyWqzdJI0qTCTUZmJ+WOxi4OUZagv7JScRabWxaXoYX1PoQ5DA6ZE7AFloI
 JsenyrjXMaLklpH7Yn/W+9MsWqq0sOE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05C593CF9F2
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 14:46:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A2003CEFB9
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 14:46:21 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ADC46140B4BD
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 14:46:20 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4128f3ee934so292175e9.3
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 05:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708609580; x=1709214380; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1I1txU1PMMZ3a3FBbddta7hyezFRGZAJIK5/Gsre65Q=;
 b=GzHy7KhsEmgtcZXU5h0ZUyNO8VGpCzpFKvU2PwDgjNXcauGkPgfbB+xo6ub9AcAkdi
 raBPYvw8XmQHuxhewpnguWjg9EX/4J06wCfSGho8eVVO0aUVsaEhum4ZZcrlOWf8vs2B
 6aiHxREXK03ATg0t68deZO+cjBP/VOZalZ5QePJgCirfM+F/4+akh6SiIdeXk5sQ3kiB
 Z6hgFNOsukumIwZwQdUV99llcT/JoBhi5IPUoMRAi+FwTnFR6pHtoFZXR8JK7HyilfwA
 Jufwe0FVaOW7Ib0Py6Gg7EBrmAejIXlI36g7reCkpMMwCutbClKJwYxoNwg/bxgqXkcj
 PO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708609580; x=1709214380;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1I1txU1PMMZ3a3FBbddta7hyezFRGZAJIK5/Gsre65Q=;
 b=Vo3hrEuDObH6GZHuyjXsH+PFr9SoJfKWP2f5t/SoGTFSCgbASZPRHu6szZIZZrfbQG
 WX1jcgqn9CF/PK9jkiNjswP4sJBiLXAEwTGUAQYuGeEke9EhW+QoMDl8FMNFt7AzvIJs
 HXAM8z6uyS73+/LpuiU6UrJroEOncjelA2Gry7jl5H+yg4L1s0LlcZv5cpo7slQHrnpY
 Vo2Ak8yXMIuGn0qWVCiA4gTxiDopIdJ937mFeUqH6Z1uxvoG6qv7Wcm23eFUIsiXmTe8
 fkA4WxNoJeFz4mdZqjGT9ahfusn0/+ZGXnjWRNlvbu4g1OfDMglFhAZ8/g/1+TGcDzAK
 roKw==
X-Gm-Message-State: AOJu0Yw8Fp8Tjq3EUuigMEkru7MFP3HCbzKA0+NRWL43OYwInUkt7FAL
 +x24hozrI8tqI8pxwfTMsOxbyIGShPQVfN1Tofx7Q3EBGFfcYRWIzBw2ydMr+2wRuiv4EXGU97z
 yTg==
X-Google-Smtp-Source: AGHT+IHzS4d83cYqAKhuRhELUzdeLz6ZeZsBQS1VZJqGJ4HhDdYBEF0wmkDAeE4kpgFT1jiCjNY4zA==
X-Received: by 2002:adf:f8c3:0:b0:33d:6b8a:707 with SMTP id
 f3-20020adff8c3000000b0033d6b8a0707mr6751932wrq.44.1708609580058; 
 Thu, 22 Feb 2024 05:46:20 -0800 (PST)
Received: from wegao.166.144.58 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a5d4f05000000b0033b684d6d5csm20511195wru.20.2024.02.22.05.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 05:46:19 -0800 (PST)
Date: Thu, 22 Feb 2024 08:46:13 -0500
To: Li Wang <liwang@redhat.com>
Message-ID: <ZddQJQ8u0V4dPsiV@wegao.166.144.58>
References: <20240222044119.28500-1-wegao@suse.com>
 <CAEemH2ehUO8=2K0RtPfuFCouGQU+Gn9ouzh+SVB5-hrQxedoaA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ehUO8=2K0RtPfuFCouGQU+Gn9ouzh+SVB5-hrQxedoaA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapoff01.c: Adjust blocks size base on
 pagesize
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

T24gVGh1LCBGZWIgMjIsIDIwMjQgYXQgMDM6NTc6NTdQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBUaHUsIEZlYiAyMiwgMjAyNCBhdCAxMjo0MeKAr1BNIFdlaSBHYW8gdmlhIGx0cCA8bHRw
QGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiAKPiA+IFRoZSBtYWtlX3N3YXBmaWxlIGZ1bmN0aW9u
IHdpbGwgZW5jb3VudGVyIG5vIHNwYWNlIGVycm9yIGlmIHBhZ2VzaXplCj4gPiBpcyBiaWdnZXIg
dGhlbiA0MDk2LCBzdWNoIGFzIHBwYzY0IHN5c3RlbSB1c2UgZGVmYXVsdCBwYWdlc2l6ZSA2NTUz
NS4KPiA+Cj4gCj4gV2hhdCBlcnJvcyBkb2VzIGl0IHNob3dzIGluIHRoZSBsb2c/Cj4gCj4gSSBj
YW4ndCByZXByb2R1Y2UgdGhpcyBvbiBteSBhYXJjaDY0IChwYWdlc2l6ZSA9PSA2NTUzNikuCj4g
U2VlbXMgdGhlICcuZGV2X21pbl9zaXplID0gMzUwJyBpcyBsYXJnZSBlbm91Z2ggZm9yIHRlc3Rp
bmcuCj4gClNvcnJ5ICwgaXQgc2hvdWxkIGJlIGJsb2NrIHNpemUgPT0gNjU1MzYuCj4gCj4gCj4g
Pgo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gPiAtLS0KPiA+
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvZmYvc3dhcG9mZjAxLmMgfCA3ICsrKysr
Ky0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fw
b2ZmMDEuYwo+ID4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvZmYvc3dhcG9mZjAx
LmMKPiA+IGluZGV4IGMzMDM1ODhkZi4uNzFkNmM2YzA0IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb2ZmL3N3YXBvZmYwMS5jCj4gPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvZmYvc3dhcG9mZjAxLmMKPiA+IEBAIC00NCw3ICs0NCwx
MiBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gIHsKPiA+ICAgICAgICAgaXNfc3dhcF9z
dXBwb3J0ZWQoVEVTVF9GSUxFKTsKPiA+Cj4gPiAtICAgICAgIGlmIChtYWtlX3N3YXBmaWxlKFNX
QVBfRklMRSwgNjU1MzYsIDEpKQo+ID4gKyAgICAgICBpbnQgYmxvY2tzID0gNjU1MzU7Cj4gPiAr
Cj4gPiArICAgICAgIGlmIChnZXRwYWdlc2l6ZSgpID4gNDA5NikKPiA+ICsgICAgICAgICAgICAg
ICBibG9ja3MgPSA2NTUzNSAqIDQwOTYgLyBnZXRwYWdlc2l6ZSgpOwo+ID4gKwo+ID4gKyAgICAg
ICBpZiAobWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIGJsb2NrcywgMSkpCj4gPiAgICAgICAgICAg
ICAgICAgdHN0X2JyayhUQlJPSywgIkZhaWxlZCB0byBjcmVhdGUgZmlsZSBmb3Igc3dhcCIpOwo+
ID4gIH0KPiA+Cj4gPiAtLQo+ID4gMi4zNS4zCj4gPgo+ID4KPiA+IC0tCj4gPiBNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPiA+Cj4gPgo+IAo+
IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
