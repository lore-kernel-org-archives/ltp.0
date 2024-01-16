Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0F8C47077
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 12:12:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 405303CE32D
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 13:12:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FF333CCA4E
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 13:12:40 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76B7A1001123
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 13:12:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C07A1FB9F;
 Tue, 16 Jan 2024 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705407159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9McjicnpPdUlzs8wokQ34Uw9redligXllqnFWjT2TWE=;
 b=CR1GDdrvl4t5zuGcqy8JQB6GED4dDA4u9hEvzpAbmu91CLdWJ824wFBdK3Ao5FajkJf/JW
 NvqyPBzaHFdKQpAFkdbHLywxLy7GuM5f2xFwaZbf0dEx6/XzkP9Bi7gmEjFGNDVO8gqlSb
 7H/wJdU49xTWMJ9LXM15brg3eQXjOJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705407159;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9McjicnpPdUlzs8wokQ34Uw9redligXllqnFWjT2TWE=;
 b=MIFb+687r5OnanUnHT1dBwwr9rkbz3DD0XM4AkfR9N/GgyYrGZRG2alslyOhZz7pE+a95r
 KxtNg7gfTXgx8jBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705407157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9McjicnpPdUlzs8wokQ34Uw9redligXllqnFWjT2TWE=;
 b=kkZcl4LkdjSuraPL0uDorViFtdH8U4Kl8FfQ/QNxrnScsDvBGiiWxIHPvZSS61JZZdhYTZ
 L3NYqgiraaW1aYqVJ04K1lnPQNJ1U9vXO8OTg1dasom5CP1ErgXIctJGWB0/Sgu1QW0zXA
 wOD5pqHLJb/XdXlJTa3tvdsQ7VrUY4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705407157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9McjicnpPdUlzs8wokQ34Uw9redligXllqnFWjT2TWE=;
 b=4vVAzHDBIJ3UkIuvYbHXel7dyewW3t/VBa99MMozle40mNm6nte0ROB+CF5Fgz4xCkAVBd
 7mS5hP8CKtIb6PBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 279FF13751;
 Tue, 16 Jan 2024 12:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q5X6BrVypmWuRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Jan 2024 12:12:37 +0000
Date: Tue, 16 Jan 2024 13:12:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240116121235.GA2582913@pevik>
References: <20240116031728.2500892-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240116031728.2500892-1-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kkZcl4Lk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4vVAzHDB
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[23.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5C07A1FB9F
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: fix compilation errors due to missing
 TCA_TCINDEX_ constants
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
Cc: jhs@mojatatu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksLAoKPiBUaGUgY2hhbmdlIGFkZHJlc3NlcyBjb21waWxhdGlvbiBlcnJvcnMgZW5jb3Vu
dGVyZWQgaW4gdGhlIHRjaW5kZXgwMS5jCj4gdGVzdCB3aGVuIGNvbXBpbGVkIGFnYWluc3Qga2Vy
bmVsLTYuNyBhbmQgYWJvdmUuCgoiYWdhaW5zdCBrZXJuZWwtNi43Ii4gQnV0IDgyYjI1NDVlZDlh
IHdpbGwgYmUgcmVsZWFzZWQgaW4gNi44LCByaWdodD8KCj4gICB0Y2luZGV4MDEuYzo2Nzo0OiBl
cnJvcjog4oCYVENBX1RDSU5ERVhfTUFTS+KAmSB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhIGZ1
bmN0aW9uKTsKPiAgICAgIGRpZCB5b3UgbWVhbiDigJhUQ0FfQ09ERUxfTUFY4oCZPwo+ICAgICAg
e1RDQV9UQ0lOREVYX01BU0ssICZtYXNrLCBzaXplb2YobWFzayksIE5VTEx9LAo+ICAgICAgIF5+
fn5+fn5+fn5+fn5+fn4KPiAgICAgICBUQ0FfQ09ERUxfTUFYCj4gICB0Y2luZGV4MDEuYzo2ODo0
OiBlcnJvcjog4oCYVENBX1RDSU5ERVhfU0hJRlTigJkgdW5kZWNsYXJlZCBoZXJlIChub3QgaW4g
YSBmdW5jdGlvbik7Cj4gICAgICBkaWQgeW91IG1lYW4g4oCYVENBX0ZMT1dfUlNISUZU4oCZPwo+
ICAgICAge1RDQV9UQ0lOREVYX1NISUZULCAmc2hpZnQsIHNpemVvZihzaGlmdCksIE5VTEx9LAo+
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+Cj4gICAgICAgVENBX0ZMT1dfUlNISUZUCj4gICBDQyB0
ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE2LTcxMTcKPiAgIENDIHV0aWxzL3NjdHAvZnVuY190ZXN0cy90
ZXN0X2dldG5hbWVfdjYubwo+ICAgdGNpbmRleDAxLmM6Njk6NDogZXJyb3I6IOKAmFRDQV9UQ0lO
REVYX0NMQVNTSUTigJkgdW5kZWNsYXJlZCBoZXJlIChub3QgaW4gYSBmdW5jdGlvbik7Cj4gICAg
ICBkaWQgeW91IG1lYW4g4oCYVENBX0ZMT1dFUl9DTEFTU0lE4oCZPwo+ICAgICAge1RDQV9UQ0lO
REVYX0NMQVNTSUQsICZjbHNpZCwgc2l6ZW9mKGNsc2lkKSwgTlVMTH0sCj4gICAgICAgXn5+fn5+
fn5+fn5+fn5+fn5+fgo+ICAgICAgIFRDQV9GTE9XRVJfQ0xBU1NJRAoKPiBUaGUgZXJyb3JzIHdl
cmUgZHVlIHRvIHRoZSByZW1vdmFsIG9mIGNlcnRhaW4gVENBX1RDSU5ERVhfIGNvbnN0YW50cwo+
IGZyb20gdGhlIGtlcm5lbCdzIHVzZXIgQVBJICh1YXBpKSwgYXMgaW5kaWNhdGVkIGJ5IHRoZSBr
ZXJuZWwgY29tbWl0LgoKPiAgIGNvbW1pdCA4MmIyNTQ1ZWQ5YSAobmV0L3NjaGVkOiBSZW1vdmUg
dWFwaSBzdXBwb3J0IGZvciB0Y2luZGV4IGNsYXNzaWZpZXIpCgo+IFRoZSByZWFzb24gd2h5IEkg
ZGlkbid0IGFkZCB0aGlzIGludG8gTFRQIGxpYnJhcnkgaXMgdGhhdCB0aGUgZGVmaW5lcwo+IGhh
dmUgYmVlbiBkcm9wcGVkIHdlIGp1c3QgbmVlZCB0byBzYXRpc2Z5IHRoaXMgb25lIGNhc2UuCgor
MSBmb3IgYWRkaW5nIGVudW0gaGVyZSBpbnN0ZWFkIG9mIHdyaXRpbmcgbTQgYXV0b3Rvb2xzIGNo
ZWNrLgoKPiBOb3RlczoKPiAgICAgV2UgbmVlZCB0byBtZXJnZSB0aGlzIHBhdGNoIGJlZm9yZSB0
aGUgbmV3IHJlbGVhc2UuCisxCgpSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+CgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
