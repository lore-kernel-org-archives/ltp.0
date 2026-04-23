Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FD2FAD3E7
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 02:38:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99D8E3E53C0
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 04:38:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37AD53E28DF
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:37:56 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 91B4F1400189
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 04:37:56 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8ef0ba61d46so242309485a.2
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 19:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776911875; x=1777516675; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7WkJk+N34mwF7k2DxKDUToUvBmmYhrtO/7hV+0itRs=;
 b=U2QRt+FLG7Zsal4HNDsTD+s1b138y4DF6WyLlwxsrnCzDs+DD7YSqSz4saSz8AOcA/
 4+m2rclCoIeJ0+afYtlVK/kzihRe1pK+IHyoQHwGZvX71FCrXm3V44dDMEuHvgGXNh1P
 E4Gqi1zpps8bNz8IqxdR3dMUyhdUS8X5z1pmZT4E/sd9cexX2tbSFy9O0zSVhQbHy6ZF
 LBpQ9j/BzQyVDgKvhFrxwq3+TSJbKgvTTSXgZjEApltLbr3k36X4e8TqZCXd0NWQdUMS
 G2d8/B9kv7A5sw2Z0d3uiGSA2tzh8QbKsw+lxOL7CsBnCxl/mzEfnNN+F7BZWFoKErH+
 ygPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911875; x=1777516675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p7WkJk+N34mwF7k2DxKDUToUvBmmYhrtO/7hV+0itRs=;
 b=NbtUKXxUveDSTrgtB1/VCQDkeoOBPdeFxuiHjY7w/aqoRsKcTfFNfq1LXB0N1oXsmt
 5nndjUQ9ZngcMeBZ1jX0OTNM6lmCbAZX+2lM1UloyCor/5Z5tFaOCE7NAD21RwQao/B+
 oZQwtj11CPTkg3PxRZyMi5upg0LFgolJ4+3kPan89a/k1Hq9zocwuaFoR6SFopb2KTpu
 /S8U5+jIhGaGalm0gulHhdOiwkMhq9gdYirNojEQK1gxfcppmOG6l6n+HEWkA0JumjMi
 INxoQAeI5O+YCoRsvQT5lhMF1zYDR2yf8sh0CXV70rXGlZ7TP0Mysv8jeiRBphiYhHsx
 3eQA==
X-Gm-Message-State: AOJu0YxgK62T4ucGus90GemCt1EP+n1muOKHLM3DW6TYmpQ3KDCSX2Vg
 DnvQD4BLI1e/qIz4Dlj4UXcdghnTls5sWr6oYFV6PZekubOkuS3/q4pM
X-Gm-Gg: AeBDievEl9OzJaRIsE9gta8DqN5vLU5d50Ejer4wFfOlcg4T7R2sPQze7L1jY6CVyIG
 CjiCcbVxrf1nrOZU8QgJNFY8evZNPaW7oCAt3Z3fc6puaSUac8GZOHFaVA3d4dKzos7nIFqiI/9
 xnXmyGQIDCr4FsXQSwHyk8mRzszujQzhnfQOFALHQIx9wXrAldq3MAtiOhDOIPGzHqKzPnB6WZu
 9pLf7ANvctRwV9qkbVUSSMqc8G+WuWKd2HJgnl6Unbm71XepRTJbrrTziXcX51muZUMBLRivLon
 FUGcBfWY0PtFlvXueFRytcdjJF5pZbqJP1uGxWqr3S+7ubpXtsRQ3z6wTHEjw06QzeJugrz5XEN
 rdBXS0d2SdFV6v4sIiiBTd7NwAH07Z6yrmFYqfRA+vf/rnN8PpaAP6UH7k3TXrTAC3lGect3FwM
 c4wMbYQnvG6vCLD2AJafv5jK30RwaepGlAMGkawQNjFeQP6piLE3MlySkbkOS/Z+2tzEvxdmJHY
 cdcKwc4ze+OSv/9M5BKFEVPjRlaGfCTw1+QddYQVdMwrliR+8Fn
X-Received: by 2002:a05:620a:471e:b0:8ee:f43a:bb6b with SMTP id
 af79cd13be357-8eef44a040dmr1263108885a.10.1776911875334; 
 Wed, 22 Apr 2026 19:37:55 -0700 (PDT)
Received: from
 runnervmeorf1.sbo4f4120sjejcpudlippbucbf.ex.internal.cloudapp.net
 ([135.232.208.129]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ed54eb91a0sm779022085a.47.2026.04.22.19.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 19:37:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 23 Apr 2026 02:37:53 +0000
Message-ID: <20260423023753.3925-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423023141.28151-1-wegao@suse.com>
References: <20260423023141.28151-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: icmp_rate_limit: set icmp_msgs_burst within network
 namespace
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgV2VpLAoKT24gMjAyNi0wNC0yMywgV2VpIEdhbyB3cm90ZToKPiBjdmU6IGljbXBfcmF0ZV9s
aW1pdDogc2V0IGljbXBfbXNnc19idXJzdCB3aXRoaW4gbmV0d29yayBuYW1lc3BhY2UKCj4gIAlj
aGlsZG5zID0gU0FGRV9PUEVOKCIvcHJvYy9zZWxmL25zL25ldCIsIE9fUkRPTkxZKTsKPiAgCj4g
KwlTQUZFX0ZJTEVfUFJJTlRGKCIvcHJvYy9zeXMvbmV0L2lwdjQvaWNtcF9tc2dzX2J1cnN0Iiwg
IjUwIik7CgpDb3JyZWN0IGZpeC4gVGhlIHNhdmVfcmVzdG9yZSBlbnRyeSB3YXMgd3JpdGluZyB0
byB0aGUgaW5pdGlhbCBuYW1lc3BhY2UKYmVmb3JlIENMT05FX05FV05FVCwgbWFraW5nIGl0IGlu
ZWZmZWN0aXZlIGluc2lkZSB0aGUgY2hpbGQgbmFtZXNwYWNlIHdoZXJlCnRoZSB0ZXN0IGFjdHVh
bGx5IHJ1bnMuCgo+IC0JCXsiL3Byb2Mvc3lzL25ldC9pcHY0L2ljbXBfbXNnc19idXJzdCIsICI1
MCIsIFRTVF9TUl9UQlJPS30sCgpObyBleHBsaWNpdCByZXN0b3JlIG5lZWRlZCDigJQgdGhlIHN5
c2N0bCBsaXZlcyBpbiB0aGUgY2hpbGQgbmFtZXNwYWNlLCB3aGljaAppcyBkZXN0cm95ZWQgd2hl
biB0aGUgdGVzdCBleGl0cy4KClJldmlld2VkLWJ5OiBMVFAgQUkgUmV2aWV3ZXIgPGx0cC1haUBu
b3JlcGx5LmdpdGh1Yi5jb20+CgotLS0KTm90ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJl
dmlldyBvZiB0aGUgcGF0Y2guCgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNl
IHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlv
dSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwg
b3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
