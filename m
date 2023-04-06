Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2740BC76196
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 11:13:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A35DE3CC75C
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 13:13:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E85503CA360
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 13:13:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC6AB200BB7
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 13:13:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 441931FD76;
 Thu,  6 Apr 2023 11:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680779583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nFAzawVtyzXTMtqeqltMwlzXXtA1uHBbO9QMYEYzzw=;
 b=YN2/7na+D2i0GhMNiKglcFxTJ8AWAFXNFtThToYGwJTkCMwSpiFLqtfffBS7YLsPXG0PUJ
 YK3T1c7yAGGkTsGU9znd6BC87s9KGUIJd1dgyQJtbpmGSFc7G0C9MT69kMtbAcU4R/TUCd
 9yAicSIskdq/LZF/Kc4dBuIJhj1oqNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680779583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nFAzawVtyzXTMtqeqltMwlzXXtA1uHBbO9QMYEYzzw=;
 b=/HOvTneU6pKyyRs0/vSUuQxcORYICRV9ud4dmhmK7HJXwKQf0s5XYfsEVnTYtyi+t/MPmr
 +/3JVnXKoUvOYqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00094133E5;
 Thu,  6 Apr 2023 11:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T8BZOT6pLmQuPgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Apr 2023 11:13:02 +0000
Date: Thu, 6 Apr 2023 13:13:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230406111301.GC1545779@pevik>
References: <20230404112852.1271969-1-pvorel@suse.cz>
 <CAEemH2fNLRxhj7NxRvxOr-XYe+gbXiEsYiKosm855_z+jdO5hA@mail.gmail.com>
 <20230406094853.GA1545779@pevik>
 <CAEemH2db7gN9GduVYwfeLM1Px9rp_WTV6uXm1O+urVLXWrMbfA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2db7gN9GduVYwfeLM1Px9rp_WTV6uXm1O+urVLXWrMbfA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mmap20: Fix invalid address
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
Cc: Paulson Raja L <paulson@zilogic.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiBPbiBUaHUsIEFwciA2LCAyMDIzIGF0IDU6NDnigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgYWxsLAoKPiA+ID4gSGkgUGV0ciwKCj4gPiA+
ICgxPDw5KSBpcyBhbHNvIHVzZWQgYnkgYW5vdGhlciBmbGFnIG9uIGFscGhhLCBidXQgaXQgc2Fp
ZCBub3QKPiA+ID4gbGludXgtc3BlY2lmaWMsCj4gPiA+IHNvIEkgZ3Vlc3MgaXQgd29uJ3QgYmUg
YSBwcm9ibGVtIChhdCBsZWFzdCBmb3Igbm93KS4KPiA+ID4gICBhbHBoYS9pbmNsdWRlL3VhcGkv
YXNtL21tYW4uaDojZGVmaW5lIF9NQVBfSEFTU0VNQVBIT1JFIDB4MDIwMAoKPiA+IEdvb2QgcG9p
bnQhIEkgY2hlY2tlZCBvbmx5IGdsaWJjL211c2wgaGVhZGVycywgb2J2aW91c2x5IGNoZWNraW5n
IGtlcm5lbAo+ID4gc291cmNlcwo+ID4gaXMgYmV0dGVyIGFzIGl0IGNvbnRhaW5zIG9sZCBhcmNo
cy4gSXQgYWZmZWN0cyBhbHBoYSwgaWE2NCBhbmQgc3BhcmMKPiA+ICh3ZWxsLCB0aGV5IG1pZ2h0
IG5vdCBldmVuIGNvbXBpbGUgY3VycmVudCBMVFAsIHdlIHdlcmUgZHJvcHBpbmcgaWE2NCBmaXhl
cwo+ID4gYW55d2F5KS4KCgo+IE9rYXksIEkgb25seSBub3RpY2VkIHRoYXQgYWxwaGEgaXMgbm90
IGRlZmluZWQgMHgwMjAwIGZvciBMaW51eAo+IHNwZWNpZmljYWxseS4KCj4gPiAkIGdpdCBncmVw
IC13IDB4MDIwMCBhcmNoLyovaW5jbHVkZS91YXBpL2FzbS9tbWFuLmgKPiA+IGFyY2gvYWxwaGEv
aW5jbHVkZS91YXBpL2FzbS9tbWFuLmg6I2RlZmluZSBfTUFQX0hBU1NFTUFQSE9SRSAweDAyMDAK
PiA+IGFyY2gvaWE2NC9pbmNsdWRlL3VhcGkvYXNtL21tYW4uaDojZGVmaW5lIE1BUF9HUk9XU1VQ
ICAgMHgwMjAwICAgICAgICAgIC8qCj4gPiByZWdpc3RlciBzdGFjay1saWtlIHNlZ21lbnQgKi8K
PiA+IGFyY2gvc3BhcmMvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmg6I2RlZmluZSBNQVBfR1JPV1NE
T1dOICAgICAgICAweDAyMDAKPiA+ICAgICAgIC8qIHN0YWNrLWxpa2Ugc2VnbWVudCAqLwoKPiA+
IEJ1dCBhcyAweDQwMCAoMSA8PCAxMCkgaXMgbm90IHVzZWQgYW55d2hlcmUsIEkgbWVyZ2VkIGl0
IHdpdGggdGhpcyB2YWx1ZS4KCgoKPiBIbW0sIEkgZGlkbid0IHVuZGVyc3RhbmQgaGVyZSB3aHkg
bWVyZ2VkIHdpdGggMHgwNDAwLAo+IGFyZW4ndCB0aGVyZSBzdGlsbCBkdXBsaWNhdGVkIGZsYWdz
PwoKPiAkIGdpdCBncmVwIC13IDB4MDQwMCBhcmNoLyovaW5jbHVkZS91YXBpL2FzbS9tbWFuLmgK
PiBhcmNoL2FscGhhL2luY2x1ZGUvdWFwaS9hc20vbW1hbi5oOiNkZWZpbmUgX01BUF9JTkhFUklU
IDB4MDQwMAo+IGFyY2gvbWlwcy9pbmNsdWRlL3VhcGkvYXNtL21tYW4uaDojZGVmaW5lIE1BUF9O
T1JFU0VSVkUgMHgwNDAwICAgICAgICAgIC8qCj4gZG9uJ3QgY2hlY2sgZm9yIHJlc2VydmF0aW9u
cyAqLwo+IGFyY2gveHRlbnNhL2luY2x1ZGUvdWFwaS9hc20vbW1hbi5oOiNkZWZpbmUgTUFQX05P
UkVTRVJWRSAgICAgICAweDA0MDAKPiAgICAgIC8qIGRvbid0IGNoZWNrIGZvciByZXNlcnZhdGlv
bnMgKi8KCkknbSBzb3JyeSBJIG5vdyBkb24ndCBrbm93IHdoYXQgSSBncmVwZWQsIGJlY2F1c2Ug
dGhlcmUgYXJlIHJlc3VsdHMgZm9yIDB4MDQwMCA6KC4KT2J2aW91c2x5IGxhc3QgbWludXRlIGNo
YW5nZSB3aXRob3V0IGFjayBpcyBhIGJhZCBwcmFjdGlzZS4KCllvdSdyZSByaWdodCwgbGludXgg
c3BlY2lmaWMgMHgwNDAwIGlzIGluIG1pcHMgYW5kIHh0ZW5zYSAoaXQncyBub24tbGludXgKc3Bl
Y2lmaWMgb24gYWxwaGEpLiBPVE9IIGlhNjQgYW5kIHNwYXJjIGRlZmluZToKCmFyY2gvaWE2NC9p
bmNsdWRlL3VhcGkvYXNtL21tYW4uaAojZGVmaW5lIE1BUF9HUk9XU1VQCTB4MDIwMAkJLyogcmVn
aXN0ZXIgc3RhY2stbGlrZSBzZWdtZW50ICovCgphcmNoL3NwYXJjL2luY2x1ZGUvdWFwaS9hc20v
bW1hbi5oCiNkZWZpbmUgTUFQX0dST1dTRE9XTgkweDAyMDAJCS8qIHN0YWNrLWxpa2Ugc2VnbWVu
dCAqLwoKQXJlIHRoZXNlIHVzZWQgYXMgZmxhZ3M/IElmIHllcyBub25lIG9mIHRoZSB2YWx1ZXMg
aXMgb3B0aW1hbCBhcyBpdCBicmVha3Mgc29tZQphcmNoLiBJZiB5b3UgYWdyZWUsIEknZCBrZWVw
IDB4MDQwMCBhbmQgZm9sbG93IEphbidzIHN1Z2dlc3Rpb24gKGRvbid0IG1hcCBhCmZpbGUsIGFu
ZCB0aGVuIGFkZCBNQVBfU1lOQyB0byBmbGFncykuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
