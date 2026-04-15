Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F3AFA0C3C
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 07:55:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CC493E2689
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 09:55:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53C473C6FF9
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 09:54:43 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CC6646005F6
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 09:54:42 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8d7e7f48499so633593685a.1
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776239681; x=1776844481; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOOY8W+fN3kJ1qy8oay8sJSYDi3oZkgpd8Id9s64kK0=;
 b=ONCoU7p2/tjgOU5eTHbIXV+n22AURQIo5OfDY/Bqu8ZgyXpuqvBU2A3fvQ1Gchaggt
 ZvhE40Ewyg6nUijgEVVlBHodwQVDSE6bz/7+RTwXNAB6IIcbiN9YbRIu67YRAmwWSo9y
 Sjzynhl3pEPx6LLn0tyAeI3sLjKtFxRLvWvuWBSaJveVGA68ZeZ9mG6z0ROZmBWvsVzH
 1cCEam5Ii3r55xNs94Z61/U1wGg7WtdKehWqX19+26H7idqw8VfhbX0HL8C57fK9ASP8
 sxVDwlwxRdUpwU80EgSyPPDSZRUTWNLbYZMpQungx4Dj0ur6Xix9UJ91TflwfRVgaAM6
 JVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776239681; x=1776844481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fOOY8W+fN3kJ1qy8oay8sJSYDi3oZkgpd8Id9s64kK0=;
 b=WzDgOcn6jcBn6aZot9xGaMDaPwcX8/t6JoNZ+DDCpjNQ9xQ0uhuTRhKkpoWXPMUzYb
 Z5jOb3TUSpOz5/hoxsi5M6st+VHNeVSldHbxNXnPA0QQkGRZCGpiX7mHU4xwJrhR/YVO
 MnZjqbZmfxv4tmcAl8Z2nmTnwNembTX4WjLKJiUp/05suRM7l8pkrMvseU9YIyhh26Vd
 9ec/Nx9e1Q4F6QPbZLKHka1fP7VaZiLdRJ1zQ+gbfIt4/Aa5UNNjjNHObkp9Ft/dxSLc
 aFI2wPt0UjB1LvmuPtd88swsOynjN2rm3yR3mGRWSUPfYfc0Pn42/hL9pRp2xoaxXnzT
 iX8A==
X-Gm-Message-State: AOJu0Yw+dVlYm2lqZPIorPK69HQ8AfhM/UpnrO1Tipwax5JZBTbVJSre
 A/TnS13ASFTqH0w44jY1ew3jj6mLB2CyAJzusRQXBJaQnpWFQwNJwDm9
X-Gm-Gg: AeBDieuKaKrcLVHPC2yrQinW6XJ/TDh7mbpWR6VWNh1FKe2NhdgAULf3s65LB6E20Im
 t47jb+2FcKk5yqbQN2lIXdNzOwuu7LKO1j2um25H3w1Y1/M5rvlNHgAiZ6bQ28d3npgT5mQv7zW
 +X75y7QuZVZ7kmbMEHr9sxSxo+3uha0CUGfFeT0Xk5u50GgtQG9JWzvX3DUTqNX5xYlqMhS/DfJ
 TTYMUvYu8NOk6MPgy/hR90ZUd7VDegDoXB9saMZ1crcJ0EHJcI42giIpgByDCB7MadrEU69zEgQ
 kQ1TOqZ71SAwf5ljnilR4kL7pRmesf6FJftKf2JTBUISoSDLmj2JDRrrsiE8PaIE+KjJOaxrfYC
 b5l9CV38PeDQoz7ijgwgZc+8FhjwDrpJOWW0aLIR6wL6CGBxXsnXvzwY+oNv4krGF6E+2rQdMo4
 2iZgEMzZVQLxzTZ/9lQNtfNNdOeCyfz3YR6lPyMd/ZdIBC9vI7ucuhPgCzu7fc6rUlplY0MmXfl
 kbi5EmceveIDPtMDw9+Gj5LY5SQXpBVasHiOT4=
X-Received: by 2002:a05:6214:4905:b0:89a:1364:1027 with SMTP id
 6a1803df08f44-8ac8617efafmr328604106d6.14.1776239681368; 
 Wed, 15 Apr 2026 00:54:41 -0700 (PDT)
Received: from
 runnervm35a4x.yaenpszya1ne1izvz2uykgmlyh.cx.internal.cloudapp.net
 ([20.109.38.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6ceb80f6sm5751426d6.46.2026.04.15.00.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 00:54:41 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 15 Apr 2026 07:54:40 +0000
Message-ID: <20260415075440.4000-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415060728.21662-2-wegao@suse.com>
References: <20260415060728.21662-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: New library function tst_get_free_uid
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

SGkgV2VpLAoKLS0tIFtQQVRDSCAxLzJdIC0tLQoKT24gV2VkLCAxNSBBcHIgMjAyNiAwNjowNzox
NiArMDAwMCwgV2VpIEdhbyB3cm90ZToKPiBbUEFUQ0ggMS8yXSBsaWI6IE5ldyBsaWJyYXJ5IGZ1
bmN0aW9uIHRzdF9nZXRfZnJlZV91aWQKClRoZSBjb21taXQgYm9keSBpcyBlbXB0eS4gQWRkIGF0
IGxlYXN0IG9uZSBzZW50ZW5jZSBleHBsYWluaW5nIHdoeQp0aGlzIGhlbHBlciBpcyBuZWVkZWQg
4oCUIGUuZy4gdGhhdCBvcGVuMTYgcmVxdWlyZXMgdHdvIGRpc3RpbmN0CnVucHJpdmlsZWdlZCBV
SURzIGFuZCB0aGF0IHRoaXMgZXh0ZW5kcyB0aGUgZXhpc3RpbmcgdHN0X2dldF9mcmVlX2dpZApw
YXR0ZXJuIHRvIFVJRHMuCgotLS0gW1BBVENIIDIvMl0gLS0tCgpPbiBXZWQsIDE1IEFwciAyMDI2
IDA2OjA3OjE3ICswMDAwLCBXZWkgR2FvIHdyb3RlOgo+IFtQQVRDSCAyLzJdIG9wZW4xNjogYWxs
b3cgcmVzdHJpY3RlZCBPX0NSRUFUIG9mIEZJRk9zIGFuZCByZWd1bGFyIGZpbGVzCgpTYW1lIGlz
c3VlIOKAlCBubyBjb21taXQgYm9keS4gRGVzY3JpYmUgd2hhdCBrZXJuZWwgZmVhdHVyZSBpcyB1
bmRlcgp0ZXN0IChwcm90ZWN0ZWRfcmVndWxhci9wcm90ZWN0ZWRfZmlmb3MsIGtlcm5lbCBjb21t
aXQgMzBhYmE2NjU2ZjYxKQphbmQgd2h5IGEgZGVkaWNhdGVkIHRlc3Qgd2FzIG5lZWRlZC4KCj4g
Ky8qXAo+ICsgKiBWZXJpZnkgZGlzYWxsb3dzIG9wZW4gb2YgRklGT3Mgb3IgcmVndWxhciBmaWxl
cyBub3Qgb3duZWQgYnkgdGhlIHVzZXIgaW4gd29ybGQKPiArICogd3JpdGFibGUgc3RpY2t5IGRp
cmVjdG9yaWVzCj4gKyAqLwoKSW5jb21wbGV0ZS4gVGhlIHRlc3QgYWxzbyB2ZXJpZmllcyB0aGUg
cG9zaXRpdmUgY2FzZSAocHJvdGVjdGlvbj0wCmFsbG93cyBhY2Nlc3MpIGFuZCBsZXZlbCAyIHBy
b3RlY3Rpb24gKGdyb3VwLXdyaXRhYmxlIHN0aWNreQpkaXJlY3RvcmllcyB2aWEgU0FGRV9DSE1P
RChESVIsIDAwMjB8U19JU1ZUWCkpLiBVcGRhdGUgdGhlIGRvYwpjb21tZW50IHRvIGNvdmVyIGFs
bCB0aHJlZSBzY2VuYXJpb3MuCgotLS0KTm90ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJl
dmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxsIHJldmlldyBjYW4gYmUKZm91bmQgYXQ6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwLWFnZW50L2FjdGlvbnMvcnVucy8y
NDQ0MjY2MTYwNwoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2
ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBp
c3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9y
ZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
