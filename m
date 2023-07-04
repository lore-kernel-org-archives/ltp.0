Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F10EB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:32:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 785B23C99BA
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 13:32:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AD993C8524
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 13:32:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A015A600780
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 13:32:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C319120528;
 Tue,  4 Jul 2023 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688470353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyPZkdC3yM+ePGFYoFL6A9ziXqq1tNWI3ii+lojCuWw=;
 b=HBJmKsN5z7e5sgVUojLv+lx5/5BGCWSUApEuAHjI2sfXEjiYzDyT89TOXG9w6R6vbnplLn
 VXDnvTyZzpcgukZKFjRSut3S2dec54pyk5wRVlOMP9BrRLsOMz1g6ricpZbrwnbKs11EAj
 F/I4aWKcyyZVL+aij2b6GLi/9e5zDRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688470353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyPZkdC3yM+ePGFYoFL6A9ziXqq1tNWI3ii+lojCuWw=;
 b=ECQ1l2F7A6QRQT1QaKTjesj4TSu9fOJOvciGrES7cPrRt2Yiq4D31VYStTwtHGQW3xqqUD
 qDLx8BqE+14yHuBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9520E133F7;
 Tue,  4 Jul 2023 11:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L79II1EDpGR/FAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 11:32:33 +0000
Date: Tue, 4 Jul 2023 13:32:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20230704113232.GA507064@pevik>
References: <20230703194904.445661-1-pvorel@suse.cz>
 <20230703200735.GB446620@pevik>
 <CAASaF6ykX_2mbA961CCqzh-McXO+_aqvoAqTUOtiZiuo8o78aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6ykX_2mbA961CCqzh-McXO+_aqvoAqTUOtiZiuo8o78aQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mremap06: Add mremap() reproducer for
 7e7757876f25
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

PiBPbiBNb24sIEp1bCAzLCAyMDIzIGF0IDEwOjA34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpLAoKPiA+IFsgZHJvcCBrZXJuZWwgZGV2ZWxvcGVycywgYWRk
IEphbiwgTGkgXQoKPiA+ID4gLS0tCj4gPiA+IEBDeXJpbDogSSBwbGFuIHRvIGFkZCBTQUZFX0ZB
TExPQ0FURSgpICgzIG90aGVyIHNvdXJjZXMpLAo+ID4gPiBTQUZFX01QUk9URUNUKCkgKDcgb3Ro
ZXIgc291cmNlcykgYW5kIFNBRkVfTVJFTUFQKCkKPiA+ID4gKDIgb3RoZXIgc291cmNlcyksIGJ1
dCBhcyBhIHNlcGFyYXRlIGVmZm9ydC4KCj4gPiBASmFuLCB5b3UgYWRkZWQgaW4gOTEyMGQ4YTIy
ICgic2FmZV9tYWNyb3M6IHR1cm4gZnVuY3Rpb25zIHdpdGggb2ZmX3QgcGFyYW1ldGVyCj4gPiBp
bnRvIHN0YXRpYyBpbmxpbmUiKSBub3RlICJmb2xsb3dpbmcgZnVuY3Rpb25zIGFyZSBpbmxpbmUg
YmVjYXVzZSB0aGUgYmVoYXZpb3VyCj4gPiBtYXkgZGVwZW5kIG9uIC1EX0ZJTEVfT0ZGU0VUX0JJ
VFM9NjQgLURPRkZfVD1fX29mZjY0X3QgY29tcGlsZSBmbGFncyIuIElNSE8gdGhlCj4gPiBvbmx5
IHNvdXJjZSB3aGljaCB1c2VzIFNBRkVfTU1BUCgpIGlzIHRlc3RjYXNlcy9rZXJuZWwvbWVtL21t
YXBzdHJlc3MvbW1hcHN0cmVzczAxLmMKCj4gc2VuZGZpbGUwNC5jIHBvdGVudGlhbGx5IHRvbywg
aXQncyBhbHNvIGNvbXBpbGVkIHdpdGggNjRiaXQgb2Zmc2V0cywKPiB0aG91Z2ggb2Zmc2V0IGlz
IGFsd2F5cyAwCgo+ID4gSSdtIGFza2luZyBiZWNhdXNlIEkgd29uZGVyIGlmIFNBRkVfTVBST1RF
Q1QoKSBhbmQgU0FGRV9NUkVNQVAoKSBzaG91bGQgYmUgYWxzbwo+ID4gc3RhdGljIGlubGluZSwg
SU1ITyBpdCdzIG5vdCBuZWVkZWQuCgo+IERvZXNuJ3QgYXBwZWFyIHRvIGJlIG5lZWRlZCBoZXJl
LgoKSGkgSmFuLAoKZ3JlYXQsIHRoYW5rcyBmb3IgaW5mby4KCktpbmQgcmVnYXJkcywKUGV0cgoK
Cj4gPiBAYWxsOiBTQUZFX01QUk9URUNUKCkgd291bGQgYmUgbmVlZGVkIGFsc28gb24gc29tZSBz
dGlsbCBvbGQgQVBJIHNvdXJjZXMKPiA+ICh0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NpZ25h
bC9zaWduYWwwNi5jLAo+ID4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tcHJvdGVjdC9tcHJv
dGVjdDAyLmMsCj4gPiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21wcm90ZWN0L21wcm90ZWN0
MDMuYykKPiA+IFNob3VsZCBJIGlnbm9yZSB0aGF0IGFuZCBhZGQgaXQganVzdCB0byBuZXcgQVBJ
PwoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiA+IEtpbmQgcmVnYXJkcywKPiA+ID4g
UGV0cgoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
