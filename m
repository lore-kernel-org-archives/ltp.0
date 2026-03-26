Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E6410A1E7C
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:37:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64CFF3C9D72
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 12:37:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E8703C9C4E
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 12:37:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AFB6D10008F4
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 12:37:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F4334D295;
 Thu, 26 Mar 2026 11:37:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAA0A4A0A3;
 Thu, 26 Mar 2026 11:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NrffK2kaxWmpcgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 26 Mar 2026 11:37:13 +0000
Message-ID: <33458536-f2e1-4ab8-a7b7-5882481dfa9b@suse.de>
Date: Thu, 26 Mar 2026 12:37:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <69c4f09a.df0a0220.10eb49.07d8@mx.google.com>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <69c4f09a.df0a0220.10eb49.07d8@mx.google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 3F4334D295
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Minor fixes
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

Ck9uIDMvMjYvMjYgOTozOCBBTSwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBIaSByaWNhcmRv
LAo+Cj4+ICsJaWYgKHBhZ2UpIHsKPj4gKwkJU0FGRV9NVU5NQVAocGFnZSwgcGFnZV9zaXplKTsK
Pj4gKwkJU0FGRV9NVU5NQVAoY29weV9wYWdlLCBwYWdlX3NpemUpOwo+PiArCQlwYWdlID0gTlVM
TDsKPj4gKwl9Cj4gVGhpcyBpcyBnb25uYSBUQlJPSyB3aGVuIGNvcHlfcGFnZSBpcyBOVUxMLiBU
aGUgc2FtZSBhcHBseSB0byBhbGwgb3RoZXIKPiB0ZXN0cyB3aGljaCBhcmUgYWZmZWN0ZWQgYnkg
dGhlIHNhbWUgYnVnLgoKRml4ZWQgaW4gdjMuCgpCVFcsIHdlIGhhdmUgYSBtaW5vciBkaWZmZXJl
bmNlIGluIHRlc3RzOgoKJCBkaWZmIHVzZXJmYXVsdGZkMDMuYyB1c2VyZmF1bHRmZDA2LmMKCjzC
oCDCoCDCoCDCoCDCoHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJSZWNlaXZlZCB1bmV4cGVjdGVk
IFVGRkRfRVZFTlQgJWQiLCAKbXNnLmV2ZW50KTsKLS0tCiA+wqAgwqAgwqAgwqAgwqB0c3RfYnJr
KFRGQUlMLCAiUmVjZWl2ZWQgdW5leHBlY3RlZCBVRkZEX0VWRU5UICVkIiwgbXNnLmV2ZW50KTsK
CkkgdGhpbmsgd2Ugc2hvdWxkIGhhdmUgVEZBSUwsIFdEWVQ/CgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
