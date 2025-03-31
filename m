Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F3DC3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743443956; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : content-type : content-transfer-encoding :
 sender : from; bh=aHO/SqTGlnDYKx1AJImSMETptXOFP8Z2UQcNLNzOUOI=;
 b=J8dwr49Emprl5qSCs0mCYekEYhTxmQ12qMNGDsg7PyTus64uZ/8/yK7SGgluYeiAlk0Q1
 PYdxi9sPyCCJcCXhvJPvKkK1H3Ayqvzq+gZfVlT2a8gVg//GA62fR0yKreZWfBOUf1KMg7R
 +zum9Z8QYbv+QYimyyWF/mVjp2nKZBc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3143A3CAD43
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 19:59:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 7C6C13C9E1E
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:58:54 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with UTF8SMTPS id BA7AD6005DD
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:58:53 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so3118144f8f.1
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 10:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743443933; x=1744048733;
 h=in-reply-to:references:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JMcNuoVgzwtMUUNR3YfuXkDlarU4Y+9H8Hl8gzDr/xM=;
 b=mpgCIxAsNo/SvpS87TIFDyz2ZsbZ3Dh0rub9lZgcctcMQHD4tloc7rfgCQjH5BN4Yc
 QxNkl2Sowe2SHfxE+weQl7s5Zp6qQx4G62KbkewfC+cb8Mzfip4CMQ8/wpkftTcWCy82
 TWBL+jZRBBOtqjJCO6mt6ipcFUK4NoIJvcUl+lwsbIQkwN0TEVExbRUV89ABMR/Zd3R8
 pSNlH8F/E0RQh9VP/oIyr1h8Ygq92hrM430NitrQsuxAvUjCsAFCIjWDwsWUuRlpyFA2
 SJ3xHnuinzOHdmhl2BBFdUSVowkR8WnBJ7buYw4PXB4NTlTXCe9ACog39QI3eYPep5Cr
 YIOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVYNJ70qvs8wrxJWTacIsun36anHIVbbuvD9mWSO126iiBBkv5pNI2dEJ9FcgTKFKCDgM=@lists.linux.it
X-Gm-Message-State: AOJu0YxdPp7MLvSC38JoA9cyJCEF9KRY/HVs8DrAcrP3jxbzUhRC2YgL
 I3N6NvpEQYqzqV4+TQoQ8rm5Y0X+/oPQ74ymtIJF8932SWXrQhGfivL2V2paHF+p8x5lZukawvW
 J
X-Gm-Gg: ASbGncvhThXCWvUKhqfs0oBUpd4rD/tGtZUNK7owivsCbbPiLTdzaTSVw2Jt3NgcpFI
 BbICjA8VqbXNioRf3hG6pDpO6OXyeRGHujToMUjf/13g6nzveebk6+G5JJzYTlBT5bBZMTMET+R
 Kkopw+1zpeBRdFanCyOL9BeNiJT1IqjwSpxlQZbI0q/tNFSwqPKlDxQdGxB/Jbh6CIAVv2BWElP
 H452vBhNm2K5WA1A4faByQ8H0W9qU1/FySrnh3Dxv4E+nPi98R0ddVc3+Zoyn89r7NIkCz/IJgQ
 KKlcCV7n9blhIc9ak9fIcfHXG9JbKjeDBQ==
X-Google-Smtp-Source: AGHT+IEaqtGuZI0I7qqUpI0NdTLQ4U24Yl5R/G54N9Sg2w9kMU7N+I0Rh60alOOwFMULLcTEWVVOlw==
X-Received: by 2002:a5d:47c8:0:b0:391:1806:e23f with SMTP id
 ffacd0b85a97d-39c120daed9mr6501240f8f.17.1743443933131; 
 Mon, 31 Mar 2025 10:58:53 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b3206sm10895148a91.42.2025.03.31.10.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 10:58:52 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 31 Mar 2025 14:58:49 -0300
Message-Id: <D8UNAKDAPZDW.I6DO8VJFXFVW@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linux Test
 Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250331-conversions-modify_ldt-v5-0-fd6ea1491956@suse.com>
 <20250331-conversions-modify_ldt-v5-3-fd6ea1491956@suse.com>
 <D8UN8017EZT6.PVLFKG2ZOJT1@suse.com>
In-Reply-To: <D8UN8017EZT6.PVLFKG2ZOJT1@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/3] syscalls/modify_ldt01: Refactor into new
 API
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIE1hciAzMSwgMjAyNSBhdCAyOjU1IFBNIC0wMywgUmljYXJkbyBCLiBNYXJsacOocmUg
d3JvdGU6Cj4gT24gTW9uIE1hciAzMSwgMjAyNSBhdCAyOjQzIFBNIC0wMywgcmJtIHdyb3RlOgoo
c25pcCkKPj4gKyAqIC0gRmFpbHMgd2l0aCBFSU5WQUwsIHdoZW4gd3JpdGluZyAoZnVuYz0xKSB0
byBhbiBpbnZhbGlkIHBvaW50ZXIKPj4gKyAqIC0gRmFpbHMgd2l0aCBFRkFVTFQsIHdoZW4gcmVh
ZGluZyAoZnVuYz0wKSBmcm9tIGFuIGludmFsaWQgcG9pbnRlcgo+PiArICogLSBQYXNzZXMgd2hl
biByZWFkaW5nIChmdW5jPTApIGZyb20gYSB2YWxpZCBwb2ludGVyCj4KPiBBaCwgSSBmb3Jnb3Qg
dG8gdXBkYXRlIHRoZSBkZXNjcmlwdGlvbi4uLgo+CgovKlwKICogVmVyaWZ5IHRoYXQgbW9kaWZ5
X2xkdCgpIGNhbGxzOgogKgogKiAtIEZhaWxzIHdpdGggRUZBVUxULCB3aGVuIHJlYWRpbmcgKGZ1
bmM9MCkgZnJvbSBhbiBpbnZhbGlkIHBvaW50ZXIKICogLSBQYXNzZXMgd2hlbiByZWFkaW5nIChm
dW5jPTApIGZyb20gYSB2YWxpZCBwb2ludGVyCiAqIC0gRmFpbHMgd2l0aCBFSU5WQUwsIHdoZW4g
d3JpdGluZyAoZnVuYz0xKSB0byBhbiBpbnZhbGlkIHBvaW50ZXIKICogLSBGYWlscyB3aXRoIEVJ
TlZBTCwgd2hlbiB3cml0aW5nIChmdW5jPTEpIHdpdGggYW4gaW52YWxpZCBieXRlY291bnQgdmFs
dWUKICogLSBGYWlscyB3aXRoIEVJTlZBTCwgd2hlbiB3cml0aW5nIChmdW5jPTEpIGFuIGVudHJ5
IHdpdGggaW52YWxpZCB2YWx1ZXMKICogLSBGYWlscyB3aXRoIEVJTlZBTCwgd2hlbiB3cml0aW5n
IChmdW5jPTB4MTEpIGFuIGVudHJ5IHdpdGggaW52YWxpZCB2YWx1ZXMKICovCgpUaG91Z2h0cz8K
Ci0gICAgUmljYXJkby4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
