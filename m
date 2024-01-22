Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FCDC4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 08:24:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF7B13CD19D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 09:24:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6C193CD19D
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 09:24:41 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CDD6F100036F
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 09:24:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CDBB41FBAE;
 Mon, 22 Jan 2024 08:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705911879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmvRFGg4gyFHbEl6vE6dWHbnN+A2gl//Px18y/TMX3E=;
 b=0dRZS2ToOv/6Pm1GB5E0v4Ui4H/aJE8AKXdhZ97u+rRxPdjAh7pXndQYDpF3BHJV4h1uSx
 DXe7OLk9euOq2TE46rFtJ6CUnJkAt2z8gWmxRSdPIfre45YJkt9s8I8N+PAKrEB1D8m4/2
 EWeMVbPNiVInK5jDAHmoWbb+YTd462o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705911879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmvRFGg4gyFHbEl6vE6dWHbnN+A2gl//Px18y/TMX3E=;
 b=VVLJ0q6Ut7EguBwQslacIiWhzqElO9tt1/eoMpyFT9Coqrqd+U3HwauxvoQxj3AeDrGwQS
 CvV9tqkxFPOzIhDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705911878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmvRFGg4gyFHbEl6vE6dWHbnN+A2gl//Px18y/TMX3E=;
 b=HIrSKfYx/whojnzFFjkQNp54AhhUuHodWZbibnNBLPb0gFttKEM6GJwndVRAPmVAHldKon
 ER1+F4ps72sVx6qPPkj7NbuIOMC6hv/Q7TjxTyTMO5lYN/+Z7gTGPC7NAYR4s8ouiPLeOw
 Vxj8rd4yRF+XWHb0AD5UMjPnTBxzjEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705911878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmvRFGg4gyFHbEl6vE6dWHbnN+A2gl//Px18y/TMX3E=;
 b=kvFeJJYebgc3CZIyKk9bUGskS5DF4fSjfrovF+pUdriweLRPDI3ZqyGWg7qOwi83gSRFgW
 uYSsKucZb9RnGZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B223A139A8;
 Mon, 22 Jan 2024 08:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ni4BKkYmrmV2WwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 08:24:38 +0000
Date: Mon, 22 Jan 2024 09:24:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240122082437.GA76754@pevik>
References: <20240119144322.41928-1-pvorel@suse.cz>
 <CAEemH2ceuoj+a2PK2pNStXYnsBcXM+g8JWkdd3Jj077xi+nm3A@mail.gmail.com>
 <20240122062627.GB58756@pevik>
 <CAEemH2epxiFvRCaXaGgbJ2uW36qrbJJ_zAYyUOwnS2Z7uqtpDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2epxiFvRCaXaGgbJ2uW36qrbJJ_zAYyUOwnS2Z7uqtpDg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.996];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

SGkgTGksCgoKPiBPbiBNb24sIEphbiAyMiwgMjAyNCBhdCAyOjI34oCvUE0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLCBDeXJpbCwKCj4gPiA+IEhpIFBldHIs
IEN5cmlsLAoKPiA+ID4gT24gRnJpLCBKYW4gMTksIDIwMjQgYXQgMTA6NDPigK9QTSBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gPiA+IFRlc3Qgb24gYWxsIGZpbGVzeXN0
ZW1zIHRvIGluY3JlYXNlIGNvdmVyYWdlLgo+ID4gPiA+IFNraXAgZmlsZXN5c3RlbXMgd2hpY2gg
ZG9lcyBub3Qgc3VwcG9ydCBzd2FwIChjdXJyZW50bHkgYmNhY2hlZnMsIGJ0cmZzCj4gPiA+ID4g
YW5kIHRtcGZzKS4KCj4gPiA+ID4gVGVzdGVkIG9uIDUuMTAsIDYuNiBhbmQgNi43LgoKPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiA+ID4gPiAtLS0K
PiA+ID4gPiBIaSBMaSwgQ3lyaWwsCgo+ID4gPiA+IGZlZWwgZnJlZSB0byBwb3N0cG9uZSB0aGlz
IGFmdGVyIHRoZSByZWxlYXNlLgo+ID4gPiA+IElmIHdlIGFyZSBmb3IgYWRkaW5nIHRoaXMsIEkn
bGwgcmV0ZXN0IG9uIE1vbmRheSBvbGRlciBmaWxlc3lzdGVtcy4KCj4gPiA+ID4gbWFuIHN3YXBv
big4KSBtZW50aW9uczoKCj4gPiA+ID4gICAgQnRyZnMKPiA+ID4gPiAgICAgICAgU3dhcCBmaWxl
cyBvbiBCdHJmcyBhcmUgc3VwcG9ydGVkIHNpbmNlIExpbnV4IDUuMCBvbiBmaWxlcyB3aXRoCj4g
PiA+ID4gbm9jb3cKPiA+ID4gPiAgICAgICAgYXR0cmlidXRlLiBTZWUgdGhlIGJ0cmZzKDUpIG1h
bnVhbCBwYWdlIGZvciBtb3JlIGRldGFpbHMuCgo+ID4gPiA+ID0+IENhbiB3ZSBwYXNzICJub2Nv
dyIganVzdCB0byBidHJmcz8gT3Igc2hvdWxkIGl0IGJlIGFkZGVkIHRvIHNpbmdsZQo+ID4gPiA+
IHRlc3QsIHdoaWNoIHVzZXMganVzdCBidHJmcyB3aXRoIG5vY293PwoKPiA+ID4gPiAgICBORlMK
PiA+ID4gPiAgICAgICAgU3dhcCBvdmVyIE5GUyBtYXkgbm90IHdvcmsuCgo+ID4gPiA+ID0+IEkg
Z3Vlc3MgdGhpcyBpcyBub3QgaW1wb3J0YW50IGZvciB1cywgYXMgTkZTIGlzIG5vdCBwYXJ0IG9m
Cj4gPiA+ID4gZmlsZXN5c3RlbXMgaW4gLmFsbF9maWxlc3lzdGVtcywgYnV0IG1heWJlIHdlIHNo
b3VsZCBzdGlsbCBhZGQgaXQgdG8KPiA+IHRoZQo+ID4gPiA+IHdoaXRlbGlzdD8KCj4gPiA+ID4g
S2luZCByZWdhcmRzLAo+ID4gPiA+IFBldHIKCj4gPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMgfCAyMSArKysrKysrKysrKysrKystLS0tLS0KPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgo+ID4g
PiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24w
MS5jCj4gPiA+ID4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5j
Cj4gPiA+ID4gaW5kZXggZTU5ZmIyMGExLi5lZjRlYmZkY2YgMTAwNjQ0Cj4gPiA+ID4gLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4gPiA+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMKPiA+ID4gPiBAQCAt
OCw2ICs4LDcgQEAKPiA+ID4gPiAgICogW0Rlc2NyaXB0aW9uXQo+ID4gPiA+ICAgKgo+ID4gPiA+
ICAgKiBDaGVja3MgdGhhdCBzd2Fwb24oKSBzdWNjZWRzIHdpdGggc3dhcGZpbGUuCj4gPiA+ID4g
KyAqIFRlc3Rpbmcgb24gYWxsIGZpbGVzeXN0ZW1zIHdoaWNoIHN1cHBvcnQgc3dhcCBmaWxlLgo+
ID4gPiA+ICAgKi8KCj4gPiA+ID4gICNpbmNsdWRlIDx1bmlzdGQuaD4KPiA+ID4gPiBAQCAtMTcs
MTMgKzE4LDE0IEBACj4gPiA+ID4gICNpbmNsdWRlICJsYXBpL3N5c2NhbGxzLmgiCj4gPiA+ID4g
ICNpbmNsdWRlICJsaWJzd2FwLmgiCgo+ID4gPiA+IC0jZGVmaW5lIFNXQVBfRklMRSAic3dhcGZp
bGUwMSIKPiA+ID4gPiArI2RlZmluZSBNTlRQT0lOVCAgICAgICAibW50cG9pbnQiCj4gPiA+ID4g
KyNkZWZpbmUgU1dBUF9GSUxFICAgICAgTU5UUE9JTlQiL3N3YXBmaWxlMDEiCgo+ID4gPiA+ICBz
dGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9uKHZvaWQpCj4gPiA+ID4gIHsKPiA+ID4gPiAgICAgICAg
IFRTVF9FWFBfUEFTUyh0c3Rfc3lzY2FsbChfX05SX3N3YXBvbiwgU1dBUF9GSUxFLCAwKSk7Cgo+
ID4gPiA+IC0gICAgICAgaWYgKFRTVF9QQVNTICYmIHRzdF9zeXNjYWxsKF9fTlJfc3dhcG9mZiwg
U1dBUF9GSUxFKSAhPSAwKSB7Cj4gPiA+ID4gKyAgICAgICBpZiAodHN0X3N5c2NhbGwoX19OUl9z
d2Fwb2ZmLCBTV0FQX0ZJTEUpICE9IDApIHsKPiA+ID4gPiAgICAgICAgICAgICAgICAgdHN0X2Jy
ayhUQlJPSyB8IFRFUlJOTywKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJGYWlsZWQgdG8gdHVybiBvZmYgc3dhcGZpbGUsIHN5c3RlbQo+ID4gPiA+IHJlYm9vdCByZWNv
bW1lbmRlZCIpOwo+ID4gPiA+ICAgICAgICAgfQo+ID4gPiA+IEBAIC0zMSwxMyArMzMsMjAgQEAg
c3RhdGljIHZvaWQgdmVyaWZ5X3N3YXBvbih2b2lkKQoKPiA+ID4gPiAgc3RhdGljIHZvaWQgc2V0
dXAodm9pZCkKPiA+ID4gPiAgewo+ID4gPiA+IC0gICAgICAgaXNfc3dhcF9zdXBwb3J0ZWQoU1dB
UF9GSUxFKTsKPiA+ID4gPiAgICAgICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAwKTsKPiA+
ID4gPiAgfQoKPiA+ID4gPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ID4gPiA+
IC0gICAgICAgLm5lZWRzX3Jvb3QgPSAxLAo+ID4gPiA+IC0gICAgICAgLm5lZWRzX3RtcGRpciA9
IDEsCj4gPiA+ID4gKyAgICAgICAubW50cG9pbnQgPSBNTlRQT0lOVCwKPiA+ID4gPiArICAgICAg
IC5tb3VudF9kZXZpY2UgPSAxLAo+ID4gPiA+ICsgICAgICAgLm5lZWRzX3Jvb3QgPSAxLCAvKiBm
b3Igc3dhcG9uKCkgKi8KPiA+ID4gPiArICAgICAgIC5hbGxfZmlsZXN5c3RlbXMgPSAxLAo+ID4g
PiA+ICAgICAgICAgLnRlc3RfYWxsID0gdmVyaWZ5X3N3YXBvbiwKPiA+ID4gPiAtICAgICAgIC5z
ZXR1cCA9IHNldHVwCj4gPiA+ID4gKyAgICAgICAuc2V0dXAgPSBzZXR1cCwKPiA+ID4gPiArICAg
ICAgIC5za2lwX2ZpbGVzeXN0ZW1zID0gKGNvbnN0IGNoYXIgKltdKSB7Cj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICJiY2FjaGVmcyIsCj4gPiA+ID4gKyAgICAgICAgICAgICAgICJidHJmcyIsCj4g
PiA+ID4gKyAgICAgICAgICAgICAgICJ0bXBmcyIsCj4gPiA+ID4gKyAgICAgICAgICAgICAgIE5V
TEwKPiA+ID4gPiArICAgICAgIH0sCgoKCj4gPiA+IElNSE8sIEkgaGF0ZSB0byBhZGQgdGhlIHNr
aXBfZmlsZXN5c3RlbSBpbiB0aGlzIHRlc3QsIGJlY2F1c2UgaWYgd2UgZG8sCj4gPiA+IHRoZW4g
d2UgaGF2ZSB0byBhZGQgdG8gYWxsIG9mIHRoZSByZWxhdGVkIHN3YXAgdGVzdHMgdGhhdCwgaXQg
YWRkIG1vcmUKPiA+ID4gdGVkaW91cyB3b3JrIHRvIHBlb3BsZS4KCj4gPiBGaXJzdCBJIHRob3Vn
aHQgaXQnZCBiZSBvayB0byBoYXZlIGp1c3Qgc2luZ2xlIHRlc3Qgd2hpY2ggdXNlcwo+ID4gYWxs
X2ZpbGVzeXN0ZW1zCj4gPiAoYmV0dGVyIG9uZSB0aGFuIG5vbmUpLCBidXQgc3VyZSwgaGF2aW5n
IGFsbCBvZiB0aGVtIHdvdWxkIGJlIGJldHRlci4KCj4gPiA+IFNvLCBpZiB3ZSBkZWNpZGUgdG8g
cG9zdHBvbmUgdGhpcyBwYXRjaCB0byByZWxlYXNlLCB3ZSBjYW4ganVzdCByZWZhY3Rvcgo+ID4g
PiB0aGUgaXNfc3dhcF9zdXBwb3J0ZWQoKSBmdW5jdGlvbiB0byBtYWtlIHRoaW5ncyBlYXNpZXIu
IEkgd2lsbCBzZW5kIGFuCj4gPiBSRkMKPiA+ID4gcGF0Y2ggdG8gc2hvdyBzb21ldGhpbmcgaW4g
bXkgbWluZCwgd2hhdCB3ZSBuZWVkIHRvIGRvIGxhdGVyIGlzIGp1c3QKPiA+ID4gdG8gZmluYWxp
emUgdGhlIHN3YXBfc3VwcG9ydGVkX2ZzW10gc3RydWN0IGxpc3QuCgo+ID4gU3VyZSwgdGhpcyBp
cyBub3QgY3JpdGljYWwsIGl0IGNhbiB3YWl0IGlmIHlvdSBoYXZlIGJldHRlciBzb2x1dGlvbi4g
VGhhbmtzCj4gPiBmb3Igc3BlbmRpbmcgdGltZSBvbiBpdC4KCgo+IFllcywgYnV0IGl0IGlzIHJl
YWR5IHRoZXJlIDEvNCA6KS4KPiAgIGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0
cC8yMDI0LUphbnVhcnkvMDM2ODA0Lmh0bWwKCj4gVGhlIHJlc3Qgd29yayBpcyBqdXN0IHRvIGZp
bmFsaXplIHRoZSBzd2FwX3N1cHBvcnRlZF9mcyBsaXN0Lgo+IEFuZCwgSSBhZ3JlZSB0aGF0IGFs
bCBvZiB0aGVzZSBjYW4gYmUgcG9zdHBvbmVkLiBCZWNhdXNlCj4gc28gZmFyIGl0IHdvbid0IGJl
IGEgY3JpdGljYWwvdXJnZW50LWZpeCBmb3IgYSBuZXcgcmVsZWFzZS4KCk9UT0ggaWYgeW91IHBy
ZXBhcmVkIHRoaXMsIEknbSBvayB0byByZXZpZXcgYW5kIHRlc3QuCkkgYWxyZWFkeSBydW4gdmFy
aW91cyB0ZXN0cyBvbiB0aGlzLgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
