Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFD1CAC5AE
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 12:25:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB28C3CE111
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 14:25:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65E513CDEC6
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 14:25:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82AE660098F
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 14:25:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58FE724199;
 Fri, 26 Sep 2025 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758889513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgbT7oV43YDGgjNU+1TspeKsdCZB+lpHSiO3yiTYvTw=;
 b=aLfFPEAXXitkG9DA04KY9MYqEM5uqMKnwwBa1dsm6gJxXGFw3BVqQ2gu2lC7MRhcGYBBan
 e4AVCeG+G1WQXGHTIY/nJDQa+UUw5taeyz99MFGhybBmc6psXNxe1bpP1U2oDkVHMHSHC3
 jIJ9GHM93yu4eDJVAHZ2b0dMAJ6pUW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758889513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgbT7oV43YDGgjNU+1TspeKsdCZB+lpHSiO3yiTYvTw=;
 b=g0zfvq6aQt1hLZFdnkNsucKbdSSu6CIvzYDIe5bzvmkb9PXJmmgxIE20KgJU0bT3YJ6RSK
 mPvou8F0yE5VexBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aLfFPEAX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g0zfvq6a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758889513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgbT7oV43YDGgjNU+1TspeKsdCZB+lpHSiO3yiTYvTw=;
 b=aLfFPEAXXitkG9DA04KY9MYqEM5uqMKnwwBa1dsm6gJxXGFw3BVqQ2gu2lC7MRhcGYBBan
 e4AVCeG+G1WQXGHTIY/nJDQa+UUw5taeyz99MFGhybBmc6psXNxe1bpP1U2oDkVHMHSHC3
 jIJ9GHM93yu4eDJVAHZ2b0dMAJ6pUW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758889513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgbT7oV43YDGgjNU+1TspeKsdCZB+lpHSiO3yiTYvTw=;
 b=g0zfvq6aQt1hLZFdnkNsucKbdSSu6CIvzYDIe5bzvmkb9PXJmmgxIE20KgJU0bT3YJ6RSK
 mPvou8F0yE5VexBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C0691373E;
 Fri, 26 Sep 2025 12:25:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J6+9CSmG1mjsQwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Sep 2025 12:25:13 +0000
Date: Fri, 26 Sep 2025 14:25:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20250926122511.GB158871@pevik>
References: <20250917102737.GA336745@pevik>
 <CAASaF6yjdrLLVnehESx1TjsrB_z48nmN_2i585GPfkG3Vvg15Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6yjdrLLVnehESx1TjsrB_z48nmN_2i585GPfkG3Vvg15Q@mail.gmail.com>
X-Rspamd-Queue-Id: 58FE724199
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] 'nobody' user for testing
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
Cc: Betty Zhou <bettyzhou@google.com>, ltp@lists.linux.it,
 Edward Liaw <edliaw@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmFuLAoKPiBPbiBXZWQsIFNlcCAxNywgMjAyNSBhdCAxMjoyN+KAr1BNIFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiBIaSwKCj4gPiBJIGZvdW5kIGEgc2V0dXAgYnVn
IG9uIExUUCBJTUEgdGVzdHMgaW1hX2NvbmRpdGlvbmFscy5zaCBhbmQKPiA+IGltYV9tZWFzdXJl
bWVudHMuc2ggd2hpY2ggdXNlICdzdWRvJyAod2l0aCB1c2VyICdub2JvZHknKS4gV2UgaGF2ZSBt
YW55IEMgdGVzdHMKPiA+IGluIExUUCB3aGljaCB1c2UgJ25vYm9keScgdXNlciBzb21laG93LCBi
dXQgdGhleSBkb24ndCBhY3R1YWxseSBleGVjdXRlCj4gPiBhbnl0aGluZyB3aXRoIHRoaXMgYWNj
b3VudC4gSU1ITyB0aGVzZSBhcmUgdGhlIG9ubHkgdGVzdHMgd2hpY2ggZXhlY3V0ZSB3aXRoICdz
dWRvJwo+ID4gKHBsZWFzZSBkb3VibGUgY2hlY2sgbWUpLgoKPiA+ICQgZ2l0IGdyZXAgLWwgbm9i
b2R5IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvIHwgd2MgLWwKPiA+IDE2MAoKPiA+IEJlY2F1
c2Ugb24gbmV3ZXIgc3lzdGVtcyAoSSBjaGVja2VkIFR1bWJsZXdlZCwgRmVkb3JhLCBEZWJpYW4p
ICdub2JvZHknIGFjY291bnQgdXNlCj4gPiAvdXNyL3NiaW4vbm9sb2dpbiB3aGljaCBwcmV2ZW50
cyBsb2dnaW5nLCB3ZSAxKSBlaXRoZXIgbmVlZCB0byBjaGFuZ2UgYWNjb3VudAo+ID4gdG8gdXNl
IGJhc2ggKGFuZCByZXN0b3JlIGl0IGJhY2sgYWZ0ZXIgdGVzdGluZykgb3IgMikgY3JlYXRlIGEg
ZGVkaWNhdGVkIHVzZXIKPiA+IGZvciB0ZXN0aW5nLiBJJ2QgdHJ5IHRvIHVzZSAndXNlcmFkZCcg
YW5kIGNoZWNrIHdpdGggZ3JlcCAvZXRjL3Bhc3N3ZCBpZiB0aGUKPiA+IHVzZXIgaXMgbm90IGFs
cmVhZHkgZGVmaW5lZC4KCj4gPiBJIHRlbmQgdG8gdXNlIDIpLCBhZGQgaXQgb25seSB0byBJTUEg
dGVzdHMgKHRvIGltYV9zZXR1cC5zaCkuIEJ1dCBJIGNvdWxkCj4gPiBwdXQgc29tZSBtb3JlIGdl
bmVyaWMgY29kZSB0byB0c3RfdGVzdC5zaCBzbyB0aGF0IGl0IGNhbiBiZSByZXVzZWQgYnkgb3Ro
ZXIKPiA+IHRlc3RzIGluIHRoZSBmdXR1cmUuIFdEWVQ/Cgo+IEhpIFBldHIsCgo+IERvIHRob3Nl
IHRlc3RzIHN0YXJ0IHVuZGVyIHJvb3QgdXNlcj8gSSdtIHRoaW5raW5nIHdlIHdyaXRlIG91ciBv
d24KPiAobXVjaCBzaW1wbGVyKQo+IHZlcnNpb24gb2YgInN1ZG8iLCB0aGF0IGp1c3QgY2hhbmdl
cyB1aWQvZ2l0IGJhc2VkIG9uIHBhcmFtZXRlcnMgYW5kCj4gZXhlY3V0ZXMgd2hhdGV2ZXIgd2Ug
Z2l2ZSBpdC4KClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjaywgSSdtIHNvcnJ5IGZvciBhIGxhdGUg
cmVwbHkuCgpZZXMsIHRoZXNlIHNoZWxsIHRlc3RzIHJlcXVpcmUgcm9vdCAoZm9yIHRvdWNoaW5n
Ci9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kgYW5kIGVmZmVjdGl2ZWx5IGR1ZSBmb3Jt
YXR0aW5nIGEgbG9vcCBkZXZpY2UpLgoKQW5kIG1vc3QgQyBBUEkgdGVzdHMgd2hpY2ggd29yayB3
aXRoICdub2JvZHknIHVzZXIgcmVxdWlyZSByb290IGR1ZSB2YXJpb3VzCnJlYXNvbnMsIGUuZy46
Cm9wZW4wMi5jOjQwOiBUQlJPSzogc2V0ZXVpZCg2NTUzNCkgZmFpbGVkOiBFUEVSTSAoMSkKCkFz
IEkgd3JvdGUgcHJldmlvdXNseSBJIHBsYW5uZWQgdXNlIGluIHNvbWUgdGVzdHMgJ3N1JyBpbnN0
ZWFkIG9mICdzdWRvJyAoJ3N1JwppcyBzaW1wbGVyKSwgYnV0IHVzdWFsIExUUCBhcHByb2FjaCB0
byBoYXZlIHNvbWUgbWluaW1hbGlzdGljIGJpbmFyeSB3b3VsZCBiZSBhCklNSE8gdGhlIGJlc3Qg
c29sdXRpb24gKG5vIGRlcGVuZGVuY3ksIGFsc28gaXQnZCBoZWxwIHRvIHRlc3Qgb24gZHJhY3V0
IGJhc2VkCnJhcGlkIHRlc3Rpbmcgd2hlbiBiaXNlY3Rpbmcga2VybmVsIHdpdGggcmFwaWRvKS4K
CkJ1dCBjdXJyZW50bHkgZm9yIG1lIGlzIG1vcmUgaW1wb3J0YW50IGlmIHdlIGp1c3QgZXhwZWN0
ICdub2JvZHknIHVzZXIgaXMgaGVyZQphbmQgbGVhdmUgaXQgdG8gdGVzdGVycyB0byBzZXQgdXAg
dGhlIGFjY291bnQgcHJvcGVybHkgKHdlIHN0aWxsIGhhdmUgdGhhdCBvbGQKSURjaGVjay5zaCBp
biB0cmVlIHdoaWNoIGlzIHJ1biBieSBkZXByZWNhdGVkICdydW5sdHAnIGJ1dCBub3QgaW4ga2ly
aykuCgpJJ20gbm90IHN1cmUgaWYgaXQncyB3b3J0aCB0byBhZGQgc29tZSAxKSBjaGVja3MgaW4g
dGhlIGxpYnJhcnkgMikgc29tZQpjdXN0b21pc2F0aW9uIChhbGxvdyB0byB1c2UgYSBkaWZmZXJl
bnQgdXNlciB2aWEgZW52LiB2YXJpYWJsZSAzKSBzZXR1cApkZWRpY2F0ZWQgdXNlciBhY2NvdW50
IGZvciBMVFAgdGVzdGluZy4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBKYW4KCgo+ID4gQWxzbywg
YXMgd2UgaGVhdmlseSB1c2UgJ25vYm9keScgYWxyZWFkeSBJJ20gbm90IHN1cmUgaWYgaXQncyB3
b3J0aCB0byBib3RoZXIKPiA+IHdpdGggcHV0dGluZyBlbnZpcm9ubWVudCB2YXJpYWJsZSBhbGxv
d2luZyBhIGRpZmZlcmVudCB1c2VyLiBOb2JvZHkgc28gZmFyIGNvbXBsYWluZWQsCj4gPiBldmVu
IEFPU1AgZm9sa3Mgc2VlbSB0byBiZSB1c2VkIEMgdGVzdHMgd2hpY2ggdXNlICdub2JvZHknIChl
LmcuIGZjaG1vZDA2LmMgaXMKPiA+IGNvbXBpbGVkIFsxXSBhbmQgbm90IGRpc2FibGVkIFsyXSku
Cgo+ID4gQWxzbywgd2UgYWdyZWVkIHdpdGggQ3lyaWwsIHRoYXQgaXQnZCBiZSBnb29kIHRvIGNv
bnZlcnQgdGhlc2UgMiBJTUEgdGVzdHMgdG8KPiA+IHVzZSAnc3UnIGluc3RlYWQgb2YgJ3N1ZG8n
IGJlY2F1c2UgJ3N1JyBpcyBzaW1wbGVyIHRoYW4gJ3N1ZG8nIChhbHRob3VnaCB3aGVuCj4gPiB0
ZXN0aW5nIHdpdGggcmFwaWRvIFszXSBub25lIG9mIHRoZW0gd29ya3Mgb3V0IG9mIHRoZSBib3gp
LgoKPiA+IFsxXSBodHRwczovL2FuZHJvaWQuZ29vZ2xlc291cmNlLmNvbS9wbGF0Zm9ybS9leHRl
cm5hbC9sdHAvKy9yZWZzL2hlYWRzL21haW4vYW5kcm9pZC9BbmRyb2lkLmJwCj4gPiBbMl0gaHR0
cHM6Ly9hbmRyb2lkLmdvb2dsZXNvdXJjZS5jb20vcGxhdGZvcm0vZXh0ZXJuYWwvbHRwLysvcmVm
cy9oZWFkcy9tYWluL2FuZHJvaWQvdG9vbHMvZGlzYWJsZWRfdGVzdHMudHh0Cj4gPiBbM10gaHR0
cHM6Ly9naXRodWIuY29tL3JhcGlkby1saW51eC9yYXBpZG8KCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
