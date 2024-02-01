Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D75C47DDF
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 07:46:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9653F3CF8DC
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 08:46:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32F713CE127
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 08:46:36 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 02F9E10006A5
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 08:46:35 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78BD322168;
 Thu,  1 Feb 2024 07:46:34 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 58D8B13594;
 Thu,  1 Feb 2024 07:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id dXeiFFpMu2WrOwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 01 Feb 2024 07:46:34 +0000
Date: Thu, 1 Feb 2024 08:46:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240201074633.GA58275@pevik>
References: <20240131102514.2739270-1-liwang@redhat.com>
 <20240131102514.2739270-8-liwang@redhat.com>
 <20240131173840.GA18869@pevik> <20240131185310.GA30901@pevik>
 <20240131190122.GB30901@pevik>
 <CAEemH2fVdZdTnRUZSWCrZrqKYyuVWvu8nNQ4A=d3h7389KO3+g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fVdZdTnRUZSWCrZrqKYyuVWvu8nNQ4A=d3h7389KO3+g@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 78BD322168
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Patch v6 7/8] swapon/off: enable all_filesystem in swap
 test
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

PiBPbiBUaHUsIEZlYiAxLCAyMDI0IGF0IDM6MDHigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+ID4gSGkgTGksCgo+ID4gYWxzbyBJIGdvdCBmYWlsdXJlcyBvbiBwcGM2
NGxlIGluIG91ciBDSQoKPiA+ICogc3dhcG9mZjAxIDYuNy4yIGFuZCBvdGhlciB2ZXJzaW9ucyB1
cCB0byA0LjEyIGJhc2VkIGtlcm5lbHMgb24gcHBjNjRsZQo+ID4gLi4uCj4gPiB0c3Rfc3VwcG9y
dGVkX2ZzX3R5cGVzLmM6OTc6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgdG1wZnMKPiA+IHRzdF9z
dXBwb3J0ZWRfZnNfdHlwZXMuYzo0OTogVElORk86IG1rZnMgaXMgbm90IG5lZWRlZCBmb3IgdG1w
ZnMKPiA+IHRzdF90ZXN0LmM6MTcwMTogVElORk86ID09PSBUZXN0aW5nIG9uIGV4dDIgPT09Cj4g
PiB0c3RfdGVzdC5jOjExMTc6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDAgd2l0aCBleHQy
IG9wdHM9JycgZXh0cmEKPiA+IG9wdHM9JycKPiA+IG1rZTJmcyAxLjQ3LjAgKDUtRmViLTIwMjMp
Cj4gPiB0c3RfdGVzdC5jOjExMzE6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvIC90bXAv
TFRQX3N3YXp1MmZUbC9tbnRwb2ludAo+ID4gZnN0eXA9ZXh0MiBmbGFncz0wCj4gPiB0c3RfaW9j
dGwuYzoyNjogVElORk86IEZJQk1BUCBpb2N0bCBpcyBzdXBwb3J0ZWQKPiA+IGxpYnN3YXAuYzox
NDY6IFRCUk9LOiBGYWlsZWQgdG8gY3JlYXRlIHN3YXBmaWxlCgoKCj4gRXJyLCBJIHJlcHJvZHVj
ZSBpdCB3aXRoIGFuIFJIRUw5IHBwYzY0bGUgdG9vLgo+IEkgZ3Vlc3MgaXQgZG9lcyBub3QgYWxs
b3cgdG8gY3JlYXRlIGEgZmlsZSB0aGF0IHNpemUgbGVzcyB0aGFuIHBhZ2Vfc2l6ZS4KCj4gT25j
ZSBJIHJlcGxhY2UgdGhlIGJsa19zaXplIHdpdGggcGFnZV9zaXplLCBhbGwgdGVzdHMgZ2V0IHBh
c3NlZC4KCisxLCBncmVhdC4gRmVlbCBmcmVlIHRvIG1lcmdlIHRoZSByZXN0IHdpdGggbXkgYWNr
LgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
