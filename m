Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA25C83F1A
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 14:09:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C04CF3CC251
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 16:09:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 184663CB5CB
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 16:09:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ED64A1A007AE
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 16:09:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED9131FB5A;
 Thu, 17 Jul 2025 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752761355;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUyOtPHITHNAwdrUh4ZtLiod9mkX55NQAqc66ep5Ur0=;
 b=T9zfcmdFLh6ylx2diAo7v/gImYD5pnnXWjJtXEe3bljZzBlILhUv07DuewEgF3Q+1dB69V
 4Fe7O+gGiqOZAurYhoeUa6Ul5ME/IoyBcayN80vQ4SL8CIjEpTTUwXusAQV7pjbYup24la
 vZYlB8ZEekdxR8gpCpcgkBCVPumG6qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752761355;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUyOtPHITHNAwdrUh4ZtLiod9mkX55NQAqc66ep5Ur0=;
 b=JSiZijbkC/9sIuKGZjYFrbwh6Vqd755uRAsh4jLfDz7W9eL0VsBD/YMaYu01YdRJbuoExS
 YQKDvwdNazG37mAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752761354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUyOtPHITHNAwdrUh4ZtLiod9mkX55NQAqc66ep5Ur0=;
 b=COv6TJN6xxjVZTI9XJ/mMoq0Bfd4weXR5VEeyEHuWQApU4s/YS4Chzt/LPXBv5CgVGvYkK
 A/iKcyDHJGUg20KzvcLbhVdy8221vQD1qyQjT2KwkS4i0EGwcODC2U3k1p5kTx7e5P1i3H
 cYDzPgqJqFUdohx82tAvrSlNcDt51E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752761354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUyOtPHITHNAwdrUh4ZtLiod9mkX55NQAqc66ep5Ur0=;
 b=Jpenqn/EkWwLYfCPg2jRm9Klftmp7OuGSuXlDlcyzg8QGNo68wBvQO51NyN/cjSFasdDWU
 DkGrYswboypUwQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5EC113A6C;
 Thu, 17 Jul 2025 14:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IxnIKwkEeWjhLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 17 Jul 2025 14:09:13 +0000
Date: Thu, 17 Jul 2025 16:09:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <20250717140907.GA11016@pevik>
References: <20250711080155.7473-1-yangtiezhu@loongson.cn>
 <6479ff64-d82c-401c-89f3-c4adbf3f330f@suse.com>
 <51cdca77-e93e-7df5-e50a-7604c2a3cb10@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51cdca77-e93e-7df5-e50a-7604c2a3cb10@loongson.cn>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] device-drivers/acpi/ltp_acpi_cmds: Fix build
 errors
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
Cc: "Ricardo B. Marliere" <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgVGllemh1LCBhbGwsCgpbIENjIEphbiBhbmQgUmljYXJkbyBpbiBjYXNlIEkgb3Zlcmxvb2sg
c29tZXRoaW5nIF0KCj4gT24gMjAyNS83LzE1IOS4i+WNiDU6MjQsIEFuZHJlYSBDZXJ2ZXNhdG8g
d3JvdGU6Cj4gPiBIaSEKCj4gPiBPbiA3LzExLzI1IDEwOjAxIEFNLCBUaWV6aHUgWWFuZyB3cm90
ZToKPiA+ID4gVGhlcmUgZXhpc3QgdGhlIGZvbGxvd2luZyBlcnJvcnMgd2hlbiBidWlsZGluZyBM
VFA6Cgo+ID4gPiDCoMKgIGx0cF9hY3BpX2NtZHMuYzozOToxMDogZmF0YWwgZXJyb3I6IGxpbnV4
L2dlbmhkLmg6IE5vIHN1Y2ggZmlsZQo+ID4gPiBvciBkaXJlY3RvcnkKPiA+ID4gwqDCoCBsdHBf
YWNwaV9jbWRzLmM6MTMxOjE4OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rp
b24KPiA+ID4gJ2FjcGlfYnVzX2dldF9kZXZpY2UnCj4gPiA+IMKgwqAgbHRwX2FjcGlfY21kcy5j
OjQwMDoxODogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uCj4gPiA+ICdh
Y3BpX2J1c19nZXRfZGV2aWNlJwoKPiA+ID4gRm9yIHRoZSBmaXJzdCBlcnJvcjoKCj4gPiA+IFRo
aXMgaXMgYmVjYXVzZSBnZW5oZC5oIGhhcyBiZWVuIHJlbW92ZWQgaW4gdGhlIExpbnV4IGtlcm5l
bCwgdGhlCj4gPiA+IGNvbnRlbnRzCj4gPiA+IG9mIGdlbmhkLmggd2FzIGZvbGRlZCBpbnRvIGJs
a2Rldi5oIFsxXS4gU2luY2UgYmxrZGV2LmggaGFzIGJlZW4gaW5jbHVkZWQKPiA+ID4gaW4gdGhl
IEMgZmlsZSwganVzdCByZW1vdmUgdW51c2VkIGluY2x1ZGUgZ2VuaGQuaCB0byBmaXggdGhlIGJ1
aWxkIGVycm9yLgoKPiA+ID4gRm9yIHRoZSBzZWNvbmQgYW5kIHRoaXJkIGVycm9yczoKCj4gPiA+
IFRoaXMgaXMgYmVjYXVzZSBhY3BpX2J1c19nZXRfZGV2aWNlKCkgaGFzIGJlZW4gZHJvcGVkIGlu
IHRoZSBMaW51eAo+ID4gPiBrZXJuZWwsCj4gPiA+IGluIG9yZGVyIHRvIGZpeCB0aGUgYnVpbGQg
ZXJyb3JzLCBqdXN0IHJlcGxhY2UgYWNwaV9idXNfZ2V0X2RldmljZSgpIHdpdGgKPiA+ID4gYWNw
aV9mZXRjaF9hY3BpX2RldigpIGxpa2UgdGhlIGtlcm5lbCBjb21taXQgWzJdLgoKPiA+ID4gWzFd
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvdG9ydmFsZHMvYy8zMjJjYmI1MGRlNzEKPiA+ID4gWzJd
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvdG9ydmFsZHMvYy9hYzJhM2ZlZWZhZDUKCj4gPiBUaGVz
ZSBwYXRjaGVzIGhhdmUgYmVlbiBpbnRyb2R1Y2VkIGluIHY1LjE4LCBidXQgd2Ugc3VwcG9ydCBr
ZXJuZWwgdW50aWwKPiA+IHY0LjQuIElmIHdlIHJlYWxseSB3YW50IHRvIGtlZXAgdGhpcyBjb2Rl
LAoKPiBUaGVyZSBhcmUgZmF0YWwgZXJyb3JzIGFib3V0IHRoZSBmb2xsb3dpbmcgdHdvIGZpbGVz
OgoKPiB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3RiaW8vdGJpb19rZXJuZWwvbHRw
X3RiaW8uYwo+IHRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvYWNwaS9sdHBfYWNwaV9j
bWRzLmMKCj4gSSBndWVzcyB0aGV5IGFyZSBub3QgdXNlZCBmcmVxdWVudGx5Lgo+IEkgYW0gbm90
IHN1cmUgd2hhdCBpcyB0aGUgcHJvcGVyIHdheSB0byBoYW5kbGUgdGhpcyBjYXNlLgoKPiAoMSkg
anVzdCBrZWVwIGl0IGFzIGlzCj4gKDIpIHJlbW92ZSB0aGVtIGVudGlyZWx5Cj4gKDMpIGFkanVz
dCB0aGVtIGZvciBkaWZmZXJlbnQga2VybmVsIHZlcnNpb25zCgpGaXJzdCwgdGhhbmtzIGEgbG90
IGZvciBsb29raW5nIGludG8gTFRQIHRlc3Qga2VybmVsIG1vZHVsZXMuIEluZGVlZApsdHBfYWNw
aV9jbWRzLmtvIGFuZCBsdHBfdGJpby5rbyBzb3VyY2UgY29kZSBkbyBub3QgY29tcGlsZSBvbiBu
ZXdlciBrZXJuZWxzIGFuZAp0aGVyZSBhcmUgbW9yZSBvZiB0aGVtIHVzaW5nIGxpbnV4L2dlbmhk
LmggKGJ1dCBvbmx5IGx0cF9hY3BpX2NtZHMua28gdXNlcwphY3BpX2J1c19nZXRfZGV2aWNlKCkp
LiBCdXQgQW5kcmVhIGlzIGNvcnJlY3Qgd2Ugd2FudCB0byBjYXJlIGFib3V0IG9sZCBrZXJuZWxz
CnVwIHRvIDQuNCAoc2VlIFsxXSkuCgpAQCAtMzYsNyArMzYsNiBAQAogI2luY2x1ZGUgPGxpbnV4
L2lvY3RsLmg+CiAjaW5jbHVkZSA8bGludXgvcG0uaD4KICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+
Ci0jaW5jbHVkZSA8bGludXgvZ2VuaGQuaD4KCkR1ZSB0aGUgYWJvdmUgY291bGQgeW91IHBsZWFz
ZSB0YWtlIHRoZSBhcHByb2FjaCBSaWNhcmRvIGRpZCBpbiA4MmUzOGExZjI0CigiYmxvY2tfZGV2
OiBDb252ZXJ0IHRvIG5ldyBBUEkiKSAtIHdyYXAgd2l0aCBpZm5kZWY/CgojaWZuZGVmIERJU0tf
TkFNRV9MRU4KIyBpbmNsdWRlIDxsaW51eC9nZW5oZC5oPgojZW5kaWYKCkJUVyBJIHdvdWxkIHBl
cnNvbmFsbHkgdXNlICNpZm5kZWYgSEFWRV9MSU5VWF9CTEtERVZfSCB0aGFuIGNoZWNraW5nIGZv
cgpESVNLX05BTUVfTEVOIGFzIHdlIGFscmVhZHkgY2hlY2sgZm9yIGxpbnV4L2Jsa2Rldi5oIGlu
IGNvbmZpZ3VyZS5hYywgYnV0IHRoYXQncwphIG1pbm9yIGRldGFpbC4KCj4gRnVydGhlcm1vcmUs
IEkgZm91bmQgdGhlcmUgYXJlIG1hbnkgd2FybmluZ3MgZXhjZXB0IHRoZSBhYm92ZQo+IGZhdGFs
IGVycm9ycywgaXMgaXQgbmVjZXNzYXJ5IHRvIHNpbGVuY2UgdGhlbSBvciBrZWVwIGl0IGFzIGlz
PwoKPiA+IHdlIG5lZWQgdG8gdXNlIGF1dG9jb25mIGluIG9yZGVyIHRvIHJlY29nbml6ZSBhY3Bp
IGZ1bmN0aW9ucyBhbmQgdG8KPiA+IGNyZWF0ZSBhIGZhbGxiYWNrIGZpbGUgaW4gbGFwaS9nZW5o
ZC5oIGxpa2Ugd2UgdXN1YWxseSBkbyBmb3IgdGhlIG9sZGVyCj4gPiBBUEkuCgo+ID4gaHR0cHM6
Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvYmxvYi9tYXN0ZXIvY29uZmlndXJl
LmFjCj4gPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC90cmVlL21h
c3Rlci9pbmNsdWRlL2xhcGkKClllcyB3ZSBuZWVkIHRvICNpZiAjZWxzZSBtYWNyb3MgZm9yIGFj
cGlfYnVzX2dldF9kZXZpY2UoKSB2cy4KYWNwaV9mZXRjaF9hY3BpX2RldigpLgoKVGhlIHRpbWVs
aW5lIG9mIHJlbGV2YW50IGNoYW5nZXMgaW4ga2VybmVsOgo1LjE3LXJjMTogYWRkZWQgYWNwaV9m
ZXRjaF9hY3BpX2RldigpCjUuMTgtcmMxOiByZW1vdmVkIGxpbnV4L2dlbmhkLmgKNS4xOC1yYzI6
IHJlbW92ZWQgYWxsIHJlbWFpbmluZyB1c2VzIG9mIGFjcGlfYnVzX2dldF9kZXZpY2UoKQo1LjE5
LXJjMTogcmVtb3ZlZCBhY3BpX2J1c19nZXRfZGV2aWNlKCkKCkJvdGggZnVuY3Rpb25zIGFyZSBp
biBkcml2ZXJzL2FjcGkvc2Nhbi5jLCBhbmQgcHJvdG90eXBlIGlzIG9ubHkgaW4ga2VybmVsIG9u
bHkKaGVhZGVyIGluY2x1ZGUvYWNwaS9hY3BpX2J1cy5oIC0gb3V0IG9mIFVBUEkgZXhwb3J0ZWQg
dG8gdXNlciBzcGFjZS4KCkl0IGxvb2tzIHRvIG1lIHRoYXQgd2UgY2FuIGhhcHBpbHkgZXhwZWN0
IHRoYXQgYWNwaV9idXNfZ2V0X2RldmljZSgpCmNhbiBiZSB1c2VkIG9ubHkgd2l0aCBsaW51eC9n
ZW5oZC5oLiBUaGF0IG1ha2VzIHRoaW5ncyBzaW1wbGUsIGJlY2F1c2UgaWYgSSdtCndyb25nIHRo
ZSBkZXRlY3Rpb24gd291bGQgaGF2ZSB0byBiZSBhZGRlZCBhcyBhIGN1c3RvbSBtYWNybyBpbiBt
NAoocHJvYmFibHkganVzdCBleHRlbmQgbTQvbHRwLWtlcm5lbF9kZXZlbC5tNCkgYmVjYXVzZSBB
Q19DT01QSUxFX0lGRUxTRSgpIHdoaWNoCmlzIGluIGNvbmZpZ3VyZS5hYyBpcyBJTUhPIG5vdCBw
b3NzaWJsZSB0byB1c2UgZm9yIGtlcm5lbCBtb2R1bGVzLgoKQW5kIHllcywgeW91IGNvdWxkIHdy
aXRlIG1hY3JvIGluIG5ld2x5IGNyZWF0ZWQgaW5jbHVkZS9sYXBpL21vZHVsZS5oIHRvIGhpZGUK
aWZkZWYgYnV0IElNSE8gbm90IHdvcnRoIGp1c3QgZm9yIHRoZXNlIDIgZnVuY3Rpb25zICh1c2Vk
IG9ubHkgaW4KbHRwX2FjcGlfY21kcy5rbykuIEZZSSBpbmZvIGFib3V0IGxhcGkgaW4gb2xkIGRv
YyBbMl0KCkZZSSBMVFAgYXV0b3Rvb2xzIGtlcm5lbCByZWxhdGVkIGhlbHBlcnM6CiogaW5jbHVk
ZS9tay9tb2R1bGUubWsgKHVzZWQgdG8gY29tcGlsZSBrZXJuZWwgbW9kdWxlcykKKiBtNC9sdHAt
a2VybmVsX2RldmVsLm00IChkZXRlY3Qgc3VwcG9ydCBmb3IgYnVpbGRpbmcgbW9kdWxlcywgZS5n
Lgp3aGV0aGVyIGFyZSBrZXJuZWwtZGVmYXVsdC1kZXZlbC0qIG9wZW5TVVNFIG9yIGxpbnV4LWti
dWlsZC0qIHBhY2thZ2VzCmluc3RhbGxlZCkKCktpbmQgcmVnYXJkcywKUGV0cgoKWzFdIGh0dHBz
Oi8vbGludXgtdGVzdC1wcm9qZWN0LnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC91c2Vycy9zdXBw
b3J0ZWRfc3lzdGVtcy5odG1sI2tlcm5lbC12ZXJzaW9uClsyXSBodHRwczovL2dpdGh1Yi5jb20v
bGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rlci9kb2Mvb2xkL0MtVGVzdC1BUEkuYXNj
aWlkb2MjbGFwaS1oZWFkZXJzCgo+IElmIG5lY2Vzc2FyeSwgd2lsbCB0cnkuCgo+IFRoYW5rcywK
PiBUaWV6aHUKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
