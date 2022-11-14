Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F600C433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 15:21:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01DCF3CD263
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 16:21:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0817C3CD214
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 16:21:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3021360076B
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 16:21:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D441200D9;
 Mon, 14 Nov 2022 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668439271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKuTWECPE8DE1H6QP0Np6SxdGNUBAcnYg4WbZIvjETs=;
 b=efnvllbYLvdSaTfRgjJd6mcZhaOMCF9G4gIxk3c3+BYUx/Rg/uvnns6l8qYP8I9NVKbovX
 31pQK0Jnp7htLCDe3KFFQMjr84Xrrgaq1+Z7AnXlAHh52V8u+tqK6Dc8TO4sOqqi8rMd6x
 cUT5L4WMr2iYFmDUXEVOY35dpXNqqUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668439271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKuTWECPE8DE1H6QP0Np6SxdGNUBAcnYg4WbZIvjETs=;
 b=fCMnaoeKrXEWJnNFtdazfni+EYLvrFsAQ/ymDH9sEVDceWCR4G7A0iXq/BZ0Go1RwkvN6h
 SlC6YwTeF8D/c9DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A45113A8C;
 Mon, 14 Nov 2022 15:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AZBECedccmMsDgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 14 Nov 2022 15:21:11 +0000
Message-ID: <7d899a16-7b4b-3ee9-8cba-949274610077@suse.cz>
Date: Mon, 14 Nov 2022 16:21:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221114093233.4668-1-mdoucha@suse.cz> <Y3JBzeBst/HufYqu@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y3JBzeBst/HufYqu@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] save_restore: Introduce new struct field for
 flags
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTQuIDExLiAyMiAxNDoyNSwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+IEknbSBub3Qgc3VyZSBp
ZiBpdCdzIGEgZ29vZCBpZGVhIHRvIGhhdmUgZGVmYXVsdCB3aXRob3V0IGFueSBjb25zdGFudHMK
PiBwYXNzZWQuIFdoZW4gSSBsb29rIGF0IHRoZSBmaWxlX3Jlc3RvcmUgcmVjb3JkcyBpbiB0aGUg
dGVzdHMgaXQgYWxsCj4gbWFrZXMgc2Vuc2UgdW50aWwgSSByZWFjaCBhIHBhcnQgd2hlcmUgMCBp
cyBwYXNzZWQgdG8gdGhlIGZsYWdzLiBJIHRoaW5rCj4gdGhhdCBpdCB3b3VsZCBtYWtlIHNlbnNl
IHRvIG1ha2UgZXZlcnl0aGluZyBhcyBzZWxmIGRlc2NyaWJpbmcgYXMKPiBwb3NzaWJsZS4KPiAK
PiBXb3VsZCB5b3UgY29uc2lkZXIgYWRkaW5nIFRTVF9TUl9UQ09ORl9NSVNTSU5HIGFuZCBUU1Rf
U1JfVENPTkZfUk8/CgpJIGNvdWxkIHNldCBib3RoIHRvIDAsIGlmIHRoYXQncyBPSy4KCj4+ICsq
ICdUU1RfU1JfRkFJTF9NSVNTSU5HJyDigJMgRW5kIHRlc3Qgd2l0aCAnVEJST0snIGlmIHRoZSBm
aWxlIGRvZXMgbm90IGV4aXN0Cj4gCj4gVGhpcyBGQUlMIHBhcnQgaW4gdGhpcyBuYW1lIGlzIHF1
aXRlIG1pc2xlYWRpbmcgc2luY2UgdGhlIHRlc3QgZW5kcyB3aXRoCj4gVEJST0suIEkgd291bGQg
c2F5IHRoYXQgaXQgd291bGQgYmUgbXVjaCBtb3JlIGNsZWFyIGlmIGl0IHdhcyBuYW1lZAo+IFRT
VF9TUl9UQlJPS19NSVNTSU5HLgoKVGhlbiBJIHNob3VsZCBhbHNvIHJlbmFtZSBUU1RfU1JfUkVR
VUlSRUQgdG8gVFNUX1NSX1RCUk9LLCByZW5hbWUgClRTVF9TUl9DT05EX0FDQ0VTUyB0byBUU1Rf
U1JfU0tJUCBhbmQgYWRkIFRTVF9TUl9UQ09ORiBmb3IgdGhlIHR3byBuZXcgCmZsYWdzLgoKLS0g
Ck1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1c2UuY3oKUUEgRW5naW5lZXIgZm9yIFNvZnR3YXJl
IE1haW50ZW5hbmNlClNVU0UgTElOVVgsIHMuci5vLgpDT1JTTyBJSWEKS3Jpemlrb3ZhIDE0OC8z
NAoxODYgMDAgUHJhZ3VlIDgKQ3plY2ggUmVwdWJsaWMKCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
