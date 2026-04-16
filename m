Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C71F8A160
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 11:58:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E897E3E2DF3
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:58:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B893A3C2B4B
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 13:58:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5978B60005A
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 13:58:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 67A385BCF3;
 Thu, 16 Apr 2026 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776340699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH7KFTcRTpnw7dTy/HQ9fVSzILZMYaPiY4GP1w04LbE=;
 b=hPGUpo5n/gJ3l9irKTcwSgaPBDtDflZ35pZid/dUotEHJpIAalX557XhnVrXWTzx0FqBOu
 DqjeJFR/TNHkRs4dUs7EzkPmG0bXt4vQQaKfl+Cz4Rb30d8FA5EzigB45J0qOjSevlg+Tk
 1xqyh6I+X9FPHMEZ9v+EmunJonD6Anw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776340699;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH7KFTcRTpnw7dTy/HQ9fVSzILZMYaPiY4GP1w04LbE=;
 b=cYamIZaPDAEYDhxohC3zixZHXHXV6agJxqc4Si+m5Ep3g8FWRVJpJmkGVvMfv3EV0fUtF2
 oKzRY1xNrqKUDBCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ANYelPUZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="VFj3/OS1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776340698;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH7KFTcRTpnw7dTy/HQ9fVSzILZMYaPiY4GP1w04LbE=;
 b=ANYelPUZtZTriLiK8muTMp44tVpPOgrb1IAlX0MAKIl6nB97YPH2FDwPEiv+YmoLjfNkGo
 jXQskL/Rlf149yN3v4OplbuOU80NDa3VQaYBGpEivGNKIhWjk2zTWy8dBqVixKjfv/tquN
 blrxNiNNz88jFePCZtfm/pKQo3JoUhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776340698;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH7KFTcRTpnw7dTy/HQ9fVSzILZMYaPiY4GP1w04LbE=;
 b=VFj3/OS16bzIvZmaCutItpUJ7HL3QyDri6uQiboh/+LzJkcZYJGEfEKR7bfyq6m4Jym88D
 Dkcgs23M68Fd4bDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C1D0593A3;
 Thu, 16 Apr 2026 11:58:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A1OeEdrO4GkCfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Apr 2026 11:58:18 +0000
Date: Thu, 16 Apr 2026 13:58:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260416115801.GA299728@pevik>
References: <20260416-fix_nanosleep_include-v1-1-f584b5556141@suse.com>
 <20260416080306.4018-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260416080306.4018-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 67A385BCF3
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nanosleep: use POSIX runtime detection for CLOCK_MONOTONIC
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

PiBIaSBBbmRyZWEsCgo+IE9uIFRodSwgMTYgQXByIDIwMjYgMDg6NTk6NTkgKzAyMDAsIEFuZHJl
YSBDZXJ2ZXNhdG8gd3JvdGU6Cj4gPiBuYW5vc2xlZXA6IHVzZSBQT1NJWCBydW50aW1lIGRldGVj
dGlvbiBmb3IgQ0xPQ0tfTU9OT1RPTklDCgo+ID4gLSNpbmNsdWRlIDx1bmlzdGQuaD4KPiA+ICAj
aW5jbHVkZSA8c3lzL3dhaXQuaD4KPiA+ICAjaW5jbHVkZSAicG9zaXh0ZXN0LmgiCj4gPiAtCj4g
PiAtI2lmZGVmIF9QT1NJWF9NT05PVE9OSUNfQ0xPQ0sKPiA+IC0jZGVmaW5lIFRFU1RfQ0xPQ0sg
Q0xPQ0tfTU9OT1RPTklDCj4gPiAtI2Vsc2UKPiA+IC0jZGVmaW5lIFRFU1RfQ0xPQ0sgQ0xPQ0tf
UkVBTFRJTUUKPiA+IC0jZW5kaWYKPiA+ICsjaW5jbHVkZSAiaGVscGVycy5oIgoKPiBUaGlzIGFw
cGxpZXMgdG8gMS0yLmMsIDEtMy5jLCAzLTIuYywgYW5kIDctMi5jLiBUaGVzZSBmaWxlcyBjYWxs
Cj4gZm9yaygpIGFuZCBzbGVlcCgpIOKAlCBib3RoIGRlY2xhcmVkIGluIDx1bmlzdGQuaD4g4oCU
IGJ1dCB0aGUgZXhwbGljaXQKPiAjaW5jbHVkZSA8dW5pc3RkLmg+IGlzIHJlbW92ZWQgYW5kIG5v
dyBvbmx5IGFycml2ZXMgdHJhbnNpdGl2ZWx5IHZpYQo+IGhlbHBlcnMuaC4gRWFjaCBmaWxlIHNo
b3VsZCBpbmNsdWRlIHRoZSBoZWFkZXJzIGl0IGRpcmVjdGx5IHVzZXM7Cj4gcGxlYXNlIGtlZXAg
I2luY2x1ZGUgPHVuaXN0ZC5oPiBpbiB0aGVzZSBmb3VyIGZpbGVzLgoKSG0sIHdlIGhhcHBpbHkg
dXNlIGluZGlyZWN0IGluY2x1ZGVzIGluIG5vbi1vcGVuUE9TSVggdGVzdHMKKGluIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvKS4gSXQgY2VydGFpbmx5IGRvZXMgbm90IGhhcm0gdG8gaW5jbHVk
ZQo8dW5pc3RkLmg+IG9uIGVhY2ggcGxhY2Ugd2hpY2ggdXNlcyBfUE9TSVhfTU9OT1RPTklDX0NM
T0NLLgoKSSdkIGhvcGUgYWdlbnQgd291bGQgZmluZCBvdGhlciAnI2lmZGVmIF9QT1NJWF9NT05P
VE9OSUNfQ0xPQ0snIHVzZSB3aXRob3V0Cjx1bmlzdGQuaD4gd2hpY2ggaXMgaW4KdGVzdGNhc2Vz
L29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvY2xvY2tfc2V0dGlt
ZS9oZWxwZXJzLmgKCktpbmQgcmVnYXJkcywKUGV0cgoKPiAtLS0KPiBOb3RlOgoKPiBPdXIgYWdl
bnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUgYWdlbnQgY2FuIHNvbWV0
aW1lcwo+IHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVuIGl0cyBmaW5kaW5n
cyBhcmUgZ2VudWluZS4gSWYKPiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVh
c2UgY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZQo+IHRoZSBzdWdnZXN0aW9ucy4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
