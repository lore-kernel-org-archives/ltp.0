Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4971C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 21:49:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326A63C927C
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 22:49:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA8DC3C08F2
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 22:49:32 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 002362009B8
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 22:49:31 +0100 (CET)
Received: by mail-pl1-x62b.google.com with SMTP id z3so2824669plg.8
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 13:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=RvbbaAiIaMB84G3oN+zPjB8rvhHiXeF9pAkWfbFThZk=;
 b=Krhwd6Bg6rmdsqhv4nfN4Lg6kJHCuuFAnU9ux2ZCiGsY736gtjQ8jbpMCxP7+9Ttga
 JWNHEo5OUrgmnu1uxI7Th3lCIPA5HyEUGpWHonOwvC/LbwRn1JNzHKvI7qUnQ41MkkQw
 4qRXHeNfyv42goIVBKnlr+ThzpUay0Sf1RgSnkm/zoh+ETCnosY2JrIYme+qNmnAJX+k
 dsFpwRL7RjzuDR5v2qJ3a4cLuyVkyWcPZoV8ni/DzaJPK17cK0neoK6ey+FGI3d20I0N
 5joG3zDnRkaCQ396yAjwHybyYO9TX48y375eYVR5YVyfZR+tY7+TqUjPtqZbMjvY/TDS
 yvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=RvbbaAiIaMB84G3oN+zPjB8rvhHiXeF9pAkWfbFThZk=;
 b=oRR40IBVfRODP59Duk7WbrqOKUIuSp2wktKaJN8cCfNSgrcXh2DQet3qLWBBvljp2P
 jy6udRou4Xex4BjXZ4pGlLJWdPacYudSdPQihxSA5yh/qaZMCSFWA4XD/TXYoS5/QLl+
 NEhMzwJDw19N/HH/h4rsvcrLnLOUCROq7U9lMYbjHLCwfaibHbtmIonwVohWrxzVWqEG
 7ExD0SkO/YQLUZRVKyUcei3N1PrnDZdYAVWTtjmfjGi+k2KubI62qLwCLik7iiyRguaK
 SQ8jJLVLKA82wpFInnkXVzfUeAmvLxnhujvGRt2UqIakt6UQz2UlKI9pZfHY0b54pNbi
 qmWw==
X-Gm-Message-State: AOAM533++vas75MbH2gORqXxnRdEY8gYbmfgqTBGW8Ji7YnX9fnZ4Hn9
 Pi+vXfpp9po3r8F3WNUDRKTw/2mmUzU=
X-Google-Smtp-Source: ABdhPJyuAXw2pY6Cg0XZJCijBfeGtnScr3UZq7C5MynlsTIErrDTWyX/q16r0Ah11f8JEQt50GF4PQ==
X-Received: by 2002:a17:902:848b:b0:148:a2e8:2c53 with SMTP id
 c11-20020a170902848b00b00148a2e82c53mr4371601plo.162.1640209770330; 
 Wed, 22 Dec 2021 13:49:30 -0800 (PST)
Received: from smtpclient.apple ([2600:380:8022:84d:4c38:e2b1:97e0:d3ac])
 by smtp.gmail.com with ESMTPSA id ot7sm7690440pjb.12.2021.12.22.13.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Dec 2021 13:49:30 -0800 (PST)
From: Brent Yardley <brent.yardley@gmail.com>
Mime-Version: 1.0 (1.0)
Date: Wed, 22 Dec 2021 13:49:28 -0800
Message-Id: <3DCFDCA8-6622-4619-8C91-96E0C53AF677@gmail.com>
References: <YcN8AUDq7FyjpGgd@yuki>
In-Reply-To: <YcN8AUDq7FyjpGgd@yuki>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mailer: iPhone Mail (19B74)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Disktest Removed from LTP?
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SW50ZXJlc3RpbmcuIEl0IGlzIHVzZWQgcXVpdGUgYSBiaXQgYW5kIGl0IGNhbiBiZSB1c2VkIG9u
IFNTRHMgYW5kIFNBVEEsIFNBUywgYXMgd2VsbCBhcyBOVk1lIGRldmljZXMuIEl0IHdhcyBuZXZl
ciBpbmNsdWRlZCBpbiBhIHJ1biBzY3JpcHQgYXMgaXQgY2FuIGJlIGRhdGEgZGVzdHJ1Y3RpdmUu
IAoKSXQgaXMgdXNlZCBhIHBhcnQgb2Ygb3RoZXIgcHJvamVjdHMgYW5kIGludGVybmFsIHRvIGEg
bnVtYmVyIG9mIHRlYW1zLiBJIHdhcyBqdXN0IHJlY2VudGx5IGFza2VkIGFib3V0IHRoZSBtYW4g
cGFnZSwgYW5kIHRoYXQgaXMgd2hlbiBJdCB3YXMgZm91bmQgdG8gbm8gbG9uZ2VyIGJlIGluIHRo
ZSBMVFAuIAoKU28gaWYgaXQgaXMgbm8gbG9uZ2VyIHdhbnRlZCBpbiB0aGUgTFRQLCBhcmUgeW91
IHNheWluZyB0aGF0IEkgc2hvdWxkIGp1c3QgcG9zdCBpdCBhcyBhbiBpbmRlcGVuZGVudCBwcm9q
ZWN0PyAgCgpUaGFua3MsCi0gQnJlbnQKCj4gT24gRGVjIDIyLCAyMDIxLCBhdCAxMToyNSwgQ3ly
aWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+IAo+IO+7v0hpIQo+PiBJIHdhcyBq
dXN0IHRvbGQgdGhhdCBkaXNrdGVzdCwgdGhlIHRvb2wgdGhhdCBJIHdyb3RlIGZvciB0ZXN0aW5n
IGRpc2sKPj4gc3Vic3lzdGVtcywgaGFzIGJlZW4gcmVtb3ZlZCBmcm9tIHRoZSBMVFAuIEkgd2Fz
IG5vdCBhc2tlZCBhYm91dCB0aGlzCj4+IGFuZCB3YXMgc3VycHJpc2VkIHRvIHNlZSB0aGF0IGl0
IGlzIGNvbnNpZGVyZWQgbm90IG1haW50YWluZWQuIEkga25vdwo+PiB0aGF0IEk/Pz92ZSBub3Qg
YWRkZWQgYW55dGhpbmcgbmV3IHRvIGl0IGZvciBtYW55IHllYXIsIGJ1dCBJIGtub3cKPj4gdGhh
dCBpdCBpcyB1c2VkIGFzIEkgZ2V0IHF1ZXN0aW9ucyBhYm91dCBpdCBmcm9tIHRpbWUgdG8gdGlt
ZS4KPj4gCj4+IENhbiBJIGFzayBzb21lb25lIGFib3V0IHRoaXMgb3IgY2FuIEkgYmUgZGlyZWN0
ZWQgdG8gc29tZW9uZSB0byBiZXR0ZXIKPj4gdW5kZXJzdGFuZCB3aHkgaXQgaXMgY29uc2lkZXJl
ZCBub3QgdXNlZD8KPiAKPiBUaGUgcmVtb3ZhbCBoYXMgYmVlbiBkaXNjdXNzZWQgaW4gdGhpcyB0
aHJlYWQ6Cj4gCj4gaHR0cHM6Ly9saXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjEtSnVu
ZS8wMjI5NjAuaHRtbAo+IAo+IEl0IGhhcyBiZWVuIHNpdHRpbmcgdW51c2VkIGluIHRoZSBzb3Vy
Y2UgdHJlZSBmb3IgeWVhcnMgdW51c2VkIHNvIHdlCj4gZGVjaWRlZCB0byByZW1vdmUgaXQuIElm
IGl0J3Mgc3RpbGwgdXNlZCBzb21ld2hlcmUgaXQgY291bGQgYmUKPiByZXNzdXJlY3RlZCBhbmQg
cHV0IHNvbWV3aGVyZSBvbiBHaXRIdWIuCj4gCj4gLS0gCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJp
c0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
