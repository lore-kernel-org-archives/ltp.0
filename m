Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8955DCCD1AB
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761292035; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xI8jMac4OYtwI7sykOBFxz19HMGZZwyta3KF9cXQnOs=;
 b=j09FIeKM5dzr3z4Cwl81fokLzyt3Cbw0QQQr2p+Wrb//rzFfQTihtXnOLfD4+jvCwyoGL
 mVank1GdO6YHcjMsOoOTCAW29cnjHOgeKR+mh8/d/MyHRA9+SuCGzHWXj/SZjVECwI1PIF5
 i0SQYsG3MDRYndGzjElKMbxttwqsGxg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F62C3CF298
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 09:47:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB83B3C702B
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 09:46:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D0FFC10007C4
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 09:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761292011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wNH4p5ioC26MUVo07azzm7qezot3XUmeYmXHqeyGgPM=;
 b=BpYPWXNJBDtV5J3odyU9jyUW2ZrhlqR0pzGA9EQ97zHq8V0j1HaMjVbWvT9iaykT5kfIbM
 mo4WnSagL8OcVPyr9S4Mm5M1GSJEoxGiutegeFuFnAnXEwLhpezun0Tw2kfazIH7KFc32e
 uvrC/ta/adH6mlAoqyNC267Ey2pRXEs=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-blomus5AMSWTBZrN-_s3dg-1; Fri, 24 Oct 2025 03:46:49 -0400
X-MC-Unique: blomus5AMSWTBZrN-_s3dg-1
X-Mimecast-MFC-AGG-ID: blomus5AMSWTBZrN-_s3dg_1761292008
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63dcbe3d18dso2284208d50.3
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 00:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761292008; x=1761896808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wNH4p5ioC26MUVo07azzm7qezot3XUmeYmXHqeyGgPM=;
 b=OEFgULbra9Mpn1OiBpFAOu222zTTmGZ8OU/QuVy4uwWmF9ktIs1EcHLSxEiGyMQtjN
 5DZzbnb6SVWJShiI6WYZe68cDsCyhqyN2AuVgia4Z4ROTgQ0muIEWrDeo05ke+d3diKV
 1mC0ZQxj7MDwOZ60cYZs5jHsPK7OUfTI9hlrrd05ERBxRMGk1O4/hwnyERF02PcWdIBz
 1toTIMdhpZ8Lt7FmtebjHLik5GnKvOYMXx+UMt8798D1HekjMzD5a5Kkz2wpiibm0dKL
 RI/ej8EyyZWyNNDn3Leovzuimt/YhroG61AG+CQFuW6C0yT5ympjNXXwFAcbb/7/BiEb
 aWkw==
X-Gm-Message-State: AOJu0YzfwM4p9JRyyWoTKBwkL7gGEee7XfltoHWoVsFebUPWptzXGLgs
 ikzAllSP8dPlueUFvregqT7lfgIpJXDtTjjBuvgi+Ac7DW1BnPGslyGPg/NkuwTYf/SpaCYsdGY
 OVPzlM1VLzPxKfazUIx39AhLZwoYcfGFk69Dv/uC+Bngu8iMlqnCSTvbjpPamnX8bj14G36zzBO
 f13NHuK1smR52Tob1yV3PNS7DKSwg=
X-Gm-Gg: ASbGncsfmKki4gfg4nltHscdE9iqrPVhGF5QrGOXvNmxwebr8WM93jRJSsi1tKHcpm/
 u70ro2ZjV2xpyYuIe9kAw30wP2/ThkCmw+gy/NcNR1VoyYUS80wou7YsA3fF5fHWYAT2nt384HC
 YDxWq5mJWOsLw7Ejpb6ERePdt96QiMCi+8O6okCKTgjbLp0qNqPlPXpNhl
X-Received: by 2002:a05:690e:12cb:b0:63e:3b29:f1e1 with SMTP id
 956f58d0204a3-63e3b29f5fdmr12048320d50.36.1761292008420; 
 Fri, 24 Oct 2025 00:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCF9//ag1DctcQo48imVZnv/rmtYSbKpA+a1TjGawNKLNAGyNFh6PwmPhLTrajmmzKYPIt5P+2axMogt3LpDw=
X-Received: by 2002:a05:690e:12cb:b0:63e:3b29:f1e1 with SMTP id
 956f58d0204a3-63e3b29f5fdmr12048314d50.36.1761292008018; Fri, 24 Oct 2025
 00:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250826044129.946421-1-chwen@redhat.com>
 <DDH4WAW0M111.1XZ3UJKV8QQTO@suse.com>
In-Reply-To: <DDH4WAW0M111.1XZ3UJKV8QQTO@suse.com>
Date: Fri, 24 Oct 2025 15:46:36 +0800
X-Gm-Features: AS18NWBRK7wuiT4RGYD2wJ_8wWlA94ZV6snmGz5yqVv70-ZqNETfUMbkwKAWIUg
Message-ID: <CAAA2g-2T2ex8nOc8XDCffuQOJU7pUxWNmR899LDPtcvZgqcVpA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZGciW8jr7AbxyCPLe0E90weeHFkxWK9fjbR8gKxhvSQ_1761292008
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v14] Add tls parameter and flag:CLONE_SETTLS cover
 for clone and clone3 syscall
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
From: Chunfu Wen via ltp <ltp@lists.linux.it>
Reply-To: Chunfu Wen <chwen@redhat.com>
Cc: ltp <ltp-bounces+andrea.cervesato=suse.com@lists.linux.it>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gQW5kcmVhLApUaGFuayB5b3UgZm9yIHJlYWNoaW5nIG91dCB0byBtZS4KSSBzdWJtaXR0
ZWQgYSBuZXcgcGF0Y2g6Cmh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDI1
LU9jdG9iZXIvMDQ1NDc4Lmh0bWwgdG8gZml4IGl0LgpQbGVhc2UgbGV0IG1lIGtub3cgd2hldGhl
ciBpdCBjYW4gd29yay4KCkJlc3QgcmVnYXJkcywKQ2h1bmZ1IFdlbgoKCk9uIE1vbiwgT2N0IDEz
LCAyMDI1IGF0IDY6NDnigK9QTSBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1
c2UuY29tPgp3cm90ZToKCj4gSGkhCj4KPiBDYW4geW91IHBsZWFzZSBjaGVjayB0aGUgQ0k/IFRo
ZSBwYXRjaC1zZXQgaXMgbm90IGNvbXBpbGluZyBpbiBib3RoCj4gb3BlbnN1c2UvYXJjaGl2ZTo0
Mi4yIGFuZCB1YnVudHU6YmlvbmljCj4KPgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0
LXByb2plY3QvbHRwL2FjdGlvbnMvcnVucy8xNjkzMjIwMjU0MS9qb2IvNDc5ODAxODI4MzkKPgo+
Cj4gLS0KPiBBbmRyZWEgQ2VydmVzYXRvCj4gU1VTRSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVyIExp
bnV4Cj4gYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQo+Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
