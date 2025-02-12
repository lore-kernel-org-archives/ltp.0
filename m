Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DB1C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 12:35:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 218A33C9A15
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 13:35:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8C3D3C2B0D
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:35:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 48DAB1002865
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:35:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 359F61FBA7;
 Wed, 12 Feb 2025 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739363716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvQR6Jx09+w819X+YS5iLK43TeFWz8EdUSh7so8PqmM=;
 b=MZ8BBY0oDS2qm6OIv9VlHKjYA3yxuHt5SQYDjMwjuzNgb1TLSw1IC6jacnYYhSpiQPlu1X
 K/aH758uswpJwoYWGzOdwNH1AKJB/FBD6Z4rS9lonOF3W+8aEq0ppPY4kc2VvM/vWkbZyt
 ki+reOm+46NJSjyEkHgm8t3mApK921s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739363716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvQR6Jx09+w819X+YS5iLK43TeFWz8EdUSh7so8PqmM=;
 b=PBboVyeEiHjJrSJ8kYOpF5YOYiQ8/UCrXIV7xfyW8+13Ag7M6lQFUEvrBpVGeKkropoL2A
 Kr6iIiuf/uzwb8BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MZ8BBY0o;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PBboVyeE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739363716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvQR6Jx09+w819X+YS5iLK43TeFWz8EdUSh7so8PqmM=;
 b=MZ8BBY0oDS2qm6OIv9VlHKjYA3yxuHt5SQYDjMwjuzNgb1TLSw1IC6jacnYYhSpiQPlu1X
 K/aH758uswpJwoYWGzOdwNH1AKJB/FBD6Z4rS9lonOF3W+8aEq0ppPY4kc2VvM/vWkbZyt
 ki+reOm+46NJSjyEkHgm8t3mApK921s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739363716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvQR6Jx09+w819X+YS5iLK43TeFWz8EdUSh7so8PqmM=;
 b=PBboVyeEiHjJrSJ8kYOpF5YOYiQ8/UCrXIV7xfyW8+13Ag7M6lQFUEvrBpVGeKkropoL2A
 Kr6iIiuf/uzwb8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20F3D13874;
 Wed, 12 Feb 2025 12:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a2wGCISVrGfSCQAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 12 Feb 2025 12:35:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id C4892A095C; Wed, 12 Feb 2025 13:35:11 +0100 (CET)
Date: Wed, 12 Feb 2025 13:35:11 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <boqw2unsm67yetv42vrn4q2d4xsfwxhys5fdfjsei7k526ltmu@zkkhjvfj3bvj>
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-3-amir73il@gmail.com>
 <betolcydydpyyd45jncnozi6g7phk32anhn4kx3jvgrk4kvwzx@5covq3yufbp3>
 <CAOQ4uxgu16dOsU4uuq66CGqXw6wY8c8jK7sL1QheB8kTPU=X+g@mail.gmail.com>
 <20250211175639.GB1911494@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250211175639.GB1911494@pevik>
X-Rspamd-Queue-Id: 359F61FBA7
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_THREE(0.00)[3];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_LAST(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] fanotify03: Add test cases for permission
 events on children
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIDExLTAyLTI1IDE4OjU2OjM5LCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIEFtaXIsIEph
biwKPiAKPiA+IE9uIE1vbiwgRmViIDEwLCAyMDI1IGF0IDQ6MjXigK9QTSBKYW4gS2FyYSA8amFj
a0BzdXNlLmN6PiB3cm90ZToKPiAKPiA+ID4gT24gTW9uIDEwLTAyLTI1IDE2OjEzOjE0LCBBbWly
IEdvbGRzdGVpbiB3cm90ZToKPiA+ID4gPiBWZXJpZnkgdGhhdCBwZXJtaXNzaW9uIGV2ZW50cyBh
cmUgZGVsaXZlcmVkIGlmZiBwYXJlbnQgaXMgd2F0Y2hpbmcKPiA+ID4gPiBjaGlsZHJlbi4KPiAK
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29t
Pgo+IAo+ID4gPiBPdmVyYWxsIGxvb2tzIG9rIGJ1dDoKPiAKPiA+ID4gPiAtICAgICBpZiAocmVh
ZChmZCwgYnVmLCBCVUZfU0laRSkgIT0gLTEpCj4gPiA+ID4gKyAgICAgZXhwX3JldCA9IGV4cF9l
cnJubyA/IC0xIDogMTsKPiA+ID4gPiArICAgICBlcnJubyA9IDA7Cj4gPiA+ID4gKyAgICAgaWYg
KHJlYWQoZmQsIGJ1ZiwgQlVGX1NJWkUpICE9IGV4cF9yZXQgfHwgZXJybm8gIT0gZXhwX2Vycm5v
KSB7Cj4gPiA+ID4gKyAgICAgICAgICAgICB0c3RfcmVzKFRGQUlMLCAicmVhZCgpIGdvdCBlcnJu
byAlZCAoZXhwZWN0ZWQgJWQpIiwgZXJybm8sIGV4cF9lcnJubyk7Cj4gPiA+ID4gICAgICAgICAg
ICAgICBleGl0KDMpOwo+ID4gPiA+ICsgICAgIH0gZWxzZSBpZiAoZXJybm8gPT0gZXhwX2Vycm5v
KSB7Cj4gPiA+ICAgICAgICAgICAgICAgICBeXiBXaHkgaXMgdGhpcyBjb25kaXRpb24gbmVlZGVk
PyBJdCBpcyBhbHdheXMgdHJ1ZSBBRkFJQ1QuCj4gCj4gPiA+ID4gKyAgICAgICAgICAgICB0c3Rf
cmVzKFRJTkZPLCAicmVhZCgpIGdvdCBlcnJubyAlZCBhcyBleHBlY3RlZCIsIGVycm5vKTsKPiA+
ID4gPiArICAgICB9Cj4gCj4gPiA+ID4gICAgICAgU0FGRV9DTE9TRShmZCk7Cj4gCj4gPiA+ID4g
LSAgICAgaWYgKGV4ZWN2ZShGSUxFX0VYRUNfUEFUSCwgYXJndiwgZW52aXJvbikgIT0gLTEpCj4g
PiA+ID4gKyAgICAgZXhwX3JldCA9IGV4cF9lcnJubyA/IC0xIDogMDsKPiA+ID4gPiArICAgICBl
cnJubyA9IDA7Cj4gPiA+ID4gKyAgICAgaWYgKGV4ZWN2ZShGSUxFX0VYRUNfUEFUSCwgYXJndiwg
ZW52aXJvbikgIT0gZXhwX3JldCB8fCBlcnJubyAhPSBleHBfZXJybm8pIHsKPiA+ID4gPiArICAg
ICAgICAgICAgIHRzdF9yZXMoVEZBSUwsICJleGVjdmUoKSBnb3QgZXJybm8gJWQgKGV4cGVjdGVk
ICVkKSIsIGVycm5vLCBleHBfZXJybm8pOwo+ID4gPiA+ICAgICAgICAgICAgICAgZXhpdCg1KTsK
PiA+ID4gPiArICAgICB9IGVsc2UgaWYgKGVycm5vID09IGV4cF9lcnJubykgewo+ID4gPiAgICAg
ICAgICAgICAgICAgXl5eIGFuZCBoZXJlIGFzIHdlbGwuLi4KPiAKPiA+ID4gPiArICAgICAgICAg
ICAgIHRzdF9yZXMoVElORk8sICJleGVjdmUoKSBnb3QgZXJybm8gJWQgYXMgZXhwZWN0ZWQiLCBl
cnJubyk7Cj4gCj4gPiBZb3UgYXJlIHJpZ2h0Lgo+ID4gSSB3YXMgImJhY2twb3J0ZWQiIGZyb20g
dGhlIHByZS1jb250ZW50IHRlc3QuCj4gPiBUaGUgdHdvIGVsc2Ugc3RhdGVtZW50cyBjYW4gYmUg
cmVtb3ZlZCBpbiB0aGlzIHBhdGNoLgo+IAo+IEZZSSBJJ20gZ29pbmcgdG8gbWVyZ2Ugd2l0aCB0
aGUgZGlmZiBiZWxvdyAoZGlzY3Vzc2VkIGNoYW5nZSkuCj4gCj4gSmFuLCBtYXkgSSBhZGQgeW91
ciBSQlQ/CgpZZXMuIEZlZWwgZnJlZSB0byBhZGQ6CgpSZXZpZXdlZC1ieTogSmFuIEthcmEgPGph
Y2tAc3VzZS5jej4KCgkJCQkJCQkJSG9uemEKLS0gCkphbiBLYXJhIDxqYWNrQHN1c2UuY29tPgpT
VVNFIExhYnMsIENSCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
