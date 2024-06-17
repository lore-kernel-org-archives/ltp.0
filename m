Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1C1C41513
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 13:08:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 836133D0D20
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 15:07:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 683503C2A2B
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 15:07:43 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4F8201400F54
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 15:07:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8A3C381FC;
 Mon, 17 Jun 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC66213AAA;
 Mon, 17 Jun 2024 13:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cCYSKhs1cGZwPQAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 13:07:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 4F1D2A0887; Mon, 17 Jun 2024 15:07:39 +0200 (CEST)
Date: Mon, 17 Jun 2024 15:07:39 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240617130739.ki5tpsbgvhumdrla@quack3>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
 <20240617093745.nhnc7e7efdldnjzl@quack3>
 <CAOQ4uxiN3JnH-oJTw63rTR_B8oPBfB7hWyun0Hsb3ZX3AORf2g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiN3JnH-oJTw63rTR_B8oPBfB7hWyun0Hsb3ZX3AORf2g@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: B8A3C381FC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIDE3LTA2LTI0IDE1OjA5OjA5LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBNb24s
IEp1biAxNywgMjAyNCBhdCAxMjozN+KAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+IHdyb3Rl
Ogo+ID4gT24gU2F0IDE1LTA2LTI0IDA3OjM1OjQyLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToK
PiA+ID4gT24gV2VkLCAxMiBKdW4gMjAyNCAxNzowOTo1NSArMTAwMCwgTmVpbEJyb3duIHdyb3Rl
Ogo+ID4gPiA+IFdoZW4gYSBmaWxlIGlzIG9wZW5lZCBhbmQgY3JlYXRlZCB3aXRoIG9wZW4oLi4u
LCBPX0NSRUFUKSB3ZSBnZXQKPiA+ID4gPiBib3RoIHRoZSBDUkVBVEUgYW5kIE9QRU4gZnNub3Rp
ZnkgZXZlbnRzIGFuZCB3b3VsZCBleHBlY3QgdGhlbSBpbiB0aGF0Cj4gPiA+ID4gb3JkZXIuICAg
Rm9yIG1vc3QgZmlsZXN5c3RlbXMgd2UgZ2V0IHRoZW0gaW4gdGhhdCBvcmRlciBiZWNhdXNlCj4g
PiA+ID4gb3Blbl9sYXN0X2xvb2t1cHMoKSBjYWxscyBmc25vZmlmeV9jcmVhdGUoKSBhbmQgdGhl
biBkb19vcGVuKCkgKGZyb20KPiA+ID4gPiBwYXRoX29wZW5hdCgpKSBjYWxscyB2ZnNfb3Blbigp
LT5kb19kZW50cnlfb3BlbigpIHdoaWNoIGNhbGxzCj4gPiA+ID4gZnNub3RpZnlfb3BlbigpLgo+
ID4gPiA+Cj4gPiA+ID4gWy4uLl0KPiA+ID4KPiA+ID4gQXBwbGllZCB0byB0aGUgdmZzLmZpeGVz
IGJyYW5jaCBvZiB0aGUgdmZzL3Zmcy5naXQgdHJlZS4KPiA+ID4gUGF0Y2hlcyBpbiB0aGUgdmZz
LmZpeGVzIGJyYW5jaCBzaG91bGQgYXBwZWFyIGluIGxpbnV4LW5leHQgc29vbi4KPiA+ID4KPiA+
ID4gUGxlYXNlIHJlcG9ydCBhbnkgb3V0c3RhbmRpbmcgYnVncyB0aGF0IHdlcmUgbWlzc2VkIGR1
cmluZyByZXZpZXcgaW4gYQo+ID4gPiBuZXcgcmV2aWV3IHRvIHRoZSBvcmlnaW5hbCBwYXRjaCBz
ZXJpZXMgYWxsb3dpbmcgdXMgdG8gZHJvcCBpdC4KPiA+ID4KPiA+ID4gSXQncyBlbmNvdXJhZ2Vk
IHRvIHByb3ZpZGUgQWNrZWQtYnlzIGFuZCBSZXZpZXdlZC1ieXMgZXZlbiB0aG91Z2ggdGhlCj4g
PiA+IHBhdGNoIGhhcyBub3cgYmVlbiBhcHBsaWVkLiBJZiBwb3NzaWJsZSBwYXRjaCB0cmFpbGVy
cyB3aWxsIGJlIHVwZGF0ZWQuCj4gPiA+Cj4gPiA+IE5vdGUgdGhhdCBjb21taXQgaGFzaGVzIHNo
b3duIGJlbG93IGFyZSBzdWJqZWN0IHRvIGNoYW5nZSBkdWUgdG8gcmViYXNlLAo+ID4gPiB0cmFp
bGVyIHVwZGF0ZXMgb3Igc2ltaWxhci4gSWYgaW4gZG91YnQsIHBsZWFzZSBjaGVjayB0aGUgbGlz
dGVkIGJyYW5jaC4KPiA+ID4KPiA+ID4gdHJlZTogICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC92ZnMvdmZzLmdpdAo+ID4gPiBicmFuY2g6IHZmcy5maXhl
cwo+ID4gPgo+ID4gPiBbMS8xXSBWRlM6IGdlbmVyYXRlIEZTX0NSRUFURSBiZWZvcmUgRlNfT1BF
TiB3aGVuIC0+YXRvbWljX29wZW4gdXNlZC4KPiA+ID4gICAgICAgaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy92ZnMvdmZzL2MvNzUzNmIyZjA2NzI0Cj4gPgo+ID4gSSBoYXZlIHJldmlld2VkIHRoZSBw
YXRjaCB5b3UndmUgY29tbWl0dGVkIHNpbmNlIEkgd2Fzbid0IHF1aXRlIHN1cmUgd2hpY2gKPiA+
IGNoYW5nZXMgeW91J3JlIGdvaW5nIHRvIGFwcGx5IGFmdGVyIHlvdXIgZGlzY3Vzc2lvbiB3aXRo
IEFtaXIuIEFuZCBJIGhhdmUKPiA+IHR3byBjb21tZW50czoKPiA+Cj4gPiBAQCAtMTA4NSw4ICsx
MDgwLDE3IEBAIEVYUE9SVF9TWU1CT0woZmlsZV9wYXRoKTsKPiA+ICAgKi8KPiA+ICBpbnQgdmZz
X29wZW4oY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsIHN0cnVjdCBmaWxlICpmaWxlKQo+ID4gIHsK
PiA+ICsgICAgICAgaW50IHJldDsKPiA+ICsKPiA+ICAgICAgICAgZmlsZS0+Zl9wYXRoID0gKnBh
dGg7Cj4gPiAtICAgICAgIHJldHVybiBkb19kZW50cnlfb3BlbihmaWxlLCBOVUxMKTsKPiA+ICsg
ICAgICAgcmV0ID0gZG9fZGVudHJ5X29wZW4oZmlsZSwgTlVMTCk7Cj4gPiArICAgICAgIGlmICgh
cmV0KQo+ID4gKyAgICAgICAgICAgICAgIC8qCj4gPiArICAgICAgICAgICAgICAgICogT25jZSB3
ZSByZXR1cm4gYSBmaWxlIHdpdGggRk1PREVfT1BFTkVELCBfX2ZwdXQoKSB3aWxsIGNhbGwKPiA+
ICsgICAgICAgICAgICAgICAgKiBmc25vdGlmeV9jbG9zZSgpLCBzbyB3ZSBuZWVkIGZzbm90aWZ5
X29wZW4oKSBoZXJlIGZvciBzeW1tZXRyeS4KPiA+ICsgICAgICAgICAgICAgICAgKi8KPiA+ICsg
ICAgICAgICAgICAgICBmc25vdGlmeV9vcGVuKGZpbGUpOwo+IAo+IFBsZWFzZSBhZGQgeyB9IGFy
b3VuZCBtdWx0aSBsaW5lIGluZGVudGVkIHRleHQuCj4gCj4gPiArICAgICAgIHJldHVybiByZXQ7
Cj4gPiAgfQo+ID4KPiA+IEFGQUlDVCB0aGlzIHdpbGwgaGF2ZSBhIHNpZGUtZWZmZWN0IHRoYXQg
bm93IGZzbm90aWZ5X29wZW4oKSB3aWxsIGJlCj4gPiBnZW5lcmF0ZWQgZXZlbiBmb3IgT19QQVRI
IG9wZW4uIEl0IGlzIHRydWUgdGhhdCBmc25vdGlmeV9jbG9zZSgpIGlzIGdldHRpbmcKPiA+IGdl
bmVyYXRlZCBmb3IgdGhlbSBhbHJlYWR5IGFuZCB3ZSBzaG91bGQgc3RyaXZlIGZvciBzeW1tZXRy
eS4gQ29uY2VwdHVhbGx5Cj4gPiBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gbWUgdG8gZ2VuZXJh
dGUgZnNub3RpZnkgZXZlbnRzIGZvciBPX1BBVEgKPiA+IG9wZW5zL2Nsb3NlcyBidXQgbWF5YmUg
SSBtaXNzIHNvbWV0aGluZy4gQW1pciwgYW55IG9waW5pb24gaGVyZT8KPiAKPiBHb29kIGNhdGNo
IQo+IAo+IEkgYWdyZWUgdGhhdCB3ZSBkbyBub3QgbmVlZCBPUEVOIG5vciBDTE9TRSBldmVudHMg
Zm9yIE9fUEFUSC4KPiBJIHN1Z2dlc3QgdG8gc29sdmUgaXQgd2l0aDoKPiAKPiBAQCAtOTE1LDcg
KzkyOSw3IEBAIHN0YXRpYyBpbnQgZG9fZGVudHJ5X29wZW4oc3RydWN0IGZpbGUgKmYsCj4gICAg
ICAgICBmLT5mX3NiX2VyciA9IGZpbGVfc2FtcGxlX3NiX2VycihmKTsKPiAKPiAgICAgICAgIGlm
ICh1bmxpa2VseShmLT5mX2ZsYWdzICYgT19QQVRIKSkgewo+IC0gICAgICAgICAgICAgICBmLT5m
X21vZGUgPSBGTU9ERV9QQVRIIHwgRk1PREVfT1BFTkVEOwo+ICsgICAgICAgICAgICAgICBmLT5m
X21vZGUgPSBGTU9ERV9QQVRIIHwgRk1PREVfT1BFTkVEIHwgX19GTU9ERV9OT05PVElGWTsKPiAg
ICAgICAgICAgICAgICAgZi0+Zl9vcCA9ICZlbXB0eV9mb3BzOwo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gMDsKPiAgICAgICAgIH0KCkZpcnN0IEkgd2FzIHNvbWV3aGF0IG5lcnZvdXMgYWJvdXQg
dGhpcyBhcyBpdCByZXN1bHRzIGluIHJldHVybmluZyBPX1BBVEgKZmQgd2l0aCBfX0ZNT0RFX05P
Tk9USUZZIHRvIHVzZXJzcGFjZSBhbmQgSSB3YXMgYWZyYWlkIGl0IG1heSBpbmZsdWVuY2UKZ2Vu
ZXJhdGlvbiBvZiBldmVudHMgKnNvbWV3aGVyZSouIEJ1dCBjaGVja2luZyBhIGJpdCwgd2UgdXNl
ICdmaWxlJyBmb3IKZ2VuZXJhdGluZyBvbmx5IG9wZW4sIGFjY2VzcywgbW9kaWZ5LCBhbmQgY2xv
c2UgZXZlbnRzIHNvIHllcywgdGhpcyBzaG91bGQKYmUgc2FmZS4gQWx0ZXJuYXRpdmVseSB3ZSBj
b3VsZCBhZGQgZXhwbGljaXQgY2hlY2tzIGZvciAhT19QQVRIIHdoZW4KZ2VuZXJhdGluZyBvcGVu
IC8gY2xvc2UgZXZlbnRzLgoKPiA+IEBAIC0zNjEyLDYgKzM2MTIsOSBAQCBzdGF0aWMgaW50IGRv
X29wZW4oc3RydWN0IG5hbWVpZGF0YSAqbmQsCj4gPiAgICAgICAgIGludCBhY2NfbW9kZTsKPiA+
ICAgICAgICAgaW50IGVycm9yOwo+ID4KPiA+ICsgICAgICAgaWYgKGZpbGUtPmZfbW9kZSAmIEZN
T0RFX09QRU5FRCkKPiA+ICsgICAgICAgICAgICAgICBmc25vdGlmeV9vcGVuKGZpbGUpOwo+ID4g
Kwo+ID4gICAgICAgICBpZiAoIShmaWxlLT5mX21vZGUgJiAoRk1PREVfT1BFTkVEIHwgRk1PREVf
Q1JFQVRFRCkpKSB7Cj4gPiAgICAgICAgICAgICAgICAgZXJyb3IgPSBjb21wbGV0ZV93YWxrKG5k
KTsKPiA+ICAgICAgICAgICAgICAgICBpZiAoZXJyb3IpCj4gPgo+ID4gRnJhbmtseSwgdGhpcyB3
b3JrcyBidXQgbG9va3MgYXMgYW4gb2RkIHBsYWNlIHRvIHB1dCB0aGlzIG5vdGlmaWNhdGlvbiB0
by4KPiA+IFdoeSBub3QganVzdCBwbGFjaW5nIGl0IGp1c3QgbmV4dCB0byB3aGVyZSBmc25vdGlm
eV9jcmVhdGUoKSBpcyBnZW5lcmF0ZWQKPiA+IGluIG9wZW5fbGFzdF9sb29rdXBzKCk/IExpa2U6
Cj4gPgo+ID4gICAgICAgICBpZiAob3Blbl9mbGFnICYgT19DUkVBVCkKPiA+ICAgICAgICAgICAg
ICAgICBpbm9kZV9sb2NrKGRpci0+ZF9pbm9kZSk7Cj4gPiAgICAgICAgIGVsc2UKPiA+ICAgICAg
ICAgICAgICAgICBpbm9kZV9sb2NrX3NoYXJlZChkaXItPmRfaW5vZGUpOwo+ID4gICAgICAgICBk
ZW50cnkgPSBsb29rdXBfb3BlbihuZCwgZmlsZSwgb3AsIGdvdF93cml0ZSk7Cj4gPiAtICAgICAg
IGlmICghSVNfRVJSKGRlbnRyeSkgJiYgKGZpbGUtPmZfbW9kZSAmIEZNT0RFX0NSRUFURUQpKQo+
ID4gLSAgICAgICAgICAgICAgIGZzbm90aWZ5X2NyZWF0ZShkaXItPmRfaW5vZGUsIGRlbnRyeSk7
Cj4gPiArICAgICAgIGlmICghSVNfRVJSKGRlbnRyeSkpIHsKPiA+ICsgICAgICAgICAgICAgICBp
ZiAoZmlsZS0+Zl9tb2RlICYgRk1PREVfQ1JFQVRFRCkKPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGZzbm90aWZ5X2NyZWF0ZShkaXItPmRfaW5vZGUsIGRlbnRyeSk7Cj4gPiArICAgICAgICAg
ICAgICAgaWYgKGZpbGUtPmZfbW9kZSAmIEZNT0RFX09QRU5FRCkKPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGZzbm90aWZ5X29wZW4oZmlsZSk7Cj4gPiArICAgICAgIH0KPiA+ICAgICAgICAg
aWYgKG9wZW5fZmxhZyAmIE9fQ1JFQVQpCj4gPiAgICAgICAgICAgICAgICAgaW5vZGVfdW5sb2Nr
KGRpci0+ZF9pbm9kZSk7Cj4gPiAgICAgICAgIGVsc2UKPiA+ICAgICAgICAgICAgICAgICBpbm9k
ZV91bmxvY2tfc2hhcmVkKGRpci0+ZF9pbm9kZSk7Cj4gPgo+ID4gVGhhdCBsb29rcyBsaWtlIGEg
cGxhY2Ugd2hlcmUgaXQgaXMgbXVjaCBtb3JlIG9idmlvdXMgdGhpcyBpcyBmb3IKPiA+IGF0b21p
Y19vcGVuKCkgaGFuZGxpbmc/IE5vdyBJIGFkbWl0IEknbSBub3QgcmVhbGx5IGNsb3NlbHkgZmFt
aWxpYXIgd2l0aAo+ID4gdGhlIGF0b21pY19vcGVuKCkgcGF0aHMgc28gbWF5YmUgSSBtaXNzIHNv
bWV0aGluZyBhbmQgZG9fb3BlbigpIGlzIGJldHRlci4KPiAKPiBJdCBsb29rcyBuaWNlLCBidXQg
SSB0aGluayBpdCBpcyBtaXNzaW5nIHRoZSBmYXN0IGxvb2t1cCBjYXNlIHdpdGhvdXQgT19DUkVB
VAo+IChpLmUuIGdvdG8gZmluaXNoX2xvb2t1cCkuCgpJIGRvbid0IHRoaW5rIHNvLiBBRkFJQ1Qg
dGhhdCBjYXNlIHdpbGwgZ2VuZXJhdGUgdGhlIGV2ZW50IGluIHZmc19vcGVuKCkKYW55d2F5IGFu
ZCBub3QgaW4gb3Blbl9sYXN0X2xvb2t1cHMoKSAvIGRvX29wZW4oKS4gQW0gSSBtaXNzaW5nIHNv
bWV0aGluZz8KCgkJCQkJCQkJSG9uemEKLS0gCkphbiBLYXJhIDxqYWNrQHN1c2UuY29tPgpTVVNF
IExhYnMsIENSCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
