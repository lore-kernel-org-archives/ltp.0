Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D32DEB64D8
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 12:48:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F84F3CC44E
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 14:48:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B2BD3C9DB1
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:48:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C69D11400547
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:48:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1EDD21C97;
 Wed, 21 Jun 2023 12:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687351701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuqSozscDUNolRj1pF55ANCp9QNruyUOZQbbJGAP32c=;
 b=AvTPlim10r0GlNpoqp8Sk2DCKv7oMNYdNnAaktDzGCR2egpef6y/iqbGBc4UBHBOJ7cuYB
 5v03yZKZSnormJ1CqKoWiMTQ2i1UaKe88ddg/EX92CIh/j7FQMR7zF3dcpEe9RQ8mGEniz
 emA+pv4KLyfxY+9cE1O7c5bw8THvl/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687351701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuqSozscDUNolRj1pF55ANCp9QNruyUOZQbbJGAP32c=;
 b=nB2YOQpxVN2BYX3zLdRgNmXGS8vEbbFSr9ngnhyZKO+QdrA89/9WAgFH5TK1ZbFrYWj5/v
 56luyKMhU3eP30AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A3BE133E6;
 Wed, 21 Jun 2023 12:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7F1EIJXxkmR9VAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jun 2023 12:48:21 +0000
Date: Wed, 21 Jun 2023 14:48:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>,
 Tapas Kundu <tkundu@vmware.com>, Ajay Kaher <akaher@vmware.com>,
 Vasavi Sirnapalli <vsirnapalli@vmware.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <20230621124820.GA464557@pevik>
References: <1687280634-5906-1-git-send-email-kashwindayan@vmware.com>
 <20230620222603.GB340710@pevik>
 <01C96D39-2B2E-44EB-A5D7-41BF26D2C2AC@vmware.com>
 <20230621081711.GA361973@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230621081711.GA361973@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBBc2h3aW4sCgo+ID4gPiBPdXQgb2YgY3VyaW9zaXR5LCB3aGljaCBlcnJubyBpcyByZXBv
cnRlZCBvbiBsaXN0ZW4/Cgo+ID4gPiBJbiBvdXIgY2FzZSBpbiBGSVBTIEVOT1NZUyBpcyByZXR1
cm5lZCwgdGh1cyBoYW5kbGVkIGFzIFRDT05GLgoKPiA+IEkgYW0gc2VlaW5nIHRoZSBFTk9TWVMg
KDM4KSBlcnJvciBhbmQgaXTigJlzIHRydWUgdGhhdCBpdCBpcyBoYW5kbGVkIGFzIFRDT05GLiBU
aGUgaW50ZW50aW9uIG9mIHRoZSBwYXRjaCBpcyB0byBmaXggdGhlIHNhbWUuCgo+IFRDT05GIG1l
YW5zIHNraXBwZWQsIGkuZS4gT0suIEkgc3VwcG9zZSB5b3VyIHBhdGNoIGFsbG93cyB0byBkbyB0
ZXN0aW5nLCB3aGljaAo+IGlzIGFuIGVuaGFuY2VtZW50LiBCdXQsIGF0IGxlYXN0IG9uIG9uZSBG
SVBTIHN5c3RlbSBJIGdldCBmYWlsdXJlIGR1ZSBtaXNzaW5nCj4gcHJvYyBmaWxlOgoKPiB0c3Rf
Zmlwcy5jOjIyOiBUSU5GTzogRklQUzogb24KPiBzY3RwX2JpZ19jaHVuay5jOjE1MzogVEJST0s6
IEZhaWxlZCB0byBvcGVuIEZJTEUgJy9wcm9jL3N5cy9uZXQvc2N0cC9jb29raWVfaG1hY19hbGcn
IGZvciByZWFkaW5nOiBFTk9FTlQgKDIpCgpPSywgdGhpcyBwcm9ibGVtIGlzIG9uIGFsbCBzeXN0
ZW1zIHdoaWNoIGhhdmVuJ3QgdXNlZCBzY3RwIHNvIGZhci4gV2UgcmVhbGx5Cm5lZWQgdG8gc29t
ZWhvdyBtb2Rwcm9iZSBzY3RwIGJlZm9yZSByZWFkaW5nIC9wcm9jL3N5cy9uZXQvc2N0cC9jb29r
aWVfaG1hY19hbGcuCk1heWJlIHVzaW5nIC5uZWVkc19kcml2ZXJzPwoKS2luZCByZWdhcmRzLApQ
ZXRyCgo+IFRoZSBzeXN0ZW0gaGFzIENPTkZJR19JUF9TQ1RQPW0sIEkgZG9uJ3Qga25vdyB3aHkg
bW9kdWxlIGlzIG5vdCBsb2FkZWQuCj4gTWF5YmUgaXQncyBub3QgaW5zdGFsbGVkIG9uIHRoZSBz
eXN0ZW0gKHdvdWxkIHJlcXVpcmUgcGFja2FnZSB3aXRoIGV4dHJhCj4gbW9kdWxlcyksIGJ1dCBz
dGlsbCB0aGlzIHdvdWxkIGJlIGEgcmVncmVzc2lvbiwgd2Ugc2hvdWxkIGNoZWNrIGZvciBwcmVz
ZW5jZSBvZgo+IHRoZSBmaWxlLgoKPiBOT1RFIFdlIGhhdmUgLnNhdmVfcmVzdG9yZSBbMV0gaGVs
cGVyLCBnZW5lcmFsbHkgd2UnZCB1c2UgaXQgd2l0aAo+IFRTVF9TUl9UQ09ORl9NSVNTSU5HLCBi
dXQgaW4gdGhpcyBjYXNlIEknZCB1c2UgYWNjZXNzKCkgdG8gY2hlY2ssCj4gYmVjYXVzZSB3aG9s
ZSBTQUZFX0ZJTEVfU0NBTkYoKSBzaG91bGQgYmUgYXBwbGllZCBvbmx5IHdoZW4gbmVlZGVkCj4g
KGluIHRzdF9maXBzX2VuYWJsZWQoKSkuCgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCgo+IFsxXSBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC93aWtpL0MtVGVzdC1BUEkj
MTI3LXNhdmluZy0tcmVzdG9yaW5nLXByb2NzeXMtdmFsdWVzCgo+ID4gVGhhbmtzLAo+ID4gQXNo
d2luIAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
