Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978BBC4332F
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 15:36:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18D6A3CCBE0
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 16:36:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 010DB3C4FC3
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 16:36:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 80E8722BB1F
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 16:36:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF2FC2208B;
 Mon, 21 Nov 2022 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669044995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HpocDWY4ifxSQqRsdLfBgSHPUNUQGvfA6Z9WoBVSTw=;
 b=uuEsgeBSPoTGSAzu6c2Z3cIapd8x58ms7EeZXK/7/4ULVlYWcPAHXiCjk8Od83CjN/GzER
 V2htZ/BOli2HqSsv7OZyiZ47/gtkvk9hO1ZobnpIE73/GBPYDW1qQT38c8w5BuzqhZUqnH
 pxLTj7MBW9RDDXujZ9XlsPXkEwrMhGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669044995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HpocDWY4ifxSQqRsdLfBgSHPUNUQGvfA6Z9WoBVSTw=;
 b=0Fti7yrl6AY5xNNMyNZsVbp/HNxdx8ASWtKu92vCtSCwCliS5Fl7DLG/EvLMqtgfSO7CSL
 PmTvJMfBl9aX+lCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB8021376E;
 Mon, 21 Nov 2022 15:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1sANLQObe2ODRAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 21 Nov 2022 15:36:35 +0000
Message-ID: <452d11fa-b622-e84a-cb51-dae9d2f51498@suse.cz>
Date: Mon, 21 Nov 2022 16:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Li Wang <liwang@redhat.com>
References: <20221116160715.10082-1-mdoucha@suse.cz>
 <CAEemH2dGJ3LzO=OS7hrxxgMJ+T4FguiBFgB3KXirJw-R7zVBBQ@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2dGJ3LzO=OS7hrxxgMJ+T4FguiBFgB3KXirJw-R7zVBBQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] save_restore: Introduce new struct field for
 flags
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTcuIDExLiAyMiA0OjU5LCBMaSBXYW5nIHdyb3RlOgo+IEkgZGlkbid0IHNlZSBhbnkgdGVz
dCB1c2luZyBUU1RfU1JfSUdOT1JFX0VSUiBmbGFnIGluIHRoaXMgcGF0Y2gsCj4gaXMgdGhpcyBw
cmVwYXJlZCBmb3IgdGhlIGNvbWluZyBwYXRjaHNldD8KCk5vLCBJJ3ZlIGFkZGVkIFRTVF9TUl9J
R05PUkVfRVJSIGp1c3QgaW4gY2FzZSB3ZSBuZWVkIHRvIHdvcmsgYXJvdW5kIApzb21lIHN5c2Zp
bGUga2VybmVsIGJ1Z3MgaW4gdGhlIGZ1dHVyZS4gSSBkb24ndCBoYXZlIGFueSB1c2UgZm9yIGl0
IHNvIGZhci4KCj4gICAgICsKPiAgICAgKyNkZWZpbmUgVFNUX1NSX1RDT05GIChUU1RfU1JfVENP
TkZfTUlTU0lORyB8IFRTVF9TUl9UQ09ORl9STykKPiAgICAgKyNkZWZpbmUgVFNUX1NSX1RCUk9L
IChUU1RfU1JfVEJST0tfTUlTU0lORyB8IFRTVF9TUl9UQlJPS19STykKPiAgICAgKyNkZWZpbmUg
VFNUX1NSX1NLSVAgKFRTVF9TUl9TS0lQX01JU1NJTkcgfCBUU1RfU1JfU0tJUF9STykKPiAKPiAK
PiBJJ2Qgc3VnZ2VzdCB1c2luZyAiX1RTS0lQIiB0b8KgcmVwbGFjZcKgIl9TS0lQJyB0byBiZSBj
b25zaXN0ZW50Lgo+IFRoZW4gdGhlIHdob2xlIGZvcm1hdCB3aWxsIGxvb2sgcXVpdGUgcGVyZmVj
dCBhbmQgZWFzeSB0byBtZW1vcml6ZTopLgoKSSBhZ3JlZSB3aXRoIEN5cmlsLCBfU0tJUCBkb2Vz
IG5vdCByZWZlciB0byBhbnkgcmVzdWx0IGZsYWcgc28gaXQgc2hvdWxkIApub3QgbG9vayBsaWtl
IG9uZS4KClRoYW5rcyBmb3IgcmV2aWV3LgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1
c2UuY3oKUUEgRW5naW5lZXIgZm9yIFNvZnR3YXJlIE1haW50ZW5hbmNlClNVU0UgTElOVVgsIHMu
ci5vLgpDT1JTTyBJSWEKS3Jpemlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3plY2ggUmVw
dWJsaWMKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
