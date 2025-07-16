Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5501BC83F1B
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 08:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752654034; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=KXRvfW0fLqVHMgYESs9KrqIA231wtN0uTX+HSXBvv8g=;
 b=nJXWCzMnM5TQ9JD9tZv2C3vZi8OOG3B2h92v3mMbEtC6MfML/58IvhOPs51WmVjdBXlFx
 j82GIe15SrTZ/0OF8WjOc0goYe/od+LCugDBqjO9Cc1cIin2HdsUSkLyyx6f0Nt7HXT6Ypb
 ebUWC2AJFrdgBeitkXCcjYMFYrXVePs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B56D63CBD99
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 10:20:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EDD13CBC18
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 10:20:11 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 218CD2009D0
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 10:20:10 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso4712489f8f.1
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752654010; x=1753258810; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OxLCss+OJkZqPaN870whXh2pTNZGjuOD1WieBU6SwSc=;
 b=L4sbNekc12/G5Ad4CiPuUCx6QlbgJLFIJh3zp7MjFo8iVwy49o/aHCqH4CuRLm0dRv
 QLAEj5n4TBwRMH243EOSiPJZoj4n2PrimyoMex1qUTMIQyYvX3AtgyRBDkGqWeAiVMK1
 iuOwZPF7KyxKqUk/oUy9m6TT8gt4oE4ZJ5j/WzPmSpqozkoomMpgkI0Nxe9+hb/Or/Ht
 6lEGivd8INjtRowrXNZ2Sf7tw3w0xf5/uQWKNVcfNAZ42XP+NIXWowq44lSkRlf00sRi
 hIjseUqCD+De+l+xJcBYR/eYxKRNaoGBwRcM9Dh5BqMu2k80QX9FAV0Vb8mFz3XNGhZ5
 ZqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752654010; x=1753258810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OxLCss+OJkZqPaN870whXh2pTNZGjuOD1WieBU6SwSc=;
 b=SAGmRsPxQVgWikkdQfZPs7B09rh0hygMU2G9lusRoBslvFBzsL0OSD2TON1nMMu1aF
 1y9leYXwvTtJ/c3Er+9ufgXa9Ysj5uXWWA8DhVWF3RZmNoaHe/SBeLONUFh18tsjCvmq
 V3blRcvCnhCwNl96DEaZXuL0ChSouj+vPYJBB9SKFIIC2UmGDPWXUkxJHW2NENZkDkkK
 PilaBrUc5TipcTBs5B+wk/ZMuPNVCZb3wAxUNx4oeykL04hFsnJwiaj/Hekz5696UHCU
 209lPMrYVAJYcimBFkLEDm7N5Xz8gch1eV3FCFjqKhC+bHcsZECHrc2y5ow5wIWsGwHq
 YTQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgELFVeZtxGZ9WJx9LeUYFWusbxhOXP02Oscb6mtONoZwS00ms5Z7PenH605nbpfODuYM=@lists.linux.it
X-Gm-Message-State: AOJu0YxjS/9g7gnvx7/5FzEZ1i3jL6VlcpCJChd6HOs5jqU4k8TZnnbU
 WzFDlfkTdQF3X9MGxE9MJfkLv6Nvo8ZOLh5vLRWXPm9wqKD51n6/KoYwa+8US/Fcs+A=
X-Gm-Gg: ASbGncu8X32AZfHIsHCoFW76KqgymBRmNU+FerQ3K/OL9na+D7yJGBdIa2rJ/D46ZT4
 hrm9L4x/1SeywJ7Xi2q99z5sWSvQUlCyZpzCmAUoMXWftTE39346Fx72r+q4N900CeE2dMoOTeb
 u/XnkuQIOwmc493Oeu9vsTGw/p35nb1aGHPBNEMqjr5IIimd+h4YHvnjYLjQfJ+gRpb2jE1ZA4Y
 SXZlXah4v5basZxO8fkb8b41G+Jv0kaxc6kEQ3U4bT90BuSO8ek00ncm7DA4KMiwh87DB6QSe+p
 Ph/43ox5+ycjVBewZogGQeN68fOnJj3q3P1NgPe4R/BzyL0ZbD48UGq6fDMV9ekXS+aBgOcXVPB
 S1RcE1gWJaBjf2s6L/hv61ydTm0GxIkIAui0ZiDI04rDkSVhixIbq6aQyfDkIP83lGL5Cc+Jwv6
 pWrgog/XmnVbffWLVzpRZ5rMazQ6Z57GraHfNUdsI3QFvWqrG3F8Zy/j0oPNwYJg==
X-Google-Smtp-Source: AGHT+IFnWuY2yJtEM1wKcDkPK6jQ66NFWmv1lIB1eCj7gFVLVdePsy6GSVUQ3BmFxikD6npirc0VPw==
X-Received: by 2002:a05:6000:2507:b0:3a5:2cf3:d6ab with SMTP id
 ffacd0b85a97d-3b60e518456mr1304622f8f.39.1752654010341; 
 Wed, 16 Jul 2025 01:20:10 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f28807csm893560a91.26.2025.07.16.01.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 01:20:09 -0700 (PDT)
Message-ID: <eb57d278-7e38-428c-8e5d-2a3fa049eaae@suse.com>
Date: Wed, 16 Jul 2025 10:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>
References: <20250709-xattr_bug_repr-v3-0-379c2c291bb7@suse.com>
 <20250709-xattr_bug_repr-v3-2-379c2c291bb7@suse.com>
 <aHf839WS0BPIa5Zq@MiWiFi-CR6608-srv>
 <f97ca222-fd8d-49e2-8e32-6e888d832f68@suse.com>
 <aHgD3wLn7Uw6ywyW@MiWiFi-CR6608-srv>
Content-Language: en-US
In-Reply-To: <aHgD3wLn7Uw6ywyW@MiWiFi-CR6608-srv>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add listxattr04 reproducer
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDcvMTYvMjUgOTo1NiBQTSwgV2VpIEdhbyB3cm90ZToKPiBPbiBXZWQsIEp1bCAxNiwgMjAy
NSBhdCAwOTozNDozMEFNICswMjAwLCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+PiBPbiA3LzE2
LzI1IDk6MjYgUE0sIFdlaSBHYW8gd3JvdGU6Cj4+PiBDdXJyZW50IHRzdF9zZWxpbnV4X2VuYWJs
ZWQgd2l0aGluIHlvdXIgcGF0Y2hzZXQgbm90IGNoZWNrIHJ1bm5pbmcgc3RhdGUKPj4+IG9mIHNl
bGludXguIHNvIGkgZ3Vlc3MgeW91IG5lZWQgY2hlY2sgL3N5cy9mcy9zZWxpbnV4L2VuZm9yY2Ug
dmFsdWUKPj4+IGhlcmUuCj4+PiBPciB5b3UgY2FuIHVzZSB0c3Rfc2VsaW51eF9lbmZvcmNpbmcu
IENvcnJlY3QgbWUgaWYgYW55Cj4+PiBtaXN1bmRlcnN0YW5kaW5nLgo+PiBJZiBTRUxpbnV4IGlz
IGVuYWJsZWQsIHdlIHdpbGwgaGF2ZSAvc3lzL2ZzL3NlbGludXggZm9sZGVyIGZpbGxlZCB3aXRo
IGZpbGVzCj4+IHRoYXQgY2FuIGJlIHVzZWQgdG8gdmVyaWZ5IFNFTGludXggc3RhdHVzIChzdWRv
IHNlc3RhdHVzIC12KS4KPj4gdHN0X3NlbGludXhfZW5hYmxlZCgpIGlzIHVzaW5nOgo+Pgo+PiAg
wqDCoMKgIGFjY2VzcyhTRUxJTlVYX1BBVEgsIEZfT0spID09IDAgJiYgIXRzdF9kaXJfaXNfZW1w
dHkoU0VMSU5VWF9QQVRILCAwKQo+Pgo+PiBUaGF0IGlzIGVub3VnaCB0byBrbm93IGlmIHdlIGhh
dmUgU0VMaW51eCBvciBub3QuIEFjY29yZGluZyB0byBDeXJpbCB3ZQo+PiBwcm9iYWJseSBqdXN0
IG5lZWQ6Cj4+Cj4+ICDCoMKgwqAgdHN0X2lzX21vdW50ZWQoU0VMSU5VWF9QQVRIKQo+Pgo+PiBM
aWtlIGl0IGlzIGluIGlzX3NlbGludXhfZW5hYmxlZCgpLgo+Pgo+PiAtIEFuZHJlYQo+Pgo+IElm
IG9ubHkgY2hlY2sgZW5hYmxlIHN0YXR1cyB0aGVuIGkgZ3Vlc3MgdGhlIHRzdF9icmsgbWVzc2Fn
ZSBzaG91bGQgdXNlCj4gdHN0X2JyayhUQ09ORiwgIlNFTGludXggaXMgbm90IGVuYWJsZWQiKSBp
bnN0ZWFkIG9mCj4gdHN0X2JyayhUQ09ORiwgIlNFTGludXggaXMgbm90IHJ1bm5pbmciKSA/CgpS
aWdodCwgImVuYWJsZWQiIGlzIG1vcmUgY29ycmVjdC4KCi0gQW5kcmVhCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
