Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C097EC27C43
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 14:13:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D39E3D0732
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 16:13:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E34383CAB27
 for <ltp@lists.linux.it>; Thu, 30 May 2024 16:13:12 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 69E71600847
 for <ltp@lists.linux.it>; Thu, 30 May 2024 16:13:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3D493387F;
 Thu, 30 May 2024 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717078389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcQs52zruZzuV92gWpu7/KbZ6uo0kkJ4eB2hLdYaNdU=;
 b=J0jld2dyTWs/F+Mj2nnZVg5gqNr6mVd8MpclPIK1PbnmsJVCrLj2+380tB9OAvTqXQbBrB
 Qvv9L2Bs23FHMUv4hwYrm6NSWH8yP14z1+qIGoJEVr36aMUKvTJeC0w2PHh661HpUodYDt
 qiK8PPvCK3wwSUBzxHJ6V6KfbFK1C5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717078389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcQs52zruZzuV92gWpu7/KbZ6uo0kkJ4eB2hLdYaNdU=;
 b=ZnRCsD9a3X+nHAME1mWhovJsMlu1xfQOccXWXDe3fXukq/pKEhF1wpSprvT8ojyEU5Bg1f
 jw9rcF4CCAG6f6Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717078388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcQs52zruZzuV92gWpu7/KbZ6uo0kkJ4eB2hLdYaNdU=;
 b=CsTNc802vuSegoJGphYFtx53S71jf6yH2YnhPClp0rthDt7+9rABORa5eUUQstZ64wV6x8
 uW6o9fN11ALb07UNDjUcXvBrA680btTSdbf7mklX18JbfwYFqwHfjElfZ3jYVLlqj8laex
 Gnxyk7ZGlRVTgBTYcqvYQnkvjOGdO68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717078388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcQs52zruZzuV92gWpu7/KbZ6uo0kkJ4eB2hLdYaNdU=;
 b=lZsXFcoI3RCZJiGGancKUI65cOv4tLuxFXl1AZ0jucHjplG05F7XW7X6+SUysIr2X2ZMs0
 u21DMckVO+iodzAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A449113A83;
 Thu, 30 May 2024 14:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oSJcJ3SJWGYAZAAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 30 May 2024 14:13:08 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 30 May 2024 16:13:08 +0200
Message-ID: <1934768.7Z3S40VBb9@localhost>
Organization: SUSE
In-Reply-To: <20240416080237.22627-1-xuyang2018.jy@fujitsu.com>
References: <20240416080237.22627-1-xuyang2018.jy@fujitsu.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] flock: Add negative tests for flock
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

SGkgWWFuZyBYdSwKCgpXaGVuIEkgYW0gdGVzdGluZyB0aGlzIGJ5IHJ1bm5pbmcgbXVsdGlwbGUg
dGltZXMsIEVJTlRSIHRlc3QgaXMgZ2V0dGluZwp0aW1lZCBvdXQgcmFuZG9tbHkuCgp0c3RfdGVz
dC5jOjE2MjU6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMwcwpmbG9jazA3LmM6
NDY6IFRJTkZPOiBHb3QgU0lHVVNSMQpUZXN0IHRpbWVvdXRlZCwgc2VuZGluZyBTSUdLSUxMIQp0
c3RfdGVzdC5jOjE2NzM6IFRJTkZPOiBLaWxsZWQgdGhlIGxlZnRvdmVyIGRlc2NlbmRhbnQgcHJv
Y2Vzc2VzCnRzdF90ZXN0LmM6MTY3OTogVElORk86IElmIHlvdSBhcmUgcnVubmluZyBvbiBzbG93
IG1hY2hpbmUsIHRyeSBleHBvcnRpbmcgTFRQX1RJTUVPVVRfTVVMID4gMQp0c3RfdGVzdC5jOjE2
ODE6IFRCUk9LOiBUZXN0IGtpbGxlZCEgKHRpbWVvdXQ/KQoKSW4gdGhlc2UgY2FzZXMgSSBzZWUg
dGhhdCB0aGVyZSBhcmUgdHdvIGxvY2tzIChoZWxkIG9yIHdhaXRpbmcpIGJ5IHRoZSBwcm9jZXNz
CmV2ZW4gYWZ0ZXIgU0lHVVNFUjEgc2lnbmFsIGlzIGRlbGl2ZXJlZCwgc28gc29tZWhvdyBzaWdu
YWwgaXMgYmVpbmcgaWdub3JlZC4KCmZsb2NrMDcgICAgICAgICAxNjUyMCAgRkxPQ0sgICAgICAg
IFdSSVRFKiAwICAgICAgICAgIDAgICAgICAgICAgMCAvdG1wLi4uCmZsb2NrMDcgICAgICAgICAx
NjUxOSAgRkxPQ0sgICAgICAgIFdSSVRFICAwICAgICAgICAgIDAgICAgICAgICAgMCAvdG1wLi4u
CgoKQW5kIEkgZmVlbCB3ZSBzaG91bGQgYWRkIEVXT1VMREJMT0NLIGVycm5vIHRlc3QgdG8gZmxv
Y2swMi5jIGZpbGUsCmFuZCBrZWVwIG9ubHkgRUlOVFIgdGVzdGNhc2UgaGVyZS4gCgoKT24gVHVl
c2RheSwgQXByaWwgMTYsIDIwMjQgMTA6MDI6MzfigK9BTSBHTVQrMiBZYW5nIFh1IHZpYSBsdHAg
d3JvdGU6Cj4gQWRkIG5lZ2F0aXZlIGNhc2VzIGZvciBmbG9jaygpLCB3aGVuIGVycm5vIGlzIEVJ
TlRSIG9yIEVXT1VMREJMT0NLCj4gCj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdSA8eHV5YW5nMjAx
OC5qeUBmdWppdHN1LmNvbT4KPiAtLS0KPiAgcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDEgKwo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zsb2NrLy5n
aXRpZ25vcmUgfCAgMSArCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmxvY2svZmxvY2sw
Ny5jICB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysKPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMDAg
aW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mbG9jay9mbG9jazA3LmMKPiAKPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBi
L3J1bnRlc3Qvc3lzY2FsbHMKPiBpbmRleCA5NTc4ZTk5MWEuLmRlNGY1YTYzMyAxMDA2NDQKPiAt
LS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+IEBAIC0zNzUs
NiArMzc1LDcgQEAgZmxvY2swMiBmbG9jazAyCj4gIGZsb2NrMDMgZmxvY2swMwo+ICBmbG9jazA0
IGZsb2NrMDQKPiAgZmxvY2swNiBmbG9jazA2Cj4gK2Zsb2NrMDcgZmxvY2swNwo+ICAKPiAgZm10
bXNnMDEgZm10bXNnMDEKPiAgCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZmxvY2svLmdpdGlnbm9yZSBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmxvY2svLmdp
dGlnbm9yZQo+IGluZGV4IGM4Y2IwZmM1NC4uOWJhYzU4MmUxIDEwMDY0NAo+IC0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZmxvY2svLmdpdGlnbm9yZQo+ICsrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZmxvY2svLmdpdGlnbm9yZQo+IEBAIC0zLDMgKzMsNCBAQAo+ICAvZmxv
Y2swMwo+ICAvZmxvY2swNAo+ICAvZmxvY2swNgo+ICsvZmxvY2swNwo+IGRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zsb2NrL2Zsb2NrMDcuYyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmxvY2svZmxvY2swNy5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRl
eCAwMDAwMDAwMDAuLjZmZDY1MDE4Ngo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Zsb2NrL2Zsb2NrMDcuYwo+IEBAIC0wLDAgKzEsOTggQEAKPiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiArLyoKPiArICogQ29w
eXJpZ2h0IChjKSAyMDI0IEZVSklUU1UgTElNSVRFRC4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KPiAr
ICogQXV0aG9yOiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPgo+ICsgKi8KPiAr
Cj4gKy8qXAo+ICsgKiBbRGVzY3JpcHRpb25dCj4gKyAqCj4gKyAqIFZlcmlmeSB0aGF0IGZsb2Nr
KDIpIGZhaWxzIHdpdGgKPiArICoKPiArICogLSBFSU5UUiB3aGVuIHdhaXRpbmcgbG9jaywgY2Fs
bCBpcyBpbnRlcnJ1cHRlZCBieSBzaWduYWwKPiArICogLSBFV09VTERCTE9DSyB3aGVuIGZpbGUg
aXMgbG9ja2VkIGFuZCBMT0NLX05CIGZsYWcgaXMgc2VsZWN0ZWQKPiArICovCj4gKwo+ICsjaW5j
bHVkZSA8c2lnbmFsLmg+Cj4gKyNpbmNsdWRlIDxzeXMvZmlsZS5oPgo+ICsjaW5jbHVkZSA8c3lz
L3dhaXQuaD4KPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gKwo+ICsjZGVmaW5lIFRFU1RfSU5U
UiAidGVzdF9pbnRyIgo+ICsjZGVmaW5lIFRFU1RfRVdPVUxEQkxPQ0sgInRlc3RfZXdvdWxkYmxv
Y2siCj4gKwo+ICtzdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHsKPiArCWNoYXIgKmZpbGVuYW1l
Owo+ICsJaW50IGV4cGVjdGVkX2Vycm5vOwo+ICsJaW50IGNoaWxkOwo+ICsJY2hhciAqZGVzYzsK
PiArfSB0Y2FzZXNbXSA9IHsKPiArCXtURVNUX0lOVFIsIEVJTlRSLCAxLAo+ICsJCSJ3aGlsZSB3
YWl0aW5nIGxvY2ssIGNhbGwgaXMgaW50ZXJydXB0ZWQgYnkgc2lnbmFsIn0sCj4gKwl7VEVTVF9F
V09VTERCTE9DSywgRVdPVUxEQkxPQ0ssIDAsCj4gKwkJImZpbGUgaXMgbG9ja2VkIGFuZCBMT0NL
X05CIGZsYWcgaXMgc2VsZWN0ZWQifSwKPiArfTsKPiArCj4gK3N0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCj4gK3sKPiArCVNBRkVfVE9VQ0goVEVTVF9JTlRSLCAwNzc3LCBOVUxMKTsKPiArCVNBRkVf
VE9VQ0goVEVTVF9FV09VTERCTE9DSywgMDc3NywgTlVMTCk7Cj4gK30KPiArCj4gK3N0YXRpYyB2
b2lkIGhhbmRsZXIoaW50IHNpZykKPiArewo+ICsJc3dpdGNoIChzaWcpIHsKPiArCWNhc2UgU0lH
VVNSMToKPiArCQl0c3RfcmVzKFRJTkZPLCAiJXMiLCAiR290IFNJR1VTUjEiKTsKPiArCWJyZWFr
Owo+ICsJZGVmYXVsdDoKPiArCQl0c3RfcmVzKFRJTkZPLCAiJXMiLCAiR290IG90aGVyIHNpZ25h
bCIpOwo+ICsJYnJlYWs7Cj4gKwl9Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIGNoaWxkX2RvKGlu
dCBmZCwgc3RydWN0IHRlc3RfY2FzZV90ICp0YykKPiArewo+ICsJc3RydWN0IHNpZ2FjdGlvbiBz
YTsKPiArCj4gKwlzYS5zYV9oYW5kbGVyID0gaGFuZGxlcjsKPiArCVNBRkVfU0lHRU1QVFlTRVQo
JnNhLnNhX21hc2spOwo+ICsJU0FGRV9TSUdBQ1RJT04oU0lHVVNSMSwgJnNhLCBOVUxMKTsKPiAr
Cj4gKwlUU1RfRVhQX0ZBSUwoZmxvY2soZmQsIExPQ0tfRVgpLCB0Yy0+ZXhwZWN0ZWRfZXJybm8s
ICIlcyIsIHRjLT5kZXNjKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgdmVyaWZ5X2Zsb2NrKHVu
c2lnbmVkIGludCBpKQo+ICt7Cj4gKwlzdHJ1Y3QgdGVzdF9jYXNlX3QgKnRjID0gJnRjYXNlc1tp
XTsKPiArCXBpZF90IHBpZDsKPiArCWludCBmZDEgPSBTQUZFX09QRU4odGMtPmZpbGVuYW1lLCBP
X1JEV1IpOwo+ICsJaW50IGZkMiA9IFNBRkVfT1BFTih0Yy0+ZmlsZW5hbWUsIE9fUkRXUik7Cj4g
Kwo+ICsJaWYgKHRjLT5jaGlsZCkgewo+ICsJCWZsb2NrKGZkMSwgTE9DS19FWCk7Cj4gKwkJcGlk
ID0gU0FGRV9GT1JLKCk7Cj4gKwkJaWYgKCFwaWQpIHsKPiArCQkJY2hpbGRfZG8oZmQyLCB0Yyk7
Cj4gKwkJCWV4aXQoMCk7Cj4gKwkJfQo+ICsJCXNsZWVwKDEpOwo+ICsJCVNBRkVfS0lMTChwaWQs
IFNJR1VTUjEpOwo+ICsJCVNBRkVfV0FJVFBJRChwaWQsIE5VTEwsIDApOwo+ICsJfSBlbHNlIHsK
PiArCQlmbG9jayhmZDEsIExPQ0tfRVgpOwo+ICsJCVRTVF9FWFBfRkFJTChmbG9jayhmZDIsIExP
Q0tfRVggfCBMT0NLX05CKSwgdGMtPmV4cGVjdGVkX2Vycm5vLAo+ICsJCQkiJXMiLCB0Yy0+ZGVz
Yyk7Cj4gKwl9Cj4gKwlTQUZFX0NMT1NFKGZkMSk7Cj4gKwlTQUZFX0NMT1NFKGZkMik7Cj4gK30K
PiArCj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiArCS5zZXR1cCA9IHNldHVw
LAo+ICsJLnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNlcyksCj4gKwkudGVzdCA9IHZlcmlmeV9mbG9j
aywKPiArCS5uZWVkc190bXBkaXIgPSAxLAo+ICsJLm5lZWRzX3Jvb3QgPSAxLAo+ICsJLmZvcmtz
X2NoaWxkID0gMSwKPiArfTsKPiAKClJlZ2FyZHMsCkF2aW5lc2gKCgoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
