Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74014C36008
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 07:38:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D20C3CAFC4
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 09:38:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50A3A3C7C2C
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:38:34 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2A91F600280
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:38:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8FF05211C6;
 Tue,  1 Apr 2025 07:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743493111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uq3ROrGGcHzIlDtPabv49uJ5Q3GHUvil71XXnh9/Ynk=;
 b=Au7aw9PRHEDgKVAiKfyz7RqMi446+HFewQWu/Bn5+8HVvQxXxmEsfuUchKe6QHsp95iaAc
 dHmex0d9ttMFHd5TVbIrC3aa4wlQOHcgRGbQR2j7/l2mq8OUCUth3Lg0OsoG9suX193k6D
 108mZ0YvDriNc6I3IP997mIAi9uEpvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743493111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uq3ROrGGcHzIlDtPabv49uJ5Q3GHUvil71XXnh9/Ynk=;
 b=fHU7G7eQy1zcKMIiid4WAQ3rmzA5m+psK9wR1Gy8hxDetGhjXpCYwiG4U4EMeTm+rJTP4I
 CXQmhyuFMU8oF0Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743493111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uq3ROrGGcHzIlDtPabv49uJ5Q3GHUvil71XXnh9/Ynk=;
 b=Au7aw9PRHEDgKVAiKfyz7RqMi446+HFewQWu/Bn5+8HVvQxXxmEsfuUchKe6QHsp95iaAc
 dHmex0d9ttMFHd5TVbIrC3aa4wlQOHcgRGbQR2j7/l2mq8OUCUth3Lg0OsoG9suX193k6D
 108mZ0YvDriNc6I3IP997mIAi9uEpvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743493111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uq3ROrGGcHzIlDtPabv49uJ5Q3GHUvil71XXnh9/Ynk=;
 b=fHU7G7eQy1zcKMIiid4WAQ3rmzA5m+psK9wR1Gy8hxDetGhjXpCYwiG4U4EMeTm+rJTP4I
 CXQmhyuFMU8oF0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75668138A5;
 Tue,  1 Apr 2025 07:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TnnAG/eX62d7WAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 07:38:31 +0000
Date: Tue, 1 Apr 2025 09:38:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: rbm@suse.com
Message-ID: <20250401073830.GD299271@pevik>
References: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
 <20250327-fix_make_clean-v1-2-8b9ed2a8d96a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250327-fix_make_clean-v1-2-8b9ed2a8d96a@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] openposix: Makefile: Add the standard
 "maintainer-clean" target
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

SGkgUmljYXJkbywKCj4gVGhlIGluY2x1ZGUvbWsvYXV0b21ha2UubWsgZmlsZSBkZWZpbmUgdGhl
IHN0YW5kYXJkICJtYWludGFpbmVyLWNsZWFuIiBhbmQKPiAiYWMtbWFpbnRhaW5lci1jbGVhbiIg
dGFyZ2V0cyBhbmQgdGhlcmVpbiBpdCBjYWxscyB0aGUgc2FtZSB0YXJnZXRzIHVuZGVyCj4gZWFj
aCBBVVRPQ09ORkVEX1NVQkRJUlMsIGJ1dCBpbiB0aGUgY2FzZSBvZiB0aGUgb3BlbnBvc2l4IHRl
c3Qgc3VpdGUsIHRoZXkKPiBkb24ndCBleGlzdC4gQWRkIHRoZW0gYW5kIGFsc28gcmVtb3ZlIHNv
bWUgZGFuZ2xpbmcgZmlsZXMgaW4gYWMtY2xlYW4uCgo+IFRoaXMgZml4ZXMgdGhlIGZvbGxvd2lu
ZyBlcnJvciB3aGVuIGNhbGxpbmcgYG1ha2UgbWFpbnRhaW5lci1jbGVhbmAgZnJvbQo+IHRoZSBw
cm9qZWN0J3MgdG9wIGxldmVsIGRpcmVjdG9yeToKCj4gbWFrZVsxXTogRW50ZXJpbmcgZGlyZWN0
b3J5ICcuL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZScKPiBtYWtlWzFdOiAqKiogTm8g
cnVsZSB0byBtYWtlIHRhcmdldCAnYWMtbWFpbnRhaW5lci1jbGVhbicuICBTdG9wLgo+IG1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5ICcuL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZScK
PiBtYWtlOiAqKiogWy4vaW5jbHVkZS9tay9hdXRvbWFrZS5tazo2ODogYWMtbWFpbnRhaW5lci1j
bGVhbl0gRXJyb3IgMgoKUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoK
VGhhbmtzIGZvciBmaXhpbmcgZGFyayBjb3JuZXJzIG9mIExUUCBidWlsZCBzeXN0ZW0uCgpXaGF0
IGEgc3RyYW5nZSB0YXJnZXQgbmFtZS4gT2J2aW91c2x5IGl0IHdhcyBtZWFudCB0byBiZSBydW4g
YmVmb3JlIHJlbGVhc2UKZmlsZSwgYnV0IGl0IHdhcyBub3QgZXZlbiBjYWxsZWQgaW4gTWFrZWZp
bGUucmVsZWFzZSB3aGljaCBJIHJlbW92ZWQgaW4KMTA4OGQ5M2Q5OS4KCkkgd2FzIHRoaW5raW5n
IHdoZXRoZXIgd2UgcmVhbGx5IG5lZWQgdGhpcyB0YXJnZXQuIE1heWJlIGl0IGNvdWxkIGJlIHBh
cnQgb2YKZGlzdGNsZWFuLgoKS2luZCByZWdhcmRzLApQZXRyCgo+IFNpZ25lZC1vZmYtYnk6IFJp
Y2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9vcGVu
X3Bvc2l4X3Rlc3RzdWl0ZS9NYWtlZmlsZSB8IDEwICsrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL01ha2VmaWxlIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhf
dGVzdHN1aXRlL01ha2VmaWxlCj4gaW5kZXggOGI0YzhjMGEyNGI4MzNmYTBmYjIxY2UzZTI1MzYy
OWYzNThmMTgwMC4uYzBjY2Q0OTliOGI5YzkzZTQ1MTMzZjViM2YxODllZGE3ZDA5YmViMyAxMDA2
NDQKPiAtLS0gYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvTWFrZWZpbGUKPiArKysg
Yi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvTWFrZWZpbGUKPiBAQCAtMzEsMTEgKzMx
LDE2IEBAIEFVVE9HRU5FUkFURURfRklMRVMgPSBpbmNsdWRlL21rL2NvbmZpZy5tawoKPiAgLlBI
T05ZOiBhYy1jbGVhbgo+ICBhYy1jbGVhbjogY2xlYW4KPiArCSQoUk0pIC1yZiBhdXRvbTR0ZS5j
YWNoZQo+ICsJJChSTSkgLWYgY29uZmlnLmxvZyBjb25maWcuc3RhdHVzCj4gKwo+ICsuUEhPTkU6
IGFjLW1haW50YWluZXItY2xlYW4KPiArYWMtbWFpbnRhaW5lci1jbGVhbjoKPiArCSQoUk0pIC1m
IGNvbmZpZ3VyZQoKPiAgLlBIT05ZOiBjbGVhbgo+ICBjbGVhbjoKPiAgCSQoUk0pIC1mICQoTE9H
RklMRSkqCj4gLQkkKFJNKSAtZiBjb25maWcubG9nIGNvbmZpZy5zdGF0dXMKPiAgCUBmb3IgZGly
IGluICQoU1VCRElSUykgdG9vbHM7IGRvIFwKPiAgCQkkKE1BS0UpIC1DICQkZGlyIGNsZWFuID4v
ZGV2L251bGw7IFwKPiAgCWRvbmUKPiBAQCAtNTEsNiArNTYsOSBAQCBkaXN0Y2xlYW4tbWFrZWZp
bGVzOgo+ICAJCSQoTUFLRSkgLUMgJCRkaXIgJEA7IFwKPiAgCWRvbmUKCj4gKy5QSE9OWTogbWFp
bnRhaW5lci1jbGVhbgo+ICttYWludGFpbmVyLWNsZWFuOiBkaXN0Y2xlYW4tbWFrZWZpbGVzIGFj
LW1haW50YWluZXItY2xlYW4KPiArCj4gICQoQVVUT0dFTkVSQVRFRF9GSUxFUyk6ICQodG9wX2J1
aWxkZGlyKS9jb25maWcuc3RhdHVzCj4gIAkkKFNIRUxMKSAkXgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
