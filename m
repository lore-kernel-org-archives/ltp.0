Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89093606A31A
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G1/t+LpX
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46DC23E24B2
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 05:11:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEDFC3E24B2
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 05:11:03 +0200 (CEST)
Received: from mta0.migadu.com (out-225.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::e1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B0AD31400BD3
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 05:11:01 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=qSCMECHEjltH4FHJFC2CeXiaVmng9/bjhz+qeyCgXzI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792552260; v=1; x=1793157060;
 b=G1/t+LpXVWIDJ760Y7s9Ipdww6Dr8Gzc+FHyg0vuoBDNZmiVqjj5C50nKC6U6N/V2KhagIj1
 7C39TgqhscoLORrV96dg+xgX4/+3tLJvBTxehOquUGW9NKvQHqKq7DVTBhBSdFGTQgbVO6fJrKy
 yks/Kz6KVhRiHqhEuLD/uIEk=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id a6b9e0391341fbb5;
 Wed, 21 Oct 2026 03:11:00 +0000
X-Mizu-Trace-ID: a6b9e0391341fbb5
X-Migadu-Flow: FLOW_OUT
Date: Wed, 21 Oct 2026 11:10:57 +0800
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Message-ID: <atgtQUefWKTfkTz-@linux.dev>
Mail-Followup-To: ltp@lists.linux.it,
 Xiaochen Shen <shenxiaochen@open-hieco.net>
References: <20261021025911.165250-1-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021025911.165250-1-li.wang@linux.dev>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: add a checked-attribute counter to
 sysfs assert helpers
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiAtLS0gYS9saWIvdHN0X3N5c2ZzX2Fzc2VydC5jCj4gKysrIGIvbGliL3RzdF9zeXNmc19hc3Nl
cnQuYwo+IEBAIC0xNSw2ICsxNSwxNyBAQAo+ICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiAgI2lu
Y2x1ZGUgInRzdF9zeXNmc19hc3NlcnQuaCIKPiAgCj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgdHN0
X3N5c2ZzX2NudDsKPiArCj4gK3N0YXRpYyBpbnQgc2lsZW50X2F0dHJfZXhpc3RzKGNvbnN0IGNo
YXIgKnBhdGgpCj4gK3sKPiArCWlmIChhY2Nlc3MocGF0aCwgRl9PSykpCj4gKwkJcmV0dXJuIDA7
Cj4gKwo+ICsJdHN0X3N5c2ZzX2NudCsrOwo+ICsJcmV0dXJuIDE7Cj4gK30KCkFmdGVyIHNlbmRp
bmcgb3V0IHRoZSBwYXRjaCwgSSByZWFsaXplZCB0aGF0IHRoZSBzaWxlbnRfYXR0cl9leGlzdHMo
KQpoZWxwZXIgaXNuJ3QgcmVhbGx5IG5lY2Vzc2FyeSDigJQgd2UgY2FuIGp1c3QgYWRkIHRzdF9z
eXNmc19jbnQrKyBkaXJlY3RseQppbiB0aGUgc2lsZW50IGZ1bmN0aW9ucy4KClNvIGxldCBtZSBy
ZXNlbmQgdjQuCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
