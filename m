Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1D7C27C79
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 17:33:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A8B83D0DE2
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 19:33:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2572A3CF731
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 19:33:32 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7A4A56068D6
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 19:33:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0656421A28;
 Wed, 19 Jun 2024 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718818409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEAcc5fI3DOIR7PywStDOYW2rJNbFHAep1/F8fna07o=;
 b=17PFQgF4i3aazWqDNL7g3kMLkqJFNEl+udKopJ9WCOifXZM4ft/acIBhjuwD2OfxW46G0L
 muQP/mfQLiPwIEVjGDhZJBX87LIw7mI2eJYhkze4B3PYfoWrLWAlfRjWeDv/VzVM23Uunf
 cQYIY3vhsRMO4iF/nNQq6R+SJexRaSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718818409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEAcc5fI3DOIR7PywStDOYW2rJNbFHAep1/F8fna07o=;
 b=jEK9TtWPeMdoZznUIMy+95NUpMdxrtDvjLUugDSy0187LPdvQi9167dwRibZdQPGfGFZSc
 ayghp/6tvZqxsMAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=17PFQgF4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jEK9TtWP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718818409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEAcc5fI3DOIR7PywStDOYW2rJNbFHAep1/F8fna07o=;
 b=17PFQgF4i3aazWqDNL7g3kMLkqJFNEl+udKopJ9WCOifXZM4ft/acIBhjuwD2OfxW46G0L
 muQP/mfQLiPwIEVjGDhZJBX87LIw7mI2eJYhkze4B3PYfoWrLWAlfRjWeDv/VzVM23Uunf
 cQYIY3vhsRMO4iF/nNQq6R+SJexRaSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718818409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEAcc5fI3DOIR7PywStDOYW2rJNbFHAep1/F8fna07o=;
 b=jEK9TtWPeMdoZznUIMy+95NUpMdxrtDvjLUugDSy0187LPdvQi9167dwRibZdQPGfGFZSc
 ayghp/6tvZqxsMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10DC913668;
 Wed, 19 Jun 2024 17:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aPznOmcWc2aqSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jun 2024 17:33:27 +0000
Date: Wed, 19 Jun 2024 19:33:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Message-ID: <20240619173324.GA504021@pevik>
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <ZnFeWJJldj_ggKnq@yuki>
 <OS3PR01MB639110A9BC48CA10A9D97FEC92CF2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OS3PR01MB639110A9BC48CA10A9D97FEC92CF2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 TO_DN_NONE(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0656421A28
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
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
Cc: linux-arm-kernel@lists.infradead.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSwKCj4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4KCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+ID4gRnJvbTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4gPiBTZW50
OiBUdWVzZGF5LCBKdW5lIDE4LCAyMDI0IDc6MTYgUE0KPiA+IFRvOiBpd2FtYXRzdSBub2J1aGly
byjlsqnmnb4g5L+h5rSLIOKXi++8pO+8qe+8tO+8o+KWoe+8pO+8qe+8tOKXi++8r++8s++8tCkK
PiA+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4KPiA+IENjOiBsdHBAbGlzdHMu
bGludXguaXQKPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGxpYjogdHN0X2ZkOiBBZGQga2VybmVs
IHZlcnNpb24gY2hlY2sgdG8gbWVtZmRfc2VjcmV0Cgo+ID4gSGkhCj4gPiA+IG1lbWZkX3NlY3Jl
dCBpcyBhIHN5c2NhbGwgYWRkZWQgc2luY2UgNS4xNC4gT24gZWFybGllciBrZXJuZWxzLCB0ZXN0
cwo+ID4gPiBzdWNoIGFzIGFjY2VwdDAzLCByZWFkYWhlYWQwMSBhbmQgc3BsaWNlMDcgdGhhdCB1
c2UgbWVtZmRfc2VjcmV0IGZhaWwuCj4gPiA+IFRoaXMgYWRkcyBhIGtlcm5lbCB2ZXJzaW9uIGNo
ZWNrIHRvIHRoZSB0c3RfZmQgbGlicmFyeSB3aGVuIHJ1bm5pbmcKPiA+ID4gdGVzdHMgdXNpbmcg
bWVtZmRfc2VjcmV0LgoKPiA+ID4gVGVzdCBsb2cgb24gbGludXgtNS4xMC4xNjIvYXJtMzIgd2l0
aCB2ZXJzaW9uIDIwMjQwNTI0Ogo+ID4gPiBgYGAKPiA+ID4gJCAuL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvYWNjZXB0L2FjY2VwdDAzCj4gPiA+IHRzdF90ZXN0LmM6MTczMzogVElORk86IExU
UCB2ZXJzaW9uOiAyMDI0MDUyNAo+ID4gPiB0c3RfdGVzdC5jOjE2MTc6IFRJTkZPOiBUaW1lb3V0
IHBlciBydW4gaXMgMGggMDBtIDMwcwo+ID4gPiBhY2NlcHQwMy5jOjU4OiBUUEFTUzogYWNjZXB0
KCkgb24gZmlsZSA6IEVOT1RTT0NLICg4OCkKPiA+ID4gYWNjZXB0MDMuYzo1ODogVFBBU1M6IGFj
Y2VwdCgpIG9uIE9fUEFUSCBmaWxlIDogRUJBREYgKDkpCj4gPiA+IGFjY2VwdDAzLmM6NTg6IFRQ
QVNTOiBhY2NlcHQoKSBvbiBkaXJlY3RvcnkgOiBFTk9UU09DSyAoODgpCj4gPiA+IGFjY2VwdDAz
LmM6NTg6IFRQQVNTOiBhY2NlcHQoKSBvbiAvZGV2L3plcm8gOiBFTk9UU09DSyAoODgpCj4gPiA+
IGFjY2VwdDAzLmM6NTg6IFRQQVNTOiBhY2NlcHQoKSBvbiAvcHJvYy9zZWxmL21hcHMgOiBFTk9U
U09DSyAoODgpCj4gPiA+IGFjY2VwdDAzLmM6NTg6IFRQQVNTOiBhY2NlcHQoKSBvbiBwaXBlIHJl
YWQgZW5kIDogRU5PVFNPQ0sgKDg4KQo+ID4gPiBhY2NlcHQwMy5jOjU4OiBUUEFTUzogYWNjZXB0
KCkgb24gcGlwZSB3cml0ZSBlbmQgOiBFTk9UU09DSyAoODgpCj4gPiA+IGFjY2VwdDAzLmM6NTg6
IFRQQVNTOiBhY2NlcHQoKSBvbiBlcG9sbCA6IEVOT1RTT0NLICg4OCkKPiA+ID4gYWNjZXB0MDMu
Yzo1ODogVFBBU1M6IGFjY2VwdCgpIG9uIGV2ZW50ZmQgOiBFTk9UU09DSyAoODgpCj4gPiA+IGFj
Y2VwdDAzLmM6NTg6IFRQQVNTOiBhY2NlcHQoKSBvbiBzaWduYWxmZCA6IEVOT1RTT0NLICg4OCkK
PiA+ID4gYWNjZXB0MDMuYzo1ODogVFBBU1M6IGFjY2VwdCgpIG9uIHRpbWVyZmQgOiBFTk9UU09D
SyAoODgpCj4gPiA+IGFjY2VwdDAzLmM6NTg6IFRQQVNTOiBhY2NlcHQoKSBvbiBwaWRmZCA6IEVO
T1RTT0NLICg4OCkKPiA+ID4gdHN0X2ZkLmM6MTUxOiBUQ09ORjogU2tpcHBpbmcgZmFub3RpZnk6
IEVOT1NZUyAoMzgpCj4gPiA+IGFjY2VwdDAzLmM6NTg6IFRQQVNTOiBhY2NlcHQoKSBvbiBpbm90
aWZ5IDogRU5PVFNPQ0sgKDg4KQo+ID4gPiB0c3RfZmQuYzoxNzA6IFRDT05GOiBTa2lwcGluZyB1
c2VyZmF1bHRmZDogRU5PU1lTICgzOCkKPiA+ID4gYWNjZXB0MDMuYzo1ODogVFBBU1M6IGFjY2Vw
dCgpIG9uIHBlcmYgZXZlbnQgOiBFTk9UU09DSyAoODgpCj4gPiA+IGFjY2VwdDAzLmM6NTg6IFRQ
QVNTOiBhY2NlcHQoKSBvbiBpbyB1cmluZyA6IEVOT1RTT0NLICg4OCkKPiA+ID4gYWNjZXB0MDMu
Yzo1ODogVFBBU1M6IGFjY2VwdCgpIG9uIGJwZiBtYXAgOiBFTk9UU09DSyAoODgpCj4gPiA+IGFj
Y2VwdDAzLmM6NTg6IFRQQVNTOiBhY2NlcHQoKSBvbiBmc29wZW4gOiBFTk9UU09DSyAoODgpCj4g
PiA+IGFjY2VwdDAzLmM6NTg6IFRQQVNTOiBhY2NlcHQoKSBvbiBmc3BpY2sgOiBFTk9UU09DSyAo
ODgpCj4gPiA+IGFjY2VwdDAzLmM6NTg6IFRQQVNTOiBhY2NlcHQoKSBvbiBvcGVuX3RyZWUgOiBF
QkFERiAoOSkKPiA+ID4gYWNjZXB0MDMuYzo1ODogVFBBU1M6IGFjY2VwdCgpIG9uIG1lbWZkIDog
RU5PVFNPQ0sgKDg4KQo+ID4gPiB0c3RfdGVzdC5jOjE2Nzc6IFRCUk9LOiBUZXN0IGtpbGxlZCBi
eSBTSUdJTEwhCgo+ID4gVGhpcyBsb29rcyBsaWtlIGEgYnVnIGVpdGhlciBpbiBrZXJuZWwgb3Ig
bGliYy4KCj4gVGhpcyBpcyBjYXVzZWQgYnkgX19OUl9tZW1mZF9zZWN1cmUgYmVpbmcgZGVmaW5l
ZCBhcyAtMSAoMHhmZmZmZmZmZilhbmQgIklsbGVnYWwgaW5zdHJ1Y3Rpb24iIAo+IG9jY3VycyB3
aGVuIHN5c2NhbGwoKSBpcyBleGVjdXRlZC4gQW5kIHRoaXMgcHJvYmxlbSBkb2VzIG5vdCBvY2N1
ciBvbiB4ODZfNjQuIAo+IEkgY2Fubm90IGRlY2lkZSBpZiB0aGlzIGlzIGEgYnVnIG9yIG5vdC4g
SSBjYW4ndCBkZWNpZGUgaWYgdGhpcyBpcyBhIGJ1ZyBvciBub3QsIGJlY2F1c2UgdGhpcyBiZWhh
dmlvciBoYXMKPiBleGlzdGVkIGZvciBhIGxvbmcgdGltZS4KCkludGVyZXN0aW5nLiBCdXQgaXQn
ZCBiZSBnb29kIHRvIGRpc2N1c3MgaXQsIHJpZ2h0PyBJbiBjYXNlIHRoZXJlIGlzIHNvbWV0aGlu
Zwp0byBpbXByb3ZlLiBDYyBsaW51eC1hcm0ta2VybmVsIE1MLgoKPiA+ID4gU3VtbWFyeToKPiA+
ID4gcGFzc2VkICAgMjAKPiA+ID4gZmFpbGVkICAgMAo+ID4gPiBicm9rZW4gICAxCj4gPiA+IHNr
aXBwZWQgIDIKPiA+ID4gd2FybmluZ3MgMAo+ID4gPiBgYGAKCj4gPiA+IENsb3NlZDogIzExNDUK
PiA+ID4gU2lnbmVkLW9mZi1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwPgo+ID4gPiAtLS0KPiA+ID4gIGxpYi90c3RfZmQuYyB8IDggKysrKysr
KysKPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCj4gPiA+IGRpZmYgLS1n
aXQgYS9saWIvdHN0X2ZkLmMgYi9saWIvdHN0X2ZkLmMgaW5kZXggNjUzOGEwOThjLi41M2Y1ODNm
YTAKPiA+ID4gMTAwNjQ0Cj4gPiA+IC0tLSBhL2xpYi90c3RfZmQuYwo+ID4gPiArKysgYi9saWIv
dHN0X2ZkLmMKPiA+ID4gQEAgLTI1NSw4ICsyNTUsMTYgQEAgc3RhdGljIHZvaWQgb3Blbl9tZW1m
ZChzdHJ1Y3QgdHN0X2ZkICpmZCkKCj4gPiA+ICBzdGF0aWMgdm9pZCBvcGVuX21lbWZkX3NlY3Jl
dChzdHJ1Y3QgdHN0X2ZkICpmZCkgIHsKPiA+ID4gKwlpZiAoKHRzdF9rdmVyY21wKDUsIDE0LCAw
KSkgPCAwKSB7Cj4gPiA+ICsJCXRzdF9yZXMoVElORk8sICJhY2NlcHQoKSBvbiAlczogTGludXgg
a2VybmVsIHZlcnNpb24gaXMgYmVmb3JlCj4gPiB0aGFuIHY1LjE0IiwgdHN0X2ZkX2Rlc2MoZmQp
KTsKCgo+ID4gPiArCQllcnJubyA9IEVOT1NZUzsKPiA+ID4gKwkJZ290byBza2lwOwo+ID4gPiAr
CX0KPiA+ID4gKwo+ID4gPiAgCWZkLT5mZCA9IHN5c2NhbGwoX19OUl9tZW1mZF9zZWNyZXQsIDAp
Owo+ID4gPiArCj4gPiA+ICAJaWYgKGZkLT5mZCA8IDApIHsKPiA+ID4gK3NraXA6Cj4gPiA+ICAJ
CXRzdF9yZXMoVENPTkYgfCBURVJSTk8sCj4gPiA+ICAJCQkiU2tpcHBpbmcgJXMiLCB0c3RfZmRf
ZGVzYyhmZCkpOwo+ID4gPiAgCX0KCj4gPiBBbmQgdGhpcyBsb29rcyBsaWtlIHlvdSBhcmUgd29y
a2luZyBhcm91bmQgdGhlIGJ1Zy4KCj4gWW91ciBwb2ludCBpcyBjb3JyZWN0Li4uCj4gSSB3b3Vs
ZCBzdWdnZXN0IHVzaW5nIHRzdF9zeXNjYWxsKCkgdG8gY2hlY2sgZm9yIHN5c2NhbGwgdW5kZWZp
bmVkIGluc3RlYWQKCldlbGwsIEkgZ3Vlc3Mgd2UgZG9uJ3Qgd2FudCB0byB1c2UgdHN0X3N5c2Nh
bGwoKSBvdGhlcndpc2UgaXQgd291bGQgY2FsbAp0c3RfYnJrKCkuIEkgcHJvcG9zZWQgc2ltaWxh
ciBwYXRjaCBzb21lIHRpbWUgYWdvIFsxXSwgSSBzdXBwb3NlIHlvdSB0b2xkIG1lCnByaXZhdGVs
eSBleGFjdGx5IHRoaXMuCgpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0
L2x0cC9wYXRjaC8yMDI0MDEyNDE0MjEwOC4zMDM3ODItMS1wdm9yZWxAc3VzZS5jei8KCj4gb2Yg
dGhpcyBtb2RpZmljYXRpb24uIEhvdyBhYm91dCB0aGlzIG1vZGlmaWNhdGlvbj8gCgo+IGBgYAo+
IC0tLSBhL2xpYi90c3RfZmQuYwo+ICsrKyBiL2xpYi90c3RfZmQuYwo+IEBAIC0yNTUsNyArMjU1
LDggQEAgc3RhdGljIHZvaWQgb3Blbl9tZW1mZChzdHJ1Y3QgdHN0X2ZkICpmZCkKCj4gIHN0YXRp
YyB2b2lkIG9wZW5fbWVtZmRfc2VjcmV0KHN0cnVjdCB0c3RfZmQgKmZkKQo+ICB7Cj4gLSAgICAg
ICBmZC0+ZmQgPSBzeXNjYWxsKF9fTlJfbWVtZmRfc2VjcmV0LCAwKTsKPiArICAgICAgIGZkLT5m
ZCA9IHRzdF9zeXNjYWxsKF9fTlJfbWVtZmRfc2VjcmV0LCAwKTsKPiAgICAgICAgIGlmIChmZC0+
ZmQgPCAwKSB7Cj4gICAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYgfCBURVJSTk8sCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIlNraXBwaW5nICVzIiwgdHN0X2ZkX2Rlc2MoZmQpKTsKCgpU
aGVyZWZvcmUgaG93IGFib3V0IHRoaXM/CgoJaWYgKCh0c3Rfa3ZlcmNtcCg1LCAxNCwgMCkpIDwg
MCkgewoJCXRzdF9yZXMoVENPTkYsICJhY2NlcHQoKSBvbiAlczogc2tpcHBpbmcgZHVlIG9sZCBr
ZXJuZWwiLCB0c3RfZmRfZGVzYyhmZCkpOwoJCXJldHVybjsKCX0KCktpbmQgcmVnYXJkcywKUGV0
cgoKPiBCZXN0IHJlZ2FyZHMsCj4gICBOb2J1aGlybwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
