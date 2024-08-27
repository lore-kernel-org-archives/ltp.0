Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7ECC54731
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 15:27:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CB563D2752
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 17:27:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 586233C655D
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 17:27:12 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BB5FD1007C82
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 17:27:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0163121B0E;
 Tue, 27 Aug 2024 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724772430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiRuT6KS5xm/a1uK/VGs5u1puvYNGTCyQqWHx/rE3bo=;
 b=o+dYyyKxYYk97NirY9aGv5IfKvHrHrqFWWqd9hJ+rwZaiV4IMrT9fYnxGt86PR0jNIoMJV
 6l92S7RFOOAUCK1SjpiOfDcCmedGKugqzx9JI6yMoBCg3KhOvtw4+eed8G9Pgjf6WcAUET
 Jh3kYsoBPntmoJJxkX3N0PRNUtT/vQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724772430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiRuT6KS5xm/a1uK/VGs5u1puvYNGTCyQqWHx/rE3bo=;
 b=bgprGjwOLEXZUcFTaD/4uIXDLmpzKCJ5Gjx7/8DrVfnaXTc6U7kK8itUTGzddff1AbSyGw
 +B2JIMwaO0HJFuBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o+dYyyKx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bgprGjwO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724772430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiRuT6KS5xm/a1uK/VGs5u1puvYNGTCyQqWHx/rE3bo=;
 b=o+dYyyKxYYk97NirY9aGv5IfKvHrHrqFWWqd9hJ+rwZaiV4IMrT9fYnxGt86PR0jNIoMJV
 6l92S7RFOOAUCK1SjpiOfDcCmedGKugqzx9JI6yMoBCg3KhOvtw4+eed8G9Pgjf6WcAUET
 Jh3kYsoBPntmoJJxkX3N0PRNUtT/vQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724772430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiRuT6KS5xm/a1uK/VGs5u1puvYNGTCyQqWHx/rE3bo=;
 b=bgprGjwOLEXZUcFTaD/4uIXDLmpzKCJ5Gjx7/8DrVfnaXTc6U7kK8itUTGzddff1AbSyGw
 +B2JIMwaO0HJFuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5FE113724;
 Tue, 27 Aug 2024 15:27:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hmVCJ03wzWbUJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 Aug 2024 15:27:09 +0000
Date: Tue, 27 Aug 2024 17:27:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Message-ID: <20240827152702.GA1634061@pevik>
References: <20240823064640.GA1217451@pevik>
 <172445038410.6062.6091007925280806767@noble.neil.brown.name>
 <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
 <20240827132242.GA1627011@pevik>
 <44DF7F99-3FDA-46C0-BC93-B6679F04B7AB@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44DF7F99-3FDA-46C0-BC93-B6679F04B7AB@oracle.com>
X-Rspamd-Queue-Id: 0163121B0E
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_EQ_ADDR_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
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
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Neil Brown <neilb@suse.de>, Josef Bacik <josef@toxicpanda.com>,
 linux-stable <stable@vger.kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiA+IE9uIEF1ZyAyNywgMjAyNCwgYXQgOToyMuKAr0FNLCBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgYWxsLAoKPiA+PiBPbiAyMy4gMDguIDI0IDIz
OjU5LCBOZWlsQnJvd24gd3JvdGU6Cj4gPj4+IE9uIEZyaSwgMjMgQXVnIDIwMjQsIFBldHIgVm9y
ZWwgd3JvdGU6Cj4gPj4+PiBXZSBkaXNjdXNzZWQgaW4gdjEgaG93IHRvIGZpeCB0ZXN0cy4gIE5l
aWwgc3VnZ2VzdGVkIHRvIGZpeCB0aGUgdGVzdCB0aGUgd2F5IHNvCj4gPj4+PiB0aGF0IGl0IHdv
cmtzIG9uIGFsbCBrZXJuZWxzLiBBcyBJIG5vdGUgWzFdCgo+ID4+Pj4gMSkgZWl0aGVyIHdlIGdp
dmUgdXAgb24gY2hlY2tpbmcgdGhlIG5ldyBmdW5jdGlvbmFsaXR5IHN0aWxsIHdvcmtzIChpZiB3
ZQo+ID4+Pj4gZmFsbGJhY2sgdG8gb2xkIGJlaGF2aW9yKQoKPiA+Pj4gSSBkb24ndCB1bmRlcnN0
YW5kLiAgV2hhdCBleGFjdGx5IGRvIHlvdSBtZWFuIGJ5ICJ0aGUgbmV3Cj4gPj4+IGZ1bmN0aW9u
YWxpdHkiLgo+ID4+PiBBcyBJIHVuZGVyc3RhbmQgaXQgdGhlcmUgaXMgbm8gbmV3IGZ1bmN0aW9u
YWxpdHkuICBBbGwgdGhlcmUgd2FzIHdhcyBhbmQKPiA+Pj4gaW5mb3JtYXRpb24gbGVhayBiZXR3
ZWVuIG5ldHdvcmsgbmFtZXNwYWNlcywgYW5kIHdlIHN0b3BwZWQgdGhlIGxlYWsuCj4gPj4+IERv
IHlvdSBjb25zaWRlciB0aGF0IHRvIGJlIG5ldyBmdW5jdGlvbmFsaXR5PwoKPiA+IFRoYW5rcyBN
YXJ0aW4gZm9yIGp1bXBpbmcgaW4uIEkgaG9wZWQgSSB3YXMgY2xlYXIsIGJ1dCBvYnZpb3VzbHkg
bm90LgoKPiA+IEZvbGxvd2luZyBhcmUgdGhlIHF1ZXN0aW9ucyBmb3Iga2VybmVsIG1haW50YWlu
ZXJzIGFuZCBkZXZlbG9wZXJzLiBJIHB1dCBteQo+ID4gb3BpbmlvbiwgYnV0IGl0J3MgcmVhbGx5
IHVwIHRvIHlvdSB3aGF0IHlvdSB3YW50IHRvIGhhdmUgdGVzdGVkLgoKPiA+PiBUaGUgbmV3IGZ1
bmN0aW9uYWxpdHkgaXMgdGhhdCB0aGUgcGF0Y2hlcyBhZGQgYSBuZXcgZmlsZSB0byBuZXR3b3Jr
Cj4gPj4gbmFtZXNwYWNlczogL3Byb2MvbmV0L3JwYy9uZnMuIFRoaXMgZmlsZSBkaWQgbm90IGV4
aXN0IG91dHNpZGUgdGhlIHJvb3QKPiA+PiBuZXR3b3JrIG5hbWVzcGFjZSBhdCBsZWFzdCBvbiBz
b21lIG9mIHRoZSBrZXJuZWxzIHdoZXJlIHdlIHN0aWxsIG5lZWQgdG8gcnVuCj4gPj4gdGhpcyB0
ZXN0LiBTbyB0aGUgcXVlc3Rpb24gaXM6IEhvdyBhZ2dyZXNzaXZlbHkgZG8gd2Ugd2FudCB0byBl
bmZvcmNlCj4gPj4gYmFja3BvcnRpbmcgb2YgdGhlc2UgTkZTIHBhdGNoZXMgaW50byBkaXN0cm9z
IHdpdGggb2xkZXIga2VybmVscz8KCj4gPj4gV2UgaGF2ZSAzIG9wdGlvbnMgaG93IHRvIGZpeCB0
aGUgdGVzdCBkZXBlbmRpbmcgb24gdGhlIGFuc3dlcjoKPiA+PiAxKSBEb24ndCBlbmZvcmNlIGF0
IGFsbC4gV2UnbGwgY2hlY2sgd2hldGhlciAvcHJvYy9uZXQvcnBjL25mcyBleGlzdHMgaW4gdGhl
Cj4gPj4gY2xpZW50IG5hbWVzcGFjZSBhbmQgcmVhZCBpdCBvbmx5IGlmIGl0IGRvZXMuIE90aGVy
d2lzZSB3ZSdsbCBmYWxsIGJhY2sgb24KPiA+PiB0aGUgZ2xvYmFsIGZpbGUuCgo+ID4gMSkgaXMg
SU1ITyB0aGUgd29yc3QgY2FzZSBiZWNhdXNlIGl0J3Mgbm90IHRlc3RpbmcgcGF0Y2ggZ2V0cyBy
ZXZlcnRlZC4KCj4gPj4gMikgRW5mb3JjZSBhZ2dyZXNzaXZlbHkuIFdlJ2xsIGhhcmRjb2RlIGEg
bWluaW1hbCBrZXJuZWwgdmVyc2lvbiBpbnRvIHRoZQo+ID4+IHRlc3QgKGUuZy4gdjUuNCkgYW5k
IGlmIHRoZSBwcm9jZmlsZSBkb2Vzbid0IGV4aXN0IG9uIGFueSBuZXdlciBrZXJuZWwsIGl0J3MK
PiA+PiBhIGJ1Zy4KCj4gPiBJIHdvdWxkIHByZWZlciAyKSwgd2hpY2ggaXMgdGhlIHVzdWFsIExU
UCBhcHByb2FjaCAoZG8gbm90IGhpZGUgYnVncywgd2UgZXZlbgo+ID4gZmFpbCBvbiB1cHN0cmVh
bSBrZXJuZWwgV09OVEZJWCBbMV0sIHdoeSB3ZSBzaG91bGQgcmVmdXNlIHRoZSBwb2xpY3kgaGVy
ZT8pLgoKPiAyKSBtYWtlcyBzZW5zZSB0byBtZS4KClRoYW5rcyBmb3IgeW91ciBvcGluaW9uLiBJ
J2xsIHNlbmQgYW5vdGhlciB2ZXJzaW9uICgrIHN0aWxsIHdhaXQgZm9yIG90aGVycyBpbnB1dCku
CgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gPiBXaGljaGV2ZXIgb2xkZXIgTFRTIHVwc3RyZWFtIGtl
cm5lbCBnZXRzIGZpeGVkIHdvdWxkIGRyaXZlIHRoZSBsaW5lIHdoZXJlIG5ldwo+ID4gZnVuY3Rp
b25hbGl0eSBpcyByZXF1ZXN0ZWQgKGN1cnJlbnRseSB2NS4xNCwgSSBzdXBwb3NlIGF0IGxlYXN0
IDUuMTAgd2lsbCBhbHNvCj4gPiBiZSBmaXhlZCkuIExUUCBhbHNvIGhhcyBhIHdheSB0byBzcGVj
aWZ5IGVudGVycHJpc2UgZGlzdHJvIGtlcm5lbCB2ZXJzaW9uIGlmCj4gPiBvbGRlciBlbnRlcnBy
aXNlIGtlcm5lbCBhbHNvIGdldHMgZml4ZWQgKHRoaXMgc2hvdWxkIG5vdCBiZSBuZWVkZWQsIGJ1
dCBpdCdkIGJlCj4gPiBwb3NzaWJsZSkuCgo+ID4+IDMpIEVuZm9yY2Ugb24gbmV3IGtlcm5lbHMg
b25seS4gV2UnbGwgc2V0IGEgaGFyZCByZXF1aXJlbWVudCBmb3Iga2VybmVsCj4gPj4gdjYuOSsg
YXMgaW4gb3B0aW9uIDIpIGFuZCBjaGVjayBmb3IgZXhpc3RlbmNlIG9mIHRoZSBwcm9jZmlsZSBv
biBhbnkgb2xkZXIKPiA+PiBrZXJuZWxzIGFzIGluIG9wdGlvbiAxKS4KCj4gPiBEdWUgd2F5IHRv
IHNwZWNpZnkgZW50ZXJwcmlzZSBkaXN0cm8ga2VybmVsIHZlcnNpb24gYW5kIHVwc3RyZWFtIGtl
cm5lbCB0ZXN0aW5nCj4gPiBleHBlY3RpbmcgcGVvcGxlIHVwZGF0ZSB0byB0aGUgbGF0ZXN0IHN0
YWJsZS9MVFMgd2Ugc2hvdWxkIG5vdCB3b3JyeSBtdWNoIGFib3V0Cj4gPiBwZW9wbGUgd2l0aCBv
bGRlciBrZXJuZWxzLgoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiBbMV0gaHR0cHM6
Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvYmxvYi9tYXN0ZXIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy91c3RhdC91c3RhdDAxLmMjTDQ4LUw0OQoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
