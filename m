Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67CEFF8855
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 17:55:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38D0F3E6AD7
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 19:54:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 534FA3E6AD9
 for <ltp@lists.linux.it>; Tue,  5 May 2026 19:54:29 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EA9546008C0
 for <ltp@lists.linux.it>; Tue,  5 May 2026 19:54:28 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso7545934eec.0
 for <ltp@lists.linux.it>; Tue, 05 May 2026 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778003667; x=1778608467; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9yLcYBpOococOuJVa/BXy5Z+cea4Fy4V2ElDet5TkQ=;
 b=snBxzFVzzqx8XSJNs02uBc/S+rvvTHcJWynggZSeHimF3yW+E88ZyTory8GFo6NwaD
 +zLNLF0xI6h2wdsT11aCQqH1f2iDBhVBthdq40R6gLy7/NFYxHIaoDs1CFuhHGxtyBem
 O5cbbcSdJM0+Zhl9iFBk558auy7ZgpCi1sV9cNvDfIcdf1czYXhrU3ZrrXO5eGVOlPqp
 LkWUf23RDVo+tOPfGawQaM/IZSg/m6LAqpVBiM2wpIPGMfY86jIcs14WQOSh5DKXPnAb
 u62u5O2RWhdqAoYc9YspbqtJjIJWyfUy5oGpuw2AAT4UrxlQMxP39NSH32nnrWd05HLT
 hvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003667; x=1778608467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n9yLcYBpOococOuJVa/BXy5Z+cea4Fy4V2ElDet5TkQ=;
 b=P2hETj+c2ya1Vi+E4TEqZUIgSzGUmbgv5Ygomo5f+26ZbhbVm2JDFvDbrsVyDK8pKX
 FrthLbfkIFRiDRruMX3DkGaUGsCbv/osotwAkPmQxwSyQJVY6n35AALp/DIo7YmaD8LW
 GGWCEIspKkC9tQ4LBpzfQrm/36UaPGWG5wdBHUPNEtKRcrc+dwi5RtXeOof/QVjhOT+a
 rOg5Np4kAr+suGAVGc3LLUdLHT1eyQkCXfUw8FoaMZNYxvp8Tx3+3U8y2Wl5rY87jOmD
 MY+3fM1INDE6FxrYtc3PGfwcGeF94Q06MJ20WnJIq7/3j7yKFXjHLfUn+tHG0h2hO8si
 7+kQ==
X-Gm-Message-State: AOJu0YwwnjtTB25bGl2zo71wKT3lwd1apXVuksMvEOOtSelSlJkRER4N
 HdW0iHwLKba4DlunV3GanhaejAJfmkToDfvLK8KZfwU3KQa0w3qotbhmN/pHSLigqow=
X-Gm-Gg: AeBDiev7hev6Gm2ltI36pClt7JVWKYqQcm77w01emMitxv9tmF7HlNquRtwiOd5qrdR
 SioMZl3338CdtI6OZjXzg3bn4eftu8nzfDbo6x6zJV5cCwnDm+FOX1UCZn+AmulnA3cL1iaOyK9
 nq2ikF5P3DaUT4+HRfvb1ZSHcXDvwEQaJxEpekjKvcuL0xiB3RW+dKZJ+6yrvrkOSjltf5NtLUY
 IKReljxJeoOwJy750aI3pDPeoj0ZxEmEO5UrCzO46kun/msxO6HKQL2PPXnQvgBueHgxA3fugkq
 zojSoI8nRVvBOVIQxj1PjJOZralHYG51cqi72Kf34Cqa0I7iY1+jgpu31UjINLYiIlbTFRoV+n9
 U1q44kGFDCblEaIGcSraQj75RJenNajsRMlJ9wngvng+QcStlNlRrTB2rN9K5tPtUdzEDed3C3/
 7biQDk5p56vHwkSMXZSS3I8pnXqruxTuIe+9lVHzk1axCVkfWDgwUXwuYqboPBvPTIQ7wxJ7JN6
 kmNySuxt18FQbIcOgg77izyO0A6R+ER4XK2u5oepDUdJxcuAJsAs60uCak=
X-Received: by 2002:a05:7300:6d03:b0:2de:3022:a459 with SMTP id
 5a478bee46e88-2f549f7c266mr139107eec.21.1778003667092; 
 Tue, 05 May 2026 10:54:27 -0700 (PDT)
Received: from
 runnervmeorf1.hqvb1w5sullexdfu0h25jepama.yx.internal.cloudapp.net
 ([52.161.50.36]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889cf53sm28238909eec.5.2026.05.05.10.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:54:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Tue,  5 May 2026 17:54:25 +0000
Message-ID: <20260505175425.4002-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505083016.36843-1-li.wang@linux.dev>
References: <20260505083016.36843-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Introduce tst_path_macros.h to consolidate system
 paths
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

SGkgTGksCgpPbiBUdWUsIDUgTWF5IDIwMjYsIExpIFdhbmcgd3JvdGU6Cj4gW1BBVENIXSBsaWI6
IEludHJvZHVjZSB0c3RfcGF0aF9tYWNyb3MuaCB0byBjb25zb2xpZGF0ZSBzeXN0ZW0gcGF0aHMK
ClRoZSBzdWJqZWN0IHByZWZpeCAibGliOiIgZG9lc24ndCBtYXRjaCB0aGUgc2NvcGUg4oCUIHRo
ZSBuZXcgaGVhZGVyIGxpdmVzIGluCmluY2x1ZGUvIGFuZCB0aGUgbWlncmF0aW9uIGNvdmVycyB+
ODAgZmlsZXMgYWNyb3NzIGluY2x1ZGUvLCBsaWIvLCB0ZXN0Y2FzZXMvLAphbmQgbGlicy8uIFVz
ZSAiaW5jbHVkZToiIG9yICJ0cmVld2lkZToiIGluc3RlYWQuCgotLS0KTm90ZToKCk91ciBhZ2Vu
dCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guCgpUaGUgYWdlbnQgY2FuIHNvbWV0
aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3Mg
YXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpj
b21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxU
UCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
