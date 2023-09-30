Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CC6E7734B
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 00:12:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 171E23CF224
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 02:12:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74F023CB9C8
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 02:12:03 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D6CEE602F65
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 02:12:02 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-405459d9a96so31505e9.0
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 17:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696032722; x=1696637522; darn=lists.linux.it;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FM803E0J5QiMS/bT+BQOq8A5Bci/86ToLI2bYKsuqQk=;
 b=O14QG7vLabD3viRbvjvfd4rSaRk58veZ44e0wTR8+JOiuVXV6z06wfhG7UYVfPpWmA
 vyd6kYhekw1zK6W8FPLrYuLqKo4C50ZudXq+WSc9Awr0jOL5oCw9syBbTlcU/QrtZOJS
 NtkH0e2Ok0KBcz+aK5oMv8BD6BGhx2NxyZ9x1x56lakmkX3UFRqdf7LDwUGYyFhQX4Cf
 a3me1BYI3IsLtQQ6Dvq6RPpcXwfkPKBumBuLCsxyuX1RhaRLJ9s/qNx5LUCyhO/4nYPL
 pJDs425WJJsG/4WIhUveigXrRlYkNiY1+++fOVm3QCUWn9/eVsLm2vR+tKSJBXMSTipG
 FE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696032722; x=1696637522;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FM803E0J5QiMS/bT+BQOq8A5Bci/86ToLI2bYKsuqQk=;
 b=AXtXmL87Tyhgb5/2cmAl3GC5R1YOkXcmyqkvsk5pkzFWwSFc0K2al7Vsk5cAs+gFwN
 Ka1BpHWFeAp1AnhbgJKPNI31jivfJfbhXdVM39ba4LhhZFeEbLya5k9N8zEpACq0PrUS
 TrJC4UCnvtX1Y3xX3yFo3vU78n8vsUR0rlTgS0kWK7xRhzvhEWFnRKKqQewOLt/gv0xG
 SXqo/7sz/uEq8/JuaKzExF42eR/w6keqCbf52GETsFozghJ5VVP+rwLmLZx46XEv+hYT
 gNaWxwwvb+aeJqy+dlXqU6v9tTnOzMdLhoV2cEIN6DvsfGaBU9+PAfIiURZdm8NIwU7r
 7B3A==
X-Gm-Message-State: AOJu0YwYX3/COcNHDMtdBC+/kQm/DPT1G5sC+79Zts5vnIpxy3E26BHd
 W/c374GS7IV1YPyfQC9++FTjWiticDYh8ZV3PYjoCQ==
X-Google-Smtp-Source: AGHT+IEelag3Ar0PcCfpdS/mKpJcgtakFP5T/I3jFlTZZBAU/rJ69D/QVU6e4wKxydeJv7iKieXV/XWPWMiFbP+XOaE=
X-Received: by 2002:a05:600c:154f:b0:400:c6de:6a20 with SMTP id
 f15-20020a05600c154f00b00400c6de6a20mr11wmg.3.1696032722186; Fri, 29 Sep 2023
 17:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZQF5J0UJ25_QLwcQ@yuki> <20230926105011.GA133737@pevik>
In-Reply-To: <20230926105011.GA133737@pevik>
Date: Fri, 29 Sep 2023 17:11:35 -0700
Message-ID: <CAG4es9VBBkLe93sSyptHc4HF0O91G+1P47cfpkKH9OYsoYCvRg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClNvcnJ5IGZvciB0aGUgbGFzdCBtaW51dGUgcmVwbHkuICBKdXN0IHNlbnQgdHdv
IG1pbm9yIHBhdGNoZXMgZm9yIHBpcGUwNyBhbmQKZ2V0cGdpZDAxIHRoYXQgd2VyZSBmYWlsaW5n
IG9uIEFuZHJvaWQuICBPdGhlciB0aGFuIHRoYXQgaXQgbG9va3MgZ29vZCBzbyBmYXIuCgpUaGFu
a3MgZm9yIGFsbCB5b3VyIGhhcmQgd29yay4KCkNoZWVycwpFZHdhcmQKCk9uIFR1ZSwgU2VwIDI2
LCAyMDIzIGF0IDM6NTDigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4K
PiBIaSB0ZXN0aW5nIGNvbW11bml0eSwKPgo+ID4gSGkhCj4gPiBBcyB1c3VhbGwgd2UgYXJlIHN1
cHBvc2VkIHRoZSByZWxlYXNlIExUUCBhdCB0aGUgZW5kIG9mIHRoZSBtb250aC4gSW4KPiA+IG9y
ZGVyIHRvIGdldCBhdCBsZWFzdCB0d28gd2Vla3Mgb2YgcHJlLXJlbGVhc2UgdGVzdGluZyBJIHdv
dWxkIGxpa2UgdG8KPiA+IGZyZWV6ZSB0aGUgZ2l0IHN0YXJ0aW5nIG5leHQgd2Vlay4gSSB3aWxs
IHRyeSB0byByZXZpZXcgYW5kIG1lcmdlIGFzCj4gPiBtdWNoIGFzIHBvc3NpYmxlIHRpbGwgdGhl
IGVuZCBvZiB0aGlzIHdlZWsuIElmIHRoZXJlIGlzIGFueXRoaW5nIHRoYXQKPiA+IHlvdSB0aGlu
ayBzaG91bGQgZ28gaW50byB0aGUgcmVsZWFzZSBsZXQgbWUga25vdyBzbyB0aGF0IEkgY2FuIGhh
dmUgYQo+ID4gbG9vay4KPgo+IEZZSSB3ZSBwbGFuIHRvIHJlbGVhc2UgTFRQIHRoaXMgd2VlayBv
biBGcmlkYXkuIEl0J3Mgbm90IG11Y2ggdGltZSBsZWZ0LCBidXQgaWYKPiB5b3UgaGF2ZSB0aW1l
LCBwbGVhc2UgdHJ5IHRvIGRvIHNvbWUgTFRQIHByZS1yZWxlYXNlIHRlc3Rpbmcgb24geW91ciBm
YXZvdXJpdGUKPiBkaXN0cm8uCj4KPiBUaGFua3MhCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
