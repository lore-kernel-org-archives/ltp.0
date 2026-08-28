Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D41C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787907748; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=me1q2FMG78TNAlOuO4jM0YEtgw/84kQbh+xzwoJIMTc=;
 b=VFJFuT3B2sYIToRhLQ0CFp9SbV+CH8vtAZXSCTlhTbK8EKWa1B2WsenZ/AYp9vGSgrP1l
 DAedk48mSOi8DRqU6c+J61so6hcm5oiLj6eIyhtJizbaem0cPSXE53DH80fVs5pKGL8KmG0
 q/NrKDUqmyTIJqJXFjgIFy113Ue6Zbg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33F443E2FC7
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:02:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F39B3CE420
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:02:06 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 442F9200AEE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:02:06 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so7595775e9.3
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787907725; x=1788512525; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SMPqPmG0ihJvpr2yr+d793iHZvt+1kSl6KyvD/CSu8w=;
 b=Oq9mpHa+xqUkisjy0Pif7cjbBYGbiWznxDoy5zWZHjA2WR9KfM9COFj4V83Akp0gU8
 v2PX/OkZGmQrTbtj1cYIbQQQ7k6KYkfScucK56Xsoml3jeCQPiPcH1/zA6zTpEd+qPSb
 EzjbvKbyUW44YLO+NyTYswAgdaQIu1wuREo84fmVTuH+2Pk0rrUK/lCVY4Mf4rzNzWSB
 WLQSlBhM3OmoiLOWZCGRmX1GxUJNzfjIuw4lBSSWkerA+1JYf0iDVoXQBo3fbpt4YFq5
 h8VNIlGbF/0qWyE2MyY6Rzq/25J2JDEhuE1W7oWRW7q0qhuFcfCCpjDCdDF30OBQLCD9
 BPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787907725; x=1788512525;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SMPqPmG0ihJvpr2yr+d793iHZvt+1kSl6KyvD/CSu8w=;
 b=Mwif/lVDB192YpDUYd8cAr/65lCavTYjRxL1ADs8rZ4XsBNbmRxyASbuQpuuvKL5bN
 YBTYvPZ01UH24C8SuO1hSwFFM1oA45Key5oU0Sb+ppzNgmYxxabHYWLTFATRPQ/kVjsU
 SDymo38FUVk7xW4yfV80zeD+wHUMtxD15KvJyYUv/zBykqM1eZ8Xnusd9JKhRe8jYLvQ
 L2BY7JAmo2QM16GM5iyh3AdWZMhk2ofLjXlK1W/TuMXn7TcIdLGc0siXvgrOl0C6pWuZ
 b9H9QHF6SQWDpTvII455vLcw9eXkjkWQhVmhSnppLlxKP98Os4CUOw7n+pHo5zk6hfVa
 i1EQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RreSaO0y9QgrEooIeyAZGmAOB/Bimm/wfiWBq+TwrE/a7qRpsOQLdgUM8jquXmslQ1JcQM=@lists.linux.it
X-Gm-Message-State: AFuF++n2YlzG+6zsFK1iRENUsXwO1mbTgbguz85t4K2zxFmqbnTmhu5t
 xL5FeU7YgAgWukBGlxn07j91Ot5xJtoqDRWSckf+mGAdn6CD2g9qg3nS3n3mZKEa8gAGGk3Ojre
 A5KFag43POg==
X-Gm-Gg: AR+sD11W6IzLCessyYJ0fFk0N4aDciL8hOqFMP+eYz58It1uX8Ft3+bp1uofghL0pGq
 83IeMwDm3JNp/JyD5tJHIc01oJCELzGkMuhLbblaHt7DaBl9dRnT1mGHCgNlpfq0ayGraXm60HR
 RWLdVI0V00N4YocGIMIZACbj588X8k3P4uEyoIVB7cDu5MJ+JuzcbTzLKU4zm80ZrW2pX+WPcZI
 bmlj/fMs4Gkug+003IZRdxYlqJJuyiKMS5EQUxBRrCyYzDUzFQZwewMpEi22/s+k1euCGlDyf8W
 mIL7/t+IY1ehP9LlUDUnTN5rWwO17XwaQqW48zj3usd0LUNiUb2wZXkH7b18lVfVyWZmAufgo7l
 h9Kb8ZcEtVktGpT/t0ac9LwIG2X4aOWrpI8JMBdJfN7THgxilTKdqpteuPg7msvxZTbsMn0AV6A
 5+GVL1vmzYPToNooDlcQFS0oF4J46AamTtHp43XNVC6P/NfnCxlkQCdaLz4O23hNsBugU0jlrH2
 EomNlBLmgR8UTqZevzCKKOckLUJ2KcxTvKJstyAn8EHoCaROCSzp8Oi7y99Z2kai5pJUkN4o/x8
 ja7wMA==
X-Received: by 2002:a05:600c:c0cf:b0:499:726b:7375 with SMTP id
 5b1f17b1804b1-49b91c51e62mr67803845e9.14.1787907724046; 
 Fri, 28 Aug 2026 02:02:04 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49c5a8e0657sm9929175e9.13.2026.08.28.02.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 02:02:03 -0700 (PDT)
Message-ID: <6a914e8b.3e068e5a.e92c7.59b4@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <apFLB-NEelwmFXfW@linux.dev>
Date: Fri, 28 Aug 2026 09:02:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon04: Add test for discard flags
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

PiA+IHRoaXMgaXMgaW50ZXJlc3RpbmcuIEFsc28gSSBub3RpY2UgaG93IGl0J3MgaGFyZCB0byBy
ZWFkIHRoZSBsb2dzLCBzbwo+ID4gSSBuZWVkIGEgVElORk8gYmVmb3JlIHRoZSBjaGVja3MuIEJ1
dCB0ZWNobmljYWxseSwgdGhpcyBjb3VsZCBiZSBhIGtlcm5lbAo+ID4gYnVnOiBjYW4geW91IHBs
ZWFzZSBhZGQgYSBzeW5jKCkgYmVmb3JlIHN0YXQoKSB3aGlsZSB3ZSBhcmUgZ2V0dGluZyB0aGUK
PiA+IGJsb2Nrc19hZnRlcj8gV2UgbWlnaHQgbmVlZCB0byBmbHVzaCB0aGUgY2FjaGUgYmVmb3Jl
IHJlYWRpbmcgdGhlIGJsb2Nrcy4KPiA+IAo+ID4gCWZkID0gU0FGRV9PUEVOKEJBQ0tJTkdfRklM
RSwgT19SRE9OTFkpOwo+ID4gCVNBRkVfRlNZTkMoZmQpOwo+ID4gCVNBRkVfQ0xPU0UoZmQpOwo+
ID4gCj4gCj4gSXQgZG9lc24ndCB3b3JrIOKAlCBldmVuIHdpdGggdGhlIGZzeW5jKCkgYWRkZWQg
YWJvdmUsIHRoZSBwcm9ibGVtIGlzCj4gc3RpbGwgcmVwcm9kdWNpYmxlLiBJIGFncmVlIGl0J3Mg
bGlrZWx5IGEga2VybmVsIGJ1ZywgYmVjYXVzZSBJIHRyaWVkCj4gb24gYzEwcyAoNi4xMikgYW5k
IGM5cyAoNS4xNCkgYW5kIGNvdWxkbid0IHJlcHJvZHVjZSB0aGUgaXNzdWUgdGhlcmUuCj4gCj4g
T25seSBvbiBrZXJuZWwtdjYuNi0qIGZhaWw6Cj4gCj4gIyBMVFBfU0lOR0xFX0ZTX1RZUEU9eGZz
IC4vc3dhcG9uMDQgLWkgMTAwCj4gCj4gc3dhcG9uMDQuYzoxNzQ6IFRQQVNTOiBibG9ja3NfYWZ0
ZXIgPT0gYmxvY2tzX2JlZm9yZSAoMzI3NjgpCj4gc3dhcG9uMDQuYzoxNzI6IFRQQVNTOiBibG9j
a3NfYWZ0ZXIgPD0gbWF4X2hlYWRlcl9ibG9ja3MgKDggPD0gMTYpCj4gc3dhcG9uMDQuYzoxNzQ6
IFRQQVNTOiBibG9ja3NfYWZ0ZXIgPT0gYmxvY2tzX2JlZm9yZSAoMzI3NjgpCj4gc3dhcG9uMDQu
YzoxNzQ6IFRQQVNTOiBibG9ja3NfYWZ0ZXIgPT0gYmxvY2tzX2JlZm9yZSAoMzI3NjgpCj4gc3dh
cG9uMDQuYzoxNzQ6IFRGQUlMOiBibG9ja3NfYWZ0ZXIgKDMyNzY4KSAhPSBibG9ja3NfYmVmb3Jl
ICg2NTQwOCkKPiBzd2Fwb24wNC5jOjE3MjogVEZBSUw6IGJsb2Nrc19hZnRlciAoMzI2NDgpID4g
bWF4X2hlYWRlcl9ibG9ja3MgKDE2KQoKZGlkIHlvdSBtb3ZlIGZzeW5jKCkgYWZ0ZXIgZmlsbGlu
ZyB0aGUgZmlsZSBhbmQgaXQncyBzdGlsbCBmYWlsaW5nPwp0aGVuIG1vc3QgbGlrZWx5IGl0J3Mg
YSBrZXJuZWwgYnVnLgoKSSB3aWxsIHNlbmQgYSBuZXcgdmVyc2lvbiB3aXRoIHRoZSBmc3luYygp
IGFzIHdlbGwsIGFuZCBhIFRJTkZPCm1lc3NhZ2UgdG8gc2hvdyB3aGF0IHRlc3QgY2FzZSB3ZSBh
cmUgcnVubmluZyBpbi4KCi0tCkFuZHJlYSBDZXJ2ZXNhdG8KU1VTRSBRRSBBdXRvbWF0aW9uIEVu
Z2luZWVyIExpbnV4CmFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
