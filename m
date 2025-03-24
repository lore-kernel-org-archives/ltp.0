Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A66DC36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 23:01:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 406853C98B2
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 00:01:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BCC43C93B8
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 00:01:09 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 97A072001C0
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 00:01:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 304171F391;
 Mon, 24 Mar 2025 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742857267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xqHehvxVyrSZML/2aBDHxHV6HdJ7pp4IVrt6vbMzzY=;
 b=oV/47jb/tgQyel3tvts8gNTK98hCiPvJGw39m0Gq9oz2h1PdpbGvxIzKmSi9zAtmSMoHN7
 DsSKExeNMa1TnqZAoVbkKk2XO4mOS+slE+7Y+yajgfP1FaIj5OemDlG+3In+h5gl1ikZAe
 6pt6M+bHVFC9v51Wm2BDkb2z4mjwvEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742857267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xqHehvxVyrSZML/2aBDHxHV6HdJ7pp4IVrt6vbMzzY=;
 b=zlbFHfeElmTF5xH9dfNG0vSpGd514wuLEnhATmk6766cnMGP6OYObtJ0qJDbXdfatMdPmE
 QUJzAvc/LjxuGtCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="oV/47jb/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zlbFHfeE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742857267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xqHehvxVyrSZML/2aBDHxHV6HdJ7pp4IVrt6vbMzzY=;
 b=oV/47jb/tgQyel3tvts8gNTK98hCiPvJGw39m0Gq9oz2h1PdpbGvxIzKmSi9zAtmSMoHN7
 DsSKExeNMa1TnqZAoVbkKk2XO4mOS+slE+7Y+yajgfP1FaIj5OemDlG+3In+h5gl1ikZAe
 6pt6M+bHVFC9v51Wm2BDkb2z4mjwvEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742857267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xqHehvxVyrSZML/2aBDHxHV6HdJ7pp4IVrt6vbMzzY=;
 b=zlbFHfeElmTF5xH9dfNG0vSpGd514wuLEnhATmk6766cnMGP6OYObtJ0qJDbXdfatMdPmE
 QUJzAvc/LjxuGtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 127EA137AC;
 Mon, 24 Mar 2025 23:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gpGXADPk4WeDYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 24 Mar 2025 23:01:07 +0000
Date: Tue, 25 Mar 2025 00:01:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250324230105.GA272772@pevik>
References: <20250314124242.459072-1-pvorel@suse.cz>
 <CAEemH2ejo61V9v=BXRt+cVL-roNLFuyKpY2MC_dYW+iJJ3ZrAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ejo61V9v=BXRt+cVL-roNLFuyKpY2MC_dYW+iJJ3ZrAQ@mail.gmail.com>
X-Rspamd-Queue-Id: 304171F391
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima_violations.sh: Fix condition evaluation
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgo+IE9uIEZyaSwgTWFyIDE0LCAyMDI1IGF0IDg6NDPigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gRXZhbHVhdGlvbiAiLWd0IDAiIG5lZWRzIHRvIGJl
IHRvZ2V0aGVyIHdpdGggZXhwZWN0YXRpb24gb2YgZW1wdHkKPiA+ICRleHBlY3RlZF92aW9sYXRp
b25zLiBUaGVyZWZvcmUgdXNlIFsgLi4uIC1hIC4uLiBdIGNvbXBhcmF0b3IgdG8gYXZvaWQKPiA+
IC1lcSBjb21wYXJpc29uIGFnYWluc3QgZW1wdHkgJGV4cGVjdGVkX3Zpb2xhdGlvbnMuCgo+ID4g
ICAgICMgTFRQUk9PVD0vb3B0L2x0cCBQQVRIPSIvb3B0L2x0cC90ZXN0Y2FzZXMvYmluOiRQQVRI
Igo+ID4gTFRQX0lNQV9MT0FEX1BPTElDWT0xIGltYV9rZXlzLnNoCj4gPiAgICAgaW1hX2tleXMg
MSBUSU5GTzogL3Byb2MvY21kbGluZToKPiA+IEJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51ei02LjE0
LjAtcmMzLTEuZ2I2YjQxMDItZGVmYXVsdCBzZWN1cml0eT1hcHBhcm1vcgo+ID4gaWdub3JlX2xv
Z2xldmVsIGltYV9wb2xpY3k9dGNiCgo+ID4gICAgICMgTFRQUk9PVD0vb3B0L2x0cCBQQVRIPSIv
b3B0L2x0cC90ZXN0Y2FzZXMvYmluOiRQQVRIIgo+ID4gaW1hX3Zpb2xhdGlvbnMuc2gKPiA+ICAg
ICAuLi4KPiA+ICAgICAvb3B0L2x0cC90ZXN0Y2FzZXMvYmluL2ltYV92aW9sYXRpb25zLnNoOiBs
aW5lIDk1OiBbOiAwOiB1bmFyeQo+ID4gb3BlcmF0b3IgZXhwZWN0ZWQKPiA+ICAgICBpbWFfdmlv
bGF0aW9ucyAxIFRGQUlMOiBvcGVuX3dyaXRlcnMgdmlvbGF0aW9uIG5vdCBhZGRlZAo+ID4gICAg
IGltYV92aW9sYXRpb25zIDIgVElORk86IHZlcmlmeSBUb01Ub1UgdmlvbGF0aW9uCj4gPiAgICAg
L29wdC9sdHAvdGVzdGNhc2VzL2Jpbi9pbWFfdmlvbGF0aW9ucy5zaDogbGluZSA5NTogWzogMDog
dW5hcnkKPiA+IG9wZXJhdG9yIGV4cGVjdGVkCj4gPiAgICAgaW1hX3Zpb2xhdGlvbnMgMiBURkFJ
TDogVG9NVG9VIHZpb2xhdGlvbiBub3QgYWRkZWQKPiA+ICAgICBpbWFfdmlvbGF0aW9ucyAzIFRJ
TkZPOiB2ZXJpZnkgb3Blbl93cml0ZXJzIHVzaW5nIG1tYXBwZWQgZmlsZXMKPiA+ICAgICB0c3Rf
dGVzdC5jOjE5MDA6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTAxMzAtMjItZ2NkMjIxNTcwMmYK
PiA+ICAgICB0c3RfdGVzdC5jOjE5MDQ6IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA2LjE0LjAtcmMz
LTEuZ2I2YjQxMDItZGVmYXVsdAo+ID4gIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBUaHUgRmViIDIw
IDEyOjI2OjU1IFVUQyAyMDI1IChiNmI0MTAyKSB4ODZfNjQKPiA+ICAgICB0c3Rfa2NvbmZpZy5j
Ojg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4gPiAg
ICAgdHN0X2tjb25maWcuYzo2NzY6IFRJTkZPOiBDT05GSUdfRkFVTFRfSU5KRUNUSU9OIGtlcm5l
bCBvcHRpb24KPiA+IGRldGVjdGVkIHdoaWNoIG1pZ2h0IHNsb3cgdGhlIGV4ZWN1dGlvbgo+ID4g
ICAgIHRzdF90ZXN0LmM6MTcyMjogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlzIDBo
IDAybSAwMHMKPiA+ICAgICBpbWFfbW1hcC5jOjM4OiBUSU5GTzogc2xlZXAgM3MKPiA+ICAgICAv
b3B0L2x0cC90ZXN0Y2FzZXMvYmluL2ltYV92aW9sYXRpb25zLnNoOiBsaW5lIDk1OiBbOiAwOiB1
bmFyeQo+ID4gb3BlcmF0b3IgZXhwZWN0ZWQKPiA+ICAgICBpbWFfdmlvbGF0aW9ucyAzIFRGQUlM
OiBvcGVuX3dyaXRlcnMgdmlvbGF0aW9uIG5vdCBhZGRlZAoKPiA+IE5PVEU6IFRoaXMgZG9lcyBu
b3QgZml4IGltYV92aW9sYXRpb25zLnNoIGZhaWxzIGFmdGVyIGNhdXNlZCBieSB1c2VyCj4gPiBk
ZWZpbmVkIHBvbGljeSBsb2FkZWQgYnkgaW1hX2tleXMuc2ggKHZpYSBMVFBfSU1BX0xPQURfUE9M
SUNZPTEpLgoKPiA+IEZpeGVzOiA3MjZlZDcxOTA1ICgiaW1hX3Zpb2xhdGlvbnMuc2g6IFVwZGF0
ZSB2YWxpZGF0ZSgpIHRvIHN1cHBvcnQKPiA+IG11bHRpcGxlIHZpb2xhdGlvbnMiKQo+ID4gU2ln
bmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgoKPiBSZXZpZXdlZC1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cgp0aGFua3MgZm9yIHlvdXIgcmV2aWV3LCBtZXJn
ZWQhCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gLS0tCj4gPiAgLi4uL2tlcm5lbC9zZWN1cml0eS9p
bnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV92aW9sYXRpb25zLnNoICAgICAgfCAzICstLQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCj4gPiBkaWZmIC0t
Z2l0Cj4gPiBhL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9p
bWFfdmlvbGF0aW9ucy5zaAo+ID4gYi90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvdGVzdHMvaW1hX3Zpb2xhdGlvbnMuc2gKPiA+IGluZGV4IDYzMzQ2ZTk0ODkuLmM2Yjky
OWEyMzMgMTAwNzU1Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvdGVzdHMvaW1hX3Zpb2xhdGlvbnMuc2gKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFfdmlvbGF0aW9ucy5zaAo+ID4gQEAgLTkw
LDggKzkwLDcgQEAgdmFsaWRhdGUoKQo+ID4gICAgICAgICBmb3IgaSBpbiAkKHNlcSAxICRtYXhf
YXR0ZW1wdCk7IGRvCj4gPiAgICAgICAgICAgICAgICAgcmVhZCBudW1fdmlvbGF0aW9uc19uZXcg
PCAkSU1BX1ZJT0xBVElPTlMKPiA+ICAgICAgICAgICAgICAgICBjb3VudDI9IiQoZ2V0X2NvdW50
ICRzZWFyY2gpIgo+ID4gLSAgICAgICAgICAgICAgIGlmIFsgLXogIiRleHBlY3RlZF92aW9sYXRp
b25zIiBdICYmIFwKPiA+IC0gICAgICAgICAgICAgICAgICBbICQoKCRudW1fdmlvbGF0aW9uc19u
ZXcgLSAkbnVtX3Zpb2xhdGlvbnMpKSAtZ3QgMCBdIHx8Cj4gPiBcCj4gPiArICAgICAgICAgICAg
ICAgaWYgWyAteiAiJGV4cGVjdGVkX3Zpb2xhdGlvbnMiIC1hICQoKCRudW1fdmlvbGF0aW9uc19u
ZXcgLQo+ID4gJG51bV92aW9sYXRpb25zKSkgLWd0IDAgXSB8fCBcCj4gPiAgICAgICAgICAgICAg
ICAgICAgWyAkKCgkbnVtX3Zpb2xhdGlvbnNfbmV3IC0gJG51bV92aW9sYXRpb25zKSkgLWVxCj4g
PiAkZXhwZWN0ZWRfdmlvbGF0aW9ucyBdOyB0aGVuCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICBbIC16ICIkZXhwZWN0ZWRfdmlvbGF0aW9ucyIgXSAmJgo+ID4gZXhwZWN0ZWRfdmlvbGF0aW9u
cz0xCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiBbICRjb3VudDIgLWd0ICRjb3VudCBd
OyB0aGVuCj4gPiAtLQo+ID4gMi40Ny4yCgoKPiA+IC0tCj4gPiBNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
