Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C49EF436B3
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 14:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 243243E5947
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 16:45:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C1003C0926
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 16:44:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5424600B24
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 16:44:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 612D45BD6C;
 Fri, 17 Apr 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F6A9593AE;
 Fri, 17 Apr 2026 14:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kclFDl9H4mlzNgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 14:44:47 +0000
Date: Fri, 17 Apr 2026 16:44:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260417144445.GA426937@pevik>
References: <20260416144213.27221-1-mdoucha@suse.cz>
 <20260416183620.4076-1-linuxtestproject.agent@gmail.com>
 <20260417130920.GA420978@pevik>
 <d5b21bfa-5fd7-4e2d-b1c0-c89c6b509dbb@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d5b21bfa-5fd7-4e2d-b1c0-c89c6b509dbb@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 612D45BD6C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Add common entry point function for all tests
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFydGluLAoKPiBIaSEKSSBvdmVybG9va2VkIHlvdXIgcmVwbHkgKHBsZWFzZSBteSBmb2xs
b3dpbmcgb25lIHdpdGggZGlmZikuCgo+IE9uIDQvMTcvMjYgMTU6MDksIFBldHIgVm9yZWwgd3Jv
dGU6Cj4gPiBIaSBNYXJ0aW4sCgo+ID4gPiBIaSBNYXJ0aW4sCgo+ID4gPiBPbiBUaHUsIDE2IEFw
ciAyMDI2LCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+ID4gPiA+IE9wZW5QT1NJWDogQWRkIGNvbW1v
biBlbnRyeSBwb2ludCBmdW5jdGlvbiBmb3IgYWxsIHRlc3RzCgo+ID4gPiA+IEFkZCBhIG5ldyBz
aGFyZWQgc291cmNlIGZpbGUgaW1wbGVtZW50aW5nIHRoZSBtYWluKCkgZnVuY3Rpb24gYW5kIHJl
bmFtZQo+ID4gPiA+IHRoZSBleGlzdGluZyBtYWluKCkgZnVuY3Rpb25zIGluIHRlc3QgY2FzZSBz
b3VyY2VzIHRvIHRlc3RfbWFpbigpLiBUaGlzCj4gPiA+ID4gYWxsb3dzIGFkZGluZyBjdXN0b20g
ZGVidWcgY29kZSB0byBhbGwgdGVzdCBjYXNlcyBhdCBvbmNlLgoKPiA+ID4gWy4uLl0KCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5j
ZS9pbnRlcmZhY2VzL3B0aHJlYWRfY3JlYXRlL2Fzc2VydGlvbnMueG1sIGIvLi4uCj4gPiA+ID4g
LSAgTk9URTogdGhhdCB0aGUgdGhyZWFkIGluIHdoaWNoIG1haW4oKSB3YXMgb3JpZ2luYWxseSBp
bnZva2VkIGlzIGRpZmZlcmVudAo+ID4gPiA+ICsgIE5PVEU6IHRoYXQgdGhlIHRocmVhZCBpbiB3
aGljaCB0ZXN0X21haW4oKSB3YXMgb3JpZ2luYWxseSBpbnZva2VkIGlzIGRpZmZlcmVudAoKPiA+
ID4gVGhpcyBjaGFuZ2VzIHZlcmJhdGltIFBPU0lYIHNwZWNpZmljYXRpb24gdGV4dC4gVGhlIGFz
c2VydGlvbnMueG1sIGZpbGVzCj4gPiA+IHF1b3RlIHRoZSBQT1NJWCBzdGFuZGFyZCwgd2hpY2gg
ZGVmaW5lcyBiZWhhdmlvdXIgcmVsYXRpdmUgdG8gbWFpbigpIOKAlCB0aGUgQwo+ID4gPiBlbnRy
eSBwb2ludCwgbm90IGFuIExUUC1pbnRlcm5hbCBmdW5jdGlvbiBuYW1lLiBSZXZlcnQgdGhlc2Ug
aHVua3MgaW4gYm90aAo+ID4gPiBwdGhyZWFkX2NyZWF0ZS9hc3NlcnRpb25zLnhtbCBhbmQgcHRo
cmVhZF9leGl0L2Fzc2VydGlvbnMueG1sLgoKPiA+ICsxCgo+IFRoaXMgImlzc3VlIiBpcyBub25z
ZW5zZS4gSSd2ZSBjaGVja2VkIHRoZSBYTUwgZmlsZXMgYW5kIHRoZSBhc3NlcnRpb25zIGFyZQo+
IHN0aWxsIGNvcnJlY3QgYXMgaXMgcmVnYXJkbGVzcyBvZiByZW5hbWluZyBhIGZldyBmdW5jdGlv
bnMuIFRoZQo+IHB0aHJlYWRfY3JlYXRlKCkgYW5kIHB0aHJlYWRfZXhpdCgpIHNwZWNpZmljYXRp
b24gYXBwbGllcyBzcGVjaWFsIHRyZWF0bWVudAo+IHRvIHRoZSBtYWluIHRocmVhZCBhbmQgYWRk
aW5nIG9uZSBtb3JlIGZ1bmN0aW9uIGNhbGwgYmV0d2VlbiB0aGUgbWFpbigpCj4gZnVuY3Rpb24g
YW5kIHRoZSB0ZXN0IGNvZGUgZG9lcyBub3QgY2hhbmdlIHRoYXQuCgpJIHVuZGVyc3Rvb2QgdGhh
dCBzcGVjIHRhbGtzIGFib3V0IG1haW4oKSBhcyBhIHNwZWNpZmljIEMgc3RhcnR1cCBmdW5jdGlv
bi4KQnV0IG9rLCBJIHdhcyBwcm9iYWJseSB3cm9uZy4KCj4gPiA+ID4gZGlmZiAtLWdpdCBhLy4u
Li9haW9fd3JpdGUvOS0yLmMgYi8uLi4vYWlvX3dyaXRlLzktMi5jCj4gPiA+ID4gK2ludCB0ZXN0
X21haW4oaW50IGFyZ2MsIGNoYXIqKiBhcmd2KQoKPiA+ID4gcy9jaGFyKiogYXJndi9jaGFyICoq
YXJndi8gdG8gbWF0Y2ggdGhlIHN0eWxlIHVzZWQgZXZlcnl3aGVyZSBlbHNlLgoKPiBUaGlzIHR5
cG8gaXMgYWN0dWFsbHkgaW4gY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zdHJjcHkvMS0xLmMgKGxp
bmUgMjM3OTMgb2YKPiB0aGUgcGF0Y2gpLiBQbGVhc2UgY2hhbmdlIHRoZSB0ZXN0X21haW4oKSBz
aWduYXR1cmUgdG8gdGhpcyBkdXJpbmcgbWVyZ2U6Cj4gaW50IHRlc3RfbWFpbihpbnQgYXJnYyBQ
VFNfQVRUUklCVVRFX1VOVVNFRCwgY2hhciAqKmFyZ3YKPiBQVFNfQVRUUklCVVRFX1VOVVNFRCkK
Ck9LLCBmaXhlZCBhbmQgbWVyZ2VkLiBUaGFua3MhCgo+IEkgZG9uJ3QgdGhpbmsgaXQgbWFrZXMg
c2Vuc2UgdG8gc2VuZCBhbm90aGVyIDFNQiBwYXRjaCB0byBmaXggb25lIGxpbmUuCgpUaGF0J3Mg
d2h5IEkgc2VudCBhbm90aGVyIHJlcGx5IHdpdGggZGlmZi4KCktpbmQgcmVnYXJkcywKUGV0cgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
