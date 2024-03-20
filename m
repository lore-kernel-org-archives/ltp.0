Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF81C54E67
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 07:56:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2AA23CD808
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 08:56:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD3273CD808
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:56:38 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 16198200D1E
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:56:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5929620A4F;
 Wed, 20 Mar 2024 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710921396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AsUsdZLfKTXq5iAOiKZm+/fHK6hQXZKaMEwIt/wB2Rs=;
 b=RLcXdSRdXItNwG3m+Rj6ZzjGxtiUQFFl4wKMSk0q4/FH3eb42HKahkS62oyCk622qG0zg1
 g7fAukGx4RoRdG73VronZ6lIpnwCnF3xVVClMs34Pb5Wih80rU+ILp3mP8hmWg0ncU9iOS
 rMHEOqjBvR/SaLyZKfzVUUuLX7XvGjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710921396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AsUsdZLfKTXq5iAOiKZm+/fHK6hQXZKaMEwIt/wB2Rs=;
 b=geACMBZqEPrVcK5QwrDcTAfP20A2Xhh/uW4h5y2lnJOsxXYWPIiIp7HsIBVqs7IF/tFax6
 cuFzf4JBhjZwBPCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710921396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AsUsdZLfKTXq5iAOiKZm+/fHK6hQXZKaMEwIt/wB2Rs=;
 b=RLcXdSRdXItNwG3m+Rj6ZzjGxtiUQFFl4wKMSk0q4/FH3eb42HKahkS62oyCk622qG0zg1
 g7fAukGx4RoRdG73VronZ6lIpnwCnF3xVVClMs34Pb5Wih80rU+ILp3mP8hmWg0ncU9iOS
 rMHEOqjBvR/SaLyZKfzVUUuLX7XvGjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710921396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AsUsdZLfKTXq5iAOiKZm+/fHK6hQXZKaMEwIt/wB2Rs=;
 b=geACMBZqEPrVcK5QwrDcTAfP20A2Xhh/uW4h5y2lnJOsxXYWPIiIp7HsIBVqs7IF/tFax6
 cuFzf4JBhjZwBPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3974136D6;
 Wed, 20 Mar 2024 07:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /1MQMq6W+mVFNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 07:56:30 +0000
Date: Wed, 20 Mar 2024 08:56:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240320075605.GA457754@pevik>
References: <20240320063218.449072-1-pvorel@suse.cz>
 <CAEemH2eRspxMmD4LEQ-ospJES2BWAHLqhviX_1uSM=-eefnQug@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eRspxMmD4LEQ-ospJES2BWAHLqhviX_1uSM=-eefnQug@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.54 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.04)[58.61%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: Add tst_selinux_enforcing()
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
Cc: Mete Durlu <meted@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksIGFsbCwKCj4gSGkgUGV0ciwKCj4gT24gV2VkLCBNYXIgMjAsIDIwMjQgYXQgMjozMuKA
r1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiBDby1kZXZlbG9wZWQt
Ynk6IE1ldGUgRHVybHUgPG1ldGVkQGxpbnV4LmlibS5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KCgo+IFRoaXMgcGF0Y2ggaXMgZG9pbmcgdGhlIHNh
bWUgd29yayBhcyBzZWN1cml0eV9nZXRlbmZvcmNlKCkgd2hpY2ggcHJvdmlkZXMKPiBieSAnc2Vs
aW51eC9zZWxpbnV4LmgnLCBidXQgaXQgaXMgc3RpbGwgd29ydGggaGF2aW5nIGl0IGJlY2F1c2Ug
d2UgZG8gbm90Cj4gd2FudCBsdHAKPiBoYXMgbWFueSBleHRyYSBkZXBlbmRlbmNpZXMgKGUuZy4g
bGlic2VsaW51eC1kZXZlbCkuCgorMQoKPiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJl
ZGhhdC5jb20+CgpUaGFua3MhCgo+ID4gLS0tCj4gPiBIaSwKCj4gPiBATGksIEN5cmlsOgo+ID4g
MSkgSSBndWVzcyB3ZSB3YW50IHRvIGRpc3Rpbmd1aXNoIEVBQ0NFUyBmb3IgU0VMaW51eCBlbmZv
cmNpbmcsIHJpZ2h0Pwo+ID4gSWYgbm90LCB0aGlzIGNvbW1pdCB3b3VsZCBiZSBkcm9wcGVkIGFu
ZCBzZWNvbmQgY29tbWl0IHdvdWxkIGp1c3QgdXNlCgo+ID4gICAgICAgICBjb25zdCBpbnQgZXhw
X2VycnNbXSA9IHt0Yy0+ZXhwZWN0ZWRfZXJybm8sIEVBQ0NFU307Cgo+ID4gICAgICAgICBUU1Rf
RVhQX0ZBSUxfQVJSKGZhbm90aWZ5X21hcmsoZmFub3RpZnlfZmQsIEZBTl9NQVJLX0FERCB8Cj4g
PiB0Yy0+bWFyay5mbGFncywKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICB0Yy0+bWFzay5m
bGFncywgZGlyZmQsIHBhdGgpLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIGV4cF9lcnJz
KTsKCj4gPiAyKSBTb21lIHRpbWUgYWdvIEkgcHJvcG9zZWQgdG8gbWVyZ2Ugc29tZSBsaWIvKi5j
IGZpbGVzLCBub3QKPiA+IGp1c3QgaGF2ZSBzbyBtYW55IGZpbGVzIHdpdGggc2luZ2xlIGZ1bmN0
aW9ucyBpbiB0aGUgbGlicmFyeS4gRS5nLgo+ID4gbGliL3RzdF9maXBzLmMsIGxpYi90c3Rfc2Vs
aW51eC5jLCBsaWIvdHN0X2xvY2tkb3duLmMgY291bGQgYmUgbWVyZ2VkCj4gPiBpbnRvIGxpYi90
c3Rfc2VjdXJpdHkuYy4gT3IgZG8gd2Ugd2FudCB0byBoYXZlIHRoZXNlIHNlcGFyYXRlPwoKCj4g
SSB0aGluayB0aGUgYW5zd2VyIGlzIFllcy4gVGhlcmUgYXJlIG1vcmUgYW5kIG1vcmUgbGliLyou
YyBmaWxlcyB3aXRoCgpJIHJlYWQgIlllcyIgYXMgdG8ga2VlcCBsaWIvdHN0X3NlbGludXguYywg
bGliL3RzdF9sb2NrZG93bi5jIGFzIHNlcGFyYXRlLgoKSSdtIG5vdCBzdXJlIG15c2VsZiAocXVp
dGUgc2VwYXJhdGUgdGhpbmdzLCBhbHRob3VnaCB0aGV5IGFyZSBhbGwgInNlY3VyaXR5IiksCndo
YXQgYm90aGVycyBtZSBtb3JlIGFyZSB0aGVzZSB0c3RfZGlyX2lzX2VtcHR5LmMsIHRzdF9wYXRo
X2hhc19tbnRfZmxhZ3MuYwpmaWxlcy4KCj4gc29tZSB0cml2aWFsIGZlYXR1cmVzLCB3aGljaCBi
cmluZyB0cm91YmxlcyBmb3IgcmVhZGluZy9tYW5hZ2luZyB0aGUKPiBsaWJyYXJ5LiBJdCBpcyBu
ZWNlc3NhcnkgdG8gYXJjaGl2ZSBhbmQgbWVyZ2UgdGhlIHNhbWUgdGhpbmcuCgoKPiA+IFdoZW4g
SSBwcm9wb3NlZCB0aGlzLCBJIHdhbnRlZCB0byBtZXJnZSBmaWxlcywgd2hpY2ggaGF2ZSB0aGUg
c2FtZSBuYW1lCj4gPiBhcyB0aGUgc2luZ2xlIGZ1bmN0aW9uIGluIHRoZSBmaWxlIChlLmcuIHRz
dF9kaXJfaXNfZW1wdHkuYywKPiA+IHRzdF9wYXRoX2hhc19tbnRfZmxhZ3MuYyksIGhhdmluZyB0
aGVtIGFzIHNpbmdsZSBmaWxlIGRvZXMgbm90IGhlbHAgbXVjaAo+ID4gd2l0aCBzZWFyY2hpbmcg
Zm9yIHRoZSBjb250ZW50LgoKCj4gKzEKCj4gQW5kIHRoZSBtb3N0IGltcG9ydGFudCBpcyB3ZSBu
ZWVkIHRvIGdpdmUgYSBnb29kIG5hbWUgZm9yIHRoZQo+IGFjaGlldmVkIGhlYWRlciBmaWxlLgoK
KzEKCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
