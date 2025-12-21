Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89136D68BD5
	for <ltp@archiver.kernel.org>; Sun, 21 Dec 2025 10:31:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A6913D0887
	for <ltp@archiver.kernel.org>; Sun, 21 Dec 2025 11:31:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF1C63D0885
 for <ltp@lists.linux.it>; Sun, 21 Dec 2025 11:30:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3C30D1000553
 for <ltp@lists.linux.it>; Sun, 21 Dec 2025 11:30:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 091AC5BD1A;
 Sun, 21 Dec 2025 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766313048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao6TVaMaHH6PRPIo3vYSAFWDIJJwR6eEc/ykKwmO2Lk=;
 b=c4d4ItNGRbZ/36tY4vwgP/xsTe3u60IIgw8TPZP6MZ9S1hP2oOcH7ZTM0GJxE73cPHzJkE
 qgs/0PT8mw9vgOWzK3EBsFsMvgtMojyEWhVyMly9iWRNq1Gv79CYAQoabozZBzGMD2/KiO
 0GWIM2nKqxClULv9MyXcGSMwtYZZcIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766313048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao6TVaMaHH6PRPIo3vYSAFWDIJJwR6eEc/ykKwmO2Lk=;
 b=ufW57H/CFAKLFkqhmwJNy9Xa3zQrHbyXgidgsZh10DBpLHy8uyplAaKS+AJM5/RjamgXDQ
 lWZcDhLizAkwghAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WpqfIC5z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VJENA6wM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766313047;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao6TVaMaHH6PRPIo3vYSAFWDIJJwR6eEc/ykKwmO2Lk=;
 b=WpqfIC5zdlgttHly8OXEm88YXBOcXruSbXEvhykcru3GdXD4+cWxYHTnabpe4L+PAoYCd8
 kBd9Mlucr0PKf7T97Ozq97hE7O4a15PXKz8Ap+b8U4LC9MnEWFY67RveAouUXH+wT4iRdm
 1A0zOfbymLoRhHwKmgKEKRO3PaBD3Bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766313047;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao6TVaMaHH6PRPIo3vYSAFWDIJJwR6eEc/ykKwmO2Lk=;
 b=VJENA6wMFjtJdu0fBNf6a5q+z4NpRi1zE2VQkKAH33P2oufpFhYAU6C1KZZMBIxWQcuuTY
 UNYCV8iaTzSNwABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE2DA13A54;
 Sun, 21 Dec 2025 10:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wE+9MFbMR2lhfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 21 Dec 2025 10:30:46 +0000
Date: Sun, 21 Dec 2025 11:30:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20251221103044.GA26843@pevik>
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 091AC5BD1A
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

SGkgYWxsLAoKPiBJdCdzIHJlYWxseSBnb29kIHRvIHdyaXRlIHRoZXNlIHJ1bGVzIGRvd24sIGVz
cGVjaWFsbHkgc2luY2UgbWFpbnRhaW5lcnMKPiBjYW4gcmV1c2UgdGhlbSBpbiBwYXRjaCByZXZp
ZXdzIHRvIGNvbW1lbnQgb24gaXNzdWVzIGFuZCBhdm9pZCByZXBlYXRlZGx5Cj4gcmVzcG9uZGlu
ZyB0byB0aGUgc2FtZSBxdWVzdGlvbnMuIEJlbG93IGFyZSB3aGF0IEkgY2FuIHRoaW5rIG9mOgoK
KzEKCj4gRG9u4oCZdCByZXF1aXJlIHJvb3QgdW5sZXNzIGl04oCZcyBlc3NlbnRpYWwKPiA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09Cj4gSWYgcm9vdC9jYXBzIGFyZSBuZWVkZWQsIHNheSB3
aHkgaW4gdGhlIHRlc3Qgb3V0cHV0LiBEcm9wIHByaXZpbGVnZXMgZm9yCj4gdGhlIHBhcnQgdGhh
dCBkb2VzbuKAmXQgbmVlZCB0aGVtIChhbmQgYXZvaWQgcnVubmluZyB0aGUgd2hvbGUgdGVzdCBh
cwo+IHJvb3Qg4oCcYmVjYXVzZSBpdOKAmXMgZWFzaWVy4oCdKS4KCgo+IEFsd2F5cyBjbGVhbiB1
cCwgZXZlbiBvbiBmYWlsdXJlCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT0KPiBFdmVyeSB0
ZXN0IHNob3VsZCBsZWF2ZSB0aGUgc3lzdGVtIGFzIGl0IGZvdW5kIGl0OiB1bm1vdW50LCByZXN0
b3JlIHN5c2N0bHMsCj4gZGVsZXRlIHRlbXAgZmlsZXMvZGlycywga2lsbCBzcGF3bmVkIHByb2Nl
c3NlcywgcmVtb3ZlIGNncm91cHMvbmFtZXNwYWNlcywKPiBkZXRhY2ggbG9vcCBkZXZpY2VzLCBy
ZXN0b3JlIHVsaW1pdHMsIGV0Yy4gQ2xlYW51cCBtdXN0IHJ1biBvbiBlYXJseS1leGl0Cj4gcGF0
aHMgdG9vLgoKCj4gUmVzcGVjdCBMVFAgcG9ydGFiaWxpdHkgZ29hbHMKPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT0KPiBBdm9pZCBub25zdGFuZGFyZCBsaWJjIEFQSXMgd2hlbiBhIHBvcnRh
YmxlIGVxdWl2YWxlbnQgZXhpc3RzOyBkb27igJl0IGFzc3VtZQo+IDY0LWJpdCwKPiBwYWdlIHNp
emUsIGVuZGlhbm5lc3MsIG9yIHBhcnRpY3VsYXIgdG9vbCB2ZXJzaW9ucy4KCisxLgpJIHdvdWxk
IGFsc28gbWVudGlvbiBQT1NJWCBzaGVsbCBjb21wYXRpYmlsaXR5LgoKTWF5YmUgYWxzbyBtZW50
aW9uICdtYWtlIGNoZWNrJy4KCiJObyByZWdyZXNzaW9ucyIKPT09PT09PT09PT09PT09PQpFYWNo
IGNvbW1pdCBuZWVkcyB0byBjb21waWxlLiBOb25lIGNvbW1pdCBjYW4gYWN0dWFsbHkgZGVsaWJl
cmF0ZWx5IGJyZWFrIHRlc3RzLgoKQXMgdGhlIGRvY3VtZW50IGlzIGdldHRpbmcgcXVpdGUgYmln
LCBJJ2QgcHV0IEFJIHBvbGljeSBpbnRvIHNlcGFyYXRlIHBhZ2UuCgpLaW5kIHJlZ2FyZHMsClBl
dHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
