Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B167C00140
	for <ltp@archiver.kernel.org>; Fri, 12 Aug 2022 15:30:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BD4F3C959E
	for <ltp@archiver.kernel.org>; Fri, 12 Aug 2022 17:30:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B1AF3C02C2
 for <ltp@lists.linux.it>; Fri, 12 Aug 2022 17:30:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 04F0E1400FA5
 for <ltp@lists.linux.it>; Fri, 12 Aug 2022 17:30:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4D08205AF;
 Fri, 12 Aug 2022 15:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660318212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjWL9QGJZGX9lFjqI7k11cDNYIdzuzGoV+GsofkA668=;
 b=rof4fgZ2DhKaFvgLNDZfJ0KrmkxCW4ChoKbSI2quaKG/nWABhj7Pv5pf0q8JL7yfUXxHew
 9HggO7wizXVXrbUFsa2c2LawYakO0vmJvf0ZQ3oT+bhHsE5RLlkNXT7O2oFwHckRFkvYtf
 KJq6zh/8DshiyQyWRKoqji31cuyGjzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660318212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjWL9QGJZGX9lFjqI7k11cDNYIdzuzGoV+GsofkA668=;
 b=MsZOnlt/NOO+z5677Z64ozt5PO2qSiFxdZ2UmzQmVbqoME3hrb4kZTByHGIHA7/v6s8U5L
 bjWTDbFCFsSxzKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B8DA13305;
 Fri, 12 Aug 2022 15:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d1qHIARy9mIwYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 12 Aug 2022 15:30:12 +0000
Date: Fri, 12 Aug 2022 17:30:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YvZyAt0QGnRZMirP@pevik>
References: <20220808125025.15167-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808125025.15167-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor pidns16 test using new LTP API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKLi4uCj4gKy8qXAo+ICsgKiBbRGVzY3JpcHRpb25dCj4gKyAqCj4gKyAqIENs
b25lIGEgcHJvY2VzcyB3aXRoIENMT05FX05FV1BJRCBmbGFnIGFuZCB2ZXJpZmllcyB0aGF0IHNp
Z2luZm8tPnNpX3BpZCBpcwpZb3UgbmVlZCB0byBxdW90ZSB2YXJpYWJsZSB3aXRoICssIGkuZS4g
K3NpZ2luZm8tPnNpX3BpZCssIG90aGVyd2lzZQpmb3JtYXR0aW5nIHNob3cgc2lnaW5mb+KGknNp
X3BpZCBpbnN0ZWFkIG9mIHNpZ2luZm8tPnNpX3BpZC4KCj4gKyAqIHNldCB0byAwIGlmIHNlbmRl
ciAocGFyZW50IHByb2Nlc3MpIHNlbnQgdGhlIHNpZ25hbC4gVGhlbiBzZW5kIHNpZ25hbCBmcm9t
Cj4gKyAqIGNvbnRhaW5lciBpdHNlbGYgYW5kIGNoZWNrIGlmIHNpZ2luZm8tPnNpX3BpZCBpcyBz
ZXQgdG8gMS4KYW5kIGhlcmUgYXMgd2VsbC4KPiArICovCgo+ICAjZGVmaW5lIF9HTlVfU09VUkNF
IDEKRG8gd2UgcmVhbGx5IG5lZWQgX0dOVV9TT1VSQ0U/IFdoeT8KCi4uLgo+ICtzdGF0aWMgaW50
IGNvdW50ZXI7ClNob3VsZG4ndCB0aGlzIGJlIHZvbGF0aWxlPyBBbmQgbWF5YmUgYWxzbyBzaWdf
YXRvbWljX3QgaW5zdGVhZCBvZiBpbnQgKGV2ZW4KaXQncyB0aGUgc2FtZSk/CnN0YXRpYyB2b2xh
dGlsZSBzaWdfYXRvbWljX3QgY291bnRlcjsKCj4gLWNoYXIgKlRDSUQgPSAicGlkbnMxNiI7Cj4g
LWludCBUU1RfVE9UQUwgPSAzOwo+IC0KPiAtdm9pZCBjaGlsZF9zaWduYWxfaGFuZGxlcihpbnQg
c2lnLCBzaWdpbmZvX3QgKiBzaSwgdm9pZCAqdW51c2VkKQo+ICtzdGF0aWMgdm9pZCBjaGlsZF9z
aWduYWxfaGFuZGxlcihMVFBfQVRUUklCVVRFX1VOVVNFRCBpbnQgc2lnLCBzaWdpbmZvX3QgKnNp
LCBMVFBfQVRUUklCVVRFX1VOVVNFRCB2b2lkICp1bnVzZWQpCj4gIHsKPiAtCXN0YXRpYyBpbnQg
YyA9IDE7Cj4gLQlwaWRfdCBleHBlY3RlZF9waWQ7Cj4gLQo+IC0JLyogVmVyaWZ5aW5nIGZyb20g
d2hpY2ggcHJvY2VzcyB0aGUgc2lnbmFsIGhhbmRsZXIgaXMgc2lnbmFsbGVkICovCj4gKwlwaWRf
dCBleHBfcGlkOwoKPiAtCXN3aXRjaCAoYykgewo+IC0JY2FzZSAxOgo+IC0JCWV4cGVjdGVkX3Bp
ZCA9IFBBUkVOVF9QSUQ7Cj4gKwlzd2l0Y2ggKGNvdW50ZXIpIHsKPiArCWNhc2UgMDoKPiArCQll
eHBfcGlkID0gMDsKPiAgCQlicmVhazsKPiAtCWNhc2UgMjoKPiAtCQlleHBlY3RlZF9waWQgPSBD
SElMRF9QSUQ7Cj4gKwljYXNlIDE6Cj4gKwkJZXhwX3BpZCA9IDE7Cj4gIAkJYnJlYWs7Cj4gIAlk
ZWZhdWx0Ogo+IC0JCXRzdF9yZXNtKFRCUk9LLCAiY2hpbGQgc2hvdWxkIE5PVCBiZSBzaWduYWxs
ZWQgMysgdGltZXMiKTsKPiArCQl0c3RfYnJrKFRCUk9LLCAiQ2hpbGQgc2hvdWxkIE5PVCBiZSBz
aWduYWxsZWQgMysgdGltZXMiKTsKPiAgCQlyZXR1cm47Cj4gIAl9Cgp2ZXJ5IG5pdDogSSdkIHVz
ZSBpZiAoY291bnRlciAKaWYgKGNvdW50ZXIgPiAxKSB7Cgl0c3RfYnJrKFRCUk9LLCAiQ2hpbGQg
c2hvdWxkIE5PVCBiZSBzaWduYWxsZWQgMysgdGltZXMiKTsKCXJldHVybjsKfQpleHBfcGlkID0g
Y291bnRlcjsKCj4gKwlpZiAoc2ktPnNpX3BpZCA9PSBleHBfcGlkKQo+ICsJCXRzdF9yZXMoVFBB
U1MsICJTaWduYWxsaW5nIFBJRCBpcyAlZCBhcyBleHBlY3RlZCIsIGV4cF9waWQpOwo+ICAJZWxz
ZQo+ICsJCXRzdF9yZXMoVEZBSUwsICJTaWduYWxsaW5nIFBJRCBpcyBub3QgJWQsIGJ1dCAlZCIs
IGV4cF9waWQsIHNpLT5zaV9waWQpOwpuaXQ6IHVzZSBUU1RfRVhQX1BBU1MoKQoKLi4uCj4gKwlp
ZiAoY3BpZCAhPSAxIHx8IHBwaWQgIT0gMCkgewo+ICsJCXRzdF9yZXMoVEZBSUwsICJHb3QgdW5l
eHBlY3RlZCByZXN1bHQgb2YgY3BpZD0lZCBwcGlkPSVkIiwgY3BpZCwgcHBpZCk7Cj4gKwkJcmV0
dXJuIDE7Cj4gKwl9Cm5pdDogbWF5YmUgZWFzaWVyIGZvciByZXZpZXdlciBpZiB0aGVzZSB0d28g
ZmFpbHVyZXMgYXJlIGhhbmRsZWQgc2VwYXJhdGVseS4KCkkgYWxzbyBob3BlIHdlIHNvb25lciBv
ciBsYXRlciBnZXQgcmlkIG9mIGx0cF9jbG9uZV9xdWljaygpIGluIGZhdm9yIG9mCnRzdF9jbG9u
ZSgpLiBOb3Qgc3VyZSB3aGVyZSBlbmRlZCB0aGUgZGlzY3Vzc2lvbiBhYm91dCBpdCwgZnJvbSBb
MV0gaXQgbG9va3MKbGlrZSBpdCdzIG5lZWRlZCBub3cuIEl0IGNhbiB3YWl0IGZvciBhbm90aGVy
IHJlc3VsdCBhZnRlciB3ZSBtYW5hZ2UgdG8gbWVyZ2UKcGlkbnMgYW5kIG1xbnMgcmV3cml0ZXMu
CgpUaGUgcmVzdCBMR1RNLiBUaGFua3MgZm9yIHlvdXIgdGlyZWxlc3Mgd29yayBvbiByZXdyaXRp
bmcgTFRQIQoKS2luZCByZWdhcmRzLApQZXRyCgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bHRwLzk0NWViMGVlLWIzNDYtNTcyOS0zZGRhLTRiZmYzOWJiNTJkOUBzdXNlLmNvbS8KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
