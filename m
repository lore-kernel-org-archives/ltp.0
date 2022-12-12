Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0116BC4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 09:09:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C9963CBE38
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 10:09:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8726B3CB6DC
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 10:09:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C2B576005D7
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 10:09:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB1861FE80;
 Mon, 12 Dec 2022 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670836142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJ2KblaUvcNl6OdwMhBL/QCWNgXvHzx/pGPQS1N93wQ=;
 b=UqZy9DlHfRw9YPXWKN5htl61C8L1LNIJ416Q8+ERU0WB/RStTw5+/p70gzjjrw4oiqhAuy
 tgxzLpMsEgJm7N9MsbV3LjNcP2T5W7IKm3kxZYhcuBH6THZZH7Dpq7wrS7TWMAVxlBiiw7
 BXhdCGT7mcUWkxqQkvknFi15Se/ROlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670836142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJ2KblaUvcNl6OdwMhBL/QCWNgXvHzx/pGPQS1N93wQ=;
 b=ZqpFMhcxOzkSK4fQ8IK3LwWCgzik/l4qOXRm9tdgt9ptaMxHQpwRx88r7wn3m11vNwA391
 CdsAnI8jDrhFv+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA64113456;
 Mon, 12 Dec 2022 09:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N/yvNK7vlmOVIAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 12 Dec 2022 09:09:02 +0000
Date: Mon, 12 Dec 2022 10:10:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Xinkuan Yan <lucky33newman@gmail.com>
Message-ID: <Y5bv+X+BnyhKJLWy@yuki>
References: <CAFQkDyZABHU38_LTvsv1eP8PvK4rHprfZrL45CYqMvav1-O8_A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFQkDyZABHU38_LTvsv1eP8PvK4rHprfZrL45CYqMvav1-O8_A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Question about log format.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gSSdtIHRyeWluZyB0byBkbyBhIGNvbmNpc2UgcGFyc2luZyBvZiB0aGUgTFRQIHJlcG9y
dC4KPiAKPiBJIGRvbid0IGhhdmUgbXVjaCBleHBlcmllbmNlIGFuZCBJJ20gbm90IGZhbWlsaWFy
IHdpdGggTFRQLCBzbyBJJ20gZ29pbmcgdG8KPiB0YWtlICNtYXRoIGFzIGFuIGV4YW1wbGUsIGZv
ciBpdCBpcyBub3QgY29tcGxleC4KPgo+IFJ1biB0ZXN0IGNvbW1hbmQ6Cj4gCj4gLi9sdHAg4oCT
ZiBtYXRoIOKAk3EKPiAKPiBJIGhhdmUgdGhyZWUgcXVlc3Rpb25zIG5vdywgIHRha2luZyB0aGUg
b25lLWxpbmUgb3V0cHV0IHJlc3VsdCBiZWxvdyBhcyBhbgo+IGV4YW1wbGU6Cj4gCj4gZmxvYXRf
aXBlcmIgMSBUUEFTUzogVGVzdCBwYXNzZWQKPiAKPiAxLCBJdCBpcyBjbGVhciB0aGF0IFRQQVNT
IG1lYW5zIGl0IHBhc3NlZCwgYnV0IHdoYXQgaXMgdGhlIG51bWJlciAxCj4gc3RhbmRpbmcgZm9y
Lgo+IAo+IDIsIFdoeSB0aGlzIGxpbmUgc2hvd2VkIHVwIHR3aWNlPyAoIFBTOiBCZXR3ZWVuIHRo
ZXNlIHR3byBsaW5lcyBhcmUgbWFueQo+IFRJTkZPLikKClRoZSBtYXRoIHRlc3RzIGFyZSBwcmlt
ZSBleGFtcGxlIGhvdyBub3QgdG8gd3JpdGUgdGVzdHMuIFBsZWFzZSBkbyBub3QKdGFrZSB0aGVt
IGFzIGFuIGV4YW1wbGUgb2YgYW55dGhpbmcgZWxzZS4gVXN1YWxseSB0aGUgbW9zdCBjbGVhbiBh
bmQgdXAKdG8gZGF0ZSB0ZXN0cyBhcmUgaW4gc3lzY2FsbHMvIGRpcmVjdG9yeS4KCj4gMywgV2hl
cmUgdG8gY2hlY2sgdGhvc2Ugb3V0IHB1dCBzdGFuZGFyZHMsIHRha2luZyB5b2N0byBwYWNrYWdl
IHRlc3QgYXMgYQo+IHNtYWxsIGNvbXByZWhlbnNpb24sIHRoYXQgc3RhbmRhcmQgd2FzICggUEFT
U3xGQUlMfFNLSVApOiBUZXN0IGluZm8uIEhvdyBpcwo+IGl0IGxpa2UgaW4gTFRQPwoKR2VuZXJh
bGx5IHRlc3RzIGluIExUUCBjYW4gaGF2ZSBtb3JlIHRoYW4gb25lIHJlc3VsdCBzbyB5b3UgY2Fu
J3QgcmVhbGx5Cm1hcCBhIHRlc3QgcmVzdWx0IHRvIGEgc2luZ2xlIHZhbHVlLiBJdCdzIGNvbW1v
biBmb3IgYSB0ZXN0IHRvIHJlcG9ydApzZXZlcmFsIFRQQVNTIGFuZCBvbmUgb3IgdHdvIFRDT05G
IGZvciBleGFtcGxlLiBUaGF0IG1lYW5zIHRoYXQgbW9zdCBvZgp0aGUgdGVzdCB3YXMgZXhlY3V0
ZWQgYnV0IHNtYWxsIHBhcnQgd2FzIHNraXBwZWQuCgpUaGUgVElORk8gbWVzc2FnZXMgYXJlIGFk
ZGl0aW9uYWwgaW5mb3JtYXRpb24gdGhhdCBtYXkgYmUgdXNlZnVsIHdoZW4KdGVzdCBmYWlsLCBu
b3RoaW5nIG1vcmUuCgpUaGUgb3ZlcmFsbCByZXN1bHQgaXMgcmVwb3J0ZWQgaW4gdGhlIHRlc3Qg
ZXhpdCB2YWx1ZSBhcyBiaXRmbGFncywgd2hpY2gKaXMgd2hhdCBpcyB1c2VkIGJ5IHRoZSBydW5s
dHAgc2NyaXB0IHRvIHByb2R1Y2UgdGhlIHJlc3VsdCBmaWxlcy4KCkFuZCBieSB0aGUgd2F5LCB3
ZSBhcmUgd29ya2luZyBvbiByZXBsYWNlbWVudCBmb3IgdGhlIHJ1bmx0cCBzY3JpcHQKd2hpY2gg
aXMgY2FsbGVkIHJ1bmx0cC1uZywgbWF5YmUgeW91IHNob3VsZCBoYXZlIGEgbG9vayBhdCB0aGF0
IGJlZm9yZQp5b3UgdHJ5IHRvIHdyaXRlIHlvdXIgb3duIHNvbHV0aW9uLgoKLS0gCkN5cmlsIEhy
dWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
