Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA559C28B30
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 18:19:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E9AD3CAE45
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 19:19:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06F1B3CABA6
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 19:18:57 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A962D1400B85
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 19:18:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81382219A5;
 Thu, 20 Mar 2025 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742494733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+mheYnDMwrAkBm887bVBrrb3kjm3XwoOitVMHl4uOc=;
 b=MxyJ0P96K/lyTDXrE9aUKDxUFPpL96yCgJSm5gRv+nKVhyDptb/tP3indEFtvhGYq0Sjam
 B88/qeIuqQJfmF11mcEBNw0Wd1OQOW0hQL3sjcAclpAXSbuGQ26cnFatxd51YE2qKKTH2N
 wU6xMlYAu5pDC4rLDpV5AWBG8jKoTdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742494733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+mheYnDMwrAkBm887bVBrrb3kjm3XwoOitVMHl4uOc=;
 b=OMBzjq6/SPNRxLPjFZ3YSrY0kQfhYTzXlh9GXap4zHCRcOUhe3FzmWItjg5CUk5cZU0frD
 yxGUAsVbe4T7YwDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742494733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+mheYnDMwrAkBm887bVBrrb3kjm3XwoOitVMHl4uOc=;
 b=MxyJ0P96K/lyTDXrE9aUKDxUFPpL96yCgJSm5gRv+nKVhyDptb/tP3indEFtvhGYq0Sjam
 B88/qeIuqQJfmF11mcEBNw0Wd1OQOW0hQL3sjcAclpAXSbuGQ26cnFatxd51YE2qKKTH2N
 wU6xMlYAu5pDC4rLDpV5AWBG8jKoTdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742494733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+mheYnDMwrAkBm887bVBrrb3kjm3XwoOitVMHl4uOc=;
 b=OMBzjq6/SPNRxLPjFZ3YSrY0kQfhYTzXlh9GXap4zHCRcOUhe3FzmWItjg5CUk5cZU0frD
 yxGUAsVbe4T7YwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52A9E139D2;
 Thu, 20 Mar 2025 18:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y1cyEw1c3GfKKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Mar 2025 18:18:53 +0000
Date: Thu, 20 Mar 2025 19:18:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250320181851.GA118182@pevik>
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-4-amir73il@gmail.com>
 <20250320170039.GA113087@pevik>
 <CAOQ4uxj2SJyo4CLF4YeK=aiAL2H+oTXzbnYCzGyF8K1Ns74HOA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj2SJyo4CLF4YeK=aiAL2H+oTXzbnYCzGyF8K1Ns74HOA@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-0.999];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify24: add mmap() and user page fault to
 test
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIE1hciAyMCwgMjAyNSBhdCA2OjAw4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEFtaXIsCgo+ID4gPiBDb21taXQgMDY2ZTA1M2ZlMjA4YSAo
ImZzbm90aWZ5OiBhZGQgcHJlLWNvbnRlbnQgaG9va3Mgb24gbW1hcCgpIikKPiA+ID4gaW4gNi4x
NC1yYzcgYWRkZWQgYSBwcmUtY29udGVudCBob29oIGluIG1tYXAoKSBiZWZvcmUgdGhlIGZpbmFs
IHJlbGVhc2UKPiA+ID4gb2YgdGhlIGZzbm90aWZ5IHByZS1jb250ZW50IGV2ZW50IGZlYXR1cmUu
Cgo+ID4gPiBUbyB0ZXN0IHByZS1jb250ZW50IGhvb2sgb24gbW1hcCgpLCBpbmNyZWFzZSB0aGUg
c2l6ZSBvZiB0aGUgdGVzdCBmaWxlCj4gPiA+IHRvIDEwMSBwYWdlcyB1c2UgbW1hcCgpIHRvIHNl
dHVwIGEgYnVmZmVyIGZyb20gdGhlIGVuZCBvZiB0aGUgdGVzdCBmaWxlLgoKPiA+ID4gQ2hhbmdl
IHNvbWUgb2YgdGhlIHRlc3QgY2FzZXMgdG8gYWxsb3cgdGhlIHdyaXRlKCkgYW5kIHVzZSB0aGlz
IGJ1ZmZlcgo+ID4gPiBhcyB0aGUgaW5wdXQgYnVmZmVyIHRvIHdyaXRlKCksIHdoaWNoIHRlc3Rz
IGRlYWRsb2NrIGF2b2lkYW5jZSBieQo+ID4gPiBzdXBwcmVzaW5nIHByZS1jb250ZW50IGhvb2sg
b24gdXNlciBwYWdlIGZhdWx0cy4KCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWlu
IDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgLi4uL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeTI0LmMgICAgIHwgNDEgKysrKysrKysrKysrKysrKy0tLQo+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgo+ID4g
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlm
eTI0LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjQuYwo+
ID4gPiBpbmRleCAyZDI0NzliMzkuLjNhNzZmMmMxYiAxMDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTI0LmMKPiA+ID4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTI0LmMKPiA+ID4gQEAgLTQ2
LDYgKzQ2LDcgQEAKPiA+ID4gIHN0YXRpYyBjaGFyIGZuYW1lW0JVRl9TSVpFXTsKPiA+ID4gIHN0
YXRpYyBjaGFyIGJ1ZltCVUZfU0laRV07Cj4gPiA+ICBzdGF0aWMgdm9sYXRpbGUgaW50IGZkX25v
dGlmeTsKPiA+ID4gK3N0YXRpYyBzaXplX3QgcGFnZV9zejsKCj4gPiA+ICBzdGF0aWMgcGlkX3Qg
Y2hpbGRfcGlkOwoKPiA+ID4gQEAgLTY4LDcgKzY5LDggQEAgc3RhdGljIHN0cnVjdCB0Y2FzZSB7
Cj4gPiA+ICAgICAgICAgICAgICAgRkFOX09QRU5fUEVSTSB8IEZBTl9QUkVfQUNDRVNTLAo+ID4g
PiAgICAgICAgICAgICAgIHsKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgIHtGQU5fT1BFTl9Q
RVJNLCBGQU5fQUxMT1d9LAo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAge0ZBTl9QUkVfQUND
RVNTLCBGQU5fREVOWX0sCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICB7RkFOX1BSRV9BQ0NF
U1MsIEZBTl9BTExPV30sCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICB7RkFOX1BSRV9BQ0NF
U1MsIEZBTl9BTExPV30sCgo+ID4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgdGhlc2UgZG91
YmxlZCBGQU5fUFJFX0FDQ0VTUywgRkFOX0FMTE9XIGFyZSBmb3IKPiA+IHJldXNpbmcgdGhlIHdy
aXRlIGJ1ZmZlciwgcmlnaHQ/IE9idmlvdXNseSBpdCdzIG5lZWRlZCBidXQgb24gdGhlIGZpcnN0
IGxvb2sgaXQKPiA+IGxvb2tzIGxpa2UgZXJyb3IuCgo+IFNvcnJ5LCB0aGlzIHdhc24ndCBwcm9w
ZXJseSBleHBsYWluZWQuCgo+IFRoaXMgY2hhbmdlIGFkZHMgYSB0ZXN0IGZvciBwcmUtbW1hcCBl
dmVudHMuCgo+IEZpcnN0IG9mIGFsbCwgd2UgYWRkZWQgYW4gbW1hcCgpIGNhbGwgYmVmb3JlIHRo
ZSB3cml0ZSgpLAo+IHNvIHdlIG5lZWQgdG8gYWRkIGFub3RoZXIgZXhwZWN0ZWQgRkFOX1BSRV9B
Q0NFU1MKPiBmb3IgdGhlIG1tYXAoKSBhbmQgd2UgYWxsb3cgdGhlIG1tYXAgZm9yIGFsbCB0ZXN0
IGNhc2VzLgoKPiBTZWNvbmRseSwgd2UgQ2hhbmdlIHNvbWUgb2YgdGhlIHRlc3QgY2FzZXMgdG8g
YWxsb3cgdGhlIHdyaXRlKCkKPiBhbmQgdXNlIHRoZSBtbWFwZWQgYnVmZmVyIGFzIHRoZSBpbnB1
dCBidWZmZXIuCgo+IFRoZSByZWFzb24gdGhhdCB3ZSBhbGxvdyB0aGUgd3JpdGUoKSBpcyB0byB2
ZXJpZnkgdGhhdCB3ZSBkbyBub3QKPiBnZXQgYW5vdGhlciBGQU5fUFJFX0FDQ0VTUyBldmVudCBm
cm9tIHJlYWRpbmcgZnJvbSB0aGUKPiBtbWFwZWQgaW5wdXQgYnVmZmVyLgoKVGhhbmtzIGZvciB0
aGUgZXhwbGFuYXRpb24uIEl0IHdvdWxkIGRlc2VydmUgdG8gdXBkYXRlIHRoZSBjb21taXQgbWVz
c2FnZSwKYnV0IGl0J3MgcHJvYmFibHkgb2J2aW91cyB0byBKYW4gYW5kIEkgYWRkIGxpbmsgdG8g
bG9yZSBiZWZvcmUgbWVyZ2luZywKdGhlcmVmb3JlIG1heWJlIGl0J3MgZW5vdWdoIGFzIGlzLgoK
QW55d2F5LCB3aG9sZSBwYXRjaHNldCBMR1RNLiBXYWl0aW5nIHRpbGwgdG9tb3Jyb3cgYmVmb3Jl
IG1lcmdpbmcgaWYgSmFuIGhhcwpzb21lIGlucHV0LgoKUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6PgoKS2luZCByZWdhcmRzLApQZXRyCgo+IFRoYW5rcywKPiBBbWlyLgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
