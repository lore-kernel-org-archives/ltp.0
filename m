Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A3ACD342F
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778232550; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Uf8nI+4CD/kFD03HaD2TxD8UOnPmwy3S6WiTpVS6KyI=;
 b=CXu9BfbAaRiuHAGv2eeZyt2qg1lxjrO8f3GzrlKNJx0OOeuRBC/8MrvVB2VftrfibiEnX
 N//q9EOlqKLfpeoDgWfJW6clF4o3iMi2MnZ4qu1Snf7Tyv23f989pJ6JOiELdvZ/4qH5k35
 a6on01tyLhWTLwJslGT6JLA3uwCL/TQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F8633E2C24
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 11:29:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D4AF3E2460
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:28:46 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E69AB100037D
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:28:45 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d75312379so1904458f8f.1
 for <ltp@lists.linux.it>; Fri, 08 May 2026 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778232525; x=1778837325; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=J6xHGFAj3Usp4hb4Hwq2eO82yLsoFIxhGCCy7eDAIWc=;
 b=YhYzggllsE1L9QucvL00KgZj5cF/pM4QiKwn3WOG3hAFrnxV3ga3kxosWxjtWgOj8j
 hdMUoG+WJZL+8p9vkl8gEiYo2mpva67iYevmkmJS9VcIJI+IqjBs5KsRA1tRAPDmbpKw
 9TBB4AeFUGRXM2vHyZHQN28QM+c+oKyqw1i2PhCGA9iD5bIe2s4D86AOQpvf4cGSpPj5
 aS84eiUq91nuJwqsqIQhiMpkUK75hZgbeLVW9RyTA+WWSZG9RIYw/TrbNXx6Jn82O6P8
 DnnBz205AE85r//PNbU2ud+3vQzDv5hu4Aht3+yOSJHRStZRyCGPHalJ5IW/jrWjpfOH
 Wp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778232525; x=1778837325;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6xHGFAj3Usp4hb4Hwq2eO82yLsoFIxhGCCy7eDAIWc=;
 b=GHrnrI6sLSgTx89hNq1xRKvp1FTO8K3k+CKTBXpbvXplaRlm3tTwyKJCtgWmPO1hVQ
 UK9wOLSovSFvGt/stQG7YhLBRR6NzfZXs+veaD3dAv2HyKsP3nl+aqp2e3Yk8d1jGATs
 SAvjCCfMOuI9roDIp+baENbjQyzlZjXWqJemkxFXZvOrDmyPSK7COo30uI/EzkoX2iHn
 HdhwVJYNEcXnsY1o3uzX9q01OY4ADnTW1MP7RA1DgN3Vp1txSY9zaIo8+gcfhOfb3yr0
 6nwIagqNZoUIsQuFBhI/PC9C2yl+Ml6y5keDy0edhdChDZEZ41vj2PYNeecbJvv8LHhi
 on9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/0THjax8v+DjuVYzWOHc4yaGhtuFYlNJ6WhluWrc28FlzfryuvfyiDmmt0q263zRkC0M=@lists.linux.it
X-Gm-Message-State: AOJu0YzeXS+Rb/tE+BoDHiMTMycVY6ClS+1MfG8uUG09/LQmv43BKNux
 UW7RI6ZvCHRZFVjUbZaP5pUlcSDoJ/I8VymVjve6z7NBCnKJtnsOvYLmu8S1TeEfRZI=
X-Gm-Gg: Acq92OE90narecGr/TlYoXUocB6K1biiALA+pGmL0y2Jiewe+u3KgjNZD14w6ERqgE9
 sgUdKfzeyAsNwnahJyHdVxL8SMlg/9pjvNOcZriVOuQl7qTnDMf7/fZ1KWXdIpYX1w7R1O6cCuM
 ppLH5mRBmtZq11nUOg3luSlMTCbpQrIC2+qVXilpuuUp3Z+VohHI4jPntNYEM7ryC27Q+KxgQCY
 1+dTB57sF2HpWKqfVIhIwT4gYYv+sRS3MdZ3iAfYgiDshBz76PA6BWSTHNmRPwXraiV9uHS8vAF
 1/cQNq71L2r/7pW6nOIhdfi1cLJwxXCzT6CZcV1uEML2/VSkiduimUTEdQo0wkEQcN0jMfiXyJs
 g/vSJQyqRFLgIP2GSXSsqdFJVXaSf/J5OvM0whdu9ldKSnhkVQEfER606eX4AxmnMch2dy5p4Th
 YTEe2MN/FFvjel3z3zBbfBI2Xqaxi1N0VMHGFYmLJlVN/LDjV/SdywZRkmd+vun9uNuyxv+OIQR
 hjL3EYGDdrty3YO1ciFf81eh/ZIK8zfreY=
X-Received: by 2002:a5d:5e01:0:b0:43e:531f:720c with SMTP id
 ffacd0b85a97d-452e96d51bbmr9848507f8f.11.1778232525203; 
 Fri, 08 May 2026 02:28:45 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a73c3sm3298065f8f.3.2026.05.08.02.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 02:28:44 -0700 (PDT)
Message-ID: <69fdaccc.df0a0220.3305d6.27a5@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260508092646.3949-1-linuxtestproject.agent@gmail.com>
Date: Fri, 08 May 2026 09:28:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: fallback SPLICE_F_MORE
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgo+IEhpIEFuZHJlYSwKPiAKPiAtLS0gW1BBVENIIDEvM10gLS0tCj4gCj4gT24gMjAyNi0w
NS0wOCwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiA+IGxhcGk6IGZhbGxiYWNrIFNQTElDRV9G
X01PUkUKPiAKPiBUaGUgY29tbWl0IGJvZHkgaXMgZW1wdHkuIFBsZWFzZSBhZGQgYXQgbGVhc3Qg
b25lIHNlbnRlbmNlIGV4cGxhaW5pbmcKPiB3aHkgdGhpcyBmYWxsYmFjayBpcyBuZWVkZWQg4oCU
IGUuZy4gd2hpY2gga2VybmVsIHZlcnNpb24gaW50cm9kdWNlZAo+IFNQTElDRV9GX01PUkUsIG9y
IHRoYXQgaXQgaXMgcmVxdWlyZWQgYnkgdGhlIHhmcm0wMSB0ZXN0IGFkZGVkIGxhdGVyCj4gaW4g
dGhpcyBzZXJpZXMuCj4gCj4gLS0tIFtQQVRDSCAyLzNdIC0tLQo+IAo+IE9uIDIwMjYtMDUtMDgs
IEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4gPiBsYXBpOiBmYWxsYmFjayBVRFBfRU5DQVAgYW5k
IFVEUF9FTkNBUF9FU1BJTlVEUAo+IAo+IFNhbWUgaXNzdWU6IHRoZSBjb21taXQgYm9keSBpcyBl
bXB0eS4gQWRkIGEgc2VudGVuY2UgZGVzY3JpYmluZyB3aHkKPiB0aGVzZSBjb25zdGFudHMgbmVl
ZCBhIGZhbGxiYWNrIGRlZmluaXRpb24uCgpUaGVzZSB0d28gY2FuIGJlIHNhZmVseSBpZ25vcmVk
LgoKUmVnYXJkcywKLS0KQW5kcmVhIENlcnZlc2F0bwpTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5l
ZXIgTGludXgKYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
