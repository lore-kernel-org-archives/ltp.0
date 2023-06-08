Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F221EC7EE29
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 07:40:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D1CC3CB2E7
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 09:40:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D9063CA775
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 09:39:53 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C5CB61000B5C
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 09:39:52 +0200 (CEST)
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-bacf9edc87bso387127276.1
 for <ltp@lists.linux.it>; Thu, 08 Jun 2023 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686209991; x=1688801991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yz/E2VWJ5V3HmEgOLYeR6IO/Q/HhuRBlj6aoRXxOxo4=;
 b=glVQPU/JJY4wNO75UJD7HcBgLNtbUILiRQGfF0zAawopjZY07YL/1AG+EjFXQ7Jo0V
 8qs10z7gcC+Bku7EiFjtnrkniWfppmSiAXy0rsIm18kvu7Mu6JuKKxSBHzLk3hJqxDF5
 +vBy5sTXhVYxk6xOucgdOSSd3q5JpcL9Ggx89qgQABXobs+tsdUobL0u5WJrmYOSuRy6
 Yl5C9wnXNVgUD6g6b0QQbToxIAdUUfx7trdZhlg14qIblipe+Cn+zf4da0c97L0SRvt3
 TBOIwk2FUKz0sYlN/IyWQt0vRnzxa/I77lE5kcbOgzy/6ONCpqTFvTMEmhr+UydjDGBQ
 OVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686209991; x=1688801991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yz/E2VWJ5V3HmEgOLYeR6IO/Q/HhuRBlj6aoRXxOxo4=;
 b=HCX9ABtcDxhQXkodA5GJViJldAjY/6kFwCFIc0Xd68tokiriSrOWIi+x5d0wny9v/k
 g27iXbFe8XEvPGYgglmFS8aOuwUkN34PTCqsH6QOyk3meS6jU2NRLT0AvN+szCgDcek9
 9bAH2dJdDYoh3bVGYV1/93QfVGJHHU4lOLw40GkSr/FjxU8X/4Usi6Rlf88y3EY6WzNv
 qX6vzmrKif9waw+XEzr8RDYK5j89U8b665iKy5w/CL47swr4HUDgZR0SUGJrd31MztQK
 CjXfgNoz8dWFWWeicULCM2pu5NMoe5EDxWBQujLKJXrT46Iz/ut15NoiLKegllksEuMZ
 KhFA==
X-Gm-Message-State: AC+VfDwLLPI1OUMuW+7ebaAzD03w5leQA9rvkQ6cEyIN+DGIpknAu3ou
 iTkMfmZSTwJWTIPmUEyE4HUaGxOVE74M5zTTGfer5A==
X-Google-Smtp-Source: ACHHUZ6tMgsx1WYGP+3Yfxf+SNvqyT5E83oYjRNnnFZ3V7w6/SvTIQ9BriJaB2cdGlTcLg7grFYrKew/RaX382uuyXE=
X-Received: by 2002:a0d:cd04:0:b0:568:f405:cbfe with SMTP id
 p4-20020a0dcd04000000b00568f405cbfemr8727360ywd.47.1686209991542; Thu, 08 Jun
 2023 00:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230605044131.798383-1-dlemoal@kernel.org>
 <20230605044131.798383-3-dlemoal@kernel.org>
 <CACRpkdaBinsAofvQgLZ5u8ScR0+yWPnQCf6E7CPtn598PN0eoQ@mail.gmail.com>
 <0347361d-1676-3fb3-da73-da54657ad8f9@kernel.org>
In-Reply-To: <0347361d-1676-3fb3-da73-da54657ad8f9@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Jun 2023 09:39:40 +0200
Message-ID: <CACRpkdaD3xM=Z0xTzHa+yH-wZ+LyhrSb3ZzGzkGdnboCaHw_+A@mail.gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ioprio: Use IOPRIO_PRIO_NUM to check prio
 range
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCAyOjU14oCvQU0gRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxA
a2VybmVsLm9yZz4gd3JvdGU6Cgo+IFRoYW5rcyBMaW51cyAhCj4KPiBNYXkgSSBhbHNvIGFzayBm
b3IgeW91ciByZXZpZXcgb2YgdGhlIGtlcm5lbCBpb3ByaW8gQVBJIHBhdGNoID8KPiBJdCBpcyBo
ZXJlOgo+Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmxvY2svMjAyMzA1MzAwNjEz
MDcuNTI1NjQ0LTEtZGxlbW9hbEBrZXJuZWwub3JnLwoKU2FkbHkgSSBkb24ndCBoYXZlIHRoaXMg
cGF0Y2ggaW4gbXkgaW5ib3gsIGJlY2F1c2UgaXQgYXBwZWFycyBJIGZlbGwKb2ZmIHRoZSBibG9j
ayBtYWlsaW5nIGxpc3QgYW5kIHdhc24ndCBvbiBUbyBvciBDYy4gSWYgeW91IHJlc2VuZAp0aGVu
IGluY2x1ZGUgbWUgb24gQ0MgYW5kIEknbGwgaGF2ZSBhIGxvb2shCgpZb3VycywKTGludXMgV2Fs
bGVpagoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
