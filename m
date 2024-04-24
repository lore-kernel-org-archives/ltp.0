Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CBEC4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 00:28:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F1DC3CFFBA
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 02:28:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A90E3CFA64
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 02:28:41 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0806B6005D7
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 02:28:41 +0200 (CEST)
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-de45f3f092bso7124267276.0
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 17:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713918520; x=1714523320; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+L5ThmivvuHGl402QOyGvXJoTsHWtH7A7A+PDKi1p4A=;
 b=Jmx+ybsUK4nqHYKvn3EnS7S+J2V+Yy4wTS4KjBiza7Tc/IOZ3yL7pNdDoFh7rzock1
 HCw/4jcyPGqIKMqKzfzk/wRqKwbQDwEFTjZ33Rt6O+L0C85XtLXK/ekjo76WseFz9ypi
 gfScmo56JQYiHnhW7B4hc1w1Wa9DyZcsP2Laxhjc5nvjONasUnMYCHeYq5rYTMQPs9CC
 9YslO3px0mJ8fkNqYoFnkXb96A2gMYlCkFw12+HeD+U84nSJG6xTAKuZ4LxqCfVZXTum
 7jwuCopgoi5siQJzvoVpFp94pIj51yn6LkKtED6AQ9Cb+jTYfP51bQYnnBNgfSZJhf6X
 xZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713918520; x=1714523320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+L5ThmivvuHGl402QOyGvXJoTsHWtH7A7A+PDKi1p4A=;
 b=nqm3smNibI2Novb2xrtuq0O4ZLWIF682528ico3hAn8GkZK4PBruEa1m9Epa2go473
 tkcJKCGlPx6bF6F7CyPzd0O1FbUxULJkYhCKJiPqlmsUir9t14sebi24h45KGxzighmF
 pMhgslvuvzmLKSo30mvD6bhAH8fQBcv45xnOkPha7BZYWS7/9AyBs7UnTXfBRelifaUC
 /yoF0feQ7RVsLWgjo7DKbOX5t/TrHcxx2HWVBSadlXZihAM/0g3x/+gG3nvN2x2gReLP
 z5De4mNOgOyQtfbmrS0NbDZF4cN1mH5KIn97SJE1dd0ByVEz+DtfB1vlSIxO/ecizH2+
 ds+w==
X-Gm-Message-State: AOJu0Yz9jnGjoadL2HVbinz4Y2yFBxOYWpwdls2ZK5zVFqK9zKJmwzU1
 myUah5reOOU0Yy97XogT28b03/xWk9H/LJIH/jSMGHKc/tfnIGsXwrSRMAJ0OpfEbcSAf3Wdqik
 0zQRvy2qrb1Cat1tjZveZ7tU+63o=
X-Google-Smtp-Source: AGHT+IFzu3vTW01hRbtRPGDQor9jGCzeNKpfAzni9v18O81gD7lEuIsyRZB7EAjaHht8NIQl/RTf6V9n/S3MYVdhZZI=
X-Received: by 2002:a25:bf8d:0:b0:de4:5faf:5efc with SMTP id
 l13-20020a25bf8d000000b00de45faf5efcmr1163764ybk.61.1713918519753; Tue, 23
 Apr 2024 17:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240423070643.38577-1-jencce.kernel@gmail.com>
 <20240423135419.GB195737@pevik>
In-Reply-To: <20240423135419.GB195737@pevik>
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Wed, 24 Apr 2024 08:28:28 +0800
Message-ID: <CADJHv_vaUCPCtYj4cMfsxDAL4r8AWveYCpSw8Pm9AeDvf0Qs8w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] readahead01: pass on pidfd
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

SGksCgpPbiBUdWUsIEFwciAyMywgMjAyNCBhdCA5OjU04oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+IHdyb3RlOgo+Cj4gSGkgTXVycGh5LAo+Cj4gPiBMaW51eCBrZXJuZWwgYWRkZWQg
cGlkZnMgdmlhIGNvbW1pdCBiNTY4M2EzN2M4ODEgaW4gdjYuOS1yYzEKPiA+IHJlbGVhc2UuIFRo
aXMgcGF0Y2hzZXQgaWdub3JlcyByZWFkYWhlYWQgcmVxdWVzdCBpbnN0ZWFkIG9mCj4gPiByZXR1
cm5pbmcgRUlOVkFMLCBzbyBtYXJrIHRoZSB0ZXN0IHBhc3MuCj4KPiBJIGtub3cgdGhhdCBDaHJp
c3RpYW4gQnJhdW5lciBzdWdnZXN0ZWQgaXQgKGhlIHdvdWxkIGRlc2VydmUgU3VnZ2VzdGVkLWJ5
OiApLAo+IGJ1dCBJIHdvdWxkIHN0aWxsIGFwcHJlY2lhdGUga2VybmVsIG1haW50YWluZXIgb3Bp
bmlvbiwgdGh1cyBub3QgbWVyZ2luZyB5ZXQuCgpHb3QgaXQuIFRoYW5rcyEKPgo+ID4gaHR0cHM6
Ly9sa21sLml1LmVkdS9oeXBlcm1haWwvbGludXgva2VybmVsLzI0MDMuMi8wMDc2Mi5odG1sCj4K
PiBGWUk6IGxvcmUgaXMgbW9yZSBwZXJtYW5lbnQgbGluazoKPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9sa21sLzIwMjQwMzE4LWZlZ2VuLWJlemF1YmVybi01N2IwYTljNmY3OGJAYnJhdW5lci8K
Pgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiA+IFNpZ25lZC1vZmYtYnk6IE11cnBoeSBaaG91
IDxqZW5jY2Uua2VybmVsQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvcmVhZGFoZWFkL3JlYWRhaGVhZDAxLmMgfCAxICsKPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvcmVhZGFoZWFkL3JlYWRhaGVhZDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3JlYWRhaGVhZC9yZWFkYWhlYWQwMS5jCj4gPiBpbmRleCBkNGIzZjMwNmYuLmFlZDhlN2YzMSAx
MDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVhZGFoZWFkL3JlYWRh
aGVhZDAxLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVhZGFoZWFkL3Jl
YWRhaGVhZDAxLmMKPiA+IEBAIC01Myw2ICs1Myw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfaW52YWxp
ZF9mZChzdHJ1Y3QgdHN0X2ZkICpmZCkKPiA+ICAgICAgIGNhc2UgVFNUX0ZEX01FTUZEOgo+ID4g
ICAgICAgY2FzZSBUU1RfRkRfTUVNRkRfU0VDUkVUOgo+ID4gICAgICAgY2FzZSBUU1RfRkRfUFJP
Q19NQVBTOgo+ID4gKyAgICAgY2FzZSBUU1RfRkRfUElERkQ6Cj4gPiAgICAgICAgICAgICAgIHJl
dHVybjsKPiA+ICAgICAgIGRlZmF1bHQ6Cj4gPiAgICAgICAgICAgICAgIGJyZWFrOwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
