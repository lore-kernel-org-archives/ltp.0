Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D91CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:51:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EDF83E619E
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 13:51:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0CA63E486B
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:51:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 168E0140075F
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 13:51:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42C686A96B;
 Wed,  3 Jun 2026 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487485;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2yONHW2DsvJDjk0ut+h+BwGaGkOKRMToA2ZWU2gFOk=;
 b=PZ8SjdrXM6b+Isto+VJ6eMjgh0c8EH7WoColyf8m3x+ff5EroXLgKxfvB0jCDJmKkNG6T9
 KVbD8tLN/v+hAgYhFhGhmheuKtQBMkXI6DY6dgwmfsAS86xEFhwEKE8jY4Zi8FKDbrHv3x
 g8Tl2IVrFA3zdWjQ2mOq0UG+2xgkpRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487485;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2yONHW2DsvJDjk0ut+h+BwGaGkOKRMToA2ZWU2gFOk=;
 b=zBue+gYK9oOzmNVtvo3eBbiCV7IYYCMKAMIV2Wn7dwSy9OVMRbLtS64SBGsHFqgu9glIeZ
 loeATtB3KnqV1+Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780487485;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2yONHW2DsvJDjk0ut+h+BwGaGkOKRMToA2ZWU2gFOk=;
 b=PZ8SjdrXM6b+Isto+VJ6eMjgh0c8EH7WoColyf8m3x+ff5EroXLgKxfvB0jCDJmKkNG6T9
 KVbD8tLN/v+hAgYhFhGhmheuKtQBMkXI6DY6dgwmfsAS86xEFhwEKE8jY4Zi8FKDbrHv3x
 g8Tl2IVrFA3zdWjQ2mOq0UG+2xgkpRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780487485;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2yONHW2DsvJDjk0ut+h+BwGaGkOKRMToA2ZWU2gFOk=;
 b=zBue+gYK9oOzmNVtvo3eBbiCV7IYYCMKAMIV2Wn7dwSy9OVMRbLtS64SBGsHFqgu9glIeZ
 loeATtB3KnqV1+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21512779A7;
 Wed,  3 Jun 2026 11:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b9weBz0VIGpRYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jun 2026 11:51:25 +0000
Date: Wed, 3 Jun 2026 13:51:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20260603115119.GA587105@pevik>
References: <CAOQ4uxizKqbByJHpQB1KAkfhgiXysSuD+8UZFmg0KY5J-4B8pw@mail.gmail.com>
 <20260603015841.16230-1-anonymemeow@gmail.com>
 <CAOQ4uxjzJMyv5usNkzjUg2c27D6sMK7oQXu-Rc+BKksZ5o8Zog@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjzJMyv5usNkzjUg2c27D6sMK7oQXu-Rc+BKksZ5o8Zog@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fanotify13: fix test failure when running
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
Cc: jack@suse.cz, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiBPbiBXZWQsIEp1biAzLCAyMDI2IGF0IDM6NTjigK9BTSBBbm9ueW1lTWVvdyA8
YW5vbnltZW1lb3dAZ21haWwuY29tPiB3cm90ZToKCj4gPiBUaGUgRkFOX0RFTEVURV9TRUxGIHRl
c3QgY2FzZSByZW1vdmVzIHRlc3QgZmlsZXMsIGNhdXNpbmcgbGF0ZXIKPiA+IGl0ZXJhdGlvbnMg
dG8gY3Jhc2guIFJlY3JlYXRlIHRoZSByZW1vdmVkIGZpbGVzIGFmdGVyIHRoZSB0ZXN0IHRvCj4g
PiByZXN0b3JlIHRoZSBleHBlY3RlZCBpbml0aWFsIHN0YXRlLiBBbmQgYWRqdXN0IHRoZSBvdmVy
bGF5ZnMgbW91bnQKPiA+IHRpbWluZyB0byBhdm9pZCBjcmVhdGluZyBmaWxlcyBkaXJlY3RseSBp
biB0aGUgZmlsZXN5c3RlbSB1bmRlcm5lYXRoCj4gPiB0aGUgYWxyZWFkeSBtb3VudGVkIG92ZXJs
YXlmcy4KCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbm9ueW1lTWVvdyA8YW5vbnltZW1lb3dAZ21haWwu
Y29tPgo+ID4gLS0tCgo+ID4gSGksIEFtaXIsCgo+ID4gSSB0ZXN0ZWQgeW91ciBzdWdnZXN0ZWQg
c29sdXRpb24sIGJ1dCB0aGUgb3ZlcmxheWZzIG1vdW50IGZhaWxlZCB3aXRoOgoKPiA+IGZhbm90
aWZ5MTMuYzoxNjU6IFRCUk9LOiBvdmVybGF5ZnMgbW91bnQgZmFpbGVkOiBFU1RBTEUgKDExNikK
Cj4gPiBTbyBJIGtlcHQgY2xlYW5fdXBwZXJfZGlyKCkgaW4gcmVzdG9yZV9vYmplY3RzKCkgdG8g
cmVzdG9yZSB0aGUgZXhwZWN0ZWQKPiA+IGluaXRpYWwgc3RhdGUuCgo+IE9rIG5vIHByb2JsZW0u
IFRoaXMgaXMgZmluZSB0b28uCj4gVGhhbmtzLAoKPiBSZXZpZXdlZC1ieTogQW1pciBHb2xkc3Rl
aW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KCkdvb2QsIG1lcmdlZCwgdGhhbmsgeW91IQoKS2luZCBy
ZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
