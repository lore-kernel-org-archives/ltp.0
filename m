Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66327F8A149
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 08:51:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E75293E263D
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 10:51:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69A263D87C1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:51:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CD2E860075A
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:51:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 742296A984;
 Thu, 16 Apr 2026 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776329462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyskFEnPVoW7mHuT0JVLRTCT6K3QAIAx+ROsZ1IO4x4=;
 b=WDUWleMKkvc1PSEZdVdPaCN/WkIP6I35ej2uUndLcJpKgn789ixNLBHkcE//VY2n0r2QOe
 tAXSbOCs8Aduq8HWNdjXHbgJQQJw7h+Ey5W/RZDOUeP9BH/cXeL48JbSgkH8Rp20xlIYMX
 agxi7u9dXB4MrF8kovDbWFTKHvc37Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776329462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyskFEnPVoW7mHuT0JVLRTCT6K3QAIAx+ROsZ1IO4x4=;
 b=81PV0q1BiiPWWPjAobjtP2AaRlR/i5bBiq3fpNhq/xLkCTYwpMG1bECT+lx51rDSpGIdxx
 /0AmjTN3zwL7x0Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776329462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyskFEnPVoW7mHuT0JVLRTCT6K3QAIAx+ROsZ1IO4x4=;
 b=WDUWleMKkvc1PSEZdVdPaCN/WkIP6I35ej2uUndLcJpKgn789ixNLBHkcE//VY2n0r2QOe
 tAXSbOCs8Aduq8HWNdjXHbgJQQJw7h+Ey5W/RZDOUeP9BH/cXeL48JbSgkH8Rp20xlIYMX
 agxi7u9dXB4MrF8kovDbWFTKHvc37Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776329462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyskFEnPVoW7mHuT0JVLRTCT6K3QAIAx+ROsZ1IO4x4=;
 b=81PV0q1BiiPWWPjAobjtP2AaRlR/i5bBiq3fpNhq/xLkCTYwpMG1bECT+lx51rDSpGIdxx
 /0AmjTN3zwL7x0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56BF24BE91;
 Thu, 16 Apr 2026 08:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0u6OE/ai4GmiRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Apr 2026 08:51:02 +0000
Date: Thu, 16 Apr 2026 10:50:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Matt Ochs <mochs@nvidia.com>
Message-ID: <20260416085053.GA290566@pevik>
References: <20260408174406.1572520-1-mochs@nvidia.com>
 <20260409075345.GC64002@pevik>
 <79CF2D7E-5987-4321-BDE7-D5FF34EBF952@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79CF2D7E-5987-4321-BDE7-D5FF34EBF952@nvidia.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: file_attr05: skip ntfs filesystem
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWF0dAo+IEhpIFBldHIsCgo+ID4gT24gQXByIDksIDIwMjYsIGF0IDAyOjUzLCBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgTWF0dGhldywKCj4gPj4gTFRQIG1v
dW50cyBudGZzIHZpYSBudGZzLTNnIChGVVNFKSByYXRoZXIgdGhhbiB0aGUga2VybmVsIG50ZnMz
Cj4gPj4gZHJpdmVyLiBudGZzLTNnJ3MgbnRmc19pb2N0bCgpIHJldHVybnMgRUlOVkFMIGZvciBh
bnkgdW5oYW5kbGVkCj4gPj4gaW9jdGwsIGluY2x1ZGluZyBGU19JT0NfRlNTRVRYQVRUUiwgc28g
ZmlsZV9zZXRhdHRyKCkgcmV0dXJucwo+ID4+IEVJTlZBTCBpbnN0ZWFkIG9mIHRoZSBleHBlY3Rl
ZCBFT1BOT1RTVVBQLgoKPiA+PiBBZGQgIm50ZnMiIHRvIHNraXBfZmlsZXN5c3RlbXMgZm9yIHRo
ZSBzYW1lIHJlYXNvbiAiZnVzZSIgaXMKPiA+PiBhbHJlYWR5IHNraXBwZWQuCgo+ID4gUmV2aWV3
ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ID4gR29vZCBjYXRjaCwgdGhhbmtz
IQoKPiBJIGFwcHJlY2lhdGUgdGhlIHJldmlldyEKCllvdSdyZSB3ZWxjb21lLCB0aGFua3MgZm9y
IHlvdXIgY29udHJpYnV0aW9ucyEKCj4gPiBXZSBkaWQgbm90IG5vdGljZSwgYmVjYXVzZSB3ZSBo
YXZlIG50ZnMzIGJsYWNrbGlzdGVkIGluIG9wZW5TVVNFIFR1bWJsZXdlZWQ6CgouLi4KPiA+PiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9maWxlX2F0dHIvZmlsZV9hdHRy
MDUuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmlsZV9hdHRyL2ZpbGVfYXR0cjA1LmMK
PiA+PiBpbmRleCA2YzE0NzFkYTMzZTcuLjg1YjZjYWZjNWYxNyAxMDA2NDQKPiA+PiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZpbGVfYXR0ci9maWxlX2F0dHIwNS5jCj4gPj4gKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9maWxlX2F0dHIvZmlsZV9hdHRyMDUuYwo+ID4+
IEBAIC00OSw2ICs0OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+PiAu
c2tpcF9maWxlc3lzdGVtcyA9IChjb25zdCBjaGFyICpjb25zdCBbXSkgewo+ID4+ICJ4ZnMiLAo+
ID4+ICJmdXNlIiwgLyogRUlOVkFMIGlzIHJhaXNlZCBiZWZvcmUgRU9QTk9UU1VQUCAqLwo+ID4+
ICsgIm50ZnMiLCAvKiBtb3VudGVkIHZpYSBudGZzLTNnIChGVVNFKSwgcmV0dXJucyBFSU5WQUwg
Ki8KPiA+IEZvciBtZSBpdCdkIHdvcmsgdG8gcmVwbGFjZSAiZnVzZSIgd2l0aCAibnRmcyIgKGku
ZS4gcmVtb3ZlICJmdXNlIikuCj4gPiBEb2VzIGl0IHdvcmsgZm9yIHlvdSBhcyB3ZWxsLCBvciB5
b3UgbmVlZCB0byBoYXZlIGJsYWNrbGlzdGVkIGJvdGg/Cgo+IFJlZ2FyZGluZyByZXBsYWNpbmcg
ImZ1c2UiIHdpdGggIm50ZnMiOiBvbiBVYnVudHUsIG50ZnMzIGlzIGF2YWlsYWJsZQo+IGFzIGEg
a2VybmVsIG1vZHVsZSwgc28gdGhlIGRldGVjdGlvbiByZXBvcnRzICJLZXJuZWwgc3VwcG9ydHMg
bnRmc+KAnQo+IGFuZCB0aGUgRlVTRSBza2lwIHBhdGggbmV2ZXIgZmlyZXMg4oCUIG1lYW5pbmcg
ImZ1c2UiIGFsb25lIGRvZXNu4oCZdAo+IGNhdGNoIGl0LiBSZW1vdmluZyAiZnVzZSIgd291bGQg
YWxzbyBkcm9wIGNvdmVyYWdlIG9mIG90aGVyCj4gRlVTRS1iYXNlZCBmaWxlc3lzdGVtcywgc28g
SSdkIHByZWZlciB0byBrZWVwIGJvdGggZW50cmllcy4KCkkgYWN0dWFsbHkgdGhpbmsgdGhhdCBv
dGhlciBmdXNlIGltcGxlbWVudGF0aW9ucyB3b3JrLCBmdXNlIHdhcyBwcm9iYWJseSBhZGRlZAp0
byBmaXggbnRmcy4gT3IgYW0gSSB3cm9uZz8gQnV0IHRoYXQgY2FuIGJlIHNvbHZlZCBhcyBhIHNl
cGFyYXRlIGVmZm9ydCwgSSBkb24ndAp3YW50IHRvIGJsb2NrIHdoYXQgeW91IHBsYW4gdG8gZml4
LgoKS2luZCByZWdhcmRzLApQZXRyCgo+IC1tYXR0CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
