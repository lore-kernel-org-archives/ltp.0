Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2288DCD1292
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 20:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39A4B3CE4E8
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 22:43:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B6263CE4DF
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 22:43:05 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 79134201DCD
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 22:43:03 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31910219C9;
 Thu,  4 Apr 2024 20:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712263381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGVk3j5aOytv9wYjog+1SryJnMaULxA1Pmg6T1GgKjI=;
 b=EQQc8gJ+ofiTOnUhcYBO/vRGixhDhuF45sawOf+LWyZ6v34Mdv1qBr3Uk8IqleJ9MzPgL8
 ARMDEyogEA7GryjhkccAVF+2h6kv7bWGQ4FLvhOAUM5dVvZjWMn89sO8Df5aKRWL7g3OA7
 U62UuV9fNupKv/m/lpGXZOA+O51471E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712263381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGVk3j5aOytv9wYjog+1SryJnMaULxA1Pmg6T1GgKjI=;
 b=HnhLOQaLsUwrgvQ/1qfXCXtCNG073jIzdV/zJ9pbfveqCwXkGnleI0I1QAtPv6wd4Z2zI/
 /nUcLDO7wMHLEJAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712263380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGVk3j5aOytv9wYjog+1SryJnMaULxA1Pmg6T1GgKjI=;
 b=KF6/uG9gYMOVhKajYY0bAzBF3w8OC7LbiA4c1ipqvOhc/gWFXsk+0Nxjyjk6Muqp4mlF3x
 j+aeoLhNNgp13+NaAiGaQ3w6UaY9drilGlQKca/tzqBId8trg3atj3LFqEhqhlbE3CNC8+
 WCB4MO+paJpclxFh3jt86AnYE/5MqxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712263380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGVk3j5aOytv9wYjog+1SryJnMaULxA1Pmg6T1GgKjI=;
 b=tPghKFgp7Zlk5W/STc6VfS/NQxD+cvipTtxFxR95FiIzLiwUqZK97ncH1kkcfv+G3wvI/5
 Fp8FeLindYFxXiBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BC8513298;
 Thu,  4 Apr 2024 20:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 11RcAdQQD2b+eQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 04 Apr 2024 20:43:00 +0000
Date: Thu, 4 Apr 2024 22:42:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240404204258.GA565448@pevik>
References: <20230829231845.25866-1-wegao@suse.com>
 <20230831064727.5790-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230831064727.5790-1-wegao@suse.com>
X-Spamd-Result: default: False [-2.12 / 50.00]; BAYES_HAM(-1.63)[92.62%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.978]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] clone3: Add clone3's clone_args cgroup
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiAtLS0KPiAgaW5jbHVk
ZS9sYXBpL3NjaGVkLmggICAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrCj4gIGluY2x1ZGUv
dHN0X2Nncm91cC5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArCj4gIGluY2x1ZGUvdHN0
X2Nsb25lLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArCj4gIGxpYi90c3RfY2dyb3Vw
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgOCArKwo+ICBsaWIvdHN0X2Nsb25lLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwo+ICBydW50ZXN0L3N5c2NhbGxzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Nsb25lMy8uZ2l0aWdub3JlIHwgIDEgKwo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2Nsb25lMy9jbG9uZTMwMy5jIHwgOTUgKysrKysrKysrKysrKysrKysrKysrCk5vdGUgbGliIGNo
YW5nZXMgc2hvdWxkIGhhdmUgYmVlbiBzZXBhcmF0ZWQgZnJvbSBhZGRpbmcgbmV3IHRlc3QgY2xv
bmUzMDMuYwooY29tbWl0IHdvdWxkIGJlIHJlYWRhYmxlKS4KCj4gIDggZmlsZXMgY2hhbmdlZCwg
MTE5IGluc2VydGlvbnMoKykKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvY2xvbmUzL2Nsb25lMzAzLmMKCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9z
Y2hlZC5oIGIvaW5jbHVkZS9sYXBpL3NjaGVkLmgKPiBpbmRleCAxMDY1NjY1ZDEuLmFjNzY2ZWZj
NSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xhcGkvc2NoZWQuaAo+ICsrKyBiL2luY2x1ZGUvbGFw
aS9zY2hlZC5oCj4gQEAgLTEzLDYgKzEzLDcgQEAKPiAgI2luY2x1ZGUgPGludHR5cGVzLmg+Cj4g
ICNpbmNsdWRlICJjb25maWcuaCIKPiAgI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKPiArI2lu
Y2x1ZGUgImxhcGkvc2NoZWQuaCIKCj4gIHN0cnVjdCBzY2hlZF9hdHRyIHsKPiAgCXVpbnQzMl90
IHNpemU7Cj4gQEAgLTU0LDYgKzU1LDkgQEAgc3RydWN0IGNsb25lX2FyZ3Mgewo+ICAJdWludDY0
X3QgX19hdHRyaWJ1dGVfXygoYWxpZ25lZCg4KSkpIHN0YWNrOwo+ICAJdWludDY0X3QgX19hdHRy
aWJ1dGVfXygoYWxpZ25lZCg4KSkpIHN0YWNrX3NpemU7Cj4gIAl1aW50NjRfdCBfX2F0dHJpYnV0
ZV9fKChhbGlnbmVkKDgpKSkgdGxzOwo+ICsJdWludDY0X3QgX19hdHRyaWJ1dGVfXygoYWxpZ25l
ZCg4KSkpIHNldF90aWQ7Cj4gKwl1aW50NjRfdCBfX2F0dHJpYnV0ZV9fKChhbGlnbmVkKDgpKSkg
c2V0X3RpZF9zaXplOwo+ICsJdWludDY0X3QgX19hdHRyaWJ1dGVfXygoYWxpZ25lZCg4KSkpIGNn
cm91cDsKCkFkZGluZyBuZXcgbWVtYmVycyBpbnRyb2R1Y2VkIHdhcm5pbmdzIGxpa2UgdGhpczoK
CnRzdF9uc19leGVjLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CnRzdF9uc19leGVjLmM6NzA6
MTY6IHdhcm5pbmc6IG1pc3NpbmcgaW5pdGlhbGl6ZXIgZm9yIGZpZWxkIOKAmGNncm91cOKAmSBv
ZiDigJhzdHJ1Y3QgdHN0X2Nsb25lX2FyZ3PigJkgWy1XbWlzc2luZy1maWVsZC1pbml0aWFsaXpl
cnNdCiAgIDcwIHwgICAgICAgICBzdHJ1Y3QgdHN0X2Nsb25lX2FyZ3MgYXJncyA9IHsgMCwgU0lH
Q0hMRCB9OwogICAgICB8ICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+CkluIGZpbGUgaW5j
bHVkZWQgZnJvbSAuLi8uLi9pbmNsdWRlL3RzdF90ZXN0Lmg6MTEzLAogICAgICAgICAgICAgICAg
IGZyb20gdHN0X25zX2V4ZWMuYzoyMDoKLi4vLi4vaW5jbHVkZS90c3RfY2xvbmUuaDoxNDoxODog
bm90ZTog4oCYY2dyb3Vw4oCZIGRlY2xhcmVkIGhlcmUKICAgMTQgfCAgICAgICAgIHVpbnQ2NF90
IGNncm91cDsKICAgICAgfCAgICAgICAgICAgICAgICAgIF5+fn5+fgoKSSdtIGdvaW5nIHRvIGZp
eCBpdC4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
