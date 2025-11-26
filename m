Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA24D10384
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764143129; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gmyWXc/Aq5C/kYo1AWB/78W+w5VpyWmoWZKenhwfDUg=;
 b=pdSo03uPu4E3e5pEdBz1cmQuy5+PnO3H5Sc5F9zxx0ABk1JCKTQ5NyKsO/Emnh05nbcJ1
 HQLvf2cLwvgJY4amRJy8/0NFEnSkVdrKr2WiKah6l1mwJRVQyHJoq580V82gJV6nPHkshLe
 SAwvDI/D+FwQf+/ZKTTPVFZ4tVdM4nQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 602B93CDC06
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 08:45:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 508793C0433
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 08:45:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 77FA6600959
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 08:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764143105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjYQ/NZHDeO7aojD7oalgSZF7MruEFiZ7Xg0fibeXUI=;
 b=OfaYGpSeXHw4QJkDlcwRPPvWOZZaTecVcb4tw2nRHQnqPEhXbhFgv7FNm/F9OUZgWDnIIk
 kG3TGhwRqc1LPRWLS9STG06nflE8IOrDMjYkBl9DQfhwsoIesUYcbTsxoEyst4g1DGc25G
 su9nqv606roqXNPYonCzmroiZEBn12A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-xefyqkG4M1e-crMSAAEbCw-1; Wed, 26 Nov 2025 02:45:02 -0500
X-MC-Unique: xefyqkG4M1e-crMSAAEbCw-1
X-Mimecast-MFC-AGG-ID: xefyqkG4M1e-crMSAAEbCw_1764143101
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b2fb13b79so3809202f8f.3
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 23:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143101; x=1764747901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qjYQ/NZHDeO7aojD7oalgSZF7MruEFiZ7Xg0fibeXUI=;
 b=tnYtwqIOQJ1PzavI7pKjjmqUIo4dSZtRU4ypgfv/lVvJ+a//aeckmzqDkunjYprXeB
 zmigxaAumYPEkpIuQ4w6HhwpF1uSeetEKUaRuSrqrNB9CTVlSbI7GSHTX+X4QkPghjBp
 AMoJhQLTGiOX2fv6Q7dpGVODhu4NJ6HktRR0mNMEJFKa9kNJUM+miG566Gidz0WJ8vhe
 S9EWl71fIzA1B2Vut8Ondh1Jfc5+RemJ9Dp525wOOY/FqhVssDZBXuXk4ahSlBp8ZOtM
 7f+AsYiWcTPgNJFe2SaYNePP3rICNCuZ+px4wAwMmhl/xLTBEBJAT/JImINkfa3bccVe
 4cXA==
X-Gm-Message-State: AOJu0YxiAn70WW8+v1ZaMRvlA+/JewPXDKCR7gP4K5taKJC3FxGNHizt
 H20Ve08/t6ughU0loumvhP1EDPv793vHGitLuxLHMASRFbtVqaXvuC12yHWZp9FIt+YJuUDQLfm
 N5WMzGkq9eVmeTFn5KujKXobzXMBGFegSf1m8s9eTXeSwEiHPERB+q2OHvNzEWiztEKaKPL51y2
 eIHCoRnPkyWbmdINg4jeRj/PpRg88=
X-Gm-Gg: ASbGncvCMhKSPG1+U6D75jsnxdoshzKslg9uJR7cNIilaZZ79DclErqJFphlExqV5/H
 s7crzCqHTuDxiDpJrtsbBv8OgLsCu9BZYhC2fs3D0HC8fayX0EXY+M1Sh+aSY7uEaUmqmYUrABB
 965gL+5lMBYP5C32zeID9GDWnGpCFZ65v6DdPDJy+Q/QdaPVmYv4Q6kaDHtxfrzjoC
X-Received: by 2002:a05:6000:1252:b0:42b:47da:c318 with SMTP id
 ffacd0b85a97d-42cc1d19514mr15541640f8f.52.1764143101055; 
 Tue, 25 Nov 2025 23:45:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFplGIj5HpjGTA/djuxS/VzkZ2R/nS0WDcW13rigNFF31O0xyGihNhlZc4EpsxKp+D1sCrJpgBay4uxv3UXGqE=
X-Received: by 2002:a05:6000:1252:b0:42b:47da:c318 with SMTP id
 ffacd0b85a97d-42cc1d19514mr15541622f8f.52.1764143100672; Tue, 25 Nov 2025
 23:45:00 -0800 (PST)
MIME-Version: 1.0
References: <20251124131335.5009-1-chrubis@suse.cz>
In-Reply-To: <20251124131335.5009-1-chrubis@suse.cz>
Date: Wed, 26 Nov 2025 08:44:44 +0100
X-Gm-Features: AWmQ_bnvVf2v2CQcmNTm6bptUjxUIywmS68C_hK9-QVJrMWMCGiWt9kKIFtr-6c
Message-ID: <CAASaF6y7zNZaow_-KhA5yF7PiQLWKJyUmtAFrCnTVBY6SWm3EA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8MmkDYKRAgO8smcJsf3NiW-DZUSC413g4eOjjrpCByo_1764143101
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/readahead02: Wait for the readahead()
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBOb3YgMjQsIDIwMjUgYXQgMjoxM+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IFRoZSB0ZXN0IGRpZCByZXF1ZXN0IHJlYWRhaGVhZCBvbiBhIGZp
bGUgYW5kIHRoZW4gaW1tZWRpYXRlbGx5IHRyaWVkIHRvCj4gYWNjZXNzIHRoZSBkYXRhIGFuZCBt
ZWFzdXJlIGlmIHJlYWRhaGVhZCBzYXZlZCBJL08gb3Igbm90LiBUaGUgcHJvYmxlbQo+IGlzIHRo
YXQgd2UgbmVlZCB0byB3YWl0IGEgYml0IGZvciB0aGUgcmVhZGFoZWFkIHRvIGhhcHBlbiwgZXNw
ZWNpYWxseSBvbgo+IGhhcmR3YXJlIHdpdGggc2xvd2VyIEkvTyBzcGVlZHMuIFNvIHRoZSB0ZXN0
IG5vdyB3YWl0cyBhIGJpdCBmb3IgdGhlCj4gcmVhZGFoZWFkIHRvIHN0YXJ0IGFuZCB0aGUgbG9v
cHMgZm9yIGEgd2hpbGUsIHdpdGggYSBzaG9ydCB1c2xlZXBzLAo+IHVudGlsIHJldGlyZXMgYXJl
IHJlYWNoZWQgb3IgdW50aWwgcGFnZSBjYWNoZSBzdG9wcyB0byBncm93Lgo+Cj4gU2lnbmVkLW9m
Zi1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+CgpBY2tlZC1ieTogSmFuIFN0YW5j
ZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
