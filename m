Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051CEC433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 11:35:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F1DC3C9F40
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 12:35:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F23C3C24D6
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 12:35:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 994C1600684
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 12:35:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C59121128;
 Fri, 11 Feb 2022 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644579312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngwABIH0fGDB8ghsEiDgTqhOHpd1iClMVhrlFITwJss=;
 b=riSoVPHuLXSOxikUzI99FszcG0KXVURDc2AoPnO/OyVxD/5kEY3wrb4RaG9T3/3bn72Kvf
 GbtwlvI2dSNEMxyBzjZ8qtlcg4Mu92D0PXdg6U2FGN8IuX2VCqvbukN6ovSSR4nuHOdgak
 VYxW1aZwi3GcMsUpPFUp8yqMMgX4fnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644579312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngwABIH0fGDB8ghsEiDgTqhOHpd1iClMVhrlFITwJss=;
 b=auNABFJvjPJbVDb6lXg6JlFk9m8TatZpxcwMJSbYDsOS8i+HJMCHthrq2lj0v4ZFVbIQVa
 XQJd4qWV8np9elCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 710BB13C03;
 Fri, 11 Feb 2022 11:35:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +YgrGvBJBmLRUgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Feb 2022 11:35:12 +0000
Message-ID: <b71648c0-475a-2404-21a0-f2df8c221ead@suse.cz>
Date: Fri, 11 Feb 2022 12:35:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Li Wang <liwang@redhat.com>
References: <20220210161817.11555-1-mdoucha@suse.cz>
 <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
 <014f765e-ce73-e90b-40ac-875cef4842e4@suse.cz>
 <CAEemH2c6muy5xNGAqhTpVqYwbiVUTFg-gOkHg6JZE_DHLgtxyA@mail.gmail.com>
 <CAEemH2d1ECs=3s63UGu1tLuQu8Uy-e9GSfO1t-yCUi+ZGLKsdQ@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2d1ECs=3s63UGu1tLuQu8Uy-e9GSfO1t-yCUi+ZGLKsdQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Terminate leftover subprocesses when main test
 process crashes
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTEuIDAyLiAyMiAxMjowMSwgTGkgV2FuZyB3cm90ZToKPiBJIGdpdmUgNSBzZWNvbmRzIHNs
ZWVwIGJlZm9yZSBzZW5kaW5nIFNJR0tJTEwgaW4gbGliLXByb2Nlc3MKPiBhbmQgbW9kaWZpZWQg
dGhlIHRlc3RfY2hpbGRyZW5fY2xlYW51cC5jIHRvIHByaW50IHBwaWQgZWFjaCAxc2VjCj4gdG8g
dmVyaWZ5IHRoaXM6Cj4gCj4gIyAuL3Rlc3RfY2hpbGRyZW5fY2xlYW51cAo+IHRzdF90ZXN0LmM6
MTQ1MjogVElORk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMTBzCj4gdGVzdF9jaGlsZHJl
bl9jbGVhbnVwLmM6MjA6IFRJTkZPOiBNYWluIHByb2Nlc3MgMTczMjM2IHN0YXJ0aW5nCj4gdGVz
dF9jaGlsZHJlbl9jbGVhbnVwLmM6Mzk6IFRJTkZPOiBGb3JrZWQgY2hpbGQgMTczMjM4Cj4gdGVz
dF9jaGlsZHJlbl9jbGVhbnVwLmM6MzM6IFRJTkZPOiBwcGlkIGlzIDE3MzIzNgo+IHRlc3RfY2hp
bGRyZW5fY2xlYW51cC5jOjMzOiBUSU5GTzogcHBpZCBpcyAxCj4gdGVzdF9jaGlsZHJlbl9jbGVh
bnVwLmM6MzM6IFRJTkZPOiBwcGlkIGlzIDEKPiB0ZXN0X2NoaWxkcmVuX2NsZWFudXAuYzozMzog
VElORk86IHBwaWQgaXMgMQo+IHRlc3RfY2hpbGRyZW5fY2xlYW51cC5jOjMzOiBUSU5GTzogcHBp
ZCBpcyAxCj4gdHN0X3Rlc3QuYzoxNTAyOiBUSU5GTzogSWYgeW91IGFyZSBydW5uaW5nIG9uIHNs
b3cgbWFjaGluZSwgdHJ5Cj4gZXhwb3J0aW5nIExUUF9USU1FT1VUX01VTCA+IDEKPiB0c3RfdGVz
dC5jOjE1MDQ6IFRCUk9LOiBUZXN0IGtpbGxlZCEgKHRpbWVvdXQ/KQo+IAo+IFN1bW1hcnk6Cj4g
cGFzc2VkIMKgIDAKPiBmYWlsZWQgwqAgMAo+IGJyb2tlbiDCoCAxCj4gc2tpcHBlZCDCoDAKPiB3
YXJuaW5ncyAwCj4gPT09PT09PQoKSG1tLCB0aGF0J3Mgd2VpcmQsIHdoZW4gSSB0cmllZCB0aGF0
IGFwcHJvYWNoIHllc3RlcmRheSwgaXQga2VwdCBsZWF2aW5nCnRoZSBjaGlsZCBiZWhpbmQuIE5v
dyBpdCBzZWVtcyB0byBiZSB3b3JraW5nLiBJIGd1ZXNzIEkgbWVzc2VkIHVwCnNvbWVob3cgYW5k
IHRoZSB0ZXN0IHByb2dyYW0gZGlkbid0IGdldCByZWxpbmtlZCBhZ2FpbnN0IG5ldyBsaWJsdHAu
YS4uLgoKT0ssIHNlbmRpbmcgdjIgc29vbiBzaW5jZSBJIGFsc28gbmVlZCB0byBmaXggYSBidWcg
aW4gdGhlIGxpYnRlc3Qgc2hlbGwKc2NyaXB0LgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91Y2hh
QHN1c2UuY3oKUUEgRW5naW5lZXIgZm9yIFNvZnR3YXJlIE1haW50ZW5hbmNlClNVU0UgTElOVVgs
IHMuci5vLgpDT1JTTyBJSWEKS3Jpemlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3plY2gg
UmVwdWJsaWMKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
