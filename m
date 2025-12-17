Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C23D65C69
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 15:58:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC7843D0409
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 16:58:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F20F93D03CC
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 16:57:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D96560045F
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 16:57:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC9145BCF9;
 Wed, 17 Dec 2025 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765987067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqYoKKyYnhjsX29Qbz9+KoEF7v9iudpVQeAQiVNs0k8=;
 b=uFjd6wnM5fRCgIGN7CsCUW4sTWZj9Plld+d+la0767tmq0Yr9ie9sbpPBbRAENHOoqCijO
 3uw/lNvb8wXoOcvETYrhDWe5l+Wn+kGbedpQGb5jf2bWlbk1B3Tp5k4XSAkoUzW8tpP91c
 O7uDgD+LJKfsHj9d1g4TxNxUZRywzLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765987067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqYoKKyYnhjsX29Qbz9+KoEF7v9iudpVQeAQiVNs0k8=;
 b=eSvTBOj7JASxE1VbDkkJ6pmGKV8vyZorfQhUbc0hTYLXBeC7q+LD32UZ5ryZhinht0A+t3
 yoPus52eLNhlKSCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765987065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqYoKKyYnhjsX29Qbz9+KoEF7v9iudpVQeAQiVNs0k8=;
 b=PoOGu4tQIo3N6BKXgfmgv4ZJJXkB2UA7/ddtxhQUkRLUKc4qWZsy0Xm8Zh/l2+ADTRZUs8
 QqBneIjMRt8a9O1rwgyK6PxCU5Fz+3Eye24lYi96c/ai9OzZUBuvJZ7eylex0MOrN2Uywq
 Jh45R6n+RWrN+agW3lTEuViYq0H/IqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765987065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqYoKKyYnhjsX29Qbz9+KoEF7v9iudpVQeAQiVNs0k8=;
 b=SIvYNUc9Bgl1sEqfGwM94OpJMV5jwEjQAO96BdDgAV9zTaFmCNrl213Vy8I73H9+TSw9VO
 8crs+QYfxXE9T6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 874503EA63;
 Wed, 17 Dec 2025 15:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bxpgH/nSQmlnXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Dec 2025 15:57:45 +0000
Date: Wed, 17 Dec 2025 16:57:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251217155744.GA75994@pevik>
References: <20251209185557.20598-1-pvorel@suse.cz>
 <20251209185557.20598-2-pvorel@suse.cz>
 <CAEemH2ej8-e_S4LgcKKkt08dUhyF0TreWp-QvXzQ1QGQYbywJg@mail.gmail.com>
 <aULIhXrMA4dgTwGg@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aULIhXrMA4dgTwGg@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] shell: Add tst_runas.c helper
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBKbyEKOikKPiA+ID4gKyAgICAgICBjaGFyICp1aWRfZW52ID0gZ2V0ZW52KFRTVF9UT19TVFJf
KExUUF9VU1JfVUlEKSk7Cj4gPiA+ICsgICAgICAgY2hhciAqZ2lkX2VudiA9IGdldGVudihUU1Rf
VE9fU1RSXyhMVFBfVVNSX0dJRCkpOwoKPiA+IFNvIGZhciB0aGlzIGZvcm1hdCBpcyBjb3JyZWN0
LgoKPiA+IEJ1dCBhcyBJIHBvaW50ZWQgaW4gdGhlIGxhc3QgdGhyZWFkLCBoZXJlIHVzaW5nIFRT
VF9UT19TVFJfIG1pZ2h0IGJlIGEKPiA+IHBvdGVudGlhbApJJ20gc29ycnkgdG8gb3Zlcmxvb2sg
dGhpcy4KCj4gPiBpc3N1ZSBpZiBzb21lZGF5IHdlIG1ha2UgY2hhbmdlcyBvbiB0aGF0IHRvIGJl
Y29tZSB0d28tbGV2ZWwgbWFjcm8uCj4gPiBJdCBsaWtlbHkgdG8gaW50ZXJwcmV0ZWQgYXMgIGdl
dGVudigiNjU1MzQiKTsKCj4gPiBTbyBvbiB0aGUgc2FmZSBzaWRlLCBJ4oCZZCBzdGlsbCByZWNv
bW1lbmQgd3JpdGluZyBpdCBleHBsaWNpdGx5OgoKPiA+ICAgICBjaGFyICp1aWRfZW52ID0gZ2V0
ZW52KCJMVFBfVVNSX1VJRCIpOwo+ID4gICAgIGNoYXIgKmdpZF9lbnYgPSBnZXRlbnYoIkxUUF9V
U1JfR0lEIik7Cgo+ICsxCgpUaGUgcmVhc29uIEkgdXNlZCB0aGUgbWFjcm8gaXMgdGhhdCBJIHBy
ZWZlciB0byB1c2UgY29uc3RhbnRzIGluc3RlYWQgb2YgYSBwbGFpbgp0ZXh0IChhbHNvIGRhbmdl
ciBvZiB0eXBvKS4gQnV0IGNoYW5nZWQgdG8geW91ciBwcm9wb3NhbCBhbmQgbWVyZ2VkIHdob2xl
CnBhdGNoc2V0LgoKVGhhbmtzIGFsbCBmb3IgeW91ciByZXZpZXcuCgpLaW5kIHJlZ2FyZHMsClBl
dHIKCj4gPiBUaGUgcmVzdCB3aG9sZSBwYXRjaCBzZXQgbG9va3MgZ29vZDoKCj4gPiBSZXZpZXdl
ZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cgo+IEZvciB0aGUgcmVzdCBhbHNvIGZy
b20gbWU6Cgo+IFJldmlld2VkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
