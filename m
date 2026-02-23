Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25471EA4FBB
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 13:16:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6B493D0F4A
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 14:16:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4269E3C2C22
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 14:16:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7EA760081B
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 14:16:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C3FF3ECB3;
 Mon, 23 Feb 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 505F53EA68;
 Mon, 23 Feb 2026 13:16:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YRHnES1TnGkUHQAAD6G6ig
 (envelope-from <rbranco@suse.de>); Mon, 23 Feb 2026 13:16:29 +0000
Message-ID: <f40c4b07-4ac5-44c7-9f69-1a22ed480496@suse.de>
Date: Mon, 23 Feb 2026 14:16:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260219225007.218697-1-rbranco@suse.de>
 <DGJWBYPFA8X4.O6DWVQQLRNGT@suse.com>
 <1a05954d-e6b9-4e43-85f2-90ea94e8b68a@suse.de> <aZwzAWcZH3daeTBs@yuki.lan>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <aZwzAWcZH3daeTBs@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7C3FF3ECB3
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Add test using UFFDIO_POISON
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

CgpPbiAyLzIzLzI2IDExOjU5IEFNLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gSGkhCj4+Pj4gKwl1
ZmZkID0gU0FGRV9VU0VSRkFVTFRGRChPX0NMT0VYRUMgfCBPX05PTkJMT0NLLCBmYWxzZSk7Cj4+
PiBNYXliZSB0aGlzIG9uZSBzaG91bGQgYmUgY2xvc2VkIGluc2lkZSBydW4oKSwgb3IgZXZlbiBy
ZW1vdmUgaXQgZnJvbQo+Pj4gc3RhdGljIHZhcmlhYmxlcyBhbmQgcGFzc2VkIHRvIHRoZSB0aHJl
YWQsIHNvIHdlIGtlZXAgaXQgaW5zaWRlIHJ1bigpLgo+PiBCdXQgdGhlbiB3ZSdkIGFsc28gaGF2
ZSB0byBmaXggdGhlIG90aGVyIHRlc3RzLgo+Pj4+ICsKPj4+PiArc3RhdGljIHN0cnVjdCB0c3Rf
dGVzdCB0ZXN0ID0gewo+Pj4+ICsJLnRlc3RfYWxsID0gcnVuLAo+Pj4+ICsJLmNsZWFudXAgPSBj
bGVhbnVwLAo+Pj4+ICt9Owo+Pj4gWW91IGFyIG1pc3NpbmcgdGhlIHJ1bnRlc3QgZW50cnkuCj4+
IFRoZXJlJ3Mgbm8gcnVudGVzdCBmdW5jdGlvbi7CoCBGb3Igbm93IEknbSB1c2luZyB0aGUgb3Ro
ZXIgdGVzdHMgYXMgdGVtcGxhdGUuCj4gUnVudGVzdCBlbnRyeSBpbiBydW50ZXN0L3N5c2NhbGxz
Cj4KCkFyZ2hoaC7CoCBTb3JyeS7CoCBGaXhlZCBpbiB2Ni4KCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
