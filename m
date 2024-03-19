Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC053C54E68
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 19:24:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA8593D00BB
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 20:24:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3C423CE674
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 20:23:55 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 123B7600E5F
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 20:23:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A44A22725;
 Tue, 19 Mar 2024 19:23:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F55F136A5;
 Tue, 19 Mar 2024 19:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id is1jEknm+WVsXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 19 Mar 2024 19:23:53 +0000
Date: Tue, 19 Mar 2024 20:23:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240319192350.GA424358@pevik>
References: <ZfQoVC7xBfGHNsgI@wegao.157.234.177>
 <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
 <ZfezDUSKwUdoSamA@wegao.215.20.80>
 <CAEemH2cLfO9nMnOdB3wTuK6bmkfsPJp_fdQOXSFU-SfHfdQSZA@mail.gmail.com>
 <Zffm+yWYrGhyVTsf@wegao.213.190.243>
 <CAEemH2e4iC1+dViTu4WgNz4-BOTg+f9+9sggy+WKhK+ZsCQmvQ@mail.gmail.com>
 <Zfg2E59Pa1uF84di@wegao.115.61.67>
 <CAEemH2c--aHRW5ZqvBZTP2AVuoiKcY4x6GAxcaMb1KgbXVUEDA@mail.gmail.com>
 <20240319050357.GA417761@pevik>
 <CAEemH2eoeuvZB+=9iG0qJ6_2OSAN9S_7R+hq+i1pXFXmY4j_jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eoeuvZB+=9iG0qJ6_2OSAN9S_7R+hq+i1pXFXmY4j_jQ@mail.gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: 6A44A22725
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

PiBPbiBUdWUsIE1hciAxOSwgMjAyNCBhdCAxOjA04oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+ID4gT24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgODo0MOKAr1BNIFdl
aSBHYW8gPHdlZ2FvQHN1c2UuY29tPiB3cm90ZToKCgoKCj4gPiA+ID4gPiBUaGF0J3MgYmVjYXVz
ZSB0aGUgYXZhaWxhYmxlIHN3YXBmaWxlIG9uIHlvdXIgU1VUIGlzIHRvbyBzbWFsbCwKPiA+ID4g
PiA+IHlvdSBjYW4gYWRqdXN0IGl0ICh0aGVuIHJldGVzdCBpdCkgYnkgeW91cnNlbGYgdG8gZmlu
ZCBhIHByb3BlciBzaXplLgoKPiA+ID4gPiA+IFRoaXMgaXMgZmluZSBhcyBsb25nIGFzIHRoZSBz
d2FwZmlsZSBzaXplIGlzIGxlc3MgdGhhbiAzMDBNQiwKPiA+ID4gPiA+IG90aGVyd2lzZSB3ZSBu
ZWVkIHRvIHNldCAuZGV2X21pbl9zaXplIGxpa2Ugd2hhdCB3ZSBkaWQKPiA+ID4gPiA+IGZvciBz
d2Fwb2ZmMDEuYy4KCj4gPiA+ID4gPiBBbmQsIG9uIHRoZSBvdGhlciBzaWRlLCB3ZSBjYW4ndCBn
dWFyYW50ZWUgdGhlIHN5c3RlbSBTd2FwQ2FjaGVkCj4gPiA+ID4gPiBoYXBwZW5lZCBldmVyeSB0
aW1lLCBpdCBkZXBlbmRzIG9uIHRoZSBzeXN0ZW0ncyBjb25maWd1cmF0aW9uLgoKCj4gPiA+ID4g
MTAwTSBpcyBnb29kIGVub3VnaCBmb3IgY3VycmVudCBzeXN0ZW0sIGNvdWxkIHlvdSBoZWxwIGNo
ZWNrIGZvbGxvd2luZwo+ID4gPiA+IHBhdGNoPwoKCj4gPiA+IENhbiB3ZSByZXdyaXRlIHRoZSBt
YWtlX3N3YXBmaWxlKCkgQVBJIHRvIHN1cHBvcnQgcGFzc2luZyBNQiBzaXplIGZvcgo+ID4gPiBt
YWtpbmcgdGhlIHN3YXBmaWxlPwoKPiA+IEkgZ3Vlc3MgaXQgd291bGQgYmUgZGVzaXJhYmxlIChi
dXQga2VlcCBhbHNvIHBvc3NpYmxlIHRvIHBhc3MgdGhhdCAxMAo+ID4gYmxvY2tzLAo+ID4gdGhl
cmVmb3JlIG1heWJlIHVzZSBmbGFnIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gTUIgYW5kIGJsb2Nr
cz8pLgoKCj4gVGhhdCdzIGZpbmUgYnV0IGEgYml0IGNvbXBsZXggZm9yIHVzZXJzIHRvIGRpc3Rp
bmd1aXNoIGZsYWdzLgoKPiBPciwgd2hhdCBhYm91dCBtYWtpbmcgdGhlIGZ1bmN0aW9uIHVzZSB0
aGUgZmxhZyBhcyBzdGF0aWMsIGFuZAo+IGV4cG9ydCB0d28gYWRkaXRpb25hbCBmdW5jdGlvbnMg
d2l0aCBNQiBhbmQgYmxvY2tzPwoKWWVzLCBJIG1lYW50IHNvbWV0aGluZyBsaWtlIHRoYXQgKDIg
d3JhcHBlcnMgd2hpY2ggd291bGQgcGFzcyB0aGUgZmxhZwp0byB0aGUgM3JkIGZ1bmN0aW9uIHdo
aWNoIGFjdHVhbGx5IGltcGxlbWVudHMgaXQuCgo+IGVudW0gc3dhcGZpbGVfbWV0aG9kIHsKPiAg
ICAgU1dBUEZJTEVfQllfU0laRSwKPiAgICAgU1dBUEZJTEVfQllfQkxPQ0tTCj4gfTsKCj4gc3Rh
dGljIGludCBtYWtlX3N3YXBmaWxlKGNvbnN0IGNoYXIgKnN3YXBmaWxlLCB1bnNpZ25lZCBpbnQg
cGFyYSwgaW50IHNhZmUsCj4gZW51bSBzd2FwZmlsZV9tZXRob2QgbWV0aG9kKSB7Cj4gICAgIC8v
IFRoZSBtYWluIGxvZ2ljIHRvIGFjaGlldmUgdGhlIHN3YXBmaWxlLW1ha2luZyBwcm9jZXNzCj4g
ICAgIC8vIC4uLgo+IH0KCj4gaW50IG1ha2Vfc3dhcGZpbGVfc2l6ZShjb25zdCBjaGFyICpzd2Fw
ZmlsZSwgdW5zaWduZWQgaW50IHNpemUsIGludCBzYWZlKSB7Cj4gICAgIHJldHVybiBtYWtlX3N3
YXBmaWxlKHN3YXBmaWxlLCBzaXplLCBzYWZlLCBTV0FQRklMRV9CWV9TSVpFKTsKPiB9Cgo+IGlu
dCBtYWtlX3N3YXBmaWxlX2Jsa3MoY29uc3QgY2hhciAqc3dhcGZpbGUsIHVuc2lnbmVkIGludCBi
bG9ja3MsIGludCBzYWZlKQo+IHsKPiAgICAgcmV0dXJuIG1ha2Vfc3dhcGZpbGUoc3dhcGZpbGUs
IGJsb2Nrcywgc2FmZSwgU1dBUEZJTEVfQllfQkxPQ0tTKTsKPiB9CgorMQoKS2luZCByZWdhcmRz
LApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
