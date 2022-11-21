Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C7AC4332F
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 14:40:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E9A63CCBC7
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 15:40:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0E103CCB9B
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 15:40:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 039442538AB
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 15:40:42 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 48FC91F85D;
 Mon, 21 Nov 2022 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669041642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNl1/4RPN8M35Jwthd+na+jnfvnsl6H3pvTw338B7Bk=;
 b=hMRfXiGEZj11KxCq0VrEYxjToAkZSaivTjLeRSNyL72ZC0BIKy2ca+KhqrogLDe6ALsHQe
 Y9IJlYqFWY7lxN6xrpGixgPgmid97Z+DWooBpy1WwrgS94o+ev7FxjZHaKztkQElNjzU32
 CvOhqiz4uNOHDlVMMuY3Tp1gHJOHxAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669041642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNl1/4RPN8M35Jwthd+na+jnfvnsl6H3pvTw338B7Bk=;
 b=d62vbg7dii95+QYxb4WrK1aP3WlgjuH8RzVMo23w5GfUnjSIB5lJkOldo38/ViT1gLCjic
 VkAb8yl/tggJrHBg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 020AA2C143;
 Mon, 21 Nov 2022 14:40:41 +0000 (UTC)
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz> <Y3ZaOqpTvvBgUTTi@pevik>
 <20221121091438.qpx3u5vpdu5afucg@quack3> <Y3tF2XF1xVlOE3fA@pevik>
 <20221121095345.2m7aze7xtlmxb4hy@quack3>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Jan Kara <jack@suse.cz>
Date: Mon, 21 Nov 2022 14:24:30 +0000
Organization: Linux Private Site
In-reply-to: <20221121095345.2m7aze7xtlmxb4hy@quack3>
Message-ID: <87r0xwfk0m.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpKYW4gS2FyYSA8amFja0BzdXNlLmN6PiB3cml0ZXM6Cgo+IE9uIE1vbiAyMS0xMS0y
MiAxMDozMzoxMywgUGV0ciBWb3JlbCB3cm90ZToKPj4gSGkgSmFuLCBhbGwsCj4+IAo+PiA+IE9u
IFRodSAxNy0xMS0yMiAxNjo1ODo1MCwgUGV0ciBWb3JlbCB3cm90ZToKPj4gPiA+IEhpIEphbiwg
YWxsLAo+PiAKPj4gPiA+ID4gKyNkZWZpbmUgZm9yZWFjaF9wYXRoKHRjLCBidWYsIHBuYW1lKSBc
Cj4+ID4gPiA+ICsJZm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9jaGVjaygoYnVmKSwg
KHRjKS0+cG5hbWUjI19mbXQsCVwKPj4gPiA+IFVuZm9ydHVuYXRlbHkgd2Ugc3RpbGwgc3VwcG9y
dCBDOTkgZHVlIG9sZCBjb21waWxlciBvbiBDZW50T1MgNywKPj4gPiA+IHRoZXJlZm9yZSBpbnQg
cGl0ZXIgbmVlZHMgdG8gYmUgZGVmaW5lZCBvdXRzaWRlIG9mIGZvciBsb29wLgo+PiAKPj4gPiBI
dW0sIGJ1dCB2YXJpYWJsZSBkZWNsYXJhdGlvbiBpbiB0aGUgZm9yIGxvb3AgaXMgcGFydCBvZiBD
OTkgc3RhbmRhcmQgKGFzCj4+ID4gdGhlIGVycm9yIG1lc3NhZ2UgYWxzbyBzYXlzKS4gU28gZGlk
IHlvdSB3YW50IHRvIHNheSB5b3UgYXJlIGNvbXBpbGluZwo+PiA+IGFnYWluc3QgQzg5IHN0YW5k
YXJkPyBBbmQgQ2VudE9TIDcgc2hpcHMgd2l0aCBHQ0MgNC44LjUgQUZBSUNTIHdoaWNoIHNob3Vs
ZAo+PiA+IGJlIGZ1bGx5IEM5OSBjb21wbGlhbnQgQlRXLiBTbyB3aGF0J3MgdGhlIHNpdHVhdGlv
biBoZXJlPwo+PiBJJ20gc29ycnksIEkgZGlkbid0IGV4cHJlc3MgY2xlYXJseSBteXNlbGYuIFll
cywgNC44LjUgc3VwcG9ydHMgQzk5LAo+PiBidXQgdGhlIGRlZmF1bHQgaXMgQzkwIFsxXS4KPgo+
IE9LLCB0aGFua3MgZm9yIGV4cGxhbmF0aW9uLgo+Cj4+ID4gVGhhdCBiZWluZyBzYWlkIEkgY2Fu
IHdvcmthcm91bmQgdGhlIHByb2JsZW0gaW4gdGhlIG1hY3JvLCBpdCB3aWxsIGp1c3QgYmUKPj4g
PiBzb21ld2hhdCB1Z2xpZXIuIFNvIGJlZm9yZSBkb2luZyB0aGF0IEknZCBsaWtlIHRvIHVuZGVy
c3RhbmQgd2hldGhlcgo+PiA+IGZvbGxvd2luZyBDODkgaXMgcmVhbGx5IHJlcXVpcmVkLi4uCj4+
IAo+PiBJJ20gZG9uJ3QgcmVtZW1iZXIgd2h5IHdlIGhhdmUganVzdCBub3Qgc3BlY2lmaWVkIC1z
dGQ9Li4uIGFscmVhZHksIEN5cmlsIGhhZAo+PiBzb21lIG9iamVjdGlvbnMsIHRodXMgQ2MgaGlt
Lgo+PiAKPj4gQ2VudDBTIEVPTCBpbiAyMDI0LTA2LCB3ZSBtaWdodCByZWNvbnNpZGVyIHRvIGFk
ZCAtc3RkPS4uLiB0byBlbmR1cCB0aGlzIGFnb255Cj4+IChlcnJvcnMgbGlrZSB0aGlzIG9mdGVu
IG5lZWQgdG8gYmUgZml4ZWQpLgo+PiAKPj4gWzFdIGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5l
ZG9jcy9nY2MtNC44LjUvZ2NjL1N0YW5kYXJkcy5odG1sCj4KPiBHaXZlbiBDeXJpbCdzIHJlcGx5
LCBzaG91bGQgSSByZXdvcmsgbXkgcGF0Y2ggb3IgYXJlIHdlIGZpbmUgd2l0aCB1c2luZwo+IEM5
OT8KCldlbGwgLXN0ZD1jOTkgZG9lc24ndCB3b3JrLCBidXQgd2UgY2FuIHVzZSAtc3RkPWdudTk5
LiBJZiB0aGF0IGRvZXNuJ3QKZml4IGl0IHRoZW4gd2Ugc2hvdWxkIGRyb3AgY2VudG9zMDcgbm93
IElNTy4KCj4KPiAJCQkJCQkJCUhvbnphCj4KPj4gPiA+IGZhbm90aWZ5MTAuYzo0NzA6MjogZXJy
b3I6IOKAmGZvcuKAmSBsb29wIGluaXRpYWwgZGVjbGFyYXRpb25zIGFyZSBvbmx5IGFsbG93ZWQg
aW4gQzk5IG1vZGUKPj4gPiA+ICAgZm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9jaGVj
aygoYnVmKSwgKHRjKS0+cG5hbWUjI19mbXQsIFwKPj4gPiA+ICAgXgo+PiAKPj4gPiA+IGZhbm90
aWZ5MTAuYzo0NzA6MTE6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYcGl0ZXLigJkKPj4gPiA+
ICAgZm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9jaGVjaygoYnVmKSwgKHRjKS0+cG5h
bWUjI19mbXQsIFwKPj4gPiA+ICAgICAgICAgICAgXgo+PiA+ID4gS2luZCByZWdhcmRzLAo+PiA+
ID4gUGV0cgoKCi0tIApUaGFuayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
