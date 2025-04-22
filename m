Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5AEC369C2
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 10:52:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1DC33C2991
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 12:52:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E4FF3C0B7C
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 12:52:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E61331A00CA5
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 12:52:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5064C1F38E;
 Tue, 22 Apr 2025 10:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745319141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J294hy/j/WLC+lp+GI8vvTUyHQgNqbHhq7yo/ezzbwA=;
 b=Xy69Pvx0imbEgKtiN6FHp3fwapeeW8jMcE9rT4S6ifAsIwF6y1fxZmt09u8GhQj1FsJuFe
 FgfbIYJ2TrRJBFHwcpLfhUppPSjujfkjjck4z4yhGiyx1vOUmNQR7Pknv08vyiAufjvb4i
 4ssVRwQEUu3tBiKKGejyyWZJatbsM44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745319141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J294hy/j/WLC+lp+GI8vvTUyHQgNqbHhq7yo/ezzbwA=;
 b=NWLqk61B1VdJ8uDhaFEOKgkkMKM0+Wsig3Lj6fEzCTK/z6PAoaREzdLdr0EyJ4Azz9/IZ/
 8B+gVgw4oTn02jBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Xy69Pvx0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NWLqk61B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745319141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J294hy/j/WLC+lp+GI8vvTUyHQgNqbHhq7yo/ezzbwA=;
 b=Xy69Pvx0imbEgKtiN6FHp3fwapeeW8jMcE9rT4S6ifAsIwF6y1fxZmt09u8GhQj1FsJuFe
 FgfbIYJ2TrRJBFHwcpLfhUppPSjujfkjjck4z4yhGiyx1vOUmNQR7Pknv08vyiAufjvb4i
 4ssVRwQEUu3tBiKKGejyyWZJatbsM44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745319141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J294hy/j/WLC+lp+GI8vvTUyHQgNqbHhq7yo/ezzbwA=;
 b=NWLqk61B1VdJ8uDhaFEOKgkkMKM0+Wsig3Lj6fEzCTK/z6PAoaREzdLdr0EyJ4Azz9/IZ/
 8B+gVgw4oTn02jBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34EB3137CF;
 Tue, 22 Apr 2025 10:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UHZWC+V0B2gqfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Apr 2025 10:52:21 +0000
Date: Tue, 22 Apr 2025 12:52:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250422105219.GA927374@pevik>
References: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
 <20250414-conversions-mknod-v3-1-e08e7463bfaa@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250414-conversions-mknod-v3-1-e08e7463bfaa@suse.com>
X-Rspamd-Queue-Id: 5064C1F38E
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/8] syscalls/mknod01: Fix checkpatch.pl
 warnings
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljYXJkbywKCj4gRml4IHRoZSBmb2xsb3dpbmcgd2FybmluZ3M6Cgo+IAlBbGlnbm1lbnQg
c2hvdWxkIG1hdGNoIG9wZW4gcGFyZW50aGVzaXMKPiAJUGxlYXNlIGRvbid0IHVzZSBtdWx0aXBs
ZSBibGFuayBsaW5lcwoKSSdtIG5vdCBzdXJlIGhvdyB5b3UgaW52b2tlIGNoZWNrcGF0Y2gucGwu
CkNvdWxkIHlvdSBwbGVhc2UgdXNlIExUUCBlbWJlZGRlZCB2ZXJzaW9uIHZpYToKCiQgbWFrZSBj
aGVjay1ta25vZDAxCgpPciwgdG8gc2VlIHdoYXQgaXQgZG9lcyB1c2UgVj0xCgokIG1ha2UgY2hl
Y2stbWtub2QwMSBWPTEKCj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJi
bUBzdXNlLmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25v
ZDAxLmMgfCA1ICsrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9k
L21rbm9kMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwMS5jCj4g
aW5kZXggZmUwYTFjZmE2YTQ3M2Y5YzJiMmE1NTQ5M2Y4MzBmMTNiODY1NjBhOC4uMzllNDAyZWU0
MTJkZTM5Yzc5MjlkY2FlNjVmZGYzZTMwMmRlOWI0NSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDEuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbWtub2QvbWtub2QwMS5jCj4gQEAgLTI2LDcgKzI2LDYgQEAgc3RhdGljIGludCB0
Y2FzZXNbXSA9IHsKPiAgCVNfSUZSRUcgfCAwNjcwMCwKPiAgfTsKCj4gLQoKVGhpcyBpcyBub3Qg
cmVwb3J0ZWQgYnkgb3VyIGNoZWNrcGF0Y2gucGwgYW5kIGl0IHdvdWxkIGJlIHVzZWZ1bC4gSSdt
IG5vdCBzdXJlCmlmIHlvdSB3YW50IHRvIGJvdGhlciB0byBsb29rIHdoaWNoIGZyb20gdGhlc2Ug
LS1pZ25vcmUKQ09OU1RfU1RSVUNULFZPTEFUSUxFLFNQTElUX1NUUklORyxGSUxFX1BBVEhfQ0hB
TkdFUyBzaG91bGQgYmUgcmVtb3ZlZCAob3Igd2hpY2gKb25lIGlzIG1pc3NpbmcsIG1heWJlIG91
ciBjaGVja3BhdGNoLnBsIGlzIG91dGRhdGVkKS4KCj4gIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25l
ZCBpbnQgaSkKPiAgewo+ICAJZGV2X3QgZGV2ID0gMDsKPiBAQCAtMzUsOCArMzQsOCBAQCBzdGF0
aWMgdm9pZCBydW4odW5zaWduZWQgaW50IGkpCj4gIAkJZGV2ID0gbWFrZWRldigxLCAzKTsKCj4g
IAlUU1RfRVhQX1BBU1MobWtub2QoUEFUSCwgdGNhc2VzW2ldLCBkZXYpLAo+IC0JCQkJIm1rbm9k
KFBBVEgsICVvLCAlbGQpIiwKPiAtCQkJCXRjYXNlc1tpXSwgZGV2KTsKPiArCQkgICAgICJta25v
ZChQQVRILCAlbywgJWxkKSIsCj4gKwkJICAgICB0Y2FzZXNbaV0sIGRldik7CgpJJ20gbm90IHN1
cmUsIGlmIHRoaXMgaXMgd29ydGggdG8gZml4IChvdXIgY2hlY2twYXRjaC5wbCBzZXR1cCBkb2Vz
IG5vdCByZXBvcnQgaXQpLgoKQnV0IHdoYXQgd291bGQgYmUgd29ydGggdG8gZml4IGlzIDMyIGJp
dCBjb21wYXRpYmlsaXR5IGVycm9yIG9uIGRldl90IGRldjoKCiQgUEtHX0NPTkZJR19MSUJESVI9
L3Vzci9saWIvcGtnY29uZmlnIENGTEFHUz0tbTMyIExERkxBR1M9LW0zMiAuL2NvbmZpZ3VyZSAj
IHNlZSBJTlNUQUxMCi4uLgoKbWtub2QwMS5jOjM3OjIyOiB3YXJuaW5nOiBmb3JtYXQg4oCYJWxk
4oCZIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSDigJhsb25nIGludOKAmSwgYnV0IGFyZ3VtZW50
IDYgaGFzIHR5cGUg4oCYZGV2X3TigJkge2FrYSDigJhsb25nIGxvbmcgdW5zaWduZWQgaW504oCZ
fSBbLVdmb3JtYXQ9XQogICAzNyB8ICAgICAgICAgICAgICAgICAgICAgICJta25vZChQQVRILCAl
bywgJWxkKSIsCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fgouLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5oOjQyOjMyOiBub3RlOiBp
biBkZWZpbml0aW9uIG9mIG1hY3JvIOKAmFRTVF9GTVRf4oCZCiAgIDQyIHwgI2RlZmluZSBUU1Rf
Rk1UXyhGTVQsIF8xLCAuLi4pIEZNVCwgIyNfX1ZBX0FSR1NfXwogICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBefn4KLi4vLi4vLi4vLi4vaW5jbHVkZS90c3RfdGVzdF9tYWNy
b3MuaDo0NjoyNjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFRTVF8yX+KAmQogICA0
NiB8ICAgICAgICAgICAgICAgICBUU1RfRk1UXyhUU1RfMl8oZHVtbXksICMjX19WQV9BUkdTX18s
IFNDQUxMKSBGTVQsIF9fVkFfQVJHU19fKSkKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+Ci4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3RfbWFjcm9zLmg6MjEwOjI1OiBu
b3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYVFNUX01TR1/igJkKICAyMTAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICBUU1RfTVNHXyhUUEFTUywgIiBwYXNzZWQiLCAjU0NBTEwsICMjX19W
QV9BUkdTX18pOyAgICAgXAogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+
Cm1rbm9kMDEuYzozNjo5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYVFNUX0VYUF9Q
QVNT4oCZCiAgIDM2IHwgICAgICAgICBUU1RfRVhQX1BBU1MobWtub2QoUEFUSCwgdGNhc2VzW2ld
LCBkZXYpLAogICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+Cm1rbm9kMDEuYzozNzo0MTogbm90
ZTogZm9ybWF0IHN0cmluZyBpcyBkZWZpbmVkIGhlcmUKICAgMzcgfCAgICAgICAgICAgICAgICAg
ICAgICAibWtub2QoUEFUSCwgJW8sICVsZCkiLAogICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfn5eCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbG9uZyBpbnQKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICVsbGQKCihJdCBzaG91bGQgYmUgc29sdmVkIGJ5IFBSSXVNQVggYW5kIGNhc3RpbmcgdG8g
KHVpbnRtYXhfdCksIGJ1dCB3ZSB1c3VhbGx5IGp1c3QKY2FzdCB0byAobG9uZyBsb25nKSBhbmQg
dXNlIGp1c3QgJWxsZC4gV2hhdGV2ZXIgeW91IHByZWZlci4KCktpbmQgcmVnYXJkcywKUGV0cgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
