Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B040CC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791974302; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QVnKzXWHPbeJx0QnlDrn7fwQcwumAzNi7rkFayYsza0=;
 b=LOqojHKWaRl+8NJvtLn1Ps0S+VgZ05SL2Fbq7qPVllCzumcmKc7qnsD3//uWJAe/y3fcG
 DB8jagF9hC97BvBm+Xm+JSy6w9ckMcGJ0LYbdYcHdwVbXDZIlkpFMa2ixNB85UuBVUtWFzz
 sQGHd1t2DshVe+lANP4UN630CyXeg5k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 538C23E6C1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 12:38:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50ADF3E6A6C
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 12:38:02 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F6EE1A009B1
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 12:38:01 +0200 (CEST)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6767d92cde6so3802510d50.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 03:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791974280; cv=none;
 d=google.com; s=arc-20260327;
 b=nuKXUoQZIcrTLC6kYrYEeqkZ1TOOaJkVUzE9nUCbWNgZxWyye1q2grOMwU9r2jHPdV
 IFxsLPHYCvswk9JcqvuoRQEeNq2z3WhAZTWzu9lPgkt+27v/4AIhd9O4RnOnrTGMcCJR
 mmkrsZ0VSmcaLLxDFoN2h/LWBv2ya9vdO1riXpWeG7oTGvArFr7ra8Fv9urrkLDTu8mX
 nSJYT2zEJvwU3HaQsgeZDA3A4m7WkcqT/pDc9zfvwEempVNQxZLNCkxefC0RiWQyBtZe
 Kj5BHyw8fAREER3LHd7XdnXM7F/6Iq4G+QGsk30kZ/Ke2AiUcGDZ4WRp5NMnEf22mpUv
 EXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mpYgu2y/reHeo/lBMZ/6W7dq7bl+O46fQq9jwxCM/34=;
 fh=SQ9N9guitCkSaO+xuxBzp1YyEEXMxSyWmXBWFIZoYuk=;
 b=CWBGLtQtgF2OVMGCQ6fKYh1Vg1MEm/oVTSovMrBaC3aSRvoCYwU8OQhChajJxGHnDb
 DUSBm+j5sYkg9dMBqlXGzqqjVe7bosGhGCL9nYdht4P8y2ZCjzHypIr3CtZmaAP+RyBA
 xE0K/hgiTq6D00c/FNUPBD0BnmNVvi9wXy3kVHTkTqhuHlamqKR5Tk+jVQYLrhXAgIWC
 Fh1lWUB0qbdql+nRG/rYWmGKWZ71HMZ0pEeI7qFRg8BP6tr2bNDAR6lHYC3RVa2shKmo
 iBItUgzEsdPzmgbaSvNjhrwvwzTRumk54XH7U8+7vIu/kSHCGySxBNpHKjQ3nQ73Tz3n
 h4Vw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791974280; x=1792579080; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mpYgu2y/reHeo/lBMZ/6W7dq7bl+O46fQq9jwxCM/34=;
 b=YD1AImV/GBicqQELpFEZZ6Tns2U0C0/hp4ggflULusSdpo+kLGizAnmg1WwNaoSHoY
 gmH69I1/RU2IpRmo+wIEJbPKawrQ2s5orwjxX7UoEklAVl5NsvVSdWmBI58Ng3VmyGhT
 OT4Ggs9ccJ4Lj98laAlOMDypDbpM2SuC6Kpd7aScjtqbebU/i/iHI8ywzr6iPrllf128
 A1fpgmJo4wSaVR4+69bFYJ+qQKN+3eXgf/VnwmeZNRK8tiXwXL4GTnsvWbk8tt/7sCw+
 EhcL7tfr3kUN1GzbXn7Vg5TqrYkyN1rORr6y+nIfgq82j3HsFzMVXFSd5d20WOeM++sc
 r1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791974280; x=1792579080;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mpYgu2y/reHeo/lBMZ/6W7dq7bl+O46fQq9jwxCM/34=;
 b=YnPPHxnE9O8C4K0qxjERKb1qOQergY13nmf4jpDrk9/qRL/hl84IpF7+8NMo8Cce2W
 jVZabl7AEfQuFjPgO7xz+wmVw1gBvAShtrIcgCEjK3fYy8OB7w/ds335PKGDsYlNRZvO
 slD7+DfIULAKbV+a0Cr4GSLRlJngAZoqrlT4XG+to764wLjfrVTpAxvIcfv6A0yu3MSZ
 l8crUls5kf0YZ46fwiJUJy4KGfPSXcSbgpQvE25eAF2uqBLjkghnFb0+4CfqZud0/T7C
 xGUYHxSDiokpXskxSCwvp6uWO6NL4tawDMYk53+nJVo6ZvL7ID9g56aJT6uiyawkSVin
 OS7Q==
X-Gm-Message-State: AFq9FYKtzHPAYP/Wy3lX8NcNU52jMXaatmokuEqDbkLPAqU8Yac9dVYK
 7Rp9R1x5LmjL7mqF6axs6IjMU5EwLX98V6KjxiTY+nub1i42eDPgTlmwVEOKNIWNzNQz+qcn3nm
 asv2XpjVzKbhYY5DQ0EdbYL+cky+Kry9x6gyFCZcr
X-Gm-Gg: AYBFou3BsqRrfrVbzIQkKtw72C+3UJRK7LxypNySSdL3GOqw3sMQouIeoAKROTYWSfY
 vmFNtNAygd87grG594shtoGVk3NU/UTBMePm6jnBOszFWUDm+rVuwvDWGN5AcpuoE1vobDODE2m
 t5Tw5G+LWjazsDnVTC9/Achyu1OR3mlbxs4QZbipoT8bHr3c4tunIodmFKSyDZOgUeTbKFJ00AQ
 WZYcAdSSEou5RFLbeJv2AmlVk4Pg0Ijca826WzpOySh0k22TvZNlEJwS6/GYk5ZTiaERtlQ8yPs
 CmfSP31WCmLC0FB7ksuxQnCyOpVHLZyy+18DyWUFCGO8HPnMm5OCsCW8Vo+tfUpM3LGpZ03Q4if
 +qHrG429zkceUtEaRBN4oMrHFWdkGKQ0ZmhwYyy7DL9bneMjTClOWm7Vtc7JGC3GM602HLdYmk5
 2J1A==
X-Received: by 2002:a05:690c:ec4:b0:8a8:6a39:37e0 with SMTP id
 00721157ae682-8b07ed9d95bmr56720317b3.42.1791974279443; Wed, 14 Oct 2026
 03:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <6ac3932e.d5b2c389.14d673.04f0@mx.google.com>
 <ifSVZvHsWCaLinAgtZoIIvpkMS0DfVOX5iZ4@localhost.localdomain>
In-Reply-To: <ifSVZvHsWCaLinAgtZoIIvpkMS0DfVOX5iZ4@localhost.localdomain>
Date: Wed, 14 Oct 2026 18:37:22 +0800
X-Gm-Features: AclHuK9pgfBHQ7KO4jErHChkmSf2Z5bSh8i2bE0UUqMLiORfJAqvfUtKNrwkQI8
Message-ID: <CAOcRiAGG6BBdewcDz42UcrOyLG8MfzdQcURWzCEqs6pJrttBDw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_{set,
 get}attr: Call the syscalls via tst_syscall()
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKPiBUaGUgYHNjaGVkX3NldGF0dHJgIGRlZmluaXRpb24gZmFsbHMgYmFjayB0
byBgc3lzY2FsbChfX05SX3NjaGVkX3NldGF0dHIsIC4uKWAKPiBpZiBpdCdzIG5vdCBwcmVzZW50
IGluc2lkZSB0aGUgc3lzdGVtIGFuZCBpZiB5b3Ugc2VlIHRoYXQgZXJyb3IsIGl0J3MgcHJvYmFi
bHkKPiBiZWNhdXNlIHlvdSBhcmUgbGlua2luZyB0byB0aGUgd3JvbmcgbGlicmFyeSBsb2NhbGx5
LgoKWW91J3JlIHJpZ2h0LiBUaGUgYmluYXJpZXMgd2VyZSBidWlsdCBhZ2FpbnN0IGEgbmV3ZXIg
QmlvbmljLCB3aGljaApwcm92aWRlcyBzY2hlZF9zZXRhdHRyKCkgYW5kIHNjaGVkX2dldGF0dHIo
KSwgYW5kIHRoZW4gcnVuIG9uIGRldmljZXMKd2l0aCBhbiBvbGRlciBsaWJjIHRoYXQgbGFja3Mg
dGhlbS4gVGhhdCdzIGEgbWlzbWF0Y2ggaW4gb3VyIGJ1aWxkIGFuZAp0ZXN0IHNldHVwLCBub3Qg
c29tZXRoaW5nIHRoZSB0ZXN0cyBzaG91bGQgd29yayBhcm91bmQuCgpQbGVhc2UgZHJvcCB0aGlz
IHBhdGNoLCBhbmQgc29ycnkgZm9yIHRoZSBub2lzZS4KClRoYW5rcywKV2FrZQoKT24gTW9uLCBP
Y3QgMTIsIDIwMjYgYXQgODoyNOKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJlYS5jZXJ2ZXNh
dG9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4gSGkgV2FrZSwKPgo+ID4gUmV2aWV3ZWQtYnk6IEFuZHJl
YSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBJIHRoaW5rIEkgcmVw
bHkgdG8gdGhlIHdyb25nIGVtYWlsLiBGb3JnZXQgYWJvdXQgdGhpcyBSQi4KPgo+IFRoZSBgc2No
ZWRfc2V0YXR0cmAgZGVmaW5pdGlvbiBmYWxscyBiYWNrIHRvIGBzeXNjYWxsKF9fTlJfc2NoZWRf
c2V0YXR0ciwgLi4pYAo+IGlmIGl0J3Mgbm90IHByZXNlbnQgaW5zaWRlIHRoZSBzeXN0ZW0gYW5k
IGlmIHlvdSBzZWUgdGhhdCBlcnJvciwgaXQncyBwcm9iYWJseQo+IGJlY2F1c2UgeW91IGFyZSBs
aW5raW5nIHRvIHRoZSB3cm9uZyBsaWJyYXJ5IGxvY2FsbHkuCj4KPiBQbGVhc2UgY29uZmlybSBp
dCBzbyB0aGlzIHBhdGNoIHdpbGwgYmUgcmVqZWN0ZWQuCj4KPiAtLQo+IEFuZHJlYSBDZXJ2ZXNh
dG8KPiBTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKPiBhbmRyZWEuY2VydmVzYXRv
QHN1c2UuY29tCgoKCi0tIApCZXN0IFJlZ2FyZHMsCldha2UgTGl1CgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
