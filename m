Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EFAC7EE29
	for <ltp@archiver.kernel.org>; Wed,  7 Jun 2023 06:44:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5F583CC999
	for <ltp@archiver.kernel.org>; Wed,  7 Jun 2023 08:44:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA8983CAEAF
 for <ltp@lists.linux.it>; Wed,  7 Jun 2023 08:44:31 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3FD8E6007A4
 for <ltp@lists.linux.it>; Wed,  7 Jun 2023 08:44:31 +0200 (CEST)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-569386b7861so4208757b3.0
 for <ltp@lists.linux.it>; Tue, 06 Jun 2023 23:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686120270; x=1688712270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gULSKx9ZqupQfwCBCfIgy+0g0+B28bI9lBpwoG9gI8E=;
 b=nI0IosgdPLzxzCzP6VuaWCKs0nhtzhVAUUlmd9/XNqzBKumJXQKvZIYQDfOE+chgBg
 bm61jjcqdCS9DoBxwtEMGW4vutC1+2h3ae/7UmCKhrNIx2jhhEgSeY1tOiAb/qyUlLIo
 WlNrTh8asjMQGyc1nyWWSlYntcbWEA6smX/n98MR694yW2pjMbn2sW2btzG7nwmC2hv0
 vYOCTl06FH5Hg0DJuQbpLCc4OE/6kwsOcQuoY6/+pB2JqdvYXAGqLhAEyjo3H9UtcaGp
 b5IDg1RZ+bc0rR0EQEMHBwtSuxIgSu2Kzf/XuIByXQ6/x/o5uf4zfQVpuid+6iTuR7WS
 g8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686120270; x=1688712270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gULSKx9ZqupQfwCBCfIgy+0g0+B28bI9lBpwoG9gI8E=;
 b=lIx0UOYUKxAr6e5qB1L9trjDYTOxf2b4BS9GLwjO1CoAo4L2hCscN5UvMft0ngiPHk
 tMXckXTRR+LLn7m7Xe7wmSL60LolbTzgZOLlzC+kGnD1nkfGBW09xY73ryGO7sVt9XEe
 AfzwR05kC8iCJSq5yhxtOQF0lYI/LR3NfhEvp1v5ymV+qzmpDxDH/uztr1juaeALURUk
 QWmXxc5ZA+KvuSQ3Jqki4Mu1jL8XmJbVX2YHr2ESUKd196JG7CzIF+E7t39jq6phgkWv
 5J0YPhF8RAQF9lnesqEP3SjpMPNNcIJzWwdfqnbFhiTOEII8R3nMznhLQ7V4J7bMbGQm
 P6uA==
X-Gm-Message-State: AC+VfDz7hY3zq8DL6jOcVIWapzf9P1U9VxosAhzg6mlafjTZAleWIIi9
 rKX6VJSzSce+pzcGlcB6LKclSZKlffH8jgcXkbrwXA==
X-Google-Smtp-Source: ACHHUZ48wCWM6Y4BXCsMI48tYoV3a2k2HqmPVp4ZpC9odVLx27Q0wGQ20CHBmsYrjiA7ef6kAoZs87UPshCfXXPYbIc=
X-Received: by 2002:a0d:d697:0:b0:561:987e:27a with SMTP id
 y145-20020a0dd697000000b00561987e027amr5016731ywd.10.1686120270031; Tue, 06
 Jun 2023 23:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230605044131.798383-1-dlemoal@kernel.org>
 <20230605044131.798383-2-dlemoal@kernel.org>
In-Reply-To: <20230605044131.798383-2-dlemoal@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Jun 2023 08:44:18 +0200
Message-ID: <CACRpkdYdtgcLSqovV-HwZ9PvSXFBZv5wdU3KzasMR1wHgah4kg@mail.gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ioprio: use ioprio.h kernel header if it
 exists
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

T24gTW9uLCBKdW4gNSwgMjAyMyBhdCA2OjQx4oCvQU0gRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxA
a2VybmVsLm9yZz4gd3JvdGU6Cgo+IEZvciB0aGUgaW9wcmlvIHN5c3RlbSBjYWxsIHRlc3QgY2Fz
ZXMsIGF2b2lkIGJsaW5kbHkgZGVmaW5pbmcgdGhlCj4gSU9QUklPX1hYWCBtYWNybyBpbnRlcm5h
bGx5IGFuZCBpbnN0ZWFkIHVzZSB0aGUga2VybmVsIHVzZXIgQVBJIGhlYWRlcgo+IGZpbGUgaWYg
aXQgZXhpc3RzLiBHaXZlbiB0aGF0IHRoZSBkZWZpbml0aW9ucyBpbiB0aGlzIGhlYWRlciBmaWxl
IGhhdmUKPiBjaGFuZ2VkIG92ZXIgdGltZSwgbWFrZSBzdXJlIHRvIHRlc3QgZm9yIHRoZSBleGlz
dGVuY2Ugb2YgdGhlIG1hY3JvCj4gSU9QUklPX1BSSU9fTEVWRUwgbWFjcm8gYW5kIGRlZmluZSBp
dCBpZiBpdCBkb2VzIG5vdCBleGlzdC4gU2ltaWxhcmx5LAo+IHVzZSBJT1BSSU9fTlJfTEVWRUxT
IHRvIGRlZmluZSBJT1BSSU9fUFJJT19OVU0gaWYgdGhhdCBtYWNybyBleGlzdHMuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPgoKUmV2aWV3ZWQt
Ynk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4KCllvdXJzLApMaW51
cyBXYWxsZWlqCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
