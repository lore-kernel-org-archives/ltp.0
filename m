Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D90C433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 13:33:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE616109F
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 13:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CE616109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52F303C93B2
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 15:33:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97F023C8D61
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:33:24 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 89ABD10013A6
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:33:23 +0200 (CEST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 227E040263
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1631194400;
 bh=ga4D/K+Dsv65rPlBlypmiyuTLBJRcvlRfX2W5lY5S9A=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=O5g1vB4yR3QtqJtSoRpZy1htt9LX4ZbxaEEqxXchtN3cH9g4TCGCsET8ZJseEvCbv
 WA+nC7C3GWS4FBPB05K3GSpKdmRiu+maGWh/JM7N9bwQcdxo4gziBGbBIQYqph4Cad
 S+edk7GS51r425fkW0RENEiIcuqcUbc5EHUiiMXbwirJKxPyEWZjC9OVT3cUvDE5qo
 yfxLcI+r64rNBnNBj1eH9xA0CaPc69jsoUO7ZfkpPcnlJOVhKc/REQXISee6fg3gvv
 UItKiu6HPRGHQlJtWZOS7/LyjK96gu7Hsd+ZtOyzqm6LLoklSy8J73L1rTxmP1EbsS
 h5UTrbe4/d+aw==
Received: by mail-wr1-f69.google.com with SMTP id
 p18-20020a5d4e12000000b0015940dc586aso511982wrt.6
 for <ltp@lists.linux.it>; Thu, 09 Sep 2021 06:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ga4D/K+Dsv65rPlBlypmiyuTLBJRcvlRfX2W5lY5S9A=;
 b=U8Z7H84pfCKkbyGawhU1E/FYukxbCaMUZpH10wpe3kzPaouhvVfkKXo8qXO+o8DDcP
 3ZWwdbbs13/0NdMchmx34Yk9Lma4HN4EKAykLSXUYvDwyM5PhNja4go4q7N47NQFMQx5
 2BIXP7rWnbopkyLs1XGwxf1ioPnVD94u/Eo7iJKml8f8u8InjHYl7wKHbj3TuXVryDVm
 oUAVD5gydKEtW1FdD40kT6oreUhFI2u7QMgcZfUZH9GIWIUrKGRrjQyJKq+x3jkIlk7y
 WY6Z3st4O4IYlCWONefRSFKFc0yCFTGxhdtNKJ+YUduDJWe/+2vAo0CwCcMLC43pewmo
 igWA==
X-Gm-Message-State: AOAM532gPH8F1NslntAwYiKW96NowFFrLooCvdix8a1t2yqCe7fNWbZD
 A8+8vG5BDn703C2HVI3srBw2vkWPlhWGMX98RXV07R1yvmVA4Lq3etteKVJt/OIPSpQw7Lngril
 IXp64BIGrhf/XIBntztt3GZNurMCU
X-Received: by 2002:a5d:4647:: with SMTP id j7mr3660185wrs.149.1631194399345; 
 Thu, 09 Sep 2021 06:33:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyr5DM0vRNQHCj08WMvbp8hGiC31PBMMvUEcNWJs0OwGqIVty3JXX8+63W9XOmwY2IR92xsiw==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr3660149wrs.149.1631194399082; 
 Thu, 09 Sep 2021 06:33:19 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.31])
 by smtp.gmail.com with ESMTPSA id 129sm1605577wmz.26.2021.09.09.06.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 06:33:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: ltp@lists.linux.it
Date: Thu,  9 Sep 2021 15:33:14 +0200
Message-ID: <20210909133314.30997-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] controllers: detect previous test failure on
 cgroup mounts
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210909133314.evGCJHveiCHme6KHwawEoKCBO6UL3kd14MI4maHdvJU@z>

VGhlIGZhaWx1cmUgb2YgbWVtY2dfc3RyZXNzX3Rlc3Quc2ggY2xlYW51cCB3ZW50IHVubm90aWNl
ZCAoZXhjZXB0CmVjaG8gbWVzc2FnZSkgYW5kIGNhdXNlZCBmdXJ0aGVyIGNncm91cF9maiBhbmQg
bWVtY2dfY29udHJvbF90ZXN0CmZhaWx1cmVzIGJlY2F1c2Ugb2YgdW5jbGVhbiBjZ3JvdXBzLiBG
bG93IGlzIHVzdWFsbHkgbGlrZToKCjEuIG1lbWNnX3N0cmVzc190ZXN0IHN1Y2NlZWRzIGJ1dCBh
Y3R1YWxseSB0aGUgL2Rldi9tZW1jZyB3YXMgbm90CiAgIGNsZWFuZWQgdXAuIE5vdGljZSBsYWNr
IG9mIGFueSBlcnJvciBtZXNzYWdlIGR1ZSB0byAyPi9kZXYvbnVsbC4KCiAgICAgbWVtY2dfc3Ry
ZXNzX3Rlc3QgMSBUSU5GTzogVGVzdGluZyAxNTAgY2dyb3VwcywgdXNpbmcgMTI3MyBNQiwgaW50
ZXJ2YWwgNQogICAgIG1lbWNnX3N0cmVzc190ZXN0IDEgVElORk86IFN0YXJ0aW5nIGNncm91cHMK
ICAgICBtZW1jZ19zdHJlc3NfdGVzdCAxIFRJTkZPOiBUZXN0aW5nIGNncm91cHMgZm9yIDkwMHMK
ICAgICBtZW1jZ19zdHJlc3NfdGVzdCAxIFRJTkZPOiBLaWxsaW5nIGdyb3VwcwogICAgIHRhZz1t
ZW1jZ19zdHJlc3Mgc3RpbWU9MTYyNjc3MDc4NyBkdXI9OTAzIGV4aXQ9ZXhpdGVkIHN0YXQ9MiBj
b3JlPW5vIGN1PTE5IGNzPTEyCgoyLiBtZW1jZ19jb250cm9sX3Rlc3QgaGFzIGZhbHNlLXBvc2l0
aXZlLiBJdCBzdWNjZWVkcyBidXQgYWN0dWFsbHkgbm8KICAgdGVzdCB3YXMgZG9uZSBkdWUgdG8g
L2Rldi9tZW1jZyBwb2xsdXRpb24gZnJvbSBwcmV2aW91cyB0ZXN0OgoKICAgICBta2RpcjogY2Fu
bm90IGNyZWF0ZSBkaXJlY3Rvcnkg4oCYL3RtcC9sdHAtcThEalNoUEplQi9tbnQvMeKAmTogRmls
ZSBleGlzdHMKICAgICBtZW1jZ19jb250cm9sICAgIDAgIFRJTkZPICA6ICBUZXN0ICMxOiBDaGVj
a2luZyBpZiB0aGUgbWVtb3J5IHVzYWdlIGxpbWl0IGltcG9zZWQgYnkgdGhlIHRvcG1vc3QgZ3Jv
dXAgaXMgZW5mb3JjZWQKICAgICBzaDogZWNobzogSS9PIGVycm9yCiAgICAgL29wdC9sdHAvdGVz
dGNhc2VzL2Jpbi9tZW1jZ19jb250cm9sX3Rlc3Quc2g6IDg2OiAvb3B0L2x0cC90ZXN0Y2FzZXMv
YmluL21lbWNnX2NvbnRyb2xfdGVzdC5zaDogY2Fubm90IGNyZWF0ZSAvdG1wL2x0cC1xOERqU2hQ
SmVCL21udC8xL21lbW9yeS5tZW1zdy5saW1pdF9pbl9ieXRlczoKICAgICBQZXJtaXNzaW9uIGRl
bmllZAogICAgIHJtZGlyOiBmYWlsZWQgdG8gcmVtb3ZlICdzdWInOiBEZXZpY2Ugb3IgcmVzb3Vy
Y2UgYnVzeQogICAgIHJtZGlyOiBmYWlsZWQgdG8gcmVtb3ZlICcvdG1wL2x0cC1xOERqU2hQSmVC
L21udC8xJzogRGV2aWNlIG9yIHJlc291cmNlIGJ1c3kKICAgICBtZW1jZ19jb250cm9sICAgIDEg
IFRQQVNTICA6ICBtZW1jZ19jb250cm9sOiBwYXNzZWQKICAgICB0YWc9bWVtY2dfY29udHJvbCBz
dGltZT0xNjI2NzcxNjk1IGR1cj02IGV4aXQ9ZXhpdGVkIHN0YXQ9MCBjb3JlPW5vIGN1PTIgY3M9
MQoKMy4gY2dyb3VwX2ZqX2Z1bmN0aW9uMl9tZW1vcnkgZmFpbHMgd2l0aCBhIGNyeXB0aWMgbWVz
c2FnZSBvZiBtb3VudGluZyBhCiAgIHBhdGggd2l0aCBuZXcgbGluZSAoYmVjYXVzZSAvZGV2L21l
bWNnIHdhcyBub3QgY2xlYW5lZCB1cCBiZWZvcmUpOgoKICAgICBjZ3JvdXBfZmpfZnVuY3Rpb24y
X21lbW9yeSAxIFRJTkZPOiBTdWJzeXN0ZW0gbWVtb3J5IGlzIG1vdW50ZWQgYXQgL3N5cy9mcy9j
Z3JvdXAvbWVtb3J5CiAgICAgL2Rldi9tZW1jZwogICAgIG1rZGlyOiBjYW5ub3QgY3JlYXRlIGRp
cmVjdG9yeSDigJgvc3lzL2ZzL2Nncm91cC9tZW1vcnnigJk6IEZpbGUgZXhpc3RzCiAgICAgY2dy
b3VwX2ZqX2Z1bmN0aW9uMl9tZW1vcnkgMSBUQlJPSzogbWtkaXIgL3N5cy9mcy9jZ3JvdXAvbWVt
b3J5CiAgICAgL2Rldi9tZW1jZy9sdHAgZmFpbGVkCiAgICAgY2dyb3VwX2ZqX2Z1bmN0aW9uMl9t
ZW1vcnkgMSBUSU5GTzogUmVtb3ZpbmcgYWxsIGx0cCBzdWJncm91cHMuLi4KICAgICBmaW5kOiDi
gJgvc3lzL2ZzL2Nncm91cC9tZW1vcnlcbi9kZXYvbWVtY2cvbHRwL+KAmTogTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeQoKVGhlIGFjdHVhbCBmYWlsdXJlIHdhcyBpbiBtZW1jZ19zdHJlc3NfdGVz
dCBleGVjdXRlZCBiZWZvcmUgb3RoZXIgdGVzdHMsCmhvd2V2ZXIgaXQgd2VudCB1bm5vdGljZWQu
ICBEZWJ1Z2dpbmcgc3VjaCBmYWlsdXJlcyBpcyBkaWZmaWN1bHQgYXMKcmVzdWx0IG9mIGZhaWxp
bmcgdGVzdCBkZXBlbmRzIG9uIHJ1bm5pbmcgYW5vdGhlciB3aGljaCBkaWQgbm90IHJlcG9ydCBh
CmZhaWx1cmUuICBJbnN0ZWFkLCBkZXRlY3QgdW5jbGVhbiBjZ3JvdXBzIG1vdW50cyBhbmQgZXhw
bGljaXRseSB0ZXN0IGl0LgoKU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
eXN6dG9mLmtvemxvd3NraUBjYW5vbmljYWwuY29tPgoKLS0tCgpDaGFuZ2VzIHNpbmNlIHYxOgox
LiBEbyBub3QgbW9kaWZ5IGNvbnRyb2wvbWVtY2dfY29udHJvbF90ZXN0LnNoIGFzIGl0IGRvZXMg
bm90IHNlZW0KICAgcmVhZHkuCi0tLQogLi4uL2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXBfZmov
Y2dyb3VwX2ZqX2NvbW1vbi5zaCAgICAgIHwgNCArKy0tCiAuLi4va2VybmVsL2NvbnRyb2xsZXJz
L21lbWNnL3N0cmVzcy9tZW1jZ19zdHJlc3NfdGVzdC5zaCAgfCA4ICsrKystLS0tCiAyIGZpbGVz
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2Nncm91cF9mai9jZ3JvdXBfZmpfY29tbW9uLnNo
IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXBfZmovY2dyb3VwX2ZqX2NvbW1v
bi5zaAppbmRleCA1NTk0ZmU5ZGU0MjYuLjUzYWI2MzdlODkxMCAxMDA3NTUKLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9jb250cm9sbGVycy9jZ3JvdXBfZmovY2dyb3VwX2ZqX2NvbW1vbi5zaAorKysg
Yi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2Nncm91cF9mai9jZ3JvdXBfZmpfY29tbW9u
LnNoCkBAIC0xMjMsMTAgKzEyMywxMCBAQCBjbGVhbnVwKCkKICAgICBmaQogCiAgICAgaWYgZ3Jl
cCAtcSAiJG1vdW50X3BvaW50IiAvcHJvYy9tb3VudHM7IHRoZW4KLSAgICAgICAgdW1vdW50ICIk
bW91bnRfcG9pbnQiCisgICAgICAgIEVYUEVDVF9QQVNTIHVtb3VudCAiJG1vdW50X3BvaW50Igog
ICAgIGZpCiAKICAgICBpZiBbIC1lICIkbW91bnRfcG9pbnQiIF07IHRoZW4KLSAgICAgICAgcm1k
aXIgIiRtb3VudF9wb2ludCIKKyAgICAgICAgRVhQRUNUX1BBU1Mgcm1kaXIgIiRtb3VudF9wb2lu
dCIKICAgICBmaQogfQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9t
ZW1jZy9zdHJlc3MvbWVtY2dfc3RyZXNzX3Rlc3Quc2ggYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRy
b2xsZXJzL21lbWNnL3N0cmVzcy9tZW1jZ19zdHJlc3NfdGVzdC5zaAppbmRleCBjMjUwMWUxNjQw
MTguLjhmN2EwZWI5ZGMzNyAxMDA3NTUKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVy
cy9tZW1jZy9zdHJlc3MvbWVtY2dfc3RyZXNzX3Rlc3Quc2gKKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9jb250cm9sbGVycy9tZW1jZy9zdHJlc3MvbWVtY2dfc3RyZXNzX3Rlc3Quc2gKQEAgLTQ0LDgg
KzQ0LDggQEAgc2V0dXAoKQogY2xlYW51cCgpCiB7CiAJaWYgWyAtZSAvZGV2L21lbWNnIF07IHRo
ZW4KLQkJdW1vdW50IC9kZXYvbWVtY2cgMj4gL2Rldi9udWxsCi0JCXJtZGlyIC9kZXYvbWVtY2cg
Mj4gL2Rldi9udWxsCisJCUVYUEVDVF9QQVNTIHVtb3VudCAvZGV2L21lbWNnCisJCUVYUEVDVF9Q
QVNTIHJtZGlyIC9kZXYvbWVtY2cKIAlmaQogfQogCkBAIC01Myw4ICs1Myw4IEBAIGRvX21vdW50
KCkKIHsKIAljbGVhbnVwCiAKLQlta2RpciAvZGV2L21lbWNnIDI+IC9kZXYvbnVsbAotCW1vdW50
IC10IGNncm91cCAtb21lbW9yeSBtZW1jZyAvZGV2L21lbWNnCisJRVhQRUNUX1BBU1MgbWtkaXIg
L2Rldi9tZW1jZworCUVYUEVDVF9QQVNTIG1vdW50IC10IGNncm91cCAtb21lbW9yeSBtZW1jZyAv
ZGV2L21lbWNnCiB9CiAKICMgJDEgTnVtYmVyIG9mIGNncm91cHMKLS0gCjIuMzAuMgoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
