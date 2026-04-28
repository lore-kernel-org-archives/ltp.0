Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B6DFF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:44:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7CF93E49FB
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 16:44:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34AEB3C66CA
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:44:21 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 79038600350
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:44:20 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8a3342d301aso111346526d6.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777387459; x=1777992259; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBqeDaQfRj6Ez/XFff7uZLqqqCbzFLjmt/cgm4UQs+M=;
 b=J6YsXzUfjgbw7AnXXwL6zRXBYDMfZO8NRg/RDupk+LsgZD7haLRsy0xexelh2+jFuU
 xIF1aUm/CIFdQ2wAmNO9gKoeV4BQeybPNHFaYe9XYSnwtVLCE771JxWBSnMaV4aNb65c
 viIOcSIFJXB4PInX5g87QMaUYwmLrOf8x0L2mj7PWM9D2yuJu3FliTK3/wCpPy6L8mK2
 t+LXeVSr0aKm3fcdoOFVShnGmeKphDPtICJ5wdS7xk0AuU1nr3ONemtIFUgZO/CBqt7T
 KoT2zMnvEzju7SZEGY0gj0b1J+Ecu6ie13wYwdxNx+OIKKWUaNw1OUNAw5LA6xDX8YKf
 pFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777387459; x=1777992259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tBqeDaQfRj6Ez/XFff7uZLqqqCbzFLjmt/cgm4UQs+M=;
 b=EcdP6v/4Kqvoa0Sd/xzkk3753af150hcTB0VFDREsHgCxKngAIbWXd8NSFc64izKM2
 EBFANTJM+UszCl9F6F3P4H15s4PnR8MMCAk2ChpCcgovRGEnxP62MG1zIPACPrNegrSM
 2P6iSEKBRnmNU0bn0JseZTzRVf7XAWkoz9Pe0bYjJOsFlUW0bvDjjCvO6ehSZS47dobU
 Alw7tTlWak8E1jCfrZfblL8Aa7IAiYHzTPerUfbldrqndyrlwXROYK1UkXyXrSpw7E7i
 3d7IAQpX5RsomKUBi9G+xofFPYMaGK0NAfYwyksS8vZTPthPjIYt12vr8P7iukIQxVW1
 dJiA==
X-Gm-Message-State: AOJu0YxNBFGtqSm6pG/UOXL0VksTfYzgQGgC48wp2ta/UWwQVIdOMA0G
 r/Ru2GLpdIldLSxrwr0kVW3yPe6uSNfP3p229eZhB5R7xtPogmYNvEPY
X-Gm-Gg: AeBDietkzNdzv0kfj38jf+uNBA/UgB24Ojd2j6SWaEmuiYYXFOzQJfXSa9zSKiKFXI2
 JQP0yeJ8MbQOgNgtsw+P6UzGRqul0ezuj7BeTS2ll3D1fwL/XvAF6oGRJKOtWpSYrW8GPyrr8+v
 xFc4o/hkBS6lWhEVAvHeRGmSQ3ha4kr2ECNXBANFLG+g4avk8YZmlAfpG1rxCYXmv4n/7xBKtMu
 DdA8qFqyJAFZcjRwAe+mUv9f92kpTOEnuqnAU1Avm4WQcPhizs/GECrz0yI0ZrotBEYOYajQuIL
 J0+Y7NY5+zIFPmF7UCN/hkntP0iNJPM/W66rHd1pme2CZngBtEka7UKU2zSmsbfzOmtpPdm3XgL
 7kEK0dLfYbGm4f7jmea5ghG9GRCGnB5ycs1HwmDCyHyaSt02R8HbIiZWWZiKO8lKBMOGNnva/d5
 yI5ocQ5I70eTi+AfE4ewaSgodyJ51bUyZbpdWqZcugoBiSW4AH/+hfFS3PA4N5uebKK00BBPrHe
 T/ZJkOg67go5o3wCkWXN53pcv+AsBUgd57cwazPM9PhNhmwoO8=
X-Received: by 2002:ad4:5bc2:0:b0:8b1:f2b7:cfb3 with SMTP id
 6a1803df08f44-8b3e2fff731mr51703756d6.20.1777387458904; 
 Tue, 28 Apr 2026 07:44:18 -0700 (PDT)
Received: from
 runnervmhkfpo.ih4hag31ne3evk1eddqqqnr0uc.cx.internal.cloudapp.net
 ([48.211.210.123]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3e2976bcbsm22296936d6.36.2026.04.28.07.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:44:18 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 28 Apr 2026 14:44:17 +0000
Message-ID: <20260428144417.4093-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428133233.28050-1-mdoucha@suse.cz>
References: <20260428133233.28050-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] aio_cancel: Fix incorrect strerror() usage
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

SGkgTWFydGluLAoKLS0tIFtQQVRDSCAxLzJdIC0tLQoKT24gMjAyNi0wNC0yOCwgTWFydGluIERv
dWNoYSB3cm90ZToKPiBhaW9fY2FuY2VsOiBGaXggaW5jb3JyZWN0IHN0cmVycm9yKCkgdXNhZ2UK
ClRoaXMgaXMgZml4aW5nIGEgcmVhbCBidWcgYnV0IGJvdGggcGF0Y2hlcyBpbiB0aGlzIHNlcmll
cyBhcmUgbWlzc2luZwpGaXhlczogdGFncy4KCi0tLSBbUEFUQ0ggMi8yXSAtLS0KCk9uIDIwMjYt
MDQtMjgsIE1hcnRpbiBEb3VjaGEgd3JvdGU6Cj4gYWlvX2NhbmNlbF82LTE6IFJld3JpdGUgdGVz
dAoKPiArCWlmIChncmV0ICE9IEFJT19DQU5DRUxFRCkgewo+ICsJCXByaW50ZihUTkFNRSAiIFVu
ZXhwZWN0ZWQgYWlvX2NhbmNlbCgpIHJldHVybiB2YWx1ZTogJXNcbiIsCj4gKwkJCXN0cmVycm9y
KGdyZXQpKTsKCnN0cmVycm9yKCkgZXhwZWN0cyBhbiBlcnJubyB2YWx1ZTsgQUlPX0NBTkNFTEVE
LCBBSU9fTk9UQ0FOQ0VMRUQsIGFuZApBSU9fQUxMRE9ORSBhcmUgbm90IGVycm5vIHZhbHVlcyAo
dGhleSBhcmUgMCwgMSwgMiBvbiBMaW51eCwgbWFwcGluZyB0bwoiU3VjY2VzcyIsICJPcGVyYXRp
b24gbm90IHBlcm1pdHRlZCIsICJObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5IikuClVzZSAiJWQi
IHRvIHByaW50IHRoZSByYXcgaW50ZWdlciBpbnN0ZWFkLgoKUHJlLWV4aXN0aW5nIGlzc3VlcyBu
b3RpY2VkIGluIHRoZSBzdXJyb3VuZGluZyBjb2RlIChub3QgaW50cm9kdWNlZApieSB0aGlzIHBh
dGNoKToKCi0gNS0xLmM6NzAsIDctMS5jOjU2IOKAlCBuYW5vc2xlZXAoKSB1c2VkIGZvciBzeW5j
aHJvbml6YXRpb24gaW4gYQogIHBvbGxpbmcgbG9vcCAoc2xlZXAtYmFzZWQgc3luYykuCgotLS0K
Tm90ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBh
Z2VudCBjYW4gc29tZXRpbWVzCnByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVu
IGl0cyBmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91CmZpbmQgaXNzdWVzIHdpdGggdGhlIHJl
dmlldywgcGxlYXNlIGNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlCnN1Z2dlc3Rpb25z
LgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
