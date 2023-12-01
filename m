Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4993C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 16:40:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8ED33CF61B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 17:40:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 687213CD424
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 17:40:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B97BE201182
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 17:40:06 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 848BA1FD80;
 Fri,  1 Dec 2023 16:40:05 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 47AD01344E;
 Fri,  1 Dec 2023 16:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id px1eD2UMamXbZQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Dec 2023 16:40:05 +0000
Date: Fri, 1 Dec 2023 17:40:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20231201164003.GA2805452@pevik>
References: <29d08b1d-13c7-4236-a2d5-0d7d1a0ea942@suse.com>
 <CAEemH2fJ+HS4pjw75uLE91XM5Ju8z9+pjeNevjwWb9WBSJ28Zw@mail.gmail.com>
 <20231201120809.GA2779521@pevik>
 <90333e17-2f02-475d-9db1-716128e4973f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <90333e17-2f02-475d-9db1-716128e4973f@suse.com>
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Rspamd-Queue-Id: 848BA1FD80
X-Spamd-Result: default: False [15.19 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; TO_DN_EQ_ADDR_SOME(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_SPF_SOFTFAIL(4.60)[~all]; DMARC_NA(1.20)[suse.cz];
 RCVD_COUNT_THREE(0.00)[3]; ARC_NA(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MX_GOOD(-0.01)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[10.74%]
X-Spam: Yes
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 6th of November 09:00 UTC
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSEKCj4gT24gMTIvMS8yMyAxMzowOCwgUGV0ciBWb3JlbCB3cm90ZToKPiA+IEhpIExpLCBB
bmRyZWEsIGFsbCwKCj4gPiA+IEhpIEFuZHJlYSwKPiA+ID4gT24gRnJpLCBEZWMgMSwgMjAyMyBh
dCA3OjI14oCvUE0gQW5kcmVhIENlcnZlc2F0byB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+
Cj4gPiA+IHdyb3RlOgo+ID4gPiA+IEhlbGxvLAo+ID4gPiA+IHRoaXMgaXMgYSBmcmllbmRseSBy
ZW1pbmRlciBmb3IgdGhlIExUUCBtYWlsaW5nIGxpc3QgYWJvdXQgbW9udGhseSBtZWV0aW5nLgo+
ID4gPiA+IEFzIHByZXZpb3VzbHkgZGlzY3Vzc2VkLgo+ID4gPiA+IFRpbWUgYW5kIGRhdGU6IEZp
cnN0IFdlZG5lc2RheSBlYWNoIG1vbnRoIGF0IDA5OjAwIFVUQy4KPiA+ID4gPiBQbGF0Zm9ybTog
aHR0cHM6Ly9tZWV0LmppdC5zaS9saW51eC10ZXN0LXByb2plY3QKCj4gPiA+IERvIHdlIHBsYW4g
dG8gc3dpdGNoIHRvIEdvb2dsZSBtZWV0PyBhbmQgd2lsbCB3ZSBoYXZlIGEgdmlkZW8gcmVjb3Jk
aW5nIG9mCj4gPiA+IHRoYXQ/Cj4gPiBHb29kIHBvaW50LCBXZSBzaG91bGQgZG8uCj4gWWVzLCBn
b29kIHBvaW50LiBJIHdvdWxkIHN1Z2dlc3QgdG8ga2VlcCBKaXRzaSBmb3IgdGhpcyB0aW1lLCBz
aW5jZSB3ZSBhcmUKPiByZWFsbHkgY2xvc2UgdG8gdGhlIG1lZXRpbmcgYW5kCj4gd2Ugc3RpbGwg
bmVlZCB0byBleHBlcmltZW50IHdpdGggR29vZ2xlIG1lZXQuCgpXZWxsLCBJIHVzZSBpdCByZWd1
bGFybHkgYW5kIGl0IHdvcmtzLCBiZXR0ZXIgdGhhbiBqaXRzaSBpbnN0YW5jZSBvbgptZWV0Lmpp
dC5zaS4KCkkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgbXVjaCB0byBleHBlcmltZW50IHdpdGggZ29v
Z2xlIG1lZXQuCgo+IFdoYXQgZG8geW91IHRoaW5rPwoKSG93IGFib3V0IHVzZSB0aGlzPwpodHRw
czovL21lZXQuZ29vZ2xlLmNvbS9xamQtbWJhcC1zdWIKKHVuZm9ydHVuYXRlbHkgZ29vZ2xlIGRv
ZXMgbm90IGFsbG93IHRvIHNldCB0aGUgbWVldGluZyBzcGVjaWZpYyBsaW5rKQoKSSBjYW4gY29u
bmVjdCBhbHNvIG9uIGh0dHBzOi8vbWVldC5qaXQuc2kvbGludXgtdGVzdC1wcm9qZWN0IGFuZCBu
YXZpZ2F0ZSB0bwpwZW9wbGUgdG8gbWVldC5nb29nbGUuY29tIChpZiB0aGVyZSBhcmUgYW55Ym9k
eSkuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gPiA+IEknbSBhZnJhaWQgdGhpcyB0aW1lIEkgaGF2
ZSB0byBiZSBhYnNlbnQgKHNpbmNlIG5vIGxhcHRvcCBvbiBteSB0cmF2ZWxpbmcpLgo+ID4gSSdt
IHNvcnJ5LCBidXQgdW5kZXJzdGFuZC4gSGF2ZSBzYWZlIHRyYXZlbGxpbmcuCgo+ID4gS2luZCBy
ZWdhcmRzLAo+ID4gUGV0cgoKPiA+ID4gVGhhbmtzIGEgbG90IGZvciBhcnJhbmdpbmcgdGhpcy4K
Cj4gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
