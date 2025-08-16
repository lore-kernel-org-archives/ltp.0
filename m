Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2653BCA0EE4
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 06:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755498710; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gl51tP1FjKiwJC+hkaf5HUm79hbardiBKLJxhMj0Uj8=;
 b=LGqEkKbvOmvd9dmYJ2kdw4LUZm35XPtlITuwB/wwbNA+gIws8i41frykAlTqRvExCM23u
 a2ywhT80puCzfxYbZpuVpo1RYfEj0oSjvjnTC3imuDhtAuTWyuAOsBdsrtEFrNQYh5fgRoe
 03cZNcwrJ/XiUh5VkcliTvdwOEihWs4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B12AF3CC963
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 08:31:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CCE93C8564
 for <ltp@lists.linux.it>; Sat, 16 Aug 2025 04:35:25 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 809C26168CE
 for <ltp@lists.linux.it>; Sat, 16 Aug 2025 04:35:24 +0200 (CEST)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24458194d83so17629685ad.2
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 19:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1755311723; x=1755916523; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYSYnsAnc4+Pe25joGiiZuFU50uPj3OZL8WRBpyuG54=;
 b=wBE0o9Ln91H/xvIiRUa4YVnd8cuj/fjDMIQInAQy9TwU6DlH++lJ+ux1kDc4LN7kUu
 R6skGQDltmIkkC1GlroTDg1DV33GAxbkHxYWbwUpTN7Wx0BPL3DvESg67HwFsaITdzGi
 EQjO3unk0WlmGcHCjljJOYPm2gSs7P2b9bjs9EcNkr5Kvt/C0X9j1peA//CVh6//qgAU
 EiaHEDHYv68J1uSIUt/trbqICctBSxLLEwuULz8/g92KNQCKDIOLTppTWxub2L/Yhx4v
 EaTjwjFDksflEJSaaCkStkMYFEVJ2BeG1qLrxLjvjmIcJv76Cuv0n7gjjOXKSdZcK/d7
 803g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755311723; x=1755916523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYSYnsAnc4+Pe25joGiiZuFU50uPj3OZL8WRBpyuG54=;
 b=YgogFroCqIb0Tk+9Io498HR5bRZvrXFwdrLMP+Enw8WrvBTjgHgd+wD3jgC5hWDAoG
 Ctgw+Bvjc2vH2rQdDttQOf8o7ER2ePZyxlD6BnwP6y83bmPxXAStqEynDFaItMpyO1B0
 7m6QdwSvbqkig8+4Yx+vvlxUAcFBwxrNedgWt0HD0eELi9N0042eC7nICadb1oU/x4hR
 Q9Fdkcbibd8PJsgmQOv5HW67iUv+aRHqj92RS6weS/UOheYQ3ssG1GVlaBBmdBG1FcoL
 H1FWUQ06B9gE9Gz/lOOpqavRxUkhFVcQlKY0ICJ5WU9QKt4k+sgB1cKDkJJZDGxhXeRg
 eESQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAGOq8ACj44htxE1Ra253Wm66U13O7w3fR0GYNbgnzRUzdvcgevsjdNG00h5ckOosHO24=@lists.linux.it
X-Gm-Message-State: AOJu0YyzC5BlsYxAr+o1x83famDCkxbgZsrdbEOkUUuiz/NU19hbgUnQ
 Ro1JlbY58MZBEruiemHKsklYSdZFJJzPKbGrjKIr/kpeCRjrWNl4tq8aba2KuTP2iQUygqYZR5W
 TfiYHoYdFdpC2+MrW3b+vO3ToG1lV+Zc2Unh7e7Ja
X-Gm-Gg: ASbGncu16vIAtCgmdMytb/VPBW9+tEEL8WB6VqyZY8aAvwfVVPAbipxYLno4A0sc2Ai
 Z692eIUlaxVIEeAwiGbh/qNrkN+ZsskF5uyJ1HX12T6O+rzTupG4Fiv5thxuK0jDSJW6qASM9FH
 S4DNMp6u0gZ/kyvCbMPAdiFa7PC5UsvosjA2KTai2c+vfGlIgGrUQPAP6YD0X6VD50zP/iey517
 Ea5xUId0FPeI3oGdSDfYLVXnYj2BEX5qKnIEeZ5j79U6xw=
X-Google-Smtp-Source: AGHT+IEoa6K5VPw7SESWJcyry0r0EAmnREWUavxXpMAeN45Ss7wHcLf9j0oo8tGG9DPZYtegphKPTtIWix2PRHyIVkg=
X-Received: by 2002:a17:903:1967:b0:242:a0b0:3c12 with SMTP id
 d9443c01a7336-2446d9c534amr60239055ad.52.1755311722577; Fri, 15 Aug 2025
 19:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <202508110750.a66a4225-lkp@intel.com> <aJ_qbZDvDJwVoZGA@localhost>
In-Reply-To: <aJ_qbZDvDJwVoZGA@localhost>
Date: Fri, 15 Aug 2025 19:35:10 -0700
X-Gm-Features: Ac12FXxRtAJ-Rrz7HjZK8VbUPj4MqgpSheT6l3cFeoFUPq4dJKBOPfSiUKanWVU
Message-ID: <CAAVpQUCEGiRjoobf69Jd5M9vnZyi0N6crNUgSBpDTGNfrap1cA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 18 Aug 2025 08:29:56 +0200
Subject: Re: [LTP] [PATCH net v2] net: ip: order the reuseport socket in
 __inet_hash
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
From: Kuniyuki Iwashima via ltp <ltp@lists.linux.it>
Reply-To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: kraig@google.com, lkp@intel.com, netdev@vger.kernel.org, dsahern@kernel.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, edumazet@google.com,
 kernel test robot <oliver.sang@intel.com>, horms@kernel.org,
 oe-lkp@lists.linux.dev, kuba@kernel.org,
 Menglong Dong <menglong8.dong@gmail.com>, pabeni@redhat.com,
 ncardwell@google.com, davem@davemloft.net, ltp@lists.linux.it,
 Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMTUsIDIwMjUgYXQgNzoxOOKAr1BNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKPgo+IE9uIE1vbiwgQXVnIDExLCAyMDI1IGF0IDAxOjI3OjEyUE0gKzA4MDAsIGtl
cm5lbCB0ZXN0IHJvYm90IHdyb3RlOgo+ID4KPiA+Cj4gPiBIZWxsbywKPiA+Cj4gPiBrZXJuZWwg
dGVzdCByb2JvdCBub3RpY2VkICJCVUc6S0FTQU46c2xhYi11c2UtYWZ0ZXItZnJlZV9pbl9faW5l
dF9oYXNoIiBvbjoKPiA+Cj4gPiBjb21taXQ6IDg1OWNhNjBiNzFlZjIyM2UyMTBkM2QwMDNhMjI1
ZDljYTcwODc5ZmQgKCJbUEFUQ0ggbmV0IHYyXSBuZXQ6IGlwOiBvcmRlciB0aGUgcmV1c2Vwb3J0
IHNvY2tldCBpbiBfX2luZXRfaGFzaCIpCj4gPiB1cmw6IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRl
bC1sYWItbGtwL2xpbnV4L2NvbW1pdHMvTWVuZ2xvbmctRG9uZy9uZXQtaXAtb3JkZXItdGhlLXJl
dXNlcG9ydC1zb2NrZXQtaW4tX19pbmV0X2hhc2gvMjAyNTA4MDEtMTcxMTMxCj4gPiBiYXNlOiBo
dHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVsL2dpdC9kYXZlbS9uZXQuZ2l0
IDAxMDUxMDEyODg3MzI5ZWE3OGVhY2ExOWIxZDJlYWM0YzlmNjAxYjUKPiA+IHBhdGNoIGxpbms6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDgwMTA5MDk0OS4xMjk5NDEtMS1kb25n
bWwyQGNoaW5hdGVsZWNvbS5jbi8KPiA+IHBhdGNoIHN1YmplY3Q6IFtQQVRDSCBuZXQgdjJdIG5l
dDogaXA6IG9yZGVyIHRoZSByZXVzZXBvcnQgc29ja2V0IGluIF9faW5ldF9oYXNoCj4gPgo+ID4g
aW4gdGVzdGNhc2U6IGx0cAo+ID4gdmVyc2lvbjogbHRwLXg4Nl82NC02NTA1ZjllMjktMV8yMDI1
MDgwMgo+ID4gd2l0aCBmb2xsb3dpbmcgcGFyYW1ldGVyczoKPiA+Cj4gPiAgICAgICBkaXNrOiAx
SERECj4gPiAgICAgICBmczogZXh0NAo+ID4gICAgICAgdGVzdDogZnNfcGVybXNfc2ltcGxlCj4g
Pgo+ID4KPiA+Cj4gPiBjb25maWc6IHg4Nl82NC1yaGVsLTkuNC1sdHAKPiA+IGNvbXBpbGVyOiBn
Y2MtMTIKPiA+IHRlc3QgbWFjaGluZTogNCB0aHJlYWRzIDEgc29ja2V0cyBJbnRlbChSKSBDb3Jl
KFRNKSBpMy0zMjIwIENQVSBAIDMuMzBHSHogKEl2eSBCcmlkZ2UpIHdpdGggOEcgbWVtb3J5Cj4g
Pgo+ID4gKHBsZWFzZSByZWZlciB0byBhdHRhY2hlZCBkbWVzZy9rbXNnIGZvciBlbnRpcmUgbG9n
L2JhY2t0cmFjZSkKPiA+Cj4gPgo+ID4KPiA+IElmIHlvdSBmaXggdGhlIGlzc3VlIGluIGEgc2Vw
YXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEgbmV3IHZlcnNpb24gb2YKPiA+IHRo
ZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MKPiA+IHwgUmVw
b3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+Cj4gPiB8
IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjUwODExMDc1MC5hNjZh
NDIyNS1sa3BAaW50ZWwuY29tCj4gPgo+ID4KPiA+IGtlcm4gOmVyciA6IFsgIDEyOC4xODY3MzVd
IEJVRzogS0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gX19pbmV0X2hhc2ggKG5ldC9pcHY0
L2luZXRfaGFzaHRhYmxlcy5jOjc0OSBuZXQvaXB2NC9pbmV0X2hhc2h0YWJsZXMuYzo4MDApCj4K
PiBUaGlzIGthc2FuIGVycm9yIG5vdCByZWxhdGVkIHdpdGggTFRQIGNhc2UsIGkgZ3Vlc3MgaXQg
dHJpZ2dlcmVkIGJ5IG5ldHdvcmsKPiByZWxhdGVkIHByb2Nlc3Mgc3VjaCBhcyBiaW5kIGV0Yy4g
SSB0cnkgdG8gZ2l2ZSBmb2xsb3dpbmcgcGF0Y2ggdG8gZml4Cj4ga2FzYW4gZXJyb3IsIGNvcnJl
Y3QgbWUgaWYgYW55IG1pc3Rha2UsIHRoYW5rcy4KCk5vdGUgdGhhdCB0aGUgcmVwb3J0IHdhcyBm
b3IgdGhlIHBhdGNoIGluIHRoZSBtYWlsaW5nIGxpc3QKYW5kIHRoZSBwYXRjaCB3YXMgbm90IGFw
cGxpZWQgdG8gbmV0LW5leHQuZ2l0IG5vciBuZXQuZ2l0LgoKCj4KPiBGcm9tOiBXZWkgR2FvIDx3
ZWdhb0BzdXNlLmNvbT4KPiBEYXRlOiBTYXQsIDE2IEF1ZyAyMDI1IDA5OjMyOjU2ICswODAwCj4g
U3ViamVjdDogW1BBVENIIHYxXSBuZXQ6IEZpeCBCVUc6S0FTQU46c2xhYi11c2UtYWZ0ZXItZnJl
ZV9pbl9faW5ldF9oYXNoCj4KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZl
ci5zYW5nQGludGVsLmNvbT4KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWxr
cC8yMDI1MDgxMTA3NTAuYTY2YTQyMjUtbGtwQGludGVsLmNvbQo+IFNpZ25lZC1vZmYtYnk6IFdl
aSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+IC0tLQo+ICBpbmNsdWRlL2xpbnV4L3JjdWxpc3RfbnVs
bHMuaCB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcmN1bGlzdF9udWxscy5oIGIv
aW5jbHVkZS9saW51eC9yY3VsaXN0X251bGxzLmgKPiBpbmRleCBkYTUwMGY0YWUxNDIuLjVkZWY5
MDA5YzUwNyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3JjdWxpc3RfbnVsbHMuaAo+ICsr
KyBiL2luY2x1ZGUvbGludXgvcmN1bGlzdF9udWxscy5oCj4gQEAgLTU3LDcgKzU3LDcgQEAgc3Rh
dGljIGlubGluZSB2b2lkIGhsaXN0X251bGxzX2RlbF9pbml0X3JjdShzdHJ1Y3QgaGxpc3RfbnVs
bHNfbm9kZSAqbikKPiAgICogQG5vZGU6IGVsZW1lbnQgb2YgdGhlIGxpc3QuCj4gICAqLwo+ICAj
ZGVmaW5lIGhsaXN0X251bGxzX3BwcmV2X3JjdShub2RlKSBcCj4gLSAgICAgICAoKigoc3RydWN0
IGhsaXN0X251bGxzX25vZGUgX19yY3UgX19mb3JjZSAqKikmKG5vZGUpLT5wcHJldikpCj4gKyAg
ICAgICAoKigoc3RydWN0IGhsaXN0X251bGxzX25vZGUgX19yY3UgX19mb3JjZSAqKikobm9kZSkt
PnBwcmV2KSkKPgo+ICAvKioKPiAgICogaGxpc3RfbnVsbHNfZGVsX3JjdSAtIGRlbGV0ZXMgZW50
cnkgZnJvbSBoYXNoIGxpc3Qgd2l0aG91dCByZS1pbml0aWFsaXphdGlvbgo+IEBAIC0xNzUsNyAr
MTc1LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGhsaXN0X251bGxzX2FkZF9iZWZvcmVfcmN1KHN0
cnVjdCBobGlzdF9udWxsc19ub2RlICpuLAo+ICB7Cj4gICAgICAgICBXUklURV9PTkNFKG4tPnBw
cmV2LCBuZXh0LT5wcHJldik7Cj4gICAgICAgICBuLT5uZXh0ID0gbmV4dDsKPiAtICAgICAgIHJj
dV9hc3NpZ25fcG9pbnRlcihobGlzdF9udWxsc19wcHJldl9yY3UobiksIG4pOwo+ICsgICAgICAg
cmN1X2Fzc2lnbl9wb2ludGVyKGhsaXN0X251bGxzX3BwcmV2X3JjdShuZXh0KSwgbik7Cj4gICAg
ICAgICBXUklURV9PTkNFKG5leHQtPnBwcmV2LCAmbi0+bmV4dCk7Cj4gIH0KPgo+IC0tCj4gMi40
My4wCj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
