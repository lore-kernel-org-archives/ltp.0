Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B8DCA0ED1
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 06:14:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 893813CBF13
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 08:14:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78DDC3CBC31
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 08:14:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 950FC1A00249
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 08:14:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85EC11F835;
 Fri, 15 Aug 2025 06:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755238447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iADAzmgCDFW+imp93V5z3gcqSRBKWrvWNRa0rTYVs2Y=;
 b=bwFzWFOH9fkiS+sUNNIrOgOG85Tg/JZmETFDEgyUTTA0oqAhx51FEZGaF7UZes7pxdFH6q
 UaEHYFGLNXN86D13FXnXcVPN577cvqylPU5axF/61x+InuR7zgjZPuUjckIv6Ud5s/EtGf
 10wIN6RIaHhFYcpIo7L4exLnBofKXEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755238447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iADAzmgCDFW+imp93V5z3gcqSRBKWrvWNRa0rTYVs2Y=;
 b=zLtLGzhAIx/21vCwJy4e3CIjQu+cOTtCkdExIrNta90Rt/kXC+dxNl7aWAbVnERA4mcTkd
 Ql5TUxaIwM6OCLAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755238447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iADAzmgCDFW+imp93V5z3gcqSRBKWrvWNRa0rTYVs2Y=;
 b=bwFzWFOH9fkiS+sUNNIrOgOG85Tg/JZmETFDEgyUTTA0oqAhx51FEZGaF7UZes7pxdFH6q
 UaEHYFGLNXN86D13FXnXcVPN577cvqylPU5axF/61x+InuR7zgjZPuUjckIv6Ud5s/EtGf
 10wIN6RIaHhFYcpIo7L4exLnBofKXEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755238447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iADAzmgCDFW+imp93V5z3gcqSRBKWrvWNRa0rTYVs2Y=;
 b=zLtLGzhAIx/21vCwJy4e3CIjQu+cOTtCkdExIrNta90Rt/kXC+dxNl7aWAbVnERA4mcTkd
 Ql5TUxaIwM6OCLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D7EB13876;
 Fri, 15 Aug 2025 06:14:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vlsFBy/QnmgsdQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Aug 2025 06:14:07 +0000
Date: Fri, 15 Aug 2025 08:14:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250815061405.GB32490@pevik>
References: <20250807062941.348971-1-pvorel@suse.cz>
 <20250807062941.348971-2-pvorel@suse.cz>
 <CAEemH2e1CbqCv8Bq4dJgBoRU2hJ72fPTsHJDYV8oLXRgs7SdAw@mail.gmail.com>
 <20250814131857.GB575710@pevik>
 <CAEemH2cLYOrZkHxj=EYcC3MYvB2cAEUhwF+jL9v6KZi2YvysNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cLYOrZkHxj=EYcC3MYvB2cAEUhwF+jL9v6KZi2YvysNQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
 error
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

SGkgTGksCgo+IE9uIFRodSwgQXVnIDE0LCAyMDI1IGF0IDk6MTnigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgTGksCgo+ID4gPiBIaSBQZXRyLAoKPiA+ID4g
SSBhbSBzdGlsbCB0cnlpbmcgdG8gbWFrZSBzdXJlIG15IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVj
dCBvbgo+ID4gPiAnRk9SQ0VfTU9EVUxFUz0xJywKPiA+ID4gd2hpY2ggb25lIGJlbG93IGRvIHlv
dSBtZWFuOgoKPiA+ID4gICAxLiBJZiBhIHN1YmRpcmVjdG9yeSBmYWlscywgaXQgc3RvcHMgZm9y
IHRoYXQgc3ViZGlyZWN0b3J5IGJ1dCB0aGUKPiA+ID4gdG9wLWxldmVsIG1ha2UKPiA+ID4gICAg
ICAgY29udGludWVzIHdpdGggdGhlIG5leHQgZGlyZWN0b3J5IGluIHRoZSBsaXN0LgoKPiA+ID4g
ICAyLiBUaGUgdG9wLWxldmVsIGJ1aWxkIHNob3VsZCBzdG9wIGltbWVkaWF0ZWx5IHdoZW4gYW55
IHN1YmRpcmVjdG9yeQo+ID4gPiBmYWlscy4KCj4gPiA+IElmIHRoZSBhbnN3ZXIgaXMgKDEpLCBJ
IGJlbGlldmUgb3VyIGN1cnJlbnQgcGF0Y2ggaXMgY29ycmVjdCAoZmVlbCBmcmVlIHRvCj4gPiA+
IGFkZCBteSBSQlQpLgo+ID4gPiBIb3dldmVyLCBpZiB0aGUgaW50ZW5kZWQgYmVoYXZpb3IgaXMg
KDIpLCB3ZSB3aWxsIG5lZWQgdG8gYW1lbmQgdGhlCj4gPiA+IHRvcC1sZXZlbCBNYWtlZmlsZQo+
ID4gPiB0byBlbnN1cmUgdGhlIGJ1aWxkIHN0b3BzIGF0IHRoZSBmaXJzdCBmYWlsdXJlLgoKPiA+
IEkgaW50ZW5kZWQgMS4sIGJ1dCBleGl0IGFmdGVyd2FyZHMgbm9uLXplcm8gb24gZXJyb3IuIEJ1
dCB0aGlzIGFjdHVhbGx5IGlzIG5vdAo+ID4gdHJ1ZS4gID0+IHY1IGlzIG5lZWRlZC4KCj4gPiBU
aGUgcmVhc29uIGZvciAxLiB3YXMgdG8gc2VlIHdoaWNoIG1vZHVsZXMgZmFpbGVkIChhbGwgb2Yg
dGhlbSkuCj4gPiBNYXliZSBpdCdkIGJlIGVub3VnaCB0byBpbXBsZW1lbnQgMi4KCj4gWWVzLCBi
dXQgRk9SQ0VfTU9EVUxFUz0xIGlzIHN0aWxsIG1ha2Ugc2Vuc2UsIHBlb3BsZSBtYXkgbm90IGxp
a2UKPiB0byBzZWUgdGhlIG1vZHVsZSdzIGVycm9yIHN0b3AgdGhlIGJ1aWxkIGV2ZXJ5IHRpbWUu
CgpJIGd1ZXNzIHlvdSdyZSB0YWxraW5nIGFib3V0IHRoZSAnbWFrZSBtb2R1bGVzJyBleGl0IGNv
ZGUsIHJpZ2h0PwpOT1RFOiBJIGRvbid0IGV4cGVjdCB0aGlzIHRhcmdldCB3b3VsZCBiZSBydW4g
aW4gcHJvZHVjdGlvbiBidWlsZHMgKGUuZy4gcnBtCm9yIG90aGVyIHBhY2thZ2UgY3JlYXRpb24p
LCBJIHdhbnQgdG8gYWRkIGl0IHRvIENJIGFuZCB1c2UgaW4gbWFudWFsIGRlYnVnZ2luZy4KCldp
dGggdGhlIGNoYW5nZSBhYm92ZSB3ZSdyZSBpbXBsZW1lbnRpbmcgMi4gSSdtIG5vdCBzdXJlIHdo
YXQgaXMgdGhlIGJlc3QuCkZhaWxpbmcgb24gZmlyc3QgZXJyb3IgaGlkZXMgb3RoZXIgZXJyb3Jz
LCBidXQgaXQncyBlYXNpZXIgdG8gc3BvdCB0aGUgZXJyb3IsCnRoZXJlZm9yZSBJIHRlbmQgdG8g
dGhpcyB2YXJpYW50LgoKMS4gaXMgZ29vZCB0byBzZWUgYWxsIGZhaWx1cmVzLCBidXQgb25lIGNh
biBvdmVybG9vayB0aGUgcmVzdWx0LiBJZiB3ZSBkZWNpZGUKYWJvdXQgaXQsIEkgd291bGQgcHJl
ZmVyIHRvIGV4aXQgbm9uLXplcm8gaWYgYW55IG9mIHRoZSBtb2R1bGVzIGZhaWwgKGxldCdzIGNh
bGwKaXQgdmFyaWFudCAzLikuCgo+ID4gVGhpcyB3b3JrcyBmb3IgbWUgKHNlbmRpbmcgdjUgdG9k
YXkpOgo+ID4gLSAgICAgICAgICAgICAgICQoTUFLRSkgLUMgJChhYnNfc3JjZGlyKS8kKGRpcik7
IFwKPiA+ICsgICAgICAgICAgICAgICAkKE1BS0UpIC1DICQoYWJzX3NyY2RpcikvJChkaXIpOyBb
ICQkPyAtZXEgMCBdIHx8IGV4aXQgZXhpdCAkJD87IFwKCj4gV2h5IG5vdDoKPiAgICAgJChNQUtF
KSAtQyAkKGFic19zcmNkaXIpLyQoZGlyKSB8fCBleGl0ICQkPzsgXAoKQWgsIHRoYXQncyBvZiBj
b3Vyc2UgYmV0dGVyLiBJIHdhcyBvYnZpb3VzbHkgbm90IGNvbmNlbnRyYXRlZCBlbm91Z2guCgo+
ID4gSSB3b25kZXIgaWYgaXQncyBlbm91Z2ggdG8gYWRkIHRoZSBjaGFuZ2Ugb25seSB0byAnbW9k
dWxlcycgdGFyZ2V0IG9yIHdoZXRoZXIgSQo+ID4gc2hvdWxkIGFkZCBpdCB0byB0aGUgb3RoZXJz
IChtb2R1bGVzLWNsZWFuLCBtb2R1bGVzLWluc3RhbGwpIGFzIHdlbGwuCgo+IFRvIGVuc3VyZXMg
Y29uc2lzdGVudCBhbmQgY29ycmVjdCBlcnJvciBoYW5kbGluZywgd2UgcHJvYmFibHkgbmVlZCB0
bwo+IHRha2UgY2FyZSBhbGwuCgpSaWdodCwgSSdsbCBhZGQgaXQuCgo+IE5vcm1hbGx5LCB3ZSB3
b3VsZG4ndCBlbmNvdW50ZXIgY2xlYW51cC9pbnN0YWxsYXRpb24gZXJyb3JzLCBidXQgaW1hZ2lu
ZSBpZgo+IG1vZHVsZXMtY2xlYW4gZmFpbGVkIGluIGEgc3ViZGlyZWN0b3J5IGJ1dCBjb250aW51
ZWQgc2lsZW50bHkuIFdlIG1pZ2h0IHRoaW5rCj4gZXZlcnl0aGluZyB3YXMgY2xlYW5lZCwgYnV0
IG91dGRhdGVkIC5rbyBvciAubyBmaWxlcyBtaWdodCByZW1haW4uCgorMQoKPiBGb3IgbW9kdWxl
cy1pbnN0YWxsOiBmYWlsIGZhc3QgYnkgZGVmYXVsdCB0byBhdm9pZCBhIHBhcnRpYWxseQo+IGlu
c3RhbGxlZCB0cmVlIGlzIG5lY2Vzc2FyeS4KCisxCgpJJ2xsIHNlbmQgdjUgZHVyaW5nIHRvZGF5
ICh3YWl0IGxpdHRsZSBsb25nZXIgZm9yIHlvdXIgZmVlZGJhY2spLgoKS2luZCByZWdhcmRzLApQ
ZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
