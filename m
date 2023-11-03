Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FCBC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 06:57:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 960043CC879
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 07:56:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2F673C0041
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 07:56:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0CD64600D84
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 07:56:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D721C219D7;
 Fri,  3 Nov 2023 06:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698994604;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrqE7WQLUoLjpcuuPtHVwF0341eLEfOP3WR7HZqopbA=;
 b=Xquxvd18i8MCshk1Pfo5Anr/yhbMXkHnxnHz/oVV/vE7jxAZ5Okq1a2hSkKbY66X+LMmAH
 YmM23+XHh7KesBNpf07htv+HBu6/h6FmLepyL4WG42p7PSrRTVcHQ6mIBN9dxlyj6DpflP
 sh2s0rBGzDVRaKMqKieso0V0hN4CJJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698994604;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrqE7WQLUoLjpcuuPtHVwF0341eLEfOP3WR7HZqopbA=;
 b=vw1a0Ctn/4Tacvt+CyNW6m9SvmX7le/y5fDGMPeByDAPA2R5UZd9ckhCSChdbFeL7lTM6g
 O1EuBwiUF2zm8ADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACB1313907;
 Fri,  3 Nov 2023 06:56:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JVLnKKyZRGW0LgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 06:56:44 +0000
Date: Fri, 3 Nov 2023 07:56:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20231103065642.GA998015@pevik>
References: <875y33vsks.fsf@suse.de> <87lebpu02a.fsf@suse.de>
 <87msvxst71.fsf@suse.de> <20231101101200.GB884786@pevik>
 <CAASaF6zhLkdhpsbJqEZVyKxg6bHwG_iNzpYPrGumzY8PO-5saw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6zhLkdhpsbJqEZVyKxg6bHwG_iNzpYPrGumzY8PO-5saw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 1st of November 09:00 UTC
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBXZWQsIE5vdiAxLCAyMDIzIGF0IDExOjEy4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIGFsbCwKCj4gPiA+IEhlbGxvLAoKPiA+ID4gVGhhbmtzIHRv
IGV2ZXJ5b25lIHdobyBhdHRlbmRlZCB0aGUgbWVldGluZy4gU29tZSBvdXRjb21lczoKPiA+IEFs
c28gdGhhbmtzIHRvIGFsbCBhdHRlbmRlcnMuCgo+ID4gPiAxLiBUaGVyZSB3ZXJlIGF1ZGlvIGFu
ZCBjb25uZWN0aW9uIGlzc3VlcyB3aXRoIEppdHNpLCB3ZSBzaG91bGQgdHJ5Cj4gPiA+ICAgIHNv
bWV0aGluZyBlbHNlIG5leHQgdGltZQoKPiA+IENvdWxkIGFueWJvZHkgdGVzdCBpZiBtZWV0IGZy
b20gZ29vZ2xlIHdvcmtzIGZvciBoaW0/Cj4gPiBodHRwczovL21lZXQuZ29vZ2xlLmNvbS91ZGMt
bmNycy13eHgKCj4gSSB0cmllZCwgaXQncyB3YWl0aW5nIGZvciBzb21lb25lIHRvIGxldCBtZSBp
bi4KPiBCdXQgSSBkb24ndCBleHBlY3QgaXNzdWVzIChhdCBsZWFzdCBmb3IgbWUvTGkpLCB3ZSBk
byB1c2UgaXQgaW50ZXJuYWxseS4KCkdyZWF0LCB0aGFuayB5b3UsIEphbi4KCktpbmQgcmVnYXJk
cywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
