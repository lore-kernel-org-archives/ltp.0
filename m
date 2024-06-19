Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525E3C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 13:31:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A58013D0DD1
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 15:31:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37CDB3D0DA3
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 15:31:03 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7FD46601159
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 15:31:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B5031F83C;
 Wed, 19 Jun 2024 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718803860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dN9IVk214i7qlpKFuRW+n++qSKVCt7hCNcSZg46BcQ=;
 b=HVPdkcsHTsNNG4mAF+zEYqnoEZmKhW6plrFnva9CWGO0E18zl+VbBUZ/S13stHULQGJraV
 B/XjmdAyyQkLhEYtN2cKlUp22LPCxId+U29Z4mCn3m/U+Y0yI0+dQpZE7msN2BpGzYHNdp
 fbBAlVrfOM0OA2Mw6SyjwWxvgKhFeS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718803860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dN9IVk214i7qlpKFuRW+n++qSKVCt7hCNcSZg46BcQ=;
 b=jdMhmUedo4LLWNhnuZeRikWqHQSuyZatjh7O9Mqryh6KwWdHDLQaC4XUdlHJBIWrLNBm39
 5d9QK8wrZt18mBAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HVPdkcsH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jdMhmUed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718803860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dN9IVk214i7qlpKFuRW+n++qSKVCt7hCNcSZg46BcQ=;
 b=HVPdkcsHTsNNG4mAF+zEYqnoEZmKhW6plrFnva9CWGO0E18zl+VbBUZ/S13stHULQGJraV
 B/XjmdAyyQkLhEYtN2cKlUp22LPCxId+U29Z4mCn3m/U+Y0yI0+dQpZE7msN2BpGzYHNdp
 fbBAlVrfOM0OA2Mw6SyjwWxvgKhFeS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718803860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dN9IVk214i7qlpKFuRW+n++qSKVCt7hCNcSZg46BcQ=;
 b=jdMhmUedo4LLWNhnuZeRikWqHQSuyZatjh7O9Mqryh6KwWdHDLQaC4XUdlHJBIWrLNBm39
 5d9QK8wrZt18mBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3B2713ABD;
 Wed, 19 Jun 2024 13:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D3haMpPdcmaGewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jun 2024 13:30:59 +0000
Date: Wed, 19 Jun 2024 15:30:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240619133058.GA457380@pevik>
References: <20240619073345.326108-1-liwang@redhat.com>
 <20240619074703.GA410266@pevik>
 <CAEemH2d3gVj+cSvVc6-Qvj4CxhBO4pVnqfouYBg03myH+S87mw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d3gVj+cSvVc6-Qvj4CxhBO4pVnqfouYBg03myH+S87mw@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0B5031F83C
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kconfig: Avoid buffer overflow when parsing
 /proc/cmdline
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

SGkgTGksCgo+IE9uIFdlZCwgSnVuIDE5LCAyMDI0IGF0IDM6NDfigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gPiBXaGVuIHRoZSB0ZXN0IGlzIHJ1biB3aXRoIGEg
a2VybmVsIGJvb3Rpbmcgd2l0aCBtYW55IHBhcmFtZXRlcnMsIHRoZQo+ID4gPiBidWZmZXIgc2l6
ZSBpcyBvZnRlbiBub3QgbGFyZ2UgZW5vdWdoIHRvIHN0b3JlIHRoZSBjb21wbGV0ZSBjb21tYW5k
Cj4gPiA+IGxpbmUuIFRoaXMgcmVzdWx0cyBpbiBhIGJ1ZmZlciBvdmVyZmxvdyBhbmQgdGhlIHRl
c3QgY29tcGxhaW5zIHdpdGgKPiA+ID4gdGhlIGZvbGxvd2luZyBtZXNzYWdlOgoKPiA+ID4gICB0
c3Rfa2NvbmZpZy5jOjYwOTogVFdBUk46IEJ1ZmZlciBvdmVyZmxvd2VkIHdoaWxlIHBhcnNpbmcg
L3Byb2MvY21kbGluZQoKPiA+IFRoYW5rcyBmb3IgdGhlIGZpeCEKCj4gPiBSZXZpZXdlZC1ieTog
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiBGaXhlczogMTgwODM0OTgyICgia2NvbmZp
ZzogYWRkIGZ1bnRpb24gdG8gcGFyc2UgL3Byb2MvY21kbGluZSIpCgo+ID4gTk9URSB0c3Rfa2Nv
bmZpZ19yZWFkKCkgaGFzIGNoYXIgbGluZVsxMjhdLCBhbHNvIHN0cnVjdCB0c3Rfa2NtZGxpbmVf
dmFyCj4gPiBtZW1iZXIKCgo+IFR5cGljYWxseSAxMjggaXMgbG9uZyBlbm91Z2ggZm9yIExpbnV4
IGtlcm5lbCBwYXJhbWV0ZXJzLCBvdGhlcndpc2UgaXQgaGFyZAo+IGZvciBwZW9wbGUgdG8gbWVt
b3JpemUgdGhlIG5hbWUgYW5kIHZhbHVlLgoKU3VyZSwgbGV0J3Mga2VlcCBpdCBmb3Igbm93LCBi
dXQgZXhhbXBsZXMgd2UgYXJlIGdldHRpbmcgY2xvc2UgOikuIFNvb25lciBvcgpsYXRlciB0aGVz
ZSBjb25maWdzLCB3aGljaCBhcmUgZ2VuZXJhdGVkIGJ5IHRvb2xjaGFpbiB3aWxsIGJlIGxvbmdl
ciB0aGFuIDEyOApjaGFyczoKCiQgYXdrICdsZW5ndGggPiBtYXhfbGVuZ3RoIHsgbWF4X2xlbmd0
aCA9IGxlbmd0aDsgbG9uZ2VzdF9saW5lID0gJDAgfSBFTkQgeyBwcmludCBsb25nZXN0X2xpbmUg
fScgL2Jvb3QvY29uZmlnKgpDT05GSUdfQ0NfVkVSU0lPTl9URVhUPSJnY2MgKFNVU0UgTGludXgp
IDEzLjIuMSAyMDI0MDIwNiBbcmV2aXNpb24gNjdhYzc4Y2FmMzFmN2NiMzIwMjE3N2U2NDI4YTQ2
ZDgyOWI3MGYyM10iCgokIGF3ayAnbGVuZ3RoID4gbWF4X2xlbmd0aCB7IG1heF9sZW5ndGggPSBs
ZW5ndGg7IGxvbmdlc3RfbGluZSA9ICQwIH0gRU5EIHsgcHJpbnQgbG9uZ2VzdF9saW5lIH0nIC9i
b290L2NvbmZpZyogfCB3YyAtTAoxMDkKCkkgd2FzIHN1cnByaXNlZCBldmVuIHJlYWwgY29uZmln
IG9wdGlvbiB3YXMgcXVpdGUgbG9uZzoKCiQgYXdrICdsZW5ndGggPiBtYXhfbGVuZ3RoIHsgbWF4
X2xlbmd0aCA9IGxlbmd0aDsgbG9uZ2VzdF9saW5lID0gJDAgfSBFTkQgeyBwcmludCBsb25nZXN0
X2xpbmUgfScgL2Jvb3QvY29uZmlnKgpDT05GSUdfTFNNPSJsYW5kbG9jayxsb2NrZG93bix5YW1h
LGxvYWRwaW4sc2FmZXNldGlkLGludGVncml0eSxhcHBhcm1vcixzZWxpbnV4LHNtYWNrLHRvbW95
byxicGYiCgokIGF3ayAnbGVuZ3RoID4gbWF4X2xlbmd0aCB7IG1heF9sZW5ndGggPSBsZW5ndGg7
IGxvbmdlc3RfbGluZSA9ICQwIH0gRU5EIHsgcHJpbnQgbG9uZ2VzdF9saW5lIH0nIC9ib290L2Nv
bmZpZyogfCB3YyAtTAo5NwoKPiA+IGhhcyB0aGlzIGxlbmd0aC4gVGhlIGxvbmdlc3QgbGluZSBv
biBzb21lIG9uIG15IHN5c3RlbXMgaXMgMTA5LCBpdCdzIHN0aWxsCj4gPiBPSywKPiA+IGhvcGVm
dWxseSBpdCBzdGF5cyA6KS4KCgo+IEhtbSwgZ29vZCBwb2ludC4gQWZ0ZXIgdGhpbmtpbmcgaXQg
b3Zlciwgc2VlbXMgdG9vIGhhc3R5IHRvIGVubGFyZ2UgdGhlCj4gYnVmW10gc2l6ZSB0byA1MTIu
Cgo+IFdlJ2QgYmV0dGVyIGtlZXAgdGhlIHNpemUgc2FtZSBiZXR3ZWVuICd0c3Rfa2NtZGxpbmVf
dmFyLnZhbHVlJyB0byB0aGUKPiBsb2NhbCAnYnVmW10nLgorMS4gSSB3b3VsZCBldmVuIGRlZmlu
ZSBhIGNvbnN0YW50IHRvIGtlZXAgdGhlc2UgMiBzaXplcyB0aGUgc2FtZS4KCj4gQW5kIHRoZSBv
dmVyZmxvdyBpcyBub3QgYSBwcm9ibGVtLCBpdCBqdXN0IGRyb3BzIHNvbWUgdW51c2VkIGluZm9b
MV0gdG8KPiByZWxvb3AgdG8KPiB0aGUgaGVhZCBmb3Igc2F2aW5nIG91ciB0YXJnZXQgcGFyYW1l
dGVyLgoKPiBbMV0gQk9PVF9JTUFHRT0oaGQwLGdwdDIpL29zdHJlZS9jZW50b3MtZGQ3NDE1ZWQy
YzdjYzNmNjViZGM0YmY4ZjlhNjNiOTViYmIxM2VlMGZlZTYzM2Y2YjkyYTg3Mjk0NGQxZDZlNC92
bWxpbnV6LTUuMTQuMC00eHguNHh4LjQ0OTVfMTMzNjU4Mzk0NC5lbDlpdi54ODZfNjQKCkFoLCB3
aGF0IGEgbG9uZyBwYXJhbWV0ZXIgOikuIE9UT0ggd291bGQgaXQgaGFybSB0byBlbmxhcmdlIGJv
dGggdG8gMjU2IG9yIGV2ZW4KNTEyPwoKPiBJJ20gdGhpbmtpbmcgb2YgbG93ZXJpbmcgdGhlIHBy
aW9yaXR5IGluZm8gZnJvbSBUV0FSTiB0byBUSU5GTyBpbiB0aGF0IGxpbmU6Cj4gICAgIHRzdF9y
ZXMoVFdBUk4sICJCdWZmZXIgb3ZlcmZsb3dlZCB3aGlsZSBwYXJzaW5nIC9wcm9jL2NtZGxpbmUi
KTsKClllcywgYnV0IGFyZSB5b3Ugc3VyZSB0aGF0IG9jY2FzaW9uYWwgbG9uZyBwYXJhbWV0ZXIg
d2lsbCBiZSBhbHdheXMgaXJyZWxldmFudD8KSSdkIHJlYWxseSBpbmNyZWFzZSB0aGUgc2l6ZS4K
CktpbmQgcmVnYXJkcywKUGV0cgoKPiBJIHdpbGwgc2VuZCBhIHBhdGNoIFYyIG9uY2UgZ2V0IGEg
YmV0dGVyIHNvbHV0aW9uLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
