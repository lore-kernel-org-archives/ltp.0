Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1D3C77B6C
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 08:02:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F27833CC4D7
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 10:02:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3141C3C6C4B
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 10:02:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D266200984
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 10:02:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DFE52189B;
 Thu, 13 Apr 2023 08:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681372931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIAEx6gEKhsC3MAU0VU7QCvjEUve/f4LyPd1r+mHFvA=;
 b=dUKBJrKI8hxEV9pJD7EuHAP7ldWtMVqeHN4d2uVMdIZhNHkpKawwLso/zbOZBZ0TBu/8Xs
 zLLxjA7/+K4p2rwxtgb6dLckU8kfKs6EcKoff6zdPttJmgqzqV9R3ByOSi0PjFn1K5/RtW
 CsQJ+lnAnNjj/ACQ5hm96oTgRpyLkdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681372931;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIAEx6gEKhsC3MAU0VU7QCvjEUve/f4LyPd1r+mHFvA=;
 b=pF7bL1YNQFaGYEeCmQeORmFFRZhvSvCq9VYsDL2TOYeRU1jbr6dJUpCRg0ZxWxjIJWr1GM
 7RKFkEAh6+RCZJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 614981390E;
 Thu, 13 Apr 2023 08:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xqG5FgO3N2QNCAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Apr 2023 08:02:11 +0000
Date: Thu, 13 Apr 2023 10:02:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230413080210.GB2072620@pevik>
References: <20230412073953.1983857-1-pvorel@suse.cz>
 <CAEemH2eGHMkUCZXJRmPBXM=qqVFA37eyEecNb8cn6j_F3dSO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eGHMkUCZXJRmPBXM=qqVFA37eyEecNb8cn6j_F3dSO2g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Remove possible double/trailing
 slashes from TMPDIR
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

PiBPbiBXZWQsIEFwciAxMiwgMjAyMyBhdCAzOjQw4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IE5GUyB0ZXN0cyBoYXZlIHByb2JsZW0gd2hlbiBUTVBESVIgcGF0
aCBjb250YWlucyBkb3VibGUgc2xhc2hlcywKPiA+IGJlY2F1c2UgdGhleSBncmVwIGV4cG9ydGZz
IG91dHB1dCB3aGljaCBpcyBub3JtYWxpemVkLgoKCj4gSSdtIG9rIHRvIHJlbW92ZSByZWR1bmRh
bnQgc2xhc2hlcywgSSBqdXN0IHdvbmRlcmluZyB3aGVyZQo+IGlzIHRoZSBzZWNvbmQgc2xhc2gg
Y29tZXMgZnJvbT8KPiBJcyB0aGF0IGFkZGVkIGJ5IGFjY2lkZW50IHdoZW4gZW52IHZhcmlhYmxl
IGRlZmluaXRpb24/CgpZZXMsIHRoYXQncyB0aGUgbGFzdCBzbGFzaCBpbiBUTVBESVI9L3Zhci90
bXAvLgpUTVBESVI9L3Zhci90bXAgd291bGQgd29yay4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiA+
IFByb2JsZW0gaXMgZWl0aGVyIHRyYWlsaW5nIHNsYXNoOgoKPiA+ICQgVE1QRElSPS92YXIvdG1w
LyBuZnMwMS5zaCAtdCB0Y3AKPiA+IC4uLgo+ID4gbmZzMDEgMSBUSU5GTzogTW91bnRpbmcgTkZT
OiBtb3VudCAtdiAtdCBuZnMgLW8gcHJvdG89dGNwLHZlcnM9MyAxMC4wLjAuMjovdmFyL3RtcC8v
TFRQX25mczAxLnNJcW00TExTNHUvMy90Y3AKPiA+IC92YXIvdG1wLy9MVFBfbmZzMDEuc0lxbTRM
TFM0dS8zLzAKPiA+IG5mczAxIDEgVElORk86IHN0YXJ0aW5nICduZnMwMV9vcGVuX2ZpbGVzIDEw
MDAnCj4gPiBuZnMwMSAxIFRQQVNTOiB0ZXN0IGZpbmlzaGVkIHN1Y2Nlc3NmdWxseQo+ID4gbmZz
MDEgMiBUSU5GTzogQ2xlYW5pbmcgdXAgdGVzdGNhc2UKPiA+IG5mczAxIDIgVElORk86IHJlbW90
ZV9kaXI6ICcvdmFyL3RtcC8vTFRQX25mczAxLnNJcW00TExTNHUvMy90Y3AnCj4gPiBleHBvcnRm
czogQ291bGQgbm90IGZpbmQgJyo6L3Zhci90bXAvL0xUUF9uZnMwMS5zSXFtNExMUzR1LzMvdGNw
JyB0bwo+ID4gdW5leHBvcnQuCj4gPiBybTogY2Fubm90IHJlbW92ZSAnL3Zhci90bXAvL0xUUF9u
ZnMwMS5zSXFtNExMUzR1LzMvMCc6IERldmljZSBvciByZXNvdXJjZQo+ID4gYnVzeQo+ID4gcm06
IGNhbm5vdCByZW1vdmUgJy92YXIvdG1wLy9MVFBfbmZzMDEuc0lxbTRMTFM0dS8zLzAnOiBJcyBh
IGRpcmVjdG9yeQoKPiA+IG9yIGRvdWJsZSAob3IgbW9yZSkgc2xhc2hlcyAoYW55d2hlcmUgaW4g
JFRNUERJUik6Cgo+ID4gJCBUTVBESVI9L3Zhci8vdG1wIG5mczAxLnNoIC10IHRjcAo+ID4gbmZz
MDEgMSBUSU5GTzogTW91bnRpbmcgTkZTOiBtb3VudCAtdiAtdCBuZnMgLW8gcHJvdG89dGNwLHZl
cnM9MyAxMC4wLjAuMjovdmFyLy90bXAvTFRQX25mczAxLnFOalNzb3BWYlkvMy90Y3AKPiA+IC92
YXIvL3RtcC9MVFBfbmZzMDEucU5qU3NvcFZiWS8zLzAKPiA+IG5mczAxIDEgVElORk86IHN0YXJ0
aW5nICduZnMwMV9vcGVuX2ZpbGVzIDEwMDAnCj4gPiBuZnMwMSAxIFRQQVNTOiB0ZXN0IGZpbmlz
aGVkIHN1Y2Nlc3NmdWxseQo+ID4gbmZzMDEgMiBUSU5GTzogQ2xlYW5pbmcgdXAgdGVzdGNhc2UK
PiA+IG5mczAxIDIgVElORk86IHJlbW90ZV9kaXI6ICcvdmFyLy90bXAvTFRQX25mczAxLnFOalNz
b3BWYlkvMy90Y3AnCj4gPiBleHBvcnRmczogQ291bGQgbm90IGZpbmQgJyo6L3Zhci8vdG1wL0xU
UF9uZnMwMS5xTmpTc29wVmJZLzMvdGNwJyB0bwo+ID4gdW5leHBvcnQuCj4gPiBybTogY2Fubm90
IHJlbW92ZSAnL3Zhci8vdG1wL0xUUF9uZnMwMS5xTmpTc29wVmJZLzMvMCc6IERldmljZSBvciBy
ZXNvdXJjZQo+ID4gYnVzeQo+ID4gcm06IGNhbm5vdCByZW1vdmUgJy92YXIvL3RtcC9MVFBfbmZz
MDEucU5qU3NvcFZiWS8zLzAnOiBJcyBhIGRpcmVjdG9yeQoKPiA+IFdoaWxlIHRoaXMgY291bGQg
YmUgaGFuZGxlZCBpbiBuZnNfbGliLnNoLCBpdCdzIGJldHRlciB0byBzYXZlIGl0IGZvcgo+ID4g
YWxsIHRlc3RzLiBJdCdzIGVhc2llciB0byBtb2RpZnkgJFRTVF9UTVBESVIsIGJlY2F1c2UgdGhl
IHByb2JsZW0KPiA+IG5hcnJvd3MgZG93biB0byBkb3VibGUgc2xhc2guCgo+ID4gU2lnbmVkLW9m
Zi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMv
bGliL3RzdF90ZXN0LnNoIHwgMiArKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykKCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5zaCBiL3Rlc3RjYXNl
cy9saWIvdHN0X3Rlc3Quc2gKPiA+IGluZGV4IGM4MTdlZWM3Ny4uNDJmNjBhYjU4IDEwMDY0NAo+
ID4gLS0tIGEvdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5zaAo+ID4gKysrIGIvdGVzdGNhc2VzL2xp
Yi90c3RfdGVzdC5zaAo+ID4gQEAgLTcyMiw2ICs3MjIsOCBAQCB0c3RfcnVuKCkKPiA+ICAgICAg
ICAgICAgICAgICBmaQoKPiA+ICAgICAgICAgICAgICAgICBUU1RfVE1QRElSPSQobWt0ZW1wIC1k
ICIkVE1QRElSL0xUUF8kVFNUX0lELlhYWFhYWFhYWFgiKQo+ID4gKyAgICAgICAgICAgICAgICMg
cmVtb3ZlIHBvc3NpYmxlIHRyYWlsaW5nIHNsYXNoIG9yIGRvdWJsZSBzbGFzaGVzIGZyb20KPiA+
IFRNUERJUgo+ID4gKyAgICAgICAgICAgICAgIFRTVF9UTVBESVI9JChlY2hvICIkVFNUX1RNUERJ
UiIgfCBzZWQgJ3N+L1wrfi9+ZycpCgo+ID4gICAgICAgICAgICAgICAgIGNobW9kIDc3NyAiJFRT
VF9UTVBESVIiCgo+ID4gLS0KPiA+IDIuNDAuMAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
