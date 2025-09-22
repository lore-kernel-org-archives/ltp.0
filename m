Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A338CAC592
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758538542; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1sPx+daQGGDbBQhOUMFk4ZhARcz1wUBsqExpc6QsBEs=;
 b=B25e2PW3YSLTNhHiUwEmWcoR9GrJxdk7YZKk7tiz63urkvnWR/eMziM7QzpqFH5BBSO6f
 S+lnBjK+a7xZBmp5yKOWkeuGcVEAWA+P8ohqsDcsV8AcVtojz/EIJFDjSrtoSul7EbfO+jp
 KElg2S9jmAanyQ8IrGTYsZWzS4nK7Q0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 268593CDE56
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 12:55:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87FBF3CC05E
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:55:20 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F62210009A6
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:55:19 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ef166e625aso2108346f8f.2
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758538519; x=1759143319; darn=lists.linux.it;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KO5sJeGqUItfo6WaWMQB5R3qCIcPhuGFwNEB/y7ohaA=;
 b=Eb5OnRrO9Wv5kr2CLsNR91mmzNgR+237NBTfA1VrYtoJf/aKPBn3PfQjBFbAxT3g9O
 vpflDX6MkZNnYntFIa/YdIaGH3hYOYiPWDgBdhhCR1/By4Uk1aEVLt5EnPb6qRVuPbYN
 TY1034+ye71zXKUaG/giurLjwKf8nPuLIRd23Ddtn6ukmlT/YwpXrSFNkIu+h043zXqa
 OrKOaLCZE75WS0Aljj33PCjXbLVerSdHOqkT/qzY4kQDCibQnkrkaqeibY1N5ueE4/L5
 f6VO5JwclJeQtU9DeGHWNQ5ZR9VR00wGfjcDrbWV7mSNbP9oV64E4loR0JJ1KcNoiAZe
 TROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758538519; x=1759143319;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KO5sJeGqUItfo6WaWMQB5R3qCIcPhuGFwNEB/y7ohaA=;
 b=AMQgad5n3IscFCBMg9Czl0Oj9Agsn6fe7Sib0lSm71CQgKQS0szsslVCya7VBHUXiF
 JPQmdDcaA/OL2Xy1GihrG04QjBmHvZZ7L21djZuFCYmcPQ6vEw5R9emKdOirkqUAT76R
 xc3vRZtGHyRuUsUnwV8ENNzPSRZowlvEuN8ad6zTzmfYS1OsbVVgCrxsoXUqmY2IX3qb
 t6t4UOGyjRD8mVUpTdtCeAWmNABG1QAzYmSsZS5wDZ+HPqRTVx0nMKa3MI53IZIZheAx
 6DWPJ7BwWIF+tG7v1CtxVKAusft8tz7xnsEDKzNeCGgwc6kLVdJY3eUcXdeHXa69QsYU
 15uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs7GD2RS5MYP6W5BU/oQ0MLa/OPeFAwvX5MKPigB/gfln6+JCrTWQ0AMVw8P2zgFl4hHk=@lists.linux.it
X-Gm-Message-State: AOJu0YyWnjnGhB10HjdMJh9IMhqq6uqsxqk9Ratbu6ryFMfah+Joa0Ar
 ImY+m7WUxf5LybuG0qFyLNhMv2HC0OAB3diEb7mA21HJQu24Z/lb2CJMtvkKW4wE+58=
X-Gm-Gg: ASbGncuel2CxxLK7+ZwhVLOEjzGW9fk67Jr9Tlk96OjaGg5H57970nF+0B/n0kvQN0H
 yQWOhMn1O4y8dWk9ET7F97po0rIMKKS4SMuv5X5f2OZlzDgP3iyZC2qO/3zpNHgxJClYTSU0BNm
 l0ZLt3OhneSVSlPinv3iQOg22Md4EHEtpP/ReYL3H2ATCUDO6oHFDhXYpVp3ir8axsVRgWKz1Jq
 OhYReN101DsfH9gPfr1dypkKAw8ak1gNJdXZ7mWE0CGOKX4yWK1UfsyAiR/2tdDDEc515ezcY6R
 RKz+oq/FFANr6ghBeXM3F1g+shdsoLMVfEOSZ88JRM48PziPItBh3mtUHtgoBJr/IXKr9sCanqm
 ABGJ4/prjAjOAOtspauf5
X-Google-Smtp-Source: AGHT+IEJeXKwKgyfQDrq+BHx6/Xv/aOiAh9yrK4ZSdubv65RuMeU4ASCJsJX0uZKmWdWrdYNL+uxSw==
X-Received: by 2002:a05:6000:2010:b0:3e8:71ad:de53 with SMTP id
 ffacd0b85a97d-3ee8808506dmr10894321f8f.59.1758538519002; 
 Mon, 22 Sep 2025 03:55:19 -0700 (PDT)
Received: from localhost ([177.94.120.255]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54a9928f32fsm1067446e0c.6.2025.09.22.03.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 03:55:18 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 22 Sep 2025 07:55:12 -0300
Message-Id: <DCZ9VJYAFDE1.1JPCOR7SIPLR5@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, <ltp@lists.linux.it>
X-Mailer: aerc 0.21.0-0-g5549850facc2-dirty
References: <20250922-kirk_2-3-v1-1-af3fc729bbdf@suse.com>
In-Reply-To: <20250922-kirk_2-3-v1-1-af3fc729bbdf@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kirk: upgrade to v2.3
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIFNlcCAyMiwgMjAyNSBhdCA3OjM5IEFNIC0wMywgQW5kcmVhIENlcnZlc2F0byB3cm90
ZToKPiBGcm9tOiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+
Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNl
LmNvbT4KPiAtLS0KPiAgdG9vbHMva2lyayB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdG9vbHMva2lyayBiL3Rv
b2xzL2tpcmsKPiBpbmRleCAyMGIxODcwYjk2NGM5YjhiODNhYTBhOWNjODYwYTViYmQxNDY1NTlj
Li4yYjVkMGJlN2YwY2RkZmMwNWQ5YzYwNjY1NjIxOWM3YTAzMjY1MTJjIDE2MDAwMAo+IC0tLSBh
L3Rvb2xzL2tpcmsKPiArKysgYi90b29scy9raXJrCj4gQEAgLTEgKzEgQEAKPiAtU3VicHJvamVj
dCBjb21taXQgMjBiMTg3MGI5NjRjOWI4YjgzYWEwYTljYzg2MGE1YmJkMTQ2NTU5Ywo+ICtTdWJw
cm9qZWN0IGNvbW1pdCAyYjVkMGJlN2YwY2RkZmMwNWQ5YzYwNjY1NjIxOWM3YTAzMjY1MTJjCgpS
ZXZpZXdlZC1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCj4KPiAtLS0K
PiBiYXNlLWNvbW1pdDogMmYyMDhjMDBjZmM0YTFkN2Q1ZDk1N2FjMmI4NjZlMTI0ODYyM2FhNgo+
IGNoYW5nZS1pZDogMjAyNTA5MjIta2lya18yLTMtMzFkNWVmYzgwMTdhCj4KPiBCZXN0IHJlZ2Fy
ZHMsCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
