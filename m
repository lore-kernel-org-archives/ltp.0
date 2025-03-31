Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60927C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 09:56:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9ECF33CAB6D
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 11:56:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8491E3C8EE0
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 11:55:55 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5AD0D10009EA
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 11:55:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C9F4B21164;
 Mon, 31 Mar 2025 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743414951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpGW0PHVU5hCH3mJcnfUVYG20xunWXor0QNypVBdoGE=;
 b=1F5wBIHyNq3TaHw7YYE/HgC1ekhtTxZ/Z1A0gNWGu6zzkuj4B1jo22olGFqj4auTbWbxYy
 W3PEqS3GhzrZQY8tM/gXXDE4leejoDlAZw6P495UowFWaKoSiuhGTKmEdlI5OFMFPug6l0
 loi1uqJeqw1NaC2eayxPPASg/jeQlOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743414951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpGW0PHVU5hCH3mJcnfUVYG20xunWXor0QNypVBdoGE=;
 b=eiYNJ12oByQFqjIgXXUeofPdff5g9uy+biSy8eiYlmxBVZjBLMTNXvW2UzvEeZtPjTUXPA
 lWv7AvhhSGoleHBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743414951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpGW0PHVU5hCH3mJcnfUVYG20xunWXor0QNypVBdoGE=;
 b=1F5wBIHyNq3TaHw7YYE/HgC1ekhtTxZ/Z1A0gNWGu6zzkuj4B1jo22olGFqj4auTbWbxYy
 W3PEqS3GhzrZQY8tM/gXXDE4leejoDlAZw6P495UowFWaKoSiuhGTKmEdlI5OFMFPug6l0
 loi1uqJeqw1NaC2eayxPPASg/jeQlOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743414951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpGW0PHVU5hCH3mJcnfUVYG20xunWXor0QNypVBdoGE=;
 b=eiYNJ12oByQFqjIgXXUeofPdff5g9uy+biSy8eiYlmxBVZjBLMTNXvW2UzvEeZtPjTUXPA
 lWv7AvhhSGoleHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96A6813A1F;
 Mon, 31 Mar 2025 09:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HOMwI6dm6mdoWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 09:55:51 +0000
Date: Mon, 31 Mar 2025 11:55:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250331095550.GA234056@pevik>
References: <20250331-fix_fanotify_i586-v1-1-4f9edd380d00@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250331-fix_fanotify_i586-v1-1-4f9edd380d00@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.cz,redhat.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,opensuse.org:url,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify: fix missing fallback for
 FAN_RESPONSE_ERRNO
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLCBhbGwsCgpbIENjIGZhbm90aWZ5IGRldmVsb3BlcnMgKyBhY3RpdmUgTFRQIG1h
aW50YWluZXJzIGZvciBDSSBjaGFuZ2UgZGVjaXNpb24gXQoKUmV2aWV3ZWQtYnk6IFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6PgoKUGxlYXNlIGFkZCBiZWZvcmUgbWVyZ2U6CgpGaXhlczogYzA4
ODMxNjQ1MiAoImZhbm90aWZ5MjQ6IEFkZCB0ZXN0IGZvciBGQU5fUFJFX0FDQ0VTUyBhbmQgRkFO
X0RFTllfRVJSTk8iKQoKPiBGcm9tOiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRv
QHN1c2UuY29tPgoKPiBGaXggdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvciBvbiBpNTg2OgoKPiBm
YW5vdGlmeTI0LmM6IEluIGZ1bmN0aW9uIOKAmGV4cGVjdGVkX2Vycm5v4oCZOgo+IC4uCj4gICAx
NzMgfCAgICAgICAgICAgICAgICAgcmV0dXJuIEZBTl9SRVNQT05TRV9FUlJOTyhyZXNwb25zZSk7
Cj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fgo+ICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICBGQU5fREVOWV9FUlJOTwo+IG1ha2VbNF06ICoq
KiBbLi4vLi4vLi4vLi4vaW5jbHVkZS9tay9ydWxlcy5tazo0ODogZmFub3RpZnkyNF0gRXJyb3Ig
MQoKVGhpcyBpcyBub3QgaTU4NiBzcGVjaWZpYywgaXQgZmFpbHMgaW4gb3VyIE9CUyBhbHNvIG9u
IHg4Nl82NCBbMV0uIEluIGZhY3QgaXQncwpub3QgYW4gYXJjaCBzcGVjaWZpYyAtIGl0IGZhaWxz
IG9uIGFsbCBhcmNocywgZS5nLjogYWFyY2g2NCBbMl0gcHBjNjRsZSBbM10uClRoaXMgaXMgYWN0
dWFsbHkgY2F1c2VkIGJ5IHVwZGF0ZSBvZiAvdXNyL2luY2x1ZGUvbGludXgvZmFub3RpZnkuaCBm
cm9tIGtlcm5lbAo2LjE0IChpbiBvcGVuU1VTRSBUdW1ibGV3ZWVkIHByb3ZpZGVkIGJ5IGxpbnV4
LWdsaWJjLWRldmVsLTYuMTQtMS4xKS4KUGxlYXNlIGZpeCB0aGUgY29tbWl0IG1lc3NhZ2UgYmVm
b3JlIG1lcmdlLgoKQW5kIEkgYWdyZWUgdGhhdCB0aGUgYmVzdCB0byBhdm9pZCB0aGlzIGluIHRo
ZSBmdXR1cmUgaXMgdG8gYWRkIGEgZ3VhcmQgdG8gYW55CmRlZmluaXRpb24uCgpAQW5kcmVhIEBM
aSBAQ3lyaWwgV2UgaGFkIGluIHRoZSBwYXN0IFR1bWJsZXdlZWQsIGJ1dCBkdWUgaW50ZXJuYWwg
cmVwbyBwcm9ibGVtCml0IHNvbWV0aW1lcyBmYWlsZWQuIEkgd29uZGVyIGlmIGl0J3MgYSB0aW1l
IHRyeWluZyB0byByZWludHJvZHVjZSBpdCBhZ2FpbiB0bwpjYXRjaCB0aGlzLiAgSWYgaXQncyBu
b3Qgd29ya2luZywgd2UgbWlnaHQgdHJ5IEZlZG9yYSByYXdoaWRlIChATGkgbm90IHN1cmUgaWYK
cmF3aGlkZSBpcyBnZW5lcmFsbHkgdXNhYmxlIGZvciBDSSkuCgpLaW5kIHJlZ2FyZHMsClBldHIK
ClsxXSBodHRwczovL2J1aWxkLm9wZW5zdXNlLm9yZy9wYWNrYWdlL2xpdmVfYnVpbGRfbG9nL2Jl
bmNobWFyazpsdHA6ZGV2ZWwvbHRwL29wZW5TVVNFX0ZhY3RvcnkveDg2XzY0ClsyXSBodHRwczov
L2J1aWxkLm9wZW5zdXNlLm9yZy9wYWNrYWdlL2xpdmVfYnVpbGRfbG9nL2JlbmNobWFyazpsdHA6
ZGV2ZWwvbHRwL29wZW5TVVNFX0ZhY3RvcnlfQVJNL2FhcmNoNjQKWzNdIGh0dHBzOi8vYnVpbGQu
b3BlbnN1c2Uub3JnL3BhY2thZ2UvbGl2ZV9idWlsZF9sb2cvYmVuY2htYXJrOmx0cDpkZXZlbC9s
dHAvb3BlblNVU0VfRmFjdG9yeV9Qb3dlclBDL3BwYzY0bGUKCj4gU2lnbmVkLW9mZi1ieTogQW5k
cmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPiAtLS0KPiBUaGUgcmVh
c29uIG9mIHRoZSBmYWlsIGlzIHJlbGF0ZWQgdG8gdGhlIEZBTl9SRVNQT05TRV9FUlJOTwo+IGRl
ZmluaXRpb24sIHdoaWNoIGlzIHNraXBwZWQgaW4gdGhlIGZhbGxiYWNrIGhlYWRlciBmaWxlLgoK
PiBodHRwczovL29wZW5xYS5vcGVuc3VzZS5vcmcvdGVzdHMvNDk2MTE2MyNzdGVwL2luc3RhbGxf
bHRwLzgyCj4gLS0tCj4gIGluY2x1ZGUvbGFwaS9mYW5vdGlmeS5oIHwgMyArKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2Zh
bm90aWZ5LmggYi9pbmNsdWRlL2xhcGkvZmFub3RpZnkuaAo+IGluZGV4IDc2OTA3ZWE1ZjIxOTg5
YzUxODU0NzhkM2Q0ZjU1NzdkOTQwM2U1MTkuLjhkMDRjOGYyODk2OWQwYjNkNWZlYzcxODI0ZDU2
OWIwMWM5ZWMwNTQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9sYXBpL2Zhbm90aWZ5LmgKPiArKysg
Yi9pbmNsdWRlL2xhcGkvZmFub3RpZnkuaAo+IEBAIC0xMjgsNiArMTI4LDkgQEAKPiAgI2lmbmRl
ZiBGQU5fREVOWV9FUlJOTwo+ICAjZGVmaW5lIEZBTl9FUlJOTyhlcnIpICgoKCgoX191MzIpKGVy
cikpICYgMHhmZikgPDwgMjQpKQo+ICAjZGVmaW5lIEZBTl9ERU5ZX0VSUk5PKGVycikgKEZBTl9E
RU5ZIHwgRkFOX0VSUk5PKGVycikpCj4gKyNlbmRpZgo+ICsKPiArI2lmbmRlZiBGQU5fUkVTUE9O
U0VfRVJSTk8KPiAgI2RlZmluZSBGQU5fUkVTUE9OU0VfRVJSTk8ocmVzKSAoKGludCkoKHJlcykg
Pj4gMjQpKQo+ICAjZW5kaWYKCgo+IC0tLQo+IGJhc2UtY29tbWl0OiAxYWNhMjk3OTM4Yzg1YjQx
ZTQxYzkxM2Q0ZmZjMGVjYzM0NWQwMmQ0Cj4gY2hhbmdlLWlkOiAyMDI1MDMzMS1maXhfZmFub3Rp
ZnlfaTU4Ni1lOTZlZTNkMDYyNzUKCj4gQmVzdCByZWdhcmRzLAoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
