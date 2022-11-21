Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E8BC433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 09:14:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FA6B3CCBAF
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 10:14:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63F3C3C0F12
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 10:14:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 267057AFD71
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 10:14:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F8E01F86C;
 Mon, 21 Nov 2022 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669022079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZJQYpENwQh1J//HldGOrFeLMgIKVoP64qZRx3wsUIs=;
 b=psP50Rp7mzttzox2qqEFqewP51mqo5yfKzBunJaCcEXDryBG8RAMaOyILP8r/jjFRR39hO
 rGkK3UK07mVM7VljB8jwi59r7opcOAfLt1QI97jBy1UqSFs/KmGhBv8wh/pBf19+xCiZiE
 MIXAzNE7KTcg3r+idVmR8EUnwZTfqYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669022079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZJQYpENwQh1J//HldGOrFeLMgIKVoP64qZRx3wsUIs=;
 b=cMdgv+SLOz4z1BZDG32I8rTxCaO0MD4yOMshWS1rtwOo2A3A3A7MgWGu8P5O6ruJUsnSy4
 ZYl/+lxrMTb/O5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20AD11377F;
 Mon, 21 Nov 2022 09:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EhfuB39Be2OXZAAAMHmgww
 (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 09:14:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 917A5A070A; Mon, 21 Nov 2022 10:14:38 +0100 (CET)
Date: Mon, 21 Nov 2022 10:14:38 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20221121091438.qpx3u5vpdu5afucg@quack3>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz> <Y3ZaOqpTvvBgUTTi@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3ZaOqpTvvBgUTTi@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: Jan Kara <jack@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1IDE3LTExLTIyIDE2OjU4OjUwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIEphbiwgYWxs
LAo+IAo+ID4gKyNkZWZpbmUgZm9yZWFjaF9wYXRoKHRjLCBidWYsIHBuYW1lKSBcCj4gPiArCWZv
ciAoaW50IHBpdGVyID0gMDsgZm9ybWF0X3BhdGhfY2hlY2soKGJ1ZiksICh0YyktPnBuYW1lIyNf
Zm10LAlcCj4gVW5mb3J0dW5hdGVseSB3ZSBzdGlsbCBzdXBwb3J0IEM5OSBkdWUgb2xkIGNvbXBp
bGVyIG9uIENlbnRPUyA3LAo+IHRoZXJlZm9yZSBpbnQgcGl0ZXIgbmVlZHMgdG8gYmUgZGVmaW5l
ZCBvdXRzaWRlIG9mIGZvciBsb29wLgoKSHVtLCBidXQgdmFyaWFibGUgZGVjbGFyYXRpb24gaW4g
dGhlIGZvciBsb29wIGlzIHBhcnQgb2YgQzk5IHN0YW5kYXJkIChhcwp0aGUgZXJyb3IgbWVzc2Fn
ZSBhbHNvIHNheXMpLiBTbyBkaWQgeW91IHdhbnQgdG8gc2F5IHlvdSBhcmUgY29tcGlsaW5nCmFn
YWluc3QgQzg5IHN0YW5kYXJkPyBBbmQgQ2VudE9TIDcgc2hpcHMgd2l0aCBHQ0MgNC44LjUgQUZB
SUNTIHdoaWNoIHNob3VsZApiZSBmdWxseSBDOTkgY29tcGxpYW50IEJUVy4gU28gd2hhdCdzIHRo
ZSBzaXR1YXRpb24gaGVyZT8KClRoYXQgYmVpbmcgc2FpZCBJIGNhbiB3b3JrYXJvdW5kIHRoZSBw
cm9ibGVtIGluIHRoZSBtYWNybywgaXQgd2lsbCBqdXN0IGJlCnNvbWV3aGF0IHVnbGllci4gU28g
YmVmb3JlIGRvaW5nIHRoYXQgSSdkIGxpa2UgdG8gdW5kZXJzdGFuZCB3aGV0aGVyCmZvbGxvd2lu
ZyBDODkgaXMgcmVhbGx5IHJlcXVpcmVkLi4uCgoJCQkJCQkJCUhvbnphCgo+IGZhbm90aWZ5MTAu
Yzo0NzA6MjogZXJyb3I6IOKAmGZvcuKAmSBsb29wIGluaXRpYWwgZGVjbGFyYXRpb25zIGFyZSBv
bmx5IGFsbG93ZWQgaW4gQzk5IG1vZGUKPiAgIGZvciAoaW50IHBpdGVyID0gMDsgZm9ybWF0X3Bh
dGhfY2hlY2soKGJ1ZiksICh0YyktPnBuYW1lIyNfZm10LCBcCj4gICBeCj4gCj4gZmFub3RpZnkx
MC5jOjQ3MDoxMTogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhwaXRlcuKAmQo+ICAgZm9yIChp
bnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9jaGVjaygoYnVmKSwgKHRjKS0+cG5hbWUjI19mbXQs
IFwKPiAgICAgICAgICAgIF4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgotLSAKSmFuIEthcmEgPGph
Y2tAc3VzZS5jb20+ClNVU0UgTGFicywgQ1IKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
