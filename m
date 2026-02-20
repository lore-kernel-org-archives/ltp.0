Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D970C56206
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 15:43:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E94DC3D085E
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 16:43:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3C053D03DC
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:43:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 31D291000A10
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:43:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A71D35BD04;
 Fri, 20 Feb 2026 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771602189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bn2cFyaPS0CS0B5eaigwPTOAtnCUFt5zuHZV+VWYzp8=;
 b=cknsQQdZWa5WBcB9kaAtUV8sceoT5FqT3w+pMTCSQmRKgv9wSAZ/v7nFKi5NJlBwEubZRV
 vjtWJYuz72yQNlDvZdALfoN+WrswW+AfT81OaDFDjR/wDFMoy9spiEIb2Ub5htJRIyQZg0
 sD0Mgusy1us6vb6uo359miImMPLvbD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771602189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bn2cFyaPS0CS0B5eaigwPTOAtnCUFt5zuHZV+VWYzp8=;
 b=l6+h69iGpCneT8ZKsnezFwZ+bywbcXp5HooBS1/XC1nGT5gtJYzzec7bwB8kWZ0+kSmK0p
 IzR8u1xEOtyAtHAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771602189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bn2cFyaPS0CS0B5eaigwPTOAtnCUFt5zuHZV+VWYzp8=;
 b=cknsQQdZWa5WBcB9kaAtUV8sceoT5FqT3w+pMTCSQmRKgv9wSAZ/v7nFKi5NJlBwEubZRV
 vjtWJYuz72yQNlDvZdALfoN+WrswW+AfT81OaDFDjR/wDFMoy9spiEIb2Ub5htJRIyQZg0
 sD0Mgusy1us6vb6uo359miImMPLvbD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771602189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bn2cFyaPS0CS0B5eaigwPTOAtnCUFt5zuHZV+VWYzp8=;
 b=l6+h69iGpCneT8ZKsnezFwZ+bywbcXp5HooBS1/XC1nGT5gtJYzzec7bwB8kWZ0+kSmK0p
 IzR8u1xEOtyAtHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81C7E3EA65;
 Fri, 20 Feb 2026 15:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oRb3HQ2BmGlncgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Fri, 20 Feb 2026 15:43:09 +0000
Message-ID: <1a05954d-e6b9-4e43-85f2-90ea94e8b68a@suse.de>
Date: Fri, 20 Feb 2026 16:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20260219225007.218697-1-rbranco@suse.de>
 <DGJWBYPFA8X4.O6DWVQQLRNGT@suse.com>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <DGJWBYPFA8X4.O6DWVQQLRNGT@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Add test using UFFDIO_POISON
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAyLzIwLzI2IDQ6MzIgUE0sIEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4+ICsKPj4gKwlz
YS5zYV9oYW5kbGVyID0gc2lnYnVzX2hhbmRsZXI7Cj4+ICsJc2lnZW1wdHlzZXQoJnNhLnNhX21h
c2spOwo+PiArCVNBRkVfU0lHQUNUSU9OKFNJR0JVUywgJnNhLCBOVUxMKTsKPj4gKwo+PiArCXNl
dF9wYWdlcygpOwo+IFRoaXMgaXMgZG9uZSBldmVyeSBjeWNsZSBvZiAtaSA+IDEsIGJ1dCBtZW1v
cnkgaXMgbmV2ZXIgcmVsZWFzZWQgYW5kCj4gZG9uZSBvbmNlIGluIGNsZWFudXAoKS4KSSdtIG1v
dmluZyBzaWdhY3Rpb24gdG8gc2V0dXAgYnV0IHNldF9wYWdlcygpIGlzIGNhbGxlZCBpbiBydW4o
KSBvbiB0aGUgCnJlc3Qgb2YgdGhlIHRlc3RzLgoKPj4gKwo+PiArCXVmZmQgPSBTQUZFX1VTRVJG
QVVMVEZEKE9fQ0xPRVhFQyB8IE9fTk9OQkxPQ0ssIGZhbHNlKTsKPiBNYXliZSB0aGlzIG9uZSBz
aG91bGQgYmUgY2xvc2VkIGluc2lkZSBydW4oKSwgb3IgZXZlbiByZW1vdmUgaXQgZnJvbQo+IHN0
YXRpYyB2YXJpYWJsZXMgYW5kIHBhc3NlZCB0byB0aGUgdGhyZWFkLCBzbyB3ZSBrZWVwIGl0IGlu
c2lkZSBydW4oKS4KCkJ1dCB0aGVuIHdlJ2QgYWxzbyBoYXZlIHRvIGZpeCB0aGUgb3RoZXIgdGVz
dHMuCj4+ICsKPj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPj4gKwkudGVzdF9h
bGwgPSBydW4sCj4+ICsJLmNsZWFudXAgPSBjbGVhbnVwLAo+PiArfTsKPiBZb3UgYXIgbWlzc2lu
ZyB0aGUgcnVudGVzdCBlbnRyeS4KClRoZXJlJ3Mgbm8gcnVudGVzdCBmdW5jdGlvbi7CoCBGb3Ig
bm93IEknbSB1c2luZyB0aGUgb3RoZXIgdGVzdHMgYXMgdGVtcGxhdGUuCgpCZXN0LApSCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
