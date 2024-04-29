Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9536C4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 17:52:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE05E3C888E
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 19:52:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 302AD3C0562
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 19:51:51 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E5CD1600B3E
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 19:51:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEC271F45B;
 Mon, 29 Apr 2024 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714413110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKsXjmM0YlljUFJcOCX+cnKO7Muljfz7yJcneYYa7/U=;
 b=TjG0fArr+7YVxkSj9s18QFKBiZu89T9sv5Pv8rDX1KJMhcFd8BDr0rBFx+bnoG2y/ThIXO
 ICGRYtUFzh79QiOL4NkfI/ou1xPbeMOBOtQQk09Xq0w8vViNC/Bbly8A6x2CQmNwc/kWUC
 V/pHPVklJ37fRi58FK4934DiGe7llws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714413110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKsXjmM0YlljUFJcOCX+cnKO7Muljfz7yJcneYYa7/U=;
 b=Zil9ZGd7BOlwks68I16CM0StrVUXO5mgBInO7l+CvV010KRhLRYEFL96KWAegrvs0RwAd6
 6gOioiUx0kq9YEDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UjatcbWy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="A457+I/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714413109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKsXjmM0YlljUFJcOCX+cnKO7Muljfz7yJcneYYa7/U=;
 b=UjatcbWyLZTyWnX9N3xmBWVTRn2t60St2RSxcQh3JjaGY0BYqG88BtpjC1E05AGkbdETYT
 McBvvtzywiWxh7a25bTNJEcVjDMw/lZ5DFa9jTWKgSpT6E7KoiENZTbtffDKpl/18L2XsD
 lVGt27Lo6OlmC6LKPl2ukQFTay1kTNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714413109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKsXjmM0YlljUFJcOCX+cnKO7Muljfz7yJcneYYa7/U=;
 b=A457+I/GsLZ5tYyB3xcgSOlaKPURGvIis0CLLC92uxfPV/O0tDqcFBJz+bWlS0dhUnMBEA
 Ug+twpd0OZjrV6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4BAB139DE;
 Mon, 29 Apr 2024 17:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eLs6KzXeL2ZCTgAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 29 Apr 2024 17:51:49 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Wei Gao <wegao@suse.com>, Wei Gao <wegao@suse.com>
Date: Mon, 29 Apr 2024 19:51:49 +0200
Message-ID: <9711748.eNJFYEL58v@localhost>
Organization: SUSE
In-Reply-To: <20240425114013.GA284406@pevik>
References: <20240415025100.2103-1-wegao@suse.com>
 <20240425020308.25367-2-wegao@suse.com> <20240425114013.GA284406@pevik>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CEC271F45B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; HAS_ORG_HEADER(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: Add TST_EXP_PASS_PTR_{NULL,
 VOID} macros
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

T24gVGh1cnNkYXksIEFwcmlsIDI1LCAyMDI0IDE6NDA6MTPigK9QTSBHTVQrMiBQZXRyIFZvcmVs
IHdyb3RlOgo+IEhpIFdlaSwKPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1
c2UuY29tPgo+ID4gLS0tCj4gPiAKPiA+ICBpbmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5oIHwgNDUg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDM5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5oIGIvaW5jbHVkZS90c3RfdGVzdF9tYWNyb3MuaAo+
ID4gaW5kZXggMjJiMzlmYjE0Li4xZmIxMzNkZDMgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL3Rz
dF90ZXN0X21hY3Jvcy5oCj4gPiArKysgYi9pbmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5oCj4gPiBA
QCAtMTc4LDYgKzE3OCwyOCBAQCBleHRlcm4gdm9pZCAqVFNUX1JFVF9QVFI7Cj4gPiAKPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXAo+ID4gIAkKPiA+ICAJfSB3aGlsZSAoMCkKPiA+IAo+ID4g
KyNkZWZpbmUgVFNUX0VYUF9QQVNTX1NJTEVOVF9QVFJfKFNDQUxMLCBTU0NBTEwsIEZBSUxfUFRS
X1ZBTCwgLi4uKSAgICAgICAKPiA+ICAgICAgXCArCWRvIHsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKPiA+ICAgICAgIFwgKwkJVEVT
VFBUUihTQ0FMTCk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKPiA+IFwgKwkJICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXAo+ID4gKwkJVFNUX1BBU1MgPSAwOyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXCArCQkgIAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXCArCQlpZgo+
ID4gKFRTVF9SRVRfUFRSID09IEZBSUxfUFRSX1ZBTCkgeyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXAo+ID4gKwkJCVRTVF9NU0dfKFRGQUlMIHwgVFRFUlJOTywgIiBmYWlsZWQiLCAgICAg
ICAgICAgICAgICAgICBcCj4gPiArCQkJICAgICAgICAgU1NDQUxMLCAjI19fVkFfQVJHU19fKTsg
ICAgICAgICAgICAgICAgICAgICAgIFwKPiA+ICsJCSAgICAgICAgYnJlYWs7ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiA+ICsJCX0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiA+
ICsJCSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKPiA+ICsJCWlmIChUU1RfUkVUICE9IDApIHsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiA+ICsJCQlUU1RfTVNHUF8oVEZBSUwgfCBUVEVS
Uk5PLCAiIGludmFsaWQgcmV0dmFsICVsZCIsICAgICAgXAo+ID4gKwkJCSAgICAgICAgICBUU1Rf
UkVULCBTU0NBTEwsICMjX19WQV9BUkdTX18pOyAgICAgICAgICAgICBcCj4gPiArCQkJYnJlYWs7
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiA+ICsJ
CX0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCj4gPiAgICAgIFwgKwkJVFNUX1BBU1MgPSAx
OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKPiA+IFwg
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKPiA+ICAgICAgICAgXCArCX0gd2hpbGUgKDApCj4gPiArCj4gPiAKPiA+
ICAjZGVmaW5lIFRTVF9FWFBfUEFTU19TSUxFTlQoU0NBTEwsIC4uLikgVFNUX0VYUF9QQVNTX1NJ
TEVOVF8oU0NBTEwsCj4gPiAgI1NDQUxMLCAjI19fVkFfQVJHU19fKQo+ID4gIAo+ID4gICNkZWZp
bmUgVFNUX0VYUF9QQVNTKFNDQUxMLCAuLi4pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKPiA+ICAgICAgIFw+IAo+ID4gQEAgLTE4OCw2ICsyMTAsMjEgQEAgZXh0ZXJu
IHZvaWQgKlRTVF9SRVRfUFRSOwo+ID4gCj4gPiAgCQkJVFNUX01TR18oVFBBU1MsICIgcGFzc2Vk
IiwgI1NDQUxMLCAjI19fVkFfQVJHU19fKTsgICAgIFwKPiA+ICAJCj4gPiAgCX0gd2hpbGUgKDAp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAo+ID4gCj4gPiArI2RlZmluZSBUU1RfRVhQX1BBU1NfUFRSXyhTQ0FMTCwgU1NDQUxMLCBG
QUlMX1BUUl9WQUwsIC4uLikgICAgICAgICAgICAgIAo+ID4gICAgICBcICsJZG8geyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAo+ID4g
ICAgICAgXCArCQlUU1RfRVhQX1BBU1NfU0lMRU5UX1BUUl8oU0NBTEwsIFNTQ0FMTCwgICAgICAg
ICAgICAgICAgICAgICAgIAo+ID4gXCArCQkJCQlGQUlMX1BUUl9WQUwsICMjX19WQV9BUkdTX18p
OyAgICAgICAgICBcCj4gPiArCQkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gPiArCQlpZiAoVFNUX1BBU1MpICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gPiArCQkJVFNUX01T
R18oVFBBU1MsICIgcGFzc2VkIiwgI1NDQUxMLCAjI19fVkFfQVJHU19fKTsgICAgIFwKPiA+ICsJ
fSB3aGlsZSAoMCkKPiA+ICsKPiA+ICsjZGVmaW5lIFRTVF9FWFBfUEFTU19QVFJfTlVMTChTQ0FM
TCwgLi4uKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCj4gPiAgICAgIFwgKyAgICAg
ICAgICAgICAgIFRTVF9FWFBfUEFTU19QVFJfKFNDQUxMLCAjU0NBTEwsIE5VTEwsCj4gPiAjI19f
VkFfQVJHU19fKTsKPiBJJ20gc3RpbGwgbm90IHN1cmUgd2hldGhlciBhZGQgVFNUX0VYUF9QQVNT
X1BUUl9OVUxMLCB3aGljaCBpcyBub3QgdXNlZC4KPiBJIHdvbmRlciB3aGF0IG90aGVycyB0aGlu
ayAoaXQgY2FuIGJlIHJlbW92ZWQgYmVmb3JlIG1lcmdlKS4KSSB0b28gdGhpbmsgd2Ugc2hvdWxk
IGFkZCB0aGlzIG1hY3JvIG9ubHkgd2l0aCBhbm90aGVyIHBhdGNoIHdoZXJlIGl0IGlzCmJlaW5n
IHVzZWQuCgpBbHNvLCBJIHdhbnQgdG8gbWVudGlvbiBJIGZpbmQgdGhlc2UgbWFjcm8gbmFtZXMg
YSBsaXR0bGUgYml0IGNvbmZ1c2luZy4KCldlIGhhdmUgVFNUX0VYUF9GQUlMX1BUUl9WT0lEKCks
IHdoaWNoIGV4cGVjdHMgYSBzeXNjYWxsIHRvIGZhaWwgYW5kIHJldHVybgoodm9pZCAqKSAtMS4K
c28gbWF5YmUgd2Ugc2hvdWxkIG5hbWUgVFNUX0VYUF9QQVNTX1BUUl9OT05WT0lEKCkgZm9yIGV4
cGVjdGluZyBhIHN5c2NhbGwKdG8gcGFzcyBhbmQgcmV0dXJuIGFueSBwb2ludGVyIHZhbHVlICE9
ICh2b2lkICopIC0xLgoKSWYgaXQgaXMganVzdCBtZSBjb25mdXNlZCB3aXRoIHRoZXNlIG5hbWVz
LCBwbGVhc2UgZGlzcmVnYXJkIHRoaXMgY29tbWVudC4KPiAKPiA+ICsKPiA+ICsjZGVmaW5lIFRT
VF9FWFBfUEFTU19QVFJfVk9JRChTQ0FMTCwgLi4uKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCj4gPiAgICAgIFwgKyAgICAgICAgICAgICAgIFRTVF9FWFBfUEFTU19QVFJfKFNDQUxM
LCAjU0NBTEwsICh2b2lkICopLTEsCj4gPiAjI19fVkFfQVJHU19fKTsgKwo+ID4gCj4gPiAgLyoK
PiA+ICAKPiA+ICAgKiBSZXR1cm5zIHRydWUgaWYgZXJyIGlzIGluIHRoZSBleHBfZXJyIGFycmF5
Lgo+ID4gICAqLwo+ID4gCj4gPiBAQCAtMzAxLDEwICszMzgsOCBAQCBjb25zdCBjaGFyICp0c3Rf
ZXJybm9fbmFtZXMoY2hhciAqYnVmLCBjb25zdCBpbnQKPiA+ICpleHBfZXJycywgaW50IGV4cF9l
cnJzX2NudCk7PiAKPiA+ICAJfSB3aGlsZSAoMCkKPiA+ICAKPiA+ICAjZGVmaW5lIFRTVF9FWFBf
RkFJTF9QVFJfTlVMTF9BUlIoU0NBTEwsIEVYUF9FUlJTLCBFWFBfRVJSU19DTlQsIC4uLikgICAg
Cj4gPiAgIFw+IAo+ID4gLQlkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiA+IAo+ID4gIAkJVFNUX0VYUF9GQUlM
X1BUUl8oU0NBTEwsICNTQ0FMTCwgTlVMTCwgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ID4g
Cj4gPiAtCQkJRVhQX0VSUlMsIEVYUF9FUlJTX0NOVCwgIyNfX1ZBX0FSR1NfXyk7ICAgICAgICBc
Cj4gPiAtCX0gd2hpbGUgKDApCj4gPiArCQkJRVhQX0VSUlMsIEVYUF9FUlJTX0NOVCwgIyNfX1ZB
X0FSR1NfXyk7Cj4gCj4gKzEKPiAKPiA+ICAjZGVmaW5lIFRTVF9FWFBfRkFJTF9QVFJfVk9JRChT
Q0FMTCwgRVhQX0VSUiwgLi4uKSAgICAgICAgICAgICAgICAgICAgICAgCj4gPiAgIFw+ICAKPiA+
ICAJZG8geyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCj4gPiAKPiA+IEBAIC0zMTQsMTAgKzM0OSw4IEBAIGNvbnN0IGNo
YXIgKnRzdF9lcnJub19uYW1lcyhjaGFyICpidWYsIGNvbnN0IGludAo+ID4gKmV4cF9lcnJzLCBp
bnQgZXhwX2VycnNfY250KTs+IAo+ID4gIAl9IHdoaWxlICgwKQo+ID4gIAo+ID4gICNkZWZpbmUg
VFNUX0VYUF9GQUlMX1BUUl9WT0lEX0FSUihTQ0FMTCwgRVhQX0VSUlMsIEVYUF9FUlJTX0NOVCwg
Li4uKSAgICAKPiA+ICAgXD4gCj4gPiAtCWRvIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ID4gCj4gPiAgCQlUU1Rf
RVhQX0ZBSUxfUFRSXyhTQ0FMTCwgI1NDQUxMLCAodm9pZCAqKS0xLCAgICAgICAgICAgICAgICAg
ICBcCj4gPiAKPiA+IC0JCQlFWFBfRVJSUywgRVhQX0VSUlNfQ05ULCAjI19fVkFfQVJHU19fKTsg
ICAgICAgIFwKPiA+IC0JfSB3aGlsZSAoMCkKPiA+ICsJCQlFWFBfRVJSUywgRVhQX0VSUlNfQ05U
LCAjI19fVkFfQVJHU19fKTsKPiAKPiArMQo+IAo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4KPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+IAo+ID4gICNkZWZpbmUg
VFNUX0VYUF9GQUlMMihTQ0FMTCwgRVhQX0VSUiwgLi4uKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAKPiA+ICAgICAgIFw+ICAKPiA+ICAJZG8geyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCgpSZWdhcmRzLApB
dmluZXNoCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
