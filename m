Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1E7E77354
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 06:23:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBB403CE0BC
	for <ltp@archiver.kernel.org>; Sat, 30 Sep 2023 08:23:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99C343C990C
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 08:22:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D6FC8601104
 for <ltp@lists.linux.it>; Sat, 30 Sep 2023 08:22:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE1B3211BC;
 Sat, 30 Sep 2023 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696054975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ouc0cjLOvGLlnJ+f/7F6K+xMQQneir99u9sPEDnwMZU=;
 b=Jnu4E5B9a/3kGGSWRj1HFLhR3Wq08APCKx24mOP6KTMe5abYl8wWFPc+AjidIb5NKQA+l9
 f/ZChsnZf+fIBrrmAu7tkytO0A1jTircENvkarLu7b17Ouohdl/Et16wVRmJ5vuzDyWmSv
 ZCPHkg7y7ezY2ItT5/EHR50Oe5darSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696054975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ouc0cjLOvGLlnJ+f/7F6K+xMQQneir99u9sPEDnwMZU=;
 b=/HyGenOolFl2pV22pNdIaq5QOAEdIfIDO1WtT8v+VUcB5d8JPcxEaOij1zZ0aaydmHhA+e
 FsfL1+lfJw+Z7dAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10D9713456;
 Sat, 30 Sep 2023 06:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vo9EKr6+F2XXEwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 30 Sep 2023 06:22:54 +0000
Date: Sat, 30 Sep 2023 08:22:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230930062240.GA414289@pevik>
References: <ZQF5J0UJ25_QLwcQ@yuki> <20230926105011.GA133737@pevik>
 <CAG4es9VBBkLe93sSyptHc4HF0O91G+1P47cfpkKH9OYsoYCvRg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9VBBkLe93sSyptHc4HF0O91G+1P47cfpkKH9OYsoYCvRg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgRWR3YXJkLAoKdGhhbmtzIGZvciB5b3VyIGZpeGVzLiBVbmZvcnR1bmF0ZWx5IEkgYWxyZWFk
eSByZWxlYXNlZCBMVFAgZWFybGllciBpbiBGcmlkYXkuCk5leHQgdGltZSB3ZSBub3RpZnkgdGhl
IGNvbW11bml0eSBlYXJsaWVyIGFuZCBzcGVjaWZ5IGFsc28gZXhwZWN0ZWQgaG91ciB3aGVuIHdl
IHJlbGVhc2UuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gSGkgUGV0ciwKCj4gU29ycnkgZm9yIHRo
ZSBsYXN0IG1pbnV0ZSByZXBseS4gIEp1c3Qgc2VudCB0d28gbWlub3IgcGF0Y2hlcyBmb3IgcGlw
ZTA3IGFuZAo+IGdldHBnaWQwMSB0aGF0IHdlcmUgZmFpbGluZyBvbiBBbmRyb2lkLiAgT3RoZXIg
dGhhbiB0aGF0IGl0IGxvb2tzIGdvb2Qgc28gZmFyLgoKPiBUaGFua3MgZm9yIGFsbCB5b3VyIGhh
cmQgd29yay4KCj4gQ2hlZXJzCj4gRWR3YXJkCgo+IE9uIFR1ZSwgU2VwIDI2LCAyMDIzIGF0IDM6
NTDigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgdGVzdGlu
ZyBjb21tdW5pdHksCgo+ID4gPiBIaSEKPiA+ID4gQXMgdXN1YWxsIHdlIGFyZSBzdXBwb3NlZCB0
aGUgcmVsZWFzZSBMVFAgYXQgdGhlIGVuZCBvZiB0aGUgbW9udGguIEluCj4gPiA+IG9yZGVyIHRv
IGdldCBhdCBsZWFzdCB0d28gd2Vla3Mgb2YgcHJlLXJlbGVhc2UgdGVzdGluZyBJIHdvdWxkIGxp
a2UgdG8KPiA+ID4gZnJlZXplIHRoZSBnaXQgc3RhcnRpbmcgbmV4dCB3ZWVrLiBJIHdpbGwgdHJ5
IHRvIHJldmlldyBhbmQgbWVyZ2UgYXMKPiA+ID4gbXVjaCBhcyBwb3NzaWJsZSB0aWxsIHRoZSBl
bmQgb2YgdGhpcyB3ZWVrLiBJZiB0aGVyZSBpcyBhbnl0aGluZyB0aGF0Cj4gPiA+IHlvdSB0aGlu
ayBzaG91bGQgZ28gaW50byB0aGUgcmVsZWFzZSBsZXQgbWUga25vdyBzbyB0aGF0IEkgY2FuIGhh
dmUgYQo+ID4gPiBsb29rLgoKPiA+IEZZSSB3ZSBwbGFuIHRvIHJlbGVhc2UgTFRQIHRoaXMgd2Vl
ayBvbiBGcmlkYXkuIEl0J3Mgbm90IG11Y2ggdGltZSBsZWZ0LCBidXQgaWYKPiA+IHlvdSBoYXZl
IHRpbWUsIHBsZWFzZSB0cnkgdG8gZG8gc29tZSBMVFAgcHJlLXJlbGVhc2UgdGVzdGluZyBvbiB5
b3VyIGZhdm91cml0ZQo+ID4gZGlzdHJvLgoKPiA+IFRoYW5rcyEKCj4gPiBLaW5kIHJlZ2FyZHMs
Cj4gPiBQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
