Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8F3C2A072
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 07:49:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC6EA3C1B25
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 08:49:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D90BE3C1B25
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 08:49:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 45C18600550
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 08:49:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEDAA5BE32;
 Mon,  5 Jan 2026 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767599354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRcTweFj3VN6oLqDOFAnNaQNXbU3LpLu16B7Bc6iSTI=;
 b=xTX8b3aHSul20JJttzYLOvw2zmP+D0zMyPGJ4D/WYynhhpSxRLGZe1d8uUjLGWq1UAWaFr
 Lbjx5UCIYpEkb5s5xO9ZjY7njUghBpeq4JphAI8t8gGzT2Sl/5boAKnDpW3JyAC4cfjYp6
 Cus5ToFYZsmZbSfTAe3Jwe0U/EBsxaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767599354;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRcTweFj3VN6oLqDOFAnNaQNXbU3LpLu16B7Bc6iSTI=;
 b=x0Xbpmc86ek37RnJIcP5HxCm9DeiQfoMkru36dWtNvHmTad5eodWKRk/ZAMBqtArHV+r+d
 z6tpQR2mh6NGbwCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767599353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRcTweFj3VN6oLqDOFAnNaQNXbU3LpLu16B7Bc6iSTI=;
 b=FqHkr21D2MpE1IFLHDXZt0Ra8GOS4upDZcFniXCCWFTon8zGqK17wCLhu66d+Zoa92aink
 ytkTDQRllCjgAMx/E02h4A7t5nQCQFlZijGxTP/1oVNQXd3fcNsvC3wmGPE9pIxz7xiLVh
 xJY2Ruu466hq8dcrWgG1sS6wKQD1vm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767599353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRcTweFj3VN6oLqDOFAnNaQNXbU3LpLu16B7Bc6iSTI=;
 b=cwcCmcILQeZUhI7gskFw1zddtxueitcvc6lTFRwYo5bE9OwyMZ0EATR5pY6Fd5xA+/1ufr
 3Bo8AHv7d+xy1mBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 792EB3EA63;
 Mon,  5 Jan 2026 07:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T/s2F/lsW2lGMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Jan 2026 07:49:13 +0000
Date: Mon, 5 Jan 2026 08:49:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260105074908.GA589722@pevik>
References: <20251222094428.87910-1-pvorel@suse.cz>
 <DFGGXHDQ8OSM.36FM2U880AQKZ@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFGGXHDQ8OSM.36FM2U880AQKZ@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] swapon03: Try to swapon() as many files until
 it fails
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

PiBIaSEKCj4gPiAtCWNoYXIgY21kX2J1ZmZlclsyNTZdOwo+ID4gKwljaGFyIGNtZF9idWZmZXJb
RklMRU5BTUVfTUFYKzI4XTsKCj4gSSdtIG5vdCBzdXJlIGlmICsyOCBpcyBuZWVkZWQuCgpJIGRl
c2NyaWJlZCB0aGUgcmVhc29uIGluIHRoZSBjb21taXQgbWVzc2FnZToKCglJdCB3YXMgcmVxdWly
ZWQgdG8gaW5jcmVhc2UgY21kX2J1ZmZlciBzaXplIHRvIGF2b2lkIGRpcmVjdGl2ZSBvdXRwdXQK
ICAgIG1heSBiZSB0cnVuY2F0ZWQgd2FybmluZy4KCkkgZ2V0IHdhcm5pbmcgb24gc21hbGxlciBz
aXplOgoKc3dhcG9uMDMuYzo3NDo2MDogd2FybmluZzog4oCYJXPigJkgZGlyZWN0aXZlIG91dHB1
dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcgdXAgdG8gNDA5NSBieXRlcyBpbnRvIGEgcmVnaW9u
IG9mIHNpemUgNDA4NyBbLVdmb3JtYXQtdHJ1bmNhdGlvbj1dCiAgIDc0IHwgICAgICAgICBzbnBy
aW50ZihjbWRfYnVmZmVyLCBzaXplb2YoY21kX2J1ZmZlciksICJncmVwIC1xICclcy4qZmlsZScg
L3Byb2Mvc3dhcHMiLCBmaWxlbmFtZSk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefgouLi4uLi4KICAgOTQgfCAgICAg
ICAgICAgICAgICAgY2hlY2tfYW5kX3N3YXBvZmYoZmlsZW5hbWUpOwogICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fgpJbiBmaWxlIGluY2x1ZGVkIGZyb20g
L3Vzci9pbmNsdWRlL3N0ZGlvLmg6OTcwLAogICAgICAgICAgICAgICAgIGZyb20gc3dhcG9uMDMu
YzoxNzoKSW4gZnVuY3Rpb24g4oCYc25wcmludGbigJksCiAgICBpbmxpbmVkIGZyb20g4oCYY2hl
Y2tfYW5kX3N3YXBvZmbigJkgYXQgc3dhcG9uMDMuYzo3NDoyLAogICAgaW5saW5lZCBmcm9tIOKA
mGNsZWFuX3N3YXDigJkgYXQgc3dhcG9uMDMuYzo5NDozOgovdXNyL2luY2x1ZGUveDg2XzY0LWxp
bnV4LWdudS9iaXRzL3N0ZGlvMi5oOjY4OjEwOiBub3RlOiDigJhfX2J1aWx0aW5fX19zbnByaW50
Zl9jaGvigJkgb3V0cHV0IGJldHdlZW4gMjkgYW5kIDQxMjQgYnl0ZXMgaW50byBhIGRlc3RpbmF0
aW9uIG9mIHNpemUgNDA5NgogICA2OCB8ICAgcmV0dXJuIF9fYnVpbHRpbl9fX3NucHJpbnRmX2No
ayAoX19zLCBfX24sIF9fVVNFX0ZPUlRJRllfTEVWRUwgLSAxLAogICAgICB8ICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgogICA2OSB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19nbGliY19vYmpz
aXplIChfX3MpLCBfX2ZtdCwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgIDcwIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBfX3ZhX2FyZ19wYWNrICgpKTsKCktpbmQgcmVnYXJkcywKUGV0
cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
