Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEDEC35274
	for <ltp@archiver.kernel.org>; Thu, 21 Dec 2023 19:05:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB1953CEF3D
	for <ltp@archiver.kernel.org>; Thu, 21 Dec 2023 20:05:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB9493C98F7
 for <ltp@lists.linux.it>; Thu, 21 Dec 2023 20:04:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2F16D2348D5
 for <ltp@lists.linux.it>; Thu, 21 Dec 2023 20:04:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D8C9D21EDA;
 Thu, 21 Dec 2023 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703185498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYF/5kTXa0oad0/upAdwW7Mw2goeVn8fOrd6N5w8w8k=;
 b=ehhNJVy6E9rBUNmbyD9YYTyvNMYBUXWfB/7Isgs2WrZfRTiH3HmsZ9vwj1XzfYZeUnk0Nd
 n/3bD12e4BAL2V6neJZp5dmNeHro8HHly1wdlMdRMIFuvYcCxbLixmLu4uscVeehOhSDby
 pyuODlKR5Klz4fumf6Gh0R2cDh2Zf8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703185498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYF/5kTXa0oad0/upAdwW7Mw2goeVn8fOrd6N5w8w8k=;
 b=Mg5m4apreOvIOzah/zgsbrCb5yAWAMbN2msYzCJJoSi+udMgF9ddND4hQ3EBVn4koNfpp2
 dBr/arpm/QHZMzBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703185497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYF/5kTXa0oad0/upAdwW7Mw2goeVn8fOrd6N5w8w8k=;
 b=ESdO+ubEVB3ESiHAGRMDPFSLbF9NDjv3I/Ttoxi9parpT/4q/F6BtpBmFrhdpvLA6tl+fl
 UfMTrvJn+kf5+Scq9nVay3aCqB2+0SHDwb013l+IsalAvupEDlDy5Fs/vt/wEPrtW7ICPR
 YuQeGrnjF82jR/PH3iJUQHTAA4AeEus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703185497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYF/5kTXa0oad0/upAdwW7Mw2goeVn8fOrd6N5w8w8k=;
 b=8KUjcwcacHoUf9oXP4whHM7Qmwx6ySoC8+wBo7Xa6x0orJlMyhSCzu579CrJeOL//Tl30M
 jA5JJrGLCP7jYtBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7627313725;
 Thu, 21 Dec 2023 19:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xrEbGlmMhGVtegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 21 Dec 2023 19:04:57 +0000
Date: Thu, 21 Dec 2023 20:04:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231221190446.GB467252@pevik>
References: <20231220145047.422491-1-pvorel@suse.cz>
 <CAEemH2d2Yj0J1GYoRASCiDHAmOJMhqnM7PHo=gOTct1H4+-bJg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d2Yj0J1GYoRASCiDHAmOJMhqnM7PHo=gOTct1H4+-bJg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.61 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.11)[88.28%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] oom*: Turn docs to docparse
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

SGkgTGksCgo+IEhpIFBldHIsCgo+IE9uIFdlZCwgRGVjIDIwLCAyMDIzIGF0IDEwOjUw4oCvUE0g
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IFNpZ25lZC1vZmYtYnk6IFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ID4gLS0tCj4gPiBIaSwKCj4gPiBJIHJlbW92ZWQg
dGhlIHBhcmFncmFwaCB3aGljaCB3YXMgdGhlIHNhbWUgZm9yIGFsbCB0ZXN0cywgd2hpY2ggaXMK
PiA+IGdlbmVyYWxseSBnb29kLCBidXQgSU1ITyBvdXRkYXRlZCAob3JpZ2luYXRlcyBmcm9tIDBk
YjU1MDc3ZiBpbiAyMDExLAo+ID4gZS5nLiAzIEdCIHdhcyBpbiBsaWIvb29tLmggI2RlZmluZSBM
RU5HVEggKDNVTDw8MzApLCBidXQgdGhlIGZpbGUgd2FzCj4gPiByZW1vdmVkIGluIDRlMjE3YTM5
OCkuIEFsc28gdGVzdHMgZGlmZmVycywgYnV0IHRoZSB0ZXh0IGlzIHRoZSBzYW1lLgoKPiA+IEBM
aSBJZiB5b3UgaGF2ZSB0aW1lLCBmZWVsIGZyZWUgdG8gYWRkIG1vcmUgdGVzdCBkZXNjcmlwdGlv
biBhbmQgcHVzaCBpdAo+ID4gd2l0aCB5b3Vyc2VsZiBhcyB0aGUgYXV0aG9yLgoKCj4gUGF0Y2gg
bWVyZ2VkLgoKPiBUaGUgT09NIHRlc3QgY29kZSBpdHNlbGYgaXMgZWFzeSB0byByZWFkIGFuZCBk
b2VzIG5vdCByZXF1aXJlIGV4Y2Vzc2l2ZQo+IGNvbW1lbnRzLgoKPiBUaGFuayB5b3UgYW5kIE1l
cnJ5IENocmlzdG1hcyEhIQoKVGhhbmtzIChub3Qgb25seSBmb3IgdGhpcyBwYXRjaCwgYnV0IGZv
ciB5b3VyIGhhcmQgd29yayBvbiBMVFApLgoKRW5qb3kgdXBjb21pbmcgQ2hpbmVzZSBOZXcgWWVh
ciEKCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
