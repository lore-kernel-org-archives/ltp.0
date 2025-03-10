Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFCCC282DE
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 10:16:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49C663CA216
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 11:16:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89F6D3C2DA5
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 11:16:08 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0A7EC1A0090A
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 11:16:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F75E2115A;
 Mon, 10 Mar 2025 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741601766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq36f47MV6+4/a5GfHs6MEOv8gJxfmRn+3jBByHmU1k=;
 b=Y3qafwTi5nknf8K00cIFxIMjPYMIYeHNBbQezjPVMvi4ZLORi7OqpOhf/ZhNrKnHyOkQpK
 fhj306o03fYvGK5I/+bWfUKJ9AVaN+6kqntS7YpgCj4ulvy0BorV3Jzr1JXLHbZetVvUEh
 wvTGAzyl/UKJzcc6ShckOeJJT/EU2oA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741601766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq36f47MV6+4/a5GfHs6MEOv8gJxfmRn+3jBByHmU1k=;
 b=H5Zez49KopbizXXsPmT9o8kkMX8gv0bcppphAwL6MYc0C1DrtL+yEF/uFVwVCaT2n9btqM
 i6dax+ZwkU+42JAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Px95udE0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XUc0jWvO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741601765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq36f47MV6+4/a5GfHs6MEOv8gJxfmRn+3jBByHmU1k=;
 b=Px95udE0C0CfP26Pm7U2hAfOnruLbLQ+rTP79yCvn3UcERxZ7BsQ/YIqoMn+on11mlTo3R
 FZjySlHSm9aFH6BbS6lM3Gnc0TBqKu522vAOurH0U2zQ+y6RJZAw/T0UknshHwj7ljdRgS
 92g0WJqYiNW0WUv3zU/PBhmMi8H6HVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741601765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq36f47MV6+4/a5GfHs6MEOv8gJxfmRn+3jBByHmU1k=;
 b=XUc0jWvOEUl3x9Chcoc5fM6GBNX3bknQziq2wWjuvLeu5uctQeDnhYzJe7i2wAegMnluC6
 sKq7B7B7jxWmYvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3C7E139E7;
 Mon, 10 Mar 2025 10:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dEM7L+S7zmdNZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Mar 2025 10:16:04 +0000
Date: Mon, 10 Mar 2025 11:16:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250310101603.GA396000@pevik>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-3-pvorel@suse.cz>
 <Z8sef_gY0UA6W1M0@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z8sef_gY0UA6W1M0@yuki.lan>
X-Rspamd-Queue-Id: 2F75E2115A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/5] lib: Allow test to have positional args
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSEKPiBBbHNvIGlzbid0IHRoZSBwYXRjaCBtaXNzaW5nIHNvbWV0aGluZz8KCj4gVGhlcmUg
YXJlIG9ubHkgbW9kaWZpY2F0aW9ucyB0byB0c3RfdGVzdC5jIGFuZCB0ZXN0X3Rlc3QuaC4KCkZZ
SSBJIHdhbnRlZCB0byBzZXBhcmF0ZSB0aGlzIGNoYW5nZSBmcm9tIHRoZSBhY3R1YWwgdXNlIChu
ZXh0IOKAkyAzcmQgY29tbWl0KS4KVGhhdCdzIHdoeSBJIG1lbnRpb25lZCBpdCBpbiB0aGUgY29t
bWl0IG1lc3NhZ2UuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
