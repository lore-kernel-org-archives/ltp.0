Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB34C4345F
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 18:45:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5EA83CFAFE
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 20:45:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 096E43CFAC2
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 20:45:43 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3FB16200161
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 20:45:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B25E1F392;
 Tue, 16 Apr 2024 18:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713293141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao3tXgiUS6ipVr7UlyOm80ckl45qLo2wJW+yv/9z6f8=;
 b=1cwblTvjBhYvqjX/QBcOB2egAUX8MKlWR4fwuMC2Ryn1Ys/OLAsUSlFbQsJ7BSUBMh3nwq
 ftgrjwXf4qjlfNdtHwZHRB7ksPdtcH83AOqxw//m9NXg7wwY+ddKi9HMt6/Bicj1bHZ9qM
 VL+DIbi6rnQQkTQcDFj0m7M40ozfm3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713293141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao3tXgiUS6ipVr7UlyOm80ckl45qLo2wJW+yv/9z6f8=;
 b=0e+isVV8iJQl3TL/chTNRmOMZKQ24dEMycTo4rUStl6DWXOrHadoSbC40FYltE6fgHxOTy
 UxA1OT7TsE0FU7CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713293141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao3tXgiUS6ipVr7UlyOm80ckl45qLo2wJW+yv/9z6f8=;
 b=1cwblTvjBhYvqjX/QBcOB2egAUX8MKlWR4fwuMC2Ryn1Ys/OLAsUSlFbQsJ7BSUBMh3nwq
 ftgrjwXf4qjlfNdtHwZHRB7ksPdtcH83AOqxw//m9NXg7wwY+ddKi9HMt6/Bicj1bHZ9qM
 VL+DIbi6rnQQkTQcDFj0m7M40ozfm3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713293141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ao3tXgiUS6ipVr7UlyOm80ckl45qLo2wJW+yv/9z6f8=;
 b=0e+isVV8iJQl3TL/chTNRmOMZKQ24dEMycTo4rUStl6DWXOrHadoSbC40FYltE6fgHxOTy
 UxA1OT7TsE0FU7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BFB313931;
 Tue, 16 Apr 2024 18:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tou7FVXHHmYhSQAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 16 Apr 2024 18:45:41 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 16 Apr 2024 20:45:40 +0200
Message-ID: <3484258.LZWGnKmheA@localhost>
Organization: SUSE
In-Reply-To: <20240416080448.22650-1-xuyang2018.jy@fujitsu.com>
References: <20240416080448.22650-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; HAS_ORG_HEADER(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrandom: Add negative tests for getrandom
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

SGkgWWFuZyBYdSwKUGxlYXNlIHNlZSBjb21tZW50cyBiZWxvdwoKT24gVHVlc2RheSwgQXByaWwg
MTYsIDIwMjQgMTA6MDQ6NDjigK9BTSBHTVQrMiBZYW5nIFh1IHZpYSBsdHAgd3JvdGU6Cj4gQWRk
IG5lZ2F0aXZlIGNhc2VzIGZvciBnZXRyYW5kb20oKSwgd2hlbiBlcnJubyBpcyBFRkFVTFQgb3Ig
RUlOVkFMCj4gCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdSA8eHV5YW5nMjAxOC5qeUBmdWppdHN1
LmNvbT4KPiAtLS0KPiAgcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDEgKwo+ICAuLi4va2VybmVsL3N5c2NhbGxzL2dldHJhbmRvbS8uZ2l0aWdub3JlICAg
ICAgfCAgMSArCj4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvZ2V0cmFuZG9tL2dldHJhbmRvbTA1LmMg
ICB8IDQ2ICsrKysrKysrKysrKysrKysrKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRp
b25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dl
dHJhbmRvbS9nZXRyYW5kb20wNS5jCj4gCj4gZGlmZiAtLWdpdCBhL3J1bnRlc3Qvc3lzY2FsbHMg
Yi9ydW50ZXN0L3N5c2NhbGxzCj4gaW5kZXggY2MxZTM5YzA1Li42MmViNGMxY2QgMTAwNjQ0Cj4g
LS0tIGEvcnVudGVzdC9zeXNjYWxscwo+ICsrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBAQCAtNTA0
LDYgKzUwNCw3IEBAIGdldHJhbmRvbTAxIGdldHJhbmRvbTAxCj4gIGdldHJhbmRvbTAyIGdldHJh
bmRvbTAyCj4gIGdldHJhbmRvbTAzIGdldHJhbmRvbTAzCj4gIGdldHJhbmRvbTA0IGdldHJhbmRv
bTA0Cj4gK2dldHJhbmRvbTA1IGdldHJhbmRvbTA1Cj4gCj4gIGdldHJlc2dpZDAxIGdldHJlc2dp
ZDAxCj4gIGdldHJlc2dpZDAxXzE2IGdldHJlc2dpZDAxXzE2Cj4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmFuZG9tLy5naXRpZ25vcmUKPiBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZ2V0cmFuZG9tLy5naXRpZ25vcmUgaW5kZXggZWYwNmVjZTlkLi5lNDdk
OGIzZjQKPiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJhbmRv
bS8uZ2l0aWdub3JlCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRyYW5kb20v
LmdpdGlnbm9yZQo+IEBAIC0yLDMgKzIsNCBAQAo+ICAvZ2V0cmFuZG9tMDIKPiAgL2dldHJhbmRv
bTAzCj4gIC9nZXRyYW5kb20wNAo+ICsvZ2V0cmFuZG9tMDUKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9nZXRyYW5kb20vZ2V0cmFuZG9tMDUuYwo+IGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9nZXRyYW5kb20vZ2V0cmFuZG9tMDUuYyBuZXcgZmlsZSBtb2RlIDEw
MDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uYTUwMjI4ZDNkCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmFuZG9tL2dldHJhbmRvbTA1LmMKPiBAQCAt
MCwwICsxLDQ2IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyCj4gKy8qCj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBGVUpJVFNVIExJTUlURUQuIEFsbCBS
aWdodHMgUmVzZXJ2ZWQuCj4gKyAqIEF1dGhvcjogWWFuZyBYdSA8eHV5YW5nMjAxOC5qeUBmdWpp
dHN1LmNvbT4KPiArICovCj4gKwo+ICsvKlwKPiArICogW0Rlc2NyaXB0aW9uXQo+ICsgKgo+ICsg
KiBWZXJpZnkgdGhhdCBnZXRyYW5kb20oMikgZmFpbHMgd2l0aAo+ICsgKgo+ICsgKiAtIEVGQVVM
VCB3aGVuIGJ1ZiBhZGRyZXNzIGlzIG91dHNpZGUgdGhlIGFjY2Vzc2libGUgYWRkcmVzcyBzcGFj
ZQo+ICsgKiAtIEVJTlZBTCB3aGVuIGZsYWcgaXMgaW52YWxpZAo+ICsgKi8KPiArCj4gKyNpbmNs
dWRlIDxzeXMvcmFuZG9tLmg+Cj4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ICsKPiArc3RhdGlj
IGNoYXIgYnVmZl9lZmF1bHRbNjRdOwo+ICtzdGF0aWMgY2hhciBidWZmX2VpbnZhbFs2NF07Cj4g
Kwo+ICtzdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHsKPiArCWNoYXIgKmJ1ZmY7Cj4gKwlzaXpl
X3Qgc2l6ZTsKPiArCXVuc2lnbmVkIGludCBmbGFnOwo+ICsJaW50IGV4cGVjdGVkX2Vycm5vOwo+
ICsJY2hhciAqZGVzYzsKPiArfSB0Y2FzZXNbXSA9IHsKPiArCXtOVUxMLCBzaXplb2YoYnVmZl9l
ZmF1bHQpLCAwLCBFRkFVTFQsCldlIHVzdWFsbHkgdXNlICcodm9pZCAqKSAtMScgZm9yIGluYWNj
ZXNzaWJsZSBhZGRyZXNzLgo+ICsJCSJidWYgYWRkcmVzcyBpcyBvdXRzaWRlIHRoZSBhY2Nlc3Np
YmxlIGFkZHJlc3Mgc3BhY2UifSwKPiArCXtidWZmX2VpbnZhbCwgc2l6ZW9mKGJ1ZmZfZWludmFs
KSwgLTEsIEVJTlZBTCwgImZsYWcgaXMgaW52YWxpZCJ9LAo+ICt9Owo+ICsKPiArc3RhdGljIHZv
aWQgdmVyaWZ5X2dldHJhbmRvbSh1bnNpZ25lZCBpbnQgaSkKPiArewo+ICsJc3RydWN0IHRlc3Rf
Y2FzZV90ICp0YyA9ICZ0Y2FzZXNbaV07Cj4gKwo+ICsJVFNUX0VYUF9GQUlMKGdldHJhbmRvbSh0
Yy0+YnVmZiwgdGMtPnNpemUsIHRjLT5mbGFnKSwKc2hvdWxkIGJlIFRTVF9FWFBfRkFJTDIoKSBo
ZXJlIGFzIGdldHJhbmRvbSgpIHJldHVybnMgbnVtYmVyIG9mIGJ5dGVzIGNvcGllZAp0byBidWYg
KGkuZS4gYSBub24tbmVnYXRpdmUgaW50ZWdlcikgb24gc3VjY2Vzcy4KPiArCQl0Yy0+ZXhwZWN0
ZWRfZXJybm8sICIlcyIsIHRjLT5kZXNjKTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB0c3Rf
dGVzdCB0ZXN0ID0gewo+ICsJLnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNlcyksCj4gKwkudGVzdCA9
IHZlcmlmeV9nZXRyYW5kb20sCj4gKwkubmVlZHNfcm9vdCA9IDEsCkRvIHdlIHJlYWxseSBuZWVk
IHJvb3QgZm9yIHRoaXM/Cj4gK307CgpSZWdhcmRzLApBdmluZXNoCgoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
