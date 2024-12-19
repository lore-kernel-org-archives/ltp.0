Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6A5E77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 13:28:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78E513ED42A
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:28:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A838B3ED3FC
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:28:18 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C80E140F67A
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:28:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB04E210F7;
 Thu, 19 Dec 2024 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734614896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jD6WHRoGfbDQ7M8hTis/v7I0iO8oPgnVdcNyU17M8dU=;
 b=1hObprAWaNpOXF7FmEHLvSWo2/vcan5sQuEpDYDnRfMORgevfcjCkkt0a3GQjTe5KwuqIV
 sBnDVFcOYV+a0WDgSqSzSttpiE75f5DuVel1/NF6Dx4fgklDuoj8RaMKJfwPhpA1MIuro9
 JXmxkmlYnUdmODgWBF0lWnhf8aeoNFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734614896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jD6WHRoGfbDQ7M8hTis/v7I0iO8oPgnVdcNyU17M8dU=;
 b=PLd3ZHK9U0+SfIsXCWfhCJvhjWUH0yu+MlaMeWNxCC7fXEVYXVjOSbpB/JSRgUuSAFZraq
 7Oe5t9rRxDMQouDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734614896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jD6WHRoGfbDQ7M8hTis/v7I0iO8oPgnVdcNyU17M8dU=;
 b=1hObprAWaNpOXF7FmEHLvSWo2/vcan5sQuEpDYDnRfMORgevfcjCkkt0a3GQjTe5KwuqIV
 sBnDVFcOYV+a0WDgSqSzSttpiE75f5DuVel1/NF6Dx4fgklDuoj8RaMKJfwPhpA1MIuro9
 JXmxkmlYnUdmODgWBF0lWnhf8aeoNFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734614896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jD6WHRoGfbDQ7M8hTis/v7I0iO8oPgnVdcNyU17M8dU=;
 b=PLd3ZHK9U0+SfIsXCWfhCJvhjWUH0yu+MlaMeWNxCC7fXEVYXVjOSbpB/JSRgUuSAFZraq
 7Oe5t9rRxDMQouDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BFD513A32;
 Thu, 19 Dec 2024 13:28:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tJ3RIHAfZGdgFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 19 Dec 2024 13:28:16 +0000
Date: Thu, 19 Dec 2024 14:28:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241219132800.GC111004@pevik>
References: <20241212060448.204158-1-liwang@redhat.com>
 <b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz>
 <20241219130738.GA111004@pevik>
 <CAEemH2d_P7y+y+P91Lxxi8jBVN1mEjWtt4fh6CRQ07+Bv0yp9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d_P7y+y+P91Lxxi8jBVN1mEjWtt4fh6CRQ07+Bv0yp9Q@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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

SGkgTGksIGFsbCwKCj4gT24gVGh1LCBEZWMgMTksIDIwMjQgYXQgOTowN+KAr1BNIFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiArMS4gTGksIGNvdWxkIHlvdSBwbGVhc2Ug
ZG8gaXQ/Cgo+IFN1cmUsIGJ1dCBJIGFtIHdvbmRlcmluZyBkbyB5b3UgcnVubmluZyB0aGUgbGF0
ZXN0IExUUCBicmFuY2ggaW4gcHJvZHVjdGl2ZQo+IGVudj8KCldlIG1vc3RseSBydW4gTFRQIHN0
YWJsZSBicmFuY2ggd2l0aCBzb21lIGV4Y2VwdGlvbnM6IG9wZW5TVVNFIFR1bWJsZXdlZWQgYW5k
CmZldyBwcm9kdWN0cyBpbiBkZXZlbG9wbWVudC4gVXN1YWxseSBpdCB3b3VsZCBiZSBtb3JlIHdv
cmsgdG8gYmFja3BvcnQgZml4ZXMKdG8gc3RhYmxlIHBhY2thZ2UgdGhhbiBydW5uaW5nIG1hc3Rl
ci4gQnV0IHNvbWV0aW1lcyB3ZSBnZXQgYSBwdW5pc2htZW50IGZvcgp0aGlzIGFwcHJvYWNoIDop
LgoKPiBJZiBzbyBJIGFtIHNvcnJ5IHRvIG1ha2UgdGhlIHRlc3QgdGltZSBwcm9sb25nLgo+IE9y
IGlmIG5vdCwgY291bGQgeW91IGdpdmUgbWUgYSBwZXJpb2QgdG8gcmVzb2x2ZSBpdCBpbiBhIG5l
dyBwYXRjaD8KClN1cmUuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
