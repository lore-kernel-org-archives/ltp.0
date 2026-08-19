Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EEAC5DF6D
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787128251; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=tLpF42JTyv3zagv3aNSZEBagv+w9sDFJ+0R79yC15ac=;
 b=EITOPC6nId4jUxinsm8fTcuk1sUCtsb4eIR00/VfVVW7ZmsIJQEOqFyFCq4aGa5nBZcCP
 dvfk7plVfFriT6HOskJK5PFP6H3OjwnZrTEPUK7WbV+P87cOn1lsBPWOKEhdJaBcJCfGvYc
 UmHLeDBQyOPPjANAy6sX0os1ry/m8rc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 552E53CD5B2
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 10:30:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 594453CC6AC
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 10:30:32 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7228E600A31
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 10:30:31 +0200 (CEST)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-51c10ed63c0so131001cf.1
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 01:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787128230; cv=none;
 d=google.com; s=arc-20260327;
 b=EgQQ4Re3n/DF4c0WIRSzMJV4YQ83ObxR/vbLKLqugkC6ueTfvHFzg3QWM8XrBfYsZ5
 yZXYeEXvMTHk+Nj99DPSUW24Jo26arpXIMKwZ9pIdAYEcamilLEFiA52APSLCPePocSc
 Zqkb71N5ghQRaZ1IyObJGVQkNN2xR1DBtwVdAKQLIt0XtvYfTZJHaNA+sLLarh1raXg+
 I3TlYAv/sRHoF7RJDVBQFdFkjjqvrjJtA+4Uzd+b5ngWzom1Ne/e9U7x0vL9p2JG7SV2
 U962M6MfinoEP2JSnQ5eFgQgLXuypA55e6oUxqQk/Wsi4mMDSnRTpcGBDnlCdKXj9QX3
 NNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F+i2HTraB3eWVkV0PuVsQbDU42qFhs1Oe3DCRZlfZLI=;
 fh=SQ9N9guitCkSaO+xuxBzp1YyEEXMxSyWmXBWFIZoYuk=;
 b=AA7Si6eeSzUyxsl9ineHI6rVMIZLoJQxn3cmaByRjQJsf4CckU9TZxLGP/ZBrdT8GQ
 sIe+riSEQeDR+wRcZ8OQm0UH+6hc2OMs7BvuRNN7bgofJBLSSWxz1q60InlkvO7Qgmg/
 Vcg3YbZMiYmuObsXfdrmGnngNxi+dL2nYl8f7nLVPxrBmIHqALStQGrk8CLK4A0WyDZY
 3eC0iwhF72WDj+ncLdzG59VlqqhMntiNU8R8MmAZBplJPyVgnubm7lrX2dLgJvY6iUKE
 I+FL69oYH7UYdzVVntBDxzmO5q6+m5TmQU1ygjpSlyvdU9ogmd0BbzNzYXt62DwT5pvD
 GRig==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787128230; x=1787733030; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F+i2HTraB3eWVkV0PuVsQbDU42qFhs1Oe3DCRZlfZLI=;
 b=GHmsxOETyMAQ/A1zq13AAJapp9qz3YkKgeWgXCgwdiWZVTMOeVf6P/yS4fAlmcAMVO
 miPs5eJdzBRkyWO9i0Kv5wHTQcMGJ4472XdUvzyTyiBJhrmJ7mBTml7ZWBN1VqqMg0cP
 7vyRCPx4fSSoQq1iJQYGbhot2kUQoKLLLOmF13rHesEuJecN+lABFImoKoNx4Z6tj34V
 P0uIGqNWiE4meQ2rI35gglf1mR0uqiS2Ec4Jkd94jWa6g7G12QyyNG0q4dLDzsgFluIE
 2xP+Qs7mCYjtO5k/HUVfTt19KKRMHZ911Kpob6gbak29AYJPUPdPzO27Ir0YzjcKRRC2
 PRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787128230; x=1787733030;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F+i2HTraB3eWVkV0PuVsQbDU42qFhs1Oe3DCRZlfZLI=;
 b=p7YdF6LFf8eQL6cqkS5fk7lP1Flbq4xz4Qy11RTjzXxpdQyfTT4kOPNRNdo7YekvlX
 xwHvPBaYf+JK8g4cN4uOA6uilX1xlEwuOxLgvg8EbQhNs957oqdbBKDpn2GojlrFxAQ8
 0zTidYFh5AjA0WTbOEFS+UfVqsEDech8LyhSbr0lD63mO6HPAXITZe7/62PQwpUodC8i
 tEXPXGoLSBZfjvWTiYapJLqYeq1x7Ba2G56HqjskxYueHMKmSh7vho8EQIvmZp2gkGEA
 6KZIt+BkFbWZGe4jh/XccUbfeHDHl+BdCBGAnfeO83OXxqd3G5VUFVTRtLpV7QxyWnjY
 xWFg==
X-Gm-Message-State: AOJu0YxDARbiKAMqug2ORaee0V+KoKyVGTJU1jJQF3J66nWM0g6rcCx7
 XzrwJFk2XgplMZPYRSJ/ZJUzrSqrNHx89cVCwPdOFVeeFCllfXZb1YBhO7sUSOAD4PYmfouVwYe
 AfIMhKV5TEe1lyCGP2VPH6YVSB34TeeoQkBhDR2ux
X-Gm-Gg: AR+sD12R2j6t/6ou8OVdgf9lQ1JrXDDrXOc2ul6X1e2dBNVvaLuVqRD2aGSG9po9kHD
 /sGl2PG6V0wItYbOM/bdfcZwd8Z9k1hVlrbKDjwgrmvZH18N5Vj9NIdVPZ4FyFk5jn2g2lnwnN/
 /Ck06f3cIF/I1S9id3O5BGaeaMiEMOzUm+gU/HZrKmBLiScAGlyAzlY2wL98sz8dTvKscyqaAiX
 TNV3eE5xUO029nJYSCzeTJAskEdbBILEaR/UwUBuWibMWaRObzFNg1onJqokRSs/So/MB8ovaPe
 P+sZOL7Db5NWEY2EystkGpF/MXFGwPMLRxd3OqmIkFxLqpQLoCKUB+rNkq34L+QW1vcMBTpg1eW
 ktnEkD8WZzA==
X-Received: by 2002:a05:622a:1f96:b0:51b:ff0a:2048 with SMTP id
 d75a77b69052e-52dd90a48femr7693491cf.3.1787128229404; Wed, 19 Aug 2026
 01:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAGJyJpsBXuD0p7Cb9W3oE-cOi8Vzew9y2RhvmDE0y79YH_oWkA@mail.gmail.com>
 <6a856455.35b91a9e.11438f.2fa3@mx.google.com>
In-Reply-To: <6a856455.35b91a9e.11438f.2fa3@mx.google.com>
Date: Wed, 19 Aug 2026 14:00:18 +0530
X-Gm-Features: AcwNN1Xsp1IZ16_6sfSVnu8tUek5a5AQeE1pwlbcFOsDD_-pdYy8Kb3Vy1ct-Lw
Message-ID: <CAGJyJps3ALiJ-9N9tjY2VjyLO-VcbK-1FiCL0pfHJN6EHPVXPg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] inode01: Configure 4KB cluster size on exfat to
 prevent ENOSPC
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
From: "Kinshu Agrawal \(xWF\) via ltp" <ltp@lists.linux.it>
Reply-To: kinshu@xwf.google.com
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLCBUaGFua3MgZm9yIHJldmlld2luZyEKClRvIGF2b2lkIGVtYWlsIHdoaXRlc3Bh
Y2UgYW5kIGZvcm1hdHRpbmcgaXNzdWVzLCBJIG9wZW5lZCBhIEdpdEh1YiBQdWxsClJlcXVlc3Qg
d2l0aCB0aGUgY2xlYW4gcGF0Y2ggYW5kIHVwZGF0ZWQgZGVzY3JpcHRpb24gaGVyZToKaHR0cHM6
Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvcHVsbC8xMzQwCgpBdmluZXNoIGFs
cmVhZHkgcmV2aWV3ZWQgdGhlIGFwcHJvYWNoIG9uIHRoZSBQUiwgYW5kIHRoZSBjb21taXQgZGVz
Y3JpcHRpb24KaGFzIGJlZW4gdXBkYXRlZCB3aXRoIHRoZSAzMktCIGNsdXN0ZXIgc2l6ZSBkZXRh
aWxzLiBQbGVhc2UgZmVlbCBmcmVlIHRvCnRha2UgYSBsb29rIHRoZXJlIQoKVGhhbmtzICYgUmVn
YXJkcywKS2luc2h1IEFncmF3YWwKCk9uIFdlZCwgQXVnIDE5LCAyMDI2IGF0IDE6MzfigK9QTSBB
bmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgp3cm90ZToKCj4gSGkg
S2luc2h1LAo+Cj4gdGhpcyBwYXRjaCBkb2Vzbid0IGFwcGx5LCBwbGVhc2Ugc2VuZCBhIHYyLgo+
Cj4gUmVnYXJkcywKPiAtLQo+IEFuZHJlYSBDZXJ2ZXNhdG8KPiBTVVNFIFFFIEF1dG9tYXRpb24g
RW5naW5lZXIgTGludXgKPiBhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCj4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
