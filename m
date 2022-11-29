Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE0BC4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 11:06:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9AA43CC5B0
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 12:06:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 585D83C3057
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:06:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BBDD31400178
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:06:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03D6321BCE;
 Tue, 29 Nov 2022 11:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669719994;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLceGHz0oNjnbPcFgn/cpGwcELGQWxSGWiCDmyAd3m8=;
 b=w8g84jISShr3WDaEuGRKPrmA8LFDGfR74SJEgUXatyp1thG1thJ5YAycUhO2LNGwZllW13
 +d5Bwg2V6w4tTA8ZydVfPOJhPtSQqzTAv0hSBue5wiMwrF4u18gBQAfPP2An/Q4ljNBy8T
 lqlOXJ82u6Azr58XKU/xsjkpITJOzjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669719994;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PLceGHz0oNjnbPcFgn/cpGwcELGQWxSGWiCDmyAd3m8=;
 b=e4A785bCyozXox/EftQLMrTXvVAbZBUHLTymaX1ElCCAFK54JCw6XTvcAX4UwgwT10QQ+v
 pqpOXD/LaUFY/qCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF60013AF6;
 Tue, 29 Nov 2022 11:06:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g+mbLLnnhWOCWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 29 Nov 2022 11:06:33 +0000
Date: Tue, 29 Nov 2022 12:06:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Y4Xnt+OsEt94aZRr@pevik>
References: <20221123144746.590890-1-tudor.cretu@arm.com>
 <Y4XmlHZyi2DG9DRT@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4XmlHZyi2DG9DRT@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] safe_macros: Fix undefined behaviour in
 vararg handling
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBUdWRvciwKCj4gPiBBY2Nlc3NpbmcgZWxlbWVudHMgaW4gYW4gZW1wdHkgdmFfbGlzdCBy
ZXN1bHRzIGluIHVuZGVmaW5lZCBiZWhhdmlvdXJbMF0KPiA+IHRoYXQgY2FuIGluY2x1ZGUgYWNj
ZXNzaW5nIGFyYml0cmFyeSBzdGFjayBtZW1vcnkuIFdoaWxlIHR5cGljYWxseSB0aGlzCj4gPiBk
b2Vzbid0IHJhaXNlIGEgZmF1bHQsIHNvbWUgbmV3IG1vcmUgc2VjdXJpdHktb3JpZW50ZWQgYXJj
aGl0ZWN0dXJlcwo+ID4gKGUuZy4gQ0hFUklbMV0gb3IgTW9yZWxsb1syXSkgZG9uJ3QgYWxsb3cg
aXQuCgo+ID4gVGhlcmVmb3JlLCByZW1vdmUgdGhlIHZhcmlhZGljbmVzcyBmcm9tIHNhZmVfKiB3
cmFwcGVycyB0aGF0IGFsd2F5cyBjYWxsCj4gPiB0aGUgZnVuY3Rpb25zIHdpdGggdGhlIG9wdGlv
bmFsIGFyZ3VtZW50IGluY2x1ZGVkLgoKPiA+IEFkYXB0IHRoZSByZXNwZWN0aXZlIFNBRkVfKiBt
YWNyb3MgdG8gaGFuZGxlIHRoZSBjaGFuZ2UgYnkgcGFzc2luZyBhCj4gPiBkZWZhdWx0IGFyZ3Vt
ZW50IGlmIHRoZXkncmUgb21pdHRlZC4KCj4gVGhhbmtzIGZvciBhbiBpbnRlcmVzdGluZyBwYXRj
aHNldCEKCj4gSSB3b25kZXIgaWYgaXQncyBhIGNvcnJlY3QgYXBwcm9hY2ggYXMgQyBBUEkgYWxs
b3dzCj4gaW50IG9wZW4oY29uc3QgY2hhciAqcGF0aG5hbWUsIGludCBmbGFncyk7Cj4gd2Ugd2ls
bCByZXBsYWNlIGl0IAo+IGludCBvcGVuKGNvbnN0IGNoYXIgKnBhdGhuYW1lLCBpbnQgZmxhZ3Ms
IG1vZGVfdCBtb2RlKTsKPiB3aGVyZSBtb2RlIGlzIDAuCj4gQnV0IGFzIGl0J3Mgb25seSBpbiBz
YWZlXyogaXQgc2hvdWxkIGJlIG9rLgo+IFdlIHN0aWxsIGhhdmUgc29tZSBvcGVuKCkgdGVzdHMg
d2l0aG91dCBtb2RlLCBpLmUuCj4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuL29wZW4w
Ni5jCgo+IFVuZm9ydHVuYXRlbHkgc29tZSB0ZXN0cyBuZWVkIHRvIGJlIGFkanVzdGVkLCBhdCBs
ZWFzdCBhbGwgdGVzdHMgaW4KPiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZnZXR4YXR0ciB3
aWxsIGZhaWwgZHVlIGludC1jb252ZXJzaW9uLAo+IGFzIHRoZXkgdXNlIE5VTEwgYXMgdGhlIHRo
aXJkIHBhcmFtZXRlcjoKCj4gJCBleHBvcnQgQ0ZMQUdTPSItV2Vycm9yPWNvbnZlcnNpb24iCj4g
JCAuL2NvbmZpZ3VyZQo+ICQgY2QgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mZ2V0eGF0dHIK
PiAkIG1ha2UgY2xlYW4KPiAkIG1ha2UgVj0xCj4gZ2NjIC1JLi4vLi4vLi4vLi4vaW5jbHVkZSAt
SS4uLy4uLy4uLy4uL2luY2x1ZGUgLUkuLi8uLi8uLi8uLi9pbmNsdWRlL29sZC8gLVdlcnJvcj1p
bnQtY29udmVyc2lvbiAtZyAtTzIgLWZuby1zdHJpY3QtYWxpYXNpbmcgLXBpcGUgLVdhbGwgLVcg
LVdvbGQtc3R5bGUtZGVmaW5pdGlvbiAtc3RkPWdudTk5IC1MLi4vLi4vLi4vLi4vbGliIGZnZXR4
YXR0cjAxLmMgIC1sbHRwIC1vIGZnZXR4YXR0cjAxCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4u
Ly4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3QuaDo5OCwKPiAgICAgICAgICAgICAgICAgIGZyb20g
ZmdldHhhdHRyMDEuYzozNDoKPiBmZ2V0eGF0dHIwMS5jOiBJbiBmdW5jdGlvbiDigJhzZXR1cOKA
mToKPiAuLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oOjkwOjY3OiBlcnJvcjog
cGFzc2luZyBhcmd1bWVudCA2IG9mIOKAmHNhZmVfb3BlbuKAmSBtYWtlcyBpbnRlZ2VyIGZyb20g
cG9pbnRlciB3aXRob3V0IGEgY2FzdCBbLVdlcnJvcj1pbnQtY29udmVyc2lvbl0KPiAgICA5MCB8
ICAgICAgICAgc2FmZV9vcGVuKF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgKHBhdGhuYW1lKSwg
KG9mbGFncyksIChtb2RlKSkKPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgoKPiAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHZvaWQgKgo+IC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmg6OTM6
OTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmF9fU0FGRV9PUEVO4oCZCj4gICAgOTMg
fCAgICAgICAgIF9fU0FGRV9PUEVOKChwYXRobmFtZSksIChvZmxhZ3MpLCAjI19fVkFfQVJHU19f
LCAwKQo+ICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fgo+IGZnZXR4YXR0cjAxLmM6MTE0OjE0
OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYU0FGRV9PUEVO4oCZCj4gICAxMTQgfCAg
ICAgICAgIGZkID0gU0FGRV9PUEVOKEZOQU1FLCBPX1JET05MWSwgTlVMTCk7Cj4gICAgICAgfCAg
ICAgICAgICAgICAgXn5+fn5+fn5+Cj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uLy4uLy4u
L2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmg6MjQ6Cj4gLi4vLi4vLi4vLi4vaW5jbHVkZS9zYWZl
X21hY3Jvc19mbi5oOjc4OjIyOiBub3RlOiBleHBlY3RlZCDigJhtb2RlX3TigJkge2FrYSDigJh1
bnNpZ25lZCBpbnTigJl9IGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlIOKAmHZvaWQgKuKAmQo+ICAg
IDc4IHwgICAgICAgICAgICAgICBtb2RlX3QgbW9kZSk7Cj4gICAgICAgfCAgICAgICAgICAgICAg
IH5+fn5+fn5efn5+Cj4gY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3Jz
Cj4gbWFrZTogKioqIFsuLi8uLi8uLi8uLi9pbmNsdWRlL21rL3J1bGVzLm1rOjQzOiBmZ2V0eGF0
dHIwMV0gRXJyb3IgMQoKTk9URTogdGhpcyBpcyBmcm9tIGdjYywgYnV0IG9idmlvdXNseSBhbHNv
IGNsYW5nIGhhcyB0aGUgc2FtZSBwcm9ibGVtLApldmVuIHdpdGhvdXQgLVdlcnJvcj1pbnQtY29u
dmVyc2lvbiBpbiBDRkxBR1MsIG9idmlvdXNseSBpdCdzIHRoZSBkZWZhdWx0LgpUaGF0J3Mgd2h5
IGl0IHdhcyBmb3VuZCBvbiBGZWRvcmEsIHdoaWNoIHdlIHRlc3Qgd2l0aCBjbGFuZy4KCktpbmQg
cmVnYXJkcywKUGV0cgoKPiBGb3VuZCBvbiByZWNlbnQgb3BlblNVU0UgVHVtYmxld2VlZCB3aGlj
aCBoYXMgMi4zNi4gQWxzbyBvdXIgQ0kgaGFzIGNhdWdodCBpdCBvbgo+IEZlZG9yYSAod2hpY2gg
YWxzbyB1c2VzIDIuMzYpOgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9wZXZpay9sdHAvYWN0aW9ucy9y
dW5zLzM1NzMyMTUzOTAvam9icy82MDA3MDE2NTcyCgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCgo+
ID4gWzBdOiBbSVNPL0lFQyA5ODk5OjIwMTFdIFByb2dyYW1taW5nIExhbmd1YWdlc+KAlEMsIDNy
ZCBlZCwgcGFyYWdyYXBoIDcuMTYuMS4xCj4gPiBbMV06IGh0dHBzOi8vd3d3LmNsLmNhbS5hYy51
ay9yZXNlYXJjaC9zZWN1cml0eS9jdHNyZC9jaGVyaS8KPiA+IFsyXTogaHR0cHM6Ly93d3cubW9y
ZWxsby1wcm9qZWN0Lm9yZy8KCj4gPiBUdWRvciBDcmV0dSAoMyk6Cj4gPiAgIHNhZmVfb3Blbjog
Rml4IHVuZGVmaW5lZCBiZWhhdmlvdXIgaW4gdmFyYXJnIGhhbmRsaW5nCj4gPiAgIHNhZmVfb3Bl
bmF0OiBGaXggdW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKPiA+ICAgc2Fm
ZV9zZW1jdGw6IEZpeCB1bmRlZmluZWQgYmVoYXZpb3VyIGluIHZhcmFyZyBoYW5kbGluZwoKPiA+
ICBpbmNsdWRlL29sZC9zYWZlX21hY3Jvcy5oICAgfCAgNiArKysrLS0KPiA+ICBpbmNsdWRlL3Nh
ZmVfbWFjcm9zX2ZuLmggICAgfCAgMyArKy0KPiA+ICBpbmNsdWRlL3RzdF9zYWZlX2ZpbGVfYXQu
aCAgfCAxMCArKysrKystLS0tCj4gPiAgaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaCAgIHwgIDYg
KysrKy0tCj4gPiAgaW5jbHVkZS90c3Rfc2FmZV9zeXN2X2lwYy5oIHwgMTQgKysrKysrKysrLS0t
LS0KPiA+ICBsaWIvc2FmZV9tYWNyb3MuYyAgICAgICAgICAgfCAxMyArLS0tLS0tLS0tLS0tCj4g
PiAgbGliL3RzdF9jZ3JvdXAuYyAgICAgICAgICAgIHwgIDIgKy0KPiA+ICBsaWIvdHN0X3NhZmVf
ZmlsZV9hdC5jICAgICAgfCAxMSArKystLS0tLS0tLQo+ID4gIGxpYi90c3Rfc2FmZV9zeXN2X2lw
Yy5jICAgICB8IDEwICstLS0tLS0tLS0KPiA+ICA5IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlv
bnMoKyksIDQ0IGRlbGV0aW9ucygtKQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
