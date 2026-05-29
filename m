Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3B4CD4F54
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 16:35:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C183F3E765F
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 18:35:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8DFC3C6FCD
 for <ltp@lists.linux.it>; Fri, 29 May 2026 18:35:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 227A11000D59
 for <ltp@lists.linux.it>; Fri, 29 May 2026 18:35:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC1F567460;
 Fri, 29 May 2026 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780072500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjGKRK5bJsXErSjeWlIywh1wZjHndX7kZ80BRz8rz90=;
 b=FcOQDsJ9qniLrRbsDRenJWXKdKqoVxPPMDSN4I8YVxzZWF5at04rqiZihYmiRZGuFHOni/
 Vsw3sI0cqZEhrHKUQl9+0seQ6z2glwEjV2ZaFGXX/zVRb9WihhvFhuCQU67MLUUAIBMwF8
 rF89sT5awCn6kYkIGRw0ePwgaN/j4Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780072500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjGKRK5bJsXErSjeWlIywh1wZjHndX7kZ80BRz8rz90=;
 b=dLeimIgSYZt8TPO1dgQwVc+CEJDZ63ZOYRpZbUC5RbcufVCAYvwieBQPYWtuu7vCTGRWpq
 jXrEjyDHe9JYkyDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ycG5rtI5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lHZy+IpX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780072495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjGKRK5bJsXErSjeWlIywh1wZjHndX7kZ80BRz8rz90=;
 b=ycG5rtI5Pq0zesuVUEYUX/jjZO5YUoO6tu0W1y1UTQUATdX0VXJ7HOY1OQXeB9rWo9yFHl
 4VZWp7BEasSIzDcnaPlTpjP9XyZtie+SDBGP/PLtkLzZ+dIc4tpjOtuFV9G/q8hAofAdc3
 eErKPR+bMubUTw0eoAysXvqcM9aVlWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780072495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjGKRK5bJsXErSjeWlIywh1wZjHndX7kZ80BRz8rz90=;
 b=lHZy+IpXdodGD5eggOssD83hO3iS/zpGGlsje4KNS/9Zii5RS0jrgGxvlxHHFJGDfEzsRI
 BcszhGSaN8q8oGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EBB6779A7;
 Fri, 29 May 2026 16:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YuENHS/AGWpSfQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 29 May 2026 16:34:55 +0000
Date: Fri, 29 May 2026 18:34:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20260529163420.GC294659@pevik>
References: <20260528162920.914321-1-amir73il@gmail.com>
 <20260528162920.914321-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260528162920.914321-2-amir73il@gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BC1F567460
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] fanotify13: fix test failure when running
 iterations
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKaXQgYWxzbyBmYWlscyBvbiBvcGVuU1VTRSBMZWFwIDQyLjIgZHVlIG1pc3Npbmcg
cmVuYW1lYXQyICh0aGUgc2FtZSBmaXggYXMgZm9yCm11c2wgZGVzY3JpYmVkIGluIHByZXZpb3Vz
IGVtYWlsKS4KCj4gKwlpZiAodHN0X3ZhcmlhbnQgJiYgKHRjLT5tYXNrICYgRkFOX0RFTEVURV9T
RUxGKSAmJgo+ICsJICAgICghb3ZsX2JpbmRfbW91bnRlZCB8fCByZW5hbWVfZXhjaGFuZ2VfdW5z
dXBwb3J0ZWQpKSB7Cj4gKwkJLyogVGhlIGV2aWN0aW9uIG9mIGJhc2UgZnMgaW5vZGVzIGlzIGRl
ZmVyZWQgZHVlIHRvIG92ZXJsYXkgaGVsZCByZWZlcmVuY2UgKi8KCldoaWxlIHdlIGFyZSBhdCBp
dCwgd2Ugc2hvdWxkIGZpeCBvbGQgdHlwbzoKVHlwbzogImRlZmVyZWQiIOKGkiAiZGVmZXJyZWQi
LgoKS2luZCByZWdhcmRzLApQZXRyCgo+ICsJCXRzdF9yZXMoVENPTkYsICJvdmVybGF5ZnMgYmFz
ZSBmcyBjYW5ub3QgYmUgd2F0Y2hlZCBmb3IgZGVsZXRlIHNlbGYgZXZlbnRzIik7Cj4gKwkJcmV0
dXJuOwo+ICsJfQo+ICsKPiAgCWlmIChmaWxlc3lzdGVtX21hcmtfdW5zdXBwb3J0ZWQgJiYgbWFy
ay0+ZmxhZyAhPSBGQU5fTUFSS19JTk9ERSkgewo+ICAJCUZBTk9USUZZX01BUktfRkxBR1NfRVJS
X01TRyhtYXJrLCBmaWxlc3lzdGVtX21hcmtfdW5zdXBwb3J0ZWQpOwo+ICAJCXJldHVybjsKPiBA
QCAtMjEyLDExICsyMjAsNiBAQCBzdGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBudW1i
ZXIpCj4gIAkJCXRzdF9yZXMoVENPTkYsICJvdmVybGF5ZnMgYmFzZSBmcyBjYW5ub3QgYmUgd2F0
Y2hlZCB3aXRoIG1vdW50IG1hcmsiKTsKPiAgCQkJZ290byBvdXQ7Cj4gIAkJfQo+IC0JCWlmICh0
Yy0+bWFzayAmIEZBTl9ERUxFVEVfU0VMRikgewo+IC0JCQkvKiBUaGUgZXZpY3Rpb24gb2YgYmFz
ZSBmcyBpbm9kZXMgaXMgZGVmZXJlZCBkdWUgdG8gb3ZlcmxheSBoZWxkIHJlZmVyZW5jZSAqLwo+
IC0JCQl0c3RfcmVzKFRDT05GLCAib3ZlcmxheWZzIGJhc2UgZnMgY2Fubm90IGJlIHdhdGNoZWQg
Zm9yIGRlbGV0ZSBzZWxmIGV2ZW50cyIpOwo+IC0JCQlnb3RvIG91dDsKPiAtCQl9CgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
