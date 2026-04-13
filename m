Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C19FF34C5D
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 14:37:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B13C33E4B29
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 16:36:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFC753CCB48
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 16:36:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 38F7D600828
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 16:36:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3F515BD01;
 Mon, 13 Apr 2026 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776091000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbXORhyQsbPWZ+6aQRmWXVL3aCXZhNbfPzQ6FF8e5ec=;
 b=PeP2MGgUYu/kLUEdv4Mb1JijEE0b32/h2dZOkPMXGAMaAvrGwWp2WubIoQdhrtm1CluVoz
 AyfGZ/YzOsEzjq6zcojXsJTQxRmLsz0QshE6gzQ7Nl9HGaAq7vpv+Xt8F3eytAHWk6Fvi0
 dRGDl54YRcqoCXH1rK2UKCc+bzGQKSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776091000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbXORhyQsbPWZ+6aQRmWXVL3aCXZhNbfPzQ6FF8e5ec=;
 b=0ej3HuHHn9PM5PXLHiTKATrtrsDuCSWVRYi6WxW5qwpXmvDhrD2AnX+Ov3d/At+hF4xaX+
 feSMs5eZJDCyajAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776090999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbXORhyQsbPWZ+6aQRmWXVL3aCXZhNbfPzQ6FF8e5ec=;
 b=dUAY/lWLwFaoEsIAxsWBKd0NvdWf2rILdHEfudqxg6r6c9kjFsNwzLCG2V/sOMYtrweavF
 +VaghHBlr9I/XBnwi6/vHmkgDtbl2ifOULEl/92d04WaGMuFceZAVqeDPXXPLIc8ej+59B
 v/br58JTnH2DpC4HB0N68n4TRszhxpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776090999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BbXORhyQsbPWZ+6aQRmWXVL3aCXZhNbfPzQ6FF8e5ec=;
 b=eQjjx/ROlR3zFrovNB/A+yXITBfapUDDoc2Y23fDrehT9ZI6L2Z2mEdNkQev7dJbDEXsxa
 6h6yoXotu4+STgBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6BC64AF29;
 Mon, 13 Apr 2026 14:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PjP1Mnb/3GnSCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 13 Apr 2026 14:36:38 +0000
Date: Mon, 13 Apr 2026 16:36:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <adz_e3PJmL9RPMt7@yuki.lan>
References: <20260413115129.30239-1-chrubis@suse.cz>
 <20260413122243.3915-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260413122243.3915-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Treat kernel ntfs3 as a separate FS
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

SGkhCj4gPiBsaWI6IFRyZWF0IGtlcm5lbCBudGZzMyBhcyBhIHNlcGFyYXRlIEZTCj4gCj4gPiBN
ZWFud2hpbGUgdGhpcyBldmVuIGNhdXNlZCBmYWlsdXJlcywgd2hpY2ggaXMgaG93IHRoaXMgaXNz
dWUgZmluYWx5Cj4gPiBzdXJmYWNlZCB3aXRoIGEgZnVzZSBiYXNlZCBOVEZTIG5vdCBiZWluZyBz
a2lwcGVkIHByb3Blcmx5IGJlY2F1c2UgdGhlCj4gPiB0ZXN0IGxpYnJhcnkgZ290IGNvbmZ1c2Vk
IHdpdGggaGF2aW5nIGJvdGgga2VybmVsIGFuZCBmdXNlIE5URlMKPiA+IGF2YWlsYWJsZS4KPiAK
PiBUd28gdHlwb3M6ICJmaW5hbHkiIC0+ICJmaW5hbGx5IiwgImNhbGxsZWQiIC0+ICJjYWxsZWQi
IChhIGZldyBsaW5lcwo+IGJlbG93KS4KCkkgd2lsbCBmaXggdGhlc2UgYmVmb3JlIGNvbW1pdGlu
Zy4KCj4gU2luY2UgdGhpcyBmaXhlcyBhIHJlYWwgZmFpbHVyZSwgcGxlYXNlIGNvbnNpZGVyIGFk
ZGluZyBhIEZpeGVzOiB0YWcKPiBwb2ludGluZyB0byB0aGUgTFRQIGNvbW1pdCB0aGF0IGludHJv
ZHVjZWQgdGhlIGJyb2tlbiBudGZzIGhhbmRsaW5nLiBJZgo+IHRoZSBpc3N1ZSBwcmVkYXRlcyBh
bnkgc2luZ2xlIGlkZW50aWZpYWJsZSBjb21taXQsIGRyb3BwaW5nIHRoZSB0YWcgaXMKPiBmaW5l
IOKAlCBqdXN0IGNsYXJpZnkgaW4gdGhlIHJlcGx5LgoKSG93ZXZlciB0aGlzIG9uZSBpcyBtb3Jl
IGNvbXBsZXgsIHRoZXJlIGlzbid0IGEgc2luZ2xlIHBhdGNoIHRoYXQgY2F1c2VkCnRoZSBwcm9i
bGVtLCBtb3Jlb3ZlciBpdCB3YXMgdHJpZ2dlcmVkIG9ubHkgYnkgYWRkaXRpb24gb2YgdGhlIG50
ZnMzCmRyaXZlciBpbnRvIHRoZSBrZXJuZWwuCgotLSAKQ3lyaWwgSHJ1YmlzCmNocnViaXNAc3Vz
ZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
