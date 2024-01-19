Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD30C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 14:33:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA5713CE2BF
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 15:33:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E4FD3CC84E
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 15:33:32 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C4AB605644
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 15:33:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BED4E1F7E5;
 Fri, 19 Jan 2024 14:33:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91129136F5;
 Fri, 19 Jan 2024 14:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XDNnITqIqmV5MwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Jan 2024 14:33:30 +0000
Date: Fri, 19 Jan 2024 15:33:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240119143329.GA8075@pevik>
References: <20231011162428.583911-1-pvorel@suse.cz>
 <20231011162428.583911-2-pvorel@suse.cz> <ZapgEnqfXwdL7_Pu@yuki>
 <CAEemH2dAvum4rHr1FpX7Tcii=U9gph+eHGW3rfYzev3S88Cfrg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dAvum4rHr1FpX7Tcii=U9gph+eHGW3rfYzev3S88Cfrg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BED4E1F7E5
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] swapon01: Test on all filesystems
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBGcmksIEphbiAxOSwgMjAyNCBhdCA3OjQy4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1Ymlz
QHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIQo+ID4gPiBUZXN0IG9uIGFsbCBmaWxlc3lzdGVtcyB0
byBpbmNyZWFzZSBjb3ZlcmFnZS4gIGJ0cmZzIGFuZCB0bXBmcwo+ID4gPiBjdXJyZW50bHkgZG9l
cyBub3Qgc3VwcG9ydCBzd2FwIGZpbGUsIGJ1dCBrZWVwIGl0IGluIGNhc2UgdGhpcyBnZXQKPiA+
ID4gY2hhbmdlZCBpbiB0aGUgZnV0dXJlLgoKPiA+ID4gVGVzdGluZyBvbiBhbGwgZmlsZXN5c3Rl
bXMgdXN1YWxseSByZXF1ZXN0cyByb290LCBidXQgd2UgZG9uJ3QgcmVxdWlyZQo+ID4gPiBpdCB3
aXRoIC5uZWVkc19yb290ID0gMS4gQnV0IHVzaW5nIHN3YXBvbigpIHJlcXVpcmVzIGl0IGFzIHdl
bGwsIHRodXMKPiA+ID4ga2VlcCBpdCBkZWZpbmVkLgoKPiA+ID4gQWxzbyBkZXRlY3QgdGhlIHN1
cHBvcnQgb24gdGhlIHNhbWUgZmlsZSBhcyB3aGljaCBpcyBiZWluZyB0ZXN0ZWQuCgo+ID4gRm9y
IHRoZSBwcmV2aW91cyBpdGVyYXRpb24gb2YgdGhpcyBwYXRjaCBMaSB3YXNuJ3Qgc3VyZSBpZiB0
aGlzIGFkZHMKPiA+IGVub3VnaCB2YWx1ZSBzaW5jZSB0aGVyZSBpc24ndCB0b24gb2YgZmlsZXN5
c3RlbSBzcGVjaWZpYyBjb2RlIGludm9sdmVkCj4gPiB1bmxlc3Mgd2UgYWN0dWFsbHkgc3RhcnQg
d3JpdGluZyB0byB0aGUgc3dhcGZpbGUuCgpJIHdvbmRlciBob3cgdG8gZm9yY2UuIFdlIGNvdWxk
IHNldHVwCgpzeXNjdGwgdm0uc3dhcHBpbmVzcz0xMDAKCkJ1dCBob3cgdG8gY29uc3VtZSBlbm91
Z2ggUkFNIHRvIGJlIGFjdHVhbGx5IHdyaXR0ZW4/Cgo+IFllcywgaWYgdGVzdGluZyB3aXRoIGFs
bF9maWxlc3lzdGVtcywgb25seSBtYWtlX3N3YXBmaWxlIHByb2Nlc3MgbWFrZXMKPiBzZW5zZSBJ
TU8uCgo+IFRoZSByZXNldCBzd2Fwb24oKSBvcGVyYXRpb24gZG9lcyB0aGUgc2FtZSB0aGluZyB0
byB0aGUga2VybmVsLgoKPiA+IEFuZCBhcyB0aGUgcGF0Y2ggaXMgSSB3b3VsZCBhZ3JlZSB3aXRo
IHRoYXQuIFdoYXQgbWF5IG1ha2Ugc2Vuc2UgSSB0aGluawo+ID4gaXMgdG8gcmVxdWlyZSBjZXJ0
YWluIGZpbGVzeXN0ZW0gdG8gc3VwcG9ydCBzd2FwLCBpLmUuIGZhaWwgdGhlIHRlc3QgaW4KPiA+
IHRoZSBjYXNlIHRoYXQgd2UgaGF2ZW4ndCBtYW5hZ2VkIHRvIGNyZWF0ZSBhbmQgZW5hYmxlIHRo
ZSBzd2FwZmlsZSB3aGVyZQo+ID4gaXQncyBzdXBwb3NlZCB0byB3b3JrLiBUaGF0IHdvdWxkIGd1
YXJkIGFib3V0IGFjY2lkZW50YWwgYnJlYWthZ2VzLCBhcwo+ID4gaXQgaXMgdGhlIHRlc3Qgd291
bGQgbm90IGNhdGNoIHRoZXNlIGJlY2F1c2UgaXQgd291bHQgVENPTkYgaW4gdGhlCj4gPiBzZXR1
cC4KCgo+ICsxCgo+IFRoaXMgc291bmRzIHJlYXNvbmFibGUsIGxvb2tzIGxpa2Ugd2UgbmVlZCBh
IHdoaXRlbGlzdCB0byBndWFyYW50ZWUKPiB0aG9zZSBmaWxlc3lzdGVtcyB0aGF0IHN1cHBvcnQg
c3dhcGZpbGUsIG90aGVyd2lzZSBpdCdzIGVhc3kgdG8gbWlzcwo+IHNvbWUgZmFsc2UgbmVnYXRp
dmVzIHdpdGggcmVwb3J0IFRDT05GIGJ5IGlzX3N3YXBfc3VwcG9ydGVkKCkuCgpPSywgZXZlbiB3
aXRob3V0IHdyaXRpbmcgaXQgd291bGQgbWFrZSBzZW5zZSB0byB0ZXN0IG9uIGFsbCBmaWxlc3lz
dGVtcy4KClJlcGxhY2luZyBpc19zd2FwX3N1cHBvcnRlZCgpIHdpdGggYSBzdGF0aWMgbGlzdCBz
b3VuZHMgZ29vZCB0byBtZS4KV2UgbWlnaHQgZW5kdXAgdG8gY2hlY2sga2VybmVsIHJlbGVhc2Ug
Zm9yIGNlcnRhaW4gZmlsZXN5c3RlbQooaWYgaXQgZ290IHN3YXAgc3VwcG9ydCBsYXRlcikuIEdv
aW5nIHRvIHNlbmQgYSBwYXRjaC4KCktpbmQgcmVnYXJkcywKUGV0cgoKCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ID4gPiAtLS0KPiA+ID4gSU1ITyBp
dCdzIG5vdCBhIGJpZyBzbG93ZG93biB0aHVzIEkga2VlcCBidHJmcyBhbmQgdG1wZnMuCj4gPiA+
IFRoZXkgbWlnaHQgZ2V0IHN1cHBvcnQgb25lIGRheS4KCj4gPiA+ICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jIHwgMTcgKysrKysrKysrKystLS0tLS0KPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKPiA+ID4g
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMK
PiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4gPiBp
bmRleCBiNWMzZjM1OWMuLjZiN2Y5NmNmNyAxMDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4gPiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPiA+IEBAIC05LDYgKzksOSBAQAo+ID4g
PiAgICogQ2hlY2tzIHRoYXQgc3dhcG9uKCkgc3VjY2VkcyB3aXRoIHN3YXBmaWxlLgo+ID4gPiAg
ICovCgo+ID4gPiArI2RlZmluZSBNTlRQT0lOVCAgICAgIm1udHBvaW50Igo+ID4gPiArI2RlZmlu
ZSBTV0FQX0ZJTEUgICAgTU5UUE9JTlQiL3N3YXBmaWxlMDEiCj4gPiA+ICsKPiA+ID4gICNpbmNs
dWRlIDx1bmlzdGQuaD4KPiA+ID4gICNpbmNsdWRlIDxlcnJuby5oPgo+ID4gPiAgI2luY2x1ZGUg
PHN0ZGxpYi5oPgo+ID4gPiBAQCAtMTgsMTQgKzIxLDE0IEBACgo+ID4gPiAgc3RhdGljIHZvaWQg
dmVyaWZ5X3N3YXBvbih2b2lkKQo+ID4gPiAgewo+ID4gPiAtICAgICBURVNUKHRzdF9zeXNjYWxs
KF9fTlJfc3dhcG9uLCAiLi9zd2FwZmlsZTAxIiwgMCkpOwo+ID4gPiArICAgICBURVNUKHRzdF9z
eXNjYWxsKF9fTlJfc3dhcG9uLCBTV0FQX0ZJTEUsIDApKTsKCj4gPiA+ICAgICAgIGlmIChUU1Rf
UkVUID09IC0xKSB7Cj4gPiA+ICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRURVJSTk8s
ICJGYWlsZWQgdG8gdHVybiBvbiBzd2FwZmlsZSIpOwo+ID4gPiAgICAgICB9IGVsc2Ugewo+ID4g
PiAgICAgICAgICAgICAgIHRzdF9yZXMoVFBBU1MsICJTdWNjZWVkZWQgdG8gdHVybiBvbiBzd2Fw
ZmlsZSIpOwo+ID4gPiAgICAgICAgICAgICAgIC8qd2UgbmVlZCB0byB0dXJuIHRoaXMgc3dhcCBm
aWxlIG9mZiBmb3IgLWkgb3B0aW9uICovCj4gPiA+IC0gICAgICAgICAgICAgaWYgKHRzdF9zeXNj
YWxsKF9fTlJfc3dhcG9mZiwgIi4vc3dhcGZpbGUwMSIpICE9IDApIHsKPiA+ID4gKyAgICAgICAg
ICAgICBpZiAodHN0X3N5c2NhbGwoX19OUl9zd2Fwb2ZmLCBTV0FQX0ZJTEUpICE9IDApIHsKPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJGYWlsZWQg
dG8gdHVybiBvZmYKPiA+IHN3YXBmaWxlLCIKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIiBzeXN0ZW0gcmVib290IGFmdGVyIGV4ZWN1dGlvbiBvZiBMVFAgIgo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAidGVzdCBzdWl0ZSBpcyByZWNvbW1lbmRlZC4iKTsK
PiA+ID4gQEAgLTM1LDEzICszOCwxNSBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9uKHZvaWQp
Cgo+ID4gPiAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiA+ID4gIHsKPiA+ID4gLSAgICAgaXNf
c3dhcF9zdXBwb3J0ZWQoIi4vdHN0c3dhcCIpOwo+ID4gPiAtICAgICBtYWtlX3N3YXBmaWxlKCJz
d2FwZmlsZTAxIiwgMCk7Cj4gPiA+ICsgICAgIGlzX3N3YXBfc3VwcG9ydGVkKFNXQVBfRklMRSk7
Cj4gPiA+ICsgICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAwKTsKPiA+ID4gIH0KCj4gPiA+
ICBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gPiA+IC0gICAgIC5uZWVkc19yb290
ID0gMSwKPiA+ID4gLSAgICAgLm5lZWRzX3RtcGRpciA9IDEsCj4gPiA+ICsgICAgIC5tbnRwb2lu
dCA9IE1OVFBPSU5ULAo+ID4gPiArICAgICAubW91bnRfZGV2aWNlID0gMSwKPiA+ID4gKyAgICAg
Lm5lZWRzX3Jvb3QgPSAxLCAvKiBmb3Igc3dhcG9uKCkgKi8KPiA+ID4gKyAgICAgLmFsbF9maWxl
c3lzdGVtcyA9IDEsCj4gPiA+ICAgICAgIC50ZXN0X2FsbCA9IHZlcmlmeV9zd2Fwb24sCj4gPiA+
ICAgICAgIC5zZXR1cCA9IHNldHVwCj4gPiA+ICB9Owo+ID4gPiAtLQo+ID4gPiAyLjQyLjAKCgo+
ID4gLS0KPiA+IEN5cmlsIEhydWJpcwo+ID4gY2hydWJpc0BzdXNlLmN6Cgo+ID4gLS0KPiA+IE1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
