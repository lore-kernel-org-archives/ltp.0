Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47CAC27C78
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 02:00:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15F993D0BAC
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 04:00:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CE253D0B09
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 04:00:07 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B32246032B1
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 04:00:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F8D620DC7;
 Wed, 12 Jun 2024 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718157605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2budf1i9wwoh1LkDGixuEWyYgN08INeWS3sLPHNKVo=;
 b=FEXZ7Zxdn44G0W/FN3ATp5uHn+gZzUdPZoFt9Mh5kgfbddzWmLwP0ye54ihKbvtl3XWUUW
 NHmlNREm/qOZca1ogmUXUy3oCVlKBSiXAAj+EESz0jlFa/CZKX/E1mTgyYtlrjiansHfrj
 d5fC31Zh3dXI4t4dCEe9UMLYEf0pIL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718157605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2budf1i9wwoh1LkDGixuEWyYgN08INeWS3sLPHNKVo=;
 b=XpTd1QMIu3lzWxWEcebdIcblWV62FddTMg2TtLL019aZh2MigHY3sxQLmFohTrzvjMze9v
 J/5Y291ComJ+LrBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718157605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2budf1i9wwoh1LkDGixuEWyYgN08INeWS3sLPHNKVo=;
 b=FEXZ7Zxdn44G0W/FN3ATp5uHn+gZzUdPZoFt9Mh5kgfbddzWmLwP0ye54ihKbvtl3XWUUW
 NHmlNREm/qOZca1ogmUXUy3oCVlKBSiXAAj+EESz0jlFa/CZKX/E1mTgyYtlrjiansHfrj
 d5fC31Zh3dXI4t4dCEe9UMLYEf0pIL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718157605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2budf1i9wwoh1LkDGixuEWyYgN08INeWS3sLPHNKVo=;
 b=XpTd1QMIu3lzWxWEcebdIcblWV62FddTMg2TtLL019aZh2MigHY3sxQLmFohTrzvjMze9v
 J/5Y291ComJ+LrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 427E213AA4;
 Wed, 12 Jun 2024 02:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xoxYNSEBaWa6fAAAD6G6ig
 (envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 02:00:01 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Amir Goldstein" <amir73il@gmail.com>
In-reply-to: <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
References: <>,
 <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
Date: Wed, 12 Jun 2024 11:59:54 +1000
Message-id: <171815759406.14261.8092450471234028375@noble.neil.brown.name>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC
 correctly.
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
Cc: Aishwarya.TCV@arm.com, Jan Kara <jack@suse.cz>, linux-nfs@vger.kernel.org,
 broonie@kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAxMSBKdW4gMjAyNCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6Cj4gT24gVHVlLCBKdW4g
MTEsIDIwMjQgYXQgNTozMOKAr0FNIE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4gd3JvdGU6Cj4g
Pgo+ID4gT24gRnJpLCAwNyBKdW4gMjAyNCwgSmFtZXMgQ2xhcmsgd3JvdGU6Cj4gPiA+Cj4gPiA+
IEhpIE5laWwsCj4gPiA+Cj4gPiA+IE5vdyB0aGF0IHlvdXIgZml4IGlzIGluIGxpbnV4LW5leHQg
dGhlIHN0YXR2ZnMwMSB0ZXN0IGlzIHBhc3NpbmcgYWdhaW4uCj4gPiA+IEhvd2V2ZXIgaW5vdGlm
eTAyIGlzIHN0aWxsIGZhaWxpbmcuCj4gPiA+Cj4gPiA+IFRoaXMgaXMgYmVjYXVzZSB0aGUgdGVz
dCBleHBlY3RzIHRoZSBJTl9DUkVBVEUgYW5kIElOX09QRU4gZXZlbnRzIHRvCj4gPiA+IGNvbWUg
aW4gdGhhdCBvcmRlciBhZnRlciBjYWxsaW5nIGNyZWF0KCksIGJ1dCBub3cgdGhleSBhcmUgcmV2
ZXJzZWQuIFRvCj4gPiA+IG1lIGl0IHNlZW1zIGxpa2UgaXQgY291bGQgYmUgYSB0ZXN0IGlzc3Vl
IGFuZCB0aGUgdGVzdCBzaG91bGQgaGFuZGxlCj4gPiA+IHRoZW0gaW4gZWl0aGVyIG9yZGVyPyBP
ciBtYXliZSB0aGVyZSBzaG91bGQgYmUgYSBzaW5nbGUgaW5vdGlmeSBldmVudAo+ID4gPiB3aXRo
IGJvdGggZmxhZ3Mgc2V0IGZvciB0aGUgYXRvbWljIG9wZW4/Cj4gPgo+ID4gSW50ZXJlc3Rpbmcu
Li4uICBJIGRvbid0IHNlZSBob3cgYW55IGZpbGVzeXN0ZW0gdGhhdCB1c2VzIC0+YXRvbWljX29w
ZW4KPiA+IHdvdWxkIGdldCB0aGVzZSBpbiB0aGUgInJpZ2h0IiBvcmRlciAtIGFuZCBJIGRvIHRo
aW5rIElOX0NSRUFURSBzaG91bGQKPiA+IGNvbWUgYmVmb3JlIElOX09QRU4uCj4gCj4gQ29ycmVj
dC4KPiAKPiA+Cj4gPiBEb2VzIE5GU3Y0IHBhc3MgdGhpcyB0ZXN0Pwo+IAo+IFByb2JhYmx5IG5v
dC4KPiAKPiA+Cj4gPiBJTl9PUEVOIGlzIGdlbmVyYXRlZCAoYnkgZnNub3RpZnlfb3BlbigpKSB3
aGVuIGZpbmlzaF9vcGVuKCkgaXMgY2FsbGVkLAo+ID4gd2hpY2ggbXVzdCBiZSAoYW5kIGlzKSBj
YWxsZWQgYnkgYWxsIGF0b21pY19vcGVuIGZ1bmN0aW9ucy4KPiA+IElOX0NSRUFURSBpcyBnZW5l
cmF0ZWQgKGJ5IGZzbm90aWZ5X2NyZWF0ZSgpKSB3aGVuIG9wZW5fbGFzdF9sb29rdXBzKCkKPiA+
IGRldGVjdHMgdGhhdCBGTU9ERV9DUkVBVEUgd2FzIHNldCBhbmQgdGhhdCBoYXBwZW5zICphZnRl
ciogbG9va3VwX29wZW4oKQo+ID4gaXMgY2FsbGVkLCB3aGljaCBjYWxscyBhdG9taWNfb3Blbigp
Lgo+ID4KPiA+IEZvciBmaWxlc3lzdGVtcyB0aGF0IGRvbid0IHVzZSBhdG9taWNfb3BlbiwgdGhl
IElOX09QRU4gaXMgZ2VuZXJhdGVkIGJ5Cj4gPiB0aGUgY2FsbCB0byBkb19vcGVuKCkgd2hpY2gg
aGFwcGVucyAqYWZ0ZXIqIG9wZW5fbGFzdF9sb29rdXBzKCksIG5vdAo+ID4gaW5zaWRlIGl0Lgo+
IAo+IENvcnJlY3QuCj4gCj4gPgo+ID4gU28gdGhlIGx0cCB0ZXN0IG11c3QgYWxyZWFkeSBmYWls
IGZvciBORlN2NCwgOXAgY2VwaCBmdXNlIGdmczIgbnRmczMKPiA+IG92ZXJsYXlmcyBzbWIuCj4g
Pgo+IAo+IGlub3RpZnkwMiBkb2VzIG5vdCBydW4gb24gYWxsX2ZpbGVzeXN0ZW1zLCBvbmx5IG9u
IHRoZSBtYWluIHRlc3QgZnMsCj4gd2hpY2ggaXMgbm90IHZlcnkgb2Z0ZW4gb25lIG9mIHRoZSBh
Ym92ZS4KPiAKPiBUaGlzIGlzIGhvdyBJIGF2ZXJ0ZWQgdGhlIHByb2JsZW0gaW4gZmFub3RpZnkx
NiAod2hpY2ggZG9lcyBydW4gb24KPiBhbGxfZmlsZXN5c3RlbXMpOgo+IAo+IGNvbW1pdCA5MDYy
ODI0YTcwYjhkYTc0YWE1YjFkYjA4NzEwZDAwMThiNDgwNzJlCj4gQXV0aG9yOiBBbWlyIEdvbGRz
dGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgo+IERhdGU6ICAgVHVlIE5vdiAyMSAxMjo1Mjo0NyAy
MDIzICswMjAwCj4gCj4gICAgIGZhbm90aWZ5MTY6IEZpeCB0ZXN0IGZhaWx1cmUgb24gRlVTRQo+
IAo+ICAgICBTcGxpdCBTQUZFX0NSRUFUKCkgaW50byBleHBsaWNpdCBTQUZFX01LTk9EKCkgYW5k
IFNBRkVfT1BFTigpLAo+ICAgICBiZWNhdXNlIHdpdGggYXRvbWljIG9wZW4gKGUuZy4gZnVzZSks
IFNBRkVfQ1JFQVQoKSBnZW5lcmF0ZXMgRkFOX09QRU4KPiAgICAgYmVmb3JlIEZBTl9DUkVBVEUg
KHRlc3RlZCB3aXRoIG50ZnMtM2cpLCB3aGljaCBpcyBpbmNvbnNpc3RlbnQgd2l0aAo+ICAgICB0
aGUgb3JkZXIgb2YgZXZlbnRzIGV4cGVjdGVkIGZyb20gb3RoZXIgZmlsZXN5c3RlbXMuCj4gCj4g
aW5vdGlmeTAyIHNob3VsZCBiZSBmaXhlZCBzaW1pbGFybHkuCgpBbHRlcm5hdGVseSAtIG1heWJl
IHRoZSBrZXJuZWwgc2hvdWxkIGJlIGZpeGVkIHRvIGFsd2F5cyBnZXQgdGhlIG9yZGVyCnJpZ2h0
LgpJIGhhdmUgYSBwYXRjaC4gIEknbGwgcG9zdCBpdCBzZXBhcmF0ZWx5LgoKVGhhbmtzIGZvciB5
b3VyIGNvbmZpcm1hdGlvbiB0aGF0IG15IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdCEKCk5laWxC
cm93bgoKCj4gCj4gSSBkaWQgbm90IGZpbmQgYW55IG90aGVyIGlub3RpZnkgdGVzdCB0aGF0IHdh
dGNoZXMgSU5fQ1JFQVRFLgo+IEkgZGlkIG5vdCBmaW5kIGFueSBvdGhlciBmYW5vdGlmeSB0ZXN0
IHRoYXQgd2F0Y2hlcyBib3RoIEZBTl9DUkVBVEUKPiBhbmQgRkFOX09QRU4uCj4gCj4gVGhhbmtz
LAo+IEFtaXIuCj4gCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
