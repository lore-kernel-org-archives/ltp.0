Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611A3C47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 14:45:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A640F3CE1E3
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 15:45:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A164E3CE1D3
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 15:44:57 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D020E100287F
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 15:44:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93E5121EC7;
 Thu, 25 Jan 2024 14:44:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DC79134C3;
 Thu, 25 Jan 2024 14:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rNAmEOdzsmUVWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jan 2024 14:44:55 +0000
Date: Thu, 25 Jan 2024 15:44:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240125144453.GB398849@pevik>
References: <20240125110510.751445-1-amir73il@gmail.com>
 <20240125122337.GA398849@pevik>
 <CAOQ4uxjMiPG5E5=jirxT_D=NDxdUfA2Vp8u1yNZ=YH_SxC0S8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjMiPG5E5=jirxT_D=NDxdUfA2Vp8u1yNZ=YH_SxC0S8Q@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 93E5121EC7
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIEphbiAyNSwgMjAyNCBhdCAyOjIz4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+ID4gV2hlbiB0ZXN0ZWQgZnMgaGFzIHplcm8gZnNpZCAoZS5nLiBm
dXNlKSBhbmQgZXZlbnRzIGFyZSByZXBvcnRlZAo+ID4gPiB3aXRoIGZzaWQrZmlkLCB3YXRjaGlu
ZyBkaWZmZXJlbnQgZmlsZXN5c3RlbXMgd2l0aCB0aGUgc2FtZSBncm91cCBpcwo+ID4gPiBub3Qg
c3VwcG9ydGVkLgoKPiA+ID4gVHJ5IHRvIHNldHVwIGEgYm9ndXMgbWFyayBvbiB0ZXN0IHRtcCBk
aXIsIGluIGFkZGl0aW9uIHRvIHRoZSBtYXJrCj4gPiA+IG9uIHRoZSB0ZXN0ZWQgZmlsZXN5c3Rl
bSwgdG8gY2hlY2sgaWYgbWFya3Mgb24gZGlmZmVyZW50IGZpbGVzeXN0ZW1zCj4gPiA+IGFyZSBz
dXBwb3J0ZWQuCgo+ID4gPiBSdW4gb24gYWxsIGZpbGVzeXN0ZW0gdG8gdGVzdCBib3RoIGZzIHdp
dGggemVybyBmc2lkIChlLmcuIGZ1c2UpIGFuZAo+ID4gPiBmcyB3aXRoIHZhbGlkIGZzaWQuCgo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgo+
ID4gPiAtLS0KCj4gPiBIaSBBbWlyLAoKPiA+ID4gUGV0ciwKCj4gPiA+IFRoZSBmYW5vdGlmeSB0
ZXN0cyBjaGFuZ2VzIHRoYXQgeW91IGFscmVhZHkgcGlja2VkIGZyb20gbXkgZ2l0aHViIFsxXQo+
ID4gPiBoYXZlIHRvIGRvIHdpdGggZml4aW5nIG5ldyB0ZXN0IGZhaWx1cmVzIGluIHY2LjcgYW5k
IHY2LjgtcmMxLCBkdWVzIHRvCj4gPiA+IHRoZSBmYWN0IHRoYXQgZWFjaCBvZiB0aG9zZSBrZXJu
ZWwgdmVyc2lvbnMgYWRkZWQgbmV3IGZpbGVzeXN0ZW1zIHRoYXQKPiA+ID4gc3VwcG9ydCBmYW5v
dGlmeSBldmVudHMgd2l0aCBmaWQrZnNpZC4KCj4gPiA+IFRoaXMgaXMgdGhlIG9ubHkgY2hhbmdl
IHRvIHRlc3QgbmV3IGZ1bmN0aW9uYWxpdHkgaW4gdjYuOC1yYzEsIG5hbWVseSwKPiA+ID4gdGhh
dCBmb3IgZnMgd2l0aCB6ZXJvIGZzaWQgKGUuZy4gZnVzZSksIGFuIGZhbm90aWZ5IGdyb3VwIGNh
biB3YXRjaCBhCj4gPiA+IHNpbmdsZSBmcyBpbnN0YW5jZS4KCj4gPiBUaGlzIHBhdGNoIHdvdWxk
IGhhdmUgdG8gYmUgcmViYXNlZCwgdG8gYmUgYXBwbGljYWJsZSBvZiB0aGUgcHJldmlvdXMgb25l
ICh3aGljaAo+ID4gdG91Y2hlcyBtb3JlIHRlc3RzKSBpbiB5b3VyIGJyYW5jaC4KCj4gSSBkb24n
dCB1bmRlcnN0YW5kIC0gdGhpcyBwYXRjaCBpcyBhbHJlYWR5IHJlYmFzZWQuCkkgbWVhbnQsIHlv
dSBzZW50IGp1c3QgdGhpcyAybmQgY29tbWl0LCB3aXRob3V0IDFzdCBjb21taXQKZjgwZGM1MTJl
ICgiZmFub3RpZnl7MDEsMDksMTB9OiBDaGVjayBmb3IgcmVwb3J0IGZpZCBzdXBwb3J0IHdpdGgg
bW91bnQgbWFyayIpClRoZXJlZm9yZSB0aGlzIGNvbW1pdCBpcyBub3QgYXBwbGljYWJsZS4gSSBn
b3QganVzdCBjb25mdXNlZCB5b3Ugc2VuZCBvbmx5CnRoaXMgY29tbWl0IHdpdGggd2l0aG91dCB0
aGUgcHJldmlvdXMgb25lLi4uCgo+IEkgaGF2ZSBpdCBpbiBteSBicmFuY2ggYWZ0ZXIgdGhlIGZp
eCBwYXRjaGVzOgoKPiA3ZGIyZGFjOWYgKEhFQUQgLT4gZmFub3RpZnlfZnNpZCkgZmFub3RpZnkw
MTogVGVzdCBzZXR0aW5nIHR3byBtYXJrcwo+IG9uIGRpZmZlcmVudCBmaWxlc3lzdGVtcwo+IGY4
MGRjNTEyZSBmYW5vdGlmeXswMSwwOSwxMH06IENoZWNrIGZvciByZXBvcnQgZmlkIHN1cHBvcnQg
d2l0aCBtb3VudCBtYXJrCj4gOTA2MjgyNGE3IChtYXN0ZXIpIGZhbm90aWZ5MTY6IEZpeCB0ZXN0
IGZhaWx1cmUgb24gRlVTRQo+IGVhMDg1NzEzZiBmYW5vdGlmeXsxNCwxNSwxNn06IENoZWNrIGZv
ciBmaWxlc3lzdGVtIG1hcmsgc3VwcG9ydCBvbiBmaWxlc3lzdGVtCj4gOTIxZjBjZTg2IGZhbm90
aWZ5MTM6IFVzZSBnZW5lcmljIGNoZWNrIGZvciBtYXJrIHR5cGUgc3VwcG9ydCBvbiBmaWxlc3lz
dGVtCgoKPiA+IEkgYWxzbyB3b25kZXIgd2hhdCBJIGRpZCB3cm9uZywgdGhlIGJyYW5jaCB3b3Jr
cyBhZnRlciByZWJvb3QsIHRlc3RlZCBvbjoKPiA+IDEpIG1haW5saW5lIGtlcm5lbCA2LjguMC1y
YzEgaW4gcmFwaWRvLWxpbnV4Cj4gPiAyKSBvcGVuU1VTRSBrZXJuZWwgNi44LjAtcmMxLTIuZ2Y0
YmE1ZGItZGVmYXVsdAo+ID4gMykgNi43LjAtOS5nYWVkZGE4MC1kZWZhdWx0CgoKPiBXaGljaCBi
cmFuY2ggd29ya3M/IExUUCBtYXN0ZXIgYnJhbmNoPwoKSSBtZWFudCBIRUFEIG9mIHlvdXIgZmFu
b3RpZnlfZnNpZCBicmFuY2guCgo+IE15IGNsYWltIGlzIHRoYXQgd2l0aCB0aGUgY3VycmVudCBM
VFAgbWFzdGVyIGJyYW5jaCwgZmFub3RpZnkwMSwwOSwxMAo+IHdvdWxkIGZhaWwgb24ga2VybmVs
IDYuOC4wLXJjMSB3aGVuIHJ1bm5pbmcgd2l0aAo+IExUUF9ERVZfRlNfVFlQRT1leGZhdCAobm90
IExUUF9TSU5HTEVfRlNfVFlQRT1leGZhdCkKCkknbSBzb3JyeSwgSSBvdmVybG9va2VkIHRoZSBk
aWZmZXJlbnQgdmFyaWFibGUuCkkgc2VlIExUUF9ERVZfRlNfVFlQRT1leGZhdCBnZXRzIEVPUE5P
VFNVUFAgb24gTFRQIG1hc3RlciBvbiA2LjguMC1yYzE6CmZhbm90aWZ5MDEuYzoxMDY6IFRCUk9L
OiBmYW5vdGlmeV9tYXJrKDMsIDB4MTEsIDB4M2IsIC4uLiwgZnNfbW50L3RmaWxlXzQ1MDMpIGZh
aWxlZDogRU9QTk9UU1VQUCAoOTUpCgo+IFNvIGF0IGxlYXN0IHlvdSBzaG91bGQgY29uc2lkZXIg
YXBwbHlpbmcgdGhpcyBmaXggZm9yIHRoZSByZWxlYXNlOgo+IGY4MGRjNTEyZSBmYW5vdGlmeXsw
MSwwOSwxMH06IENoZWNrIGZvciByZXBvcnQgZmlkIHN1cHBvcnQgd2l0aCBtb3VudCBtYXJrCgpJ
IHNlZS4gWWVzLCBJIHJlcHJvZHVjZWQgdGhlIHByb2JsZW0gYW5kIHRodXMgY2hlcnJ5LXBpY2tl
ZCBhbmQgbWVyZ2VkIHRoaXMgb25lCmFzIGJhZThlYzlhMy4KCkFsdGhvdWdoIHRoaXMgcGF0Y2gg
KHRoZSAybmQgY29tbWl0KSBzaG91bGQgYWxzbyB3b3JrIGV2ZXJ5d2hlcmUsIEknbGwgYmFja3Bv
cnQKaXQganVzdCBhZnRlciB0aGUgcmVsZWFzZS4KClRoYW5rcyBhIGxvdCBmb3IgZXhwbGFuYXRp
b24gYW5kIHNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLgoKS2luZCByZWdhcmRzLApQZXRyCgo+IFRo
YW5rcywKPiBBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
