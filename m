Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3870EB64DC
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 06:34:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B3183CDECA
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 08:34:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 625E63C2FAF
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 08:34:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4B8271A004A3
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 08:34:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3FE3C21D9E;
 Tue, 11 Jul 2023 06:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689057246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJ9d5JTPSMLejK0dQWj/RmMWL/KaXYFzQ46/ggV/60Q=;
 b=L+BV9an+uQJQW5dOZcYNzrrmDG9occvzYhYCXnegHQ+UoHiwP9h1cp0TpdnH/yG1axLyd1
 0R0mpS8Zu93PRrUHINCFT8GUhP0nGKyVhEK4da1ky8aVCnDnR67vcRPqBRe2Q25R3c9FFj
 3RElWCc7LM5BvuDoCIfBMyZWJqN1WE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689057246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJ9d5JTPSMLejK0dQWj/RmMWL/KaXYFzQ46/ggV/60Q=;
 b=ztifpI47/lhdaMjjD6HSvi6sFzeTLviqBRRt2BIksUeIXIIFclq5a3K5zVdYmMAh+7ur/B
 uJpbZN/F9HCo3tBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01B861390F;
 Tue, 11 Jul 2023 06:34:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IscHOd33rGTlEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Jul 2023 06:34:05 +0000
Date: Tue, 11 Jul 2023 08:34:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230711063404.GA693714@pevik>
References: <20230710141403.1155151-1-amir73il@gmail.com>
 <20230710155006.GA659329@pevik>
 <CAOQ4uxjUkLo_MX+nxM1KFp66+C6c5zr75GAgpA0RZofZm7sfgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjUkLo_MX+nxM1KFp66+C6c5zr75GAgpA0RZofZm7sfgw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify14: Test disallow sb/mount mark on
 anonymous pipe
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
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBNb24sIEp1bCAxMCwgMjAyMyBhdCA2OjUw4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEFtaXIsCgo+ID4gPiBUaGlzIGNhc2Ugd2FzIHJldHJvYWN0
aXZlbHkgZGlzYWxsb3dlZC4KCj4gPiA+IFRoaXMgdGVzdCBpcyBtZWFudCB0byBlbmNvdXJhZ2Ug
dGhlIGJhY2twb3J0aW5nIG9mIGNvbW1pdCA2OTU2MmViMGJkM2UKPiA+ID4gKCJmYW5vdGlmeTog
ZGlzYWxsb3cgbW91bnQvc2IgbWFya3Mgb24ga2VybmVsIGludGVybmFsIHBzZXVkbyBmcyIpIHRv
Cj4gPiA+IGFsbCBzdGFibGUga2VybmVscy4KCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXIgR29s
ZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gPiA+IC0tLQoKPiA+ID4gUGV0ciwKCj4gPiA+
IFRoaXMgdGVzdHMgZm9yIGEgYmVoYXZpb3IgdGhhdCB3ZSBjb25zaWRlciBicm9rZW4gc2luY2Ug
dGhlIGRhd24gb2YKPiA+ID4gZmFub3RpZnkuCgo+ID4gPiBUaGUgZml4IHdhcyBtZXJnZWQgdG8g
djYuNS1yYzEuCj4gPiA+IEkndmUgYWxyZWFkeSBwb3N0ZWQgYmFja3BvcnQgcGF0Y2hlcyBmb3Ig
a2VybmVscyA+IHY1LjAuCj4gPiA+IEkgYW0gbm90IHBsYW5uaW5nIHRvIHBvc3QgYmFja3BvcnQg
cGF0Y2hlcyBmb3Igb2xkZXIga2VybmVscy4KCj4gPiBJIHNlZQo+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvc3RhYmxlLzIwMjMwNzEwMTMzMjA1LjExNTQxNjgtMS1hbWlyNzNpbEBnbWFpbC5j
b20vCgo+ID4gSSdsbCBzdWdnZXN0IHRvIHdhaXQgdGlsbCBHcmVnIHJlbGVhc2VzIHRoZSBiYWNr
cG9ydCAoc2hvdWxkIGJlIHF1aWNrIGVub3VnaCkuCgoKPiBvay4KCj4gPiA+IEV2ZW4gdGhvdWdo
IHRoZSB0d28gbmV3IHRlc3QgY2FzZXMgZG8gbm90IHVzZSBGQU5fUkVQT1JUX0ZJRCwKPiA+ID4g
ZmFub3RpZnkxNCByZXF1aXJlcyBGQU5fUkVQT1JUX0ZJRCwgc28gaXQgaXMgbm90IGdvaW5nIHRv
IHJ1biB0aGVzZQo+ID4gPiB0ZXN0IGNhc2VzIG9uIGtlcm5lbCA8IHY1LjEgYW55d2F5LgoKPiA+
ID4gVGhhbmtzLAo+ID4gPiBBbWlyLgoKPiA+ID4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmFub3Rp
ZnkvZmFub3RpZnkxNC5jICAgICB8IDMyICsrKysrKysrKysrKysrKysrLS0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKPiA+ID4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMKPiA+ID4gaW5k
ZXggYmZhMDM0OWZlLi4wNjNhOWY5NmYgMTAwNjQ0Cj4gPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jCj4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jCj4gPiA+IEBAIC0xOSw2ICsxOSw5
IEBACj4gPiA+ICAgKgo+ID4gPiAgICogICAgIGNlYWY2OWY4ZWFkYyBmYW5vdGlmeTogZG8gbm90
IGFsbG93IHNldHRpbmcgZGlyZW50IGV2ZW50cyBpbiBtYXNrIG9mIG5vbi1kaXIKPiA+ID4gICAq
ICAgICA4Njk4ZTNiYWI0ZGQgZmFub3RpZnk6IHJlZmluZSB0aGUgdmFsaWRhdGlvbiBjaGVja3Mg
b24gbm9uLWRpciBpbm9kZSBtYXNrCj4gPiA+ICsgKgo+ID4gPiArICogVGhlIHBpcGVzIHRlc3Qg
Y2FzZXMgYXJlIHJlZ3Jlc3Npb24gdGVzdHMgZm9yIGNvbW1pdDoKPiA+ID4gKyAqICAgICA2OTU2
MmViMGJkM2UgZmFub3RpZnk6IGRpc2FsbG93IG1vdW50L3NiIG1hcmtzIG9uIGtlcm5lbCBpbnRl
cm5hbCBwc2V1ZG8gZnMKPiA+ID4gICAqLwoKPiA+ID4gICNkZWZpbmUgX0dOVV9TT1VSQ0UKPiA+
ID4gQEAgLTQwLDYgKzQzLDcgQEAKCj4gPiA+ICAjZGVmaW5lIEZMQUdTX0RFU0MoZmxhZ3MpIHso
ZmxhZ3MpLCAoI2ZsYWdzKX0KCj4gPiA+ICtzdGF0aWMgaW50IHBpcGVzWzJdID0gey0xLCAtMX07
Cj4gPiA+ICBzdGF0aWMgaW50IGZhbm90aWZ5X2ZkOwo+ID4gPiAgc3RhdGljIGludCBmYW5fcmVw
b3J0X3RhcmdldF9maWRfdW5zdXBwb3J0ZWQ7Cj4gPiA+ICBzdGF0aWMgaW50IGlnbm9yZV9tYXJr
X3Vuc3VwcG9ydGVkOwo+ID4gPiBAQCAtNjAsNiArNjQsNyBAQCBzdGF0aWMgc3RydWN0IHRlc3Rf
Y2FzZV90IHsKPiA+ID4gICAgICAgLyogd2hlbiBtYXNrLmZsYWdzID09IDAsIGZhbm90aWZ5X2lu
aXQoKSBpcyBleHBlY3RlZCB0byBmYWlsICovCj4gPiA+ICAgICAgIHN0cnVjdCB0ZXN0X2Nhc2Vf
ZmxhZ3NfdCBtYXNrOwo+ID4gPiAgICAgICBpbnQgZXhwZWN0ZWRfZXJybm87Cj4gPiA+ICsgICAg
IGludCAqcGZkOwoKPiA+IFRoaXMgcHJvZHVjZXMgd2FybmluZ3M6Cj4gPiBmYW5vdGlmeTE0LmM6
NzA6OTogd2FybmluZzogbWlzc2luZyBpbml0aWFsaXplciBmb3IgZmllbGQg4oCYcGZk4oCZIG9m
IOKAmHN0cnVjdCB0ZXN0X2Nhc2VfdOKAmSBbLVdtaXNzaW5nLWZpZWxkLWluaXRpYWxpemVyc10K
PiA+ICAgIDcwIHwgICAgICAgICB7RkxBR1NfREVTQyhGQU5fQ0xBU1NfQ09OVEVOVCB8IEZBTl9S
RVBPUlRfRklEKSwge30sIHt9LCBFSU5WQUx9LAo+ID4gICAgICAgfCAgICAgICAgIF4KPiA+IGZh
bm90aWZ5MTQuYzo2NzoxNDogbm90ZTog4oCYcGZk4oCZIGRlY2xhcmVkIGhlcmUKPiA+ICAgIDY3
IHwgICAgICAgICBpbnQgKnBmZDsKPiA+ICAgICAgIHwgICAgICAgICAgICAgIF5+fgo+ID4gZmFu
b3RpZnkxNC5jOjczOjk6IHdhcm5pbmc6IG1pc3NpbmcgaW5pdGlhbGl6ZXIgZm9yIGZpZWxkIOKA
mHBmZOKAmSBvZiDigJhzdHJ1Y3QgdGVzdF9jYXNlX3TigJkgWy1XbWlzc2luZy1maWVsZC1pbml0
aWFsaXplcnNdCj4gPiAgICA3MyB8ICAgICAgICAge0ZMQUdTX0RFU0MoRkFOX0NMQVNTX1BSRV9D
T05URU5UIHwgRkFOX1JFUE9SVF9GSUQpLCB7fSwge30sIEVJTlZBTH0sCj4gPiAgICAgICB8ICAg
ICAgICAgXgo+ID4gZmFub3RpZnkxNC5jOjY3OjE0OiBub3RlOiDigJhwZmTigJkgZGVjbGFyZWQg
aGVyZQo+ID4gICAgNjcgfCAgICAgICAgIGludCAqcGZkOwo+ID4gICAgICAgfCAgICAgICAgICAg
ICAgXn5+Cgo+ID4gQ291bGQgeW91IHBsZWFzZSBmaXggdGhlbT8gSSBndWVzcyBwZmQgbXVzdCBi
ZSBOVUxMIHdoZW4gdW51c2VkLgoKCj4gb2suIGJ1dCBJIGhhdmUgdG8gYXNrLAo+IHdoYXQgaXMg
dGhlIHZhbHVlIG9mIGV4cGxpY2l0bHkgaW5pdGlhbGl6aW5nIGFsbCB0aGUgb2xkIHRlc3QgY2Fz
ZXMgdG8KPiBwZmQgPSBOVUxMPwo+IGFuZCB3aGF0IGlzIHdyb25nIHdpdGggZGVmYXVsdCBOVUxM
IGluaXRpYWxpemVycz8KPiBJcyBpdCBhIGRlbGliZXJhdGUgZGVjaXNpb24gb2YgTFRQIHRvIGNh
cmUgYWJvdXQgdGhpcyB3YXJuaW5nPwo+IGl0J3MgYSBjbGFzc2ljIHBhdHRlcm4gZm9yIHdoYXQg
dGhpcyBwYXRjaCBkb2VzIC0KPiBhZGQgYSBuZXcgZmllbGQgdG8gdGVzdCBjYXNlIHdoaWNoIGFs
bCB0aGUgZXhpc3RpbmcgdGVzdCBjYXNlcwo+IHNob3VsZCBub3QgY2FyZSBhYm91dC4KCldlbGws
IHdlIHRyeSB0byBhdm9pZCB3YXJuaW5ncyBpbiBuZXcgQVBJIHRlc3RzIChhbmQgcmV3cml0aW5n
IGxlZ2FjeSBBUEkgdGVzdHMKaW50byBuZXcgQVBJIHRvIGNsZWFudXAgdGhlIGNvZGUpLgoKVGhl
IHNvbHV0aW9uIHRvIGF2b2lkIHdhcm5pbmdzIGlzIHRvIHVzZSBkZXNpZ25hdGVkIGluaXRpYWxp
emVycyAobmFtZWQKaW5pdGlhbGl6ZXJzKSwgdGhlIHNhbWUgd2F5IGFzIGluIGVkZTdmMDk1ZSAo
ImZhbm90aWZ5MTA6IFVzZSBuYW1lZAppbml0aWFsaXplcnMiKToKCgkvKiBGQU5fUkVQT1JUX0ZJ
RCB3aXRob3V0IGNsYXNzIEZBTl9DTEFTU19OT1RJRiBpcyBub3QgdmFsaWQgKi8KCXsKCQkuaW5p
dCA9IEZMQUdTX0RFU0MoRkFOX0NMQVNTX0NPTlRFTlQgfCBGQU5fUkVQT1JUX0ZJRCksCgkJLmV4
cGVjdGVkX2Vycm5vID0gRUlOVkFMCgl9LAoKCS8qIEZBTl9SRVBPUlRfRklEIHdpdGhvdXQgY2xh
c3MgRkFOX0NMQVNTX05PVElGIGlzIG5vdCB2YWxpZCAqLwoJewoJCS5pbml0ID0gRkxBR1NfREVT
QyhGQU5fQ0xBU1NfUFJFX0NPTlRFTlQgfCBGQU5fUkVQT1JUX0ZJRCksCgkJLmV4cGVjdGVkX2Vy
cm5vID0gRUlOVkFMCgl9LAoKCS4uLgoJewoJCS5pbml0ID0gRkxBR1NfREVTQyhGQU5fQ0xBU1Nf
Tk9USUYpLAoJCS5tYXJrID0gRkxBR1NfREVTQyhGQU5fTUFSS19GSUxFU1lTVEVNKSwKCQkubWFz
ayA9IHsgRkFOX0FDQ0VTUywgImFub255bW91cyBwaXBlIn0sCgkJLmV4cGVjdGVkX2Vycm5vID0g
RUlOVkFMLAoJCS5wZmQgPSBwaXBlcwoJfSwKClRoZSBsYXN0IG9uZSBjb3VsZCBiZSB3aXRob3V0
IGRlc2lnbmF0ZWQgaW5pdGlhbGl6ZXJzLCBiZWNhdXNlIHdlIHBhc3MgYWxsCnN0cnVjdCBtZW1i
ZXJzLCBidXQgSU1ITyBpdCdzIGJldHRlciBmb3IgcmVhZGFiaWxpdHkuCgpUaGVyZWZvcmUgaWRl
YWwgc29sdXRpb24gd291bGQgYmUgdG8gdHVybiB0aGUgdGVzdCBpbnRvIGRlc2lnbmF0ZWQgaW5p
dGlhbGl6ZXJzCmluIHNlcGFyYXRlIGNvbW1pdCwgZm9sbG93ZWQgYnkgdGhpcyBjaGFuZ2UuCgo+
IEFsc28sIEkgaGF2ZSBhbHdheXMgc2VlbiB0aGVzZSB3YXJuaW5ncyBmb3Igc3RydWN0IHRzdF90
ZXN0LgoKPiBmYW5vdGlmeTE0LmM6Mjg0OjE6IHdhcm5pbmc6IG1pc3NpbmcgaW5pdGlhbGl6ZXIg
Zm9yIGZpZWxkCj4gJ25lZWRzX2NtZHMnIG9mICdzdHJ1Y3QgdHN0X3Rlc3QnIFstV21pc3Npbmct
ZmllbGQtaW5pdGlhbGl6ZXJzXQo+ICAgMjg0IHwgfTsKPiAgICAgICB8IF4KPiBJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gZmFub3RpZnkxNC5jOjI4Ogo+IC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rl
c3QuaDozMjQ6MjE6IG5vdGU6ICduZWVkc19jbWRzJyBkZWNsYXJlZCBoZXJlCj4gICAzMjQgfCAg
Y29uc3QgY2hhciAqY29uc3QgKm5lZWRzX2NtZHM7Cj4gICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn4KClRoZXNlIHdhcm5pbmdzIHdlcmUgY2F1c2VkIGJ5IHRoZXNlIEdDQyBi
dWdzIChmaXhlZCBpbiBnY2MgMTIgYW5kIGJhY2twb3J0ZWQgdG8KZ2NjIDExKToKaHR0cHM6Ly9n
Y2MuZ251Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9ODQ2ODUKaHR0cHM6Ly9nY2MuZ251
Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9ODIyODMKCktpbmQgcmVnYXJkcywKUGV0cgoK
PiBNdXN0IHdlIHJlYWxseSBpbml0aWFsaXplIGFuIGVtcHR5IG5lZWRzX2NtZHMgYXJyYXkgZm9y
IGV2ZXJ5IHRlc3Q/Cj4gU2VlbXMgcG9pbnRsZXNzIHRvIG1lLCBidXQgSSBtYXkgbm90IGhhdmUg
dGhlIGJpZ2dlciBwaWN0dXJlLgoKPiBUaGFua3MsCj4gQW1pci4KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
