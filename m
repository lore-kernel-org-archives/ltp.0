Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E46606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UFOqKj+I
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECB103CFE52
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 03:56:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 055253CFD25
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 03:56:19 +0200 (CEST)
Received: from mta1.migadu.com (out-209.mta1.migadu.com
 [IPv6:2001:41d0:203:375::d1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C9AC100048B
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 03:56:17 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=44z+8I6eWPlyZ4J/Gd/j9z6IbCF936FP7LLIYqJlD/I=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792634177; v=1; x=1793238977;
 b=UFOqKj+Ik82ZoocEPPh4FcbIwrkTdw6gWJrF9PqoonNUVQxN2BuywD/BwpcHVest/mX+Fz5F
 umXkduYmwQr1zNEtHCxprTMnNtVNCU8QAeYLHl2vaD8u5uQ8sz4300FOVZs11mj9ONw4cVRFIit
 7obH7sJd2KdBwHB5Lrc/puTI=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id d63d590b52bebf2f;
 Thu, 22 Oct 2026 01:56:16 +0000
X-Mizu-Trace-ID: d63d590b52bebf2f
X-Migadu-Flow: FLOW_OUT
Date: Thu, 22 Oct 2026 09:56:09 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <atltORji4cZMrRs3@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 LTP List <ltp@lists.linux.it>
References: <as2dZ8VBuN2NM3TZ@linux.dev>
 <4EkJ88xMyWBqTKeQ8KRctlqrIv8JfY4VYo5D@localhost.localdomain>
 <athrEiFc8i3Tf-3G@yuki.lan> <20261021120751.GA265579@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021120751.GA265579@pevik>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiA+IEhpIQo+ID4gPiA+ID4gd2hhdCBhYm91dCBzY2hlZHVsaW5nIGEgbmV3IExUUCBtZWV0aW5n
IGFmdGVyIHRoZSByZWxlYXNlPwo+ID4gPiA+ID4gV2hlbidzIHlvdXIgZmlyc3QgYXZhaWxhYmxl
IGRhdGU/Cj4gCj4gPiA+ID4gU291bmRzIGdvb2QuCj4gCj4gPiA+ID4gTXkgYXZhaWxhYmlsaXR5
IGlzIG9uIHdlZWtkYXlzLCA04oCTNiBQTSBCZWlqaW5nIHRpbWUgKFVUQys4KSwgd2hpY2gKPiA+
ID4gPiBzaG91bGQgYmUgOeKAkzExIEFNIENFVC4gCj4gCj4gQExpIGRvIHlvdSBoYXZlIHRpbWUg
b25seSBvbiB3ZWVrZW5kcz8gSSdtIHF1aXRlIGJ1c3kgb24gd2Vla2VuZHMgYWxyZWFkeS4KCk5v
LCBJIG1lYW50IE1vbmRheSB0byBGcmlkYXksIG5vdCB3ZWVrZW5kcy4gOikKCj4gCj4gPiA+ID4g
SXQgbWlnaHQgYmUgYmV0dGVyIHRvIHNoYXJlIGFuIGFnZW5kYSBvciBkaXNjdXNzIHRoZSB0b3Bp
Y3MgYmVmb3JlaGFuZC4KPiAKPiA+ID4gc29ycnkgZm9yIG15IGRlbGF5LCBjcmF6eSB0aW1lcy4K
PiAKPiA+ID4gSSB3b3VsZCBsaWtlIHRvIGhhdmUgYSBMVFAgbWVldGluZywgaWYgeW91IHdhbnQg
d2UgY2FuIGRvIGl0IGF0IDEwYW0gdGhlIG5leHQKPiA+ID4gd2VlayBpZiB3ZWRuZXNkYXkgYXJl
IHRoZSBvbmx5IG9wdGlvbi4KPiAKPiA+ID4gQFBldHIgQEN5cmlsIFdEWVQ/Cj4gCj4gPiBXZWRu
ZXNkYXkgMjguIE9jdCBpcyBiYW5rIGhvbGxpZGF5IGluIEN6ZWNoIHJlcHVibGljLCBhbiBpbmRl
cGVuZGVuY2UgZGF5Lgo+IAo+ICsxCj4gCj4gSWYgaXQgbmVlZHMgdG8gYmUgV2VkbmVzZGF5LCB0
aGVuIG5leHQgb25lIDR0aCBPY3QgZnJvbSAxMCB3b3VsZCB3b3JrIGZvciBtZS4KCkkgZ3Vlc3Mg
eW91IG1lYW4gNHRoIE5vdi4gT2YgY291cnNlLCB0aGF0J3MgZmluZSB3aXRoIG1lLgoKPiBPciB3
ZSBjYW4gdHJ5IHRvIGZpbmQgYW5vdGhlciBkYXkgbmV4dCB3ZWVrICgyNnRoLTMwdGggU2VwKSwg
ZS5nLiBUdWUgMjd0aCBmcm9tCj4gMTEuMDAgYW0gd291bGQgd29yayBmb3IgbWUgKG1lZXRpbmcg
ZnJvbSAxMS4wMCBzaGlmdGVkIHRvIDEwLjAwKS4KCkkgdm90ZSB0byAxMGFtIENFVC4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
