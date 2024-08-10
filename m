Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB29FC3DA4A
	for <ltp@archiver.kernel.org>; Sat, 10 Aug 2024 08:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723280333; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=V9HuHBg3k/QBSzXAaMCSSZEq4opL+XClOKVFUQPjhgE=;
 b=Uc+Qy3oGB4yXnbiY7liFVm2VOPVxnlyizRLnQdKm4LHXp7TUTENJXR5LONY/GWdOrRB9h
 w5SE54tGejvEbqO2n7dNCm9y+mwnqcn4z6asJBvJG6eNdKbOtd+uRWo/X5CJXrKdZK9rvDr
 73dR6qLNMq8pr8iY3PpMFucj4GocmQs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAA2A3D1EF6
	for <ltp@archiver.kernel.org>; Sat, 10 Aug 2024 10:58:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 254B33D1CA3
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 10:58:30 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9CA1B1A01124
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 10:58:29 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7aa4ca9d72so343662066b.0
 for <ltp@lists.linux.it>; Sat, 10 Aug 2024 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723280309; x=1723885109; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GQa7LkSSMhqruVKM+Z7QNtFKoJJZsNGSEUNDe6Wqyjg=;
 b=EedAc93vzKUc+bhLH/rWvhwWpkxIurY15Nn4fbTancYicWSugtYfhSZLzxSwWOwDM2
 ac4gJEp4FgKSzpGOQhseJVVs19f6emsQW9fROtJYn1cZOL05IneCVjkdUPlFnzWUMLWo
 RYg7OK1R4Op8nnZURy3nJPyPlHGCd4Kb/iVtt5G3baRA/8paz4rOxXexOAdeuSgvdUNq
 00/jl9594a+/ElYBnse9rySfyiIB8uiezHeW+YBF4UMI6Zoz0pC5sdK3cT+H0H1kjlBD
 DFXRfxr5Z/rVubdxiJHTa99UUMUxAp8lDJndyP/ObAvDqBFgW3TaC6gSfAj63zOcEap3
 CwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723280309; x=1723885109;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GQa7LkSSMhqruVKM+Z7QNtFKoJJZsNGSEUNDe6Wqyjg=;
 b=t2GQKkbE9LTrj0sZkfb6xhXoQXUbV2nq5UYes9b3q9KdiL5SFUmeWnBNiXyFhQDtl+
 OmITBCQqbRYlr0bIf0NFNjat67KqFnvG4LtPwnq8gmffL9lCvbkaphNkyj8c6eHlByvA
 KfpBPfFPZ3IDB/K4tkeBYZLE2Mibf+xv/p8luyubxFWO/89cDkct4lTIOev16YaXJB/b
 GDeUBJonPX7f6PBcQZMdvbf2fUtNQuZwwNFEyduC6qa/FaBl57jizTvYPnmHTbcZ5dcy
 i6WEuWRvTWbaF6K3Fhyd0CHjg+EPgpynisp1e4q8pEQHRyWLWtRGAWFw2GycZR9oIYFN
 lQiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG6W08EAbwbvJHO4g3XcIXwCJLZktcUzOrXisZv0tpsHq4Y9Z478mSGufEx6ziYxFuk193xFWU3EJ8l/LNj02Sm+Y=
X-Gm-Message-State: AOJu0YzkP070lZjEFXZjSDjt6i5ofSiu0L5IvNvtvGYSF3boKnU3Hw9j
 t9QbUeAnjjDZT7AMxH7PkZa1yzmRD64UzhADfFIriCdBJzmUXOqfm892gevyaiU=
X-Google-Smtp-Source: AGHT+IFS6rF/qy0VWax7HwILq27nVp0qg61bNmGBmeenp7hyaEeDAP4F2f/pXie1p7RKwEJZ2fT8eA==
X-Received: by 2002:a17:907:7e97:b0:a7a:bbbb:6243 with SMTP id
 a640c23a62f3a-a80aa6548bdmr288946566b.51.1723280308413; 
 Sat, 10 Aug 2024 01:58:28 -0700 (PDT)
Received: from [192.168.178.49] ([79.140.125.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80bb0e1981sm52078066b.72.2024.08.10.01.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Aug 2024 01:58:28 -0700 (PDT)
Message-ID: <883b07d9-f6d0-4d6e-a85e-9028b45dc485@suse.com>
Date: Sat, 10 Aug 2024 10:58:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Petr Vorel <pvorel@suse.cz>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
 <20240801-landlock-v5-3-663d7383b335@suse.com>
 <20240808095824.GC327665@pevik> <20240809.Ohqueicih1ou@digikod.net>
Content-Language: en-US
In-Reply-To: <20240809.Ohqueicih1ou@digikod.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/6] Disable kernel version check in landlock
 tests
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
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWVja2FlbCwKCk9uIDgvOS8yNCAxNjozNiwgTWlja2HDq2wgU2FsYcO8biB3cm90ZToKPiBP
biBUaHUsIEF1ZyAwOCwgMjAyNCBhdCAxMTo1ODoyNEFNICswMjAwLCBQZXRyIFZvcmVsIHdyb3Rl
Ogo+PiBpcyBpcyByZWFsbHkgaGVscGZ1bCB3aGVuIGxhbmRsb2NrIHN1cHBvcnQgaGFzCj4+PiBi
ZWVuIGJhY2twb3J0ZWQgaW50byBvbGQga2VybmVscy4KPj4gR3JlYXQsIEknbSBnbGFkIHlvdSBy
ZW1vdmVkIGl0IGZyb20gYWxsIGxhbmRsb2NrIHRlc3RzLiBJdCByZWFsbHkgZGlkIG5vdCBtYWtl
Cj4+IHNlbnNlIHRvIGd1YXJkIGNvcnJlY3QgdmVyc2lvbiB3aXRoIDMgZ3VhcmRzIChrZXJuZWwg
dmVyc2lvbiwga2VybmVsIGNvbmZpZyBhbmQKPj4gQUJJKS4gQ291bGQgeW91IHBsZWFzZSByZW1v
dmUgYWxzbyBDT05GSUdfU0VDVVJJVFlfTEFORExPQ0s9eSwgYmVjYXVzZSB5b3UKPj4gY2hlY2sg
RU9QTk9UU1VQUCBpbiB2ZXJpZnlfbGFuZGxvY2tfaXNfZW5hYmxlZCgpLgo+Pgo+PiBBbnl3YXks
IGZlZWwgZnJlZSB0byBtZXJnZSB0aGVzZSBmaXJzdCAzIHBhdGNoZXMgKGlkZWFsbHkgcmVtb3Zl
IGFsc28KPj4gQ09ORklHX1NFQ1VSSVRZX0xBTkRMT0NLPXkgYmVmb3JlIG1lcmdlKS4KPiBNeSB1
bmRlcnN0YW5kaW5nIGlzIHRoYXQgTFRQIG9ubHkgdGVzdHMgc3VwcG9ydGVkIGZlYXR1cmVzIHRv
IG1ha2Ugc3VyZQo+IHRoZXkgd29yayBhcyBleHBlY3RlZCwgaWYgZW5hYmxlZC4gIElzIGl0IGNv
cnJlY3Q/ClllcywgbGFuZGxvY2sgaW4gcGFydGljdWxhciBjYW4gYmUgYSBiYWNrcG9ydGVkIGZl
YXR1cmUsIHNvIHdlIG5lZWQgdG8gCnJlbW92ZSBDT05GSUcgZmxhZ3MgYW5kIGtlcm5lbCB2ZXJz
aW9uLCByYWlzaW5nIGFuIGVycm9yIGp1c3QgaW4gY2FzZSB3ZSAKaGF2ZSBFTk9TWVMuCj4gSSdt
IHRoZW4gd29uZGVyaW5nIHdoYXQgaXMgdGhlIHB1cnBvc2Ugb2YgbmVlZHNfa2NvbmZpZ3MuICBJ
ZiB0aGVyZSBpcwo+IG5vICJuZWVkZWQiIGNvbmZpZywgZG9lcyB0aGF0IG1lYW5zIHRoYXQgTGFu
ZGxvY2sgdGVzdHMgd2lsbCBhbHdheXMgcnVuCj4gYW5kIGRldGVjdCBhdCBydW4gdGltZSBpZiB0
ZXN0cyBhcmUgc2tpcHBlZCBvciBub3Q/ICBJZiB5ZXMsIGl0IGxvb2tzCj4gZ29vZCB0byBtZS4K
Pgo+IEFuZHJlYSdzIGNvbW1pdCB0byByZW1vdmUgbmVlZHNfa2NvbmZpZzoKPiBodHRwczovL2dp
dGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9jb21taXQvZTdlYmM2MzdkMGQ5OTI5NTQ5
MGFkZjU3NjYwYTNiM2ExNzdkNjVkMwo+Cj4gSXMgdGhlcmUgYW4gb25saW5lIGRhc2hib2FyZCB0
byBzZWUgc29tZSB0ZXN0ZWQga2VybmVscz8KQFBldHIgVm9yZWwKPgo+PiBSZXZpZXdlZC1ieTog
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4+Cj4+IEtpbmQgcmVnYXJkcywKPj4gUGV0cgo+
Pgo+PiAtLSAKPj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwClJlZ2FyZHMsCkFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
