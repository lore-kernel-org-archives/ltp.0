Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB2CC83F17
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 06:30:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09C5C3CC488
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 08:30:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A2AB3CB145
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 08:30:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3076C10006C5
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 08:30:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B60A11F38A;
 Fri, 18 Jul 2025 06:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752820233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUg+bFSI//4mxqflViQg/QILzSZKPnVhjzhkaDNhjIE=;
 b=H0owf3VzSQHMh8ogSxWC9R/xgXL81jXTYnPd8I8zXJZTJcQfKB+th1sAPDP11z4W5niGY/
 ul3b/FZqXAhKuWDHt9jQS4QG4nLeMuR8fXDyp4cfDtYrY3aeG5kTNJu2IhKumXrxBB1Mor
 7YFowxK/GjIsfRiD9lX5dm5skejCZsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752820233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUg+bFSI//4mxqflViQg/QILzSZKPnVhjzhkaDNhjIE=;
 b=TixgIlWRuRRb6uU+CO225Ivb5JbYC/nHp0mIq1e5jmWVwxXVR3nALFRTKfudb1w8O3F5Iu
 SQTgp6/x3/n1BZAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752820233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUg+bFSI//4mxqflViQg/QILzSZKPnVhjzhkaDNhjIE=;
 b=H0owf3VzSQHMh8ogSxWC9R/xgXL81jXTYnPd8I8zXJZTJcQfKB+th1sAPDP11z4W5niGY/
 ul3b/FZqXAhKuWDHt9jQS4QG4nLeMuR8fXDyp4cfDtYrY3aeG5kTNJu2IhKumXrxBB1Mor
 7YFowxK/GjIsfRiD9lX5dm5skejCZsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752820233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUg+bFSI//4mxqflViQg/QILzSZKPnVhjzhkaDNhjIE=;
 b=TixgIlWRuRRb6uU+CO225Ivb5JbYC/nHp0mIq1e5jmWVwxXVR3nALFRTKfudb1w8O3F5Iu
 SQTgp6/x3/n1BZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72E2813A52;
 Fri, 18 Jul 2025 06:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N/NvGgnqeWgpJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Jul 2025 06:30:33 +0000
Date: Fri, 18 Jul 2025 08:30:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <20250718063028.GA1387837@pevik>
References: <20250711080155.7473-1-yangtiezhu@loongson.cn>
 <6479ff64-d82c-401c-89f3-c4adbf3f330f@suse.com>
 <51cdca77-e93e-7df5-e50a-7604c2a3cb10@loongson.cn>
 <20250717140907.GA11016@pevik>
 <bba4b00c-e75c-4cda-9b92-9692edac2c73@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bba4b00c-e75c-4cda-9b92-9692edac2c73@loongson.cn>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
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

SGkgVGllemh1LAoKPiBPbiAyMDI1LzcvMTcg5LiL5Y2IMTA6MDksIFBldHIgVm9yZWwgd3JvdGU6
Cj4gPiBIaSBUaWV6aHUsIGFsbCwKCj4gLi4uCgo+ID4gRHVlIHRoZSBhYm92ZSBjb3VsZCB5b3Ug
cGxlYXNlIHRha2UgdGhlIGFwcHJvYWNoIFJpY2FyZG8gZGlkIGluIDgyZTM4YTFmMjQKPiA+ICgi
YmxvY2tfZGV2OiBDb252ZXJ0IHRvIG5ldyBBUEkiKSAtIHdyYXAgd2l0aCBpZm5kZWY/Cgo+ID4g
I2lmbmRlZiBESVNLX05BTUVfTEVOCj4gPiAjIGluY2x1ZGUgPGxpbnV4L2dlbmhkLmg+Cj4gPiAj
ZW5kaWYKCj4gPiBCVFcgSSB3b3VsZCBwZXJzb25hbGx5IHVzZSAjaWZuZGVmIEhBVkVfTElOVVhf
QkxLREVWX0ggdGhhbiBjaGVja2luZyBmb3IKPiA+IERJU0tfTkFNRV9MRU4gYXMgd2UgYWxyZWFk
eSBjaGVjayBmb3IgbGludXgvYmxrZGV2LmggaW4gY29uZmlndXJlLmFjLCBidXQgdGhhdCdzCj4g
PiBhIG1pbm9yIGRldGFpbC4KCj4gSSB0aGluayB1c2UgIiNpZm5kZWYgRElTS19OQU1FX0xFTiIg
aXMgcHJvcGVyLgoKSSdtIHNvcnJ5LCBJIG1lYW50ICNpZmRlZiBIQVZFX0xJTlVYX0dFTkhEX0gg
KHRoYXQgaXMgd2hhdCBpcyBiZWluZyBjaGVja2VkIGluCmNvbmZpZ3VyZS5hYykuCgo+IEJlY2F1
c2UgYm90aCBnZW5oZC5oIGFuZCBibGtkZXYuaCBhcmUgZXhpc3QgYmVmb3JlIHRoZSBrZXJuZWwK
PiBjb21taXQgMzIyY2JiNTBkZTcxICgiYmxvY2s6IHJlbW92ZSBnZW5oZC5oIiksIEhBVkVfTElO
VVhfQkxLREVWX0gKPiBzZWVtcyBhbHdheXMgZGVmaW5lIGFzIDEgZm9yIHRoZSBuZXcgYW5kIG9s
ZCBrZXJuZWwgdmVyc2lvbnMuCgo+IEJ1dCB0aGUgZGVmaW5pdGlvbiBESVNLX05BTUVfTEVOIHdh
cyBtb3ZlZCBmcm9tIGdlbmhkLmggaW50byBibGtkZXYuaAo+IGFmdGVyIHRoYXQgY29tbWl0LCBi
ZWNhdXNlIGJsa2Rldi5oIGlzIGluY2x1ZGVkIGZpcnN0LCBzbyB3ZSBjYW4gY2hlY2sKPiBESVNL
X05BTUVfTEVOLCBpdCBzaG91bGQgaW5jbHVkZSBnZW5oZC5oIGlmbmRlZiBESVNLX05BTUVfTEVO
LgoKU3VyZSwgdGhpcyB3b3JrcyBub3cgYW5kIGl0J3MgZ29vZCBlbm91Z2guIFRoZSByZWFzb24g
SSB3b3VsZCBwZXJzb25hbGx5IGRlcGVuZApvbiBoZWFkZXIgYmFzZWQgY2hlY2sgI2lmZGVmIEhB
VkVfTElOVVhfR0VOSERfSCBpcyB0aGF0IGlmIGtlcm5lbCBkZXZzIGFyZSBvayB0bwpyZW1vdmUg
d2hvbGUgaGVhZGVyIHRoZXkgY2FuIG9mIGNvdXJzZSBhbHNvIHJlbmFtZSBvciBjb21wbGV0ZWx5
IHJlbW92ZQpESVNLX05BTUVfTEVOIGRlZmluaXRpb24uCgo+ID4gWWVzIHdlIG5lZWQgdG8gI2lm
ICNlbHNlIG1hY3JvcyBmb3IgYWNwaV9idXNfZ2V0X2RldmljZSgpIHZzLgo+ID4gYWNwaV9mZXRj
aF9hY3BpX2RldigpLgoKPiBIZXJlIGlzIGEgZHJhZnQgY2hhbmdlLCBJIHdpbGwgcG9zdCBhIGZv
cm1hbCB2MiBwYXRjaCBpZiB5b3UgYXJlIE9LLgoKPiAtLS0tLT44LS0tLS0KPiBkaWZmIC0tZ2l0
IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJlLmFjCj4gaW5kZXggMTFlNTk5YTgxLi4xZjZlMmIx
YjkgMTAwNjQ0Cj4gLS0tIGEvY29uZmlndXJlLmFjCj4gKysrIGIvY29uZmlndXJlLmFjCj4gQEAg
LTEwMCw2ICsxMDAsNyBAQCBBQ19TVUJTVChIQVZFX0ZUU19ILCAkaGF2ZV9mdHMpCj4gIEFDX0NI
RUNLX0hFQURFUlMobGludXgvdm1fc29ja2V0cy5oLCBbXSwgW10sIFsjaW5jbHVkZSA8c3lzL3Nv
Y2tldC5oPl0pCgo+ICBBQ19DSEVDS19GVU5DU19PTkNFKFsgXAo+ICsgICAgYWNwaV9idXNfZ2V0
X2RldmljZSBcCgpJJ20gc29ycnkgdGhpcyB3aWxsIG5vdCB3b3JrLiBBQ19DSEVDS19GVU5DU19P
TkNFKCkgd29ya3Mgb25seSBmb3IgdXNlcnNwYWNlCmZ1bmN0aW9ucyAoYW5kIHJlcXVpcmUgQUNf
Q0hFQ0tfSEVBREVSUygpIHdpdGggdGhlIHVzZXJzcGFjZSBoZWFkZXIgdG8gYmUgcGFzc2VkCmJl
Zm9yZSkuCgpCdXQgYXMgSSB3cm90ZSBiZWZvcmUgYWNwaV9idXNfZ2V0X2RldmljZSgpIGFuZCBh
Y3BpX2ZldGNoX2FjcGlfZGV2KCkgaXMgb25seSBpbgprZXJuZWwgc291cmNlIGRyaXZlcnMvYWNw
aS9zY2FuLmMgKCsgcHJvdG90eXBlIGlzIG9ubHkgaW4ga2VybmVsIG9ubHkgaGVhZGVyCmluY2x1
ZGUvYWNwaS9hY3BpX2J1cy5oIGJ1dCBpdCB3b3VsZCBub3QgaGVscCkuCgpXZSBoYXZlIEFDX0NP
TVBJTEVfSUZFTFNFKCksIHdoaWNoIGNhbiBiZSB1c2VkIGZvciBkZXRlY3Rpbmcgc3RhdGljIGlu
bGluZSBVQVBJCmZ1bmN0aW9ucywgZS5nLiAKCkFDX0NPTVBJTEVfSUZFTFNFKAoJCQkJICBbQUNf
TEFOR19QUk9HUkFNKAoJCQkJICAgW1sKCQkJCQkjaW5jbHVkZSA8bGludXgvZGNjcC5oPgoJCQkJ
CSNpbmNsdWRlIDxzdGRkZWYuaD4KCQkJCQldXSwKCQkJCSAgIFtbCgkJCQkJc3RydWN0IGRjY3Bf
aGRyICpkaDsKCQkJCQkodm9pZClkY2NwX3BhY2tldF9oZHJfbGVuKGRoLT5kY2NwaF90eXBlKTsK
CQkJCQldXQoJCQkJICAgKV0sCgkJCQkgICBbQUNfREVGSU5FKFtIQVZFX0RDQ1BfUEFDS0VUX0hE
Ul9MRU5dLCBbMV0sIFtEZWZpbmUgaWYgZGNjcF9wYWNrZXRfaGRyX2xlbiBpcyBhdmFpbGFibGVd
KV0sCgkJCQkgICBbXQoJCQkJICAgKQpCdXQgYWdhaW4sIHRoaXMgaXMgbm90IHRoZSBjYXNlIG9m
IGFjcGlfYnVzX2dldF9kZXZpY2UoKSBub3IKYWNwaV9mZXRjaF9hY3BpX2RldigpLgoKQ2FuIHdl
IGdldCBiYWNrIHRvIDUuMTggYmFzZWQgY2hlY2s/CgpHaXZlbiB0aGUgdGltZWxpbmUgSSB3cm90
ZSBhYm92ZSB0aGlzIHNob3VsZCBiZSBzdWZmaWNpZW50OgoKI2lmZGVmIEhBVkVfTElOVVhfR0VO
SERfSAo9PiBhY3BpX2ZldGNoX2FjcGlfZGV2KCkKI2Vsc2UKPT4gYWNwaV9idXNfZ2V0X2Rldmlj
ZSgpCiNlbmRpZgoKQnV0IHByb2JhYmx5IHRoZSBiZXN0IHdheSB3b3VsZCBiZSB0byBjaGVjayBh
Z2FpbnN0IDUuMTg6CgojaW5jbHVkZSA8bGludXgvdmVyc2lvbi5oPgojaWYgTElOVVhfVkVSU0lP
Tl9DT0RFIDwgS0VSTkVMX1ZFUlNJT04oNSwgMTgsIDApCj0+IGFjcGlfZmV0Y2hfYWNwaV9kZXYo
KQojZWxzZQo9PiBhY3BpX2J1c19nZXRfZGV2aWNlKCkKI2VuZGlmCgo+ICAgICAgY2FjaGVzdGF0
IFwKPiAgICAgIGNsb25lMyBcCj4gICAgICBjbG9zZV9yYW5nZSBcCj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvYWNwaS9sdHBfYWNwaV9jbWRzLmMKPiBiL3Rl
c3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvYWNwaS9sdHBfYWNwaV9jbWRzLmMKPiBpbmRl
eCBkMTJkZDZiOTQuLmY2ODAxNDczMiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2Rl
dmljZS1kcml2ZXJzL2FjcGkvbHRwX2FjcGlfY21kcy5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9kZXZpY2UtZHJpdmVycy9hY3BpL2x0cF9hY3BpX2NtZHMuYwo+IEBAIC0zNiw3ICszNiw5IEBA
Cj4gICNpbmNsdWRlIDxsaW51eC9pb2N0bC5oPgo+ICAjaW5jbHVkZSA8bGludXgvcG0uaD4KPiAg
I2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4KPiArI2lmbmRlZiBESVNLX05BTUVfTEVOCj4gICNpbmNs
dWRlIDxsaW51eC9nZW5oZC5oPgo+ICsjZW5kaWYKPiAgI2luY2x1ZGUgPGxpbnV4L2RtaS5oPgo+
ICAjaW5jbHVkZSA8bGludXgvbmxzLmg+Cgo+IEBAIC0xMjMsMTQgKzEyNSwyMCBAQCBzdGF0aWMg
dm9pZCBnZXRfY3JzX29iamVjdChhY3BpX2hhbmRsZSBoYW5kbGUpCgo+ICBzdGF0aWMgdm9pZCBn
ZXRfc3lzZnNfcGF0aChhY3BpX2hhbmRsZSBoYW5kbGUpCj4gIHsKPiAtICAgICAgIGFjcGlfc3Rh
dHVzIHN0YXR1czsKPiAgICAgICAgIHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlOwoKPiAgICAg
ICAgIGtmcmVlKHN5c2ZzX3BhdGgpOwo+ICAgICAgICAgc3lzZnNfcGF0aCA9IE5VTEw7Cgo+ICsj
aWZkZWYgSEFWRV9BQ1BJX0JVU19HRVRfREVWSUNFCj4gKyAgICAgICBhY3BpX3N0YXR1cyBzdGF0
dXM7Cj4gKwo+ICAgICAgICAgc3RhdHVzID0gYWNwaV9idXNfZ2V0X2RldmljZShoYW5kbGUsICZk
ZXZpY2UpOwo+ICAgICAgICAgaWYgKEFDUElfU1VDQ0VTUyhzdGF0dXMpKQo+ICsjZWxzZQo+ICsg
ICAgICAgZGV2aWNlID0gYWNwaV9mZXRjaF9hY3BpX2RldihoYW5kbGUpOwo+ICsgICAgICAgaWYg
KGRldmljZSkKPiArI2VuZGlmCj4gICAgICAgICAgICAgICAgIHN5c2ZzX3BhdGggPSBrb2JqZWN0
X2dldF9wYXRoKCZkZXZpY2UtPmRldi5rb2JqLAo+IEdGUF9LRVJORUwpOwo+ICB9Cgo+IEBAIC0z
OTgsOSArNDA2LDE1IEBAIHN0YXRpYyBpbnQgYWNwaV90ZXN0X2J1cyh2b2lkKQo+ICAgICAgICAg
aWYgKGFjcGlfZmFpbHVyZShzdGF0dXMsICJhY3BpX2dldF9oYW5kbGUiKSkKPiAgICAgICAgICAg
ICAgICAgcmV0dXJuIDE7Cgo+ICsjaWZkZWYgSEFWRV9BQ1BJX0JVU19HRVRfREVWSUNFCj4gICAg
ICAgICBwcmtfYWxlcnQoIlRFU1QgLS0gYWNwaV9idXNfZ2V0X2RldmljZSIpOwo+ICAgICAgICAg
c3RhdHVzID0gYWNwaV9idXNfZ2V0X2RldmljZShidXNfaGFuZGxlLCAmZGV2aWNlKTsKPiAgICAg
ICAgIGlmIChhY3BpX2ZhaWx1cmUoc3RhdHVzLCAiYWNwaV9idXNfZ2V0X2RldmljZSIpKQo+ICsj
ZWxzZQo+ICsgICAgICAgcHJrX2FsZXJ0KCJURVNUIC0tIGFjcGlfZmV0Y2hfYWNwaV9kZXYiKTsK
PiArICAgICAgIGRldmljZSA9IGFjcGlfZmV0Y2hfYWNwaV9kZXYoYnVzX2hhbmRsZSk7Cj4gKyAg
ICAgICBpZiAoIWRldmljZSkKPiArI2VuZGlmCj4gICAgICAgICAgICAgICAgIHJldHVybiAxOwoK
PiAgICAgICAgIHBya19hbGVydCgiVEVTVCAtLSBhY3BpX2J1c191cGRhdGVfcG93ZXIgIik7CgpQ
bGVhc2Ugd2hpbGUgeW91J3JlIGF0IGl0IHJlbW92ZSB0cmFpbGluZyB3aGl0ZXNwYWNlOgogICAg
ICAgICAgcHJrX2FsZXJ0KCJURVNUIC0tIGFjcGlfYnVzX3VwZGF0ZV9wb3dlciIpOwoKVGhlIHJl
c3QgTEdUTS4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBUaGFua3MsCj4gVGllemh1CgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
