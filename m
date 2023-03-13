Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E327C6FD19
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 10:20:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 159033CAFBC
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 11:20:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E73A73CADA6
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 11:20:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9DA5E6006D0
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 11:19:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5811422A3D;
 Mon, 13 Mar 2023 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678702798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgSNCWcxZdjhGPYEF4LvMqKBO/QcWL9Yw0P3aBUwOWk=;
 b=a8CwYA5RVNlGEiYfhKTClwuGdX4F6M089dtNIMo6bBZ6vpsxoGrTAn7e5q0AwjhNCpTmoi
 UdLHkD0XXYqLfZj9UIn1eZ5QjXvptvXDrQRr7s8aUK0tgomYrz02bl8caxOdRgPpA67HHp
 OcdVvxciMEbQfrjjZiSYExE7A1ySUxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678702798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgSNCWcxZdjhGPYEF4LvMqKBO/QcWL9Yw0P3aBUwOWk=;
 b=FXNLYBQWXFuQy4bpmaJA5rK+ooQLq/fLdQvYF7JUlSjyBUArQIrJOoINgYdJprhkFi+YBH
 f1cBz73UzXwGr+CQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B8ED12C141;
 Mon, 13 Mar 2023 10:19:57 +0000 (UTC)
References: <CAEemH2esqAP+kfEgwXkSkw6V7ubFn+uq2_QdF_Nx1gF2t-WXzA@mail.gmail.com>
 <20230302074123.567654-1-liwang@redhat.com> <20230303083822.GB4255@pevik>
 <CAEemH2ffqNxiOMyGx1m+7RmAcj2OHk2vdCyA2ZVDEnU0PGOytw@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 13 Mar 2023 10:15:30 +0000
Organization: Linux Private Site
In-reply-to: <CAEemH2ffqNxiOMyGx1m+7RmAcj2OHk2vdCyA2ZVDEnU0PGOytw@mail.gmail.com>
Message-ID: <8735696jhv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCh v2] madvise06: stop throwing failure when
 MADV_WILLNEED is ignored
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
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>, Paul Bunyan <pbunyan@redhat.com>,
 Eirik Fuller <efuller@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JpdGVzOgoKPiBIaSwKPgo+IE9u
IEZyaSwgTWFyIDMsIDIwMjMgYXQgMzo0NOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
PiB3cm90ZToKPgo+PiBIaSBMaSwKPj4KPj4gTEdUTS4KPj4gQWNrZWQtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6Pgo+Pgo+Cj4gVGhhbmsgeW91IGZvciB5b3VyIGFjaywgUGV0ci4KPgo+
IEkgc3RpbGwgd2FudCBSaWNoYXJkIGdpdmVzIG1lIGEgZmluYWwgY2hlY2suCj4KPiBAUmljaGFy
ZCwgZG8geW91IGFncmVlIHdpdGggcHVzaGluZyBpdCwgb3Igb3RoZXIgdGhvdWdodHM/CgpJIHRo
aW5rIGl0IG5lZWRzIGF0IGxlYXN0IG9uZSB1bmNvbmRpdGlvbmFsIHRzdF9yZXMoVFBBU1MsIC4u
LikKb3RoZXJ3aXNlIHRoZSBsaWJyYXJ5IHdpbGwgcmVwb3J0IFRCUk9LIGlmIHRoZXJlIGlzIG5v
IHBhc3Mgb3IgZmFpbApyZXN1bHQuCgpQb3NzaWJseSBqdXN0IHRzdF9yZXMoVFBBU1MsICJOb3Ro
aW5nIGJhZCBoYXBwZW5kIHByb2JhYmx5IikgYXQgdGhlIGVuZApvciBjaGVjayBmb3Iga2VybmVs
IHRhaW50cy4KCldpdGggdGhhdDoKUmV2aWV3ZWQtYnk6IFJpY2hhcmQgUGFsZXRob3JwZSA8cnBh
bGV0aG9ycGVAc3VzZS5jb20+CgpTb3JyeSBmb3Igc2xvdyByZXNwb25zZS4KCi0tIApUaGFuayB5
b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
