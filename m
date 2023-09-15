Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EE8EE6421
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 06:52:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2F0B3CE683
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 08:52:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D81E3CB160
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 08:51:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 691C4600A01
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 08:51:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 306E21F74B;
 Fri, 15 Sep 2023 06:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694760707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6d7Aexwx4MHakC44s5oI4XvpxKE+4R880qYFT7U8+nI=;
 b=D1lpx8QyS9VGuHz5xk0VhOY9UZMuOo5FH3p1OD5+Sp2rOIr1oLdaAaYZ3THLxVYSWsgukB
 HWAPZNEFliln2m1jAXFi4tPGpEGqXrpVeOeY3/U/ueg6xQOzBv+7DbZPMv7JqpHFQvI/7Y
 /dWjT9mOXaFVWSmGoIzGOXupuwK5yUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694760707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6d7Aexwx4MHakC44s5oI4XvpxKE+4R880qYFT7U8+nI=;
 b=ozzcvfkaT9lBnYhsOLHRUj2cfw8gw5RxnQ3l5upFxlRYHgxNAVG+q0ZoNlSxWNjkeWwxlw
 4kpupUh5zQrGKvBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3D491358A;
 Fri, 15 Sep 2023 06:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aeITMgL/A2WcCQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 06:51:46 +0000
Date: Fri, 15 Sep 2023 08:51:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230915065145.GA15133@pevik>
References: <20230903111558.2603332-1-amir73il@gmail.com>
 <20230903111558.2603332-2-amir73il@gmail.com>
 <87il8dghw0.fsf@suse.de>
 <CAOQ4uxhM8F6iyp5AVLquaq=NoR_V_6Y6NUjBDjqfjgcPvA5-Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhM8F6iyp5AVLquaq=NoR_V_6Y6NUjBDjqfjgcPvA5-Dw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] fanotify13: Test watching overlayfs upper fs
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW1pciwgUmljaGllLAoKPiBPbiBUaHUsIFNlcCAxNCwgMjAyMyBhdCAxOjM34oCvUE0gUmlj
aGFyZCBQYWxldGhvcnBlIDxycGFsZXRob3JwZUBzdXNlLmRlPiB3cm90ZToKCj4gPiBIZWxsbyBB
bWlyLAoKPiA+IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyaXRlczoKCj4g
PiA+IFJ1biBhIHRlc3QgdmFyaWFudCB3aXRoIG92ZXJsYXlmcyAob3ZlciBhbGwgc3VwcG9ydGVk
IGZzKQo+ID4gPiB3aGVuIHdhdGNoaW5nIHRoZSB1cHBlciBmcy4KCj4gPiA+IFRoaXMgaXMgYSBy
ZWdyZXNzaW9uIHRlc3QgZm9yIGtlcm5lbCBmaXggYmMyNDczYzkwZmNhCj4gPiA+ICgib3ZsOiBl
bmFibGUgZnNub3RpZnkgZXZlbnRzIG9uIHVuZGVybHlpbmcgcmVhbCBmaWxlcyIpLAo+ID4gPiBm
cm9tIGtlcm5lbCA2LjUsIHdoaWNoIGlzIG5vdCBsaWtlbHkgdG8gYmUgYmFja3BvcnRlZCB0byBv
bGRlciBrZXJuZWxzLgoKPiA+ID4gVG8gYXZvaWQgd2FpdGluZyBmb3IgZXZlbnRzIHRoYXQgd29u
J3QgYXJyaXZlIHdoZW4gdGVzdGluZyBvbGQga2VybmVscywKPiA+ID4gcmVxdWlyZSB0aGF0IGtl
cm5lbCBzdXBwb3J0cyBlbmNvZGluZyBmaWQgd2l0aCBuZXcgZmxhZyBBVF9IQUROTEVfRklELAo+
ID4gPiBhbHNvIG1lcmdlZCB0byA2LjUgYW5kIG5vdCBsaWtlbHkgdG8gYmUgYmFja3BvcnRlZCB0
byBvbGRlciBrZXJuZWxzLgoKPiA+IFVuZm9ydHVuYXRlbHkgUGV0cidzIG5vdCBoZXJlIGF0IHRo
ZSBtb21lbnQuCgo+ID4gSSBndWVzcyB0aGlzIGZpcnN0IHBhdGNoIGRvZXNuJ3QgcmVxdWlyZSA2
LjY/IFNvIGl0IGNvdWxkIGJlIG1lcmdlZAo+ID4gaW5kZXBlbmRlbnRseSB3aXRob3V0IGZ1cnRo
ZXIgY29uc2lkZXJhdGlvbnMgZm9yIHdoYXQgbWFrZXMgaXQgaW50byA2LjY/CgoKPiBZZXMgdGhh
dCBpcyBjb3JyZWN0LgoKSSdtIGZpbmFsbHkgYmFjayA6KS4KClJldmlld2VkLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KCkknbGwgYXNrIEN5cmlsIHRoaXMgcGF0Y2ggdG8gYmUgbWVy
Z2VkIGJlZm9yZSBMVFAgcmVsZWFzZSAoZmluYWwgZGF5IHRvZGF5CmJlZm9yZSBnaXQgZnJlZXpl
KS4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBUaGFua3MsCj4gQW1pci4KCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
