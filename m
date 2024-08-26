Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A80C5472E
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 18:12:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C099B3D25DC
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 20:12:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B6CC3C9AC6
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 20:12:24 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 477E21A00249
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 20:12:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FE251F8AA;
 Mon, 26 Aug 2024 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724695940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9KDrENkxUY3sD5HkXughr2j0KwYtQb7IhfDznhNo7g=;
 b=gVQ5H7evma78dGKNKUKMNHizrX36YmuQ9022ZCpxu7PkjvlYxtqDnbbh2zGDXm2JOnsSjL
 XZ6C5FByY0e+Z1OXrlmY4FnZQcnldd3EWNwFYrSpB9rU6HIpNf4nrhwX/FLITBQxA0f10Y
 sG//KU84MZ+sUK2bZv64ylwnb3bFEXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724695940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9KDrENkxUY3sD5HkXughr2j0KwYtQb7IhfDznhNo7g=;
 b=nyRDExanxp91TUIePGCtL7ECz1syAoQvpuBeUp1fYlzsqCBTaRQzcg/1zeDfAhEeqs2E75
 Kuz1BXpuM96a8LDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gVQ5H7ev;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nyRDExan
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724695940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9KDrENkxUY3sD5HkXughr2j0KwYtQb7IhfDznhNo7g=;
 b=gVQ5H7evma78dGKNKUKMNHizrX36YmuQ9022ZCpxu7PkjvlYxtqDnbbh2zGDXm2JOnsSjL
 XZ6C5FByY0e+Z1OXrlmY4FnZQcnldd3EWNwFYrSpB9rU6HIpNf4nrhwX/FLITBQxA0f10Y
 sG//KU84MZ+sUK2bZv64ylwnb3bFEXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724695940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9KDrENkxUY3sD5HkXughr2j0KwYtQb7IhfDznhNo7g=;
 b=nyRDExanxp91TUIePGCtL7ECz1syAoQvpuBeUp1fYlzsqCBTaRQzcg/1zeDfAhEeqs2E75
 Kuz1BXpuM96a8LDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 728691398D;
 Mon, 26 Aug 2024 18:12:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rFRIGoTFzGZUHwAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 26 Aug 2024 18:12:20 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Ma Xinjian <maxj.fnst@fujitsu.com>, liwang@redhat.com,
 Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Aug 2024 20:12:20 +0200
Message-ID: <2718474.fDdHjke4Dd@localhost>
Organization: SUSE
In-Reply-To: <20240819082213.2150403-1-maxj.fnst@fujitsu.com>
References: <20240819082213.2150403-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8FE251F8AA
X-Spamd-Result: default: False [-6.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; HAS_ORG_HEADER(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,opensuse.org:url];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[4];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getdents02: Add case for errno EFAULT
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uZGF5LCBBdWd1c3QgMTksIDIwMjQgMTA6MjI6MTPigK9BTSBHTVQrMiBNYSBYaW5qaWFu
IHZpYSBsdHAgd3JvdGU6Cj4gQ3VycmVudGx5IHRoZXJlIGlzIG5vIGNhc2UgZm9yIEVGQVVMVCwg
c28gYSBuZXcgY2FzZSBpcyBhZGRlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNYSBYaW5qaWFuIDxt
YXhqLmZuc3RAZnVqaXRzdS5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
Z2V0ZGVudHMvZ2V0ZGVudHMwMi5jIHwgNSArKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0
ZGVudHMvZ2V0ZGVudHMwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRkZW50cy9n
ZXRkZW50czAyLmMKPiBpbmRleCBhZGUxYzk0NzYuLjU3OGRiOWQxZSAxMDA2NDQKPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDIuYwo+ICsrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMwMi5jCj4gQEAgLTE1LDYg
KzE1LDcgQEAKPiAgICogICAtIGdldGRlbnRzKCkgZmFpbHMgd2l0aCBFSU5WQUwgaWYgcmVzdWx0
IGJ1ZmZlciBpcyB0b28gc21hbGwKPiAgICogICAtIGdldGRlbnRzKCkgZmFpbHMgd2l0aCBFTk9U
RElSIGlmIGZpbGUgZGVzY3JpcHRvciBkb2VzIG5vdCByZWZlciB0byBhIGRpcmVjdG9yeQo+ICAg
KiAgIC0gZ2V0ZGVudHMoKSBmYWlscyB3aXRoIEVOT0VOVCBpZiBkaXJlY3Rvcnkgd2FzIHVubGlu
a2VkKCkKPiArICogICAtIGdldGRlbnRzKCkgZmFpbHMgd2l0aCBFRkFVTFQgaWYgYXJndW1lbnQg
cG9pbnRzIG91dHNpZGUgdGhlIGNhbGxpbmcgcHJvY2VzcydzIGFkZHJlc3Mgc3BhY2UKPiAgICov
Cj4gIAo+ICAjZGVmaW5lIF9HTlVfU09VUkNFCj4gQEAgLTM0LDYgKzM1LDcgQEAgc3RhdGljIHNp
emVfdCBzaXplOwo+ICAKPiAgc3RhdGljIGNoYXIgZGlycDFfYXJyWzFdOwo+ICBzdGF0aWMgY2hh
ciAqZGlycDEgPSBkaXJwMV9hcnI7Cj4gK3N0YXRpYyBjaGFyICpkaXJwX2JhZDsKPiAgc3RhdGlj
IHNpemVfdCBzaXplMSA9IDE7Cj4gIAo+ICBzdGF0aWMgaW50IGZkX2ludiA9IC01Owo+IEBAIC01
MSw2ICs1Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgdGNhc2Ugewo+ICAJeyAmZmQsICZkaXJwMSwgJnNp
emUxLCBFSU5WQUwgfSwKPiAgCXsgJmZkX2ZpbGUsICZkaXJwLCAmc2l6ZSwgRU5PVERJUiB9LAo+
ICAJeyAmZmRfdW5saW5rZWQsICZkaXJwLCAmc2l6ZSwgRU5PRU5UIH0sCj4gKwl7ICZmZCwgJmRp
cnBfYmFkLCAmc2l6ZSwgRUZBVUxUIH0sCj4gIH07Cj4gIAo+ICBzdGF0aWMgdm9pZCBzZXR1cCh2
b2lkKQo+IEBAIC02Myw2ICs2Niw4IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIAlmZCA9
IFNBRkVfT1BFTigiLiIsIE9fUkRPTkxZKTsKPiAgCWZkX2ZpbGUgPSBTQUZFX09QRU4oInRlc3Qi
LCBPX0NSRUFUIHwgT19SRFdSLCAwNjQ0KTsKPiAgCj4gKwlkaXJwX2JhZCA9IHRzdF9nZXRfYmFk
X2FkZHIoTlVMTCk7Cj4gKwo+ICAJU0FGRV9NS0RJUihURVNUX0RJUiwgRElSX01PREUpOwo+ICAJ
ZmRfdW5saW5rZWQgPSBTQUZFX09QRU4oVEVTVF9ESVIsIE9fRElSRUNUT1JZKTsKPiAgCVNBRkVf
Uk1ESVIoVEVTVF9ESVIpOwo+IAoKSGksCgpJIG5vdGljZWQsIHRoaXMgbmV3IHRlc3RjYXNlIGZv
ciB2ZXJpZnlpbmcgRUZBVUxUIGlzIGZhaWxpbmcgd2l0aCAzMi1iaXQKY29tcGF0IGxheWVyIFsx
XSAgYXMgd2VsbCBhcyBvbiAzMi1iaXQgYXJjaHMgWzJdCmdldGRlbnRzKCkgLyBnZXRkZW50czY0
KCkgcmV0dXJucyBFSU5WQUwgaW5zdGVhZCBvZiBleHBlY3RlZCBFRkFVTFQsIHdoaWNoCm1lYW5z
IHRoYXQgc2l6ZSBmb3IgYnVmZmVyIGRpcnAgaXMgdG9vIHNtYWxsLgpBbmQgYnVmZmVyIHNpemUg
aXNzdWUgYWxzbyBhZmZlY3RzIG90aGVyIGVycm5vIGNhc2VzLCBidXQgd2UgbmV2ZXIgZW5jb3Vu
dGVyZWQKaXQgYXMgc3lzY2FsbCByZXR1cm5zIHRoZSBleHBlY3RlZCBlcnJubyBiZWZvcmUgaGl0
dGluZyB0aGUgc2l6ZSBpc3N1ZS4KCgpnZXRkZW50cy5oOjE0ODogVElORk86IFRlc3RpbmcgdGhl
IFNZU19nZXRkZW50cyBzeXNjYWxsCnRzdF9idWZmZXJzLmM6NTc6IFRJTkZPOiBUZXN0IGlzIHVz
aW5nIGd1YXJkZWQgYnVmZmVycwpnZXRkZW50czAyLmM6ODg6IFRQQVNTOiBnZXRkZW50cyBmYWls
ZWQgYXMgZXhwZWN0ZWQ6IEVCQURGICg5KQpnZXRkZW50czAyLmM6ODg6IFRQQVNTOiBnZXRkZW50
cyBmYWlsZWQgYXMgZXhwZWN0ZWQ6IEVJTlZBTCAoMjIpCmdldGRlbnRzMDIuYzo4ODogVFBBU1M6
IGdldGRlbnRzIGZhaWxlZCBhcyBleHBlY3RlZDogRU5PVERJUiAoMjApCmdldGRlbnRzMDIuYzo4
ODogVFBBU1M6IGdldGRlbnRzIGZhaWxlZCBhcyBleHBlY3RlZDogRU5PRU5UICgyKQpnZXRkZW50
czAyLmM6OTI6IFRGQUlMOiBnZXRkZW50cyBmYWlsZWQgdW5leHBlY3RlZGx5OiBFSU5WQUwgKDIy
KQpnZXRkZW50cy5oOjE1MTogVElORk86IFRlc3RpbmcgdGhlIFNZU19nZXRkZW50czY0IHN5c2Nh
bGwKdHN0X2J1ZmZlcnMuYzo1NzogVElORk86IFRlc3QgaXMgdXNpbmcgZ3VhcmRlZCBidWZmZXJz
CmdldGRlbnRzMDIuYzo4ODogVFBBU1M6IGdldGRlbnRzIGZhaWxlZCBhcyBleHBlY3RlZDogRUJB
REYgKDkpCmdldGRlbnRzMDIuYzo4ODogVFBBU1M6IGdldGRlbnRzIGZhaWxlZCBhcyBleHBlY3Rl
ZDogRUlOVkFMICgyMikKZ2V0ZGVudHMwMi5jOjg4OiBUUEFTUzogZ2V0ZGVudHMgZmFpbGVkIGFz
IGV4cGVjdGVkOiBFTk9URElSICgyMCkKZ2V0ZGVudHMwMi5jOjg4OiBUUEFTUzogZ2V0ZGVudHMg
ZmFpbGVkIGFzIGV4cGVjdGVkOiBFTk9FTlQgKDIpCmdldGRlbnRzMDIuYzo5MjogVEZBSUw6IGdl
dGRlbnRzIGZhaWxlZCB1bmV4cGVjdGVkbHk6IEVJTlZBTCAoMjIpCmdldGRlbnRzLmg6MTU3OiBU
Q09ORjogbGliYyBnZXRkZW50cygpIGlzIG5vdCBpbXBsZW1lbnRlZApnZXRkZW50cy5oOjE2Mjog
VElORk86IFRlc3RpbmcgbGliYyBnZXRkZW50czY0KCkKdHN0X2J1ZmZlcnMuYzo1NzogVElORk86
IFRlc3QgaXMgdXNpbmcgZ3VhcmRlZCBidWZmZXJzCmdldGRlbnRzMDIuYzo4ODogVFBBU1M6IGdl
dGRlbnRzIGZhaWxlZCBhcyBleHBlY3RlZDogRUJBREYgKDkpCmdldGRlbnRzMDIuYzo4ODogVFBB
U1M6IGdldGRlbnRzIGZhaWxlZCBhcyBleHBlY3RlZDogRUlOVkFMICgyMikKZ2V0ZGVudHMwMi5j
Ojg4OiBUUEFTUzogZ2V0ZGVudHMgZmFpbGVkIGFzIGV4cGVjdGVkOiBFTk9URElSICgyMCkKZ2V0
ZGVudHMwMi5jOjg4OiBUUEFTUzogZ2V0ZGVudHMgZmFpbGVkIGFzIGV4cGVjdGVkOiBFTk9FTlQg
KDIpCmdldGRlbnRzMDIuYzo4ODogVFBBU1M6IGdldGRlbnRzIGZhaWxlZCBhcyBleHBlY3RlZDog
RUZBVUxUICgxNCkKCgpbMV0gaHR0cHM6Ly9vcGVucWEub3BlbnN1c2Uub3JnL3Rlc3RzLzQ0MzI3
NTYjc3RlcC9nZXRkZW50czAyLzgKWzJdIGh0dHBzOi8vb3BlbnFhLm9wZW5zdXNlLm9yZy90ZXN0
cy80NDMxOTU3I3N0ZXAvZ2V0ZGVudHMwMi84CgoKUmVnYXJkcywKQXZpbmVzaAoKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
