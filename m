Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B0C36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 10:29:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AF333CAE7F
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 12:29:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AA563CAE53
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:29:18 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 87A6C1000998
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 12:29:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD3F4211C6;
 Tue,  1 Apr 2025 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743503355;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFMzv/7m2hl6UmbMONZLjPpJBVP/Yc7PC8A0kmHgSE8=;
 b=YWuT4CL1AwXNkWFXLLtj3MIIFtfTn442vW0UjeH4BphdqMGt4+j2GeE71H44y22uFNN+MY
 6QpdhJ2jTn8a6Z/jkLubXIqlvPNxwzglw9KfF6FkKcsb2YZSnzjtxhFiaZfaMl25g3oVBJ
 FngUYbaSdp2Cjue+6baidllswINk+pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743503355;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFMzv/7m2hl6UmbMONZLjPpJBVP/Yc7PC8A0kmHgSE8=;
 b=IOTz7gBS9gRIVDteIoA2RwF8+f0SDeXD44EYMpWUZe/ML9W9Oedu+TITwsTN9tsns+33tB
 vm7txQUq6/z1pwDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N8XMAtXp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1kZmjo8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743503354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFMzv/7m2hl6UmbMONZLjPpJBVP/Yc7PC8A0kmHgSE8=;
 b=N8XMAtXpUQ/vkk7QdRfxXFd5W60jFw3XJlcPutvOOfk7bzCxBcK82t7cJTdtYkqnSGRBUt
 oQ+hXne80sroZ7kvqKzJ/vCK8TL7MkCT9v6lNO9MHoe38FM9Tns2cxNF93fJwtge5P5O/7
 GQmWiw/WDj6xbuuFEBp2IJ2QLa0z3Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743503354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFMzv/7m2hl6UmbMONZLjPpJBVP/Yc7PC8A0kmHgSE8=;
 b=1kZmjo8F+VQI4Ff3H+c8NQmD0YgCIQf94YQDhRpdyLRNnSzlL75Ke7BznLFwG28qS3IDL+
 iNuVX2eRMhglVyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C10E9138A5;
 Tue,  1 Apr 2025 10:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2VvlLfq/62cYFQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 10:29:14 +0000
Date: Tue, 1 Apr 2025 12:29:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: rbm@suse.com
Message-ID: <20250401102909.GB345164@pevik>
References: <20250331-conversions-modify_ldt-v5-0-fd6ea1491956@suse.com>
 <20250331-conversions-modify_ldt-v5-1-fd6ea1491956@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250331-conversions-modify_ldt-v5-1-fd6ea1491956@suse.com>
X-Rspamd-Queue-Id: DD3F4211C6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljYXJkbywgQW5kcmVhLAoKPiArKysgYi9pbmNsdWRlL2xhcGkvbGR0LmgKPiBAQCAtMCww
ICsxLDM0IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
Cj4gKy8qCj4gKyAqIENvcHlyaWdodCAoYykgMjAyNSBTVVNFIExMQyBSaWNhcmRvIEIuIE1hcmxp
w6hyZSA8cmJtQHN1c2UuY29tPgo+ICsgKi8KPiArCj4gKyNpZm5kZWYgTEFQSV9MRFRfSF9fCj4g
KyNkZWZpbmUgTEFQSV9MRFRfSF9fCj4gKwo+ICsjaW5jbHVkZSAiY29uZmlnLmgiCj4gKyNpbmNs
dWRlICJsYXBpL3N5c2NhbGxzLmgiCj4gKyNpbmNsdWRlIDxhc20vbGR0Lmg+Cj4gKwo+ICtzdGF0
aWMgaW50IG1vZGlmeV9sZHQoaW50IGZ1bmMsIHZvaWQgKnB0ciwgdW5zaWduZWQgbG9uZyBieXRl
Y291bnQpCkZZSSBpZiB0aGlzIGluIGEgaGVhZGVyIGl0IHNob3VsZCBiZSAnc3RhdGljIGlubGlu
ZScuIFRoYXQgd291bGQgYmUgd29ydGggdG8gZml4LgoKV2UgaGF2ZSBhIGxvdCBvZiAnc3RhdGlj
IGlubGluZScgaW4gbGFwaSBoZWFkZXJzLiBJTUhPIHRoaXMgaXMgYSBnb29kIGFwcHJvYWNoCmZv
ciB0aGVzZSBmZWF0dXJlIHNwZWNpZmljIHN5c2NhbGxzLCBhbHRob3VnaCBNYXJ0aW4gRG91Y2hh
IHRyaWVkIHRvIGdldCByaWQgb2YKc29tZSBzdGF0aWMgaW5saW5lIChtb3ZpbmcgdGhlbSB0byBD
IGZpbGVzIGluIGxpYi8pIHRvIGF2b2lkIGNvbXBpbGF0aW9uIHByb2JsZW1zLgoKQnV0IGFnYWlu
LCB0aGlzIGlzIHdvcnRoIGZvciBzb21lIGdlbmVyaWMgZmlsZXMgbG9uZyBlbm91Z2ggZS5nLgps
aWIvdHN0X25ldGxpbmsuYyBvciBsaWIvdHN0X25ldGRldmljZS5jLgoKQWxzbyBzdGF0aWMgaW5s
aW5lIG1ha2VzIGNvZGUgdG8gZ3JvdywgYnV0IGFkZGluZyBuZXcgQyBzb3VyY2UgdG8gTFRQIGxp
YnMgbWFrZXMKSU1ITyBiaWdnZXIgY29kZSBzaXplIGluY3JlYXNlIChiZXNpZGVzIHdlIGRvbid0
IGNhcmUgYWJvdXQgTFRQIHNpemUgYW55d2F5LApvdGhlcndpc2Ugd2Ugd291bGQgY2hhbmdlIGxp
bmtpbmcgc2ltaWxhciB0byBidXN5Ym94IC0gc2luZ2xlIGJpbmFyeSBwcm92aWRpbmcKbWFueSBm
dW5jdGlvbnMpLgoKPiArewo+ICsJcmV0dXJuIHRzdF9zeXNjYWxsKF9fTlJfbW9kaWZ5X2xkdCwg
ZnVuYywgcHRyLCBieXRlY291bnQpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IHNhZmVfbW9kaWZ5
X2xkdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCBpbnQgZnVuYywKPiArCQkJ
ICAgdm9pZCAqcHRyLCB1bnNpZ25lZCBsb25nIGJ5dGVjb3VudCkKPiArewpBbmQgaGVyZSBhcyB3
ZWxsLgoKS2luZCByZWdhcmRzLApQZXRyCgo+ICsJaW50IHJ2YWw7Cj4gKwo+ICsJcnZhbCA9IG1v
ZGlmeV9sZHQoZnVuYywgcHRyLCBieXRlY291bnQpOwo+ICsJaWYgKHJ2YWwgPT0gLTEpCj4gKwkJ
dHN0X2Jya18oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywKPiArCQkJICJtb2RpZnlfbGR0
KCVkLCAlcCwgJWx1KSIsIGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKPiArCj4gKwlyZXR1cm4gcnZh
bDsKPiArfQo+ICsKPiArI2RlZmluZSBTQUZFX01PRElGWV9MRFQoZnVuYywgcHRyLCBieXRlY291
bnQpIFwKPiArCXNhZmVfbW9kaWZ5X2xkdChfX0ZJTEVfXywgX19MSU5FX18sIChmdW5jKSwgKHB0
ciksIChieXRlY291bnQpKQo+ICsKPiArI2VuZGlmIC8qIExBUElfTERUX0hfXyAqLwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
