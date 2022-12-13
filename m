Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284C2C04FDE
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 09:37:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA9633CBDB4
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 10:37:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DAF43C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 10:36:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 12C561A000B8
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 10:36:55 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 340A722982;
 Tue, 13 Dec 2022 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670924215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwkCyKy/pPNOo2gObFUJOuOPDETUXS2HC6XwCAoOIyE=;
 b=CkDZIwTehUSht44efmrVKYJEJpMcpvz5sr+DZ29opWuS8N+Rs7tOTO3PFNYLpVa0RKyW+f
 4EfhCpIaOAVxVN9FuEuMOIYwIXiQ38kF2qPdA5su3XYmGS0A5Q4YEG/KBm7NuUMWNJAK02
 Za59ab0Eu4XV3K0vpdFGAXCWjsi6tcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670924215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwkCyKy/pPNOo2gObFUJOuOPDETUXS2HC6XwCAoOIyE=;
 b=6ouLg+jEb11U+AiLBmmItWuYd+UsyOdDl1yzwEO21F0vILAcvIPF1ETCBUcTRidl6YtgNc
 ZZZglV9gD9WCxPCg==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A30052C141;
 Tue, 13 Dec 2022 09:36:54 +0000 (UTC)
References: <20221207092428.11798-1-teo.coupriediaz@arm.com>
 <871qp4u02j.fsf@suse.de> <Y5dHRcLD1359Rm3o@pevik>
 <4b38f13f-a8a1-bbde-9103-9900f0cf5a88@arm.com> <Y5eA7WeAV4b/Cp8d@pevik>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Dec 2022 09:34:20 +0000
Organization: Linux Private Site
In-reply-to: <Y5eA7WeAV4b/Cp8d@pevik>
Message-ID: <87fsdjskzw.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/brk: add direct syscall tst_variant
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JpdGVzOgoKPiBIaSBUZW8sCj4K
Pj4gSGkgUGV0ciwKPgo+PiBPbiAxMi8xMi8yMDIyIDE1OjIyLCBQZXRyIFZvcmVsIHdyb3RlOgo+
PiA+IEhpIFJpY2hpZSwKPgo+PiA+ID4gQ3lyaWwsIFBldHIsIFdvdWxkIHlvdSBsaWtlIHRvIGFk
ZCB5b3VyIHJldmlld2VkIGJ5IHRhZ3M/IFRoZW4gd2UgY2FuCj4+ID4gPiBtZXJnZSB0aGlzLgo+
PiA+IEJ5IGFjY2lkZW50IEkgcmVwbHkgdG8gbXkgcG9pbnRzIHRvIHYxIFsxXS4KPj4gPiBUbyBj
b3B5IGl0IGhlcmU6Cj4KPj4gPiAxKSBUaGVyZSBhcmUgd2FybmluZ3M6Cj4+ID4gYnJrMDIuYzog
SW4gZnVuY3Rpb24g4oCYYnJrX3ZhcmlhbnRz4oCZOgo+PiA+IGJyazAyLmM6MjY6Mjg6IHdhcm5p
bmc6IGNhc3QgdG8gcG9pbnRlciBmcm9tIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUKPj4gPiBb
LVdpbnQtdG8tcG9pbnRlci1jYXN0XQo+PiA+ICAgICAyNiB8ICAgICAgICAgICAgICAgICBicmtf
YWRkciA9ICh2b2lkICopYnJrKGFkZHIpOwo+PiA+ICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4KPgo+PiA+IDIpIG1ha2UgY2hlY2sgcmVwb3J0cyBlcnJvcnMgd2hpY2gg
YXJlIGVhc2lseSBmaXhlZC4KPgo+PiA+IFRlbyByZXBsaWVkIFsyXSwgdGhhdCBoZSdzIGdvaW5n
IHRvIGZpeCBpdC4gSSB0aG91Z2h0IEkgaGFkIHNldCBpdAo+PiA+ICJDaGFuZ2VzIHJlcXVlc3Rl
ZCIsIGJ1dCBub3cgSSBzZWUgIk5lZWRzIFJldmlldyAvIEFDSyIuIFNldHRpbmcgaXQgdG8KPj4g
PiAiQ2hhbmdlcyByZXF1ZXN0ZWQiLgo+Cj4+IEkgYmVsaWV2ZSB0aGUgcG9pbnRzIHlvdSByYWlz
ZWQgYXJlIGZpeGVkIGluIHRoZSB2Miwgb24gdG9wIG9mIHRoaXMgdGhyZWFkLgo+PiBSZS1hcHBs
eWluZyBpdCBvbiB0b3Agb2YgbWFzdGVyIG9uIG15IHNpZGUgZG9lc24ndCBnaXZlIG1lIGFueSB3
YXJuaW5ncyBmb3IKPj4gdGhlIGJyayB0ZXN0cywgYXMgSSBkbyBub3QgY2FzdCB0aGUgcmVzdWx0
IGZyb20gdGhlIGxpYmMgYnJrIGFueW1vcmUsIGFuZAo+PiBtYWtlIGNoZWNrIHJlcG9ydHMgZXhp
c3RpbmcgaXNzdWVzIHdpdGggdGhlIG5hbWUgb2YgdGhlIGZ1bmN0aW9uLCBidXQgbm8KPj4gc3R5
bGUgcHJvYmxlbXMgdGhhdCBkaWQgZXhpc3QgaW4gdjEuIChJIGRvbid0IG1pbmQgY2hhbmdpbmcg
dGhlbSBpZiB5b3UKPj4gd2FudCwgYnV0IHRoZXkgYXJlIHByZXNlbnQgb24gbWFzdGVyIGFzIHdl
bGwpLgo+Cj4+IElmIHlvdSBnaXZlIGEgcXVpY2sgbG9vayBhdCB0aGUgcGF0Y2ggdjIgeW91J2xs
IHNlZSB0aGF0IGluZGVlZCB0aGVyZSBpcyBubwo+PiBtb3JlICh2b2lkICopYnJrKGFkZHIpIG9y
IHN1Y2ggdGhhdCBnZW5lcmF0ZWQgdGhlIHdhcm5pbmdzLCBmb3IgZXhhbXBsZS4KPj4gKFRoZSBz
eXNjYWxscyBzdGlsbCBuZWVkIGl0LCBhcyB0aGV5IHJldHVybiB0aGUgYnJlYWsgZGlyZWN0bHkg
cmF0aGVyIHRoYW4KPj4gYW4gZXJyb3IsIHdoaWNoIGlzIHdoYXQgdGhlIGxpYmMgd3JhcHBlciBk
b2VzLikKPgo+PiBJIG1pZ2h0IGJlIG1pc3Npbmcgc29tZXRoaW5nLCBwbGVhc2UgZG8gdGVsbCBt
ZSBpZiB0aGF0J3MgdGhlIGNhc2UgISBCdXQgSQo+PiBiZWxpZXZlIHRoYXQgdGhlIHYyIF9zaG91
bGRfIGJlIGZyZWUgb2YgdGhvc2UgaXNzdWVzLgo+Cj4gSSB0aG91Z2h0IEkgbXVzdCBoYXZlIHB1
dCB2MSBjb2RlIGludG8gbXkgdjIgYnJhbmNoLiBCdXQgdGhlIHdhcm5pbmdzIGFyZQo+IGFjdHVh
bGx5IHdoZW4gY29tcGlsaW5nIG9uIEFscGluZToKPgo+ICQgbWFrZSBWPTEKPiBnY2MgLUkuLi8u
Li8uLi8uLi9pbmNsdWRlIC1JLi4vLi4vLi4vLi4vaW5jbHVkZQo+IC1JLi4vLi4vLi4vLi4vaW5j
bHVkZS9vbGQvIC1nIC1PMiAtZyAtTzIgLWZuby1zdHJpY3QtYWxpYXNpbmcgLXBpcGUKPiAtV2Fs
bCAtVyAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1MLi4vLi4vLi4vLi4vbGliIGJyazAxLmMgLWxs
dHAgLW8KPiBicmswMQo+IGJyazAxLmM6IEluIGZ1bmN0aW9uICd2ZXJpZnlfYnJrJzoKPiBicmsw
MS5jOjIyOjI3OiB3YXJuaW5nOiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZl
cmVudCBzaXplIFstV2ludC10by1wb2ludGVyLWNhc3RdCj4gICAgMjIgfCAgICAgICAgICAgICAg
ICAgY3VyX2JyayA9ICh2b2lkICopdHN0X3N5c2NhbGwoX19OUl9icmssIDApOwo+ICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCj4gYnJrMDEuYzo1MjozNTogd2FybmluZzogY2Fz
dCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdpbnQtdG8tcG9p
bnRlci1jYXN0XQo+ICAgIDUyIHwgICAgICAgICAgICAgICAgICAgICAgICAgY3VyX2JyayA9ICh2
b2lkICopdHN0X3N5c2NhbGwoX19OUl9icmssIG5ld19icmspOwo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4KPiBnY2MgLUkuLi8uLi8uLi8uLi9pbmNsdWRlIC1J
Li4vLi4vLi4vLi4vaW5jbHVkZQo+IC1JLi4vLi4vLi4vLi4vaW5jbHVkZS9vbGQvIC1nIC1PMiAt
ZyAtTzIgLWZuby1zdHJpY3QtYWxpYXNpbmcgLXBpcGUKPiAtV2FsbCAtVyAtV29sZC1zdHlsZS1k
ZWZpbml0aW9uIC1MLi4vLi4vLi4vLi4vbGliIGJyazAyLmMgLWxsdHAgLW8KPiBicmswMgo+IGJy
azAyLmM6IEluIGZ1bmN0aW9uICdicmtfdmFyaWFudHMnOgo+IGJyazAyLmM6MjQ6Mjg6IHdhcm5p
bmc6IGNhc3QgdG8gcG9pbnRlciBmcm9tIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUgWy1XaW50
LXRvLXBvaW50ZXItY2FzdF0KPiAgICAyNCB8ICAgICAgICAgICAgICAgICBicmtfYWRkciA9ICh2
b2lkICopdHN0X3N5c2NhbGwoX19OUl9icmssIGFkZHIpOwo+ICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXgo+IGJyazAyLmM6IEluIGZ1bmN0aW9uICdicmtfZG93bl92bWFzJzoK
PiBicmswMi5jOjM4OjI4OiB3YXJuaW5nOiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9m
IGRpZmZlcmVudCBzaXplIFstV2ludC10by1wb2ludGVyLWNhc3RdCj4gICAgMzggfCAgICAgICAg
ICAgICAgICAgYnJrX2FkZHIgPSAodm9pZCAqKXRzdF9zeXNjYWxsKF9fTlJfYnJrLCAwKTsKPiAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KPgoKSG93IGlzIHRoaXMgcG9zc2li
bGUgd2hlbiB0c3Rfc3lzY2FsbCAobm93KSB1c2VzIGludHB0cl90PwoKLS0gClRoYW5rIHlvdSwK
UmljaGFyZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
