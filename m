Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A27BC4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 10:57:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E85F83CE235
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 11:57:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B89A3CC7B7
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 11:57:38 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AD50D1A002E8
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 11:57:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B15D922022;
 Mon, 22 Jan 2024 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705921056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAxnaDG9XF6nJaQjUsd3vnaChvp9ev3xy1i1Wvc2efg=;
 b=jCzQ4MQydejgwb2H0DNpUH7aKgiV8LkzsHF5wBYkxVoUK0AbNgajcIQJ/NncrSZ/N3tGA5
 NO8Hx2DDupJdRpqOl8uJ7v6rCLtNdDlWhPETlD/M4U7+7oJ7FIG8i5nAXrWX8csXULwsMp
 ebddeMsJnZZwRMu59vyrRO/80wXYjhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705921056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAxnaDG9XF6nJaQjUsd3vnaChvp9ev3xy1i1Wvc2efg=;
 b=gJA7b134/BDG/JwVOqdWm1TTLuUqMzRKf1VT9OwlIlgwZr4AEmmCvMzHsSwrMKFMtHAIgl
 PlR71El8H52rkgDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705921056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAxnaDG9XF6nJaQjUsd3vnaChvp9ev3xy1i1Wvc2efg=;
 b=jCzQ4MQydejgwb2H0DNpUH7aKgiV8LkzsHF5wBYkxVoUK0AbNgajcIQJ/NncrSZ/N3tGA5
 NO8Hx2DDupJdRpqOl8uJ7v6rCLtNdDlWhPETlD/M4U7+7oJ7FIG8i5nAXrWX8csXULwsMp
 ebddeMsJnZZwRMu59vyrRO/80wXYjhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705921056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAxnaDG9XF6nJaQjUsd3vnaChvp9ev3xy1i1Wvc2efg=;
 b=gJA7b134/BDG/JwVOqdWm1TTLuUqMzRKf1VT9OwlIlgwZr4AEmmCvMzHsSwrMKFMtHAIgl
 PlR71El8H52rkgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9510113995;
 Mon, 22 Jan 2024 10:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /0yaIyBKrmVhEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 10:57:36 +0000
Date: Mon, 22 Jan 2024 11:57:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240122105734.GA95077@pevik>
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122090349.GD76754@pevik>
 <CAEemH2c7_pvi1imV3pb2oc3g_ZGSTvBsKd=OYE=mSW2g=Z-BEA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c7_pvi1imV3pb2oc3g_ZGSTvBsKd=OYE=mSW2g=Z-BEA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

PiBPbiBNb24sIEphbiAyMiwgMjAyNCBhdCA1OjAz4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLCBDeXJpbCwKCj4gPiA+IFRoaXMgaW50cm9kdWNlIGFu
IGVuaGFuY2VtZW50IHRvIHRoZSBsaWJyYXJ5J3MgaXNfc3dhcF9zdXBwb3J0ZWQKPiA+ID4gZnVu
Y3Rpb24gdG8gY2hlY2sgZm9yIGZpbGVzeXN0ZW0gY29tcGF0aWJpbGl0eSBiZWZvcmUgYXR0ZW1w
dGluZwo+ID4gPiB0byBjcmVhdGUgYW5kIGVuYWJsZSBhIHN3YXAgZmlsZS4gIEEgbGlzdCBvZiBz
dXBwb3J0ZWQgZmlsZXN5c3RlbXMKPiA+ID4gaXMgYWRkZWQgKGV4dDIsIGV4dDMsIGV4dDQsIHhm
cywgdmZhdCwgZXhmYXQsIG50ZnMpLCBhbmQgYSBjaGVjawo+ID4gPiBhZ2FpbnN0IHRoaXMgbGlz
dCBpcyBwZXJmb3JtZWQgdG8gZW5zdXJlIHRoYXQgdGhlIHN3YXAgb3BlcmF0aW9ucwo+ID4gPiBh
cmUgb25seSBhdHRlbXB0ZWQgb24ga25vd24gY29tcGF0aWJsZSBmaWxlc3lzdGVtcy4KCj4gPiA+
IElmIHRoZSBtYWtlX3N3YXBmaWxlIGZ1bmN0aW9uIGZhaWxzLCB0aGUgZXJyb3IgaGFuZGxpbmcg
aXMgbm93Cj4gPiA+IG1vcmUgZGVzY3JpcHRpdmU6IGl0IGRpc3Rpbmd1aXNoZXMgYmV0d2VlbiBm
YWlsdXJlcyBkdWUgdG8gdGhlCj4gPiA+IGZpbGVzeXN0ZW0gbm90IHN1cHBvcnRpbmcgc3dhcCBm
aWxlcyBhbmQgb3RoZXIgdHlwZXMgb2YgZmFpbHVyZXMuCj4gPiA+IFNpbWlsYXJseSwgd2hlbiBh
dHRlbXB0aW5nIHRvIGVuYWJsZSB0aGUgc3dhcCBmaWxlIHdpdGggc3dhcG9uLAo+ID4gPiB0aGUg
cGF0Y2ggZW5zdXJlcyB0aGF0IGNsZWFyZXIgZXJyb3IgbWVzc2FnZXMgYXJlIHByb3ZpZGVkIGlu
Cj4gPiA+IGNhc2VzIHdoZXJlIHRoZSBvcGVyYXRpb24gaXMgbm90IHN1cHBvcnRlZCBieSB0aGUg
ZmlsZXN5c3RlbS4KCj4gPiA+IFNpZ25lZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPgo+ID4gPiAtLS0KPiA+ID4gIGxpYnMvbGlibHRwc3dhcC9saWJzd2FwLmMgfCAzMyArKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKPiA+ID4gZGlmZiAtLWdpdCBhL2xpYnMvbGli
bHRwc3dhcC9saWJzd2FwLmMgYi9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCj4gPiA+IGluZGV4
IDEzNjEwNzA5ZS4uNjIzZjJmYjNjIDEwMDY0NAo+ID4gPiAtLS0gYS9saWJzL2xpYmx0cHN3YXAv
bGlic3dhcC5jCj4gPiA+ICsrKyBiL2xpYnMvbGlibHRwc3dhcC9saWJzd2FwLmMKPiA+ID4gQEAg
LTEyLDYgKzEyLDE3IEBACj4gPiA+ICAjaW5jbHVkZSAibGlic3dhcC5oIgo+ID4gPiAgI2luY2x1
ZGUgImxhcGkvc3lzY2FsbHMuaCIKCj4gPiA+ICtzdGF0aWMgY29uc3QgY2hhciAqY29uc3Qgc3dh
cF9zdXBwb3J0ZWRfZnNbXSA9IHsKPiA+ID4gKyAgICAgImV4dDIiLAo+ID4gPiArICAgICAiZXh0
MyIsCj4gPiA+ICsgICAgICJleHQ0IiwKPiA+ID4gKyAgICAgInhmcyIsCj4gPiA+ICsgICAgICJ2
ZmF0IiwKPiA+ID4gKyAgICAgImV4ZmF0IiwKPiA+ID4gKyAgICAgIm50ZnMiLAo+ID4gPiArICAg
ICBOVUxMCj4gPiA+ICt9Owo+ID4gPiArCj4gPiA+ICAvKgo+ID4gPiAgICogTWFrZSBhIHN3YXAg
ZmlsZQo+ID4gPiAgICovCj4gPiA+IEBAIC00MCwyMyArNTEsMzEgQEAgaW50IG1ha2Vfc3dhcGZp
bGUoY29uc3QgY2hhciAqc3dhcGZpbGUsIGludCBzYWZlKQo+ID4gPiAgICovCj4gPiA+ICB2b2lk
IGlzX3N3YXBfc3VwcG9ydGVkKGNvbnN0IGNoYXIgKmZpbGVuYW1lKQo+ID4gPiAgewo+ID4gPiAr
ICAgICBpbnQgaSwgc3dfc3VwcG9ydCA9IDA7Cj4gPiA+ICAgICAgIGludCBmaWJtYXAgPSB0c3Rf
ZmlibWFwKGZpbGVuYW1lKTsKPiA+IEp1c3QgYSBub3RlIHVucmVsYXRlZCB0byB0aGlzIHBhdGNo
c2V0LiBXaGVuIHRlc3Rpbmcgb24gU0xFUyBrZXJuZWwgYmFzZWQKPiA+IG9uCj4gPiA1LjMuMTgg
d2Ugc3RpbGwgZ2V0IFRDT05GIGR1ZSBtaXNzaW5nIEZJQk1BUCBpb2N0bCBzdXBwb3J0OgoKPiA+
IHRzdF90ZXN0LmM6MTY2OTogVElORk86ID09PSBUZXN0aW5nIG9uIGJ0cmZzID09PQo+ID4gdHN0
X3Rlc3QuYzoxMTE4OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggYnRyZnMgb3B0
cz0nJyBleHRyYQo+ID4gb3B0cz0nJwo+ID4gdHN0X3Rlc3QuYzoxMTMyOiBUSU5GTzogTW91bnRp
bmcgL2Rldi9sb29wMCB0byAvdG1wL0xUUF9zd2F6YXFGMUwvbW50cG9pbnQKPiA+IGZzdHlwPWJ0
cmZzIGZsYWdzPTAKPiA+IHRzdF9pb2N0bC5jOjIxOiBUSU5GTzogRklCTUFQIGlvY3RsIGlzIE5P
VCBzdXBwb3J0ZWQ6IEVJTlZBTCAoMjIpCj4gPiBsaWJzd2FwLmM6NDU6IFRJTkZPOiBGU19OT0NP
V19GTCBhdHRyaWJ1dGUgc2V0IG9uIG1udHBvaW50L3N3YXBmaWxlMDEKCj4gPiBsaWJzd2FwLmM6
MTE0OiBUQ09ORjogU3dhcGZpbGUgb24gYnRyZnMgbm90IGltcGxlbWVudGVkCgoKPiBJbnRlcmVz
dGluZywgY2FuIHlvdSB0cnkgd2l0aCB0aGUgYmVsb3cgY29tbWFuZCBtYW51YWxseSB0byBzZWUg
aWYgc3dhcGZpbGUKPiBpcyBzdXBwb3J0ZWQgY29ycmVjdGx5IG9uIHRoZSBCVFJGUz8KPiAiY3V0
IGZyb20gbWFuIDUgYnRyZnMiCgo+ICAgICAgICAgICAjIHRydW5jYXRlIC1zIDAgc3dhcGZpbGUK
PiAgICAgICAgICAgIyBjaGF0dHIgK0Mgc3dhcGZpbGUKPiAgICAgICAgICAgIyBmYWxsb2NhdGUg
LWwgMkcgc3dhcGZpbGUKPiAgICAgICAgICAgIyBjaG1vZCAwNjAwIHN3YXBmaWxlCj4gICAgICAg
ICAgICMgbWtzd2FwIHN3YXBmaWxlCj4gICAgICAgICAgICMgc3dhcG9uIHN3YXBmaWxlCgpJdCB3
b3JrcyAodGVzdGVkIG9uIG9wZW5TVVNFIFR1bWJsZXdlZWQgd2l0aCA2LjYuMTEgd2hpY2ggYWxz
byByZXBvcnRlZCBGSUJNQVAKaW9jdGwgaXMgTk9UIHN1cHBvcnRlZCksIG9uIGZpbGUgY3JlYXRl
ZCB3aXRoOgoKZGQgaWY9L2Rldi96ZXJvIG9mPXN3YXBmaWxlIGJzPTQwME0gY291bnQ9MQoKIyBz
d2Fwb24gLXMKRmlsZW5hbWUJCQkJVHlwZQkJU2l6ZQkJVXNlZAkJUHJpb3JpdHkKL2Rldi92ZGEz
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcnRpdGlvbgkyMDk4MTUyCQkzNDE0OAkJ
LTIKL3Jvb3Qvc3dhcGZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIGZpbGUJCTIwOTcxNDgJ
CTAJCS0zCgojIGRmIC1oVCAuCkZpbGVzeXN0ZW0gICAgIFR5cGUgICBTaXplICBVc2VkIEF2YWls
IFVzZSUgTW91bnRlZCBvbgovZGV2L3ZkYTIgICAgICBidHJmcyAgIDI4RyAgIDIxRyAgMS40RyAg
OTUlIC9yb290CgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gPiBBbSBJIHdyb25nIG9yIGNvdWxkIGl0
IGJlIHNvbHZlZCB3aXRoIEZJRU1BUCAoPGxpbnV4L2ZpZW1hcC5oPik/Cj4gPiBJZiB5ZXMsIEkg
d29uZGVyIGlmIHdlIHNob3VsZCBmYWxsYmFjayBvbiBidHJmcyB3aGVuIEZJQk1BUCBpcyBtaXNz
aW5nCgo+ID4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvRG9jdW1lbnRhdGlvbi9maWxlc3lz
dGVtcy9maWVtYXAudHh0Cgo+ID4gaHR0cHM6Ly91bml4LnN0YWNrZXhjaGFuZ2UuY29tL3F1ZXN0
aW9ucy82MjM4NTkvaG93LWRvLXlvdS1maW5kLXRoZS1waHlzaWNhbC1vZmZzZXQtZm9yLWEtZmls
ZS1pbi1idHJmcwoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
