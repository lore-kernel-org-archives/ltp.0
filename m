Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E082C36017
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 07:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743407668; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=B7+E0KyZoQ+AttcVLDPnforsoKz44NSeySZbbrx74sI=;
 b=oKtvD+qpnNImFM2eyRgFAP5RXXXBVQR5B8nuEHcX8lwQfijmg5ASiOrUkgA0pGhIP7KvB
 T5OFBnwJaktxDIkWAJyJdwssWVdnQxOVe4BfWb/FBbUNbdjd49TPm2y+2mKyye30IshXn7E
 wYN2uLr1Fs6m3pZqmxHmxvoxGwo+RgA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 877FE3CA846
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 09:54:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B75C73C199A
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 09:54:06 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 190981A01943
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 09:54:05 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3965c995151so2202167f8f.1
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 00:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743407645; x=1744012445; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QzrZVdoru+c/vz1rU+xaHK/nJ3aUzvcDp/f1rEYdEvU=;
 b=ZF0tT5YTHLsfown9slsGzIEkM935LXLH/Ydc0EagflruKj3fhJgRNCmtIBAySBFBZp
 1FcvNh5NDRh4H6O83VrDrOQL8ia94p0m/a2q+keSk3FiOWSQcKRHXROXxfw8H8j9HUa6
 5INQTd6LvEEgdI+Ycz4l37xiCrLUX6Ea5mQy8fxDSsRkI2TT0aBvt95sZT23xEn8FPCX
 uBGFJkTcISWpnoVfBZiii+WdmhOjImey6Lv+bXPke62IcMxClmylnKN1f9e4yHb+fkx3
 A6O6WErfKy/TG770qFtCIQi+PARFV+LVlw/OFxYt6HBp0L/kZ/WcDoGRoK6ZE79aIzKC
 2D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743407645; x=1744012445;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QzrZVdoru+c/vz1rU+xaHK/nJ3aUzvcDp/f1rEYdEvU=;
 b=gryE9looQ17j3FcUqq/TaGCTiWeHGdTvBuQMDcuT0Bk1ZMKM0tybDLEYyl7EWGOIMG
 Wvlytkwn8Lnt/JZ3vsIKAwtTkPDG0L8bj5HEp1yqJAZhNSmXp+gkhQ1kEeSBTOWBHJ9Y
 ZojfVdwyD+xhtoqlVW9m6Zr5N8Ozil2TH+LI3LRRuGI+//pa9hNFWbJ3lsV8zVPGxeS3
 eg+V/izEPC4Db1gCi+HDEGuzKV7lI1bIGmroHC5j7noTFEHsvymnrpJv0pZyAgA/7TN5
 WRSOrPJHJvT0EdnGhiHiBrXchE1zo6ovwls5crdDtvRBvo7Jn6IaKTvb7icTOwuiYKiN
 OEiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv7ijyt9sxpFCVJXWBDWNu1xOKAJs12bWS0InMJvBpq3i6VQb7BORTn1vHYHr5tCO7vQ4=@lists.linux.it
X-Gm-Message-State: AOJu0YxRJ+zWZ3qqGzoZBBpITF/YOS2FZgSUNpSbsTTr7nWUlmO5qA9u
 4AbzEpg2xnEAGilXs6QoCQSnFkfCl7zHcu0UmtCJUS/r5QkywXb/Eb9AWX1LcRDu9cCCBFI+mKe
 ptF4sjg==
X-Gm-Gg: ASbGncvoU6oXcSvk2enWfPJZkJVGowlTrzURhynFV4lHGgWjKAyodKyEME83PGSNfOY
 2t2VzDrXkMf4m6Rp3QBZNfMC3C6t2+QT5JlD6+1ma2AIwhOjUNvQ1r+YMBUHDDL1iGxEbKjwFb2
 tJCdMwMaGx5Gj+zK2EJWvfKwys9mVi3aBs5c6OkTKwW44z9AtPz7Aglx0WjX2BpWE5OmXpKe55h
 S4lAWFik8Y2okeMzI5tSvhtgEyhPD0Gpqac8rq+0LJvpj56t6MsuD7dRQTH7DEf6Xc0Zt6nXcIP
 CloJPHAag1wlowJJ/Hyp1T6mi5xtLcRptEMtSTg9OXUc3RXbukPyXY/ShM/dQh+A1WYlTevphEA
 KiTAYx916LeZpRjxV8ehSr1Rks6g=
X-Google-Smtp-Source: AGHT+IETikedZZZEMXz2EZ1PwUO9OKWk6xgJ3+CSvfFbyywZdkcApXPKsv9BZdOlvhot3MExazVVZg==
X-Received: by 2002:a05:6000:18a8:b0:399:6d53:68d9 with SMTP id
 ffacd0b85a97d-39c12118aedmr6737317f8f.38.1743407645354; 
 Mon, 31 Mar 2025 00:54:05 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663564sm10712646f8f.32.2025.03.31.00.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 00:54:05 -0700 (PDT)
Message-ID: <e6694935-a54f-4db9-87a9-a99520e7d011@suse.com>
Date: Mon, 31 Mar 2025 09:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rbm@suse.com, Linux Test Project <ltp@lists.linux.it>
References: <20250328-conversions-modify_ldt-v4-0-a5ee7b8d82aa@suse.com>
 <20250328-conversions-modify_ldt-v4-1-a5ee7b8d82aa@suse.com>
 <58a6f06d-9d7a-4067-b401-6aa98f4f8ed2@suse.com>
Content-Language: en-US
In-Reply-To: <58a6f06d-9d7a-4067-b401-6aa98f4f8ed2@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMy8zMS8yNSAwOTowNiwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBjdmUtMjAxNS0zMjkw
LmMgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+IGluZGV4IAo+IDYzZTVkOTJjOTFi
ODMwY2Q4MDY2YTZhNmMzMjk0NjFiNzI3MzFmMzIuLmQxYmQxZDk0MTUzNTlkMjU2OGM2Njk0ZjE1
ZmZlOGFmZTJhMWY2OTAgCj4gMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0z
MjkwLmMKPiArKysgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYyAKClRoZXJlJ3MgYWxz
byBhIGNvbXBpbGUgd2FybmluZyBpbiB0aGlzIGZpbGUgd2hpY2ggbmVlZHMgdG8gYmUgZml4ZWQ6
CgpjdmUtMjAxNS0zMjkwLmM6MjAxOjI4OiB3YXJuaW5nOiBwYXNzaW5nIGFyZ3VtZW50IDQgb2Yg
4oCYc2FmZV9tb2RpZnlfbGR04oCZIApkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFsaWZpZXIgZnJv
bSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQogwqAgMjAxIHzC
oMKgwqDCoMKgwqDCoMKgIFNBRkVfTU9ESUZZX0xEVCgxLCAmZGF0YV9kZXNjLCBzaXplb2YoZGF0
YV9kZXNjKSk7Ci4uLy4uL2luY2x1ZGUvbGFwaS9sZHQuaDozNjo1NDogbm90ZTogaW4gZGVmaW5p
dGlvbiBvZiBtYWNybyAK4oCYU0FGRV9NT0RJRllfTERU4oCZCiDCoMKgIDM2IHzCoMKgwqDCoMKg
wqDCoMKgIHNhZmVfbW9kaWZ5X2xkdChfX0ZJTEVfXywgX19MSU5FX18sIChmdW5jKSwgKHB0ciks
IAooYnl0ZWNvdW50KSkKIMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+Ci4uLy4uL2luY2x1ZGUvbGFwaS9sZHQuaDoyMzozNDog
bm90ZTogZXhwZWN0ZWQg4oCYdm9pZCAq4oCZIGJ1dCBhcmd1bWVudCBpcyAKb2YgdHlwZSDigJhj
b25zdCBzdHJ1Y3QgdXNlcl9kZXNjICrigJkKIMKgwqAgMjMgfMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICpwdHIsIHVuc2lnbmVkIGxv
bmcgYnl0ZWNvdW50KQogwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH5+fn5+fl5+fgoKQW5kcmVhCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
