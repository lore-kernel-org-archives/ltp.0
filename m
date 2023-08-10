Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60697C001B0
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 17:59:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 313F93CD09C
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 19:59:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8E643C88E2
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 19:59:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7227600A36
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 19:59:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A40421845;
 Thu, 10 Aug 2023 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691690357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qV7OdASfAB+5tosh3k2ds2ilQaEeS5aAa2P4oOQNnxQ=;
 b=k/NWICjGlG3d3o/gqhvt6nQOxc7HXrfFAOw9FP1WM+AV8UTk7PoiJ/HEbdPvXpgeD9thC/
 2SU4Iugm5dTn8DSn8CB43ijDFSFetpRRkGlAbFAUFlAuELhT1pHiXuuFw7J5rn1i4pA1UI
 oM+a876hKxcQK3nGr4XPvsUcXi2fHiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691690357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qV7OdASfAB+5tosh3k2ds2ilQaEeS5aAa2P4oOQNnxQ=;
 b=WZ+JnW3yq1lthLnPb/JtQUQfxsmPoMj7q2/k3TRQZw7nqQHMAkxXavDoJrqwu+WlRLbjEf
 tARs9MbHpBkusUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76DE1138E2;
 Thu, 10 Aug 2023 17:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Aa35HHUl1WSSXQAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 17:59:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id B130DA076F; Thu, 10 Aug 2023 19:59:16 +0200 (CEST)
Date: Thu, 10 Aug 2023 19:59:16 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230810175916.ac3on2lwlfszs673@quack3>
References: <20230810131012.13026-1-jack@suse.cz>
 <CAOQ4uxiY3Qajthb_kVhzGbuzqzJvUWXdF4HRW=YtaojQ1Ys3DA@mail.gmail.com>
 <20230810142524.xmrf4xfplxe7hv2e@quack3>
 <CAOQ4uxh85sm8nv6_Q2tH95Uwx2G8aZ0nhLPLhOMYeOC=mjbKqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh85sm8nv6_Q2tH95Uwx2G8aZ0nhLPLhOMYeOC=mjbKqQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify23: Make evictable marks tests more
 reliable
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it, petr.vorel@suse.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1IDEwLTA4LTIzIDE3OjM4OjE1LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBUaHUs
IEF1ZyAxMCwgMjAyMyBhdCA1OjI14oCvUE0gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JvdGU6
Cj4gPiA+IE1lYW5pbmcgdGhhdCB0aGUgZXhwbGFuYXRpb24gaXMgdHJ1ZSBiZWNhdXNlIGZhbm90
aWZ5MTAgaGFzOgo+ID4gPgo+ID4gPiAgICAgICAgIC8qIFNocmlua2VycyBvbiBvdGhlciBmcyBk
byBub3Qgd29yayByZWxpYWJseSBlbm91Z2ggdG8KPiA+ID4gZ3VhcmFudGVlIG1hcmsgZXZpY3Rp
b24gb24gZHJvcF9jYWNoZXMgKi8KPiA+ID4gICAgICAgICAuZGV2X2ZzX3R5cGUgPSAiZXh0MiIs
Cj4gPiA+Cj4gPiA+IE1heWJlIHRoYXQgc2hvdWxkIGJlIHNwZWxsZWQgb3V0Pwo+ID4KPiA+IEkg
Z3Vlc3MgeW91IHNwZWFrIGFib3V0IGZhbm90aWZ5MjMgbm93IGJ1dCB5ZXMsIHRoaXMgcGF0Y2gg
ZGVwZW5kcyBvbiB0aGUKPiA+IGZhY3QgdGhhdCB3ZSBhcmUgbGltaXRlZCB0byBleHQyLiBQZXJo
YXBzIEkgY2FuIGFkZCB0aGF0IHRvIHRoZSBjb21tZW50IGJ1dAo+ID4gaXQgYWxyZWFkeSBpcyBt
ZW50aW9uZWQgaW4gdGhlIHRlc3QgYXMgeW91IHNob3cgYWJvdmUuLi4KPiAKPiBZZXMsIHRoYXQg
aXMgYWxsIEkgbWVhbnQsIHNvIGEgcmVhZGVyIHdvbid0IHNlZSB0aGlzIGV4cGxhbmF0aW9uIGFu
ZAo+IHRyeSB0byBjb3B5IHRoZSBzYW1lIG1pdGlnYXRpb24gdG8gb3RoZXIgdGVzdHMgdGhhdCBk
byBub3QgbGltaXQKPiB0aGVtc2VsdmVzIHRvIGV4dDIsIGJldHRlciBtYWtlIHRoYXQgZmFjdCBj
bGVhciBpbiB0aGUgY29tbWVudC4KCk9LLCBJJ3ZlIGFkZGVkIGEgbm90ZSB0byB0aGUgY29tbWVu
dCB0aGF0IHRoaXMgaXMgc3BlY2lmaWMgdG8gdGhlIGZzIGFuZAp0aGUgdGVzdCBpcyBsaW1pdGVk
IHRvIGV4dDIuIEknbGwgc2VuZCB2MiBzaG9ydGx5LgoKCQkJCQkJCQlIb256YQotLSAKSmFuIEth
cmEgPGphY2tAc3VzZS5jb20+ClNVU0UgTGFicywgQ1IKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
