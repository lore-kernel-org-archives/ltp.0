Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211B9C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 09:14:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 871B73CC7EF
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 10:14:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FD1B3CB0C4
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 10:14:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1631608A9B
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 10:14:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 605FD1FD65;
 Fri,  3 Nov 2023 09:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699002881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW7B2P0dCjEIuMn9RXrZCwQhAUMnmTgAYJsXyMmZzzM=;
 b=On9Enjl3NwMP6dvM9ytSwEFBCFmMN4a3FirBtlcv1sLYyWD+ZOuJWJl+fmApLJoSKfBZR8
 x4I+2cmn2iz2keNKwR1REOSaeFwFtBTb9h5XnalZ1QIAUV3I2eY5/Xuq+Umhq3Oqnd0qpZ
 Y9lOABx2FWHXEOEsfsuneoLnpxfKW+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699002881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW7B2P0dCjEIuMn9RXrZCwQhAUMnmTgAYJsXyMmZzzM=;
 b=lRUfTBBGV/VMy2tGfe3D0AtQBpsxRhGnrjKmXRZBaG6pJUo3/6WUSCIlXF3sOoimmtO51P
 O/F//JP8fBFF2mAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0143713907;
 Fri,  3 Nov 2023 09:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id elYTOgC6RGU2bwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 09:14:40 +0000
Date: Fri, 3 Nov 2023 10:14:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231103091439.GA1026385@pevik>
References: <20231102072030.1800796-1-liwang@redhat.com>
 <20231102092135.GA921952@pevik>
 <CAEemH2fWDQgPv+9TR9nb4rw5CsJx3uGKS+Yvb3YqgNEOUSVYmg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fWDQgPv+9TR9nb4rw5CsJx3uGKS+Yvb3YqgNEOUSVYmg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: add centos stream support
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
Cc: Chao Ye <cye@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBQZXRyLAoKPiBPbiBUaHUsIE5vdiAyLCAyMDIzIGF0IDU6MjHigK9QTSBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgTGksCgo+ID4gPiBUaGlzIGlzIGJhc2Ug
b24gUGV0ZXIncyBwYXRjaDoKPiA+ID4gICBDSTogUmVBcGxhY2UgQ2VudE9TIDcgd2l0aCBvcGVu
U1VTRSBMZWFwIDQyLjIsIFVidW50dSB4ZW5pYWwKCj4gPiA+IENpOiBodHRwczovL2dpdGh1Yi5j
b20vd2FuZ2xpNTY2NS9sdHAvYWN0aW9ucy9ydW5zLzY3MjkzNzk1NjUKCj4gPiBSZXZpZXdlZC1i
eTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgoKPiBUaGFua3MhCgoKPiA+IEFUTSB3ZSBo
YXZlIDE4IGpvYnMsIElNSE8gd2Ugc2hvdWxkIG5vdCBhZGQgbW9yZSB3aXRob3V0IHJlbW92aW5n
IG90aGVycwo+ID4ganVzdCB0bwo+ID4gaGF2ZSByZWFzb25hYmxlIENJIHJ1bnRpbWUuCgoKPiBZ
b3VyIGNvbmNlcm4gbWFrZXMgc2Vuc2UsIGJ1dCBJIGhhdmUgbm8gaWRlYSB3aGljaCBvbmUgY291
bGQgYmUgcmVtb3ZlZC4KCkkgd29uZGVyIGlmIGp1c3QgYWRkaW5nIENlbnRPUyA5IHdvdWxkIGJl
IGVub3VnaC4gQmVjYXVzZSBpbiBDSSB3ZSB0ZXN0IGp1c3QKY29tcGlsYXRpb24uIFRoZSBwb2lu
dCBvZiB0aGUgcHVibGljIENJIGlzIHRvIHRlc3QgdGhlIG9sZGVzdCBkaXN0cm9zLCBuZXdlc3QK
ZGlzdHJvcyBhbmQgc29tZXRoaW5nIGluIGJldHdlZW4sIHRoYXQgc2hvdWxkIGNvdmVyIHRoZSBt
b3N0IG9mIGNvbXBpbGF0aW9uCnByb2JsZW1zIChubyBuZWVkIHRvIHRlc3QgKmFsbCogdXNlZCBk
aXN0cm9zIHRvIGJlIHNhZmUpLgpCdXQgc3VyZSwgYm90aCBjYW4gc3RheSBpZiB5b3Ugd2FudC4g
VGhlIHJ1bnRpbWUgaXMgc3RpbGwgcmVhc29uYWJsZS4KTk9URTogSSBkaWQgbm90IGNhcmUgbXVj
aCBpbiBjYXNlIG9mIGlwdXRpbHMsIHdoaWNoIGhhdmUgbXVjaCBmYXN0ZXIgYnVpbGQgdGhhbgpM
VFAuCgpJZiB3ZSB3YW50IHRvIGFkZCBib3RoIENlbnRPUyA4IGFuZCA5LCB3ZSBjb3VsZCByZW1v
dmUgc29tZSBvZiBkZWJpYW46b2xkc3RhYmxlIChidWxsc2V5ZSkKKHNpbWlsYXIga2VybmVsKS4K
CkFuZCwgd2UgY291bGQgYWRkIGp1c3Qgb3BlblNVU0UgTGVhcCA0Mi4yLCB3aGljaCBoYXMgb2xk
ZXIgZ2xpYmMgYW5kIGdjYyB0aGFuClVidW50dSAxNi4wNCBMVFMgeGVuaWFsLiBGb3Igc3VyZSB0
aGVyZSBhcmUgbW9yZSBwZW9wbGUgd2hpY2ggdXNlIHhlbmlhbCB0aGFuCm9sZCBMZWFwIDQyLjIs
IGJ1dCBhcyBJIHNhaWQsIHRoZSBnb2FsIGlzIHRvIHRlc3QgdGhlIG9sZGVzdCBkaXN0cm8gd2UK
bWFpbnRhaW5lcnMgcmVhbGx5IGNhcmUgYWJvdXQgKGFuZCBkbyBub3QgaGF2ZSBleHRyYSB3b3Jr
IGZvciBub3RoaW5nLCB3aGljaCBpcwpJTUhPIGtlZXBpbmcgQ2VudE9TIDcgY29tcGlsYWJsZSku
CgpXRFlUPwoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
