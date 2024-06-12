Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80DAC27C77
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 11:48:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB11C3D0BB2
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 13:48:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBD033CE0D9
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 13:47:58 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3274810006C6
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 13:47:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A6405C161;
 Wed, 12 Jun 2024 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718192876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DO6CKqmZSs/sVbRj2TCciFxO1LSPO4hZc1lrmrgZm/A=;
 b=vIgmHWUhwb6cvZRmqUuWDpP2HqgoxszL/5/EBqAxkQ/j95uG7tqu0Atog10lPDZ5zZa2ep
 Njm9HJb8hwY/mYbiL2n30Yal1Nucl8ozRXYiMjfNHxAct04Xr2dDxIo1H5gEU8Dd4mc+Tz
 tQX+zf2S07LWlgUkXX1r90fC1lQfJa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718192876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DO6CKqmZSs/sVbRj2TCciFxO1LSPO4hZc1lrmrgZm/A=;
 b=qH8Tn7kwJtS63vuzriQ8mY9AdSKK9PjmHpyFoTFEpACUu+s/4r7sdqQyEVbplQFAZcnuRf
 Gm9ktDAENTcYjUBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vIgmHWUh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qH8Tn7kw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718192876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DO6CKqmZSs/sVbRj2TCciFxO1LSPO4hZc1lrmrgZm/A=;
 b=vIgmHWUhwb6cvZRmqUuWDpP2HqgoxszL/5/EBqAxkQ/j95uG7tqu0Atog10lPDZ5zZa2ep
 Njm9HJb8hwY/mYbiL2n30Yal1Nucl8ozRXYiMjfNHxAct04Xr2dDxIo1H5gEU8Dd4mc+Tz
 tQX+zf2S07LWlgUkXX1r90fC1lQfJa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718192876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DO6CKqmZSs/sVbRj2TCciFxO1LSPO4hZc1lrmrgZm/A=;
 b=qH8Tn7kwJtS63vuzriQ8mY9AdSKK9PjmHpyFoTFEpACUu+s/4r7sdqQyEVbplQFAZcnuRf
 Gm9ktDAENTcYjUBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81EE41372E;
 Wed, 12 Jun 2024 11:47:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5PqpCeiKaWZzGgAAD6G6ig
 (envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 11:47:52 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Amir Goldstein" <amir73il@gmail.com>
In-reply-to: <CAOQ4uxidUYY02xry+y5VpRWfBjCmAt0CnmJ3JbgLTLkZ6nn1sA@mail.gmail.com>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>,
 <CAOQ4uxidUYY02xry+y5VpRWfBjCmAt0CnmJ3JbgLTLkZ6nn1sA@mail.gmail.com>
Date: Wed, 12 Jun 2024 21:47:48 +1000
Message-id: <171819286884.14261.11045203598673536466@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A6405C161
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
 Miklos Szeredi <miklos@szeredi.hu>, linux-nfs@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCAxMiBKdW4gMjAyNCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6Cj4gT24gV2VkLCBKdW4g
MTIsIDIwMjQgYXQgMTA6MTDigK9BTSBOZWlsQnJvd24gPG5laWxiQHN1c2UuZGU+IHdyb3RlOgo+
ID4KPiA+Cj4gPiBXaGVuIGEgZmlsZSBpcyBvcGVuZWQgYW5kIGNyZWF0ZWQgd2l0aCBvcGVuKC4u
LiwgT19DUkVBVCkgd2UgZ2V0Cj4gPiBib3RoIHRoZSBDUkVBVEUgYW5kIE9QRU4gZnNub3RpZnkg
ZXZlbnRzIGFuZCB3b3VsZCBleHBlY3QgdGhlbSBpbiB0aGF0Cj4gPiBvcmRlci4gICBGb3IgbW9z
dCBmaWxlc3lzdGVtcyB3ZSBnZXQgdGhlbSBpbiB0aGF0IG9yZGVyIGJlY2F1c2UKPiA+IG9wZW5f
bGFzdF9sb29rdXBzKCkgY2FsbHMgZnNub2ZpZnlfY3JlYXRlKCkgYW5kIHRoZW4gZG9fb3Blbigp
IChmcm9tCj4gPiBwYXRoX29wZW5hdCgpKSBjYWxscyB2ZnNfb3BlbigpLT5kb19kZW50cnlfb3Bl
bigpIHdoaWNoIGNhbGxzCj4gPiBmc25vdGlmeV9vcGVuKCkuCj4gPgo+ID4gSG93ZXZlciB3aGVu
IC0+YXRvbWljX29wZW4gaXMgdXNlZCwgdGhlCj4gPiAgICBkb19kZW50cnlfb3BlbigpIC0+IGZz
bm90aWZ5X29wZW4oKQo+ID4gY2FsbCBoYXBwZW5zIGZyb20gZmluaXNoX29wZW4oKSB3aGljaCBp
cyBjYWxsZWQgZnJvbSB0aGUgLT5hdG9taWNfb3Blbgo+ID4gaGFuZGxlciBpbiBsb29rdXBfb3Bl
bigpIHdoaWNoIGlzIGNhbGxlZCAqYmVmb3JlKiBvcGVuX2xhc3RfbG9va3VwcygpCj4gPiBjYWxs
cyBmc25vdGlmeV9jcmVhdGUuICBTbyB3ZSBnZXQgdGhlICJvcGVuIiBub3RpZmljYXRpb24gYmVm
b3JlCj4gPiAiY3JlYXRlIiAtIHdoaWNoIGlzIGJhY2t3YXJkcy4gIGx0cCB0ZXN0Y2FzZSBpbm90
aWZ5MDIgdGVzdHMgdGhpcyBhbmQKPiA+IHJlcG9ydHMgdGhlIGluY29uc2lzdGVuY3kuCj4gPgo+
ID4gVGhpcyBwYXRjaCBsaWZ0cyB0aGUgZnNub3RpZnlfb3BlbigpIGNhbGwgb3V0IG9mIGRvX2Rl
bnRyeV9vcGVuKCkgYW5kCj4gPiBwbGFjZXMgaXQgaGlnaGVyIHVwIHRoZSBjYWxsIHN0YWNrLiAg
VGhlcmUgYXJlIHRocmVlIGNhbGxlcnMgb2YKPiA+IGRvX2RlbnRyeV9vcGVuKCkuCj4gPgo+ID4g
Rm9yIHZmc19vcGVuKCkgYW5kIGtlcm5lbF9maWxlX29wZW4oKSB0aGUgZnNub3RpZnlfb3Blbigp
IGlzIHBsYWNlZAo+ID4gZGlyZWN0bHkgaW4gdGhhdCBjYWxsZXIgc28gdGhlcmUgc2hvdWxkIGJl
IG5vIGJlaGF2aW91cmFsIGNoYW5nZS4KPiA+Cj4gPiBGb3IgZmluaXNoX29wZW4oKSB0aGVyZSBh
cmUgdHdvIGNhc2VzOgo+ID4gIC0gZmluaXNoX29wZW4gaXMgdXNlZCBpbiAtPmF0b21pY19vcGVu
IGhhbmRsZXJzLiAgRm9yIHRoZXNlIHdlIGFkZCBhCj4gPiAgICBjYWxsIHRvIGZzbm90aWZ5X29w
ZW4oKSBhdCB0aGUgdG9wIG9mIGRvX29wZW4oKSBpZiBGTU9ERV9PUEVORUQgaXMKPiA+ICAgIHNl
dCAtIHdoaWNoIG1lYW5zIGRvX2RlbnRyeV9vcGVuKCkgaGFzIGJlZW4gY2FsbGVkLgo+ID4gIC0g
ZmluaXNoX29wZW4gaXMgdXNlZCBpbiAtPnRtcGZpbGUoKSBoYW5kbGVycy4gIEZvciB0aGVzZSBh
IHNpbWlsYXIKPiA+ICAgIGNhbGwgdG8gZnNub3RpZnlfb3BlbigpIGlzIGFkZGVkIHRvIHZmc190
bXBmaWxlKCkKPiAKPiBBbnkgaGFuZGxlcnMgb3RoZXIgdGhhbiBvdmxfdG1wZmlsZSgpPwoKTG9j
YWwgZmlsZXN5c3RlbXMgdGVuZCB0byBjYWxsIGZpbmlzaF9vcGVuX3NpbXBsZSgpIHdoaWNoIGlz
IGEgdHJpdmlhbAp3cmFwcGVyIGFyb3VuZCBmaW5pc2hfb3BlbigpLgpFdmVyeSAudG1wZmlsZSBo
YW5kbGVyIGNhbGxzIGVpdGhlciBmaW5pc2hfb3BlbigpIG9yIGZpbmlzaF9vcGVuX3NpbXBsZSgp
LgoKPiBUaGlzIG9uZSBpcyBhIHZlcnkgcmVjZW50IGFuZCBwcmV0dHkgc3BlY2lhbCBjYXNlLgo+
IERpZCBvcGVuKE9fVE1QRklMRSkgdXNlZCB0byBlbWl0IGFuIE9QRU4gZXZlbnQgYmVmb3JlIHRo
YXQgY2hhbmdlPwoKSSBiZWxpZXZlIHNvLCB5ZXMuCgpUaGFua3MsCk5laWxCcm93bgoKPiAKPiA+
Cj4gPiBXaXRoIHRoaXMgcGF0Y2ggTkZTdjMgaXMgcmVzdG9yZWQgdG8gaXRzIHByZXZpb3VzIGJl
aGF2aW91ciAoYmVmb3JlCj4gPiAtPmF0b21pY19vcGVuIHN1cHBvcnQgd2FzIGFkZGVkKSBvZiBn
ZW5lcmF0aW5nIENSRUFURSBub3RpZmljYXRpb25zCj4gPiBiZWZvcmUgT1BFTiwgYW5kIE5GU3Y0
IG5vdyBoYXMgdGhhdCBzYW1lIGNvcnJlY3Qgb3JkZXJpbmcgdGhhdCBpcyBoYXMKPiA+IG5vdCBo
YWQgYmVmb3JlLiAgSSBoYXZlbid0IHRlc3RlZCBvdGhlciBmaWxlc3lzdGVtcy4KPiA+Cj4gPiBG
aXhlczogN2M2YzUyNDlmMDYxICgiTkZTOiBhZGQgYXRvbWljX29wZW4gZm9yIE5GU3YzIHRvIGhh
bmRsZSBPX1RSVU5DIGNvcnJlY3RseS4iKQo+ID4gUmVwb3J0ZWQtYnk6IEphbWVzIENsYXJrIDxq
YW1lcy5jbGFya0Bhcm0uY29tPgo+ID4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMDFjM2JmMmUtZWIxZi00YjdmLWE1NGYtZDJhMDVkZDNkOGM4QGFybS5jb20KPiA+IFNpZ25l
ZC1vZmYtYnk6IE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4KPiA+IC0tLQo+ID4gIGZzL25hbWVp
LmMgfCAgNSArKysrKwo+ID4gIGZzL29wZW4uYyAgfCAxOSArKysrKysrKysrKystLS0tLS0tCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+ID4K
PiA+IGRpZmYgLS1naXQgYS9mcy9uYW1laS5jIGIvZnMvbmFtZWkuYwo+ID4gaW5kZXggMzdmYjBh
OGFhMDlhLi4wNTdhZmFjYzRiNjAgMTAwNjQ0Cj4gPiAtLS0gYS9mcy9uYW1laS5jCj4gPiArKysg
Yi9mcy9uYW1laS5jCj4gPiBAQCAtMzYxMiw2ICszNjEyLDkgQEAgc3RhdGljIGludCBkb19vcGVu
KHN0cnVjdCBuYW1laWRhdGEgKm5kLAo+ID4gICAgICAgICBpbnQgYWNjX21vZGU7Cj4gPiAgICAg
ICAgIGludCBlcnJvcjsKPiA+Cj4gPiArICAgICAgIGlmIChmaWxlLT5mX21vZGUgJiBGTU9ERV9P
UEVORUQpCj4gPiArICAgICAgICAgICAgICAgZnNub3RpZnlfb3BlbihmaWxlKTsKPiA+ICsKPiA+
ICAgICAgICAgaWYgKCEoZmlsZS0+Zl9tb2RlICYgKEZNT0RFX09QRU5FRCB8IEZNT0RFX0NSRUFU
RUQpKSkgewo+ID4gICAgICAgICAgICAgICAgIGVycm9yID0gY29tcGxldGVfd2FsayhuZCk7Cj4g
PiAgICAgICAgICAgICAgICAgaWYgKGVycm9yKQo+ID4gQEAgLTM3MDAsNiArMzcwMyw4IEBAIGlu
dCB2ZnNfdG1wZmlsZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwKPiA+ICAgICAgICAgbW9kZSA9
IHZmc19wcmVwYXJlX21vZGUoaWRtYXAsIGRpciwgbW9kZSwgbW9kZSwgbW9kZSk7Cj4gPiAgICAg
ICAgIGVycm9yID0gZGlyLT5pX29wLT50bXBmaWxlKGlkbWFwLCBkaXIsIGZpbGUsIG1vZGUpOwo+
ID4gICAgICAgICBkcHV0KGNoaWxkKTsKPiA+ICsgICAgICAgaWYgKGZpbGUtPmZfbW9kZSAmIEZN
T0RFX09QRU5FRCkKPiA+ICsgICAgICAgICAgICAgICBmc25vdGlmeV9vcGVuKGZpbGUpOwo+ID4g
ICAgICAgICBpZiAoZXJyb3IpCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIGVycm9yOwo+ID4g
ICAgICAgICAvKiBEb24ndCBjaGVjayBmb3Igb3RoZXIgcGVybWlzc2lvbnMsIHRoZSBpbm9kZSB3
YXMganVzdCBjcmVhdGVkICovCj4gPiBkaWZmIC0tZ2l0IGEvZnMvb3Blbi5jIGIvZnMvb3Blbi5j
Cj4gPiBpbmRleCA4OWNhZmI1NzIwNjEuLjk3MGYyOTljMGU3NyAxMDA2NDQKPiA+IC0tLSBhL2Zz
L29wZW4uYwo+ID4gKysrIGIvZnMvb3Blbi5jCj4gPiBAQCAtMTAwNCwxMSArMTAwNCw2IEBAIHN0
YXRpYyBpbnQgZG9fZGVudHJ5X29wZW4oc3RydWN0IGZpbGUgKmYsCj4gPiAgICAgICAgICAgICAg
ICAgfQo+ID4gICAgICAgICB9Cj4gPgo+ID4gLSAgICAgICAvKgo+ID4gLSAgICAgICAgKiBPbmNl
IHdlIHJldHVybiBhIGZpbGUgd2l0aCBGTU9ERV9PUEVORUQsIF9fZnB1dCgpIHdpbGwgY2FsbAo+
ID4gLSAgICAgICAgKiBmc25vdGlmeV9jbG9zZSgpLCBzbyB3ZSBuZWVkIGZzbm90aWZ5X29wZW4o
KSBoZXJlIGZvciBzeW1tZXRyeS4KPiA+IC0gICAgICAgICovCj4gPiAtICAgICAgIGZzbm90aWZ5
X29wZW4oZik7Cj4gPiAgICAgICAgIHJldHVybiAwOwo+ID4KPiA+ICBjbGVhbnVwX2FsbDoKPiA+
IEBAIC0xMDg1LDggKzEwODAsMTcgQEAgRVhQT1JUX1NZTUJPTChmaWxlX3BhdGgpOwo+ID4gICAq
Lwo+ID4gIGludCB2ZnNfb3Blbihjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgc3RydWN0IGZpbGUg
KmZpbGUpCj4gPiAgewo+ID4gKyAgICAgICBpbnQgcmV0Owo+ID4gKwo+ID4gICAgICAgICBmaWxl
LT5mX3BhdGggPSAqcGF0aDsKPiA+IC0gICAgICAgcmV0dXJuIGRvX2RlbnRyeV9vcGVuKGZpbGUs
IE5VTEwpOwo+ID4gKyAgICAgICByZXQgPSBkb19kZW50cnlfb3BlbihmaWxlLCBOVUxMKTsKPiA+
ICsgICAgICAgaWYgKCFyZXQpCj4gPiArICAgICAgICAgICAgICAgLyoKPiA+ICsgICAgICAgICAg
ICAgICAgKiBPbmNlIHdlIHJldHVybiBhIGZpbGUgd2l0aCBGTU9ERV9PUEVORUQsIF9fZnB1dCgp
IHdpbGwgY2FsbAo+ID4gKyAgICAgICAgICAgICAgICAqIGZzbm90aWZ5X2Nsb3NlKCksIHNvIHdl
IG5lZWQgZnNub3RpZnlfb3BlbigpIGhlcmUgZm9yIHN5bW1ldHJ5Lgo+ID4gKyAgICAgICAgICAg
ICAgICAqLwo+ID4gKyAgICAgICAgICAgICAgIGZzbm90aWZ5X29wZW4oZmlsZSk7Cj4gCj4gSSBh
Z3JlZSB0aGF0IHRoaXMgY2hhbmdlIHByZXNlcnZlcyB0aGUgbG9naWMsIGJ1dCAobXkgb3duKSBj
b21tZW50Cj4gYWJvdmUgaXMgaW5jb25zaXN0ZW50IHdpdGggdGhlIGNhc2Ugb2Y6Cj4gCj4gICAg
ICAgICBpZiAoKGYtPmZfZmxhZ3MgJiBPX0RJUkVDVCkgJiYgIShmLT5mX21vZGUgJiBGTU9ERV9D
QU5fT0RJUkVDVCkpCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+IAo+IFdoaWNo
IGRvZXMgc2V0IEZNT0RFX09QRU5FRCwgYnV0IGRvZXMgbm90IGVtaXQgYW4gT1BFTiBldmVudC4K
CklmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoYXQgY2FzZSBkb2Vzbid0IGVtaXQgYW4gT1BF
TiBldmVudCBiZWZvcmUKbXkgcGF0Y2gsIGJ1dCB3aWxsIHJlc3VsdCBpbiBhIENMT1NFIGV2ZW50
LgpBZnRlciBteSBwYXRjaCAuLi4gSSB0aGluayBpdCBzdGlsbCBkb2Vzbid0IGVtaXQgT1BFTi4K
Ckkgd29uZGVyIGlmLCBpbnN0ZWFkIG9mIGFkZGluZyB0aGUgdGhlIGZzbm90aWZ5X29wZW4oKSBp
biBkb19vcGVuKCksIHdlCnNob3VsZCBwdXQgaXQgaW4gdGhlXAoJaWYgKGZpbGUtPmZfbW9kZSAm
IChGTU9ERV9PUEVORUQgfCBGTU9ERV9DUkVBVEVEKSkgewpjYXNlIG9mIG9wZW5fbGFzdF9sb29r
dXBzKCkuCgpPciBtYXliZSBpdCByZWFsbHkgZG9lc24ndCBodXJ0IHRvIGhhdmUgYSBDTE9TRSBl
dmVudCB3aXRob3V0IGFuZCBPUEVOLiAKT1BFTiB3aXRob3V0IENMT1NFIHdvdWxkIGJlIHByb2Js
ZW1hdGljLCBidXQgdGhlIG90aGVyIHdheSBhcm91bmQKc2hvdWxkbid0IG1hdHRlci4uLi4gIEl0
IGZlZWxzIHVudGlkeSwgYnV0IG1heWJlIHdlIGRvbid0IGNhcmUuCgpUaGFua3MsCk5laWxCcm93
bgoKCj4gCj4gSSBoYXZlIGEgZmVlbGluZyB0aGF0IHRoZSBjb21tZW50IGlzIGNvcnJlY3QgYWJv
dXQgdGhlIENMT1NFIGV2ZW50IGluCj4gdGhhdCBjYXNlLCBidXQgaG9uZXN0bHksIEkgZG9uJ3Qg
dGhpbmsgdGhpcyBjb3JuZXIgY2FzZSBpcyB0aGF0IGltcG9ydGFudCwKPiBqdXN0IG1heWJlIHRo
ZSBjb21tZW50IG5lZWRzIHRvIGJlIHNsaWdodGx5IGNsYXJpZmllZD8KPiAKPiBUaGFua3MsCj4g
QW1pci4KPiAKPiA+ICsgICAgICAgcmV0dXJuIHJldDsKPiA+ICB9Cj4gPgo+ID4gIHN0cnVjdCBm
aWxlICpkZW50cnlfb3Blbihjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgaW50IGZsYWdzLAo+ID4g
QEAgLTExNzgsNyArMTE4Miw4IEBAIHN0cnVjdCBmaWxlICprZXJuZWxfZmlsZV9vcGVuKGNvbnN0
IHN0cnVjdCBwYXRoICpwYXRoLCBpbnQgZmxhZ3MsCj4gPiAgICAgICAgIGlmIChlcnJvcikgewo+
ID4gICAgICAgICAgICAgICAgIGZwdXQoZik7Cj4gPiAgICAgICAgICAgICAgICAgZiA9IEVSUl9Q
VFIoZXJyb3IpOwo+ID4gLSAgICAgICB9Cj4gPiArICAgICAgIH0gZWxzZQo+ID4gKyAgICAgICAg
ICAgICAgIGZzbm90aWZ5X29wZW4oZik7Cj4gPiAgICAgICAgIHJldHVybiBmOwo+ID4gIH0KPiA+
ICBFWFBPUlRfU1lNQk9MX0dQTChrZXJuZWxfZmlsZV9vcGVuKTsKPiA+IC0tCj4gPiAyLjQ0LjAK
PiA+Cj4gCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
