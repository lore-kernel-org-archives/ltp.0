Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5D3C369AB
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 06:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745477268; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=0wp+omAp9bPrFa4OSJadZNOgTmIma8FO+pQcJCh0S64=;
 b=dd5/+9WslQ+Wagualrplaxvpn35mTAM6MA2IjtRalLTO+yqYiBRf+UCvm62GuaxM66Bwf
 dpGNdWCBbzTG6kgNGg7+aOYunutX/w+O0YoTva73kk4kDKhbKW/0ICMDvBTJBDYQiQC6Bh9
 08qqMz1vy0ZfcGpf5Y/knRHTqyE2c9k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F14B3CB2CC
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 08:47:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B1C03CB23B
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 08:47:26 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5FD651A00148
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 08:47:25 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39d83782ef6so1268187f8f.0
 for <ltp@lists.linux.it>; Wed, 23 Apr 2025 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745477245; x=1746082045; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=op8wlwR5D7DkWlcC+3fQ/A11CzgLulmLHX+oMHOaDb8=;
 b=bO1LeA9feS4trT0r8D7VUIDm84hCx1d6eBrFX+6nJWldWwiHGmaDu9Gi4vVESJKD5X
 cndth+em8UJdf86bir8u/EugwoMmk4pcvAKsIrkiL+sfdzG/8YDPzXju5YVKbHU835en
 P7Aelj2heOjaE3qIAI4ANleLFIpDrSCwE+B4GvMwL3QcRumlGlLJ4jxtssI2T8HbCkVB
 udgl3tPHjT6sEk5h7qABfcMtQJ1L7E1CJ+OlKgmYWyIzriCBL8CNN1PO9x6R1cIXXxX7
 yq3zWv3YrzX0FIGkVtLK4EU/enqEyUr+5ZUWpqFxQo/1PrkSTJ19ducu1o3sgCZAUr32
 6FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745477245; x=1746082045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=op8wlwR5D7DkWlcC+3fQ/A11CzgLulmLHX+oMHOaDb8=;
 b=avh7Bcij5Nq1+7J8rzFVT2N/JYz6vB5WeDCqdf08abW3Py2W7iGwIVDjTDY9lm8JKx
 FUO6l9y1xX55LjXYJC+BOlvW/OqY102npEhjn2zoPZSVOFcdUPWJOXl4EyKbOcfq6gm2
 C/1wJfuZrEM/tRFXefRit/y5RA13dhC8YrL8cZKZFKfd46QnBLZ6PHgU2SfMQ2gbVuYI
 4KN/1rqHDxeXY0rpS2HwnXQtKStHNXMHMyEnc5uJ8LLKYNR4G4O+eSrymsdKHFxw+DcK
 9MjUCpVA7D/ZT1hYs6TxanpS0lEkDJghw4iedGodz6M9gNA5ikIRsCfjRVbCTHx/rDPU
 Rr3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD/SGhkatr0w6pf01YlPaHRpBwyA6vO+QOdOvLNK/ty1Bisbzal8I54rGoPuuhifrqgGs=@lists.linux.it
X-Gm-Message-State: AOJu0YyDI07zBs8SXtdTC7rFfvRiAUIXuFK8Qtc+ZZpVx17v9mr7PWH4
 obmtmltRGfKbb36Emst76dDPQUmEAkznGILjmgYWSHO1/Z5+gPM6OC2Amx//DKo=
X-Gm-Gg: ASbGncsQP9kPrt0FJ70BYD0OvDi0tskVK22ahgM0aty1th1GXVoq4QHsm3EugQYO/la
 bbo4+fY8PyU6BakrvKTsC5bizgoUDGYmyrMtopXOztST4L57iQwpvwl4UE6JqOL19m2ljkhg0iH
 Z9shyyf/EY2Aon6uZXvIv/Bdh4ucAcjMuBTEBiS8u8reQ0RJF+ItnBqjRzlqwlyf6BmJRlLzNF9
 XD1DvOzllhbMbQ0bLB4JC7XRdCZb0TvrZnI65j5qqAeBSbbxTHk9Z/DaDknN0Z3ZD6pxyFsmCSb
 DmLB+/4NFIui6IcB69bH76rvHrk3fIQ0KbslHoVQqpijclk0ID3a1KAAfueT8TNDWlHdooeXd+n
 xT+tHQnAkpwKfEKmtQgQ8Nr6T7wk+/xiCIx/sKk8GdZH2lHmIFgvIBqw9qSUx03mBfCCPGkDZbj
 7waoI=
X-Google-Smtp-Source: AGHT+IEFWgo5LNBM1OliMwUsBQqdXyqqBQ00OATfOG0zZZAhGKKsYHXu4OZITzUDcl+f4IygKeCG4w==
X-Received: by 2002:adf:fb4c:0:b0:391:1218:d5f4 with SMTP id
 ffacd0b85a97d-3a06d698d62mr815431f8f.23.1745477244725; 
 Wed, 23 Apr 2025 23:47:24 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d532d27sm992568f8f.80.2025.04.23.23.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 23:47:24 -0700 (PDT)
Message-ID: <85160220-450e-480f-8b82-3d875dae1260@suse.com>
Date: Thu, 24 Apr 2025 08:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <63e8ded5-9aff-4e47-9bb7-13c5c1fb80e9@suse.com>
 <D9D679V6YID4.1V0K965QC9EYJ@suse.com>
Content-Language: en-US
In-Reply-To: <D9D679V6YID4.1V0K965QC9EYJ@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open LTP meeting 24th of April
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SSBtaXN0eXBlZCB0aGUgaG91ci4gSXQncyA5VVRDLCBub3QgMTAuIFNvcnJ5IGZvciB0aGUgbGF0
ZSByZXBseSwgSSBsb3N0IAp0aGlzIGUtbWFpbCBzb21laG93LgoKS2luZCByZWdhcmRzLApBbmRy
ZWEgQ2VydmVzYXRvCgpPbiA0LzIyLzI1IDE0OjM1LCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90
ZToKPiBPbiBUdWUgQXByIDIyLCAyMDI1IGF0IDk6MTcgQU0gLTAzLCBBbmRyZWEgQ2VydmVzYXRv
IHZpYSBsdHAgd3JvdGU6Cj4+IEhlbGxvIGV2ZXJ5b25lLAo+Pgo+PiB0aGlzIGlzIGEgZnJpZW5k
bHkgcmVtaW5kZXIgZm9yIHRoZSBMVFAgbWFpbGluZyBsaXN0IGFib3V0IHRoZSBuZXh0IExUUAo+
PiBtZWV0aW5nLgo+PiBBcyBwcmV2aW91c2x5IGRpc2N1c3NlZC4KPj4KPj4gTmV4dCBtZWV0aW5n
IGl0J3Mgc3VwcG9zZWQgdG8gYmUgb24gdGhlIDI0dGggb2YgQXByaWwgMDk6MDAgVVRDLgo+PiBQ
bGF0Zm9ybTogaHR0cHM6Ly9tZWV0Lmdvb2dsZS5jb20vam9uLWd5dGYtdWVpCj4+Cj4+IEJ1dCB3
ZSBzaG91bGQgc3RhcnQgdG8gdGFrZSBpbnRvIGFjY291bnQgYW4gYW5vdGhlciBzdGFydGluZyBo
b3VyLCBzbwo+PiBSaWNhcmRvIE1hcmxpZXJlIGNhbiBqb2luIGFzIHdlbGwgKGhlIGxpdmVzIGlu
IEJyYXppbCkuIElmIGl0J3Mgb2sgZm9yCj4+IHlvdSwgd2UgY2FuIG1vdmUgaXQgdG8gMTA6MDAg
VVRDLgo+Pgo+IDEwOjAwIFVUQyB3b3VsZCBiZSBwZXJmZWN0IGZvciBtZSwgdGhhbmtzIQo+Cj4+
IFRoYW5rIHlvdSwKPj4gQW5kcmVhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
