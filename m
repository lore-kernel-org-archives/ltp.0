Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B6DC25B48
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 08:21:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 891523CAB0C
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 10:21:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E5503CAB0C
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:21:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BEB4D601569
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 10:21:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D80E621AA1;
 Thu, 26 Oct 2023 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698308481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B808psIPb9M2Nt1d+1lescebgPiiTGs1MOxBj/kDoFI=;
 b=XMOot8LMgCpSke1e7t74yb7TtEY05y8H7JDjKzIcQS6JEYIDkSswzIVFNFGi3HHbcAjYNk
 lf7GN6q3d2kgJiArS9QDfn284diTcSGjKmjeDzTxuMw2SgRQekm4WI7tPwDUxVVvVzHNFf
 aip60HmDIUB4HcPY8V+FtdhLx4V2bFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698308481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B808psIPb9M2Nt1d+1lescebgPiiTGs1MOxBj/kDoFI=;
 b=6xrTILYh07k8cvnA/2UwHsvgbMlzU12osH+7EX64l4CQ8g1PCVxwOps9Fo+RJG+RQ22L13
 laqDQCgshWWEusBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7365D1358F;
 Thu, 26 Oct 2023 08:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ncM1G4EhOmVCCAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 08:21:21 +0000
Date: Thu, 26 Oct 2023 10:21:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20231026082120.GA574267@pevik>
References: <20231025140109.340441-1-pvorel@suse.cz>
 <CAASaF6yVnrBK0UCxj4HRbi_scm84KS5Jm_xi8rUEuXcZXo=rZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6yVnrBK0UCxj4HRbi_scm84KS5Jm_xi8rUEuXcZXo=rZQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-9.48 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[14];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.18)[96.07%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Remove CentOS 7 support
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
Cc: Ulrich Hecht <uli@kernel.org>, Martin Doucha <martin.doucha@suse.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmFuLAoKPiBPbiBXZWQsIE9jdCAyNSwgMjAyMyBhdCA0OjAx4oCvUE0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIGFsbCwKCj4gPiB3ZSByZWNlbnRseSBoYWQg
eWV0IGFub3RoZXIgcmVncmVzc2lvbiBvbiBvbGQgQ2VudE9TIDcgKGtlcm5lbCAzLjEwLAo+ID4g
Z2xpYmMgMi4xNywgZ2NjIDQuOC41IFsxXS4gVGhhdCBicm91Z2h0IG1lIHRvIHRoZSBxdWVzdGlv
biBpZiB3ZSBzdGlsbAo+ID4gd2FudCB0byBzdXBwb3J0IGl0LgoKPiA+IEFsdGhvdWdoIHdlIHRl
c3QgaW4gU1VTRSBhbHNvIHZlcnkgb2xkIFNMRVMgcmVsZWFzZXMsIHRoZXNlIGFyZSB0ZXN0ZWQK
PiA+IHdpdGggb2xkZXIgTFRQIHJlbGVhc2VzLiBJIHN1cHBvc2UgUmVkIEhhdCBkb2VzIHRoZSBz
YW1lIHdpdGggUkhFTAo+ID4gKExpLCBKYW4sIHBsZWFzZSBjb3JyZWN0IG1lIGlmIG5vdCwgb3Ig
ZmVlbCBmcmVlIHRvIGludHJvZHVjZSBhbm90aGVyCj4gPiBDZW50T1MgdmVyc2lvbiwgYXMgdGhl
cmUgd2lsbCBub25lIHdpdGggdGhpcyBwYXRjaHNldCksIHRodXMgd2h5Cj4gPiBwcmV0ZW5kIGN1
cnJlbnQgTFRQIGlzIHVzZWZ1bCBvbiB0aGVzZSBvbGQgcmVsZWFzZXMuCgo+IExvb2tpbmcgYXQg
aW50ZXJuYWwgTFRQIHRlc3Qgd3JhcHBlciwgaXQncyB1c2luZyBvbGRlciBMVFAgcmVsZWFzZSBm
b3IgUkhFTDcsCj4gc28geW91ciBhc3N1bXB0aW9uIGFwcGVhcnMgdG8gYmUgY29ycmVjdC4KCgo+
ID4gSSB3b25kZXIgd2hvIGlzIGFjdHVhbGx5IGludGVyZXN0ZWQgaW4ga2VlcGluZyBMVFAgY29t
cGlsYWJsZSBmb3IgQ2VudE9TIDcuCj4gPiBBY2NvcmRpbmcgdG8gZGlzdHJvd2F0Y2ggaXQgRU9M
IGluIDIwMjQtMDYgWzJdLCBidXQgZG9lcyBhbnlib2R5IGV2ZW4gcnVuIG5ldwo+ID4gTFRQIG9u
IGl0LiBJZiB5ZXMsIHBsZWFzZSBzcGVhayB1cCwgYnV0IEknZCBleHBlY3QgdGhhdCBwZXJzb24g
dG8KPiA+IGFjdHVhbGx5IG1haW50YWluIENJIGZhaWx1cmVzLgoKPiBUaGVyZSdzIHBsYW5uZWQg
RUxTIHVudGlsIDIwMjYsIGJ1dCBJJ2QgZXhwZWN0IHRoYXQgY29udGludWVzIHVzaW5nCj4gb2xk
ZXIgTFRQIGZvciB0ZXN0cy4KClRoYW5rcyBhIGxvdCBmb3IgYSBjb25maXJtYXRpb24uCgpLaW5k
IHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
