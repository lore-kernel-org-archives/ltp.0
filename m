Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945BCC0219D
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 12:41:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10DBF3C9A9B
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 13:41:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2074F3C1B79;
 Thu, 13 Feb 2025 13:41:17 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DDA9F141A27C;
 Thu, 13 Feb 2025 13:41:13 +0100 (CET)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f9f6a2fa8dso1252257a91.1; 
 Thu, 13 Feb 2025 04:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739450472; x=1740055272;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:dkim-signature:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KyxeFu5Q2vTWJeUTf/1csa4HoWgbSoJS5V+amE1MxMI=;
 b=GcWSvT/DiLS9EkPgObP8i3qBj49RfdXHusZ943DkodV0ZyeVKWcSbOupqfUyaHo4zi
 a7iyKIfS7669pj+T3olXFhW2xVkhjJcvpJFuE+pdm2hbtylxZO4WmIveJIHTYFuO24e6
 MCLnK+btqoO2O0YMcuf87u/CffOKlx8C9rWbf/RgzuiHbrcjJyb57WOepBC5Lznw4GxB
 XaMzuspFmFudOJ6qClB1u9056qIq8GrKAA/qpi24mtIT7XD6t9Wt0zQpQWlHt2KyQYru
 /EJZo/JJEWdtJ5OEWuzFD2+j5C/cKyjRUddzMy0zF78CmGODo2hQ3uDmTMgiJ7LEwKBO
 nqFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQDttNx4sdwfebNaI9p7tDod/EYks7ELpLi13xc+EXNzJIa2jCBX1nMCVyiqmsu5Xclbk=@lists.linux.it
X-Gm-Message-State: AOJu0YxzDmiU1jQrbKus5c5JlhkxNF+qtmaEywcTmf5S6tg86h12uBnm
 j+3fuR4BiGVtBZJMcbsDd/t6sH8JOuvXkCDGgTeiCHGhHAzsV5NKEBQcNjvk
X-Gm-Gg: ASbGnctWaWOGP+R7gGmtXfMiLP1XjdTIcxRmhiLdr+cja0dQmqbS9OLvTIATsa8Ys/E
 0oH8VTBvjsOeeqQW6uYTBEbVCa7BxM4ikxkSEICMn1qvq8xdcPFrstNvZK47fqrRArnrVVZjS5u
 si9nc8sNsaK9C2+Uj8dGMud/5B07qDDri3wcFMCkgKMzQdTGalzDnFvGBKvE/VwkDmWeYFOzZZC
 0AJC6KCtCoy1AucpwW7LCgjb6coWDhzPOLst4jwk6vQ9YFQc0pCdARVKlubD/knrkZinOakbyd6
 MVdSJME6gA==
X-Google-Smtp-Source: AGHT+IECFJWuouBYb/g6NfLQ8NhrIDo2G2URZj6U29H6yy881eXHGKauQI+xee8ggcvf+4PjgXfdHQ==
X-Received: by 2002:a17:90a:e185:b0:2ee:8430:b831 with SMTP id
 98e67ed59e1d1-2fbf5bc0249mr11838602a91.2.1739450471772; 
 Thu, 13 Feb 2025 04:41:11 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f48eesm3193595a91.22.2025.02.13.04.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 04:41:11 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739450469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KyxeFu5Q2vTWJeUTf/1csa4HoWgbSoJS5V+amE1MxMI=;
 b=hycf0MrY+rsymDLCs0VoUalpAED/MRSGWYviCaeX0OOGEEtwzf5x4MGWMgWevXJg4xmBkZ
 4smWZHUSyokrqdjcIh0UbToOBGGT1DJqrw/6HHJPIczWhuXb7fgFlx+/Ipz8akExD33T6P
 q1ASMdRDFvsP3KTZ6E/J+lYJyUSJkG38Yp47wIFyFNWVG04T3T8gMJABSWDjgDwpksYbyH
 mco+Dupn28VfoRc5zhf0KuPPGZl0IdcD4rsTayVInIY08wmg0fsdZC9mR8NUM/gY0RijdS
 vEF8csR0adGQygQUb2ncImN2y67xZ5JW6t+/5vj+14fi9L7mD0HbNINB7OWJfw==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Mime-Version: 1.0
Date: Thu, 13 Feb 2025 09:41:05 -0300
Message-Id: <D7RBQ8EVJ237.1KWPQN7GTU9YG@marliere.net>
To: "Cyril Hrubis" <chrubis@suse.cz>, <ltp@lists.linux.it>
References: <20250212131618.6810-1-chrubis@suse.cz>
In-Reply-To: <20250212131618.6810-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Add shell test metadata parser
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8hCgpPbiBXZWQgRmViIDEyLCAyMDI1IGF0IDEwOjE2IEFNIC0wMywgQ3lyaWwgSHJ1Ymlz
IHdyb3RlOgo+IEFzIHByb21pc2VkIHRoaXMgYWRkcyBtZXRhZGF0YSBwYXJzZXIgZm9yIHRoZSBz
aGVsbCB0ZXN0Y2FzZXMuIEluIHRoZQo+IGVuZCBJIHdyb3RlIGl0IGluIGFib3V0IDEwMCBsaW5l
cyBvZiBDIGJlY2F1c2UgdGhlIGVrdml2YWxlbnQgYXdrIHNjcmlwdAo+IHdvdWxkIGJlIHRvbyBj
b21wbGljYXRlZC4KPgo+IEN5cmlsIEhydWJpcyAoMik6Cj4gICBtZXRhcGFyc2U6IEFkZCBzaGVs
bCB0ZXN0IHBhcnNlcgo+ICAgbWV0YXBhcnNlOiBkYXRhX3N0b3JhZ2U6IEZpeCB3YXJuaW5nCj4K
PiAgbWV0YWRhdGEvLmdpdGlnbm9yZSAgICAgfCAgIDEgKwo+ICBtZXRhZGF0YS9NYWtlZmlsZSAg
ICAgICB8ICAgNCArLQo+ICBtZXRhZGF0YS9kYXRhX3N0b3JhZ2UuaCB8ICAgMiArLQo+ICBtZXRh
ZGF0YS9tZXRhcGFyc2Utc2guYyB8IDEyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCj4gIG1ldGFkYXRhL3BhcnNlLnNoICAgICAgIHwgIDEzICsrKysKPiAgNSBmaWxl
cyBjaGFuZ2VkLCAxNDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IG1ldGFkYXRhL21ldGFwYXJzZS1zaC5jCgpGb3IgdGhlIHNlcmllczoKClJldmll
d2VkLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmljYXJkb0BtYXJsaWVyZS5uZXQ+ClRlc3Rl
ZC1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJpY2FyZG9AbWFybGllcmUubmV0PgoKU28sIGN1
cnJlbnRseSB0aGVyZSdzIG9ubHkgdGVzdGNhc2VzL2tlcm5lbC9tZW0vdm1hL3ZtYTA1LnNoIGFu
ZCB0aGUKZ29hbCBpcyB0byBhZGQgbWV0YWRhdGEgdG8gYWxsICouc2ggdGVzdHMsIGNvcnJlY3Q/
CgpUaGFua3MsCi0JUmljYXJkby4KCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
