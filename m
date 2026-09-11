Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454F5C88E45
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789139800; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=jlahRe8gJTNWv+3mmfK4G8vmOmpM8hkYnmKZ8T0c75A=;
 b=Lt+W/jEJZgA2Z52BSF/8u9bkpr/yzu5uFuxwneJmIkWmpHDp4lka0e8Uw3NzGbVRv8NFZ
 hOP766OpFU3WCgs7OOuv+0qoGkq8KzRglUJsWy8WrWpYRPyAvWqS7ST25tK0/VctFVNNXBM
 PrAkxrazxKe6OTpu2FLkBAfRDmX5OMw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 701C13E9223
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 17:16:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 776D43E30CC
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:16:21 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C36AC600BA6
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:16:20 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so319101f8f.0
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789139780; x=1789744580; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=l4/acWYUlIcXwSX9UXtjaaGj3Z5EAhhy+hVHEXrtJp0=;
 b=V8MooydMQOY38YF0uOmp/jmvs3LzpdH0kBYNAeApZhCoLKuYTjj0il8RWcEsiUe9Cg
 4GlRSXZFdFGeY73cFxx01Ks5RtvljoXIJ/Mv/uc8qEm4vcxnQddHosj0cb/8dtf8hJY7
 +6nTyjM/8FTfL21N8ymmcHMAqNIA0QTA3gymAbEIFNGfcbQw302nWA9SOzW8rox6p/up
 2DTljaEwekMs7WPCgU6h3d1ROj3fp5IOzl2PGt6I1w1WC64yA4ne7nagyIEXy22GnxsK
 jUWErXBQ9M0CZ87rIZCjxaNeQSYC5q7g3L2cOBWuV9xdCRyZrPt5lg6PNFXebfMOrxF+
 fzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789139780; x=1789744580;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l4/acWYUlIcXwSX9UXtjaaGj3Z5EAhhy+hVHEXrtJp0=;
 b=SbjnWgr4wO+thWsxqdg8T6fz4MEvRIdULQMD1z8wcj3p3I9bFHOp/5RXWqwLTK8Pbd
 9GFyBZek+7wwKXy02z2jDi4lRCPBg7ETxcKQQS5wxzTpQT/b6mKZzsfv7zkBc1niEsgH
 CUliGGCLe4ymXupSjHpmRqfvR/uNt4oXhbvn6E/w+nhdLosVxRpR6fPnn51ggM31s5Jb
 7cnkD2eDq5hSHonW9Irbexq5envuExvijQI9RsLMPithauEoYmjIQmo9kYKZY9naQeCE
 uYcQvWnJO6KZbp6nrnPkSeey3T/pWy0Bv7rrfICskyYXKio5Oe7xY+A2VHVrzMGKse0b
 MCZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhLvTxyK68CieApduBzjHfz43zymE/RHh5qFWDFkIGnlS14UzRJqNV0ukM87Cra41SUhA=@lists.linux.it
X-Gm-Message-State: AFuF++nyeUwm6wM3QZ78kKqWTYy6mYiq1k4laqZLwsKm6+3krBgvEu2Q
 5QCwhiCtWwPfuM9m+0GUEYkaY/FXHTdW7YuTwGg4Q7aR4TjNdDLYRhD9lWWJRvo/2tHXkcm+Xie
 Zo5Mkvqk=
X-Gm-Gg: AYBFou1s0T7/gtkqo7vK3rxUl57UTaZRGTIbIXrjv2XhseQjc/2ppKuFkBHnie4jETd
 kLs05DiMaLkQT2Vu8cGSD7QXbPlv74AkfKaUOolPg9EJSxfTCQBnXr3tYWIdqdMV6gqSGidkA+L
 /vDTfa2ox8Ssm2nsQXKDoSRlgN944VzIttWrZnm/FR6oIbZEE3l5SLd7XwrP8EZhWGwq9bKwBfb
 4Sat+FrTBM87RBvAi/on4fe85VNynA7IwtzHc11AGRbHTh5kv+ThSZZEWxBY4Gz+Ga1GfQDUe+y
 CUz7Z6nrEADFh/XQ8q2phXeVXKGSIcbgBx9PZtgzPdDlN0KOKiOMlAM4N1qCLdSb4SydEHedX4J
 cuONBfkj2qEdJ45zbwm4uPS/tq5c+tZCXzFq1oCma7I4RbrMvv3muohp/XM7LSkg1oHkF3hh7OJ
 GJHIwajWf9gtTFOkx17mGDY1a2yj+w2+PcP2p3IhLHDwQuFCY022qkd8kX2UlPPN397nYe64iwz
 oYPMjavDuVo3V3R0ttnKtZnKk8MuzyCGM8tcUNxjdZaPqskS52+vsln/nv0nDwk5OwKzsxzYJ2K
 p7D9g5K0Nf2fzU66
X-Received: by 2002:a05:6000:4608:b0:485:8224:1a44 with SMTP id
 ffacd0b85a97d-486e988ef46mr6239417f8f.21.1789139779930; 
 Fri, 11 Sep 2026 08:16:19 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm6665439f8f.20.2026.09.11.08.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:16:19 -0700 (PDT)
Message-ID: <6aa41b43.63ed6291.2b47ca.90d9@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260911135907.GC1488703@pevik>
Date: Fri, 11 Sep 2026 15:16:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] mmap24: add test for MAP_32BIT address limit
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBBbmRyZWEsCj4gCj4gPiBBZGQgYSB0ZXN0IHZlcmlmeWluZyB0aGF0IG1tYXAoKSB3aXRo
IHRoZSBNQVBfMzJCSVQgZmxhZyByZXN0cmljdHMKPiA+IG1hcHBpbmdzIHRvIHRoZSBmaXJzdCAy
R0Igb2YgYWRkcmVzcyBzcGFjZSBhbmQgZmFpbHMgd2l0aCBFTk9NRU0KPiA+IHdoZW4gdGhlIDMy
LWJpdCBhZGRyZXNzIHNwYWNlIGlzIGV4aGF1c3RlZCB3aXRob3V0IGZhbGxpbmcgYmFjayB0bwo+
ID4gaGlnaGVyIGFkZHJlc3Nlcy4KPiAKPiBUaGFua3MhCj4gCj4gLi4uCj4gPiArKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDI0LmMKPiAuLi4KPiA+ICsKPiA+ICsJCWlm
ICgodW5zaWduZWQgbG9uZylhZGRyICsgQ0hVTktfU1ogPiBBRERSX0xJTUlUKSB7Cj4gPiArCQkJ
dHN0X3JlcyhURkFJTCwgIm1hcHBpbmcgYXQgJXAgKyAlenUgZXhjZWVkcyAyR0IgbGltaXQiLAo+
ICV6dSBpcyB3cm9uZyBvbiAzMiBiaXQuCj4gCj4gLi4vLi4vLi4vLi4vaW5jbHVkZS90c3RfdGVz
dC5oOjc1OjU1OiB3YXJuaW5nOiBmb3JtYXQg4oCYJXp14oCZIGV4cGVjdHMgYXJndW1lbnQgb2Yg
dHlwZSDigJhzaXplX3TigJksIGJ1dCBhcmd1bWVudCA2IGhhcyB0eXBlIOKAmGxvbmcgdW5zaWdu
ZWQgaW504oCZIFstV2Zvcm1hdD1dCj4gICAgNzUgfCAgICAgICAgICAgICAgICAgdHN0X3Jlc18o
X19GSUxFX18sIF9fTElORV9fLCAodHR5cGUpLCAoYXJnX2ZtdCksICMjX19WQV9BUkdTX18pO1wK
PiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fgo+IG1tYXAyNC5jOjYzOjI1OiBub3RlOiBpbiBleHBhbnNpb24gb2Yg
bWFjcm8g4oCYdHN0X3Jlc+KAmQo+ICAgIDYzIHwgICAgICAgICAgICAgICAgICAgICAgICAgdHN0
X3JlcyhURkFJTCwgIm1hcHBpbmcgYXQgJXAgKyAlenUgZXhjZWVkcyAyR0IgbGltaXQiLAo+ICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fgoKKzEKCj4gQlRXIEkgd2FzIHdv
bmRlcmluZyBpZiBJIGNhbiBnZXQgdGhpcyBmYWlsaW5nIHdoZW4gcnVubmluZyBvbiBWTSB3aXRo
IHJlYWxseQo+IHNtYWxsIFJBTSwgYnV0IGV2ZW4gd2l0aCAyNDkgTUIgSSBnZXQgZ2V0IG1hcHBl
ZCA5MjggTUIgKG9yIDk2MCBNQiB3aGVuIEkgcnVuCj4gd2l0aCAtaSk6Cj4gCj4gbW1hcDI0LmM6
ODE6IFRQQVNTOiBNYXBwZWQgOTI4IE1CIGFjcm9zcyAyOSBjaHVua3Mgd2l0aGluIDJHQiBiZWZv
cmUgRU5PTUVNCj4gCj4gV2hhdCBhbSBJIG1pc3Npbmc/CgpUaGFua3MgZm9yIGNoZWNraW5nLCBJ
IGRpZG4ndCB2ZXJpZnkgMzItYml0cyBpbmRlZWQuLgoKSSBmb3VuZCB0aGUgcmVhc29uIGFuZCBp
dCdzIHJlYWxseSB0cmlja3kuIEluIGFyY2gveDg2L2tlcm5lbC9zeXNfeDg2XzY0LmMsCk1BUF8z
MkJJVCBmb3JjZXMgdGhlIG1hcHBpbmcgcmFuZ2UgdG86CgoJYmVnaW4gPSAweDQwMDAwMDAwICgx
IEdCKQoJZW5kID0gMHg4MDAwMDAwMCAoMiBHQikKCldoaWNoIGlzIDFHQiBtYXguCgpBbmQgcHJv
YmFibHkgdGhlIHJlYXNvbiB3aHkgeW91IGNhbiAibWFwIiA5MjggTUIgaW4gYSBzaG9ydCBtZW1v
cnkgc3lzdGVtCmlzIGJlY2FzdWVlIHlvdSBhcmUgYWN0dWFsbHkgc2VlaW5nIHZpcnR1YWwgbWVt
b3J5IGFsbG9jYXRpb24uIFRoZSB0ZXN0CmlzIHRvdWNoaW5nIGp1c3QgMiBwYWdlcyBpbnN0ZWFk
IG9mIGFsbDoKCgkoKGNoYXIgKilhZGRyKVswXSA9ICdhJzsKCSgoY2hhciAqKWFkZHIpW0NIVU5L
X1NaIC0gMV0gPSAneic7CgpjYW4geW91IHRyeSB0byBhcHBseSBhIG1lbXNldCgpIGZvciB0aGUg
d2hvbGUgYWxsb2NhdGlvbiBhbmQgc2VlIHdoYXQKaGFwcGVucz8gVGhlIG9ubHkgcHJvYmxlbSBp
ZiBJIHVzZSB0aGlzIG1ldGhvZCwgdGhvLCBpcyB0aGF0IG1lbW9yeSBtaWdodApiZSBzd2FwcGVk
IG91dC4KCkkgd2lsbCBzZW5kIGEgbmV3IHZlcnNpb24gd2l0aCBQUk9UX05PTkUgdGhhdCBpcyBh
bGxvY2F0aW5nIHZpcnR1YWwKcGFnZXMgYW5kIGNoYW5naW5nIGEgYml0IHRoZSBsb2dpYyBvZiB0
aGUgZmluYWwgY2hlY2suCgotLQpBbmRyZWEgQ2VydmVzYXRvClNVU0UgUUUgQXV0b21hdGlvbiBF
bmdpbmVlciBMaW51eAphbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
