Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838ABCD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:49:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 163C93E2AAB
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 13:49:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECE163E2AAB
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 13:48:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F7E81000768
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 13:48:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CFDC06CBCB;
 Tue, 16 Jun 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C42A9779A8;
 Tue, 16 Jun 2026 11:48:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xzcLxw4MWrKRgAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 16 Jun 2026 11:48:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 7CBC4A12D3; Tue, 16 Jun 2026 13:48:44 +0200 (CEST)
Date: Tue, 16 Jun 2026 13:48:44 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <jbzdwchf4dwfyx5dceorqacjzyi2dwlp3lqhyr25kntcggev47@zwsyivp2frp2>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
 <20260615180629.7148-2-anonymemeow@gmail.com>
 <ate4q7znqlhitd4y5wsrxx2rtq7u6btfeheep6svgvw5zhtbbn@y7cau7ke55ij>
 <CAOQ4uxhnrH3=XsCBhuO3oYtS=pZcRjkAchtrVwtnfJzBVmpNfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhnrH3=XsCBhuO3oYtS=pZcRjkAchtrVwtnfJzBVmpNfQ@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CFDC06CBCB
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fanotify20: Allow FAN_REPORT_PIDFD with
 FAN_REPORT_TID on v7.2+
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIDE2LTA2LTI2IDEzOjI3OjIwLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBUdWUs
IEp1biAxNiwgMjAyNiBhdCA5OjQw4oCvQU0gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JvdGU6
Cj4gPgo+ID4gT24gVHVlIDE2LTA2LTI2IDAyOjA2OjI1LCBBbm9ueW1lTWVvdyB3cm90ZToKPiA+
ID4gZmFub3RpZnlfaW5pdCgpIHVzZWQgdG8gcmVqZWN0IEZBTl9SRVBPUlRfUElERkQgY29tYmlu
ZWQgd2l0aAo+ID4gPiBGQU5fUkVQT1JUX1RJRCB3aXRoIEVJTlZBTC4gU2luY2UgTGludXggdjcu
MiwgZmFub3RpZnkgc3VwcG9ydHMKPiA+ID4gcmVwb3J0aW5nIHBpZGZkcyBmb3IgdGhyZWFkIElE
cywgc28gdGhpcyBjb21iaW5hdGlvbiBpcyBleHBlY3RlZCB0bwo+ID4gPiBzdWNjZWVkLgo+ID4g
Pgo+ID4gPiBLZWVwIGV4cGVjdGluZyBFSU5WQUwgb24gb2xkZXIga2VybmVscyBhbmQgYWRqdXN0
IHRoZSB0ZXN0IGV4cGVjdGF0aW9uCj4gPiA+IGJhc2VkIG9uIHRoZSBydW5uaW5nIGtlcm5lbCB2
ZXJzaW9uLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbm9ueW1lTWVvdyA8YW5vbnltZW1l
b3dAZ21haWwuY29tPgo+ID4KPiA+IFRoYW5rcyBmb3IgdGhlIGZpeGVzISBTb21lIGNvbW1lbnQg
YmVsb3cuIEFuZCB0YWtlIHlvdXIgdGltZSB3aXRoIGZpbmFsCj4gPiBleGFtcywgdGhhdCdzIG1v
cmUgaW1wb3J0YW50IHRoYW4gc29tZSBmYWlsaW5nIExUUCB0ZXN0cyA6KQo+ID4KPiA+ID4gZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMC5j
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIwLmMKPiA+ID4g
aW5kZXggYjMyZWNmNmFhLi45YTc4ZjZmZjAgMTAwNjQ0Cj4gPiA+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMC5jCj4gPiA+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMC5jCj4gPiA+IEBAIC04LDEzICs4
LDE0IEBACj4gPiA+Cj4gPiA+ICAvKlwKPiA+ID4gICAqIFRoaXMgc291cmNlIGZpbGUgY29udGFp
bnMgYSB0ZXN0IGNhc2Ugd2hpY2ggZW5zdXJlcyB0aGF0IHRoZQo+ID4gPiAtICogOm1hbnBhZ2U6
YGZhbm90aWZ5KDcpYCBBUEkgcmV0dXJucyBhbiBleHBlY3RlZCBlcnJvciBjb2RlIHdoZW4gcHJv
dmlkZWQgYW4KPiA+ID4gLSAqIGludmFsaWQgaW5pdGlhbGl6YXRpb24gZmxhZyBhbG9uZ3NpZGUg
RkFOX1JFUE9SVF9QSURGRC4gQWRkaXRpb25hbGx5LCBpdAo+ID4gPiAtICogY2hlY2tzIHRoYXQg
dGhlIG9wZXJhYmlsaXR5IHdpdGggZXhpc3RpbmcgRkFOX1JFUE9SVF8qIGZsYWdzIGlzIG1haW50
YWluZWQKPiA+ID4gLSAqIGFuZCBmdW5jdGlvbmluZyBhcyBpbnRlbmRlZC4KPiA+ID4gKyAqIDpt
YW5wYWdlOmBmYW5vdGlmeSg3KWAgQVBJIHJldHVybnMgYW4gZXhwZWN0ZWQgZXJyb3IgY29kZSB3
aGVuIHByb3ZpZGVkCj4gPiA+ICsgKiB1bnN1cHBvcnRlZCBpbml0aWFsaXphdGlvbiBmbGFncywg
ZS5nLiBGQU5fUkVQT1JUX1BJREZEIGNvbWJpbmVkIHdpdGgKPiA+ID4gKyAqIEZBTl9SRVBPUlRf
VElELiBBZGRpdGlvbmFsbHksIGl0IGNoZWNrcyB0aGF0IHRoZSBvcGVyYWJpbGl0eSB3aXRoCj4g
PiA+ICsgKiBzdXBwb3J0ZWQgRkFOX1JFUE9SVF8qIGZsYWdzIGlzIG1haW50YWluZWQgYW5kIGZ1
bmN0aW9uaW5nIGFzIGludGVuZGVkLgo+ID4gPiAgICoKPiA+ID4gICAqIE5PVEU6IEZBTl9SRVBP
UlRfUElERkQgc3VwcG9ydCB3YXMgYWRkZWQgaW4gdjUuMTUtcmMxIGluCj4gPiA+ICAgKiBhZjU3
OWJlYjY2NmEgKCJmYW5vdGlmeTogYWRkIHBpZGZkIHN1cHBvcnQgdG8gdGhlIGZhbm90aWZ5IEFQ
SSIpLgo+ID4gPiArICogRkFOX1JFUE9SVF9QSURGRCBjb21iaW5lZCB3aXRoIEZBTl9SRVBPUlRf
VElEIGlzIHN1cHBvcnRlZCBzaW5jZSB2Ny4yLXJjMS4KPiAKPiBDYW4gYWRkIHRoZSB1cHN0cmVh
bSBjb21taXQgaGVyZS4KPiAKPiA+ID4gICAqLwo+ID4gPgo+ID4gPiAgI2RlZmluZSBfR05VX1NP
VVJDRQo+ID4gPiBAQCAtMjYsOCArMjcsMTAgQEAKPiA+ID4KPiA+ID4gICNkZWZpbmUgTU9VTlRf
UEFUSCAgICJmc19tbnQiCj4gPiA+ICAjZGVmaW5lIEZMQUdTX0RFU0MoeCkgLmZsYWdzID0geCwg
LmRlc2MgPSAjeAo+ID4gPiArI2RlZmluZSBQSURGRF9USURfRkxBR1MgKEZBTl9SRVBPUlRfUElE
RkQgfCBGQU5fUkVQT1JUX1RJRCkKPiA+ID4KPiA+ID4gIHN0YXRpYyBpbnQgZmQ7Cj4gPiA+ICtz
dGF0aWMgaW50IHRocmVhZF9waWRmZF9zdXBwb3J0ZWQ7Cj4gPiA+Cj4gPiA+ICBzdGF0aWMgc3Ry
dWN0IHRlc3RfY2FzZV90IHsKPiA+ID4gICAgICAgdW5zaWduZWQgaW50IGZsYWdzOwo+ID4gPiBA
QCAtNTEsMTcgKzU0LDIxIEBAIHN0YXRpYyB2b2lkIGRvX3NldHVwKHZvaWQpCj4gPiA+ICAgICAg
ICAqLwo+ID4gPiAgICAgICBSRVFVSVJFX0ZBTk9USUZZX0lOSVRfRkxBR1NfU1VQUE9SVEVEX09O
X0ZTKEZBTl9SRVBPUlRfUElERkQsCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgTU9VTlRfUEFUSCk7Cj4gPiA+ICsKPiA+ID4gKyAgICAgdGhy
ZWFkX3BpZGZkX3N1cHBvcnRlZCA9IHRzdF9rdmVyY21wKDcsIDIsIDApID49IDA7Cj4gPiA+ICB9
Cj4gPiA+Cj4gPiA+ICBzdGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBpKQo+ID4gPiAg
ewo+ID4gPiAgICAgICBzdHJ1Y3QgdGVzdF9jYXNlX3QgKnRjID0gJnRlc3RfY2FzZXNbaV07Cj4g
PiA+ICsgICAgIGludCBleHBfZXJybm8gPSAodGMtPmZsYWdzICYgUElERkRfVElEX0ZMQUdTKSA9
PSBQSURGRF9USURfRkxBR1MgJiYKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHRocmVhZF9w
aWRmZF9zdXBwb3J0ZWQgPyAwIDogdGMtPmV4cF9lcnJubzsKPiA+ID4KPiA+ID4gLSAgICAgdHN0
X3JlcyhUSU5GTywgIlRlc3QgJXMgb24gJXMiLCB0Yy0+ZXhwX2Vycm5vID8gImZhaWwiIDogInBh
c3MiLAo+ID4gPiArICAgICB0c3RfcmVzKFRJTkZPLCAiVGVzdCAlcyBvbiAlcyIsIGV4cF9lcnJu
byA/ICJmYWlsIiA6ICJwYXNzIiwKPiA+ID4gICAgICAgICAgICAgICB0Yy0+ZGVzYyk7Cj4gPiA+
Cj4gPiA+ICAgICAgIFRTVF9FWFBfRkRfT1JfRkFJTChmZCA9IGZhbm90aWZ5X2luaXQodGMtPmZs
YWdzLCBPX1JET05MWSksCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICB0Yy0+ZXhwX2Vy
cm5vKTsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIGV4cF9lcnJubyk7Cj4gPgo+ID4g
SHVtLCB0aGlzIGxvb2tzIHNvbWV3aGF0IHVnbHkuIElkZWFsbHkgd2UnZCBpbml0aWFsaXplIHRl
c3QgY2FzZSAuZXhwX2Vycm5vCj4gPiBhY2NvcmRpbmdseSB0byB0aGUgZXhwZWN0ZWQgcmV0dXJu
IG9mIHRoZSBzeXNjYWxsIChidXQgdGhhdCdzIG5vdCByZWFsbHkKPiA+IHBvc3NpYmxlIGJlY2F1
c2UgdGhlIGluaXRpYWxpemVyIGhhcyB0byBiZSBjb25zdGFudCkuIENoZWNraW5nIGhvdyBvdGhl
cgo+ID4gdGVzdHMgaGFuZGxlIGl0LCBJIHRoaW5rIHdlIGNhbiBjbG9uZSB0aGUgdGVzdHMgdG8g
dHdvLiBPbmUgdGhhdCBleHBlY3RzCj4gPiBmYWlsdXJlIGFuZCBpcyBza2lwcGVkIGZvciBrZXJu
ZWxzID49IDcuMiBhbmQgb25lIHRoYXQgZXhwZWN0cyBzdWNjZXNzIGFuZAo+ID4gaXMgc2tpcHBl
ZCBmb3Iga2VybmVscyA8IDcuMi4gQW5kIHdlIGNhbiBoYXZlIGluIHRoZSB0ZXN0IGRlc2NyaXB0
aW9uCj4gPiAubWluX2t2ZXIgYW5kIC5tYXhfa3ZlciBmaWVsZHMgdGhhdCB3b3VsZCBzdG9yZSBm
b3Igd2hpY2gga2VybmVsIHZlcnNpb25zCj4gPiB0aGUgdGVzdCBzaG91bGQgYmUgcGVyZm9ybWVk
Lgo+IAo+IExPTCB0aGVyZSBpcyBub3RoaW5nIHRvIHRlc3QgaW4gdGhlID49IDcuMiB0ZXN0Lgo+
IAo+IFRoZSB0ZXN0IHRoYXQgdGhlc2UgZmxhZyBjb21iaW5hdGlvbiBhcmUgYWxsb3dlZDoKPiAg
ICAgICAgICAgICAgICAgRkxBR1NfREVTQyhGQU5fUkVQT1JUX1BJREZEIHwgRkFOX1JFUE9SVF9U
SUQpLAo+ICAgICAgICAgICAgICAgICBGTEFHU19ERVNDKEZBTl9SRVBPUlRfUElERkQgfCBGQU5f
UkVQT1JUX0ZJRCB8Cj4gRkFOX1JFUE9SVF9ERklEX05BTUUpLAo+IAo+IElzIGFscmVhZHkgInRl
c3RlZCIgYnkgdGhlIHRlc3RzIHRoYXQgdXNlIHRoZW0uCj4gYW5kIHdlIGRvbid0IGhhdmUgYW55
IHRlc3RzIHRoYXQgPj0gNS4xMCBoYXMgc3VwcG9ydCBmb3IKPiBGQU5fTUFSS19GSUxFU1lTVEVN
IGV0Yy4KPiAKPiBFYXNpZXN0IGlzIHRvIGp1c3Qgc2tpcCBmYW5vdGlmeTIwIGZvciB2ZXJzaW9u
ID49IDcuMgoKUmlnaHQsIEkgcHJvYmFibHkgb3ZlcmVuZ2luZWVyZWQgdGhpcyA6KSBKdXN0IHNr
aXAgdGhlIHRlc3QgZm9yIG5ld2VyCmtlcm5lbCB2ZXJzaW9ucy4KCgkJCQkJCQkJSG9uemEKLS0g
CkphbiBLYXJhIDxqYWNrQHN1c2UuY29tPgpTVVNFIExhYnMsIENSCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
