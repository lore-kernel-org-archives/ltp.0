Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8739CD44C41
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 12:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768481631; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lUL9iqDY2dIRDHonsMlTzWmLv1pvfXydZtCq9+hUVA8=;
 b=DydTiNS/kv6aCFuLM9XCl0PO22yJ2oZbjGqiNR5s1BArAqWoccz/72R0ETZY/RToeMkym
 xXJvPHCqh00flT8F80rrHOht6TG1mBbN5D5/ldM7fkxwEYIcmWGoFkjEwKp5C19tC0dry68
 MADieqG7QBFVQ6E4joNJRg3EDE4hF/4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E425E3C9E44
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 13:53:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1D143C2884
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 13:53:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2D2672002C3
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 13:53:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768481605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dc27IOgUBRKBXpfrTthsK/TVraWBtN3G2pptdoHl0f8=;
 b=fKR2u8kXf0HEJhrK5C/G20uohtsIOJTZC86oTEA6zYDUDKBn3eH2p1H4CFtaOsmzV4lyi/
 TdwK7wEtm+6M0vrcTDhSclcABniY8oCFV1fLnbO1ad41msatYqs98JqKdDZtFvEHTVugJ1
 KygHB613wu55qegH0Zd9pcqdGiOS6us=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-7F1ShGYbO--RwUVG5kly_Q-1; Thu, 15 Jan 2026 07:53:23 -0500
X-MC-Unique: 7F1ShGYbO--RwUVG5kly_Q-1
X-Mimecast-MFC-AGG-ID: 7F1ShGYbO--RwUVG5kly_Q_1768481603
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ae56205588so1279406eec.1
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 04:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768481601; x=1769086401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dc27IOgUBRKBXpfrTthsK/TVraWBtN3G2pptdoHl0f8=;
 b=kKiF0PGFGOuYtdlMpSNb4GgCvHoapg9RVBk/vJm39tZYIjOVqx10rR77qZyj7u36gG
 /v+U1aYGTXr7MvMK4hGqE/ujMnEw1tOKBM/JabKW0fJqz7/jZbBYKbuP0+7cyls7SJYS
 XS2FPAuM1bfVsaIm3XM9gfBqx9Rf1iE5Wz69dQeAwbTYaDS2iPxQ6CrgnGqDOWUPeOzi
 AGxsoJbBV84WC9aMgrPxwvhVvzYbIhwaThp8FkwPUEROMC0FhKj8wUlG5LW4dn0c0upN
 I2GKWIyRJpqommI6hPGTyCPEbz+icGHturUmF/1O8PMoPBCu1/qawLgYAmGLD7i38/rC
 gEQQ==
X-Gm-Message-State: AOJu0YzTezCYOvxNT0GRhaXiQdHP4zM0r9yrEzbl4iopkpvoZvevU7OI
 YYFsBm893iLHMs8tRdIdFIXrNIsHSth4Q6r0t0i4z7uBx6l6N+Bd9GMWyJACJhxpTP3jMJYvzgG
 e5zDandOJgQ56jvuUGXy+D4hn4xvKkc4GWvC5wn1Xp2f1tB3pD04Dr4yfz3Bi7MniUcNuL+aQPG
 QE8u92kPUDoyLWLsxQbyyj3klpGb12lLFE8KT1ZA==
X-Gm-Gg: AY/fxX5UnQOO9eNBAcqhZdrdNDWLmRRuwJqD9l7Dlr5t27qrF6mBkEMAR5M+67cCaB7
 rnfE/yJG32Ydq0lZN9lG3DMu/zhGiCi0EefPBAiGbHZ70D3YxY2KXV2jkYCcCNQAY1TgOIUW96M
 +LY8ETD6ud1tAkC8JIYDQ+n1TtJqT+IBIfrlmW33CzQ9Ym/g+wqjYlxqI9QDQUevEgA2E=
X-Received: by 2002:a05:7300:5728:b0:2a4:630b:c789 with SMTP id
 5a478bee46e88-2b48f5c5c59mr7633927eec.37.1768481601457; 
 Thu, 15 Jan 2026 04:53:21 -0800 (PST)
X-Received: by 2002:a05:7300:5728:b0:2a4:630b:c789 with SMTP id
 5a478bee46e88-2b48f5c5c59mr7633895eec.37.1768481600999; Thu, 15 Jan 2026
 04:53:20 -0800 (PST)
MIME-Version: 1.0
References: <aWjZX0fsrTJMqq49@yuki.lan>
In-Reply-To: <aWjZX0fsrTJMqq49@yuki.lan>
Date: Thu, 15 Jan 2026 20:53:09 +0800
X-Gm-Features: AZwV_QijfXUYJiXanws0P7wCbfjfm6JamkMQw80iyvuFGaj6Y1JPh3rtFn6ABG0
Message-ID: <CAEemH2f_56EZUi74x-K5a5Pe231qjU14NTsZjWt+=aTdAJcLkA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -pOIIDhZ4y-uxEjP9IDKe4sjirB62nwOsKOhPa8z8B4_1768481603
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Q3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiBJdCdzIGFib3V0IHdlIHN0
YXJ0IHRvIHByZXBhcmUgZm9yIHRoZSBKYW51YXJ5IHJlbGVhc2UuIFdlIGhhdmUgcm91Z2hseQo+
IGEgd2VlayBmb3IgZ2V0dGluZyBpbiBhbGwgcGF0Y2hlcyB0aGF0IHNob3VsZCBnbyBpbi4gU28g
aWYgdGhlcmUgaXMKPiBhbnl0aGluZyB0aGF0IHNob3VsZCBiZSByZXZpZXdlZCBwbGVhc2UgcG9p
bnQgaXQgb3V0IEFTQVAuCgpJIGhvcGUgdG8gcHJvbW90ZSB0aGUgc3RhbmRhcmRpemF0aW9uIG9m
IHRoZSBMVFAgQVBJIG5hbWVzcGFjZS4KQWZ0ZXIgc29tZSBkaXNjdXNzaW9uLCB3ZSBzdGlsbCBo
YXZlbid0IGZvdW5kIGEgc2F0aXNmYWN0b3J5IHByZWZpeC4KZS5nLgoKICB0c3RfOiBjb3JlIExU
UCBBUEkgKGxpYi8pCiAgZXRzdF86IG5vbuKAkWNvcmUgZXh0ZW5kZWQgbGlicmFyeSBpbiAobGli
cy8pCiAgb3RzdF86IGxlZ2FjeS9jb21wYXQgbGlicmFyeSAobm8gbmV3IGZlYXR1cmVzKQoKQnV0
IG5vdywgSSdtIGFsc28gY29uc2lkZXJpbmcgdXNpbmcgdHN0XyosIGVzdF8qLCBhbmQgb3N0Xyog
ZGlyZWN0bHkuCgpUaGF0IHdvdWxkIGdyZWF0IGlmIHdlIGNhbiBmaW5hbGl6ZSB0aGlzIGJlZm9y
ZSB0aGlzIHJlbGVhc2UuCgo+IEFzIGZvciBtZSBJJ20gZ29pbmcgdG8gKGhvcGVmdWxseSkgZmlu
YWxpemUgdGhlIGdyb3VuZCBydWxlcyBwYXRjaCBhbmQKPiBzZW5kIGFub3RoZXIgdmVyc2lvbiB0
b2RheS4KCkFuZCwgSSB3aWxsIHN0YXJ0IHRoZSBwcmUtcmVsZWFzZSB0ZXN0aW5nIChhZ2FpbnN0
IENlbnRPUykgc29vbi4KCgotLQpSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
