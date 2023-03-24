Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB82BC6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 06:12:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081623CC3CD
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 07:12:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A9263CA4F3
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 07:12:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 43DDC14010D1
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 07:12:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 364071FE6B;
 Fri, 24 Mar 2023 06:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679638356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eo+x976LpzDrosG2iNFg50/evSkMSfFPCTrzJ70wQcw=;
 b=K46/WaWnF+rsP+Cm3xEAuhH6Eb/Qp8hW2Jb5l1OHcJyiN82s3ECqI6eHcdhLT6qddyIW9s
 Zihv1K7Zg27zUF8ClTPdn7JRgNODFoFStozuxA5W/gyYffaXmQjDtKhq/PK3Wz0miT3CHR
 mayJ0K1w9NVIHbAkLLFvRggV2996iMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679638356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eo+x976LpzDrosG2iNFg50/evSkMSfFPCTrzJ70wQcw=;
 b=IEnmhote3G8b3sgqsSsUCdKNfMBmH50C3w4UhxRrMWH5KiTFadjkJHm5xgRFUL05gVRNFY
 xmArh6dtZcShrmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDC30133E5;
 Fri, 24 Mar 2023 06:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7hGmOFM/HWTgOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 24 Mar 2023 06:12:35 +0000
Date: Fri, 24 Mar 2023 07:12:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230324061234.GA516079@pevik>
References: <20230320235108.2058967-1-edliaw@google.com>
 <20230320235108.2058967-3-edliaw@google.com>
 <20230323085216.GC405493@pevik>
 <CAG4es9WSByGyehAh3fvw2W0o-sh974WNBKym-1gMwJUx-V+Bcw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9WSByGyehAh3fvw2W0o-sh974WNBKym-1gMwJUx-V+Bcw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] set_dev_loop_path: Refactor set_dev_path
 and check return value
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
Cc: kernel-team@android.com,
 Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIE1hciAyMywgMjAyMyBhdCAxOjUy4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEVkd2FyZCwKCj4gPiA+IHRzdF9maW5kX2ZyZWVfbG9vcGRl
diBkb2VzIG5vdCBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIG9mIHNldF9kZXZfcGF0aAo+ID4gPiBh
bmQgd2lsbCByZXR1cm4gdGhlIGxhc3QgYXR0ZW1wdGVkIHBhdGggZXZlbiBpZiBpdCBkb2VzIG5v
dCBwYXNzIGEgc3RhdAo+ID4gPiBjaGVjay4gIHNldF9kZXZfcGF0aCBhbHNvIGhhcyBhIHJldHVy
biB2YWx1ZSB0aGF0IGlzIG5vdCBjb25zaXN0ZW50IHdpdGgKPiA+ID4gdGhlIG90aGVyIGZ1bmN0
aW9ucyBpbiB0aGlzIGZpbGUuCgo+ID4gVGhpcyBjaGFuZ2UgYW5kIGNoYW5nZSBvZiByZXR1cm4g
aXMgYSBiaXQgYnVyZGVuIGluIGxvb3AgcmVuYW1lIGNoYW5nZXMuCj4gPiBJJ20gb2sgaXQncyBp
biBzaW5nbGUgcGF0Y2gsIGJ1dCBpdCdkIGJlIG1vcmUgcmVhZGFibGUgaWYgaXQgd2VyZSBzZXBh
cmF0ZS4KCj4gTm90IGEgcHJvYmxlbSwgSSB3aWxsIHNwbGl0IGl0LgoKKzEKCkFsc28sIHBsZWFz
ZSByZWJhc2UgKEkgcHVzaGVkIHNvbWUgY2hhbmdlcykgd2hpY2ggdG91Y2ggZmlsZXMgeW91IGFs
c28gbW9kaWZ5LgoKPiA+IHNldF9kZXZfcGF0aCgpIGlzIGdvaW5nIHRvIGJlIGNhbGxlZCBvbmx5
IGlmIG5vbi1OVUxMIHBhdGgKPiA+IChzZWUgaW5jbHVkZS90c3RfZGV2aWNlLmgpLiBJIGhhdmVu
J3QgZm91bmQgYSB0ZXN0IHdoaWNoIHVzZXMgaXQgdGhpcyB3YXksCj4gPiBidXQgc2hvdWxkbid0
IGl0IGJlIGNoZWNraW5nIHBhdGgsIGluc3RlYWQgb2YgIXBhdGg/Cgo+ID4gICAgICAgICBpZiAo
cGF0aCAmJiBzZXRfZGV2X2xvb3BfcGF0aChyYywgcGF0aCwgcGF0aF9sZW4pICE9IDApCgo+ID4g
S2luZCByZWdhcmRzLAo+ID4gUGV0cgoKPiBPb3BzLCBJIG1pc3NlZCB0aGF0IGluIHRoZSBjb21t
ZW50IGFuZCB0aG91Z2h0IGEgTlVMTCBwYXRoIHNob3VsZCBiZQo+IGNoZWNrZWQgYXMgYW4gZXJy
b3IuICBZb3UgYXJlIHJpZ2h0LCBJIHdpbGwgY2hhbmdlIGl0LiAgQWxzbywgSSB3YXNuJ3QKPiBz
dXJlIGlmIEkgc2hvdWxkIGJlIGV4cGxpY2l0IHdpdGggdGhlICIhPSAwIi4KCkkgZ3Vlc3Mgd2Ug
YXJlIHF1aXRlIG9rIHdpdGgganVzdCAiISIuIFdlIHRyeSB0byBiZSBwcmVjaXNlIGF0IHN5c2Nh
bGxzIHRlc3RpbmcKKHRvIGNoZWNrIGlmIHRoZSByZXR1cm4gdmFsdWUgb24gZXJyb3IgaXMgZXhh
Y3RseSAtMSwgbm90IGp1c3QgPCAwLCBidXQgd2l0aApub3JtYWwgbm9uLXRlc3RpbmcgY29kZSBs
aWtlIHRoaXMgaW4gdHN0X2tlcm5lbC5jIGl0J3Mgbm90IG5lZWRlZC4KCktpbmQgcmVnYXJkcywK
UGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
