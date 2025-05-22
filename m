Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE17C54E90
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 19:39:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB9A63CC88D
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 21:39:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B3CA3C006A
 for <ltp@lists.linux.it>; Thu, 22 May 2025 21:39:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EC2C51A00241
 for <ltp@lists.linux.it>; Thu, 22 May 2025 21:39:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 369B5219E0;
 Thu, 22 May 2025 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747942752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0nqeTYdrSSXySYrEov0N+PRKQ9C4ALuiRMowTEBLjI=;
 b=ahueEoCOxb/FV4rcaa4dp0j1jj7P415LcL5V26wvXIk+l5u2pRnNp4NZvt/MVHFXVILyk1
 IVxKLUTAToQA+4KXENRs66YSekAWEJEkSPTN3a0Cfr0Ormaa/khlrG+eOn1X7kgCvjmfWX
 +tFER8D7gPgFiFaKA7DuowlCVtvXVPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747942752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0nqeTYdrSSXySYrEov0N+PRKQ9C4ALuiRMowTEBLjI=;
 b=PO91CujW+KdtPlmHo+sGulk9qgy9z8N12r1aycHEvf3GZUP5Q0uG+gwVi53fk2LbQizHLU
 SElLX58k4mvu9IDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747942752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0nqeTYdrSSXySYrEov0N+PRKQ9C4ALuiRMowTEBLjI=;
 b=ahueEoCOxb/FV4rcaa4dp0j1jj7P415LcL5V26wvXIk+l5u2pRnNp4NZvt/MVHFXVILyk1
 IVxKLUTAToQA+4KXENRs66YSekAWEJEkSPTN3a0Cfr0Ormaa/khlrG+eOn1X7kgCvjmfWX
 +tFER8D7gPgFiFaKA7DuowlCVtvXVPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747942752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0nqeTYdrSSXySYrEov0N+PRKQ9C4ALuiRMowTEBLjI=;
 b=PO91CujW+KdtPlmHo+sGulk9qgy9z8N12r1aycHEvf3GZUP5Q0uG+gwVi53fk2LbQizHLU
 SElLX58k4mvu9IDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D82F113433;
 Thu, 22 May 2025 19:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e5a2MV99L2h7bQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 May 2025 19:39:11 +0000
Date: Thu, 22 May 2025 21:39:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250522193910.GA28496@pevik>
References: <20250521141655.3202240-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250521141655.3202240-1-wegao@suse.com>
X-Spamd-Result: default: False [-0.50 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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

SGkgV2VpLCBhbGwsCgpAYWxsOiBpcyB0aGlzIGEgY2FuZGlkYXRlIGZvciBhIHJlbGVhc2U/IEl0
J2QgYmUgbmljZSB0byBnZXQgaXQgZml4ZWQuCgo+IFVzaW5nIHNwcmludGYgd2l0aG91dCBsZW5n
dGggY2hlY2tpbmcgaW4gdHN0X3RtcGRpciBtYXkgbGVhZCB0byBidWZmZXIgb3ZlcmZsb3cuCj4g
U28gaW4gdGhpcyBwYXRjaCB1c2Ugb3BlbmF0KCkgaW5zdGVhZCBvZiBvcGVuKCkuCgpMR1RNLCBi
dXQgaXQnZCBiZSBuaWNlIGlmIHdlIGNvdWxkIHVzZSBvbmx5IHJtb2JqYXQoKS4KCkNvdWxkIHlv
dSBwbGVhc2UgcmVtb3ZlIHRoZSB1bnVzZWQgdmFyaWFibGU/Cgp0c3RfdG1wZGlyLmM6IEluIGZ1
bmN0aW9uIOKAmHJtb2JqYXTigJk6CnRzdF90bXBkaXIuYzozMjc6MjE6IHdhcm5pbmc6IHVudXNl
ZCB2YXJpYWJsZSDigJhzdGF0YnVm4oCZIFstV3VudXNlZC12YXJpYWJsZV0KICAzMjcgfCAgICAg
ICAgIHN0cnVjdCBzdGF0IHN0YXRidWY7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICBefn5+
fn5+CgoKU3VnZ2VzdGVkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KCj4gRml4
czoxMjQxCgpUaGlzIGlzIGJldHRlciBhcyBpdCBzaG93cyBsaW5rIGluIEdpdEh1YiB3ZWI6CkZp
eGVzOiAjMTI0MQoKT3IsIElNSE8gYmV0dGVyCkZpeGVzOiBodHRwczovL2dpdGh1Yi5jb20vbGlu
dXgtdGVzdC1wcm9qZWN0L2x0cC9pc3N1ZXMvMTI0MQoKS2luZCByZWdhcmRzLApQZXRyCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
