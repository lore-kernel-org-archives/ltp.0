Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DE9F94CD8
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 07:55:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFE403E2DE6
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 09:55:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8DDD3E2D89
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 09:54:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 04F991A00700
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 09:54:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DF406A81B;
 Wed, 22 Apr 2026 07:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776844476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3gBC0Qpq0Aj9Ic0H6VrWB1NS6ZwkBjSADyl90iOhNk=;
 b=Rb4jI2cq6NkGjDVvKvjDts7taqA5buyKABGmdzm5uNGEGw4auY06S85EAs6+7MNR7ErKeX
 P2daK7AXcCPi76TziLPExOqHAGJnlAvIynebmpmhmrqXDu/DJHdikzAo0MnzaCsTe2RDVB
 h8O46NvECFIF3zHnGFdhayzSVRfO5Yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776844476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3gBC0Qpq0Aj9Ic0H6VrWB1NS6ZwkBjSADyl90iOhNk=;
 b=h0BW85BqAViicCe+xxP2JjrxQv1Km0T74gRSCUcpyXQX2RLY8BtWSKDS/k9cTafYexhhrr
 NwoxEEVve1Ns0BBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776844475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3gBC0Qpq0Aj9Ic0H6VrWB1NS6ZwkBjSADyl90iOhNk=;
 b=fq7mTtIEpXOZBrxcVCZxq9WlA2zx/PPwrPsbthgfF8pcb1WH8CF+f2K6bqFAhzg43B17A4
 LB6TOFdzAHuoeTIf63f8/99OgZcPvMNEzYBxjelNCKtYjFpg810auYMmp2falF09IEv4Oc
 pRnaB1gOKuwG30gNrslcFMYFo9IyH7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776844475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3gBC0Qpq0Aj9Ic0H6VrWB1NS6ZwkBjSADyl90iOhNk=;
 b=Gj4yaEr2lBvQ0T/d43Sc31RQPly8xv89Yw4R5UoPSW8mKtSPvOHwM3ieLuYlLC1KzzE4Q7
 2sxKlOZHF2HxAPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DAD5593AF;
 Wed, 22 Apr 2026 07:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c8SjCbt+6GnqWAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Wed, 22 Apr 2026 07:54:35 +0000
Message-ID: <319d3965-30f0-49c5-b747-ad16334391e2@suse.de>
Date: Wed, 22 Apr 2026 09:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Martin Cermak <mcermak@redhat.com>
References: <20260421152349.1673057-1-mcermak@redhat.com>
 <20260422053712.GB392764@pevik>
Content-Language: en-US
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <20260422053712.GB392764@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiA0LzIyLzI2IDc6MzcgQU0sIFBldHIgVm9yZWwgd3JvdGU6Cj4+IEhvd2V2ZXIsIHNvbWUg
b2YgdGhlIHRlc3RjYXNlcyBjYW4gYmUgZWFzaWx5IGNoYW5nZWQgdG8gdXNlIGZvcmtlZAo+PiBw
cm9jZXNzZXMgaW5zdGVhZCBvZiB0aHJlYWRzLiAgVGhhdCdzIHdoYXQgdGhpcyBwYXRjaCBkb2Vz
LiAgV2hlbgo+PiBjbGllbnQgcHJvZ3JhbSBmb3JrcywgVmFsZ3JpbmQgZm9ya3MgdG9vLCBhbmQg
dGhhdCBhbGxvd3MgZm9yIHRoZSBuZWVkZWQKPj4gcGFyYWxsZWxpc20gdG8gaGFuZGxlIHRoZSBw
YWdlIGZhdWx0Lgo+IFlvdSB1bmRlcnN0YW5kIHByb2Nlc3MgdnMuIHRocmVhZHMgbW9yZSB0aGFu
IG1lLiBCdXQgc2hvdWxkbid0IG1tYXAoKSB1c2UKPiBNQVBfU0hBUkVEIGluc3RlYWQgb2YgTUFQ
X1BSSVZBVEUgZm9yIHRob3NlIHdoaWNoIGFyZW4ndCB1c2luZyAvZGV2L3VzZXJmYXVsdGZkPwoK
VGhlIGRvY3VtZW50YXRpb24gZm9yIHVzZXJmYXVsdGZkIG1lbnRpb25zIHRocmVhZHMuwqAgSSdt
IGFmcmFpZCB3ZSdsbApsb3NlIHZpdGFsIGNvdmVyYWdlIGlmIHdlIG1vdmUgdG8gZm9ya2VkIHBy
b2Nlc3Nlcy4KClBlcmhhcHMgd2Ugc2hvdWxkIGNvdmVyIGJvdGg/CgpBbHNvIGNoZWNrb3V0IFVG
RkRfRkVBVFVSRV9FVkVOVF9GT1JLIGFuZCB0aGUgQlVHUyBzZWN0aW9uIGZvciB0aGlzIGluCnVz
ZXJmYXVsdGZkKDIpLgpJIGhhdmUgbGlrZSAzIHBhdGNoZXMgZm9yIHVzZXJmYXVsdGZkIHRoYXQg
SSdtIGFmcmFpZCBJJ2QgaGF2ZSB0byByZWJhc2UgCnRoZW4uXCBCZXN0LApSaWNhcmRvCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
