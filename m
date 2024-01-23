Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB93EC47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 12:31:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 285B63CEE6B
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 13:31:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85F293CC752
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 13:31:24 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 106761000C2E
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 13:31:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E2102110B;
 Tue, 23 Jan 2024 12:31:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB9D413786;
 Tue, 23 Jan 2024 12:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i3x3NJqxr2XkPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 12:31:22 +0000
Date: Tue, 23 Jan 2024 13:31:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240123123121.GB175806@pevik>
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122091356.GF76754@pevik>
 <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
 <20240122110344.GB95077@pevik>
 <CAEemH2cNn1kyWrnqXHHeOteGT_FQ=PBVc55NFhkZbmkbMOoD=A@mail.gmail.com>
 <20240122202325.GA119341@pevik>
 <CAEemH2dTKjxuiMaHBh0Ky0VV+p2YmDQzH7nvZZjnOVop2E04jQ@mail.gmail.com>
 <CAEemH2cEY=kiJe91Y_kZNefjbh+L-3rikcxErSqVwhQN7mQ=fA@mail.gmail.com>
 <20240123074806.GA144741@pevik>
 <CAEemH2eDZ-Sn0mfH5_pKKLoMe=FXSPA2XRpbs5VmscSZrU4Eng@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eDZ-Sn0mfH5_pKKLoMe=FXSPA2XRpbs5VmscSZrU4Eng@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0E2102110B
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIEphbiAyMywgMjAyNCBhdCAzOjQ44oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLAoKPiA+ID4gVjMgaXMgaGVyZTogaHR0cHM6Ly9naXRo
dWIuY29tL3dhbmdsaTU2NjUvbHRwL2NvbW1pdHMvbGlic3dhcC12MwoKPiA+IEkndmUganVzdCBz
Y2hlZHVsZWQgbmV3IHJ1bnMgZm9yIGJvdGggVHVtYmxld2VlZCBhbmQgYWxsIFNMRVMgdmVyc2lv
bnMKPiA+ICh2YXJpb3VzIGtlcm5lbCB2ZXJzaW9ucykuCgoKPiBUaGFua3MgUGV0ciwgYW5kIHNv
cnJ5IGZvciBwb3N0aW5nIHRvIE1MIHNvIGxhdGVyLgo+IEkgZGlkIHNvbWUgcG9saXNoaW5nIHdv
cmsgYW5kIGZpeGVkIGEgZmV3IHRpbnkgaXNzdWVzIGJhc2VkIG9uIGFib3ZlIFYzLgoKPiBJJ20g
bm90IHN1cmUgaWYgdGhlIGxpYnN3YXAtdjMgYnJhbmNoIHdpbGwgdGVzdCB3ZWxsICh3aXRoIHRp
bnkgaXNzdWVzKS4KPiBTbyBJIHB1c2hlZCB0aGUgbGF0ZXN0IHRvIG15IG1haW4gYnJhbmNoOgo+
ICBodHRwczovL2dpdGh1Yi5jb20vd2FuZ2xpNTY2NS9sdHAKPiBBbmQsIEkgZGVwbG95ZWQgaXQg
d2l0aCBhIGdlbmVyYWwgdGVzdCAoYWdhaW5zdCBSSEVMKSBmb3IgdGhlIGNvbWluZwo+IHJlbGVh
c2Ugd29yay4KClRoYW5rcyBMaSEKQXMgSSB3cm90ZSB0byA0dGggcGF0Y2ggWzFdIHRoZXJlIHdp
bGwgYmUgdjQgbmVlZGVkLCBidXQgZml4IHNob3VsZCBiZSBlYXN5LgoKS2luZCByZWdhcmRzLApQ
ZXRyCgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjQwMTIzMTIxMTU2LkdBMTc1
ODA2QHBldmlrLwoKPiBXaWxsIHNoYXJlIG15IHRlc3QgcmVzdWx0IHdpdGggeW91IGFuZCBDcnlp
bCBsYXRlci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
