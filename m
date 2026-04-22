Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5822AFA1FFC
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 21:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776892376; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3brSipw1JxZ7qSKlK45l6IemdkDTLhI7TR+scscRil8=;
 b=WhvBu+Le923Z5CbQ290cIQidvfJ1/cpc4rrAo1KFh+3pRifXok6m3SI29H3nFsUjG3uSZ
 nN0n6LddlLpXZQMrLIvKKhe/cLf4Z7aks3DRsM4wVII2nuzXvLsyRpezIxD+3pU0tufDn3S
 aY7AqBBh6NsiP4Bo0OA/d81STWHIG7c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 857773E7062
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 23:12:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4D7F3E6FDE
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 23:12:33 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EC7E41A00249
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 23:12:32 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso23930895e9.3
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776892352; x=1777497152; darn=lists.linux.it;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLfX5712aTh39FgcQbjU7Licn3rEVlQpXs+5zsN+6Rg=;
 b=QvqGSTOQLbLNSA1bcneZWlF5nUsK3J+UnhvBB4cmWRDEv77Lv0X2Erv27jcahi/vub
 1CueDkos6jf1OFnloxXYbB0r7+UKLN5CAVM9txuqK0M1F2JQw/mxClyts6ts8p7uweSm
 DBDyuyQPlQqhGAh4+9tug0FHY3x0GWapadQ3EYNwaDwJEJpnDBccQ+Rvp3Vg9dosTCWW
 rn/wUZpFyzKkKJUkrhjkME4gVoZ421KurQWSvduZT7jW4IrRnmWrE0DapeM4FUnVp567
 pfAF7iwDHMoK72lkrp+P3pbLnYxOydzOvdPpWabZpT3XpbPP3l66t6WwuOGrEQvogDJG
 lETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776892352; x=1777497152;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LLfX5712aTh39FgcQbjU7Licn3rEVlQpXs+5zsN+6Rg=;
 b=MsM/y5hFCKOdOt+to3ICEukGhVAD0+N/3l5hP41lNZWbJ1FTk1e3wVi5KnDMjzi0IH
 TCq81wARX/7wEDKP7rUkAaWGa8L48CyQrodAOIp3Rzm2Qrsnkr7emjKn2q/3PzdwPUu3
 PIi9WPBJsnnBT/QCgvPVPOU9pzzve5Sd80KCFIwmXM5WrVVj+qxqPtyl3UQ/kq1dyoDt
 u7gHmpd2xKZLGTrsyA+5YC5Afu8VLdKxiyC92T50Jt7MLVQX84AdjyIkRgq+XgitrNva
 No+sZ87UMhuDjdtNNwHA2SNbHtBZm5YY1yrbQxZa9UBUbIvegqhh7QUDcRocpigWBEFF
 Ot+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+FJ3vu+cAPppDzAaU2MYbAPQgz1LhH3fBCeTsK3wuQ2fITLfX0ZCl75Qn5/1VgHDoSSw=@lists.linux.it
X-Gm-Message-State: AOJu0Yyh1hYX6TfYZGb2rkNg2im78hRlEDJXWOfvkFLCJEEYYCw1Ra20
 7gy7RmJ+Cav6MWURChZhYh4u+0fj5SdB6duDCxt5nLQaVwO+Z2kmTHS0PEesKZj7Kmg=
X-Gm-Gg: AeBDieskkNfsaVLY0JsOFeSjmi6TmeRib8AyIbsQqF7c4ysRkp3TehWz64dzgM+jaSl
 nvQmpUfmD6xsUNL4g8GI25q0YV/9wULZnWjr+bTFbmUQ+wElWUfiDm1jIzROOcO410BkVZibuWy
 8aNrB1xlegl/7Wlx/n1tTPLd62+hdWK0C1Dn7tEOQovF8q13MJ82HLo0wCb4Wy8gYo5icpGxhFw
 g7u9smOPuQaz3zEXCE7Ss7zGfspkWGdPhm6b5YWoUFbb5Gm7UbFPt5mxub6pnnqUMzHfPu20v95
 1MZmeUktPp2htJBfTGvCr1rZc/vSuhO9z2M6pwTZ+zlF8v9IfjTEZnAlCaR11dvGYDf+6xFxzol
 EMuiLoFaMVb853U8D0oxeGHu1+ejmMolWclzcwYPTb1shTmWsq5/fP6PaaE7eAp7PkPvMN6D2Xc
 D3BHL9g32G9DvTo4EY17bccd4=
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id
 5b1f17b1804b1-4891c1f38c8mr228221245e9.6.1776892352247; 
 Wed, 22 Apr 2026 14:12:32 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:2ecf:67ff:fe81:9da0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ea8e4b373dsm8171428eec.6.2026.04.22.14.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 14:12:31 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 22 Apr 2026 18:12:29 -0300
Message-Id: <DHZZRO62EJIT.LI44FS2U1Z2B@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.21.0-120-g22b95d38161f
References: <20260422113136.416482-1-pvorel@suse.cz>
In-Reply-To: <20260422113136.416482-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] include: Remove 'make install' support
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>,
 =?utf-8?b?UmljYXJkbyBCIC4gTWFybGnDqHJl?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkIEFwciAyMiwgMjAyNiBhdCA4OjMxIEFNIC0wMywgUGV0ciBWb3JlbCB3cm90ZToKPiBM
VFAgaGVhZGVycyBhcmVuJ3QgbmVlZGVkIHRvIGJlIGluc3RhbGxlZCwgdGhleSBhcmUgdW51c2Fi
bGUgd2l0aG91dCBMVFAKPiBjb3JlIGxpYnJhcnkgYW55d2F5ICh3aGljaCBpcyBub3Qgc2VwYXJh
dGVkIGZyb20gc291cmNlcykuIFRoZXJlZm9yZQo+IG5ld2x5IGFkZGVkIE1ha2VmaWxlIGZvciAn
bWFrZSBjaGVjaycgaW4gNjg0Y2FlNzU1MiAoImluY2x1ZGUvbGFwaTogYWRkCj4gbGVhZiBNYWtl
ZmlsZSIpIGRpZCBub3Qgc3VwcG9ydCBpdC4gUmVtb3ZlIGl0IGFsc28gZnJvbQo+IGluY2x1ZGUv
TWFrZWZpbGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4K
ClJldmlld2VkLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKPiAtLS0K
PiBIaSwKPgo+IHRyaXZpYWwgcGF0Y2gsIGJ1dCBJJ2QgYXBwcmVjaWF0ZSB5b3VyIGFjayB0aGF0
IHdlIHJlYWxseSBkb24ndCB3YW50Cj4gaGVhZGVycyB0byBiZSBpbnN0YWxsZWQuIE90aGVyd2lz
ZSBpdCdkIGhhdmUgdG8gYmUgYWRkZWQgYWxzbyB0bwo+IGluY2x1ZGUvbGFwaS9NYWtlZmlsZSAo
YWRkZWQgaW4gNjg0Y2FlNzU1MikuCgpUaGFua3MhCgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIK
Pgo+ICBpbmNsdWRlL01ha2VmaWxlIHwgOSArLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCA4IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvTWFr
ZWZpbGUgYi9pbmNsdWRlL01ha2VmaWxlCj4gaW5kZXggODRjZDRlZDZlMy4uN2ZlNzJhMjU1NyAx
MDA2NDQKPiAtLS0gYS9pbmNsdWRlL01ha2VmaWxlCj4gKysrIGIvaW5jbHVkZS9NYWtlZmlsZQo+
IEBAIC0xLDE5ICsxLDEyIEBACj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIKPiAgIyBDb3B5cmlnaHQgKEMpIDIwMDksIENpc2NvIFN5c3RlbXMgSW5jLgo+ICsj
IENvcHlyaWdodCAoYykgTGludXggVGVzdCBQcm9qZWN0LCAyMDI2Cj4gICMgTmdpZSBDb29wZXIs
IEp1bHkgMjAwOQo+ICAKPiAgdG9wX3NyY2RpcgkJPz0gLi4KPiAgCj4gIGluY2x1ZGUgJCh0b3Bf
c3JjZGlyKS9pbmNsdWRlL21rL2Vudl9wcmUubWsKPiAgCj4gLUlOU1RBTExfRElSCQk6PSAkKGlu
Y2x1ZGVkaXIpCj4gLQo+IC1JTlNUQUxMX01PREUJCTo9IDAwNjQ0Cj4gLQo+IC1JTlNUQUxMX1RB
UkdFVFMJCTo9ICouaAo+IC0KPiAtTUFLRV9UQVJHRVRTCQk6PQo+IC0KPiAgLlBIT05ZOiBhYy1j
bGVhbiBhYy1kaXN0Y2xlYW4gYWMtbWFpbnRhaW5lci1jbGVhbiBkaXN0Y2xlYW4gbWFpbnRhaW5l
ci1jbGVhbgo+ICBkaXN0Y2xlYW46OiBjbGVhbiBhYy1kaXN0Y2xlYW4KPiAgbWFpbnRhaW5lci1j
bGVhbjo6IGRpc3RjbGVhbiBhYy1tYWludGFpbmVyLWNsZWFuCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
