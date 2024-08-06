Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C787C52D6F
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 09:22:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB74A3D1ED2
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 11:22:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD7A33CB256
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 11:22:00 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 81B9110000CD
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 11:21:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FEBD1F8D9;
 Tue,  6 Aug 2024 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722936117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ha3xKDKda/tmInm5dDdB1lt89uYLrujdZ2+SH1LmVHM=;
 b=PVkwCf+t5f7THzT+JVKRN/au4rqzr8Zktij+LlKTcvmea8dW345fH8lVhiNhD4bt885eFC
 oHasPrxfD8XOhipIa8czq0HKz2SA1NlB13jNxJdFQEqhzMhXX9gI9xHvb4sS8cpXk8jeMT
 FLUuxJ+pxbzfLwVfEn2ylcxNce2cmJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722936117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ha3xKDKda/tmInm5dDdB1lt89uYLrujdZ2+SH1LmVHM=;
 b=TXTaUNP0mTY+xMt0ibqbTV87KoFBog5npb0qAR7j68BIGQE5Ol2y+4wa9D5ghnC+r6GQ1R
 Ng60z6LSqW0NmACA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722936117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ha3xKDKda/tmInm5dDdB1lt89uYLrujdZ2+SH1LmVHM=;
 b=PVkwCf+t5f7THzT+JVKRN/au4rqzr8Zktij+LlKTcvmea8dW345fH8lVhiNhD4bt885eFC
 oHasPrxfD8XOhipIa8czq0HKz2SA1NlB13jNxJdFQEqhzMhXX9gI9xHvb4sS8cpXk8jeMT
 FLUuxJ+pxbzfLwVfEn2ylcxNce2cmJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722936117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ha3xKDKda/tmInm5dDdB1lt89uYLrujdZ2+SH1LmVHM=;
 b=TXTaUNP0mTY+xMt0ibqbTV87KoFBog5npb0qAR7j68BIGQE5Ol2y+4wa9D5ghnC+r6GQ1R
 Ng60z6LSqW0NmACA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3632A13981;
 Tue,  6 Aug 2024 09:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8bAwDDXrsWZoewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Aug 2024 09:21:57 +0000
Date: Tue, 6 Aug 2024 11:21:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240806092151.GB108596@pevik>
References: <CAEemH2eF3B41E2nv1+-oMrCUTw7zfVrgCULRBaBe=Pk9roBUiQ@mail.gmail.com>
 <20240806023105.20509-1-liwang@redhat.com>
 <20240806061947.GB73369@pevik>
 <CAEemH2dR-sQGkwHG5eP9mzKp=oBoLjoFSOe_+7jwnYaJ8NgFzQ@mail.gmail.com>
 <CAEemH2ewdg-D-OvAYk31qaLOpteubBDfpHZ2oB1quVK7fbjuTw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ewdg-D-OvAYk31qaLOpteubBDfpHZ2oB1quVK7fbjuTw@mail.gmail.com>
X-Spamd-Result: default: False [-0.50 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pkey: remove the ltp_ prefix from pkey functions
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

PiBPbiBUdWUsIEF1ZyA2LCAyMDI0IGF0IDM6MzfigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cgo+ID4gSGkgUGV0cgoKPiA+IE9uIFR1ZSwgQXVnIDYsIDIwMjQgYXQgMjox
OeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPj4gSGkgTGksCgo+
ID4+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiA+PiBUaGFua3Mh
Cgo+ID4+IE90aGVyIHRoaW5nIHdoaWNoIHNob3VsZCBmb2xsb3cgaXMgdG8gdXNlIC50ZXN0X3Zh
cmlhbnRzLgoKCj4gPiBBcyBJIHBvaW50ZWQgb3V0IGluIHRoZSBsYXN0IGVtYWlsLCBtc2VhbCgp
IGlzIHRvbyBuZXcgdG8gbGliYywgdGhlcmUgaXMKPiA+IG5vIHdyYXBwZXIgaW4gR2xpYmMgc28g
ZmFyLgo+ID4gU2hvdWxkIHdlIGFkZCAudGVzdF92YXJpYW50cyBub3c/Cgo+IEFueXdheSwgSSBi
b2xkbHkgcHVzaGVkIHRoZSBwYXRjaGVzIGFuZCBhZGRlZCBhIFRPRE8gaW4gdGhlIGNvbW1lbnRz
Lgo+IEBQZXRyLCBJIHdvdWxkIGJlIGhhcHB5IHRvIHJldmlldyBpZiB5b3UgcGxhbiB0byB3cml0
ZSBtb3JlIHRvIGNvdmVyIGxpYmMKPiB3cmFwcGVyLgoKSSdtIHNvcnJ5IHRoaXMgd2FzIG1lYW50
IG9ubHkgZm9yIGZ1bmN0aW9ucyBpbiBsYXBpL3BrZXkuaCwgd2hpY2ggaGF2ZQp0aGVpciBmYWxs
YmFjayB2YXJpYW50cyBndWFyZGVkIGJ5ICNpZm5kZWYgSEFWRV9QS0VZX01QUk9URUNULgpJJ2xs
IHNlbmQgYSBwYXRjaCBmb3IgaXQuCgpBbHNvLCBvbmNlIG1zZWFsKCkgZ2V0cyB0byBhbnkgbGli
YywgaXQgbWlnaHQgbmVlZCB0byBiZSBndWFyZGVkIChkZXBlbmRpbmcgaWYKd2UgbG9hZCBoZWFk
ZXIgd2hlcmUgd2lsbCBiZSBhZGRlZCkuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9tc2VhbDAxLmMKPiArKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEuYwo+IEBAIC0xOSwxMiArMTksMTUgQEAKPiAg
ICogICB3aGVuIHVzZXJzIGRvbuKAmXQgaGF2ZSB3cml0ZSBwZXJtaXNzaW9uIHRvIHRoZSBtZW1v
cnkKPiAgICoKPiAgICogQW55IG9mIHRoZSBkZXNjcmliZWQgYWN0aW9ucyBpcyByZWNvZ25pemVk
IHZpYSBFUEVSTSBlcnJuby4KPiArICoKPiArICogVE9ETzogc3VwcG9ydCBib3RoIHJhdyBzeXNj
YWxsIGFuZCBsaWJjIHdyYXBwZXIgdmlhIC50ZXN0X3ZhcmlhbnRzLgo+ICAgKi8KCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
