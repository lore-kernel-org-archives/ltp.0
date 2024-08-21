Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E30C52D7C
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 09:37:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 579443D2269
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 11:37:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1FFB3D115D
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 11:37:17 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 08A1560A768
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 11:37:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE61D20054;
 Wed, 21 Aug 2024 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724233036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugs6te0X/nonWu+6e1llRg5ZWyrX5/9pXfX8C9uNt/s=;
 b=X6xJL1j7aIczt+Jot9AVVJpfTy36RlQ6lMtZLyN9Obq/N7pJqE4rQt05+gAI7ob+W/Zjv9
 W8nURoe4qW55TkFNEoCKinMz8/1VwRqr0M/GF+3pOqnI5HRLCnPw8NiVZ9RpHwZGG+KC3s
 IVTz/QWgD99Ki2fBPx0bVNikyvGx5LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724233036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugs6te0X/nonWu+6e1llRg5ZWyrX5/9pXfX8C9uNt/s=;
 b=aZN2wIx0foqspEJpa+JEIK9oLPM+qhMh8reqhJgTyAR9XwQKUVX+xw7oPqbY7ybq+eqpU3
 PrwKFOCqs9yuSLCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="KjWUgnX/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="o9mRL/8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724233035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugs6te0X/nonWu+6e1llRg5ZWyrX5/9pXfX8C9uNt/s=;
 b=KjWUgnX//2WlwC2F/DbYPutm1ry1CqKhPnVOrnW3EA1V1s/7DaqrRqOWJqGNLANPQnKSqV
 FKh2pHdRoPERNX19almHWmPuFMKHyetsM//4pBPHCF9qoYk90PIHIFpFUfrNudfqZXbMnu
 oEJSpeYZoLCnHt+pYoABt5RJcLM3bqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724233035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugs6te0X/nonWu+6e1llRg5ZWyrX5/9pXfX8C9uNt/s=;
 b=o9mRL/8Omadwdo/LhSKHta+vRPw4pQMOAWLcy7odw5dgqc4oBOvpF2PuplOSd6t/Ty7HMT
 /LiSdFbYEKzK9hBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFC1C139C2;
 Wed, 21 Aug 2024 09:37:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mL/tNUu1xWb9VQAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 21 Aug 2024 09:37:15 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 21 Aug 2024 11:37:15 +0200
Message-ID: <2522568.XAFRqVoOGU@localhost>
Organization: SUSE
In-Reply-To: <20240726095546.1041726-1-pvorel@suse.cz>
References: <20240726095546.1041726-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: EE61D20054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 HAS_ORG_HEADER(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] lib: print kernel version
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

SGkgUGV0ciwKCkkgdGhpbmsgdGhpcyBpcyB2ZXJ5IGhlbHBmdWwuIFRoYW5rIHlvdSEKClJldmll
d2VkLWJ5OiBBdmluZXNoIEt1bWFyIDxha3VtYXJAc3VzZS5kZT4KZm9yIGFsbCBwYXRjaGVzIGlu
IHNlcmllcy4KCk9uIEZyaWRheSwgSnVseSAyNiwgMjAyNCAxMTo1NTo0M+KAr0FNIEdNVCsyIFBl
dHIgVm9yZWwgd3JvdGU6Cj4gSGksCj4gCj4gYSBmb2xsb3cgdXAgb2YgNWNhYmYyYmVhNyAoInRz
dF90bXBkaXI6IFByaW50IHVzZWQgdGVtcG9yYXJ5IGRpciBhbmQgaXRzCj4gZmlsZXN5c3RlbSIp
IHdoaWNoIHNob3VsZCBoZWxwIGRlYnVnZ2luZyBvZiBMVFAgZmFpbHVyZSByZXBvcnRzLgo+IAo+
IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4gCj4gUGV0ciBWb3JlbCAoMyk6Cj4gICBsaWI6IFByaW50
IHRlc3RlZCBrZXJuZWwgYW5kIGFyY2gKPiAgIHRzdF90ZXN0LnNoOiBsaWI6IFByaW50IHRlc3Rl
ZCBrZXJuZWwgYW5kIGFyY2gKPiAgIHRzdF90ZXN0OiBQcmludCB1c2VkIHRlbXBvcmFyeSBkaXIg
YW5kIGl0cyBmaWxlc3lzdGVtCj4gCj4gIGxpYi90c3RfdGVzdC5jICAgICAgICAgICAgfCA2ICsr
KysrKwo+ICB0ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoIHwgMiArKwo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKQo+IAo+IAoKUmVnYXJkcywKQXZpbmVzaAoKCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
