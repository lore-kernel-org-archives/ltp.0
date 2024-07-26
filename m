Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E22C3DA4A
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722011140; h=mime-version :
 date : message-id : references : in-reply-to : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5WT++jcbjFUCzNeLnfGN6faYKWcrpsSIN8fYGAfrUfQ=;
 b=agpL9REZc3fk7j5S2mWpKpSGFsWeQzx86nXkYsM66bNnEwa1q312OZyeH4kU6SNFBFFC2
 LljApT01LWSfUmcLhRnUBAus7JdVPC3KhyxPH0qG0UWIfJuaCofG8daxuuUspdHOoviDPDB
 T40z1AFozj1nV4aqhPkF7aiYTf3tJp4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D4B13D1CC9
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 18:25:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA3C63CF2B3
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 18:25:17 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 635F81A02382
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 18:25:17 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7a94478a4eso327079566b.1
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722011117; x=1722615917; darn=lists.linux.it;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:from:to:cc:subject:date:message-id
 :reply-to; bh=fNk/Q+gdHd/wtmrRQ/u8qzATkby8S/HE3RYTd94yHjU=;
 b=eLkKGPfQaJfc2+gf/02LZV5OJl+TArAG0eUT3xlLlaq+/2nYOFJeEOZtpLfaL3xdEs
 8LNOeEw9i0WyIQ9AmLgoyJnyKGx47ufFWsu1qFKoJWr8/79A0uWLvqwtbgAHURzaLWAb
 qFhntXqVmnRjeCYiM2xClUHkUhCjJ44qaSqlsROonS2ohJC4lWw0zCVYGuvrPRSQkZP8
 BdZTZAD989sZdv5UIcJ0pxxNj2QMaqskGk8SKDA0G3M9IATjd95Zj3khyULoR4w27ovm
 JAWuZ/UGj+408nIwKTsh/h1t5txBljJyjrRlmKTVbqPpROA25jekwBVDUTK+hw9i22qD
 f4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722011117; x=1722615917;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNk/Q+gdHd/wtmrRQ/u8qzATkby8S/HE3RYTd94yHjU=;
 b=GKQ53CDi4x3IDLzTQrQuOy4bALvP7MOETywZjGHUf09mkGU+OhC44wyW5GH/OGU6Sv
 S6aXq+stmgeXeDO2MaaKTjpZ9YijZmUengeY7WqsoVAUEKsjpNUnrRyelRvYDWOK2Uwq
 FsqdlJGurZ2qsLexl9zhSdlq1qBCWBvpyzsc4JycU3oyi7tyIDIpf867OKLUZmiQ6sIT
 8gPjOxQyNOQ1l9LvaKDEnFtTTdJW5g+RMUsgZnquzpQkbgO7dftclY6Vi2XXlv65HXAp
 vx2rfcLzimFN8o919uxSQMoF+caJQEZbFuuKbsdYVr84RzSKgVQ2mauvGWSvRsS4HyZJ
 0PjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQihdDbXvBmy4Fxw046C5ou+yl5TUspFe1NyR8BMzgFOKVRZ069uPAIbw9VcgCyxhwQa3hcozFHza+6l5T5y1Sx00=
X-Gm-Message-State: AOJu0YzsTJGyj7tm+iP5nqh3z5cI3+/NMP4jAFxgSnExtKraHuZ0H8kY
 4mbFackOSrlWv3/ZwXXW870ya6yv2D4/ramkD4/aTIfuFnEN2Et0HlWrfZy8SO0=
X-Google-Smtp-Source: AGHT+IHi+UznP3wWZgz9bpj85tgku8mfxtaVtj6dC0xWSlVJK3P3zus1TjtF7gnrSM8lzhjN7JsBkg==
X-Received: by 2002:a17:907:7d8c:b0:a77:c051:36a9 with SMTP id
 a640c23a62f3a-a7d3f86be00mr10973966b.9.1722011115873; 
 Fri, 26 Jul 2024 09:25:15 -0700 (PDT)
Received: from smtpclient.apple ([2a02:a31b:84a1:b780:642a:14cb:fb0a:e823])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab4de06sm192837466b.71.2024.07.26.09.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 09:25:15 -0700 (PDT)
Mime-Version: 1.0 (1.0)
Date: Fri, 26 Jul 2024 18:25:04 +0200
Message-Id: <BB880A72-58CB-48B8-B7F7-3304744CE366@suse.com>
References: <ZqPFF7BovWnpZu8T@yuki>
In-Reply-To: <ZqPFF7BovWnpZu8T@yuki>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mailer: iPhone Mail (21F90)
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewritten symlink01 test
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhhdOKAmXMgYSBtZXNzIGR1ZSB0byBtdWx0aXBsZSBwYXRjaGVzIHZzLiBzaW5nbGUgcGF0Y2gg
c2V0LiBJIGNoZXJyeS1waWNrZWQgaW4gYjQgYnJhbmNoIGFsbCBwcmV2aW91cyBzaW5nbGUgcGF0
Y2hlcyBpbnRvIG9uZSBwYXRjaCBzZXQsIGZvcmdldHRpbmcgdG8gdXBkYXRlIHRoZSBzeW1saW5r
MDEuCgpJIHdpbGwgZml4IGl0IG9uY2UgSeKAmW0gYmFjayBmcm9tIHZhY2F0aW9uLgoKQW5kcmVh
Cgo+IE9uIDI2IEp1bCAyMDI0LCBhdCAxNzo0OCwgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2Uu
Y3o+IHdyb3RlOgo+IAo+IO+7v0hpIQo+PiBUaGlzIHRlc3QgaGFzIGJlZW4gc3BsaXQgYW5kIHJl
d3JpdHRlbi4gTm93IGl0IHZlcmlmaWVzIHRoZSBmb2xsb3dpbmcKPj4gc3ltbGluaygpIHN5c2Nh
bGwgZmVhdHVyZXM6Cj4+IAo+PiAtIHN5bWJvbGljIGxpbmsgaXMgY3JlYXRlZCBmcm9tIGEgbm9u
LWV4aXN0aW5nIGZvbGRlcgo+PiAtIHN5bWJvbGljIGxpbmsgaXMgY3JlYXRlZCBmcm9tIGV4aXN0
aW5nIGZvbGRlcgo+PiAtIHN5c2NhbGwgcmFpc2VzIEVFWElTVCB3aGVuIHN5bWJvbGljIGxpbmsg
YWxyZWFkeSBleGlzdHMKPj4gLSBzeXNjYWxsIHJhaXNlcyBFTkFNRVRPT0xPTkcgd2hlbiBwYXRo
IG5hbWUgaXMgUEFUSF9NQVggbG9uZyAob3IgYWJvdmUpCj4gCj4gSSBoYWQgYSBxdWljayBsb29r
IGF0IHRoZSBzdGF0dXMgb2YgdGhpcyBhbmQgaXQgc2VlbXMgdGhhdCB0aGVyZSBhcmUKPiBzdGls
bCBhIGZldyBtaXNzaW5nIHBhcnRzLCBuYW1lbHk6Cj4gCj4gJCBnaXQgZ3JlcCBzeW1saW5rMDEg
cnVudGVzdC8KPiAKPiBydW50ZXN0L3N5c2NhbGxzOmNoZGlyMDFBIHN5bWxpbmswMSAtVCBjaGRp
cjAxCj4gcnVudGVzdC9zeXNjYWxsczpjaG1vZDAxQSBzeW1saW5rMDEgLVQgY2htb2QwMQo+IHJ1
bnRlc3Qvc3lzY2FsbHM6bGluazAxIHN5bWxpbmswMSAtVCBsaW5rMDEKPiBydW50ZXN0L3N5c2Nh
bGxzOnJlYWRsaW5rMDFBIHN5bWxpbmswMSAtVCByZWFkbGluazAxCj4gcnVudGVzdC9zeXNjYWxs
czpyZW5hbWUwMUEgc3ltbGluazAxIC1UIHJlbmFtZTAxCj4gcnVudGVzdC9zeXNjYWxsczpybWRp
cjAzQSBzeW1saW5rMDEgLVQgcm1kaXIwMwo+IHJ1bnRlc3Qvc3lzY2FsbHM6c3ltbGluazAxIHN5
bWxpbmswMQo+IHJ1bnRlc3Qvc3lzY2FsbHM6dW5saW5rMDEgc3ltbGluazAxIC1UIHVubGluazAx
Cj4gCj4gQW5kIHRoZSBvbmx5IHBhdGNoIGFwYXJ0IGZyb20gc3ltbGluazAxIGNvbnZlcnNpb24g
b24gcGF0Y2h3b3JrIHNlZW1zIHRvCj4gYmUgcmVuYW1lMTU6Cj4gCj4gaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8yMDI0MDQyNDA5MjM1Ny4xMTIwNy0xLWFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZS8KPiAKPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNA
c3VzZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
