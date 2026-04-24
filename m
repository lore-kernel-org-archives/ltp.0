Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5F1FE51FB
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 09:59:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A2993E2D46
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 11:59:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DBEB3C1DA7
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:59:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6AF821A00A3B
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 11:59:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 260CA5BD89;
 Fri, 24 Apr 2026 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777024747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GNRy0Dwc2cERwWAMX+djHGhIG+YWrRp0Sjs9cVv7zs=;
 b=zIse+R73GjCBeRol8Xpew8KFeLapQomFMblf2dKoV/RIedD6F9IX4ZmUMWX2glxWajVday
 W3f9ECs5v9nD355O12xs8iW+hP5PdKVab3MVfYrZPrXKWSMdit8TdiHCb38cx+/FFuuzuW
 bj3496rY0Xz36CFNzY8SkfeIN+4KRSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777024747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GNRy0Dwc2cERwWAMX+djHGhIG+YWrRp0Sjs9cVv7zs=;
 b=h2kKIPeVXj3/boXId3ALabzeTPoVNG2Au9BBrNf+/D4oPgOwyhrEHEdl7I+TltTx/UOGZe
 5RPy3JL8DGtUgTAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s4oPg8Cs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b3d3ruB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777024746;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GNRy0Dwc2cERwWAMX+djHGhIG+YWrRp0Sjs9cVv7zs=;
 b=s4oPg8Cs8h81nUOupVogqohUw1JaNoCfqDevaIZFwZC9CdHHX7uKmgnRdmuAfOkgE/3BuM
 4EqDq5t3wXqQG5DhtJdqSIKy5AVRAHMwqMCwcqHs8W9mqt1aLhncgwnLz7XmnZn/Wi1x+s
 13u3cai91Ld141mFFpiHtojUTUry9n8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777024746;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GNRy0Dwc2cERwWAMX+djHGhIG+YWrRp0Sjs9cVv7zs=;
 b=b3d3ruB4d2rDVz23rHAhJE8XHVuHKuCcMD52tEzIucrekdOTTjInKFIEWQQA4FKJ/ATeCr
 oN40VL7+cI1sS1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02D72593A4;
 Fri, 24 Apr 2026 09:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QZSgOuk+62kkYQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 09:59:05 +0000
Date: Fri, 24 Apr 2026 11:59:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260424095900.GA500158@pevik>
References: <20260424060543.462475-1-pvorel@suse.cz>
 <aesL6YSphAi5vJbO@linux.dev> <20260424063132.GE462697@pevik>
 <aesWy5_fBdPNzvle@linux.dev>
 <CAASaF6xiLDa_uOKkG2=aVhysnbKNCT-H_PiFYFt5=889g1K74Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xiLDa_uOKkG2=aVhysnbKNCT-H_PiFYFt5=889g1K74Q@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 260CA5BD89
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl_pidfd06: Update kernel version
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

SGkgYWxsLAoKZmlyc3QsIHRoYW5rcyBmb3IgYSByZXZpZXchCgo+IE9uIEZyaSwgQXByIDI0LCAy
MDI2IGF0IDk6MTPigK9BTSBMaSBXYW5nIDxsaS53YW5nQGxpbnV4LmRldj4gd3JvdGU6Cgo+ID4g
PiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9waWRmZDA2
LmMKPiA+ID4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxf
cGlkZmQwNi5jCj4gPiA+ID4gPiBAQCAtNTQsNyArNTQsNyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2
b2lkKQo+ID4gPiA+ID4gICBpZiAoIWlvY3RsX3BpZGZkX2luZm9fZXhpdF9zdXBwb3J0ZWQoKSkK
PiA+ID4gPiA+ICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAiUElERkRfSU5GT19FWElUIGlzIG5v
dCBzdXBwb3J0ZWQgYnkgaW9jdGwoKSIpOwoKPiA+ID4gPiA+IC0gaWYgKHRzdF9rdmVyY21wKDcs
IDAsIDApID49IDApCj4gPiA+ID4gPiArIGlmICh0c3Rfa3ZlcmNtcCg2LCAxOCwgMTQpID49IDAp
Cgo+ID4gPiA+IFdoYXQgd2lsbCBoYXBwZW4gaWYgdGhpcyB0ZXN0IGlzIHJ1biBvbiBrZXJuZWwg
cmFuZ2U6IHY2LjE5LjAgfiB2Ni4xOS45PwoKPiA+ID4gRllJIEkgaGF2ZW4ndCB0ZXN0ZWQgdGhh
dCwgYnV0IGl0IHNob3VsZCBmYWlsIG9uIDYuMTguMC4udjYuMTguMTMgYW5kIG9uCj4gPiA+IHY2
LjE5LjAuLnY2LjE5LjkgZHVlIG1pc3NpbmcgYmFja3BvcnQuCgo+ID4gPiBJJ2QgYXNzdW1lIHRo
YXQncyBjb3JyZWN0LCBiZWNhdXNlIG9uIHN0YWJsZS9MVFMgd2Ugc2hvdWxkIElNSE8gYmUgbW9y
ZSBzdHJpY3QKPiA+ID4gdG8gZW5zdXJlIGl0IGJlaGF2ZXMgYXMgZXhwZWN0ZWQuIFdEWVQ/Cgo+
ID4gSG1tLCBtYXliZSB0aGF0J3MgYWNjZXB0YWJsZS4gT3IganVzdDoKCj4gPiAgIGlmICgodHN0
X2t2ZXJjbXAoNiwgMTgsIDE0KSA9PSAwIHx8Cic9PScgSSBndWVzcyB5b3UgbWVhbiAnPj0nLCB0
aGlzIHdvdWxkIG5vdCB3b3JrIG9uIHY2LjE4LjE1Li52Ni4xOC4yNAoKPiA+ICAgICAgICB0c3Rf
a3ZlcmNtcCg2LCAxOSwgMTApID09IDApIHx8Cic9PSc6IGFsdGhvdWdoIDYuMTkuMTQgaXMgRU9M
LCB0aGF0IG1pZ2h0IGNoYW5nZS4KCj4gPiAgICAgICAgdHN0X2t2ZXJjbXAoNywgMCwgMCkgPj0g
MCkKCkJlZm9yZSBzZW5kaW5nIEkgd2FzIHRoaW5raW5nIGFib3V0OgoKaWYgKCh0c3Rfa3ZlcmNt
cCg2LCAxOSwgMTApID49IDApIHx8CiAgICAodHN0X2t2ZXJjbXAoNiwgMTgsIDE0KSA+PSAwICYm
IHRzdF9rdmVyY21wKDYsIDE5LCAwKSA8IDApCgpCZWNhdXNlIHRoZSBvbmx5IHZlcnNpb24gd2hp
Y2ggc2hvdWxkIGJlIGF2b2lkZWQgaXMgdjYuMTkuMC4udjYuMTkuOS4KSSBjYW4gc2VuZCB2Mi4K
Cj4gPiBBbmQgaXQnZCBiZSBncmVhdCB0byBoYXZlIEphbidzIGNvbW1lbnRzLCBoZSBpcyBhbiBl
eHBlcnQgaW4KPiA+IHRoZSBrZXJuZWwgbWFpbnRlbmFuY2UgYXJlYTopLgoKPiBlaG0sIG5vdCBz
dXJlIGFib3V0IHRoYXQgOi0pLgoKPiBUaGlzIGlzIGNoYW5nZSBpbiBlcnJvciBjb2RlLCB3ZSBk
aWRuJ3QgdHJlYXQgcHJldmlvdXMgdmFsdWUgYXMgZXJyb3IgZm9yIG9sZGVyCj4gcmVsZWFzZXMs
IHNvIHdoeSBkbyB0aGF0IG5vdz8gSSBkb24ndCBzZWUgaXQgY292ZXJlZCBpbiBtYW4gcGFnZXMg
KHlldCksCj4gc28gd2h5IGJlIHN0cmljdD8KCj4gSSB0aGluayB0aGUgcGF0Y2ggc2hvdWxkIGVp
dGhlciB1c2UgbW9yZSBzcGVjaWZpYyB2ZXJzaW9uIHJhbmdlcyBvcgo+IGFsbG93IGJvdGggZXJy
bm9zIG9uIHZlcnNpb25zIDw9IDcuMC4wLgoKRllJIFdlaSdzIGFwcHJvYWNoIHdhcyBub3QgdG8g
YmUgc3RyaWN0OgpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwL3BhdGNo
LzIwMjYwNDI0MDYwNTQzLjQ2MjQ3NS0xLXB2b3JlbEBzdXNlLmN6LwoKSSBkaWQgbm90IHN1cGVy
c2VkZSBpdCAoc29tZWJvZHkgZGlkKSwgZmVlbCBmcmVlIHRvIGFjayB0aGlzIGFwcHJvYWNoIChh
bmQgSQp3aWxsIG5vdCBzZW5kIHYyKS4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
