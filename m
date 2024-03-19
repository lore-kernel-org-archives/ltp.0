Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAB7C54E71
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 19:24:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C3A83D00AC
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 20:24:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 031633CE674
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 20:24:35 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 712C714052C4
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 20:24:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1613D2272A;
 Tue, 19 Mar 2024 19:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710876273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAMok/NqxRRG3VysjolM9hr2p0gGYPPoCFjJtMT+tD4=;
 b=m6EJtErc48bT8npVoyazrUMdEkw1TXaz6mO8fz+l3OxmLMK16V6LJT01LX8TZBo0hFi5gg
 3Dbqp1J7vVuraRBvy0klBqjb5O3FIT1oP+POwgWx2wShX+zWBu8NgtSLcm9998PBvfpKH/
 6RrKc27eNpHrie0iqAX8bGD4tqc/Yv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710876273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAMok/NqxRRG3VysjolM9hr2p0gGYPPoCFjJtMT+tD4=;
 b=mXAPBAgXXAYXukH3UPgauyzWlVXlnGeLN3qgvZ08iNMkjjtUd9RG+DojZF9RzxaQtOinX6
 2NDCy19ZrnqC6dCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710876273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAMok/NqxRRG3VysjolM9hr2p0gGYPPoCFjJtMT+tD4=;
 b=m6EJtErc48bT8npVoyazrUMdEkw1TXaz6mO8fz+l3OxmLMK16V6LJT01LX8TZBo0hFi5gg
 3Dbqp1J7vVuraRBvy0klBqjb5O3FIT1oP+POwgWx2wShX+zWBu8NgtSLcm9998PBvfpKH/
 6RrKc27eNpHrie0iqAX8bGD4tqc/Yv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710876273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAMok/NqxRRG3VysjolM9hr2p0gGYPPoCFjJtMT+tD4=;
 b=mXAPBAgXXAYXukH3UPgauyzWlVXlnGeLN3qgvZ08iNMkjjtUd9RG+DojZF9RzxaQtOinX6
 2NDCy19ZrnqC6dCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F071A136A5;
 Tue, 19 Mar 2024 19:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J6sKOnDm+WWSXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 19 Mar 2024 19:24:32 +0000
Date: Tue, 19 Mar 2024 20:24:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240319192422.GB424358@pevik>
References: <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
 <ZfezDUSKwUdoSamA@wegao.215.20.80>
 <CAEemH2cLfO9nMnOdB3wTuK6bmkfsPJp_fdQOXSFU-SfHfdQSZA@mail.gmail.com>
 <Zffm+yWYrGhyVTsf@wegao.213.190.243>
 <CAEemH2e4iC1+dViTu4WgNz4-BOTg+f9+9sggy+WKhK+ZsCQmvQ@mail.gmail.com>
 <Zfg2E59Pa1uF84di@wegao.115.61.67>
 <CAEemH2c--aHRW5ZqvBZTP2AVuoiKcY4x6GAxcaMb1KgbXVUEDA@mail.gmail.com>
 <20240319050357.GA417761@pevik>
 <CAEemH2eoeuvZB+=9iG0qJ6_2OSAN9S_7R+hq+i1pXFXmY4j_jQ@mail.gmail.com>
 <CAEemH2etj26fEXV7jk3jC=RcU=v18qDpkskhVOr8bDW5Fma4vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2etj26fEXV7jk3jC=RcU=v18qDpkskhVOr8bDW5Fma4vQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[49.23%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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

PiBPbiBUdWUsIE1hciAxOSwgMjAyNCBhdCAxOjQz4oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgoKCgo+ID4gT24gVHVlLCBNYXIgMTksIDIwMjQgYXQgMTowNOKAr1BNIFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPj4gPiBPbiBNb24sIE1hciAxOCwg
MjAyNCBhdCA4OjQw4oCvUE0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgoKCgoKPiA+
PiA+ID4gPiBUaGF0J3MgYmVjYXVzZSB0aGUgYXZhaWxhYmxlIHN3YXBmaWxlIG9uIHlvdXIgU1VU
IGlzIHRvbyBzbWFsbCwKPiA+PiA+ID4gPiB5b3UgY2FuIGFkanVzdCBpdCAodGhlbiByZXRlc3Qg
aXQpIGJ5IHlvdXJzZWxmIHRvIGZpbmQgYSBwcm9wZXIKPiA+PiBzaXplLgoKPiA+PiA+ID4gPiBU
aGlzIGlzIGZpbmUgYXMgbG9uZyBhcyB0aGUgc3dhcGZpbGUgc2l6ZSBpcyBsZXNzIHRoYW4gMzAw
TUIsCj4gPj4gPiA+ID4gb3RoZXJ3aXNlIHdlIG5lZWQgdG8gc2V0IC5kZXZfbWluX3NpemUgbGlr
ZSB3aGF0IHdlIGRpZAo+ID4+ID4gPiA+IGZvciBzd2Fwb2ZmMDEuYy4KCj4gPj4gPiA+ID4gQW5k
LCBvbiB0aGUgb3RoZXIgc2lkZSwgd2UgY2FuJ3QgZ3VhcmFudGVlIHRoZSBzeXN0ZW0gU3dhcENh
Y2hlZAo+ID4+ID4gPiA+IGhhcHBlbmVkIGV2ZXJ5IHRpbWUsIGl0IGRlcGVuZHMgb24gdGhlIHN5
c3RlbSdzIGNvbmZpZ3VyYXRpb24uCgoKPiA+PiA+ID4gMTAwTSBpcyBnb29kIGVub3VnaCBmb3Ig
Y3VycmVudCBzeXN0ZW0sIGNvdWxkIHlvdSBoZWxwIGNoZWNrIGZvbGxvd2luZwo+ID4+ID4gPiBw
YXRjaD8KCgo+ID4+ID4gQ2FuIHdlIHJld3JpdGUgdGhlIG1ha2Vfc3dhcGZpbGUoKSBBUEkgdG8g
c3VwcG9ydCBwYXNzaW5nIE1CIHNpemUgZm9yCj4gPj4gPiBtYWtpbmcgdGhlIHN3YXBmaWxlPwoK
PiA+PiBJIGd1ZXNzIGl0IHdvdWxkIGJlIGRlc2lyYWJsZSAoYnV0IGtlZXAgYWxzbyBwb3NzaWJs
ZSB0byBwYXNzIHRoYXQgMTAKPiA+PiBibG9ja3MsCj4gPj4gdGhlcmVmb3JlIG1heWJlIHVzZSBm
bGFnIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gTUIgYW5kIGJsb2Nrcz8pLgoKCj4gPiBUaGF0J3Mg
ZmluZSBidXQgYSBiaXQgY29tcGxleCBmb3IgdXNlcnMgdG8gZGlzdGluZ3Vpc2ggZmxhZ3MuCgo+
ID4gT3IsIHdoYXQgYWJvdXQgbWFraW5nIHRoZSBmdW5jdGlvbiB1c2UgdGhlIGZsYWcgYXMgc3Rh
dGljLCBhbmQKPiA+IGV4cG9ydCB0d28gYWRkaXRpb25hbCBmdW5jdGlvbnMgd2l0aCBNQiBhbmQg
YmxvY2tzPwoKPiA+IGVudW0gc3dhcGZpbGVfbWV0aG9kIHsKPiA+ICAgICBTV0FQRklMRV9CWV9T
SVpFLAo+ID4gICAgIFNXQVBGSUxFX0JZX0JMT0NLUwo+ID4gfTsKCj4gPiBzdGF0aWMgaW50IG1h
a2Vfc3dhcGZpbGUoY29uc3QgY2hhciAqc3dhcGZpbGUsIHVuc2lnbmVkIGludCBwYXJhLCBpbnQK
PiA+IHNhZmUsIGVudW0gc3dhcGZpbGVfbWV0aG9kIG1ldGhvZCkgewo+ID4gICAgIC8vIFRoZSBt
YWluIGxvZ2ljIHRvIGFjaGlldmUgdGhlIHN3YXBmaWxlLW1ha2luZyBwcm9jZXNzCj4gPiAgICAg
Ly8gLi4uCj4gPiB9Cgo+ID4gaW50IG1ha2Vfc3dhcGZpbGVfc2l6ZShjb25zdCBjaGFyICpzd2Fw
ZmlsZSwgdW5zaWduZWQgaW50IHNpemUsIGludCBzYWZlKSB7Cj4gPiAgICAgcmV0dXJuIG1ha2Vf
c3dhcGZpbGUoc3dhcGZpbGUsIHNpemUsIHNhZmUsIFNXQVBGSUxFX0JZX1NJWkUpOwo+ID4gfQoK
PiA+IGludCBtYWtlX3N3YXBmaWxlX2Jsa3MoY29uc3QgY2hhciAqc3dhcGZpbGUsIHVuc2lnbmVk
IGludCBibG9ja3MsIGludAo+ID4gc2FmZSkgewo+ID4gICAgIHJldHVybiBtYWtlX3N3YXBmaWxl
KHN3YXBmaWxlLCBibG9ja3MsIHNhZmUsIFNXQVBGSUxFX0JZX0JMT0NLUyk7Cj4gPiB9CgoKPiBF
dmVuIHNpbXBsZXIgdG8gZGVmaW5lIHR3byBtYWNyb3Mgd2l0aCBvbmUgbWFrZV9zd2FwZmlsZSgp
OgoKPiAjZGVmaW5lIE1BS0VfU1dBUEZJTEVfU0laRShzd2FwZmlsZSwgc2l6ZSwgc2FmZSkgXAo+
ICAgICBtYWtlX3N3YXBmaWxlKHN3YXBmaWxlLCBzaXplLCBzYWZlLCBTV0FQRklMRV9CWV9TSVpF
KQoKPiAjZGVmaW5lIE1BS0VfU1dBUEZJTEVfQkxLUyhzd2FwZmlsZSwgYmxvY2tzLCBzYWZlKSBc
Cj4gICAgIG1ha2Vfc3dhcGZpbGUoc3dhcGZpbGUsIGJsb2Nrcywgc2FmZSwgU1dBUEZJTEVfQllf
QkxPQ0tTKQoKKzEKCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
