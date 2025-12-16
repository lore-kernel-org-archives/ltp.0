Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58660D5E12E
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:22:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E18D93D0360
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 12:22:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 890C33D0343
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:22:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 54B4D600677
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:22:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF90233691;
 Tue, 16 Dec 2025 11:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765884151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xi9n1pxEirbNoi4LPaIJqun5CD2MvG0MYIgWV4nnAl4=;
 b=goX27HxBamYXpS4w/RBPAxnhVgQtAWF8Ie/NGWBb6G6t4e6e/573JdWPXkvWEbkgqKm02y
 M9JXOORDgYJn0vhgn+bXHen32RpAYFMR2KMkNvY1V4Eg63pg45D9Fyp3J94fFXe3dIiRrv
 HYIRqApA52IQv6jCX8032dj1287hYIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765884151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xi9n1pxEirbNoi4LPaIJqun5CD2MvG0MYIgWV4nnAl4=;
 b=H418Yasb3KwrYCt763f9fnfSC0Nh2gajsMp8y9q6e2Q5RxlbPHyFBrOQftON+09xPqT1o7
 RQUQENHn2EBjmrAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765884149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xi9n1pxEirbNoi4LPaIJqun5CD2MvG0MYIgWV4nnAl4=;
 b=0uK3zA6f7ZGdnR5kSJLETbPwEhfyCvDYS3QGQZQaRW1zrk5owamM691JyHrI2VO66JqNvd
 0bcJtnVdjleC7w+ccxoa0JjL6c+Dclr+JT839cJm+J4b5606pOseX6+7HFjhdbIXTHvPg+
 5Z7nFfWtfLWK91NNWB9vRvIuVi59rto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765884149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xi9n1pxEirbNoi4LPaIJqun5CD2MvG0MYIgWV4nnAl4=;
 b=7AiCH2Zh8MXzrpe+Z1wlxw+dnQ4LhQJphDmbobtF9dxBgpEbxYnm5UWsJ9imuVQSUmcqV7
 mSlzHKIWuVLqeFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDC033EA63;
 Tue, 16 Dec 2025 11:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1+dXMfVAQWnSIAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 16 Dec 2025 11:22:29 +0000
Date: Tue, 16 Dec 2025 12:23:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aUFBNIwaFo-YLPNR@yuki.lan>
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.988]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gSXQncyByZWFsbHkgZ29vZCB0byB3cml0ZSB0aGVzZSBydWxlcyBkb3duLCBlc3BlY2lh
bGx5IHNpbmNlIG1haW50YWluZXJzCj4gY2FuIHJldXNlIHRoZW0gaW4gcGF0Y2ggcmV2aWV3cyB0
byBjb21tZW50IG9uIGlzc3VlcyBhbmQgYXZvaWQgcmVwZWF0ZWRseQo+IHJlc3BvbmRpbmcgdG8g
dGhlIHNhbWUgcXVlc3Rpb25zLiBCZWxvdyBhcmUgd2hhdCBJIGNhbiB0aGluayBvZjoKPiAKPiBE
b27igJl0IHJlcXVpcmUgcm9vdCB1bmxlc3MgaXTigJlzIGVzc2VudGlhbAo+ID09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KPiBJZiByb290L2NhcHMgYXJlIG5lZWRlZCwgc2F5IHdoeSBpbiB0
aGUgdGVzdCBvdXRwdXQuIERyb3AgcHJpdmlsZWdlcyBmb3IKPiB0aGUgcGFydCB0aGF0IGRvZXNu
4oCZdCBuZWVkIHRoZW0gKGFuZCBhdm9pZCBydW5uaW5nIHRoZSB3aG9sZSB0ZXN0IGFzCj4gcm9v
dCDigJxiZWNhdXNlIGl04oCZcyBlYXNpZXLigJ0pLgo+IAo+IAo+IEFsd2F5cyBjbGVhbiB1cCwg
ZXZlbiBvbiBmYWlsdXJlCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT0KPiBFdmVyeSB0ZXN0
IHNob3VsZCBsZWF2ZSB0aGUgc3lzdGVtIGFzIGl0IGZvdW5kIGl0OiB1bm1vdW50LCByZXN0b3Jl
IHN5c2N0bHMsCj4gZGVsZXRlIHRlbXAgZmlsZXMvZGlycywga2lsbCBzcGF3bmVkIHByb2Nlc3Nl
cywgcmVtb3ZlIGNncm91cHMvbmFtZXNwYWNlcywKPiBkZXRhY2ggbG9vcCBkZXZpY2VzLCByZXN0
b3JlIHVsaW1pdHMsIGV0Yy4gQ2xlYW51cCBtdXN0IHJ1biBvbiBlYXJseS1leGl0Cj4gcGF0aHMg
dG9vLgo+IAo+IAo+IFJlc3BlY3QgTFRQIHBvcnRhYmlsaXR5IGdvYWxzCj4gPT09PT09PT09PT09
PT09PT09PT09PT09PT09Cj4gQXZvaWQgbm9uc3RhbmRhcmQgbGliYyBBUElzIHdoZW4gYSBwb3J0
YWJsZSBlcXVpdmFsZW50IGV4aXN0czsgZG9u4oCZdCBhc3N1bWUKPiA2NC1iaXQsCj4gcGFnZSBz
aXplLCBlbmRpYW5uZXNzLCBvciBwYXJ0aWN1bGFyIHRvb2wgdmVyc2lvbnMuCgpTaGFsbCBJIHNl
bmQgYSBWMyB3aXRoIHRoZXNlIGluY2x1ZGVkLCBvciBkbyB5b3Ugd2FudCB0byBzZW5kIGEgcGF0
Y2ggb24KdGhlIHRvcCBvZiB0aGUgb25lIEkgc2VuZD8KCi0tIApDeXJpbCBIcnViaXMKY2hydWJp
c0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
