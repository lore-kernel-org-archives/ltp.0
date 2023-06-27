Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B10EB64D9
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 13:50:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CDF23CD0BF
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 15:50:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00C123CCA97
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 15:50:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E160F600205
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 15:50:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A545B1F459;
 Tue, 27 Jun 2023 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687873806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2pklLmRkXSb/3Xcf2w4DNzQZ8DQcV4JcrWsAkhObRE=;
 b=mJxe2FLcieR+gXWZfsfDlF1YzFot4Pytl4WDuDm6X26Z3M/620AtrQu1LHeH8eBYsmhquW
 AwR11qbvQY+/7nJfHJrZE+r4OlxdzCTsNvGSQ8gWqwM6RJf44KwgUMEj1eNBaJNqTpG/gQ
 LpVe0/BbHeVwEOMavo+0f4TRP3ot0cM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687873806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2pklLmRkXSb/3Xcf2w4DNzQZ8DQcV4JcrWsAkhObRE=;
 b=o/gg/dZ8RvsfPM7W4Va3rri2x0CxUSrFAe+rrrOSPfueH/N1gC1V8l6zUPZlVRaZsOntle
 ynopOQceIztLe4Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68F9913276;
 Tue, 27 Jun 2023 13:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NTMZGA7pmmRcdwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jun 2023 13:50:06 +0000
Date: Tue, 27 Jun 2023 15:50:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230627135004.GA58180@pevik>
References: <20230615093933.3185297-1-dylan@andestech.com>
 <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
 <ZJlZD2fVXaVM3X5i@yuki>
 <CAEemH2d=Mf=WsSXFGwUPeL3dqSOR2kf-eJr+C8HFTMMhAEynKg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d=Mf=WsSXFGwUPeL3dqSOR2kf-eJr+C8HFTMMhAEynKg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc
 variant
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
Cc: minachou@andestech.com, tim609@andestech.com, ltp@lists.linux.it,
 x5710999x@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiBPbiBNb24sIEp1biAyNiwgMjAyMyBhdCA1OjIy4oCvUE0gQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIQo+ID4gPiBZb3UgcG9pbnRlZCB0aGUg
c2VnbWVudCBmYXVsdCBvbmx5IGV4aXN0cyBvbiAzMmJpdCB3aGVuIHVzZQo+ID4gPiBsaWJjIHdy
YXBwZXIsIGJ1dCB0aGlzIGNvbmRpdGlvbiBza2lwcyBmb3IgYm90aCA2NGFuZDMyIGJpdHMsCj4g
PiA+IGlzbid0IGl0PwoKPiA+ID4gSSBndWVzcyB0aGUgc3RyaWN0IGNvbmRpdGlvbiBzaG91bGQg
YmUgYXMgYmVsb3c/Cgo+ID4gPiAgICAgaWYgKHRjYXNlc1tpXS5lcnJvciA9PSBFRkFVTFQgJiYg
dHYtPnNobWN0bCA9PSBsaWJjX3NobWN0bCAmJgo+ID4gPiB0c3Rfa2VybmVsX2JpdHMoKSA9PSAz
Mikgewo+ID4gPiAgICAgLi4uCj4gPiA+ICAgICB9Cgo+ID4gQWN0dWFsbHkgSSB0aGluayB0aGF0
IGl0IG1heSBiZSBzYWZlciB0byBza2lwIGxpYmMgdmVyc2lvbiByZWdhcmRsZXNzLAo+ID4gYXMg
bG9uZyBhcyB3ZSBoYXZlIHRoZSByYXcgc3lzY2FsbCB0ZXN0IGluIHBsYWNlIHdlIGFyZSBub3Qg
Z2V0dGluZyBhbnkKPiA+IG1vcmUgY292ZXJhZ2UgZnJvbSBwYXNzaW5nIGludmFsaWQgYWRkcmVz
cyB0byB0aGUgbGliYyBjYWxsLCBzaW5jZQo+ID4gZWl0aGVyIHRoZSBsaWJjIGNhbGwgaXMgdGhp
biB3cmFwcGVyLCBpLmUuIGVxdWl2YWxlbnQgdG8gdGhlIHN5c2NhbGwoKQo+ID4gY2FsbCB3aGlj
aCB3ZSBhbHJlYWR5IHRlc3QsIG9yIGl0IGRvZXMgc29tZXRoaW5nIHRvIHRoZSBhcmd1bWVudHMs
IGluCj4gPiB3aGljaCBjYXNlIGl0J3MgcG9zc2libGUgdG8gdHJpZ2dlciBzZWdmYXVsdCwgaWYg
bm90IG5vdyBpbiBzb21lIGZ1dHVyZQo+ID4gbGliYyB2ZXJzaW9ucy4KCkdvb2QgdG8ga25vdy4g
QmVjYXVzZSBhdCBsZWFzdCBvZiBzb21lIG9mIHRoZSB0ZXN0cyBtb2RpZmllZCBieSBWaW5heSBL
dW1hcgood2hpY2ggRHlsYW4gaXMgcmVmZXJyaW5nKSBhcmVuJ3QgYWJsZSB0byBydW4gb24gMzJi
aXQgbGliYyBpZiB3ZSBza2lwIHdpdGgKJiYgdHN0X2tlcm5lbF9iaXRzKCkgPT0gMzIsIGUuZy4K
Ci4vbXNnY3RsMDQKdHN0X3Rlc3QuYzoxNTU4OiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBo
IDAwbSAzMHMKbXNnY3RsMDQuYzoxMDM6IFRJTkZPOiBUZXN0aW5nIHZhcmlhbnQ6IGxpYmMgbXNn
Y3RsKCkKbXNnY3RsMDQuYzo3OTogVFBBU1M6IG1zZ2N0bCgzMjgxNiwgMiwgMHg1NjVlNDcwMCkg
OiBFQUNDRVMgKDEzKQp0c3Rfa2VybmVsLmM6ODc6IFRJTkZPOiB1bmFtZS5tYWNoaW5lPXg4Nl82
NCBrZXJuZWwgaXMgNjRiaXQKdHN0X3Rlc3QuYzoxNjE4OiBUQlJPSzogVGVzdCBraWxsZWQgYnkg
U0lHU0VHViEKCj4gT2theSwgc291bmRzIHJlYXNvbmFibGUuIEkgYWdyZWUgd2l0aCB0aGlzLgoK
QlRXIEkgYWxzbyBnZXQgRU5PTUVNIG9uIG15IGxhcHRvcCAoY3VycmVudGx5IDFHIGZyZWUgc3Bh
Y2UpOgpodWdlc2htY3RsMDIuYzoxMTk6IFRCUk9LOiBzaG1nZXQgIzE6IEVOT01FTSAoMTIpCgpT
aG91bGQgd2UgaGFuZGxlIGl0IHNvbWVob3c/CgpLaW5kIHJlZ2FyZHMsClBldHIKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
