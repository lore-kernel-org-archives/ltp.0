Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9C9C3271E
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 04:03:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8183F3D3ABC
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 06:03:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E868F3C61C7
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 06:02:47 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 75DEE1401713
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 06:02:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 564431FBBC;
 Mon,  8 Jul 2024 04:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720411364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKtVEJDeXjpBPTY4afSaL5c+FvnCh0fg4jOYNeCWwgg=;
 b=buCTH80h+E6ZFcF72pZ5XVCbgNmfCJUCMXEEWyBorYrzMsEkbi7iakJZkpVQIh+70wwkTh
 7RscC0Mpxszng6CCkgGgy/ZMc4byAnp5PDPiuAQYYvhfqDGGFuypqudPtC0s9+ZfepO3fP
 FITPRaMN7CLexi5XftWFuqOcucxT9NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720411364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKtVEJDeXjpBPTY4afSaL5c+FvnCh0fg4jOYNeCWwgg=;
 b=ue5Lz4L6dMTYN8hRQSV2zDkClpO2nTs0q2JMU/NPj021xgPssfsMr9ixuOUFELiOGd3vSt
 ynpcMEgMuYz8RbDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720411364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKtVEJDeXjpBPTY4afSaL5c+FvnCh0fg4jOYNeCWwgg=;
 b=buCTH80h+E6ZFcF72pZ5XVCbgNmfCJUCMXEEWyBorYrzMsEkbi7iakJZkpVQIh+70wwkTh
 7RscC0Mpxszng6CCkgGgy/ZMc4byAnp5PDPiuAQYYvhfqDGGFuypqudPtC0s9+ZfepO3fP
 FITPRaMN7CLexi5XftWFuqOcucxT9NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720411364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKtVEJDeXjpBPTY4afSaL5c+FvnCh0fg4jOYNeCWwgg=;
 b=ue5Lz4L6dMTYN8hRQSV2zDkClpO2nTs0q2JMU/NPj021xgPssfsMr9ixuOUFELiOGd3vSt
 ynpcMEgMuYz8RbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1759112FF6;
 Mon,  8 Jul 2024 04:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AdbfBORki2ZAVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Jul 2024 04:02:44 +0000
Date: Mon, 8 Jul 2024 06:02:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Message-ID: <20240708040238.GA117694@pevik>
References: <d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com>
 <2fc3a3fd-7433-45ba-b281-578355dca64c@oracle.com>
 <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <296EA0E6-0E72-4EA1-8B31-B025EB531F9B@oracle.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
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
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
 Sherry Yang <sherry.yang@oracle.com>, linux-stable <stable@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 Calum Mackay <calum.mackay@oracle.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKCj4gPiBPbiBKdWwgMiwgMjAyNCwgYXQgNjo1NeKAr1BNLCBDYWx1bSBNYWNrYXkg
PGNhbHVtLm1hY2theUBvcmFjbGUuY29tPiB3cm90ZToKCj4gPiBUbyBjbGFyaWZ54oCmCgo+ID4g
T24gMDIvMDcvMjAyNCA1OjU0IHBtLCBDYWx1bSBNYWNrYXkgd3JvdGU6Cj4gPj4gaGkgUGV0ciwK
PiA+PiBJIG5vdGljZWQgeW91ciBMVFAgcGF0Y2ggWzFdWzJdIHdoaWNoIGFkanVzdHMgdGhlIG5m
c3N0YXQwMSB0ZXN0IG9uIHY2Ljkga2VybmVscywgdG8gYWNjb3VudCBmb3IgSm9zZWYncyBjaGFu
Z2VzIFszXSwgd2hpY2ggcmVzdHJpY3QgdGhlIE5GUy9SUEMgc3RhdHMgcGVyLW5hbWVzcGFjZS4K
PiA+PiBJIHNlZSB0aGF0IEpvc2VmJ3MgY2hhbmdlcyB3ZXJlIGJhY2twb3J0ZWQsIGFzIGZhciBi
YWNrIGFzIGxvbmd0ZXJtIHY1LjQsCgo+ID4gU29ycnksIHRoYXQncyBub3QgcXVpdGUgYWNjdXJh
dGUuCgo+ID4gSm9zZWYncyBORlMgY2xpZW50IGNoYW5nZXMgd2VyZSBhbGwgYmFja3BvcnRlZCBm
cm9tIHY2LjksIGFzIGZhciBhcyBsb25ndGVybSB2NS40Lnk6Cgo+ID4gMjA1N2E0OGQwZGQwIHN1
bnJwYzogYWRkIGEgc3RydWN0IHJwY19zdGF0cyBhcmcgdG8gcnBjX2NyZWF0ZV9hcmdzCj4gPiBk
NDcxNTFiNzllMzIgbmZzOiBleHBvc2UgL3Byb2MvbmV0L3N1bnJwYy9uZnMgaW4gbmV0IG5hbWVz
cGFjZXMKPiA+IDE1NDgwMzZlZjEyMCBuZnM6IG1ha2UgdGhlIHJwY19zdGF0IHBlciBuZXQgbmFt
ZXNwYWNlCgoKPiA+IE9mIEpvc2VmJ3MgTkZTIHNlcnZlciBjaGFuZ2VzLCBmb3VyIHdlcmUgYmFj
a3BvcnRlZCBmcm9tIHY2LjkgdG8gdjYuODoKCj4gPiA0MThiOTY4N2RlY2Ugc3VucnBjOiB1c2Ug
dGhlIHN0cnVjdCBuZXQgYXMgdGhlIHN2YyBwcm9jIHByaXZhdGUKPiA+IGQ5ODQxNmNjMjE1NCBu
ZnNkOiByZW5hbWUgTkZTRF9ORVRfKiB0byBORlNEX1NUQVRTXyoKPiA+IDkzNDgzYWM1ZmVjNiBu
ZnNkOiBleHBvc2UgL3Byb2MvbmV0L3N1bnJwYy9uZnNkIGluIG5ldCBuYW1lc3BhY2VzCj4gPiA0
YjE0ODg1NDExZjcgbmZzZDogbWFrZSBhbGwgb2YgdGhlIG5mc2Qgc3RhdHMgcGVyLW5ldHdvcmsg
bmFtZXNwYWNlCgo+ID4gYW5kIHRoZSBvdGhlcnMgcmVtYWluZWQgb25seSBpbiB2Ni45OgoKPiA+
IGFiNDJmNGQ5YTI2ZiBzdW5ycGM6IGRvbid0IGNoYW5nZSAtPnN2X3N0YXRzIGlmIGl0IGRvZXNu
J3QgZXhpc3QKPiA+IGEyMjE0ZWQ1ODhmYiBuZnNkOiBzdG9wIHNldHRpbmcgLT5wZ19zdGF0cyBm
b3IgdW51c2VkIHN0YXRzCj4gPiBmMDk0MzIzODY3NjYgc3VucnBjOiBwYXNzIGluIHRoZSBzdl9z
dGF0cyBzdHJ1Y3QgdGhyb3VnaCBzdmNfY3JlYXRlX3Bvb2xlZAo+ID4gM2Y2ZWYxODJmMTQ0IHN1
bnJwYzogcmVtb3ZlIC0+cGdfc3RhdHMgZnJvbSBzdmNfcHJvZ3JhbQo+ID4gZTQxZWU0NGNjNmE0
IG5mc2Q6IHJlbW92ZSBuZnNkX3N0YXRzLCBtYWtlIHRoX2NudCBhIGdsb2JhbCBjb3VudGVyCj4g
PiAxNmZiOTgwOGFiMmMgbmZzZDogbWFrZSBzdmNfc3RhdCBwZXItbmV0d29yayBuYW1lc3BhY2Ug
aW5zdGVhZCBvZiBnbG9iYWwKCgoKPiA+IEknbSB3b25kZXJpbmcgaWYgdGhpcyBkaWZmZXJlbmNl
IGJldHdlZW4gTkZTIGNsaWVudCwgYW5kIE5GUyBzZXJ2ZXIsIHN0YXQgYmVoYXZpb3VyLCBhY3Jv
c3Mga2VybmVsIHZlcnNpb25zLCBtYXkgcGVyaGFwcyBjYXVzZSBzb21lIHVzZXIgY29uZnVzaW9u
PwoKPiBBcyBhIHJlZnJlc2hlciBmb3IgdGhlIHN0YWJsZSBmb2xrZW4sIEpvc2VmJ3MgY2hhbmdl
cyBtYWtlCj4gbmZzc3RhdHMgc2lsbydkLCBzbyB0aGV5IG5vIGxvbmdlciBzaG93IGNvdW50cyBm
cm9tIHRoZSB3aG9sZQo+IHN5c3RlbSwgYnV0IG9ubHkgZm9yIE5GUyBvcGVyYXRpb25zIHJlbGF0
aW5nIHRvIHRoZSBsb2NhbCBuZXQKPiBuYW1lc3BhY2UuIFRoYXQgaXMgYSBzdXJwcmlzaW5nIGNo
YW5nZSBmb3Igc29tZSB1c2VycywgdG9vbHMsCj4gYW5kIHRlc3RpbmcuCgo+IEknbSBub3QgY2xl
YXIgb24gd2hldGhlciB0aGVyZSBhcmUgYW55IHJ1bGVzL2d1aWRlbGluZXMgYXJvdW5kCj4gTFRT
IGJhY2twb3J0cyBjYXVzaW5nIGJlaGF2aW9yIGNoYW5nZXMgdGhhdCB1c2VyIHRvb2xzLCBsaWtl
Cj4gbmZzc3RhdCwgbWlnaHQgYmUgaW1wYWN0ZWQgYnkuCgo+IFRoZSBjbGllbnQtc2lkZSBuZnNz
dGF0IGNoYW5nZXMgYXJlIGZ1bGx5IGJhY2twb3J0ZWQgdG8gYWxsCj4gVFMga2VybmVscy4gQnV0
IHNob3VsZCB0aGV5IGhhdmUgYmVlbj8KCj4gVGhlIHNlcnZlci1zaWRlIG5mc3N0YXQgY2hhbmdl
cyBhcHBlYXIgaW4gb25seSB2Ni45LiBTaG91bGQKPiB0aGV5IGJlIGJhY2twb3J0ZWQgdG8gdGhl
IG90aGVyIExUUyBrZXJuZWxzLCBvciBub3Q/CgpGaXJzdCwgdGhhbmtzIGEgbG90IGZvciBoYXZp
bmcgYSBsb29rIGludG8gdGhlIGlzc3VlLgoKSXQgbG9va3MgdG8gbWUgYXMgYSBmdW5jdGlvbmFs
IGNoYW5nZSwgdGh1cyBJIHdvdWxkIG5vdCBiYWNrcG9ydApjaGFuZ2VzIHVubGVzcyBjaGFuZ2Vz
IHRoZXkgYXJlIG5lZWRlZCB0byBiZSBiYWNrcG9ydGVkIChwYXJ0IHNvbWUgbGFyZ2VyIGZpeCku
ClRodXMgbWF5YmUgcmV2ZXJ0PwoKQW5kIGlmIGJhY2twb3J0ZWQsIEkgd291bGQgZXhwZWN0IGNo
YW5nZXMgb24gYm90aCBzaWRlcyAoY2xpZW50IGFuZCBzZXJ2ZXIpCndvdWxkIGJlIGJhY2twb3J0
ZWQgKG5vdCBqdXN0IHNlcnZlciBzaWRlKS4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiA+PiBzbyB5
b3VyIGNoZWNrIGZvciBrZXJuZWwgdmVyc2lvbiAiNi45IiBpbiB0aGUgdGVzdCBtYXkgbmVlZCB0
byBiZSBhZGp1c3RlZCwgaWYgTFRQIGlzIGludGVuZGVkIHRvIGJlIHJ1biBvbiBzdGFibGUga2Vy
bmVscz8KPiA+PiBiZXN0IHdpc2hlcywKPiA+PiBjYWx1bS4KPiA+PiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbHRwLzIwMjQwNjIwMTExMTI5LjU5NDQ0OS0xLXB2b3JlbEBzdXNlLmN6Lwo+
ID4+IFsyXSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwLyBwYXRjaC8y
MDI0MDYyMDExMTEyOS41OTQ0NDktMS1wdm9yZWxAc3VzZS5jei8KPiA+PiBbM10gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtbmZzLyBjb3Zlci4xNzA4MDI2OTMxLmdpdC5qb3NlZkB0b3hp
Y3BhbmRhLmNvbS8KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
