Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03175C4167B
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 18:26:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A1173CDB7E
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 19:26:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2552E3CCB41
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 19:26:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 044766008D1
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 19:26:07 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B371E21A8B;
 Mon, 27 Nov 2023 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701109566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8aqdH4xxcDBqiXlySHa9+vNm1BAHrekYrVurFgKtgQ=;
 b=JTUDB4Xxa0A78Y+qsoXbcy8dl73y1EISocS+oNSiqH7wzHkKb+OJ7mRegZNBz6paapqOsa
 0QOHrktkJj706WWcrtNGpfRO24ZD5amiitRPsGJ9W2QNw30wEHuYHeQKQUCoJPBYkeQDNC
 g65NF8A4GaCXAU0Do9IAOWvEasQxqZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701109566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8aqdH4xxcDBqiXlySHa9+vNm1BAHrekYrVurFgKtgQ=;
 b=FgOaJQWf8fpKBm0zDlL5oIMFn9byfTqxLju4wgdSmyzitJ4OKQ9X7JUS5F+92tGZ+pKjUk
 tUkvacFoeRhKuyDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A31E6132A6;
 Mon, 27 Nov 2023 18:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id ZAWDJz7fZGXvAgAAn2gu4w
 (envelope-from <jack@suse.cz>); Mon, 27 Nov 2023 18:26:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 25490A07CB; Mon, 27 Nov 2023 19:26:02 +0100 (CET)
Date: Mon, 27 Nov 2023 19:26:02 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20231127182602.p5tx5hvinsobw3xb@quack3>
References: <20231127154013.2625-1-jack@suse.cz>
 <CAOQ4uxhtz2rCn70roeof0Bt8CbAi0vK4CMNiuoFq9M85FUpgGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhtz2rCn70roeof0Bt8CbAi0vK4CMNiuoFq9M85FUpgGQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify: Fix broken tests due to
 fanotify_events_supported_by_kernel()
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
Cc: pvorel@suse.com, Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIDI3LTExLTIzIDE5OjQwOjE0LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBNb24s
IE5vdiAyNywgMjAyMyBhdCA1OjQw4oCvUE0gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JvdGU6
Cj4gPgo+ID4gV2hlbiBMVFAgdGVzdCBpcyBydW4gd2l0aCBDV0QgaW4gYnRyZnMgc3Vidm9sdW1l
LCB0ZXN0cyBsaWtlIGZhbm90aWZ5MTYKPiA+IGZhaWwgd2l0aDoKPiA+Cj4gPiBmYW5vdGlmeS5o
OjE2OTogVEJST0s6IGZhbm90aWZ5X21hcmsgKDMsIEZBTl9NQVJLX0FERCwgLi4uLCBBVF9GRENX
RCwgIi4iKSBmYWlsZWQ6IEVYREVWICgxOCkKPiA+Cj4gPiBUaGlzIGlzIGJlY2F1c2UgZmFub3Rp
ZnlfZXZlbnRzX3N1cHBvcnRlZF9ieV9rZXJuZWwoKSB0cnkgdG8gcGxhY2UgYQo+ID4gbWFyayBv
bnRvIENXRCBhbmQgdGhhdCBpcyBmb3JiaWRkZW4gZm9yIGJ0cmZzIHN1YnZvbHVtZXMuIENoYW5n
ZQo+ID4gZmFub3RpZnlfZXZlbnRzX3N1cHBvcnRlZF9ieV9rZXJuZWwoKSB0byB1c2UgIi8iIGlu
c3RlYWQgb2YgIi4iIHdoaWNoCj4gPiBoYXMgaGlnaGVyIGNoYW5jZXMgb2Ygd29ya2luZyBmb3Ig
YnRyZnMuCj4gPgo+IAo+IEZXSVcsICIuIiBpbiBzZXR1cCgpIGlzIHVzdWFsbHkgYSB0ZW1wZGly
ICh1bmRlciBMVFAgdGVtcCByb290KQo+IFNvIEknbSBub3Qgc3VyZSB0aGF0ICIvIiBpcyBhIGJl
dHRlciBjaG9pY2UgdGhhbiAiLiIuCj4gQXQgbGVhc3QgdGhlIExUUCB0ZW1wIGRpciBpcyBjb25m
aWd1cmFibGUuCj4gYW5kIG5vIHJlYXNvbiB0aGF0ICIvIiBpcyBub3QgYSBidHJmcyBzdWJ2b2wg
aW5zaWRlIGEgY29udGFpbmVyLi4uCgpZZWFoLCB0aGF0J3MgYSBnb29kIHBvaW50LiBJIHdhcyB0
aGlua2luZyBpdCBuZWVkIG5vdCBiZSBzbyBzaW1wbGUgYnV0CndhbnRlZCBzb21ldGhpbmcgdG8g
c3RhcnQgYSBkaXNjdXNzaW9uIDopCgo+IEZZSSwgaW4gdGhpcyBicmFuY2g6Cj4gaHR0cHM6Ly9n
aXRodWIuY29tL2FtaXI3M2lsL2x0cC9jb21taXRzL2Zhbm90aWZ5X2ZzaWQKPiAKPiBJIGhhdmUg
YWxyZWFkeSBpbXBsZW1lbnRlZCBmYW5vdGlmeV9mbGFnc19zdXBwb3J0ZWRfb25fZnMoKQo+IHdo
aWNoIGNhbiBiZSB1c2VkIHRvIHRlc3Qgc3VwcG9ydCBmb3IgYW4gZXZlbnQvbWFyayBvbiBhIHNw
ZWNpZmljIHBhdGguCj4gCj4gSSBkaWQgbm90IG1ha2UgdGhlIGNoYW5nZSBpbiBmYW5vdGlmeTE2
LmMgdG8gdXNlCj4gZmFub3RpZnlfZmxhZ3Nfc3VwcG9ydGVkX29uX2ZzKCkgaW5zdGVhZCBvZgo+
IGZhbm90aWZ5X3ttYXJrLGV2ZW50c31fc3VwcG9ydGVkX2J5X2tlcm5lbCgpIGJ1dCBpdCB3b3Vs
ZCBiZSB0cml2aWFsIHRvIGRvLgoKT0ssIHRoaXMgaXMgcHJvYmFibHkgYSBtb3JlIHJvYnVzdCBp
ZGVhIHNvIHRoYXQgd2UgdGVzdCBhbGwgdGhlIGZlYXR1cmVzCmFnYWluc3QgYSBwYXRoIHdlIGFy
ZSB0aGVuIGFjdHVhbGx5IGdvaW5nIHRvIHVzZSBmb3IgdGVzdGluZy4gSSdsbCBwaWNrIHRoZQpj
b21taXQgImZhbm90aWZ5OiBHZW5lcmFsaXplIGhlbHBlciBmYW5vdGlmeV9mbGFnc19zdXBwb3J0
ZWRfb25fZnMoKSIgZnJvbQp5b3VyIGJyYW5jaCBhbmQgcmV3b3JrIHRoZSBmaXggYmFzZWQgb24g
dGhhdCB0b21vcnJvdy4gVGhhbmtzIQoKCQkJCQkJCQlIb256YQotLSAKSmFuIEthcmEgPGphY2tA
c3VzZS5jb20+ClNVU0UgTGFicywgQ1IKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
