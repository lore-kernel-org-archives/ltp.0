Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F92C4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 06:26:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C0493CE23B
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:26:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9C5D3C98F9
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 07:26:30 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56323200255
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 07:26:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E9841FB6D;
 Mon, 22 Jan 2024 06:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705904789;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9VSCaazo2zFzamnC3tQLpdq5ABP1koaA9Zfi4FjeGQ=;
 b=cttXd5+ThCaUecJX6TWlELlmxOjF+f6Xoh7rlC/+Nw9aGqn7LWet/IMsJb6Ib9LpnO4gRs
 3mjfZzo3iv8s852cyyI0crLToj+zEoF1SGYP7LTZO0zs4pX2FzTu0o8KQv/1ckRR6JMaXr
 ZJXIQAwVcQnZyZAxu8XL8QEXmsDjBnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705904789;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9VSCaazo2zFzamnC3tQLpdq5ABP1koaA9Zfi4FjeGQ=;
 b=JBpGoBhrcNxhR+4JvcG83qEqPXP7pnLmjk15M/MaJtE9AZCjM7xM9Ili0iXRj5MC9yMYt7
 VAuH7tAI6cUo9UDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705904789;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9VSCaazo2zFzamnC3tQLpdq5ABP1koaA9Zfi4FjeGQ=;
 b=cttXd5+ThCaUecJX6TWlELlmxOjF+f6Xoh7rlC/+Nw9aGqn7LWet/IMsJb6Ib9LpnO4gRs
 3mjfZzo3iv8s852cyyI0crLToj+zEoF1SGYP7LTZO0zs4pX2FzTu0o8KQv/1ckRR6JMaXr
 ZJXIQAwVcQnZyZAxu8XL8QEXmsDjBnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705904789;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9VSCaazo2zFzamnC3tQLpdq5ABP1koaA9Zfi4FjeGQ=;
 b=JBpGoBhrcNxhR+4JvcG83qEqPXP7pnLmjk15M/MaJtE9AZCjM7xM9Ili0iXRj5MC9yMYt7
 VAuH7tAI6cUo9UDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D113E139A2;
 Mon, 22 Jan 2024 06:26:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mdNKMZQKrmURPAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 06:26:28 +0000
Date: Mon, 22 Jan 2024 07:26:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240122062627.GB58756@pevik>
References: <20240119144322.41928-1-pvorel@suse.cz>
 <CAEemH2ceuoj+a2PK2pNStXYnsBcXM+g8JWkdd3Jj077xi+nm3A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ceuoj+a2PK2pNStXYnsBcXM+g8JWkdd3Jj077xi+nm3A@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] swapon01: Test on all filesystems
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

SGkgTGksIEN5cmlsLAoKPiBIaSBQZXRyLCBDeXJpbCwKCj4gT24gRnJpLCBKYW4gMTksIDIwMjQg
YXQgMTA6NDPigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gVGVz
dCBvbiBhbGwgZmlsZXN5c3RlbXMgdG8gaW5jcmVhc2UgY292ZXJhZ2UuCj4gPiBTa2lwIGZpbGVz
eXN0ZW1zIHdoaWNoIGRvZXMgbm90IHN1cHBvcnQgc3dhcCAoY3VycmVudGx5IGJjYWNoZWZzLCBi
dHJmcwo+ID4gYW5kIHRtcGZzKS4KCj4gPiBUZXN0ZWQgb24gNS4xMCwgNi42IGFuZCA2LjcuCgo+
ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiAtLS0KPiA+
IEhpIExpLCBDeXJpbCwKCj4gPiBmZWVsIGZyZWUgdG8gcG9zdHBvbmUgdGhpcyBhZnRlciB0aGUg
cmVsZWFzZS4KPiA+IElmIHdlIGFyZSBmb3IgYWRkaW5nIHRoaXMsIEknbGwgcmV0ZXN0IG9uIE1v
bmRheSBvbGRlciBmaWxlc3lzdGVtcy4KCj4gPiBtYW4gc3dhcG9uKDgpIG1lbnRpb25zOgoKPiA+
ICAgIEJ0cmZzCj4gPiAgICAgICAgU3dhcCBmaWxlcyBvbiBCdHJmcyBhcmUgc3VwcG9ydGVkIHNp
bmNlIExpbnV4IDUuMCBvbiBmaWxlcyB3aXRoCj4gPiBub2Nvdwo+ID4gICAgICAgIGF0dHJpYnV0
ZS4gU2VlIHRoZSBidHJmcyg1KSBtYW51YWwgcGFnZSBmb3IgbW9yZSBkZXRhaWxzLgoKPiA+ID0+
IENhbiB3ZSBwYXNzICJub2NvdyIganVzdCB0byBidHJmcz8gT3Igc2hvdWxkIGl0IGJlIGFkZGVk
IHRvIHNpbmdsZQo+ID4gdGVzdCwgd2hpY2ggdXNlcyBqdXN0IGJ0cmZzIHdpdGggbm9jb3c/Cgo+
ID4gICAgTkZTCj4gPiAgICAgICAgU3dhcCBvdmVyIE5GUyBtYXkgbm90IHdvcmsuCgo+ID4gPT4g
SSBndWVzcyB0aGlzIGlzIG5vdCBpbXBvcnRhbnQgZm9yIHVzLCBhcyBORlMgaXMgbm90IHBhcnQg
b2YKPiA+IGZpbGVzeXN0ZW1zIGluIC5hbGxfZmlsZXN5c3RlbXMsIGJ1dCBtYXliZSB3ZSBzaG91
bGQgc3RpbGwgYWRkIGl0IHRvIHRoZQo+ID4gd2hpdGVsaXN0PwoKPiA+IEtpbmQgcmVnYXJkcywK
PiA+IFBldHIKCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEu
YyB8IDIxICsrKysrKysrKysrKysrKy0tLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMKPiA+IGluZGV4IGU1OWZiMjBhMS4uZWY0ZWJmZGNmIDEw
MDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEu
Ywo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+
ID4gQEAgLTgsNiArOCw3IEBACj4gPiAgICogW0Rlc2NyaXB0aW9uXQo+ID4gICAqCj4gPiAgICog
Q2hlY2tzIHRoYXQgc3dhcG9uKCkgc3VjY2VkcyB3aXRoIHN3YXBmaWxlLgo+ID4gKyAqIFRlc3Rp
bmcgb24gYWxsIGZpbGVzeXN0ZW1zIHdoaWNoIHN1cHBvcnQgc3dhcCBmaWxlLgo+ID4gICAqLwoK
PiA+ICAjaW5jbHVkZSA8dW5pc3RkLmg+Cj4gPiBAQCAtMTcsMTMgKzE4LDE0IEBACj4gPiAgI2lu
Y2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKPiA+ICAjaW5jbHVkZSAibGlic3dhcC5oIgoKPiA+IC0j
ZGVmaW5lIFNXQVBfRklMRSAic3dhcGZpbGUwMSIKPiA+ICsjZGVmaW5lIE1OVFBPSU5UICAgICAg
ICJtbnRwb2ludCIKPiA+ICsjZGVmaW5lIFNXQVBfRklMRSAgICAgIE1OVFBPSU5UIi9zd2FwZmls
ZTAxIgoKPiA+ICBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9uKHZvaWQpCj4gPiAgewo+ID4gICAg
ICAgICBUU1RfRVhQX1BBU1ModHN0X3N5c2NhbGwoX19OUl9zd2Fwb24sIFNXQVBfRklMRSwgMCkp
OwoKPiA+IC0gICAgICAgaWYgKFRTVF9QQVNTICYmIHRzdF9zeXNjYWxsKF9fTlJfc3dhcG9mZiwg
U1dBUF9GSUxFKSAhPSAwKSB7Cj4gPiArICAgICAgIGlmICh0c3Rfc3lzY2FsbChfX05SX3N3YXBv
ZmYsIFNXQVBfRklMRSkgIT0gMCkgewo+ID4gICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0sg
fCBURVJSTk8sCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8g
dHVybiBvZmYgc3dhcGZpbGUsIHN5c3RlbQo+ID4gcmVib290IHJlY29tbWVuZGVkIik7Cj4gPiAg
ICAgICAgIH0KPiA+IEBAIC0zMSwxMyArMzMsMjAgQEAgc3RhdGljIHZvaWQgdmVyaWZ5X3N3YXBv
bih2b2lkKQoKPiA+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gIHsKPiA+IC0gICAgICAg
aXNfc3dhcF9zdXBwb3J0ZWQoU1dBUF9GSUxFKTsKPiA+ICAgICAgICAgbWFrZV9zd2FwZmlsZShT
V0FQX0ZJTEUsIDApOwo+ID4gIH0KCj4gPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0g
ewo+ID4gLSAgICAgICAubmVlZHNfcm9vdCA9IDEsCj4gPiAtICAgICAgIC5uZWVkc190bXBkaXIg
PSAxLAo+ID4gKyAgICAgICAubW50cG9pbnQgPSBNTlRQT0lOVCwKPiA+ICsgICAgICAgLm1vdW50
X2RldmljZSA9IDEsCj4gPiArICAgICAgIC5uZWVkc19yb290ID0gMSwgLyogZm9yIHN3YXBvbigp
ICovCj4gPiArICAgICAgIC5hbGxfZmlsZXN5c3RlbXMgPSAxLAo+ID4gICAgICAgICAudGVzdF9h
bGwgPSB2ZXJpZnlfc3dhcG9uLAo+ID4gLSAgICAgICAuc2V0dXAgPSBzZXR1cAo+ID4gKyAgICAg
ICAuc2V0dXAgPSBzZXR1cCwKPiA+ICsgICAgICAgLnNraXBfZmlsZXN5c3RlbXMgPSAoY29uc3Qg
Y2hhciAqW10pIHsKPiA+ICsgICAgICAgICAgICAgICAiYmNhY2hlZnMiLAo+ID4gKyAgICAgICAg
ICAgICAgICJidHJmcyIsCj4gPiArICAgICAgICAgICAgICAgInRtcGZzIiwKPiA+ICsgICAgICAg
ICAgICAgICBOVUxMCj4gPiArICAgICAgIH0sCgoKCj4gSU1ITywgSSBoYXRlIHRvIGFkZCB0aGUg
c2tpcF9maWxlc3lzdGVtIGluIHRoaXMgdGVzdCwgYmVjYXVzZSBpZiB3ZSBkbywKPiB0aGVuIHdl
IGhhdmUgdG8gYWRkIHRvIGFsbCBvZiB0aGUgcmVsYXRlZCBzd2FwIHRlc3RzIHRoYXQsIGl0IGFk
ZCBtb3JlCj4gdGVkaW91cyB3b3JrIHRvIHBlb3BsZS4KCkZpcnN0IEkgdGhvdWdodCBpdCdkIGJl
IG9rIHRvIGhhdmUganVzdCBzaW5nbGUgdGVzdCB3aGljaCB1c2VzIGFsbF9maWxlc3lzdGVtcwoo
YmV0dGVyIG9uZSB0aGFuIG5vbmUpLCBidXQgc3VyZSwgaGF2aW5nIGFsbCBvZiB0aGVtIHdvdWxk
IGJlIGJldHRlci4KCj4gU28sIGlmIHdlIGRlY2lkZSB0byBwb3N0cG9uZSB0aGlzIHBhdGNoIHRv
IHJlbGVhc2UsIHdlIGNhbiBqdXN0IHJlZmFjdG9yCj4gdGhlIGlzX3N3YXBfc3VwcG9ydGVkKCkg
ZnVuY3Rpb24gdG8gbWFrZSB0aGluZ3MgZWFzaWVyLiBJIHdpbGwgc2VuZCBhbiBSRkMKPiBwYXRj
aCB0byBzaG93IHNvbWV0aGluZyBpbiBteSBtaW5kLCB3aGF0IHdlIG5lZWQgdG8gZG8gbGF0ZXIg
aXMganVzdAo+IHRvIGZpbmFsaXplIHRoZSBzd2FwX3N1cHBvcnRlZF9mc1tdIHN0cnVjdCBsaXN0
LgoKU3VyZSwgdGhpcyBpcyBub3QgY3JpdGljYWwsIGl0IGNhbiB3YWl0IGlmIHlvdSBoYXZlIGJl
dHRlciBzb2x1dGlvbi4gVGhhbmtzCmZvciBzcGVuZGluZyB0aW1lIG9uIGl0LgoKS2luZCByZWdh
cmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
