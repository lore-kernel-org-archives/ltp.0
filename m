Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7F0C4332F
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 09:33:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0D723CCBAD
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 10:33:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A24873C0F12
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 10:33:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB6D61BBD721
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 10:33:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF28B21AC7;
 Mon, 21 Nov 2022 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669023194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0lqPN5Ygm6NsfQQLENh6OUjdObJszdDCWyqTK+zvbu4=;
 b=ERiZp86KAv6K+rbCkABNstB+mCWBwa8e9b1CWGMI4Gy7Y0s0ALhIWwesWeT5jSMmnCjRwo
 3OOaUxdvoGflChUK/rA8zsPwlZT3VjiudqN6CFqaPFCmnen0SyXHRR4DVHXBbrabyvSijR
 FuooRKk6uiua76oqsGGj1ls+QBrqY2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669023194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0lqPN5Ygm6NsfQQLENh6OUjdObJszdDCWyqTK+zvbu4=;
 b=VmzwmYApEseTmm+a1ZTgmEqaM1C6y3RBjWbz5fBsAj0N4goMJdDWP81drLAiEOejjCSME7
 2T/YeU1ulertSVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92E681377F;
 Mon, 21 Nov 2022 09:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2d4UItpFe2PEbwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 21 Nov 2022 09:33:14 +0000
Date: Mon, 21 Nov 2022 10:33:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <Y3tF2XF1xVlOE3fA@pevik>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz> <Y3ZaOqpTvvBgUTTi@pevik>
 <20221121091438.qpx3u5vpdu5afucg@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221121091438.qpx3u5vpdu5afucg@quack3>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify10: Add support for multiple event
 files
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmFuLCBhbGwsCgo+IE9uIFRodSAxNy0xMS0yMiAxNjo1ODo1MCwgUGV0ciBWb3JlbCB3cm90
ZToKPiA+IEhpIEphbiwgYWxsLAoKPiA+ID4gKyNkZWZpbmUgZm9yZWFjaF9wYXRoKHRjLCBidWYs
IHBuYW1lKSBcCj4gPiA+ICsJZm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9jaGVjaygo
YnVmKSwgKHRjKS0+cG5hbWUjI19mbXQsCVwKPiA+IFVuZm9ydHVuYXRlbHkgd2Ugc3RpbGwgc3Vw
cG9ydCBDOTkgZHVlIG9sZCBjb21waWxlciBvbiBDZW50T1MgNywKPiA+IHRoZXJlZm9yZSBpbnQg
cGl0ZXIgbmVlZHMgdG8gYmUgZGVmaW5lZCBvdXRzaWRlIG9mIGZvciBsb29wLgoKPiBIdW0sIGJ1
dCB2YXJpYWJsZSBkZWNsYXJhdGlvbiBpbiB0aGUgZm9yIGxvb3AgaXMgcGFydCBvZiBDOTkgc3Rh
bmRhcmQgKGFzCj4gdGhlIGVycm9yIG1lc3NhZ2UgYWxzbyBzYXlzKS4gU28gZGlkIHlvdSB3YW50
IHRvIHNheSB5b3UgYXJlIGNvbXBpbGluZwo+IGFnYWluc3QgQzg5IHN0YW5kYXJkPyBBbmQgQ2Vu
dE9TIDcgc2hpcHMgd2l0aCBHQ0MgNC44LjUgQUZBSUNTIHdoaWNoIHNob3VsZAo+IGJlIGZ1bGx5
IEM5OSBjb21wbGlhbnQgQlRXLiBTbyB3aGF0J3MgdGhlIHNpdHVhdGlvbiBoZXJlPwpJJ20gc29y
cnksIEkgZGlkbid0IGV4cHJlc3MgY2xlYXJseSBteXNlbGYuIFllcywgNC44LjUgc3VwcG9ydHMg
Qzk5LApidXQgdGhlIGRlZmF1bHQgaXMgQzkwIFsxXS4KCj4gVGhhdCBiZWluZyBzYWlkIEkgY2Fu
IHdvcmthcm91bmQgdGhlIHByb2JsZW0gaW4gdGhlIG1hY3JvLCBpdCB3aWxsIGp1c3QgYmUKPiBz
b21ld2hhdCB1Z2xpZXIuIFNvIGJlZm9yZSBkb2luZyB0aGF0IEknZCBsaWtlIHRvIHVuZGVyc3Rh
bmQgd2hldGhlcgo+IGZvbGxvd2luZyBDODkgaXMgcmVhbGx5IHJlcXVpcmVkLi4uCgpJJ20gZG9u
J3QgcmVtZW1iZXIgd2h5IHdlIGhhdmUganVzdCBub3Qgc3BlY2lmaWVkIC1zdGQ9Li4uIGFscmVh
ZHksIEN5cmlsIGhhZApzb21lIG9iamVjdGlvbnMsIHRodXMgQ2MgaGltLgoKQ2VudDBTIEVPTCBp
biAyMDI0LTA2LCB3ZSBtaWdodCByZWNvbnNpZGVyIHRvIGFkZCAtc3RkPS4uLiB0byBlbmR1cCB0
aGlzIGFnb255CihlcnJvcnMgbGlrZSB0aGlzIG9mdGVuIG5lZWQgdG8gYmUgZml4ZWQpLgoKWzFd
IGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MtNC44LjUvZ2NjL1N0YW5kYXJkcy5o
dG1sCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gCQkJCQkJCQlIb256YQoKPiA+IGZhbm90aWZ5MTAu
Yzo0NzA6MjogZXJyb3I6IOKAmGZvcuKAmSBsb29wIGluaXRpYWwgZGVjbGFyYXRpb25zIGFyZSBv
bmx5IGFsbG93ZWQgaW4gQzk5IG1vZGUKPiA+ICAgZm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRf
cGF0aF9jaGVjaygoYnVmKSwgKHRjKS0+cG5hbWUjI19mbXQsIFwKPiA+ICAgXgoKPiA+IGZhbm90
aWZ5MTAuYzo0NzA6MTE6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYcGl0ZXLigJkKPiA+ICAg
Zm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9jaGVjaygoYnVmKSwgKHRjKS0+cG5hbWUj
I19mbXQsIFwKPiA+ICAgICAgICAgICAgXgo+ID4gS2luZCByZWdhcmRzLAo+ID4gUGV0cgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
