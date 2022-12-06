Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B90DC352A1
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 14:04:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AD4F3CC185
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 15:04:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA19B3C88FA
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 15:04:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6681660011C
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 15:04:23 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1292521C4D;
 Tue,  6 Dec 2022 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670335463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ehj4H22IFuejZCZS4fYgjMT38OwVCUJG4JlwMBPa7jc=;
 b=JoNhrs6KeQeikwbGX0u9iiCjt7ETRfZn+fGoh8BWjhC9W1N7OW08Jc62l5NEmacDdrtUtw
 GzPojVwAp4Rq2/mnLkWROok3iseImEvXkY8qpkAtZ+bOuQ/M4d/QSz/CQy317C/a6zAL1S
 sYzAOPw9qsFC5z+DrrfGIw5aIto/gok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670335463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ehj4H22IFuejZCZS4fYgjMT38OwVCUJG4JlwMBPa7jc=;
 b=32PJIwFcJt52a95xpYDHPJskUzFuYdsKGIMktkboaeezTLpUzsNmJt0FYfAa2Onxc9sQy1
 l/FM5YeCOptSsUAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EED90132F3;
 Tue,  6 Dec 2022 14:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id D5FcOeZLj2OWFwAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Tue, 06 Dec 2022 14:04:22 +0000
Date: Tue, 6 Dec 2022 15:04:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <20221206140421.GB21839@pevik>
References: <20221206122604.212528-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221206122604.212528-1-teo.coupriediaz@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/brk: add direct syscall tst_variant
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

SGkgVGVvLAoKPiBEaXJlY3QgdXNhZ2Ugb2YgYnJrIGlzIGRpc2NvdXJhZ2VkIGluIGZhdm9yIG9m
IHVzaW5nIG1hbGxvYy4gQWxzbywgYnJrIHdhcwo+IHJlbW92ZWQgZnJvbSBQT1NJWCBpbiBQT1NJ
WC4xLTIwMDEuCj4gSW4gcGFydGljdWxhciwgdGhlIE11c2wgbGliYydzIGJyayBhbHdheXMgcmV0
dXJucyAtRU5PTUVNIHdoaWNoIGNhdXNlcwo+IHRoZSBMVFAgdGVzdHMgdG8gZXhpdCBwcmVtYXR1
cmVseS4gSW52b2tpbmcgdGhlIHN5c2NhbGwgZGlyZWN0bHkgYWxsb3dzCj4gdGhlbSB0byBwcm9w
ZXJseSB2YWxpZGF0ZSBicmsgYmVoYXZpb3IuIEFkZCBhIG5ldyB0ZXN0IHZhcmlhbnQgaGFuZGxp
bmcgaWYKPiB0aGUgbGliYyB3cmFwcGVycyBhcmUgbm90IGltcGxlbWVudGVkIGFuZCB0ZXN0aW5n
IHRoZSBkaXJlY3Qgc3lzY2FsbC4KCj4gVXNlIHRzdF9zeXNjYWxsKCkgYW5kIGhhbmRsZSB0aGUg
ZmFpbHVyZSBjYXNlcyBvdXJzZWx2ZXMsIGFzCj4gd2UgZG9uJ3QgZGVwZW5kIG9uIHRoZSBsaWJj
IHRvIGRvIGl0IGFueW1vcmUuCgo+IFRoZSBwYXRjaCBhbHNvIHdvcmtzIGFyb3VuZCB0aGUgZGVw
ZW5kZW5jeSBvbiBzYnJrIHRvIGdldCB0aGUgY3VycmVudCBicmVhawo+IGFzIGl0IGhhcyB0aGUg
c2FtZSBpc3N1ZXMuIEluc3RlYWQsIGNhbGwgdHN0X3N5c2NhbGwoX19OUl9icmssIDApIHdoaWNo
Cj4gYWx3YXlzIHJldHVybnMgdGhlIGN1cnJlbnQgYnJlYWsuCgo+IFVwZGF0ZSBicmswMSB0byB1
c2Ugdm9pZCogdG8gdW5pZnkgaXQgd2l0aCBicmswMi4KVGhhdCBicm91Z2h0IHdhcm5pbmdzLCBz
ZWUgYmVsb3cuCgouLi4KPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Jyay9icmsw
Mi5jCj4gQEAgLTE0LDI0ICsxNCw1MSBAQAo+ICAjaW5jbHVkZSA8dW5pc3RkLmg+Cj4gICNpbmNs
dWRlIDxzeXMvbW1hbi5oPgo+ICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiArI2luY2x1ZGUgImxh
cGkvc3lzY2FsbHMuaCIKPiArCj4gK2lubGluZSB2b2lkICpicmtfdmFyaWFudHModm9pZCAqYWRk
cikKPiArewo+ICsJdm9pZCAqYnJrX2FkZHI7Cj4gKwlpZiAodHN0X3ZhcmlhbnQpIHsKPiArCQli
cmtfYWRkciA9ICh2b2lkICopdHN0X3N5c2NhbGwoX19OUl9icmssIGFkZHIpOwo+ICsJfSBlbHNl
IHsKPiArCQlicmtfYWRkciA9ICh2b2lkICopYnJrKGFkZHIpOwoKTk9URSB1c2luZyBwb2ludGVy
IGZvciBicmsoKSBpcyBwcm9ibGVtYXRpYywgdGhlcmUgYXJlIGNvbXBsYWluczoKCmJyazAyLmM6
IEluIGZ1bmN0aW9uIOKAmGJya192YXJpYW50c+KAmToKYnJrMDIuYzoyNjoyODogd2FybmluZzog
Y2FzdCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZQpbLVdpbnQtdG8t
cG9pbnRlci1jYXN0XQogICAyNiB8ICAgICAgICAgICAgICAgICBicmtfYWRkciA9ICh2b2lkICop
YnJrKGFkZHIpOwogICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCk5vdCBz
dXJlIGhvdyB0byBmaXggdGhpcy4gUHJvYmxlbSBpcyBpbiBib3RoIEMgZmlsZXMsIG9uIHNldmVy
YWwgcGxhY2VzLgoKVGhlcmUgYXJlIGFsc28gY29kZSBzdHlsZSBwcm9ibGVtcyAoeW91IGNhbiBz
ZWUgaXQgd2hlbiBydW5uaW5nIG1ha2UgY2hlY2sgaW4KdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9icmsvKSwgYnV0IHRoYXQncyBhIG1pbm9yIGRldGFpbC4KCktpbmQgcmVnYXJkcywKUGV0cgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
