Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDF2C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 21:32:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BA683CF98A
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 22:32:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CF8B3CF972
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 22:31:59 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 835281A007FE
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 22:31:57 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EC992230B;
 Tue, 30 Jan 2024 21:31:57 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 73D5613212;
 Tue, 30 Jan 2024 21:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 9/4+HM1quWUgGQAAn2gu4w
 (envelope-from <jack@suse.cz>); Tue, 30 Jan 2024 21:31:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 1B557A07F9; Tue, 30 Jan 2024 22:31:57 +0100 (CET)
Date: Tue, 30 Jan 2024 22:31:57 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240130213157.fco4tnocm4vgwgw3@quack3>
References: <20240125110510.751445-1-amir73il@gmail.com>
 <20240130130712.GB778733@pevik>
 <CAOQ4uxi+0us5cq5BhoLoPDCbZgeqhtWiK4UCDV5HaZ+aZQwCLw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi+0us5cq5BhoLoPDCbZgeqhtWiK4UCDV5HaZ+aZQwCLw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7EC992230B
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIDMwLTAxLTI0IDE2OjU4OjI4LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBUdWUs
IEphbiAzMCwgMjAyNCBhdCAzOjA34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdy
b3RlOgo+ID4gVGVzdGVkIG9uIFNMRSAxNS1TUDYgKGtlcm5lbCA2LjQpLCBvbiAxNS1TUDQgKGtl
cm5lbCA1LjE0KSwgVHVtYmxld2VlZCAoa2VybmVsCj4gPiA2LjguMC1yYzEpLCBBbHBpbmUgTGlu
dXggKGtlcm5lbCA2LjQpIEkgZ2V0Ogo+ID4KPiA+IGZhbm90aWZ5MDEuYzozNDE6IFRGQUlMOiBm
YW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4i
KSBmYWlsZWQ6IEVYREVWICgxOCkKPiA+Cj4gPiBmb3IgdGVzdHMgIzMsICM0IGFuZCAjNSBvbiBh
bGwgZmlsZXN5c3RlbXMuCj4gPgo+ID4gVGVzdGluZyBvbiBvdGhlciBvbiBvdGhlciBmaWxlc3lz
dGVtIGl0IHdvcmtzOiBEZWJpYW4ga2VybmVsIDUuMTAsIDYuMSBvbiBleHQ0LAo+ID4gQWxwaW5l
IExpbnV4IGtlcm5lbCA2LjQgb24gdG1wZnMsIFR1bWJsZXdlZWQga2VybmVsIDYuOC4wLXJjMSBv
biB0bXBmcy4KPiA+Cj4gPiBTaG91bGQgYmUgYnRyZnMgaGFuZGxlZCBkaWZmZXJlbnRseSBvciBz
a2lwcGVkPyAoYmVsb3cpCj4gPiBPciB0ZXN0IEVYREVWIGZvciAjMywgIzQgYW5kICM1PyAobm90
IHN1cmUgaG93IGhhbmRsZSBqdXN0IGhhbGYgb2YgdGhlIHRlc3RzIG9uCj4gPiBidHJmcyBkaWZm
ZXJlbnRseSkuCj4gPgo+ID4gS2luZCByZWdhcmRzLAo+ID4gUGV0cgo+ID4KPiA+IGRpZmYgLS1n
aXQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMgdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKPiA+IGluZGV4IGJhMDlm
MzA5ZC4uOTdhZGUxODI5IDEwMDY0NAo+ID4gLS0tIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmFub3RpZnkvZmFub3RpZnkwMS5jCj4gPiArKysgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
YW5vdGlmeS9mYW5vdGlmeTAxLmMKPiA+IEBAIC0zMzUsOCArMzM1LDE1IEBAIHBhc3M6Cj4gPiAg
ICAgICAgICAqIGRpZmZlcmVudCBmaWxlc3lzdGVtcyBhcmUgc3VwcG9ydGVkLgo+ID4gICAgICAg
ICAgKiBXaGVuIHRlc3RlZCBmcyBoYXMgemVybyBmc2lkIChlLmcuIGZ1c2UpIGFuZCBldmVudHMg
YXJlIHJlcG9ydGVkCj4gPiAgICAgICAgICAqIHdpdGggZnNpZCtmaWQsIHdhdGNoaW5nIGRpZmZl
cmVudCBmaWxlc3lzdGVtcyBpcyBub3Qgc3VwcG9ydGVkLgo+ID4gKyAgICAgICAgKiBOb3Qgc3Vw
cG9ydGVkIG9uIEJ0cmZzLgo+ID4gICAgICAgICAgKi8KPiA+ICsgICAgICAgaWYgKHRzdF9mc190
eXBlKCIuIikgPT0gVFNUX0JUUkZTX01BR0lDKSB7Cj4gPiArICAgICAgICAgICAgICAgdHN0X3Jl
cyhUQ09ORiwgInNraXBwZWQgb24gQnRyZnMiKTsKPiA+ICsgICAgICAgICAgICAgICByZXR1cm47
Cj4gPiArICAgICAgIH0KPiA+ICsKPiAKPiBOb3RlIHRoYXQgYnRyZnMgaXMgbm90IHRoZSBGUyB1
bmRlciB0ZXN0LiBJdCBpcyB0aGUgRlMgb2YgVE1QRlMsCj4gc28gZXZlbiBpZiB5b3UgZGlkIHNr
aXAsIHRoaXMgbWVzc2FnZSB3b3VsZCBoYXZlIGJlZW4gd3JvbmcuCj4gCj4gUGxlYXNlIHRyeSB0
aGUgcGF0Y2ggYmVsb3cuCgpUaGFua3MgZm9yIGZpeGluZyB0aGlzIHNvIHF1aWNrbHkhIFRoZSBm
aXggbG9va3MgZ29vZCB0byBtZS4KCgkJCQkJCQkJSG9uemEKLS0gCkphbiBLYXJhIDxqYWNrQHN1
c2UuY29tPgpTVVNFIExhYnMsIENSCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
