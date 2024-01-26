Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEE3C48260
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 10:39:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA0BF3CFAEB
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 11:39:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEA523CFABA
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:39:19 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43786600BD4
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:39:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 280EB21DD4;
 Fri, 26 Jan 2024 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706265558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUGUPRc1PvoPql4d5meb+gODJLZNYJT5HzJLBDSahtw=;
 b=eDgHPoZh5rokMW756rIFHzsJxnmO3XJgFE5cKyX4DJRV9Tr8x0C0bGF827T4rBVXx8VYhD
 00EpZHjbjziszlAzGfOLKCQ6pCdJjSL3DNrV8hPU/cgjiLgwfcpqArU6auMUN8mN98wcZE
 I7LTN7bXojCajZA7KNvPmvluVF5NeY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706265558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUGUPRc1PvoPql4d5meb+gODJLZNYJT5HzJLBDSahtw=;
 b=0GGM0uioTBqiDo+2giJrHKLaMr8SV6mHQJB97+n2jhzXUV3Lse70Hcwdh4IOxBCyUvh3+x
 AqjQv1CSWzDWfODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706265558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUGUPRc1PvoPql4d5meb+gODJLZNYJT5HzJLBDSahtw=;
 b=eDgHPoZh5rokMW756rIFHzsJxnmO3XJgFE5cKyX4DJRV9Tr8x0C0bGF827T4rBVXx8VYhD
 00EpZHjbjziszlAzGfOLKCQ6pCdJjSL3DNrV8hPU/cgjiLgwfcpqArU6auMUN8mN98wcZE
 I7LTN7bXojCajZA7KNvPmvluVF5NeY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706265558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUGUPRc1PvoPql4d5meb+gODJLZNYJT5HzJLBDSahtw=;
 b=0GGM0uioTBqiDo+2giJrHKLaMr8SV6mHQJB97+n2jhzXUV3Lse70Hcwdh4IOxBCyUvh3+x
 AqjQv1CSWzDWfODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1C2813A22;
 Fri, 26 Jan 2024 10:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4c2ZOdWLs2XTJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jan 2024 10:39:17 +0000
Date: Fri, 26 Jan 2024 11:39:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240126103916.GA467134@pevik>
References: <20240124044548.2652626-1-liwang@redhat.com>
 <20240124192251.GB333483@pevik>
 <CAEemH2furScb5PPAFEK+Vq0xyF21B6OekqT-infZDByKUnUe3Q@mail.gmail.com>
 <ZbOD_yAeaj0fRFgW@yuki>
 <CAEemH2evCmByMS7GrrXmO2SeQm71Lxn7qQSE1S6Mnj_HCjr_NA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2evCmByMS7GrrXmO2SeQm71Lxn7qQSE1S6Mnj_HCjr_NA@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.52 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.02)[52.01%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V4 0/6] improvement work on libswap library
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

PiBIaSBDeXJpbCwKCj4gT24gRnJpLCBKYW4gMjYsIDIwMjQgYXQgNjowNeKAr1BNIEN5cmlsIEhy
dWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKCj4gPiBIaSEKPiA+ID4gWWVzLCBJIGNhbiBk
byBhbGwgb2YgdGhhdCBhZnRlciByZWxlYXNlLgoKPiA+ID4gQEN5cmlsIEhydWJpcyA8Y2hydWJp
c0BzdXNlLmN6PiBDYW4gSSBtZXJnZSB0aGlzIHBhdGNoIHNldCBiZWZvcmUKPiA+IHJlbGVhc2Us
Cj4gPiA+IGl0J3MgYmVlbiBnZXR0aW5nIHRlc3RlZCBieSBQZXRyIGFuZCBtZSBhY3Jvc3MgZGlz
dHJpYnV0aW9ucy4KCj4gPiBJIHdpbGwgaGF2ZSBhIGxvb2ssIGhvd2V2ZXIgYXMgd2UgYXJlIGdl
dHRpbmcgY2xvc2UgdG8gdGhlIHJlbGVhc2UgZGF0ZQo+ID4gSSB3b3VsZCBzYXkgdGhhdCB0aGUg
c2FmZSBjaG9pY2UgaXMgdG8gYXZvaWQgYmlnZ2VyIGNoYW5nZXMuIEkgaGF2ZSBiYWQKPiA+IGV4
cGVyaWVuY2VzIHdpdGggYSBsYXN0IG1pbnV0ZSBjaGFuZ2VzIHRoYXQgY2F1c2VkIHVuZXhwZWN0
ZWQgZmFpbHVyZXMKPiA+IHRoYXQgd2VyZSBkZXRlY3RlZCB0b28gbGF0ZS4KCgo+IFVuZGVyc3Rh
bmQsIEkgaGF2ZSBjb25maWRlbmNlIGJlY2F1c2UgaXQgb25seSBpbXBhY3RzIG9uCj4gc3dhcG9u
MDEsc3dhcG9mZjAxIGFuZCBib3RoIGdldCB2ZXJpZmllZCBvbiB2YXJpb3VzIGRpc3Ryb3MuCgo+
IEJ1dCB5b3UncmUgcmlnaHQsIEkgY2FuIHdhaXQgdW50aWwgdGhlIG5ldyByZWxlYXNlLgoKYWNr
LiBCVFcgZG8gd2UgdGFnIG9uIE1vbmRheT8KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
