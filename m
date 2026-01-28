Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A827AD25B44
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769599715; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ww8zZKbv9JJOHvGgEm7vaq8KKa1nr9aMuPnCTHV/KsM=;
 b=ETbMFfEFEO8RIuZ4PptUKldkWkLlzaOKFdiyoZ6P6R5m0aXNgKh/sGk9Z1A110W3pgNJ9
 ZJX2/NOS7O5iFzhB2+nywngTgEgNbJ/euRps8V4x0pZBWNMq/PXxUA7uPhwvsZKS6iCA2f/
 K/xEs89cCiBj5Dnglkl9Z6DLbjHUSak=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46FDE3CB0D3
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 12:28:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42FEC3CAF61
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 12:28:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D558D1000A9B
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 12:28:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769599687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xaZrP7BljcmnfC6mB+gSIsWNR3zDH7L9p43qopj/Tlg=;
 b=QVqEgEVsajytGS+z+M+B2tFY4OPJ8f2g8jXqztMzBqnS4n6qo7M2hSNfw9VjRCObjPAoVy
 psMoPhvIMLaYGJ8oDSudeneecFKfiIemHZc8S0OQQpXlbrNuJTQ/4mXiRMeJv3upSPX1nB
 GERaL+UjvineP1xp8VXxI/irHAxIL38=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Cev1bg7nOlqwSggIgkcMQA-1; Wed, 28 Jan 2026 06:28:05 -0500
X-MC-Unique: Cev1bg7nOlqwSggIgkcMQA-1
X-Mimecast-MFC-AGG-ID: Cev1bg7nOlqwSggIgkcMQA_1769599684
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b7a28264c1so650631eec.0
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 03:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769599684; x=1770204484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaZrP7BljcmnfC6mB+gSIsWNR3zDH7L9p43qopj/Tlg=;
 b=JVLqpiiXpmPRVEqQc7yImemvZ038RBntFpbmvN4d8GK31Plw5avh6Inji1Hb0C6Gwl
 buU+7xC3CBo1e5LIYZu1kCc4cMOBIkZpBjAr8U+Eivd8yx1ks+D7giKl+kG9lSjYR++n
 GP2WKP0e4eCLzmVBDjWnU3/971AE91xXBXuSb9071Ho1ZZCuEWgOEfjbwkbbl0I2GlbD
 o1XFruTYfgWnRqj54oBpU2Ge338Suot7yuLK4gbeobzTDlBX2oHcsJYhFRXHra05x9gT
 ykT5N39FV4mJvp9jg5+sy0zTu1R7vHnTTQ0M98fGumWR5eqq4FkOCJ7+iyn/OObkXoxR
 c80Q==
X-Gm-Message-State: AOJu0Yzf8S/Q0cLnZreH/gz7jdJabizH2WrArs68OZFtn8oCNqoUyIv5
 d+M4SbvJK4wao1tCY2KD8Kw20DUmtVqotOMMOKGNVOzwUrbwwXcinL/xD4onWT/6PTKghfzSCyq
 q8+Juusr/zM/ygG2SmDDLPRQn1kesBCwtayYh8f/TqBPJ7fC1pNzYewD0+X0t3WxVfWLxBQWCnT
 quEsbO/2WwfPIA5LqsW+fyl5IzmDU=
X-Gm-Gg: AZuq6aIzuMr8d03RI91JV1iy/hALQu5ITtoXYwEu39tel6y482ZJyo7sTvIEtCj5isN
 egLWWcD9goypnK6GznrSMZK6MR/TCUxw04Z+3MEVoD4gFo9qMet6sbX4FLJP92xoLTROtxx/qy4
 6HSLRYuQ6Knm2+2W4VVeBXFHSSgINvI/bRfcr2dwrmpjcI+rsStlRZ1aHvbt+455TPHjY=
X-Received: by 2002:a05:7300:fd05:b0:2a4:65b5:9868 with SMTP id
 5a478bee46e88-2b78da689c2mr3233757eec.38.1769599683301; 
 Wed, 28 Jan 2026 03:28:03 -0800 (PST)
X-Received: by 2002:a05:7300:fd05:b0:2a4:65b5:9868 with SMTP id
 5a478bee46e88-2b78da689c2mr3233742eec.38.1769599682523; Wed, 28 Jan 2026
 03:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20260128-kirk_v3-2-1-v1-1-9364f4bf919c@suse.com>
In-Reply-To: <20260128-kirk_v3-2-1-v1-1-9364f4bf919c@suse.com>
Date: Wed, 28 Jan 2026 19:27:50 +0800
X-Gm-Features: AZwV_QjUzK9x6HEfGR1HVbwhlrzsbUfaiNmF5EmvDjZZcCLkM8PSZpBTbFAmJRU
Message-ID: <CAEemH2c7WhKRntOZpZ4jPe43wG9NiQYz65CtcB1uo+ChejapAQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CA1l3Ztk_0O-Gbclikj8Jk62JEOXbWKGq5DLdvCmuDg_1769599684
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] kirk: Update to v3.2.1
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gMjgsIDIwMjYgYXQgNjo0OeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVz
dC1wcm9qZWN0L2tpcmsvcmVsZWFzZXMvdGFnL3YzLjIuMQo+ICogbHRwOiBjb3JyZWN0bHkgZmV0
Y2ggTFRQUk9PVCBieSBAYWNlcnYgaW4gIzg4Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2Vy
dmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2Fu
ZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
