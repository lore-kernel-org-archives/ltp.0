Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED44AC54E41
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 09:04:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1AB03CEB8C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 10:04:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 404713CAB09
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 10:04:34 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C9F6603454
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 10:04:32 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99A5B689F4;
 Mon,  4 Mar 2024 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709543069;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZcgBe7uwEbTmaroDU3/78oCjAqNhmnF1pbW4zQ1KVg=;
 b=gEeyKEPGRnw1SL8rIDNT3+hImlQvTJ8IysulB5PIy4GBtTOrpmw+zoRCrw1Ec5Cc09byHg
 ZMUSVtqqiZypbSd59dXwTs2hEfPswX5F473cL/R5uAX2zi5/4eaGEK7wQD9bzei4Q8OqAB
 O2F9kyBWPbMzdV1WGfnueCUuPLr5gok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709543069;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZcgBe7uwEbTmaroDU3/78oCjAqNhmnF1pbW4zQ1KVg=;
 b=tMfMiBXnIJi5UYKGRywDFTcRKgrz87is2Arj/5mBOVaqVO3Kc5U6IZ1nIzghfkM+2kaeaK
 JVEUUzX5gRwxhwDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709543069;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZcgBe7uwEbTmaroDU3/78oCjAqNhmnF1pbW4zQ1KVg=;
 b=gEeyKEPGRnw1SL8rIDNT3+hImlQvTJ8IysulB5PIy4GBtTOrpmw+zoRCrw1Ec5Cc09byHg
 ZMUSVtqqiZypbSd59dXwTs2hEfPswX5F473cL/R5uAX2zi5/4eaGEK7wQD9bzei4Q8OqAB
 O2F9kyBWPbMzdV1WGfnueCUuPLr5gok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709543069;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZcgBe7uwEbTmaroDU3/78oCjAqNhmnF1pbW4zQ1KVg=;
 b=tMfMiBXnIJi5UYKGRywDFTcRKgrz87is2Arj/5mBOVaqVO3Kc5U6IZ1nIzghfkM+2kaeaK
 JVEUUzX5gRwxhwDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D55113419;
 Mon,  4 Mar 2024 09:04:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id ezZSHZ2O5WU3BAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 04 Mar 2024 09:04:29 +0000
Date: Mon, 4 Mar 2024 10:04:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240304090424.GA2619408@pevik>
References: <20240301062716.3023-1-wegao@suse.com>
 <5681819a-2a3a-4c47-a1f1-3f9f49c994d9@fujitsu.com>
 <20240303131402.GC1856074@pevik>
 <CAEemH2eKts8X+tj1keU4Vqp5LwKRa8V1w7QdzGOPmC95F9JK7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eKts8X+tj1keU4Vqp5LwKRa8V1w7QdzGOPmC95F9JK7Q@mail.gmail.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gEeyKEPG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tMfMiBXn
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.75 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.04)[58.67%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 99A5B689F4
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
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

PiBPbiBTdW4sIE1hciAzLCAyMDI0IGF0IDk6MTTigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+ID4gSGkgV2VpLCBYdSwKCj4gPiA+IEhpICBXZWkKCj4gPiA+ID4gSSBl
bmNvdW50ZXIgYSBkZWFkIGxvb3Agb24gZm9sbG93aW5nIGNvZGUgaW4gb3VyIHRlc3Qgb24gcHBj
NjQgbWFjaGluZToKPiA+ID4gPiB3aGlsZSAoKGMgPSBmZ2V0YyhmcCkpICE9IEVPRikKCj4gPiA+
ID4gSSB0aGluayAiL3Byb2Mvc3dhcHMiIGlzIG5vdCBub3JtYWwgZmlsZSBhbmQgY2FuIG5vdCBn
ZXQgRU9GIGluIHNvbWUKPiA+IHNpdHVhdGlvbiwKPiA+ID4gPiBzbyBpIHVzZSBmZ2V0cyBhIGxp
bmUgYW5kIGNhY3VsYXRlIHN3YXAgZGV2IG51bWJlci4KCj4gPiBJIGd1ZXNzIHRoZSBwcm9ibGVt
IGhhcyBiZWVuIGZpeGVkIGJ5IGFub3RoZXIgcGF0Y2ggWzFdLCB0aHVzIGNsb3NpbmcgaXQgaW4K
PiA+IHBhdGNod29yay4gUGxlYXNlIGxldCBtZSBrbm93IGlmIG5vdC4KCgo+IFNlZW1zIG5vdCwg
dGhlIHBhdGNoIFsxXSBiZWxvdyBpcyBtYWlubHkgdG8gY291bnQgdGhlIGZyZWUgZGlzayBzaXpl
LgoKPiBCdXQgV2VpJ3Mgd29yayBoZXJlIGlzIHRvIGNhbGN1bGF0ZSBzd2FwLWRldiBudW1iZXJz
IGNvcnJlY3RseQo+IChlc3BlY2lhbGx5IGdldCByaWQgb2YgRU9GIGFmZmVjdGlvbiB0byBzb21l
IGRlZ3JlZSkuCgpPSywgc2V0dGluZyBpdCBhcyAiTmV3IiBhZ2Fpbi4KCktpbmQgcmVnYXJkcywK
UGV0cgoKPiBYdSBZYW5nLCB3aGF0IGRvIHlvdSB0aGluaz8gb3IgZGlkIEkgbWlzcyBhbnl0aGlu
ZyBoZXJlPwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
