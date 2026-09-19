Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2E3C982D7
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 00:19:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13FC43E9201
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 02:19:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 044903E72AB
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 02:18:49 +0200 (CEST)
Received: from mta0.migadu.com (out-144.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6C8901401222
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 02:18:46 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=uJrl1oHmm/wBFCEIr+bEV+yySrXvRouNl2JEoJ80owc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789777125; v=1; x=1790381925;
 b=ggVUKHjNjJM2LLNL1rx2xj4TqEQ2Ui1KTlpW6b7ixjtyUhql/sr+AEYZLfQzD9rcW7c/4ypc
 SbPG/aj7/W57gWUhDDrByjX2+vP82cJllapAJqF1yiUAWRX+Feme0UsR+NFdvM+ACVHcMcTof+q
 Zfu8kDdPF/Ugu51i9FngICkU=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 0ed6d2c055805bd5;
 Sat, 19 Sep 2026 00:18:35 +0000
X-Mizu-Trace-ID: 0ed6d2c055805bd5
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
Mime-Version: 1.0 (1.0)
Date: Sat, 19 Sep 2026 08:18:22 +0800
Message-Id: <E335EF80-850D-4B05-B803-BE5C605524E5@linux.dev>
References: <20260918143911.GA1951845@pevik>
In-Reply-To: <20260918143911.GA1951845@pevik>
To: Petr Vorel <pvorel@suse.cz>
X-Mailer: iPhone Mail (24A437)
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 00/36] Improve coverage for keyctl() syscall
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

ClNlbnQgZnJvbSBteSBpUGhvbmUKCj4gT24gMTggU2VwIDIwMjYsIGF0IDIyOjM5LCBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4gCj4g77u/SGkgTGksCj4gCj4+IEZvciB0aGUg
cGF0Y2hzZXQ6Cj4gCj4+IFRlc3RlZC1ieTogTGkgV2FuZyA8bGkud2FuZ0BsaW51eC5kZXY+Cj4g
Cj4gdGhhbmtzIGZvciB5b3VyIHRlc3RpbmcgKEkgYWxzbyBkaWQgc29tZSkuCj4gCj4gSSdtIGdv
aW5nIHRvIGFwcGx5IGZpeGVzIHlvdSBzdWdnZXN0ZWQgYW5kIG1lcmdlLgo+IAo+IENhbiBJIGFk
ZCB5b3VyIFJCVCBiZWZvcmUgbWVyZ2UgKHdob2xlIHBhdGNoc2V0IG9yIHBsZWFzZSBzcGVjaWZ5
IHdoZXJlIGFkZCBvcgo+IG5vdCBhZGQpPyBPYnZpb3VzbHkgeW91IGRpZCBhIGxvdCBvZiByZXZp
ZXcgb24gdGhpcyBwYXRjaHNldC4KClN1cmUuIEFDSyBmb3IgdGhlIHdob2xlIHBhdGNoc2V0LgoK
PiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
