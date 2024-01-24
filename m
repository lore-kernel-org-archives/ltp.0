Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B3AC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 10:06:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA26C3CE200
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 11:06:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D5133C62AC
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 11:06:16 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 95BA460074E
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 11:06:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07C331F7E0;
 Wed, 24 Jan 2024 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706090774;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gk5lpHiseSyE0DUh1GOejJM6Z0pQ1kK2ChScDK5KEtQ=;
 b=xVih07nINQryd2QCmXfweXe0Pk1vl4p0j5NI83Ad0r21S5Duu3T6ycxlMzKc/NWPSvEHSd
 IrONYah/hW2WGiwc6RQocuBdQYoLb4SmjVQ49Q00lqM3mvOKl3BfHuqf5b4v3aw+8DbDAd
 xLI6XB/M72XqF4GyD/D/UOBDNOsvrCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706090774;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gk5lpHiseSyE0DUh1GOejJM6Z0pQ1kK2ChScDK5KEtQ=;
 b=0oR6y3zW6qrQTn1dNEaoeXy23wvkytaADKx/Fi38F/n32Oksb3DdZ18UalrngAmJGKEreg
 0T4b95EardD5WtCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706090774;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gk5lpHiseSyE0DUh1GOejJM6Z0pQ1kK2ChScDK5KEtQ=;
 b=xVih07nINQryd2QCmXfweXe0Pk1vl4p0j5NI83Ad0r21S5Duu3T6ycxlMzKc/NWPSvEHSd
 IrONYah/hW2WGiwc6RQocuBdQYoLb4SmjVQ49Q00lqM3mvOKl3BfHuqf5b4v3aw+8DbDAd
 xLI6XB/M72XqF4GyD/D/UOBDNOsvrCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706090774;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gk5lpHiseSyE0DUh1GOejJM6Z0pQ1kK2ChScDK5KEtQ=;
 b=0oR6y3zW6qrQTn1dNEaoeXy23wvkytaADKx/Fi38F/n32Oksb3DdZ18UalrngAmJGKEreg
 0T4b95EardD5WtCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3E971333E;
 Wed, 24 Jan 2024 10:06:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v7jUMRXhsGURBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 10:06:13 +0000
Date: Wed, 24 Jan 2024 11:06:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240124100612.GA269395@pevik>
References: <20240123114840.2610533-1-liwang@redhat.com>
 <20240123114840.2610533-5-liwang@redhat.com>
 <20240123121156.GA175806@pevik> <20240123123740.GC175806@pevik>
 <CAEemH2dAG89-4CcX1GsfCwXuD+J5i5FETBU0bf8nK+q+uXgxsw@mail.gmail.com>
 <20240123154735.GC201093@pevik>
 <CAEemH2esyVuT6ptkT3nNp+YAZMgvBg7andV0i8eMo6OCD9Za9g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2esyVuT6ptkT3nNp+YAZMgvBg7andV0i8eMo6OCD9Za9g@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xVih07nI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0oR6y3zW
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[26.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 07C331F7E0
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3 4/5] libswap: add function to prealloc
 contiguous file
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

PiBPbiBUdWUsIEphbiAyMywgMjAyNCBhdCAxMTo0N+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToKCj4gPiA+IEhpIFBldHIsCgo+ID4gPiBPbiBUdWUsIEphbiAyMywgMjAy
NCBhdCA4OjM34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+ID4g
PiBIaSBMaSwKCj4gPiA+ID4gPiBIaSBMaSwKCj4gPiA+ID4gPiBzd2Fwb2ZmMDEgZmFpbHMgb24g
VE1QRElSIG9uIGJ0cmZzIChyZWdhcmRsZXNzIGtlcm5lbCB2ZXJzaW9uKToKCj4gPiA+ID4gRllJ
IGl0IHdvcmtzIG9uIFR1bWJsZXdlZWQgd2l0aCA2Ljcga2VybmVsLiBJdCdzIGJyb2tlbiBvbiBz
b21lIG9sZGVyCj4gPiBTTEVTCj4gPiA+ID4gd2l0aCA1LjE0IGFuZCBhbGwgb2xkZXIga2VybmVs
cy4gSSBzdXBwb3NlIHdpdGggbm9jb3cgKGZpeGVzIEkKPiA+IHN1Z2dlc3RlZAo+ID4gPiA+IHBy
ZXZpb3VzbHkpIHdvdWxkIHdvcmsgYXMgZXhwZWN0ZWQgKFRQQVNTLCBvciBUQ09ORiBvbiBrZXJu
ZWwgPCA1LjApLgoKCj4gPiA+IFlvdSdyZSByaWdodC4KCj4gPiA+IFdlIGhhdmUgdG8gZ3VhcmFu
dGVlIHRoZSBzd2FwZmlsZSBpcyBhIGNvbnRpZ3VvdXMgZmlsZSB3aGF0ZXZlciB0aGUgRlMKPiA+
IHR5cGUKPiA+ID4gaXMuCj4gPiA+IFNvIGhlcmUgbWFraW5nIHVzZSBvZiBtYWtlX3N3YXBmaWxl
KCkgaXMgYSBoYXJkIHJlcXVpcmVtZW50Lgo+ID4gPiBBbmQsIEkgZG9uJ3QgdGhpbmsgdGhlIGZp
bGUgZmlyc3Qgd2l0aCA2NTUzNiBibG9ja3MgKGluIHN3YXBvZmYwMSkgaXMgbm90Cj4gPiA+IG5l
Y2Vzc2FyeS4KCj4gPiBNYXliZSBub3QsIGJ1dCBub3cgd2UgdGVzdCBvbiBzaW5nbGUgc3dhcCBz
aXplLiBUZXN0aW5nIHNtYWxsIHN3YXAgYW5kIGJpZwo+ID4gc3dhcAo+ID4gd2FzIElNSE8gbW9y
ZSB0ZXN0aW5nIGNvdmVyYWdlICh2YXJpb3VzIGZpbGVzeXN0ZW1zIGJlaGF2ZSBkaWZmZXJlbnRs
eSBvbgo+ID4gZGlmZmVyZW50IHNpemUpLCBidXQgZ2l2ZW4gdGhpcyB3b3VsZCBiZSBtb3JlIGlt
cG9ydGFudCBmb3Igd2hvbGUKPiA+IC5hbGxfZmlsZXN5c3RlbXMgPSAxIHRlc3RpbmcgSSdtIG9r
IHdpdGggdGhlIGNoYW5nZS4KCgo+IE9rLCB0aGF0IGNvdWxkIGJlIGFjaGlldmVkIGJ5IGN1c3Rv
bWl6aW5nIHRoZSBzd2FwIGZpbGUgc2l6ZSBsYXRlci4KPiBJdCdzIG5vdCB2ZXJ5IGhhcmQuIEJ1
dCBub3cgSSBkb24ndCB3YW50IHRvIGluY3JlYXNlIHRoZSBwYXRjaHNldCBudW1iZXIKPiBqdXN0
IGZvciBtb3JlIGNvdmVyYWdlLCB0aGF0IHdpbGwgYmUgYSBidXJkZW4gZm9yIHJlbGVhc2UgdGVz
dGluZyB3b3JrLgoKSGkgTGksCgorMSwgc3VyZS4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
