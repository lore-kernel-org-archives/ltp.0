Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D99FC61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:12:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D29783E2FC8
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:12:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59D4A3D8567
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:12:24 +0200 (CEST)
Received: from mta0.migadu.com (out-73.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ADACB600A70
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:12:23 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=ROw9RFiWeHOx+vfxQgR94iXMAMCq8apmkF4mlzidl3s=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787908342; v=1; x=1788513142;
 b=YPR4XjwLjhP1d9bTThblEbingSCngHg35+CDH7CxOmwL3WRZWdA3CjEFG/5MfN96Y3YK6GMr
 zLsxhhL0z3s8MKCMFJhMmfY15aVYt3CrkCEGG3eCep8DTkNJ0jqZ4Ez1uXzALj0ZUENU431rIQr
 29XxqWlFgQyQ5i1KxzjZaHPg=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 45d2dcf97aa55110;
 Fri, 28 Aug 2026 09:12:22 +0000
X-Mizu-Trace-ID: 45d2dcf97aa55110
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 17:12:14 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <apFQ7jIcG2CJzrd0@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <apFOTreIdNbi2U72@linux.dev>
 <6a914eb4.cfcabfe1.269b6.bc9c@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a914eb4.cfcabfe1.269b6.bc9c@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon04: Add test for discard flags
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMjgsIDIwMjYgYXQgMDk6MDI6NDNBTSArMDAwMCwgQW5kcmVhIENlcnZlc2F0
byB3cm90ZToKPiA+IEdyZWF0LCB0aGlzIHdvcmtzIQo+ID4gCj4gPiBJIHRoaW5rIHRoZSBmc3lu
YyBhZnRlciB0c3RfZmlsbF9maWxlKCkgZW5zdXJlcyBhbGwgYWxsb2NhdGVkIGJsb2NrcyBhcmUK
PiA+IGZsdXNoZWQgdG8gZGlzaywgc28gc3RhdCgpIHJlZmxlY3RzIHRoZSByZWFsIGJsb2NrIGNv
dW50Lgo+ID4gCj4gPiBGZWVsIGZyZWUgdG8gYWRkIG15IFJCVCB3aXRoIHRoaXMgY2hhbmdlIGFw
cGxpZWQ6Cj4gPiAKPiA+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaS53YW5nQGxpbnV4LmRldj4K
PiAKPiB0aGVyZSB3ZSBhcmUgOi0pIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHdpdGggdGhlIFIt
QiB0YWdzCgpIbW0sIEkgdGhvdWdodCBhYm91dCBpdCBhZ2Fpbi4gUGVyaGFwcyB3ZSBkb24ndCBu
ZWVkIHRoaXMgY2hhbmdlLgoKQ29tcGFyaW5nIHRoZSByZXN1bHRzIG9uIDYuMTIgYW5kIDUuMTQg
a2VybmVscywgb25seSA2LjYgbmVlZHMgdGhlIHN5bmMoKS4KCklmIHRoZSBzd2FwIGZpbGUgY29u
dGFpbnMgZGVsYWxsb2MgYmxvY2tzLCB0aGUga2VybmVsIHNob3VsZCBmbHVzaAp0aGVtIHRvIGRp
c2sgZmlyc3QsIHRoZW4gcGVyZm9ybSB0aGUgZGlzY2FyZC4KCklmIHRoZSBrZXJuZWwgaW5zdGVh
ZCBkaXNjYXJkcyAibm9uZXhpc3RlbnQgYmxvY2tzIiBkaXJlY3RseSDigJQgbWFraW5nCnRoZSBk
aXNjYXJkIGluZWZmZWN0aXZlIOKAlCB0aGF0IGNvdWxkIGJlIGNvbnNpZGVyZWQgYSBtaW5vciBi
dWcsIHRob3VnaAp0aGUgaW1wYWN0IGlzIGxpbWl0ZWQuCgotLSAKUmVnYXJkcywKTGkgV2FuZwoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
