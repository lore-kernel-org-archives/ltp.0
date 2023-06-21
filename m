Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A72EB64DD
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 12:41:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8ACA3CB8DB
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 14:41:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AF8C3C9DB1
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:41:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 37F2D60094E
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:41:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5946C21C95;
 Wed, 21 Jun 2023 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687351261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ye2OYYmizC/C09urGeUvZlVhCHGEtEX/TFACn5P8S8=;
 b=Q+55m39M7amdM+CWjDJHkeBxLV7MDRu/bTiB8V6ZclH8p86uI7WOP/VnzOroG6DJ9X3+YL
 ZOI+EIXFR9KUye316MEUWFI/R9/hX5Zk64IhAT/Ffg0UQskXiHAUk3ItXFTTVrSUxTv8X5
 aM6ChuDA3DNTCaYEzZ9/Epb0v5iqQLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687351261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ye2OYYmizC/C09urGeUvZlVhCHGEtEX/TFACn5P8S8=;
 b=6AmsQZRWrNdW1mrd53ubFmRT7gk5ach/OaCNiCg6mWJRd593YbKBD2E0xBh1IDkl3ZCPe1
 cxnouUNM8ModRtBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43B5F133E6;
 Wed, 21 Jun 2023 12:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2oZ5D93vkmTBUAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 21 Jun 2023 12:41:01 +0000
Message-ID: <e6dc2fff-99cc-33ff-548e-1828143d9d74@suse.cz>
Date: Wed, 21 Jun 2023 14:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Li Wang <liwang@redhat.com>
References: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
 <7ac34b5102d65e6bb7112234f6ad685e98d066f2.1687306661.git.souta.kawahara@miraclelinux.com>
 <1cca2a5f-64e0-2932-2971-8d7d91e01605@suse.cz>
 <CAEemH2dYgefTdWd2VgK5aur9qo8Z89C9CuK=pAT1O_dccOdw9w@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2dYgefTdWd2VgK5aur9qo8Z89C9CuK=pAT1O_dccOdw9w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] runtest/cve: Add some existing CVE tests
 to runtest file
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjEuIDA2LiAyMyAxMzo1MiwgTGkgV2FuZyB3cm90ZToKPiBUaGFua3MgZm9yIHRoZSBpbmZv
LiBJIGxvb2sgYSB3aGlsZSB3aHkgY2FuJ3QgYnVpbGQgdGhlbQo+IGFzIGZha2UgcHJvZ3JhbXMg
YW5kIG9ubHkgZXhpdCB3aXRoIFRDT05GIG9uIG5vbi14ODYsCj4gYnV0IHNlZW1zIGl0IGhhcyBz
b21lIHBsYXRmb3JtLWRlcGVuZGVudCBhc3NlbWJseSBsYW5ndWFnZQo+IGFuZCB0aGUgbGlua2Vy
IHJ1bGXCoHVuc3VwcG9ydCB0aGF0LgoKVGhlIEtWTSBNYWtlZmlsZSBpcyBjb21wbGljYXRlZCBi
ZWNhdXNlIHdlIGJ1aWxkIGEgcmF3IG1hY2hpbmUgY29kZSAKYmluYXJ5IHdoaWNoIHdpbGwgYmUg
ZXhlY3V0ZWQgaW4gdGhlIFZNIGFuZCB0aGVuIGxpbmsgaXQgaW5zaWRlIHRoZSB0ZXN0IApwcm9n
cmFtIGFzIGEgZGF0YSBibG9iLiBBZGRpbmcgZXh0cmEgY29uZGl0aW9ucyB0byBza2lwIHRoZSBi
bG9iIApjb21waWxhdGlvbiBhbmQgc2FmZWx5IFRDT05GIGluIHRoZSB0ZXN0IHByb2dyYW1zIHdv
dWxkIG1ha2UgZXZlcnl0aGluZyAKZXZlbiBtb3JlIGNvbXBsaWNhdGVkIHNvIGl0J3Mgbm90IHdv
cnRoIHRoZSBlZmZvcnQgYXQgdGhpcyBwb2ludCBiZWNhdXNlIAp0aGUgS1ZNIHRlc3QgY292ZXJh
Z2UgaXMgc3RpbGwgcXVpdGUgc21hbGwuCgotLSAKTWFydGluIERvdWNoYSAgIG1kb3VjaGFAc3Vz
ZS5jegpTVyBRdWFsaXR5IEVuZ2luZWVyClNVU0UgTElOVVgsIHMuci5vLgpDT1JTTyBJSWEKS3Jp
emlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3plY2ggUmVwdWJsaWMKCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
