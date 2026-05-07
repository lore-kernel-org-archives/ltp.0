Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F87CD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:37:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 034EB3E2876
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:37:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A72E73CA180
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:37:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F4DB60080F
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:37:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4E7E6C19F;
 Thu,  7 May 2026 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778139439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMRWT06US3azMfNR4a7tbw3+iX6HacaWt7Kp9FGt/Mg=;
 b=f1/UhoV/4ubdJMVQCU2PD+o+9IhMHNn5RqtNGRdi84PG+iyKYrig3MvmfFIM81jV7VrxOz
 Yx1U3ZDmLzch/3IDZcH/TMq2YdtXbHdCrw/R9MJmtz+vqlH0JQeI7g/VCkNmjI85RZDrJe
 VFJaTyOdf8TjrYx/WDo0AaGZ/DqulUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778139439;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMRWT06US3azMfNR4a7tbw3+iX6HacaWt7Kp9FGt/Mg=;
 b=x03jBEgkaI1WtTBOW+ynafO+txrxwH/e1KEFFSOyEFD5SWxolXngQlRaPxhkjkdNLBorPR
 MSN1sE0LzMESbqAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778139438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMRWT06US3azMfNR4a7tbw3+iX6HacaWt7Kp9FGt/Mg=;
 b=TL+Cxa3Ct8k32YITeH8hdljXSGuhC9aajO/HAJKESC5Dg2Z/KkfZn5BDB9gYXgX271+1BB
 BUbfrDGFrYzRLK8GJYw02CmYqvg5VaEEMnkX5qq2s/z+z035Ysj9+99m1JSWV/54/LSY+M
 nGdtCo+sXDiu/GF4jZkJujvKRPVGif0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778139438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMRWT06US3azMfNR4a7tbw3+iX6HacaWt7Kp9FGt/Mg=;
 b=3kP5+hBY9GyjvDit88uZEn6/XaNf4dhC6mWAhWJudNhQEEDe0Cq8cOmLbofR8+hx/IzSUD
 D1krW3TKq8P+HbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4223593A7;
 Thu,  7 May 2026 07:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XBrIKi5B/Gl7EAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 07 May 2026 07:37:18 +0000
Date: Thu, 7 May 2026 09:37:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <afxBKVidvR96iTTP@yuki.lan>
References: <20260409103041.8253-1-chrubis@suse.cz>
 <69fb4789.5d0a0220.2b948b.6eaf@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69fb4789.5d0a0220.2b948b.6eaf@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Fix proc parsing in newuname01
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

SGkhCj4gPiArCWYgPSBmb3BlbihwYXRoLCAiciIpOwo+ID4gKwlpZiAoIWYpIHsKPiA+ICsJCXRz
dF9icmttXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLCBOVUxMLAo+ID4gKwkJICAgICAg
ICAgICJGYWlsZWQgdG8gb3BlbiBGSUxFICclcycgZm9yIHJlYWRpbmciLCBwYXRoKTsKPiA+ICsJ
fQo+ID4gKwo+ID4gKwlpZiAoIWZnZXRzKGJ1ZiwgYnVmX3NpemUsIGYpKQo+IAo+IE1pc3Npbmcg
cmV0dXJuOyBhZnRlciB0c3RfYnJrbV8oKSDigJQgZiBpcyBOVUxMIGlmIGZvcGVuIGZhaWxlZCwg
c28gZmdldHMoKQo+IGRlcmVmZXJlbmNlcyBOVUxMLiBFdmVyeSBvdGhlciBlcnJvciBwYXRoIGlu
IHRoaXMgZmlsZSBoYXMgcmV0dXJuOyBhZnRlcgo+IHRzdF9icmttXygpLgoKWWVzIEknbSBhd2Fy
ZSwgdGhhbmtzIGZvciByZW1pbmRpbmcgbWUgdGhvdWdoLgoKPiA+ICsJc2l6ZV90IGxlbiA9IHN0
cmxlbihidWYpOwo+IAo+IFZhcmlhYmxlIGRlY2xhcmF0aW9uIGFmdGVyIGEgc3RhdGVtZW50LiBN
b3ZlIGxlbiB0byB0aGUgdG9wIG9mIHRoZSBmdW5jdGlvbgo+IHdpdGggRklMRSAqZi4KCkRvIHdl
IHN0aWwgZm9sbG93IHRoZSBDODkgaW4gdGhpcyByZWdhcmQ/IFdlIGFscmVhZHkgZm9yY2UgZ251
OTkgaW4KdGhlIGNvbmZpZy5tay4KCj4gPiArICogSXQncyByZWNvbWVuZGVkIHRvIHVzZSB0aGlz
IGZvciB2YXJpb3VzIHN5c2ZzIG9yIHByb2NmcyBmaWxlcyB0aGF0IG1heSBiZQo+IAo+IHMvcmVj
b21lbmRlZC9yZWNvbW1lbmRlZC8KPiAKPiBSZWdhcmRzLAo+IExUUCBBSSBSZXZpZXdlcgo+IAo+
IC0tCj4gQW5kcmVhIENlcnZlc2F0bwo+IFNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51
eAo+IGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0Bz
dXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
