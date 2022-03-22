Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141EFC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 07:49:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA61B3C8707
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 08:49:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C3F93C01FD
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 08:49:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C09E600823
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 08:48:59 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6D7BF210F6;
 Tue, 22 Mar 2022 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647935338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNg2OfpBm5x7XvIX2JAB1IAvup0shtn9AkKQr1o06rI=;
 b=qo1LdJ9bqHfMpVNiFMKKkmSb3/CAs7pVsMgZUBG5AjaIgcrN6gTMQb1dxLU9w7j5eSfy31
 qFd8drimiiiWvYcyllZLn+2mVVwbjv74e/eSbwJQLif9MEf09T68dqMAhQW0w4ke1gAAdj
 A1MzSjvtBn+IpLbb2sqwArAFjQHGOVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647935338;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNg2OfpBm5x7XvIX2JAB1IAvup0shtn9AkKQr1o06rI=;
 b=EqGNUo6zi2P0X6012vku5IX/hoe9IgZ2bDplOvJ6mfly/jve4r2m00B8lZKU3IogpenBj+
 uTFz4XsS0A1ZNGDQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3228AA3B81;
 Tue, 22 Mar 2022 07:48:58 +0000 (UTC)
References: <20220321101429.3703-1-rpalethorpe@suse.com>
 <CAEemH2fYy_WRLEdHyfomsEwFbbrJPCJZdZQ5HPjo=kQCr7tjNw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 22 Mar 2022 07:48:36 +0000
In-reply-to: <CAEemH2fYy_WRLEdHyfomsEwFbbrJPCJZdZQ5HPjo=kQCr7tjNw@mail.gmail.com>
Message-ID: <87a6dictqz.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] memcontrol04: Copy from kselftest
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
Reply-To: rpalethorpe@suse.de
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgpMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JpdGVzOgoKPiBSaWNoYXJkIFBh
bGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1c2UuY29tPiB3cm90ZToKPgo+ICBBdCBmaXJzdCBnbGFu
Y2UgdGhpcyB0ZXN0IGxvb2tzIHRoZSBzYW1lIGFzIG1lbWNvbnRyb2wwMy4gSG93ZXZlcgo+ICB0
aGVyZSBhcmUgc29tZSBzaWduaWZpY2FudCBjaGFuZ2VzIHdoaWNoIGNvbXBsaWNhdGUgY29tYmlu
aW5nIHRoZSB0d28uCj4KPiAgQXQgbGVhc3QgdXAgdG8ga2VybmVsICg1LjE3KSB0aGVyZSBhcHBl
YXJzIHRvIGJlIGEgYnVnIGNhdXNpbmcgbG93Cj4gIG1lbW9yeSBldmVudHMgaW4gRi4gVGhlcmUg
aXMgcHJlc2VudGx5IG5vIHNvbHV0aW9uLCBzbyBhIGtub3duLWJ1ZyB0YWcKPiAgd2l0aCBhIGxp
bmsgdG8gTWljaGFsJ3MgaW52ZXN0aWdhdGlvbiBoYXMgYmVlbiBpbmNsdWRlZC4KPgo+ICBTaWdu
ZWQtb2ZmLWJ5OiBSaWNoYXJkIFBhbGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1c2UuY29tPgo+ICBD
YzogTWljaGFsIEtvdXRuw70gPG1rb3V0bnlAc3VzZS5jb20+Cj4gIENjOiBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4KPgo+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNv
bT4KClB1c2hlZCEgdGhhbmtzLgoKLS0gClRoYW5rIHlvdSwKUmljaGFyZC4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
