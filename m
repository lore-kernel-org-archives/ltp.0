Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AB3C67861
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 15:14:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ED683CF600
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 17:14:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 095763CF5ED
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 17:14:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 401841001F59
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 17:14:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75A3522A1B;
 Mon,  8 Apr 2024 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712589244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFQW7LPPJblAr41yg0P78nE3lKBDnDyOAuC0nblk6mY=;
 b=V4/uaVJOs8MrwSNwV/9t46M6ZmASCIo6qPL/7aAhIY/OsOJ/pHBdf6KqUxZB1JcgKSPVY/
 ZpgAWv1GIGF444MUS3omet3I/NFg/1yhUW0V2psv7IumUNjDOOdfW8WfNCxkA5x5YB8QGT
 iminscu/2luOuABFnRb5PpoZzypFplE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712589244;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFQW7LPPJblAr41yg0P78nE3lKBDnDyOAuC0nblk6mY=;
 b=4OABYQe1LnamV/ubTay1go3bGIOlClAdgAhJ1pf4ncIuaIYnhCfaDB/MWFpEXl0wgQ6iCW
 HUdT0LkF8i3H7cDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="V4/uaVJO";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4OABYQe1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712589244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFQW7LPPJblAr41yg0P78nE3lKBDnDyOAuC0nblk6mY=;
 b=V4/uaVJOs8MrwSNwV/9t46M6ZmASCIo6qPL/7aAhIY/OsOJ/pHBdf6KqUxZB1JcgKSPVY/
 ZpgAWv1GIGF444MUS3omet3I/NFg/1yhUW0V2psv7IumUNjDOOdfW8WfNCxkA5x5YB8QGT
 iminscu/2luOuABFnRb5PpoZzypFplE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712589244;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFQW7LPPJblAr41yg0P78nE3lKBDnDyOAuC0nblk6mY=;
 b=4OABYQe1LnamV/ubTay1go3bGIOlClAdgAhJ1pf4ncIuaIYnhCfaDB/MWFpEXl0wgQ6iCW
 HUdT0LkF8i3H7cDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E3BA13675;
 Mon,  8 Apr 2024 15:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dkU8FrwJFGaTVAAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 08 Apr 2024 15:14:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 08 Apr 2024 17:14:03 +0200
Message-ID: <2511807.XAFRqVoOGU@localhost>
Organization: SUSE
In-Reply-To: <20240401024948.8703-1-xuyang2018.jy@fujitsu.com>
References: <20240401024948.8703-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; HAS_ORG_HEADER(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 75A3522A1B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unlink: Add error tests for EPERM and EROFS
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

SGkgWWFuZyBYdSwKc29tZSBjb21tZW50cyBiZWxvdwoKT24gTW9uZGF5LCBBcHJpbCAxLCAyMDI0
IDQ6NDk6NDjigK9BTSBDRVNUIFlhbmcgWHUgdmlhIGx0cCB3cm90ZToKPiBBZGQgbmVnYXRpdmUg
Y2FzZXMgZm9yIHVubGluaygpLCB3aGVuIGVycm5vIGlzIEVQRVJNIG9yIEVST0ZTLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+Cj4gLS0tCj4g
IHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArCj4gIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5saW5rLy5naXRpZ25vcmUgfCAgMSArCj4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5saW5rL3VubGluazA5LmMgfCA4NiArKysrKysrKysrKysr
KysrKysrKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCA4OCBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3VubGluay91bmxpbmswOS5jCj4g
Cj4gZGlmZiAtLWdpdCBhL3J1bnRlc3Qvc3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzCj4gaW5k
ZXggNGVkMmI1NjAyLi5iOTljZTcxNzAgMTAwNjQ0Cj4gLS0tIGEvcnVudGVzdC9zeXNjYWxscwo+
ICsrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBAQCAtMTY1MSw2ICsxNjUxLDcgQEAgdW5saW5rMDEg
c3ltbGluazAxIC1UIHVubGluazAxCj4gIHVubGluazA1IHVubGluazA1Cj4gIHVubGluazA3IHVu
bGluazA3Cj4gIHVubGluazA4IHVubGluazA4Cj4gK3VubGluazA5IHVubGluazA5Cj4gCj4gICN1
bmxpbmthdCB0ZXN0IGNhc2VzCj4gIHVubGlua2F0MDEgdW5saW5rYXQwMQo+IGRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3VubGluay8uZ2l0aWdub3JlCj4gYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3VubGluay8uZ2l0aWdub3JlIGluZGV4IDJlNzgzNTgwZC4uNjAz
OGNjMjlkCj4gMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bmxpbmsv
LmdpdGlnbm9yZQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5saW5rLy5naXRp
Z25vcmUKPiBAQCAtMSwzICsxLDQgQEAKPiAgL3VubGluazA1Cj4gIC91bmxpbmswNwo+ICAvdW5s
aW5rMDgKPiArL3VubGluazA5Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvdW5saW5rL3VubGluazA5LmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5saW5r
L3VubGluazA5LmMgbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAuLmI3ZmY5
NGVlNgo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vu
bGluay91bmxpbmswOS5jCj4gQEAgLTAsMCArMSw4NiBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQg
RlVKSVRTVSBMSU1JVEVELiBBbGwgUmlnaHRzIFJlc2VydmVkLgo+ICsgKiBBdXRob3I6IFlhbmcg
WHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+Cj4gKyAqLwo+ICsKPiArLypcCj4gKyAqIFtE
ZXNjcmlwdGlvbl0KPiArICoKPiArICogVmVyaWZ5IHRoYXQgdW5saW5rKDIpIGZhaWxzIHdpdGgK
PiArICoKPiArICogLSBFUEVSTSB3aGVuIHRhcmdldCBmaWxlIGlzIG1hcmtlZCBhcyBpbW11dGFi
bGUgb3IgYXBwZW5kLW9ubHkKPiArICogLSBFUk9GUyB3aGVuIHRhcmdldCBmaWxlIGlzIG9uIGEg
cmVhZC1vbmx5IGZpbGVzeXN0ZW0uCj4gKyAqLwo+ICsKPiArI2luY2x1ZGUgPGVycm5vLmg+Cj4g
KyNpbmNsdWRlIDx1bmlzdGQuaD4KPiArI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgo+ICsjaW5jbHVk
ZSAidHN0X3Rlc3QuaCIKPiArI2luY2x1ZGUgInRzdF9zYWZlX21hY3Jvcy5oIgo+ICsjaW5jbHVk
ZSAibGFwaS9mcy5oIgplcnJuby5oLCB1bmlzdGQuaCwgaW9jdGwuaCBhbmQgdHN0X3NhZmVfbWFj
cm9zLmggaGVhZGVycyBhcmUgYWxyZWFkeSBpbmNsdWRlZAp2aWEgdHN0X3Rlc3QuaAogCj4gKwo+
ICsjZGVmaW5lIFRFU1RfRVBFUk1fSU1NVVRBQkxFICJ0ZXN0X2VwZXJtX2ltbXV0YWJsZSIKPiAr
I2RlZmluZSBURVNUX0VQRVJNX0FQUEVORF9PTkxZICJ0ZXN0X2VwZXJtX2FwcGVuZF9vbmx5Igo+
ICsjZGVmaW5lIERJUl9FUk9GUyAiZXJvZnMiCj4gKyNkZWZpbmUgVEVTVF9FUk9GUyAiZXJvZnMv
dGVzdF9lcm9mcyIKPiArCj4gK3N0YXRpYyBpbnQgZmRfaW1tdXRhYmxlOwo+ICtzdGF0aWMgaW50
IGZkX2FwcGVuZF9vbmx5Owo+ICsKPiArc3RhdGljIHN0cnVjdCB0ZXN0X2Nhc2VfdCB7Cj4gKwlj
aGFyICpmaWxlbmFtZTsKPiArCWludCBleHBlY3RlZF9lcnJubzsKPiArCWNoYXIgKmRlc2M7Cj4g
K30gdGNhc2VzW10gPSB7Cj4gKwl7VEVTVF9FUEVSTV9JTU1VVEFCTEUsIEVQRVJNLCAidGFyZ2V0
IGZpbGUgaXMgaW1tdXRhYmxlIn0sCj4gKwl7VEVTVF9FUEVSTV9BUFBFTkRfT05MWSwgRVBFUk0s
ICJ0YXJnZXQgZmlsZSBpcyBhcHBlbmQtb25seSJ9LAo+ICsJe1RFU1RfRVJPRlMsIEVST0ZTLCAi
dGFyZ2V0IGZpbGUgaW4gcmVhZC1vbmx5IGZpbGVzeXN0ZW0ifSwKPiArfTsKPiArCj4gK3N0YXRp
YyB2b2lkIHNldHVwKHZvaWQpCj4gK3sKPiArCWludCBhdHRyOwo+ICsKPiArCWZkX2ltbXV0YWJs
ZSA9IFNBRkVfT1BFTihURVNUX0VQRVJNX0lNTVVUQUJMRSwgT19DUkVBVCwgMDYwMCk7Cj4gKwlp
b2N0bChmZF9pbW11dGFibGUsIEZTX0lPQ19HRVRGTEFHUywgJmF0dHIpOwo+ICsJYXR0ciB8PSBG
U19JTU1VVEFCTEVfRkw7Cj4gKwlpb2N0bChmZF9pbW11dGFibGUsIEZTX0lPQ19TRVRGTEFHUywg
JmF0dHIpOwo+ICsKPiArCWZkX2FwcGVuZF9vbmx5ID0gU0FGRV9PUEVOKFRFU1RfRVBFUk1fQVBQ
RU5EX09OTFksIE9fQ1JFQVQsIDA2MDApOwo+ICsJaW9jdGwoZmRfYXBwZW5kX29ubHksIEZTX0lP
Q19HRVRGTEFHUywgJmF0dHIpOwo+ICsJYXR0ciB8PSBGU19BUFBFTkRfRkw7Cj4gKwlpb2N0bChm
ZF9hcHBlbmRfb25seSwgRlNfSU9DX1NFVEZMQUdTLCAmYXR0cik7CldlIGNhbiB1c2UgU0FGRV9J
T0NUTCgpIGluIGFsbCBwbGFjZXMuCj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIGNsZWFudXAodm9p
ZCkKPiArewo+ICsJaW50IGF0dHI7Cj4gKwo+ICsJaW9jdGwoZmRfaW1tdXRhYmxlLCBGU19JT0Nf
R0VURkxBR1MsICZhdHRyKTsKPiArCWF0dHIgJj0gfkZTX0lNTVVUQUJMRV9GTDsKPiArCWlvY3Rs
KGZkX2ltbXV0YWJsZSwgRlNfSU9DX1NFVEZMQUdTLCAmYXR0cik7Cj4gKwlTQUZFX0NMT1NFKGZk
X2ltbXV0YWJsZSk7Cj4gKwo+ICsJaW9jdGwoZmRfYXBwZW5kX29ubHksIEZTX0lPQ19HRVRGTEFH
UywgJmF0dHIpOwo+ICsJYXR0ciAmPSB+RlNfQVBQRU5EX0ZMOwo+ICsJaW9jdGwoZmRfYXBwZW5k
X29ubHksIEZTX0lPQ19TRVRGTEFHUywgJmF0dHIpOwo+ICsJU0FGRV9DTE9TRShmZF9hcHBlbmRf
b25seSk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHZlcmlmeV91bmxpbmsodW5zaWduZWQgaW50
IGkpCj4gK3sKPiArCXN0cnVjdCB0ZXN0X2Nhc2VfdCAqdGMgPSAmdGNhc2VzW2ldOwo+ICsKPiAr
CVRTVF9FWFBfRkFJTCh1bmxpbmsodGMtPmZpbGVuYW1lKSwgdGMtPmV4cGVjdGVkX2Vycm5vLCAi
JXMiLCB0Yy0+ZGVzYyk7CklmIGZvciB3aGF0ZXZlciByZWFzb24sIHVubGluaygpIGNhbGwgcGFz
c2VzIGhlcmUsIGZ1cnRoZXIgdGVzdCBpdGVyYXRpb25zCndpbGwgbm90IHdvcmsgY29ycmVjdGx5
IGFzIHRlc3QgZmlsZSBubyBsb25nZXIgZXhpc3QuIEkgZ3Vlc3Mgd2UgbmVlZCB0byBoYW5kbGUK
dGhlIHJlc3RvcmluZyBpbiB0aGlzIG1haW4gdGVzdCBmdW5jdGlvbi4gQW5kIGNsZWFudXAoKSBk
b2VzIG5vdCBuZWVkIHRvIHJlc2V0CmFueSBmbGFncyBhcyBpdCBpcyBjYWxsZWQgb25seSBvbmNl
IGFmdGVyIGFsbCB0aGUgaXRlcmF0aW9ucy4KCj4gK30KPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdHN0
X3Rlc3QgdGVzdCA9IHsKPiArCS5zZXR1cCA9IHNldHVwLAo+ICsJLnRjbnQgPSBBUlJBWV9TSVpF
KHRjYXNlcyksCj4gKwkuY2xlYW51cCA9IGNsZWFudXAsCj4gKwkudGVzdCA9IHZlcmlmeV91bmxp
bmssCj4gKwkubmVlZHNfcm9mcyA9IDEsCj4gKwkubW50cG9pbnQgPSBESVJfRVJPRlMsCj4gKwku
bmVlZHNfcm9vdCA9IDEsCj4gK307CgoKUmVnYXJkcywKQXZpbmVzaAoKCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
