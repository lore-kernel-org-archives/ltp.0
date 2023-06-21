Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2EBEB64D8
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 08:17:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2E423CC666
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 10:17:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 074B23C9212
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 10:17:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F2F1D1A00922
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 10:17:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFC6F1F8BA;
 Wed, 21 Jun 2023 08:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687335432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kdKAfCI7BAwIr6xRk7g/2dNUDoHlca9jmdMvNW6G6M=;
 b=ofqGDGurV3wRWXjybA3iHKdxwiV2h6cpMUaJycbrP89FGAA4lcgh4pbHU/+4a/P8BeIaIl
 /YfLOQU2UoS+nCX1qNf15zKmPMRkpkUqRz6uST62qItaiXYhb2Swv1uM9zvkhD2UnLLAwT
 QCUphYZhxDvfb9a0OBehzTLd0cOjR3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687335432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kdKAfCI7BAwIr6xRk7g/2dNUDoHlca9jmdMvNW6G6M=;
 b=o4ArFA4LftsicY48t1/lqWmlAIib3gclHR3hiOsGXLMySmv5+7cQISQyR2XOYjv+eAv78L
 GzX+IeCOVZpdiZCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C2DA133E6;
 Wed, 21 Jun 2023 08:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dKLSJAiykmQATwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jun 2023 08:17:12 +0000
Date: Wed, 21 Jun 2023 10:17:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Message-ID: <20230621081711.GA361973@pevik>
References: <1687280634-5906-1-git-send-email-kashwindayan@vmware.com>
 <20230620222603.GB340710@pevik>
 <01C96D39-2B2E-44EB-A5D7-41BF26D2C2AC@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01C96D39-2B2E-44EB-A5D7-41BF26D2C2AC@vmware.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sctp_big_chunk: Do not use md5 hmac algo if fips
 is enabled
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
Cc: Tapas Kundu <tkundu@vmware.com>, Ajay Kaher <akaher@vmware.com>,
 Vasavi Sirnapalli <vsirnapalli@vmware.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQXNod2luLAoKPiA+IE91dCBvZiBjdXJpb3NpdHksIHdoaWNoIGVycm5vIGlzIHJlcG9ydGVk
IG9uIGxpc3Rlbj8KCj4gPiBJbiBvdXIgY2FzZSBpbiBGSVBTIEVOT1NZUyBpcyByZXR1cm5lZCwg
dGh1cyBoYW5kbGVkIGFzIFRDT05GLgoKPiBJIGFtIHNlZWluZyB0aGUgRU5PU1lTICgzOCkgZXJy
b3IgYW5kIGl04oCZcyB0cnVlIHRoYXQgaXQgaXMgaGFuZGxlZCBhcyBUQ09ORi4gVGhlIGludGVu
dGlvbiBvZiB0aGUgcGF0Y2ggaXMgdG8gZml4IHRoZSBzYW1lLgoKVENPTkYgbWVhbnMgc2tpcHBl
ZCwgaS5lLiBPSy4gSSBzdXBwb3NlIHlvdXIgcGF0Y2ggYWxsb3dzIHRvIGRvIHRlc3RpbmcsIHdo
aWNoCmlzIGFuIGVuaGFuY2VtZW50LiBCdXQsIGF0IGxlYXN0IG9uIG9uZSBGSVBTIHN5c3RlbSBJ
IGdldCBmYWlsdXJlIGR1ZSBtaXNzaW5nCnByb2MgZmlsZToKCnRzdF9maXBzLmM6MjI6IFRJTkZP
OiBGSVBTOiBvbgpzY3RwX2JpZ19jaHVuay5jOjE1MzogVEJST0s6IEZhaWxlZCB0byBvcGVuIEZJ
TEUgJy9wcm9jL3N5cy9uZXQvc2N0cC9jb29raWVfaG1hY19hbGcnIGZvciByZWFkaW5nOiBFTk9F
TlQgKDIpCgpUaGUgc3lzdGVtIGhhcyBDT05GSUdfSVBfU0NUUD1tLCBJIGRvbid0IGtub3cgd2h5
IG1vZHVsZSBpcyBub3QgbG9hZGVkLgpNYXliZSBpdCdzIG5vdCBpbnN0YWxsZWQgb24gdGhlIHN5
c3RlbSAod291bGQgcmVxdWlyZSBwYWNrYWdlIHdpdGggZXh0cmEKbW9kdWxlcyksIGJ1dCBzdGls
bCB0aGlzIHdvdWxkIGJlIGEgcmVncmVzc2lvbiwgd2Ugc2hvdWxkIGNoZWNrIGZvciBwcmVzZW5j
ZSBvZgp0aGUgZmlsZS4KCk5PVEUgV2UgaGF2ZSAuc2F2ZV9yZXN0b3JlIFsxXSBoZWxwZXIsIGdl
bmVyYWxseSB3ZSdkIHVzZSBpdCB3aXRoClRTVF9TUl9UQ09ORl9NSVNTSU5HLCBidXQgaW4gdGhp
cyBjYXNlIEknZCB1c2UgYWNjZXNzKCkgdG8gY2hlY2ssCmJlY2F1c2Ugd2hvbGUgU0FGRV9GSUxF
X1NDQU5GKCkgc2hvdWxkIGJlIGFwcGxpZWQgb25seSB3aGVuIG5lZWRlZAooaW4gdHN0X2ZpcHNf
ZW5hYmxlZCgpKS4KCktpbmQgcmVnYXJkcywKUGV0cgoKWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9s
aW51eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvQy1UZXN0LUFQSSMxMjctc2F2aW5nLS1yZXN0b3Jp
bmctcHJvY3N5cy12YWx1ZXMKCj4gVGhhbmtzLAo+IEFzaHdpbiAKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
