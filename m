Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7C7C4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 16:17:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFABF3CDA3C
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 17:17:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D1DB3C0796
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 17:17:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 21C3860010D
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 17:17:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 614281F86C;
 Mon,  7 Nov 2022 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667837862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHt5Oh68AUiwJhhp+AybwkhVsj1EaS95dT2DZ9dYgyM=;
 b=HtvmZlV482H++bPob5traUlHTTNNCHpDD0iU2NbN/BNnUheB8SIQdygOrNa+bToshqcfIV
 EjW5bCw1p+58VskoaZ7/znfij865fVoj82V7XTV8apgkhlCJ8VLZT2Z+yk+gBWvOXUx6F5
 NprpRu2UEdPuzQrEjXfQeA0vjR4Uq6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667837862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHt5Oh68AUiwJhhp+AybwkhVsj1EaS95dT2DZ9dYgyM=;
 b=i9W+n4Xw0yYyRb7j0q/pdV/b1dBWi5VW5WwgAe6k14zOZNr/kIl7b8o1aGqjpGeeVJWgj3
 vDGoiwHrlfz11sAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 472CF13494;
 Mon,  7 Nov 2022 16:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wTPwD6YvaWOKUwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 07 Nov 2022 16:17:42 +0000
Message-ID: <ac17f564-1616-dc8a-75fc-6e75d49cc8c7@suse.cz>
Date: Mon, 7 Nov 2022 17:17:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Li Wang <liwang@redhat.com>
References: <20221103164550.7037-1-mdoucha@suse.cz>
 <CAEemH2di5wCY-M+EUGdovSRWU2zvminpuVpBBP_FiU3U8KDw0w@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2di5wCY-M+EUGdovSRWU2zvminpuVpBBP_FiU3U8KDw0w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Introduce new struct field for flags
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

T24gMDYuIDExLiAyMiA3OjI0LCBMaSBXYW5nIHdyb3RlOgo+IFRoaXMgaXMgYSBnb29kIHRob3Vn
aHQgdG8gc3BsaXQgdGhlIHBlcm1pc3Npb24gYW5kIHJlc3BlY3RpdmVseQo+IGhhbmRsZSB0aGVt
LCBidXQgSSBmZWVsIHRoYXQgdGhlc2UgbmFtZXMgYXJlwqBhIGJpdCBhbWJpZ3VvdXMuCj4gCj4g
Rm9yIGV4YW1wbGUgVFNUX1NSX0lHTk9SRV9STywgSSB3YXMgcHV6emxlZCBhIHdoaWxlIHdoZW4K
PiByZWFkaW5nIGl0IGluIHRoZSBiZWxvdyBjb2RlLCBpdCBjYW4gYmUgdGhvdWdodCBvZiBhcyBp
Z25vcmluZyB0aGUKPiBSRUFEX09OTFkgcGVybWlzc2lvbiBpZiBqdXN0IGZyb20gdGhlIGxpdGVy
YWwgbWVhbmluZy4KClRoZSBvbmx5IHNlbnNpYmxlIHdheSB0byBpZ25vcmUgcmVhZC1vbmx5IHBl
cm1pc3Npb25zIGlzIHRvIHNraXAgd3JpdGluZyAKaW50byB0aGUgZmlsZS4gRXNwZWNpYWxseSB3
aGVuIHRoZSB0ZXN0IGNhbiBydW4gd2l0aG91dCByb290IHByaXZpbGVnZXMuCgo+IFdlwqBuZWVk
IHRvIGZpbmQgbW9yZSBwcmVjaXNlIG5hbWVzLgo+IAo+ICAgICArCj4gICAgICsjZGVmaW5lIFRT
VF9TUl9SRVFVSVJFRCAoVFNUX1NSX0ZBSUxfTUlTU0lORyB8IFRTVF9TUl9GQUlMX1JPKQo+ICAg
ICArI2RlZmluZSBUU1RfU1JfSUZfQUNDRVNTIChUU1RfU1JfSUdOT1JFX01JU1NJTkcgfCBUU1Rf
U1JfSUdOT1JFX1JPKQo+IAo+IAo+IEhlcmUgYXMgd2VsbCwgZXNwZWNpYWxseSB0aGVzZSB0d28g
d2lsbCBiZSBtb3JlIGZyZXF1ZW50bHnCoHVzZWQgaW4gCj4gdGVzdGNhc2Ugd3JpdGluZy4KCkkg
YW0gb3BlbiB0byBzdWdnZXN0aW9ucy4KCj4gICAgICt2b2lkIHRzdF9zeXNfY29uZl9zYXZlX3N0
cihjb25zdCBjaGFyICpwYXRoLCBjb25zdCBjaGFyICp2YWx1ZSk7Cj4gCj4gCj4gRG8gd2UgaGF2
ZSBhbnkgb3RoZXIgcGxhY2UgdG8gdXNlIHRzdF9zeXNfY29uZl9zYXZlX3N0cj8KPiBJZiBubywg
SSB3b3VsZCBzdWdnZXN0IGRlY2xhcmluZyBpdCBvbmx5IGFzIGEgc3RhdGljIGZ1bmN0aW9uCj4g
aW4gdGhlIHRzdF9zeXNfY29uZi5jCgpJJ20gbm90IHN1cmUgc3VjaCBjaGFuZ2UgYmVsb25ncyBp
biB0aGlzIHBhdGNoIGJ1dCBmZWVsIGZyZWUgdG8gc3VibWl0IAphbm90aGVyIHBhdGNoIGZvciBp
dC4KCi0tIApNYXJ0aW4gRG91Y2hhICAgbWRvdWNoYUBzdXNlLmN6ClFBIEVuZ2luZWVyIGZvciBT
b2Z0d2FyZSBNYWludGVuYW5jZQpTVVNFIExJTlVYLCBzLnIuby4KQ09SU08gSUlhCktyaXppa292
YSAxNDgvMzQKMTg2IDAwIFByYWd1ZSA4CkN6ZWNoIFJlcHVibGljCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
