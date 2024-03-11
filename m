Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD0C54E58
	for <ltp@archiver.kernel.org>; Mon, 11 Mar 2024 16:09:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 773543CFD7B
	for <ltp@archiver.kernel.org>; Mon, 11 Mar 2024 17:09:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EF4C3C803F
 for <ltp@lists.linux.it>; Mon, 11 Mar 2024 17:09:35 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6184C601BBE
 for <ltp@lists.linux.it>; Mon, 11 Mar 2024 17:09:34 +0100 (CET)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5a1f24cc010so884792eaf.1
 for <ltp@lists.linux.it>; Mon, 11 Mar 2024 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710173373; x=1710778173; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PILxDYflZgbCo+K0GUIJE4pbycGuy7hz4ex4c7fun/s=;
 b=GsoS681qfaaw30w8NJDcLgS6Yo8x0mESssRoRKgqOtWiTr2Cr9pdkgnGrk+FgUc2ct
 M67Y3XrXBADdXUC/xF5MxwASH8WsBjqxLEimFcEJ4MU8Ue55mpx6Cehg58Qap5sBOYyx
 i+T6GvF8G22eVjBsmhSfhw1GDyyZks8BpuEaJkGXSaB/fkW5xRciSlXlymshaW4ibThM
 8Jc6Ox3+PcKKLSoJ8VnAp8dENN2zQoDFeFiTszTEeU4Qh6+h0cHPNTWdwF4eVEqBd+Ui
 O0v6TShxVMt41D6qY33ca9gjKApY5NZjMMKe2SxGCwNb5pltqugxmIXtH0Fp+jHI5B/O
 9bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710173373; x=1710778173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PILxDYflZgbCo+K0GUIJE4pbycGuy7hz4ex4c7fun/s=;
 b=crWCrw09xhun0rQiuaJ3/GHUS/xUeLBiY1zau80cdN2RtVJ5FOoskhhyIO4SVeDj6V
 qdO4lLSZEYGgDHRg832R53eUdi2pXPh0/ROEi3ok4XdF/yV03L/41m1BY/PWuAqA4ufE
 wsa7wS6WG0+zQmCpyT9BP+p9KPxDGJCWEB/ivhIj3FztSJ+ulH5JF6cnxuRid6JKCivc
 qIzWfkJkH4i/UQdfROtswxDz0pvfNhaHLRytcXpND6XND/GjEHCZOQ9Niq9kP1ZpHk01
 V7D92t732hxBhRq9CYNwgCu6GgByehPxwDBNKWirAZKGqeJ03oOmf0ibRA3C4NwNdmzz
 Lo7w==
X-Gm-Message-State: AOJu0YylABcSU2khaVjDzaJOgxLOL8KFEK5vvKCuQCUcGNfRZzCRP/2O
 Tq2p9/R6tfKD2R88BcHk03a1QoMjX6x8iU1N1sP2UUVlxpUNqsq1Yv0BoyRxASBo/NDDDpe+xon
 PdsMgZ30ZYnS/j/JMFu118ZiWwxc=
X-Google-Smtp-Source: AGHT+IGUbZUUg1zg1w8U75DViX8fDgVkO9kGSae5xIZdmLhz8HDUk5G+3kaXL8t4rEqlPyWMsVpXKWHDTGEarKCKzZ8=
X-Received: by 2002:a05:6358:39a2:b0:17b:b830:2809 with SMTP id
 b34-20020a05635839a200b0017bb8302809mr8605074rwe.19.1710173373113; Mon, 11
 Mar 2024 09:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240307092603.16269-1-meted@linux.ibm.com>
 <CAOQ4uxhFB2Gv2+8N-sc9a1+Kz1KqW+bniJe0JhVSHsaMWnxrmQ@mail.gmail.com>
 <3700d7c9-2f7e-4946-be27-87f500ccb6dd@linux.ibm.com>
In-Reply-To: <3700d7c9-2f7e-4946-be27-87f500ccb6dd@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Mar 2024 18:08:53 +0200
Message-ID: <CAOQ4uxgrGwiwpsLinWvVER-2W3AJxA0tR3qox-V4rxnt=OTTig@mail.gmail.com>
To: Mete Durlu <meted@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fanotify14: fix anonymous pipe testcases
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMTEsIDIwMjQgYXQgNDo1M+KAr1BNIE1ldGUgRHVybHUgPG1ldGVkQGxpbnV4
LmlibS5jb20+IHdyb3RlOgo+Cj4gT24gMy84LzI0IDE0OjM5LCBBbWlyIEdvbGRzdGVpbiB3cm90
ZToKPiA+IE9uIEZyaSwgTWFyIDgsIDIwMjQgYXQgMjo0M+KAr1BNIE1ldGUgRHVybHUgPG1ldGVk
QGxpbnV4LmlibS5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gV2hlbiBTRWxpbnV4IGlzIGNvbmZpZ3Vy
ZWQgKGNvbWVzIG91dCBvZiB0aGUgYm94IG9uIG1vc3QgZGlzdHJvcykgYW5kCj4gPj4gaXMgY29u
ZmlndXJlZCB0byBlbmZvcmNpbmcgKHRoZSBkZWZhdWx0IGNvbmZpZ3VyYXRpb24pLCB0ZXN0cyBy
ZWxhdGVkCj4gPj4gdG8gYW5vbnltb3VzIHBpcGVzIHJldHVybiBFQUNDRVMgaW5zdGVhZCBvZiB0
aGUgZXhwZWN0ZWQgZXJybm8gRUlOVkFMLgo+ID4+IEZpeCB0aGUgZmFpbHVyZXMgY2F1c2VkIGJ5
IHRoZSBhYm92ZSBjb25kaXRpb24gYnkgY2hlY2tpbmcgdGhlIFNFbGludXgKPiA+PiBjb25maWd1
cmF0aW9uIGFuZCBhZGp1c3RpbmcgdGhlIGVycm5vIGFjY29yZGluZ2x5Lgo+ID4KPiA+IEhpIE1l
dGUsCj4gPgo+ID4gSXNuJ3QgdGhlIG91dGNvbWUgb2YgdGhlIHRlc3QgZGVwZW5kZW50IG9uIHRo
ZSBTRXBvbGljeSBydWxlcz8KPiA+IE5vdCBvbmx5IGlmIGl0IGlzIGVuZm9yY2VkPwo+ID4KPiA+
IFNvcnJ5IEkgaGF2ZSB2ZXJ5IGxpdHRsZSBleHBlcmllbmNlIHdpdGggU0VMaW51eC4KPiA+Cj4K
PiBIaSBBbWlyLAo+Cj4gSSBkb24ndCBoYXZlIFNFbGludXggZXhwZXJpZW5jZSBlaXRoZXIsIG9u
IG15IHByb3Bvc2VkIHBhdGNoIEkgb25seQo+IGNvbnNpZGVyZWQgdGhlIGRlZmF1bHQgYmVoYXZp
b3IgYnV0IHlvdSBhcmUgcmlnaHQgZGlmZmVyZW50IFNFbGludXgKPiBjb25maWd1cmF0aW9ucyBt
YXkgbGVhZCB0byBkaWZmZXJlbnQgb3V0Y29tZXMuIEkgc2tpbW1lZCBvdmVyIFNFbGludXgKPiB3
aWtpIGEgbGl0dGxlIGFuZCBub3cgSSB0aGluayB0cnlpbmcgdG8gdmVyaWZ5IHRoZSBTRWxpbnV4
IHBvbGljeSB3b3VsZAo+IGJlIHRvbyBjdW1iZXJzb21lLiBJbnN0ZWFkIEkgcHJvcG9zZSB0d28g
ZGlmZmVyZW50IHNvbHV0aW9ucy4KPgo+IDEuIFdlIGNhbiBza2lwIHRoZSBhbm9ueW1vdXMgcGlw
ZSB0ZXN0IGNhc2VzIHdoZW4gU0VsaW51eCBpcyBpbgo+ICAgICBlbmZvcmNpbmcgc3RhdGUuCj4K
PiBvcgo+Cj4gMi4gV2UgY2FuIGFjY2VwdCBib3RoIEVBQ0VTUyBhbmQgRUlOVkFMIGFzIHZhbGlk
IGVycm5vcyB3aGVuIFNFbGludXggaXMKPiAgICAgaW4gZW5mb3JjaW5nIHN0YXRlLgo+Cj4gUGVy
c29uYWxseSBvcHRpb24gMiBzb3VuZHMgYmV0dGVyIHRvIG1lIHNpbmNlIHdlIHdvdWxkIGdldCBt
b3JlIGNvdmVyYWdlCj4gdGhhdCB3YXkuIElmIGVpdGhlciB3YXkgc291bmRzIGdvb2QgSSBjYW4g
c2VuZCBhIHYyIHJpZ2h0IGF3YXkuIEhvdyBkb2VzCj4gdGhhdCBzb3VuZD8KCm9wdGlvbiAyIHNv
dW5kcyBnb29kIHRvIG1lLgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
