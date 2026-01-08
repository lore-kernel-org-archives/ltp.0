Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC747D185F1
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767879234; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bJPeS4tTqCoNSowHcY9HbJ9lCIWpYZOP/3TaHoqY4wE=;
 b=GL6P+Mj0PAKC5elsTD5LoRKlCu3qYTRnMY9oiatmoPm2ilmAk2KHZZIoXHoQoE09nwrGP
 i4HN8iw3IRdWXGUNbnujqNkBYoxzG0p8CfppG0oTdNobjPtGXB+/bY3Q7+VX4KApgIw49me
 caFYyXwqH8dehf0iYXUa/TPXscFR7gg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DFED3C54E7
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 14:33:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 548A23C54E7
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 14:33:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ADD2E200967
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 14:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767879208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dRy3648pU/PY27QE3JMqkwan+vCifA4re+zmkBnoUyE=;
 b=XLN7yEXPQbCEvWkGJVMxyqlwG/4IDlWjptLxNC9tLQPPP3hslTM68dDtCBGw8ii2S/OQiG
 grrFimN12xOBjstaaOsS5hxf8plqhWvwunhgLWmK8KkSF/sV747WczDf8mPKZx7OMjYhxS
 DX7rvrbPzvt8ZTPSpfopbUCGPC0Wv8A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-vwk0W_-OOXCcjpwCEKGrKA-1; Thu, 08 Jan 2026 08:33:25 -0500
X-MC-Unique: vwk0W_-OOXCcjpwCEKGrKA-1
X-Mimecast-MFC-AGG-ID: vwk0W_-OOXCcjpwCEKGrKA_1767879205
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a34f64f5eso64417496d6.1
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 05:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767879205; x=1768484005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRy3648pU/PY27QE3JMqkwan+vCifA4re+zmkBnoUyE=;
 b=YiP3MZLmH5nQefEKqo2+axyx4+r8vC2rpKb7l18osWx7b/wZnKKDduY6f8CXsXHD9u
 0B3XdmR1r9qhXHczZe71HWUwoQ8uzYKW5y8ikkkCHYep+hX6PQGzVWGOSFlvM36jKGrE
 JjvCDdupPes8EzO+c/2tzED/NXYTLnIqmlioycNrw1jlOA0hkbOUUQ7BYd8fON8XqA8D
 2mAzrMxXCaDmPXFY9d8GAC8SFHIYLJ+ixhaRd/x4Wl0zkNwcKyA0tb/oNGpsf8FrUznV
 OIyfGa44NN7INnGS/DfEfQXO2ez8ZRR+EQv/WewlaQay9KZ7xHgtzcG8PCBaZHOWsz7y
 jcWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPWr/0gyoR3emjVOL2pGZ+WeDdvRqXQyvsbFe0OgsRpqZO1UOdcyvY8OBswkTYHJTWKUU=@lists.linux.it
X-Gm-Message-State: AOJu0Yy+OZIrCc1mm/CDHPZsUu5Hx/wBODsu9QkkLg6KksPKbsbCuYYa
 6Rpm8q/qcnMUlb6TJt4k11PXBbXPs2/GQ1g7rgM2VLrZQYFZdhupFP2xGA7DlOWr7wvHXDEBwQB
 Xxu3gU7bTTDNemdy81YomAPNzUu31GV0AUZbwtDLBP7yeoTuUgSjXK8yf8ZY69Ze+ao00iSGNM+
 C9DWiwB30qIH1IFMZUEWzeKjMgJw0=
X-Gm-Gg: AY/fxX4MtMSk72w9Jweh1k79r2Wry6ES8BFLqlBXGvqnPXFbDNbrE+x6xTaZHN9jFo6
 FfxDbOCy1saHfEE6r+me0TtEu4WVIbtpjcaYFOrLRnjQ+efcs5tGVXpz8v5ZEicJwm8sGjGz3Mq
 pdDYjdapcOtS0+o17x76R0no0FOuxgeK6sOuQ+kOtohez5ni7QtDkAt4w9cDs9PEdRGQ==
X-Received: by 2002:a05:6214:2dc9:b0:70f:b03d:2e85 with SMTP id
 6a1803df08f44-89083cd1f1amr89658526d6.24.1767879204574; 
 Thu, 08 Jan 2026 05:33:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYN4id9BP1urYk8T3NWLHJ/dFqV58yRNSkrMgYevny9i7YQ/76UU0WVMA/5y2pHysKqcl+18WPSn/+E0jHXYg=
X-Received: by 2002:a05:6214:2dc9:b0:70f:b03d:2e85 with SMTP id
 6a1803df08f44-89083cd1f1amr89658056d6.24.1767879204050; Thu, 08 Jan 2026
 05:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20251104193942.4080083-1-sbertram@redhat.com>
 <aQstFByWQ6Zkz6ZP@yuki.lan> <DFJ2JRL7LR8L.3P1WOI00EDDRI@suse.com>
In-Reply-To: <DFJ2JRL7LR8L.3P1WOI00EDDRI@suse.com>
Date: Thu, 8 Jan 2026 08:33:12 -0500
X-Gm-Features: AQt7F2ozuTjfy7xpV9RuaBzZaddy6ACZ3GDWHn5yAJFz6friQIZRYLWBXdAQvNo
Message-ID: <CAD_=S2=kAj-xhxs+qhY7VfRW13UPeP3vPjh6LzqQv8a+Z6OZTA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8lKpDTrMoaMxEYoyaU81SVgZwnSMsyVlKp8lykg_KlE_1767879205
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] Add config check for systems that do not
 support CONFIG_XFS_FS.
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

WWVzLCBwbGVhc2UhCnN0ZXBoZW4KSGUvSGlzL0hpbQoKCk9uIFRodSwgSmFuIDgsIDIwMjYgYXQg
MzozNuKAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cndy
b3RlOgoKPiBIaSEKPgo+IE9uIFdlZCBOb3YgNSwgMjAyNSBhdCAxMTo1NSBBTSBDRVQsIEN5cmls
IEhydWJpcyB3cm90ZToKPiA+IEhpIQo+ID4gVGhlcmUgd2FzIGEgYnVnIGluIHRoZSB0ZXN0IGxp
YnJhcnkgZmlsZXN5c3RlbSBhdmFpbGFiaWxpdHkgY2hlY2ssCj4gPiBzaG91bGQgaGF2ZSBiZWVu
IGZpeGVkIGJ5Ogo+ID4KPiA+IGNvbW1pdCA1ZTFlMGUyZDgxZTU2NGRmMDk1NDJiN2NhYTJhNjY5
MjhjMDVkZDNhCj4gPiBBdXRob3I6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+ID4g
RGF0ZTogICBNb24gT2N0IDI3IDE2OjA5OjI0IDIwMjUgKzAxMDAKPiA+Cj4gPiAgICAgbGliL3Rz
dF90ZXN0OiBGaXggRlMga2VybmVsIHN1cHBvcnRlZCBjaGVjawo+Cj4gU2hvdWxkIHdlIHJlamVj
dCB0aGUgcGF0Y2g/Cj4KPiAtLQo+IEFuZHJlYSBDZXJ2ZXNhdG8KPiBTVVNFIFFFIEF1dG9tYXRp
b24gRW5naW5lZXIgTGludXgKPiBhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCj4KPgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
