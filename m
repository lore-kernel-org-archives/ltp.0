Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D53CA1013
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 20:35:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 605DC3D2899
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 22:35:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9599F3CF9DA
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:35:10 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 98BDE600763
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:35:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFB911F7F0;
 Fri, 30 Aug 2024 20:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725050108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxsZ91NSS+MS3t+20vrmGZlARy/YjprZCAdsS6DDuZ0=;
 b=Uu7s7fnxt8e480N+TjpuV/A2DrGoBlfLgZ1RFxrWDXHfNZpx9IQmKe7v7NyDXZ0/8AX+Ca
 XR0q+zhuEzAqV/BDEj9+4iDbJMDGSHebFg8v0tngRQtRD7uzJk5dQ61w6phA7dCeWux8CI
 plx6/qQasaHiMC7DWduL0vyxGL2LXBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725050108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxsZ91NSS+MS3t+20vrmGZlARy/YjprZCAdsS6DDuZ0=;
 b=s8Rwp34igbRIiZH+VEe1Bf3GrgpPdQSc928W4L6YMwRAnCJ3xoNMsjcnKSLHhtRGDZS/db
 oqAdRbkKqsbgxuBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=liwtRNF3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YcQRYiXe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725050107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxsZ91NSS+MS3t+20vrmGZlARy/YjprZCAdsS6DDuZ0=;
 b=liwtRNF3UzPjQj5K4O7U7IyoKfx7KW/gm/6Ql7Is9P3HtAO62FTz8LbdoiTHis8TF31DwG
 SDgmmOWi47FTn29LC935dnPt9BlBhlAqe10sXf0+SZuIiDQQ0R9KPXY0YQmmU4n1eaG+kD
 gOeTnnMXRo+bDjBexACknqzUrTGn1A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725050107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxsZ91NSS+MS3t+20vrmGZlARy/YjprZCAdsS6DDuZ0=;
 b=YcQRYiXemeUwzI7EWRAOXW5i0kuZDmB6b9uWfAT8j/1eYMAtK1hiusgowNpd+pl0f4AqW8
 2aDONk9s6llaXcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73BB313A3D;
 Fri, 30 Aug 2024 20:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c2zKGvss0mauTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 20:35:07 +0000
Date: Fri, 30 Aug 2024 22:35:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Message-ID: <20240830203501.GA94648@pevik>
References: <20240318231603.2221376-1-sashal@kernel.org>
 <CAOQ4uxjxSQESOZVCV_yL=uwG5+Y89sYRozVSgHPpaudG4CwZqw@mail.gmail.com>
 <ACB7BCB8-E6EA-41DC-8228-881081AA0596@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ACB7BCB8-E6EA-41DC-8228-881081AA0596@oracle.com>
X-Rspamd-Queue-Id: CFB911F7F0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_EQ_ADDR_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.cz,google.com,kernel.org,lists.linux.it];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Patch "fsnotify: consistent behavior for parent not
 watching children" has been added to the 5.15-stable tree
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
Cc: Sasha Levin <sashal@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Bobrowski <repnop@google.com>,
 "stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ2h1Y2ssCgo+IEhpIEFtaXItCgo+ID4gT24gTWFyIDIwLCAyMDI0LCBhdCAyOjU34oCvQU0s
IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOgoKPiA+IFBsZWFzZSBm
b2xsb3cgdXAgaW4gYWRqdXN0aW5nIHRoZSBMVFAgdGVzdCBmYW5vdGlmeTA5IHRvIHVwZGF0ZSB0
aGlzCj4gPiBjb21tZW50IHdpdGggdGhlIGFwcHJvcHJpYXRlIDUuMTUueSB2ZXJzaW9uOgoKPiA+
ICogVGVzdCBjYXNlcyAjNi0jNyBhcmUgcmVncmVzc2lvbiB0ZXN0cyBmb3IgY29tbWl0Ogo+ID4g
KiAoZnJvbSB2NS4xOSwgdW5saWtlbHkgdG8gYmUgYmFja3BvcnRlZCB0aHVzIG5vdCBpbiAudGFn
cyk6Cj4gPiAqCj4gPiAqICAgICAgZTczMDU1OGFkZmZiIGZhbm90aWZ5OiBjb25zaXN0ZW50IGJl
aGF2aW9yIGZvciBwYXJlbnQgbm90Cj4gPiB3YXRjaGluZyBjaGlsZHJlbgoKPiA+IEFzIHdlbGwg
YXMgdGhpcyBoYWNraXNoIHRlc3QgY29uZGl0aW9uOgoKPiA+ICAgICAgICBpZiAodGMtPmlnbm9y
ZSAmJiB0c3Rfa3ZlcmNtcCg1LCAxOSwgMCkgPCAwKSB7Cj4gPiAgICAgICAgICAgICAgICB0c3Rf
cmVzKFRDT05GLCAiaWdub3JlZCBtYXNrIG9uIHBhcmVudCBkaXIgaGFzIHVuZGVmaW5lZCAiCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImJlaGF2aW9yIG9uIGtlcm5lbCA8IDUu
MTkiKTsKPiA+ICAgICAgICAgICAgICAgIHJldHVybjsKPiA+ICAgICAgICB9Cgo+IEknbSBub3Qg
c3VyZSBob3cgdGhpcyBjaGVjayBzaG91bGQgYmUgYWx0ZXJlZC4KCj4gVGhlIGZpeCBpbiBxdWVz
dGlvbiBub3cgYXBwZWFycyBpbiBib3RoIDUuMTAuMjIwIGFuZAo+IDUuMTUuMTU0LiBXaGljaCBt
ZWFucyB0aGUgY29tbWl0IGlzIGluLCBmb3IgaW5zdGFuY2UsCj4gNS4xMC4yMjIgYW5kIDUuMTUu
MTYwLCBidXQgbm90IGluIDUuMTMuMCBvciA1LjE3LjAuCgpUaGFuayB5b3UgZm9yIG5vdGljaW5n
IHRoYXQuIFRoZSBjb21tZW50IG9uIHRoZSB0ZXN0IHBhdGNoIFsxXSB3YXM6CgogKiBUZXN0IGNh
c2VzICM2LSM3IGFyZSByZWdyZXNzaW9uIHRlc3RzIGZvciBjb21taXQ6CiAqIChmcm9tIHY1LjE5
LCB1bmxpa2VseSB0byBiZSBiYWNrcG9ydGVkIHRodXMgbm90IGluIC50YWdzKToKCkkgc2VlIGlu
IHRoZSBlbmQgaXQgZ290IGJhY2twb3J0ZWQuIE5vdyB3ZSBoYXZlIHRvIGRlY2lkZSB3aGV0aGVy
IGl0J3MgaW1wb3J0YW50CmVub3VnaCB0aGF0IHdlIHNob3VsZCBwdXQgY29tbWl0IGluIHRoZSB0
YWcgYW5kIHJ1biBpdCB1bmNvbmRpdGlvbmFsbHkKKHByZWZlcnJlZCB3YXkgZm9yIGZpeGVzKSBv
ciBmcm9tIHRoZSBsYXRlc3Qgc3RhYmxlIGtlcm5lbCB2ZXJzaW9uIHdoaWNoIGdvdCB0aGUKYmFj
a3BvcnQuCgpBRkFJSyBMVFAgc2hvdWxkIG5vdCB0cnkgdG8gaGlkZSBidWdzLCByZXBvcnQgbWlz
c2luZyBmaXguIEFuZCBpdCdzIHVwIHRvCnRlc3RlcnMgYW5kIHRoZSBwcm9qZWN0cyBpZiB0aGV5
IGNvbnNpZGVyIHRoZSBwcm9ibGVtIGFzIFdPTlRGSVggb3IgdGhlIGtlcm5lbAp0aGV5IHRlc3Qg
d2lsbCBiYWNrcG9ydCB0aGUgZml4LgoKS2luZCByZWdhcmRzLApQZXRyCgpbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbHRwLzIwMjIwNjIwMTMyNzM3LjIwMTUwNzMtNS1hbWlyNzNpbEBnbWFp
bC5jb20vCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
