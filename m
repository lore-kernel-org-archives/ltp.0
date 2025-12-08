Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07756D3B7E2
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 11:51:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5957A3CF2F8
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 12:51:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B35ED3C064C
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 12:51:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 378E81000434
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 12:51:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40ADA5BEB3;
 Mon,  8 Dec 2025 11:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765194695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/6XLuXIyxSHTizVr9G6rhdrrvw6Rwsd0lYSIuuH0bI=;
 b=eJypT0pmz8JVPRFA9uMsiyx2GXQmegwIhT77ywFxZRAZ5LmsBq2yuUO/Vk0PwGrNSOSrfG
 mf8lt/KKBDnsj1/5EfAsQPV1uZ9UtlHdyxnS96pDkbAVMHH+KFxS2ZDGe1IVde6rnYTkwX
 4Mcsvu81euFOnRvWvkJJcLH6wVziWZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765194695;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/6XLuXIyxSHTizVr9G6rhdrrvw6Rwsd0lYSIuuH0bI=;
 b=RiIUMj1iYW41dCj9MusB4EGuXJSE2coDjGDQMavHbdb8vVnIBaaQZLzdDCZF/fkFIq58cT
 kC4rfCKrvJ8fscDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=elB+k+E4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bBJMITEx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765194694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/6XLuXIyxSHTizVr9G6rhdrrvw6Rwsd0lYSIuuH0bI=;
 b=elB+k+E412S3tVhJXk6M79yG8TxwEPzfBYwRGJL3YYT54mCS4RClquFTW+XMMluWnIzi2C
 TEJ1QLfJyKoYMWGSWfUNGzB1jbff0jEp2g3wi1LF28WNZi1BSSPBeHb+vUJwiwQuKy/PE4
 1SbMe7N8uoFbNpqFvh2qW7rf3X6zUJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765194694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/6XLuXIyxSHTizVr9G6rhdrrvw6Rwsd0lYSIuuH0bI=;
 b=bBJMITExlfXhQPOCDDfIe8NJaeiPfbbEB/aHifo6kRBcsXzx6vor76PuDWVSuEItr4a1v3
 ZbhaH7j8CkcyqeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 086683EA63;
 Mon,  8 Dec 2025 11:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iyTzAMa7NmmYIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Dec 2025 11:51:34 +0000
Date: Mon, 8 Dec 2025 12:51:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251208115132.GB683201@pevik>
References: <20251127143959.9416-1-wegao@suse.com>
 <CAEemH2c648sBs9LJmQBGRi-OY6s6p-ju-nAzHLGL2uzoiJTiag@mail.gmail.com>
 <aSlRR21MVU1tq-6T@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aSlRR21MVU1tq-6T@autotest-wegao.qe.prg2.suse.org>
X-Rspamd-Queue-Id: 40ADA5BEB3
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[configure.ac:url,suse.cz:dkim,suse.cz:replyto,linux.it:email,linux.it:url,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,configure.ac:url,suse.cz:dkim,suse.cz:replyto,linux.it:email,linux.it:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrei Vagin <avagin@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKZmlyc3QsIHdlIGhhdmUgYSBkaWZmZXJlbnQgcGF0Y2ggaW5jcmVhc2luZyB2YWx1
ZSB0byA2LjExLgpodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNTEyMDMwODEyMjYuMTE0
ODIzNi0xLW1hc2FoaXJvLnlhbWFkYUBjYW5vbmljYWwuY29tLwoKPiBPbiBGcmksIE5vdiAyOCwg
MjAyNSBhdCAxMToyNjowN0FNICswODAwLCBMaSBXYW5nIHdyb3RlOgo+ID4gSGkgV2VpLAoKCj4g
PiBPbiBUaHUsIE5vdiAyNywgMjAyNSBhdCA5OjQx4oCvQU0gV2VpIEdhbyB2aWEgbHRwIDxsdHBA
bGlzdHMubGludXguaXQ+IHdyb3RlOgoKPiA+ID4gTmV3IGtlcm5lbCBjb21taXQgbGVhZCB0ZXN0
IGNhc2UgZmFpbHVyZSB3aXRoIGZvbGxvd2luZyBlcnJvciBtZXNzYWdlOgo+ID4gPiBsaXN0bW91
bnQwNC5jOjEyODogVEZBSUw6IGludmFsaWQgbW50X2lkX3JlcS5zcGFyZSBleHBlY3RlZCBFSU5W
QUw6IEVCQURGCj4gPiA+ICg5KQoKPiA+ID4gRGV0YWlsIG9mIG5ldyBrZXJuZWwgY29tbWl0Ogo+
ID4gPiBjb21taXQ6IDc4ZjBlMzNjZDZjOTM5YTU1NWFhODBkYmVkMmZlYzZiMzMzYTc2NjAKPiA+
ID4gZnMvbmFtZXNwYWNlOiBjb3JyZWN0bHkgaGFuZGxlIGVycm9ycyByZXR1cm5lZCBieSBncmFi
X3JlcXVlc3RlZF9tbnRfbnMKCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1
c2UuY29tPgo+ID4gPiAtLS0KPiA+ID4gIGNvbmZpZ3VyZS5hYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMSArCj4gPiA+ICAuLi4va2VybmVsL3N5c2NhbGxzL2xpc3Rtb3Vu
dC9saXN0bW91bnQwNC5jICAgIHwgMTggKysrKysrKysrKysrLS0tLS0tCj4gPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgo+ID4gPiBkaWZmIC0t
Z2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJlLmFjCj4gPiA+IGluZGV4IDA0ODBmNDZjYS4u
ZmNmZjkwNzk5IDEwMDY0NAo+ID4gPiAtLS0gYS9jb25maWd1cmUuYWMKPiA+ID4gKysrIGIvY29u
ZmlndXJlLmFjCj4gPiA+IEBAIC0yNjMsNiArMjYzLDcgQEAgQUNfQ0hFQ0tfVFlQRVMoW3N0cnVj
dCBjYWNoZXN0YXRdLCwsWyNpbmNsdWRlCj4gPiA+IDxzeXMvbW1hbi5oPl0pCgo+ID4gPiAgIyBE
ZWZpbmVkIGluIDxsaW51eC9tb3VudC5oPiwgYnV0IGluY2x1ZGUvbGFwaS9tb3VudC5oIGluY2x1
ZGVzCj4gPiA+IDxzeXMvbW91bnQuaD4gKi8KPiA+ID4gIEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3Qg
bW50X2lkX3JlcV0sLCxbI2luY2x1ZGUgPHN5cy9tb3VudC5oPl0pCj4gPiA+ICtBQ19DSEVDS19N
RU1CRVJTKFtzdHJ1Y3QgbW50X2lkX3JlcS5tbnRfbnNfZmRdLCwsWyNpbmNsdWRlIDxzeXMvbW91
bnQuaD5dKQo+ID4gPiAgQUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBzdGF0bW91bnRdLCwsWyNpbmNs
dWRlIDxzeXMvbW91bnQuaD5dKQo+ID4gPiAgQUNfQ0hFQ0tfTUVNQkVSUyhbc3RydWN0IHN0YXRt
b3VudC5tbnRfbnNfaWRdLCwsWyNpbmNsdWRlIDx1bmlzdGQuaD4KPiA+ID4gICNpbmNsdWRlIDxs
aW51eC9tb3VudC5oPl0pCj4gPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2xpc3Rtb3VudC9saXN0bW91bnQwNC5jCj4gPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9saXN0bW91bnQvbGlzdG1vdW50MDQuYwo+ID4gPiBpbmRleCBhNTJiYWQwNjQuLjNiZTNi
ZTRmMiAxMDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saXN0bW91
bnQvbGlzdG1vdW50MDQuYwo+ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xp
c3Rtb3VudC9saXN0bW91bnQwNC5jCj4gPiA+IEBAIC0xOCw2ICsxOCw3IEBACj4gPiA+ICAjaW5j
bHVkZSAibGFwaS9tb3VudC5oIgo+ID4gPiAgI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKCj4g
PiA+ICsjaWZkZWYgSEFWRV9TVFJVQ1RfTU5UX0lEX1JFUV9NTlRfTlNfRkQKPiA+ID4gICNkZWZp
bmUgTU5UX1NJWkUgMzIKCj4gPiA+ICBzdGF0aWMgc3RydWN0IG1udF9pZF9yZXEgKnJlcXVlc3Q7
Cj4gPiA+IEBAIC0yNiw3ICsyNyw3IEBAIHN0YXRpYyB1aW50NjRfdCBtbnRfaWRzW01OVF9TSVpF
XTsKPiA+ID4gIHN0YXRpYyBzdHJ1Y3QgdGNhc2Ugewo+ID4gPiAgICAgICAgIGludCByZXFfdXNh
Z2U7Cj4gPiA+ICAgICAgICAgdWludDMyX3Qgc2l6ZTsKPiA+ID4gLSAgICAgICB1aW50MzJfdCBz
cGFyZTsKPiA+ID4gKyAgICAgICB1aW50MzJfdCBtbnRfbnNfZmQ7Cj4gPiA+ICAgICAgICAgdWlu
dDY0X3QgbW50X2lkOwo+ID4gPiAgICAgICAgIHVpbnQ2NF90IHBhcmFtOwo+ID4gPiAgICAgICAg
IHVpbnQ2NF90ICptbnRfaWRzOwo+ID4gPiBAQCAtNzMsMTIgKzc0LDEyIEBAIHN0YXRpYyBzdHJ1
Y3QgdGNhc2Ugewo+ID4gPiAgICAgICAgIHsKPiA+ID4gICAgICAgICAgICAgICAgIC5yZXFfdXNh
Z2UgPSAxLAo+ID4gPiAgICAgICAgICAgICAgICAgLnNpemUgPSBNTlRfSURfUkVRX1NJWkVfVkVS
MCwKPiA+ID4gLSAgICAgICAgICAgICAgIC5zcGFyZSA9IC0xLAo+ID4gPiArICAgICAgICAgICAg
ICAgLm1udF9uc19mZCA9IC0xLAo+ID4gPiAgICAgICAgICAgICAgICAgLm1udF9pZCA9IExTTVRf
Uk9PVCwKPiA+ID4gICAgICAgICAgICAgICAgIC5tbnRfaWRzID0gbW50X2lkcywKPiA+ID4gICAg
ICAgICAgICAgICAgIC5ucl9tbnRfaWRzID0gTU5UX1NJWkUsCj4gPiA+IC0gICAgICAgICAgICAg
ICAuZXhwX2Vycm5vID0gRUlOVkFMLAo+ID4gPiAtICAgICAgICAgICAgICAgLm1zZyA9ICJpbnZh
bGlkIG1udF9pZF9yZXEuc3BhcmUiLAo+ID4gPiArICAgICAgICAgICAgICAgLmV4cF9lcnJubyA9
IEVCQURGLAo+ID4gPiArICAgICAgICAgICAgICAgLm1zZyA9ICJpbnZhbGlkIG1udF9pZF9yZXEu
bW50X25zX2ZkIGJhZCBmaWxlIGRlc2NyaXB0b3IiLAo+ID4gPiAgICAgICAgIH0sCj4gPiA+ICAg
ICAgICAgewo+ID4gPiAgICAgICAgICAgICAgICAgLnJlcV91c2FnZSA9IDEsCj4gPiA+IEBAIC0x
MjIsNyArMTIzLDcgQEAgc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBuKQo+ID4gPiAgICAg
ICAgICAgICAgICAgcmVxLT5tbnRfaWQgPSB0Yy0+bW50X2lkOwo+ID4gPiAgICAgICAgICAgICAg
ICAgcmVxLT5wYXJhbSA9IHRjLT5wYXJhbTsKPiA+ID4gICAgICAgICAgICAgICAgIHJlcS0+c2l6
ZSA9IHRjLT5zaXplOwo+ID4gPiAtICAgICAgICAgICAgICAgcmVxLT5zcGFyZSA9IHRjLT5zcGFy
ZTsKPiA+ID4gKyAgICAgICAgICAgICAgIHJlcS0+bW50X25zX2ZkID0gdGMtPm1udF9uc19mZDsK
PiA+ID4gICAgICAgICB9Cgo+ID4gPiAgICAgICAgIFRTVF9FWFBfRkFJTCh0c3Rfc3lzY2FsbChf
X05SX2xpc3Rtb3VudCwgcmVxLCB0Yy0+bW50X2lkcywKPiA+ID4gQEAgLTEzMyw5ICsxMzQsMTQg
QEAgc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBuKQo+ID4gPiAgc3RhdGljIHN0cnVjdCB0
c3RfdGVzdCB0ZXN0ID0gewo+ID4gPiAgICAgICAgIC50ZXN0ID0gcnVuLAo+ID4gPiAgICAgICAg
IC50Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMpLAo+ID4gPiAtICAgICAgIC5taW5fa3ZlciA9ICI2
LjgiLAo+ID4gPiArICAgICAgIC5taW5fa3ZlciA9ICI2LjE4IiwKCgpGWUkgdGhpcyBpcyBhIHJ1
bnRpbWUgY2hlY2ssIGJ1dCB0aGUgcHJvYmxlbSBpcyB3aXRoIGtlcm5lbCBoZWFkZXJzLgppbmNs
dWRlL2xhcGkvbW91bnQuaCBbMV0gdXNlcyA8c3lzL21vdW50Lmg+IChzZWUgTFRQIGluY2x1ZGUv
bGFwaS9tb3VudC5oIFsxXQphbmQgdGhlIHJlYXNvbiB3aHkgd2UgZGlkIGVuZHVwIHVzaW5nIDxz
eXMvbW91bnQuaD4gaW5zdGVhZCBvZiA8bGludXgvbW91bnQuaD4KWzJdIFszXSksIGJ1dCBnbGli
YyAoc2luY2UgY2VydGFpbiB2ZXJzaW9uLCB1bmxpa2UgbXVzbCkgaW5jbHVkZXMgPGxpbnV4L21v
dW50Lmg+LgpUaGVyZWZvcmUgd2hpbGUgdGhlIHByb2JsZW0gaXMgb24gY3VycmVudCBEZWJpYW4g
dGVzdGluZyB3aXRoIGxpbnV4LWxpYmMtZGV2IGFsbAo2LjE3LjktMSAoaXQgd2FzIHdvcmtpbmcg
aW4gcHJldmlvdXMgYnVpbGRzIHdpdGggbGludXgtbGliYy1kZXYgYWxsIDYuMTcuOC0xKS4KQnV0
IE9UT0ggbXkgb3BlblNVU0UgVHVtYmxld2VlZCBWTSB3aXRoIDYuMTguMC1yYzYtNC5nZmVhMGQ5
NyB3b3JrcyB3aXRob3V0IHRoaXMKcGF0Y2guIEFsc28gU0xFMTYgd2l0aCA2LjEyIGJhc2VkIGtl
cm5lbCB3b3JrcyB3aXRob3V0IHRoaXMgcGF0Y2guCgp0c3RfdGVzdC5jOjIwMjg6IFRJTkZPOiBU
ZXN0ZWQga2VybmVsOiA2LjE4LjAtcmM2LTQuZ2ZlYTBkOTctZGVmYXVsdCAjMSBTTVAgUFJFRU1Q
VF9EWU5BTUlDIFNhdCBOb3YgMjIgMTk6NDY6NTUgVVRDIDIwMjUgKGZlYTBkOTcpIHg4Nl82NAp0
c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25m
aWcuZ3onCnRzdF9rY29uZmlnLmM6Njc2OiBUSU5GTzogQ09ORklHX0ZBVUxUX0lOSkVDVElPTiBr
ZXJuZWwgb3B0aW9uIGRldGVjdGVkIHdoaWNoIG1pZ2h0IHNsb3cgdGhlIGV4ZWN1dGlvbgp0c3Rf
dGVzdC5jOjE4NDY6IFRJTkZPOiBPdmVyYWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMm0gMDBz
Cmxpc3Rtb3VudDA0LmM6MTI4OiBUUEFTUzogcmVxdWVzdCBwb2ludHMgdG8gdW5hY2Nlc3NpYmxl
IG1lbW9yeSA6IEVGQVVMVCAoMTQpCmxpc3Rtb3VudDA0LmM6MTI4OiBUUEFTUzogbW50X2lkcyBw
b2ludHMgdG8gdW5hY2Nlc3NpYmxlIG1lbW9yeSA6IEVGQVVMVCAoMTQpCmxpc3Rtb3VudDA0LmM6
MTI4OiBUUEFTUzogaW52YWxpZCBmbGFncyA6IEVJTlZBTCAoMjIpCmxpc3Rtb3VudDA0LmM6MTI4
OiBUUEFTUzogaW5zdWZmaWNpZW50IG1udF9pZF9yZXEuc2l6ZSA6IEVJTlZBTCAoMjIpCmxpc3Rt
b3VudDA0LmM6MTI4OiBUUEFTUzogaW52YWxpZCBtbnRfaWRfcmVxLnNwYXJlIDogRUlOVkFMICgy
MikKbGlzdG1vdW50MDQuYzoxMjg6IFRQQVNTOiBpbnZhbGlkIG1udF9pZF9yZXEucGFyYW0gOiBF
SU5WQUwgKDIyKQpsaXN0bW91bnQwNC5jOjEyODogVFBBU1M6IGludmFsaWQgbW50X2lkX3JlcS5t
bnRfaWQgOiBFSU5WQUwgKDIyKQpsaXN0bW91bnQwNC5jOjEyODogVFBBU1M6IG5vbi1leGlzdGFu
dCBtbnRfaWQgOiBFTk9FTlQgKDIpCgpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3Qt
cHJvamVjdC9sdHAvYmxvYi9tYXN0ZXIvaW5jbHVkZS9sYXBpL21vdW50LmgKWzJdIGh0dHBzOi8v
Z2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC9hMjMwMGRjMGY1MWY0NmZm
YjA3YTQ2NWQ4NzM0NjM5ZGJlM2FmMDQ0ClszXSBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVz
dC1wcm9qZWN0L2x0cC9jb21taXQvMWZlZWI1NzgxMWE0YWEyZjU2YWQ4NWVkZjY5YThlYTg3MDg2
N2M2NQoKPiA+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCj4gPiBU
aGlzIHBhdGNoIGxvb2tzIGdvb2QsIEkgaGF2ZSBvbmUgcXVlc3Rpb24gZG8gd2UgbmVlZCB0byBj
b3ZlciB0aGUgJ3NwYXJlJwo+ID4gZmllbGQgdGVzdCBmb3Iga2VybmVscyBiZXR3ZWVuIDYuOCB0
byA2LjE4Pwo+IEkgdGhpbmsgb25seSBrZWVwIHRyYWNraW5nIGxhdGVzdCBmZWF0dXJlJ3MgY2hh
bmdlIGNhbiBtYWtlIG91ciBsaWZlCj4gZWFzeSBmb3IgdGhpcyBjYXNlIDopCgpEdWUgdGhlIGFi
b3ZlIElNSE8gd2Ugc2hvdWxkIGNvbnNpZGVyIHN1cHBvcnQgZm9yIDw2LjExLCA2LjE3PiBhcyB3
ZWxsLgpXZSBoYXZlIHNpbWlsYXIgY3JhenkgYXBwcm9hY2ggZm9yIGEgc3RydWN0IGNoYW5nZSBp
biBpbmNsdWRlL2xhcGkvZmFub3RpZnkuaCwKc2VlIEZTSURfVkFMX01FTUJFUigpLgoKS2luZCBy
ZWdhcmRzLApQZXRyCgo+ID4gICAgICAgICAuYnVmcyA9IChzdHJ1Y3QgdHN0X2J1ZmZlcnMgW10p
IHsKPiA+ID4gICAgICAgICAgICAgICAgIHsgJnJlcXVlc3QsIC5zaXplID0gTU5UX0lEX1JFUV9T
SVpFX1ZFUjAgfSwKPiA+ID4gICAgICAgICAgICAgICAgIHt9LAo+ID4gPiAgICAgICAgIH0sCj4g
PiA+ICB9Owo+ID4gPiArCj4gPiA+ICsjZWxzZQo+ID4gPiArICAgICAgIFRTVF9URVNUX1RDT05G
KAo+ID4gPiArICAgICAgICAgICAgICAgIlRoaXMgc3lzdGVtIGRvZXMgbm90IHN1cHBvcnQgbW50
X2lkX3JlcS5tbnRfbnNfZmQuIik7Cj4gPiA+ICsjZW5kaWYgLyogSEFWRV9TVFJVQ1RfTU5UX0lE
X1JFUV9NTlRfTlNfRkQgKi8KPiA+ID4gLS0KPiA+ID4gMi41MS4wCgoKPiA+ID4gLS0KPiA+ID4g
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCgoK
Cj4gPiAtLSAKPiA+IFJlZ2FyZHMsCj4gPiBMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
