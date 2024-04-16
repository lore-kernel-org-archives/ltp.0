Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B43AC4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 14:47:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B03353CFAED
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 16:47:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CC5D3CFAFE
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 16:47:34 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9673D6011EA
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 16:47:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C46CF5F8D1;
 Tue, 16 Apr 2024 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713278852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teKxAvEotg56m74UIF1Wj/hIRKNqBQsarZEloEWijXc=;
 b=ClW+nGukjj2iAMS6SbEMLJcQw+9CGIPyGilrxa/Z1QgGi6J+3oJeHH1m1Dh1gfkYNLA4Ss
 /d7UwD/Wm7s7EAK9YjKzWTfMcZb2qDtWLNODi8rXoIianBVSZHIVqFGx6hLaCkUhtixGyc
 gDLRVO9CujcaWzJ0ohIudbKETpgDfkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713278852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teKxAvEotg56m74UIF1Wj/hIRKNqBQsarZEloEWijXc=;
 b=Vn0DIf8sHTn7g7xdccW/DmCO7Y3SWkZf95/aiG32ILmQct8zK0Wvvb5fFYnJnnGaEuGfbt
 kAsMaecEIa9ZhhDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713278852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teKxAvEotg56m74UIF1Wj/hIRKNqBQsarZEloEWijXc=;
 b=ClW+nGukjj2iAMS6SbEMLJcQw+9CGIPyGilrxa/Z1QgGi6J+3oJeHH1m1Dh1gfkYNLA4Ss
 /d7UwD/Wm7s7EAK9YjKzWTfMcZb2qDtWLNODi8rXoIianBVSZHIVqFGx6hLaCkUhtixGyc
 gDLRVO9CujcaWzJ0ohIudbKETpgDfkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713278852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teKxAvEotg56m74UIF1Wj/hIRKNqBQsarZEloEWijXc=;
 b=Vn0DIf8sHTn7g7xdccW/DmCO7Y3SWkZf95/aiG32ILmQct8zK0Wvvb5fFYnJnnGaEuGfbt
 kAsMaecEIa9ZhhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9E7313432;
 Tue, 16 Apr 2024 14:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7MJzJ4SPHmaPdwAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 16 Apr 2024 14:47:32 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 16 Apr 2024 16:47:32 +0200
Message-ID: <2281389.vFx2qVVIhK@localhost>
Organization: SUSE
In-Reply-To: <20240411054940.17859-1-xuyang2018.jy@fujitsu.com>
References: <20240411054940.17859-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; HAS_ORG_HEADER(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, fujitsu.com:email, suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] unlink: Add error tests for EPERM and EROFS
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

SGksCgpSZXZpZXdlZC1ieTogQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+CndpdGggYmVs
b3cgdHlwbyBmaXhlcy4KCk9uIFRodXJzZGF5LCBBcHJpbCAxMSwgMjAyNCA3OjQ5OjQw4oCvQU0g
R01UKzIgeW91IHdyb3RlOgo+IEFkZCBuZWdhdGl2ZSBjYXNlcyBmb3IgdW5saW5rKCksIHdoZW4g
ZXJybm8gaXMgRVBFUk0gb3IgRVJPRlMuCj4gCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdSA8eHV5
YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4KPiAtLS0KPiAgcnVudGVzdC9zeXNjYWxscyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMSArCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
dW5saW5rLy5naXRpZ25vcmUgfCAgIDEgKwo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vu
bGluay91bmxpbmswOS5jIHwgMTAyICsrKysrKysrKysrKysrKysrKysrCj4gIDMgZmlsZXMgY2hh
bmdlZCwgMTA0IGluc2VydGlvbnMoKykKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvdW5saW5rL3VubGluazA5LmMKPiAKPiBkaWZmIC0tZ2l0IGEvcnVudGVz
dC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBpbmRleCA0ZWQyYjU2MDIuLmI5OWNlNzE3
MCAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxs
cwo+IEBAIC0xNjUxLDYgKzE2NTEsNyBAQCB1bmxpbmswMSBzeW1saW5rMDEgLVQgdW5saW5rMDEK
PiAgdW5saW5rMDUgdW5saW5rMDUKPiAgdW5saW5rMDcgdW5saW5rMDcKPiAgdW5saW5rMDggdW5s
aW5rMDgKPiArdW5saW5rMDkgdW5saW5rMDkKPiAKPiAgI3VubGlua2F0IHRlc3QgY2FzZXMKPiAg
dW5saW5rYXQwMSB1bmxpbmthdDAxCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvdW5saW5rLy5naXRpZ25vcmUKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5s
aW5rLy5naXRpZ25vcmUgaW5kZXggMmU3ODM1ODBkLi42MDM4Y2MyOWQKPiAxMDA2NDQKPiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3VubGluay8uZ2l0aWdub3JlCj4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsvLmdpdGlnbm9yZQo+IEBAIC0xLDMgKzEsNCBA
QAo+ICAvdW5saW5rMDUKPiAgL3VubGluazA3Cj4gIC91bmxpbmswOAo+ICsvdW5saW5rMDkKPiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsvdW5saW5rMDkuYwo+
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsvdW5saW5rMDkuYyBuZXcgZmlsZSBt
b2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uM2FiNDc4ZTUwCj4gLS0tIC9kZXYvbnVsbAo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5saW5rL3VubGluazA5LmMKPiBAQCAt
MCwwICsxLDEwMiBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1s
YXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQgRlVKSVRTVSBMSU1JVEVELiBBbGwg
UmlnaHRzIFJlc2VydmVkLgo+ICsgKiBBdXRob3I6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVq
aXRzdS5jb20+Cj4gKyAqLwo+ICsKPiArLypcCj4gKyAqIFtEZXNjcmlwdGlvbl0KPiArICoKPiAr
ICogVmVyaWZ5IHRoYXQgdW5saW5rKDIpIGZhaWxzIHdpdGgKPiArICoKPiArICogLSBFUEVSTSB3
aGVuIHRhcmdldCBmaWxlIGlzIG1hcmtlZCBhcyBpbW11dGFibGUgb3IgYXBwZW5kLW9ubHkKPiAr
ICogLSBFUk9GUyB3aGVuIHRhcmdldCBmaWxlIGlzIG9uIGEgcmVhZC1vbmx5IGZpbGVzeXN0ZW0u
Cj4gKyAqLwo+ICsKPiArI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgo+ICsjaW5jbHVkZSAidHN0X3Rl
c3QuaCIKPiArI2luY2x1ZGUgImxhcGkvZnMuaCIKPiArCj4gKyNkZWZpbmUgVEVTVF9FUEVSTV9J
TU1VVEFCTEUgInRlc3RfZXBlcm1faW1tdXRhYmxlIgo+ICsjZGVmaW5lIFRFU1RfRVBFUk1fQVBQ
RU5EX09OTFkgInRlc3RfZXBlcm1fYXBwZW5kX29ubHkiCj4gKyNkZWZpbmUgRElSX0VST0ZTICJl
cm9mcyIKPiArI2RlZmluZSBURVNUX0VST0ZTICJlcm9mcy90ZXN0X2Vyb2ZzIgo+ICsKPiArc3Rh
dGljIGludCBmZF9pbW11dGFibGU7Cj4gK3N0YXRpYyBpbnQgZmRfYXBwZW5kX29ubHk7Cj4gKwo+
ICtzdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHsKPiArCWNoYXIgKmZpbGVuYW1lOwo+ICsJaW50
ICpmZDsKPiArCWludCBmbGFnOwo+ICsJaW50IGV4cGVjdGVkX2Vycm5vOwo+ICsJY2hhciAqZGVz
YzsKPiArfSB0Y2FzZXNbXSA9IHsKPiArCXtURVNUX0VQRVJNX0lNTVVUQUJMRSwgJmZkX2ltbXV0
YWJsZSwgRlNfSU1NVVRBQkxFX0ZMLCBFUEVSTSwKPiArCQkidGFyZ2V0IGZpbGUgaXMgaW1tdXRh
YmxlIn0sCj4gKwl7VEVTVF9FUEVSTV9BUFBFTkRfT05MWSwgJmZkX2FwcGVuZF9vbmx5LCBGU19B
UFBFTkRfRkwsIEVQRVJNLAo+ICsJCSJ0YXJnZXQgZmlsZSBpcyBhcHBlbmQtb25seSJ9LAo+ICsJ
e1RFU1RfRVJPRlMsIE5VTEwsIDAsIEVST0ZTLCAidGFyZ2V0IGZpbGUgaW4gcmVhZC1vbmx5IGZp
bGVzeXN0ZW0ifSwKPiArfTsKPiArCj4gK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gK3sKPiAr
CWludCBhdHRyOwo+ICsKPiArCWZkX2ltbXV0YWJsZSA9IFNBRkVfT1BFTihURVNUX0VQRVJNX0lN
TVVUQUJMRSwgT19DUkVBVCwgMDYwMCk7Cj4gKwlTQUZFX0lPQ1RMKGZkX2ltbXV0YWJsZSwgRlNf
SU9DX0dFVEZMQUdTLCAmYXR0cik7Cj4gKwlhdHRyIHw9IEZTX0lNTVVUQUJMRV9GTDsKPiArCVNB
RkVfSU9DVEwoZmRfaW1tdXRhYmxlLCBGU19JT0NfU0VURkxBR1MsICZhdHRyKTsKPiArCj4gKwlm
ZF9hcHBlbmRfb25seSA9IFNBRkVfT1BFTihURVNUX0VQRVJNX0FQUEVORF9PTkxZLCBPX0NSRUFU
LCAwNjAwKTsKPiArCVNBRkVfSU9DVEwoZmRfYXBwZW5kX29ubHksIEZTX0lPQ19HRVRGTEFHUywg
JmF0dHIpOwo+ICsJYXR0ciB8PSBGU19BUFBFTkRfRkw7Cj4gKwlTQUZFX0lPQ1RMKGZkX2FwcGVu
ZF9vbmx5LCBGU19JT0NfU0VURkxBR1MsICZhdHRyKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQg
Y2xlYW51cCh2b2lkKQo+ICt7Cj4gKwlpbnQgYXR0cjsKPiArCj4gKwlTQUZFX0lPQ1RMKGZkX2lt
bXV0YWJsZSwgRlNfSU9DX0dFVEZMQUdTLCAmYXR0cik7Cj4gKwlhdHRyICY9IH5GU19JTU1VVEFC
TEVfRkw7Cj4gKwlTQUZFX0lPQ1RMKGZkX2ltbXV0YWJsZSwgRlNfSU9DX1NFVEZMQUdTLCAmYXR0
cik7Cj4gKwlTQUZFX0NMT1NFKGZkX2ltbXV0YWJsZSk7Cj4gKwo+ICsJU0FGRV9JT0NUTChmZF9h
cHBlbmRfb25seSwgRlNfSU9DX0dFVEZMQUdTLCAmYXR0cik7Cj4gKwlhdHRyICY9IH5GU19BUFBF
TkRfRkw7Cj4gKwlTQUZFX0lPQ1RMKGZkX2FwcGVuZF9vbmx5LCBGU19JT0NfU0VURkxBR1MsICZh
dHRyKTsKPiArCVNBRkVfQ0xPU0UoZmRfYXBwZW5kX29ubHkpOwo+ICt9Cj4gKwo+ICtzdGF0aWMg
dm9pZCB2ZXJpZnlfdW5saW5rKHVuc2lnbmVkIGludCBpKQo+ICt7Cj4gKwlzdHJ1Y3QgdGVzdF9j
YXNlX3QgKnRjID0gJnRjYXNlc1tpXTsKPiArCWludCBhdHRyOwo+ICsKPiArCVRTVF9FWFBfRkFJ
TCh1bmxpbmsodGMtPmZpbGVuYW1lKSwgdGMtPmV4cGVjdGVkX2Vycm5vLCAiJXMiLCB0Yy0+ZGVz
Yyk7Cj4gKwo+ICsJLyogSWYgdW5saW5rKCkgc3VjZWVkZWQgdW5leHBlY3RlZGx5LCB0ZXN0IGZp
bGUgc2hvdWxkIGJlIHJldG9yZWQuICovCnMvc3VjZWVkZWQvc3VjY2VlZGVkCnMvcmV0b3JlZC9y
ZXN0b3JlZAo+ICsJaWYgKCFUU1RfUkVUKSB7Cj4gKwkJaWYgKHRjLT5mZCkgewo+ICsJCQkqKHRj
LT5mZCkgPSBTQUZFX09QRU4odGMtPmZpbGVuYW1lLCBPX0NSRUFULCAwNjAwKTsKPiArCQkJaWYg
KHRjLT5mbGFnKSB7Cj4gKwkJCQlTQUZFX0lPQ1RMKCoodGMtPmZkKSwgRlNfSU9DX0dFVEZMQUdT
LCAmYXR0cik7Cj4gKwkJCQlhdHRyIHw9IHRjLT5mbGFnOwo+ICsJCQkJU0FGRV9JT0NUTCgqKHRj
LT5mZCksIEZTX0lPQ19TRVRGTEFHUywgJmF0dHIpOwo+ICsJCQl9Cj4gKwkJfSBlbHNlIHsKPiAr
CQkJU0FGRV9UT1VDSCh0Yy0+ZmlsZW5hbWUsIDA2MDAsIDApOwo+ICsJCX0KPiArCX0KPiArfQo+
ICsKPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsJLnNldHVwID0gc2V0dXAs
Cj4gKwkudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKSwKPiArCS5jbGVhbnVwID0gY2xlYW51cCwK
PiArCS50ZXN0ID0gdmVyaWZ5X3VubGluaywKPiArCS5uZWVkc19yb2ZzID0gMSwKPiArCS5tbnRw
b2ludCA9IERJUl9FUk9GUywKPiArCS5uZWVkc19yb290ID0gMSwKPiArfTsKClJlZ2FyZHMsCkF2
aW5lc2gKCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
