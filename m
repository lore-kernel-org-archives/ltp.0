Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710FCC47422
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 09:08:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F1413CCCE5
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 10:08:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C6C13C8B4E
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 10:08:32 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E051200071
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 10:08:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EAA31FBEE;
 Wed, 17 Jan 2024 09:08:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13FEB13751;
 Wed, 17 Jan 2024 09:08:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5BpfAA6Zp2WOFAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 09:08:30 +0000
Date: Wed, 17 Jan 2024 10:08:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240117090828.GA2665992@pevik>
References: <20240116031728.2500892-1-liwang@redhat.com>
 <20240116121235.GA2582913@pevik>
 <CAEemH2dOHxT__TjWuDJY7Dq0p8-n7ZdRHD2nU7sw9aawUFqLfg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dOHxT__TjWuDJY7Dq0p8-n7ZdRHD2nU7sw9aawUFqLfg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5EAA31FBEE
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: fix compilation errors due to missing
 TCA_TCINDEX_ constants
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
Cc: Martin Doucha <martin.doucha@suse.com>, jhs@mojatatu.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIEphbiAxNiwgMjAyNCBhdCA4OjEy4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLCwKCj4gPiA+IFRoZSBjaGFuZ2UgYWRkcmVzc2VzIGNv
bXBpbGF0aW9uIGVycm9ycyBlbmNvdW50ZXJlZCBpbiB0aGUgdGNpbmRleDAxLmMKPiA+ID4gdGVz
dCB3aGVuIGNvbXBpbGVkIGFnYWluc3Qga2VybmVsLTYuNyBhbmQgYWJvdmUuCgo+ID4gImFnYWlu
c3Qga2VybmVsLTYuNyIuIEJ1dCA4MmIyNTQ1ZWQ5YSB3aWxsIGJlIHJlbGVhc2VkIGluIDYuOCwg
cmlnaHQ/CgoKPiBJdCdzIGFscmVhZHkgY29udGFpbmVkIGluIHRoZSBrZXJuZWwtNi43IHJlbGVh
c2UuCgpXZWxsLCBpdCdzIG5vdCB0aGF0IGltcG9ydGFudCAoYW5kIHdhcyBhbHJlYWR5IG1lcmdl
ZCBhbnl3YXkpLCBidXQganVzdCBmb3IKY2xhcml0eToKCm9uIHVwZGF0ZWQga2VybmVsIHRyZWUg
KHdpdGggZmV0Y2hlZCB0YWdzKToKJCBnaXQgdGFnIC0tY29udGFpbnMgODJiMjU0NWVkOWEKbmV4
dC0yMDI0MDEwNApuZXh0LTIwMjQwMTA1Cm5leHQtMjAyNDAxMDkKbmV4dC0yMDI0MDExMApuZXh0
LTIwMjQwMTEyCgpBbHNvLCBMVFAgdHJlZSB3aXRob3V0IHRoaXMgcGF0Y2ggY29tcGlsZXMgb24g
VHVtYmxld2VlZCB3aXRoIDYuNyBrZXJuZWwKaGVhZGVycy4KCmdpdGsgc2hvd3M6CiQgZ2l0ayAt
MSA4MmIyNTQ1ZWQ5YQpGb2xsb3dzOiB2Ni43LXJjNgpQcmVjZWRlczogbmV4dC0yMDI0MDEwNCwg
bmV4dC0yMDI0MDEwNSwgbmV4dC0yMDI0MDEwOSwgbmV4dC0yMDI0MDExMCwgbmV4dC0yMDI0MDEx
Mgo9PiBJTUhPIG5ldGRldiBtZXJnZSB3aW5kb3cgc3RhcnRlZCBhdCB2Ni43LXJjNiwgYnV0IGl0
J3Mgd2luZG93IGZvciB2Ni44LXJjMS4KCj4gUGF0Y2ggbWVyZ2VkLCB0aGFua3MhCgpUaGFua3Mg
Zm9yIHNwb3R0aW5nIHRoaXMgZWFybHkgZW5vdWdoIQoKS2luZCByZWdhcmRzLApQZXRyCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
