Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778C0CA9ED0
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 02:54:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BF863EB8F4
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 04:54:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4770D3C57EB
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 04:54:40 +0200 (CEST)
Received: from mta1.migadu.com (out-128.mta1.migadu.com
 [IPv6:2001:41d0:203:375::80])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4DD8E60048F
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 04:54:39 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=eezQDD38OB5PPObdcvxpLiwfBDFscpn7hsP0SQwpKTo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791860079; v=1; x=1792464879;
 b=YZ94Xf5VizBIiRAbRZSjq/kVulxzsCs9+8sF10BvM8kxBt8hOt403R3nsEVeNaS3cAisCMjj
 DaWIuqBCcKyc/UsTdvkviul4OZRzj7ygNjdU4+yeizw8uP2are+r8R0d9gGlf5Nh/Nq5k/PJCYC
 VJtrfqUuONwyMT0P9Hc2ewZY=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id e715ad2da2d18129;
 Tue, 13 Oct 2026 02:54:38 +0000
X-Mizu-Trace-ID: e715ad2da2d18129
X-Migadu-Flow: FLOW_OUT
Date: Tue, 13 Oct 2026 10:54:31 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <as2dZ8VBuN2NM3TZ@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 LTP List <ltp@lists.linux.it>
References: <DEOxbeuZFcHpiFjVfFNUWk1P6sFdwJrbbB3T@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DEOxbeuZFcHpiFjVfFNUWk1P6sFdwJrbbB3T@localhost.localdomain>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKPiBIZWxsbyBldmVyeW9uZSwKPiAKPiB3aGF0IGFib3V0IHNjaGVkdWxpbmcg
YSBuZXcgTFRQIG1lZXRpbmcgYWZ0ZXIgdGhlIHJlbGVhc2U/Cj4gV2hlbidzIHlvdXIgZmlyc3Qg
YXZhaWxhYmxlIGRhdGU/CgpTb3VuZHMgZ29vZC4KCk15IGF2YWlsYWJpbGl0eSBpcyBvbiB3ZWVr
ZGF5cywgNOKAkzYgUE0gQmVpamluZyB0aW1lIChVVEMrOCksIHdoaWNoCnNob3VsZCBiZSA54oCT
MTEgQU0gQ0VULiAKCkl0IG1pZ2h0IGJlIGJldHRlciB0byBzaGFyZSBhbiBhZ2VuZGEgb3IgZGlz
Y3VzcyB0aGUgdG9waWNzIGJlZm9yZWhhbmQuCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
