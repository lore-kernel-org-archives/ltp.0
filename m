Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863ABC0218A
	for <ltp@archiver.kernel.org>; Tue, 28 Jan 2025 12:26:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E073E3C67A8
	for <ltp@archiver.kernel.org>; Tue, 28 Jan 2025 13:26:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B23663C1448
 for <ltp@lists.linux.it>; Tue, 28 Jan 2025 13:26:18 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AA1EB1A0199E
 for <ltp@lists.linux.it>; Tue, 28 Jan 2025 13:26:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A6A31F381;
 Tue, 28 Jan 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3828613715;
 Tue, 28 Jan 2025 12:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QAzLCujMmGeXHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 Jan 2025 12:26:16 +0000
Date: Tue, 28 Jan 2025 13:26:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Minear, Coey" <coey.minear@hpe.com>
Message-ID: <20250128122606.GA366018@pevik>
References: <MN0PR84MB3022EFF407AA0C3130EE9728EAEC2@MN0PR84MB3022.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN0PR84MB3022EFF407AA0C3130EE9728EAEC2@MN0PR84MB3022.NAMPRD84.PROD.OUTLOOK.COM>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7A6A31F381
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Possible fix for LTP Issue #1219
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ29leSwKCj4gSSBjcmVhdGVkIGFuIGlzc3VlIGFnYWluc3QgTFRQOiBodHRwczovL2dpdGh1
Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9pc3N1ZXMvMTIxOS4g4oCYcGV2aWvigJkgc3Vn
Z2VzdGVkIHRoYXQgSSBzZW5kIGEgcGF0Y2ggaGVyZS4gSeKAmWxsIGFkbWl0IHRoYXQgSeKAmW0g
dW5jZXJ0YWluIHdoYXQgZm9ybSB3b3VsZCBiZSBwcmVmZXJyZWQsIGJ1dCBoZXJl4oCZcyB3aGF0
IEnigJlsbCBzaGFyZToKPiBbW1BBVENIXV0KCkZZSSBjb21taXQgbWVzc2FnZSBsaWtlIHRoaXMg
aXMgbm90IG11Y2ggaGVscGZ1bCAodXN1YWxseSB0aGUgcmVhc29uIGZvciB0aGUKY2hhbmdlIGlz
IGltcG9ydGFudCB0byBkZXNjcmliZSwgeW91IGRvbid0IHB1dCB5b3VyIFNpZ25lZC1vZmYtYnk6
KSwgYnV0IHdlIGNhbgpmaXggaXQgYmVmb3JlIG1lcmdlLgoKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9rdm0va3ZtX3BhZ2VmYXVsdDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9r
dm1fcGFnZWZhdWx0MDEuYwo+IGluZGV4IDE2YjMxMzdjMC4uNjQ5YmY0MjlhIDEwMDY0NAo+IC0t
LSBhL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2t2bV9wYWdlZmF1bHQwMS5jCj4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9rdm0va3ZtX3BhZ2VmYXVsdDAxLmMKPiBAQCAtMjE0LDYgKzIxNCwxMCBAQCBz
dGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gICAgICAgICAuc2V0dXAgPSBzZXR1cCwK
PiAgICAgICAgIC5jbGVhbnVwID0gdHN0X2t2bV9jbGVhbnVwLAo+ICAgICAgICAgLm5lZWRzX3Jv
b3QgPSAxLAo+ICsgICAgICAgLm5lZWRzX2RyaXZlcnMgPSAoY29uc3QgY2hhciAqY29uc3QgW10p
IHsKPiArICAgICAgICAgICAgICAgImt2bSIsCj4gKyAgICAgICAgICAgICAgIE5VTEwKPiArICAg
ICAgIH0sCj4gICAgICAgICAuc3VwcG9ydGVkX2FyY2hzID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtd
KSB7Cj4gICAgICAgICAgICAgICAgICJ4ODZfNjQiLAo+ICAgICAgICAgICAgICAgICBOVUxMCj4g
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2t2bV9zdm0wMS5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9rdm0va3ZtX3N2bTAxLmMKPiBpbmRleCAzMmQxNTUyNmIuLmY4MTYwMjU2NyAxMDA2
NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2t2bS9rdm1fc3ZtMDEuYwo+ICsrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwva3ZtL2t2bV9zdm0wMS5jCj4gQEAgLTEwOCw2ICsxMDgsMTAgQEAgc3RhdGlj
IHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgLnRlc3RfYWxsID0gdHN0X2t2bV9y
dW4sCj4gICAgICAgICAuc2V0dXAgPSB0c3Rfa3ZtX3NldHVwLAo+ICAgICAgICAgLmNsZWFudXAg
PSB0c3Rfa3ZtX2NsZWFudXAsCj4gKyAgICAgICAubmVlZHNfZHJpdmVycyA9IChjb25zdCBjaGFy
ICpjb25zdCBbXSkgewo+ICsgICAgICAgICAgICAgICAia3ZtIiwKPiArICAgICAgICAgICAgICAg
TlVMTAo+ICsgICAgICAgfSwKPiAgICAgICAgIC5zdXBwb3J0ZWRfYXJjaHMgPSAoY29uc3QgY2hh
ciAqY29uc3QgW10pIHsKPiAgICAgICAgICAgICAgICAgIng4Nl82NCIsCj4gICAgICAgICAgICAg
ICAgICJ4ODYiLAo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2t2bS9rdm1fc3ZtMDIu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2t2bV9zdm0wMi5jCj4gaW5kZXggNjkxNGZkY2JhLi43
MDFmMjczMWQgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9rdm0va3ZtX3N2bTAyLmMK
PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9rdm1fc3ZtMDIuYwo+IEBAIC0xMjksNiArMTI5
LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiAgICAgICAgIC50ZXN0X2Fs
bCA9IHRzdF9rdm1fcnVuLAo+ICAgICAgICAgLnNldHVwID0gdHN0X2t2bV9zZXR1cCwKPiAgICAg
ICAgIC5jbGVhbnVwID0gdHN0X2t2bV9jbGVhbnVwLAo+ICsgICAgICAgLm5lZWRzX2RyaXZlcnMg
PSAoY29uc3QgY2hhciAqY29uc3QgW10pIHsKPiArICAgICAgICAgICAgICAgImt2bSIsCj4gKyAg
ICAgICAgICAgICAgIE5VTEwKPiArICAgICAgIH0sCj4gICAgICAgICAuc3VwcG9ydGVkX2FyY2hz
ID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtdKSB7Cj4gICAgICAgICAgICAgICAgICJ4ODZfNjQiLAo+
ICAgICAgICAgICAgICAgICAieDg2IiwKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9r
dm0va3ZtX3N2bTAzLmMgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9rdm1fc3ZtMDMuYwo+IGluZGV4
IDg3MTY0ZDAxMy4uODdmOTg4N2Q4IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwva3Zt
L2t2bV9zdm0wMy5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9rdm0va3ZtX3N2bTAzLmMKPiBA
QCAtODgsNiArODgsOSBAQCBzdGF0aWMgdm9pZCAqdm1fdGhyZWFkKHZvaWQgKmFyZykKCj4gc3Rh
dGljIHZvaWQgc2V0dXAodm9pZCkKPiB7Cj4gKyAgICAgICAvKiBSdW4gdGhlIGNvbW1vbiAndHN0
X2t2bV9zZXR1cCgpJyBmaXJzdC4gKi8KPiArICAgICAgIHRzdF9rdm1fc2V0dXAoKTsKSU1ITyAi
a3ZtIiBpbiAubmVlZHNfZHJpdmVycyBpcyBlbm91Z2gsIGJ1dCBJIG1pZ2h0IGJlIHdyb25nLgpA
TWFydGluPwoKPiArCj4gICAgICAgICBzdHJ1Y3Qgc2lnYWN0aW9uIHNhID0geyAuc2FfaGFuZGxl
ciA9IHNpZ2hhbmRsZXIgfTsKPiAgICAgICAgIHB0aHJlYWRfbXV0ZXhhdHRyX3QgYXR0cjsKCj4g
QEAgLTE1NSw2ICsxNTgsMTAgQEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAg
ICAgICAgLnNldHVwID0gc2V0dXAsCj4gICAgICAgICAuY2xlYW51cCA9IGNsZWFudXAsCj4gICAg
ICAgICAubWluX2NwdXMgPSAyLAo+ICsgICAgICAgLm5lZWRzX2RyaXZlcnMgPSAoY29uc3QgY2hh
ciAqY29uc3QgW10pIHsKPiArICAgICAgICAgICAgICAgImt2bSIsCj4gKyAgICAgICAgICAgICAg
IE5VTEwKPiArICAgICAgIH0sCj4gICAgICAgICAuc3VwcG9ydGVkX2FyY2hzID0gKGNvbnN0IGNo
YXIgKmNvbnN0IFtdKSB7Cj4gICAgICAgICAgICAgICAgICJ4ODZfNjQiLAo+ICAgICAgICAgICAg
ICAgICAieDg2IiwKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9rdm0va3ZtX3N2bTA0
LmMgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9rdm1fc3ZtMDQuYwo+IGluZGV4IGU2OWYwZDRiZS4u
ZDhkM2JkZDk2IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2t2bV9zdm0wNC5j
Cj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9rdm0va3ZtX3N2bTA0LmMKPiBAQCAtMjk3LDYgKzI5
NywxMCBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gICAgICAgICAudGVzdF9h
bGwgPSB0c3Rfa3ZtX3J1biwKPiAgICAgICAgIC5zZXR1cCA9IHRzdF9rdm1fc2V0dXAsCj4gICAg
ICAgICAuY2xlYW51cCA9IHRzdF9rdm1fY2xlYW51cCwKPiArICAgICAgIC5uZWVkc19kcml2ZXJz
ID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtdKSB7Cj4gKyAgICAgICAgICAgICAgICJrdm0iLAo+ICsg
ICAgICAgICAgICAgICBOVUxMCj4gKyAgICAgICB9LAo+ICAgICAgICAgLnN1cHBvcnRlZF9hcmNo
cyA9IChjb25zdCBjaGFyICpjb25zdCBbXSkgewo+ICAgICAgICAgICAgICAgICAieDg2XzY0IiwK
PiAgICAgICAgICAgICAgICAgIng4NiIsCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
a3ZtL2xpYl9ob3N0LmMgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9saWJfaG9zdC5jCj4gaW5kZXgg
OGUzZDYwOTRlLi4xNzIxNWMyM2IgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9rdm0v
bGliX2hvc3QuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2xpYl9ob3N0LmMKPiBAQCAt
MzIzLDcgKzMyMywxNCBAQCB2b2lkIHRzdF9rdm1fY2xlYXJfZ3Vlc3Rfc2lnbmFsKHN0cnVjdCB0
c3Rfa3ZtX2luc3RhbmNlICppbnN0KQoKPiB2b2lkIHRzdF9rdm1fc2V0dXAodm9pZCkKPiB7Cj4g
LQo+ICsgICAgICAgLyogRG8gYSBxdWljayBjaGVjayB0aGF0IHRoZSAna3ZtJyBtb2R1bGUgaXMg
YWN0dWFsbHkgbG9hZGVkIGJ5Cj4gKyAgICAgICAgICBjaGVja2luZyBmb3IgJy9kZXYva3ZtJy4g
SWYgdGhhdCBkZXZpY2UgZmlsZSBpcyBub3QgcHJlc2VudCwgdGhlbgo+ICsgICAgICAgICAgdGhl
IG1vZHVsZSBpcyBsaWtlbHkgbm90IGxvYWRlZCBpbiB3aGljaCBjYXNlIHdlIHNob3VsZCBqdXN0
IENPTkYKPiArICAgICAgICAgIG91dC4KPiArICAgICAgICovCj4gKyAgICAgICBpZiAoYWNjZXNz
KCIvZGV2L2t2bSIsIEZfT0spICE9IDApIHsKPiArICAgICAgICAgICAgICAgIHRzdF9icmsoVENP
TkYsICJUaGUgdGVzdCByZXF1aXJlcyAna3ZtJyBkZXZpY2UsIHdoaWNoIGlzIG5vdCBsb2FkZWQu
Iik7Cj4gKyAgICAgICB9ClRoZXJlZm9yZSBJIHdvdWxkIHJlbW92ZSB0aGlzLgoKS2luZCByZWdh
cmRzLApQZXRyCgo+IH0KCj4gdm9pZCB0c3Rfa3ZtX3J1bih2b2lkKQo+IFtbL1BBVENIXV0KCj4g
SeKAmWxsIGFkbWl0IHRoYXQgdGhpcyBwb3NzaWJseSBjb250YWlucyBwYXJ0cyB0aGF0IHlvdSBt
YXkgbm90IHdhbnQsIGJ1dCBpdCBpbmNsdWRlcyB0aGUgcGFydHMgb2YgdGhlIGlzc3VlIHRoYXQg
SSByYWlzZWQuCgo+IENvZXkgTWluZWFyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
