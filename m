Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446C1C5B555
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 14:39:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A68563CA59D
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 16:39:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03DAA3C9B17
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 16:39:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 09DFE100098E
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 16:39:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC4651F445;
 Fri,  6 Jun 2025 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749220777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UlNnd+M6YLIb1JemhbGnVu/WRSPGEmnqN2idiNpcTcw=;
 b=h3PnxosQJ4yeFgDr33QKoyMYwVN7Gj5Lf0tm7GHDcDMSHdD74C/amUVhGYNuqOhx2BAPSz
 2Fv8yVezUq24MK0mBZDZ6EhUdFMBrCeMMPQmCC90q3se94ByFt/e74fFxvf9T+KXGN+X/q
 TL7T0nZXIAf66/6q29kQK7UrEvNXnTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749220777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UlNnd+M6YLIb1JemhbGnVu/WRSPGEmnqN2idiNpcTcw=;
 b=8C3QdyZAaIHBO+FNyjBslqN4JSdNxqILgYrwT5Ea9FiKSDJPa2veDiZ51W+7feXh2QGYSY
 A+DxGbt1mTFARvBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h3PnxosQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8C3QdyZA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749220777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UlNnd+M6YLIb1JemhbGnVu/WRSPGEmnqN2idiNpcTcw=;
 b=h3PnxosQJ4yeFgDr33QKoyMYwVN7Gj5Lf0tm7GHDcDMSHdD74C/amUVhGYNuqOhx2BAPSz
 2Fv8yVezUq24MK0mBZDZ6EhUdFMBrCeMMPQmCC90q3se94ByFt/e74fFxvf9T+KXGN+X/q
 TL7T0nZXIAf66/6q29kQK7UrEvNXnTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749220777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UlNnd+M6YLIb1JemhbGnVu/WRSPGEmnqN2idiNpcTcw=;
 b=8C3QdyZAaIHBO+FNyjBslqN4JSdNxqILgYrwT5Ea9FiKSDJPa2veDiZ51W+7feXh2QGYSY
 A+DxGbt1mTFARvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 941E71369F;
 Fri,  6 Jun 2025 14:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9OO9Iqn9QmiNGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jun 2025 14:39:37 +0000
Date: Fri, 6 Jun 2025 16:39:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250606143936.GC1312985@pevik>
References: <20250606110541.220472-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250606110541.220472-1-liwang@redhat.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AC4651F445
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] tst_atomic: drop legacy inline assembly
 and use __atomic or __sync builtins
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

SGkgTGksIEN5cmlsLAoKPiBSZWZhY3RvciB0c3RfYXRvbWljLmggdG8gcmVtb3ZlIGFsbCBsZWdh
Y3kgYXJjaGl0ZWN0dXJlLXNwZWNpZmljIGlubGluZQo+IGFzc2VtYmx5IGFuZCBmYWxsYmFjayBj
b2RlIHBhdGhzLiBUaGUgbmV3IGltcGxlbWVudGF0aW9uIHN1cHBvcnRzIG9ubHkKPiB0d28gd2Vs
bC1kZWZpbmVkIGludGVyZmFjZXM6IF9fYXRvbWljXyogYnVpbHQtaW5zIChHQ0Mg4omlIDQuNykg
YW5kIF9fc3luY18qCj4gYnVpbHQtaW5zIChHQ0Mg4omlIDQuMSkuCgo+IFRoaXMgc2ltcGxpZmlj
YXRpb24gaW1wcm92ZXMgbWFpbnRhaW5hYmlsaXR5LCBjbGFyaXR5LCBhbmQgcG9ydGFiaWxpdHkK
PiBhY3Jvc3MgcGxhdGZvcm1zLgoKPiBUaGUgbWVtb3J5IG9yZGVyIGlzIGV4cGxpY2l0bHkgc2V0
IHRvIF9fQVRPTUlDX1NFUV9DU1QgdG8gcHJlc2VydmUgc3RyaWN0Cj4gc2VxdWVudGlhbCBjb25z
aXN0ZW5jeSwgd2hpY2ggYWxpZ25zIHdpdGggdGhlIEMrKzExIG1lbW9yeSBtb2RlbC4KCj4gUmVm
ZXJlbmNlOiBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3MvZ2NjL18wMDVmXzAwNWZhdG9t
aWMtQnVpbHRpbnMuaHRtbAorMQoKVGhhbmtzIGZvciB0aGUgd29yayEKUmV2aWV3ZWQtYnk6IFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4KPiBTdWdnZXN0ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNl
LmN6PgoKPiArCj4gKy8qIFVzZSBfX2F0b21pYyBidWlsdC1pbnMgKEdDQyA+PSA0LjcpLCB3aXRo
IHNlcXVlbnRpYWwgY29uc2lzdGVuY3kuICovCgorMSBmb3IgZG9jdW1lbnRpbmcgdGhpcy4gSG9w
ZWZ1bGx5IHRoZXNlIGFyZSBvbGQgZW5vdWdoIHRvIG5vdCBoYXZpbmcgdG8gbWVudGlvbgppdCBp
biB0aGUgZG9jcy4gQnV0IGlmIHlvdSB0aGluayBpdCdzIG5vdCB0aGF0IG9sZCwgaXQgbWlnaHQg
YmUgd29ydGggbGF0ZXIgdG8KZG9jdW1lbnQgaXQgaW4gZG9jL3VzZXJzL3N1cHBvcnRlZF9zeXN0
ZW1zLnJzdC4KaHR0cHM6Ly9saW51eC10ZXN0LXByb2plY3QucmVhZHRoZWRvY3MuaW8vZW4vbGF0
ZXN0L3VzZXJzL3N1cHBvcnRlZF9zeXN0ZW1zLmh0bWwKCkluIHRoYXQgY2FzZSBtaW5pbWFsIGNs
YW5nIHZlcnNpb24gc2hvdWxkIGJlIG5vdGVkIGFzIHdlbGwuCgpCVFcgSSB0cmllZCB0byBzZWFy
Y2gsIHNob3VsZCBpdCBiZSBjbGFuZyAzLjU/CkkgdHJpZWQgdG8gc2VhcmNoIGJ1dCBub3QgZm91
bmQuCmh0dHBzOi8vY2xhbmcubGx2bS5vcmcvZG9jcy9MYW5ndWFnZUV4dGVuc2lvbnMuaHRtbCNj
MTEtYXRvbWljLWJ1aWx0aW5zCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gKyMgZXJyb3IgIllvdXIg
Y29tcGlsZXIgZG9lcyBub3Qgc3VwcG9ydCBhdG9taWMgb3BlcmF0aW9ucyAoX19hdG9taWMgb3Ig
X19zeW5jKSIKPiAgI2VuZGlmCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
