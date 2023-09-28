Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B507CE732FD
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 17:39:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5D0A3CF25D
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 19:39:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 447883CD44D
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 19:39:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E57141400BDA
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 19:39:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B34831F45A;
 Thu, 28 Sep 2023 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695922783;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZTvN8shKnfLBR+oCQvrNHu/5mlQFxM9TNGKBLYX5is=;
 b=vR0UC4iB8q0IOkyRK03EIRFFY6TTySUea2yx5A++KT42wPZZp8TFCUo0rDiPSUUlcBKKag
 GI5xURnN7yCBDNUtOr5LIq2y9mkjtfPA2bFFWiMWjo475bvBB9mdMuG4GkzCEf7lt/sZ9R
 M1+KdAEqb7RSaZk7hEQCSp41+ILWGdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695922783;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZTvN8shKnfLBR+oCQvrNHu/5mlQFxM9TNGKBLYX5is=;
 b=C7ZrIpUAa+mwIP+uLCrzkrddSUO1bPD1NG4rovgcWB6A+nd+GTIG51Y0WMywyGaKRMsGyV
 yxvMEpPaXYzw+xAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3675A138E9;
 Thu, 28 Sep 2023 17:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hvzyCV+6FWWAbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 28 Sep 2023 17:39:43 +0000
Date: Thu, 28 Sep 2023 19:39:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230928173941.GA307171@pevik>
References: <ZQF5J0UJ25_QLwcQ@yuki> <20230926105011.GA133737@pevik>
 <CAEemH2cb-asn5VSnpSCusS-Rb187T_mjOrBqH722_c3KaAF=LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cb-asn5VSnpSCusS-Rb187T_mjOrBqH722_c3KaAF=LQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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

SGkgTGksCgo+IEhpIFBldHIsCgo+IE9uIFR1ZSwgU2VwIDI2LCAyMDIzIGF0IDY6NTDigK9QTSBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgdGVzdGluZyBjb21tdW5p
dHksCgo+ID4gPiBIaSEKPiA+ID4gQXMgdXN1YWxsIHdlIGFyZSBzdXBwb3NlZCB0aGUgcmVsZWFz
ZSBMVFAgYXQgdGhlIGVuZCBvZiB0aGUgbW9udGguIEluCj4gPiA+IG9yZGVyIHRvIGdldCBhdCBs
ZWFzdCB0d28gd2Vla3Mgb2YgcHJlLXJlbGVhc2UgdGVzdGluZyBJIHdvdWxkIGxpa2UgdG8KPiA+
ID4gZnJlZXplIHRoZSBnaXQgc3RhcnRpbmcgbmV4dCB3ZWVrLiBJIHdpbGwgdHJ5IHRvIHJldmll
dyBhbmQgbWVyZ2UgYXMKPiA+ID4gbXVjaCBhcyBwb3NzaWJsZSB0aWxsIHRoZSBlbmQgb2YgdGhp
cyB3ZWVrLiBJZiB0aGVyZSBpcyBhbnl0aGluZyB0aGF0Cj4gPiA+IHlvdSB0aGluayBzaG91bGQg
Z28gaW50byB0aGUgcmVsZWFzZSBsZXQgbWUga25vdyBzbyB0aGF0IEkgY2FuIGhhdmUgYQo+ID4g
PiBsb29rLgoKPiA+IEZZSSB3ZSBwbGFuIHRvIHJlbGVhc2UgTFRQIHRoaXMgd2VlayBvbiBGcmlk
YXkuIEl0J3Mgbm90IG11Y2ggdGltZSBsZWZ0LAo+ID4gYnV0IGlmCj4gPiB5b3UgaGF2ZSB0aW1l
LCBwbGVhc2UgdHJ5IHRvIGRvIHNvbWUgTFRQIHByZS1yZWxlYXNlIHRlc3Rpbmcgb24geW91cgo+
ID4gZmF2b3VyaXRlCj4gPiBkaXN0cm8uCgoKPiBBQ0suCgo+IE15IHByZS1yZWxlYXNlIHRlc3Qg
cmVzdWx0IGxvb2tzIGdvb2Qgb24gb3VyIFJIRUw4LzkuIEp1c3Qgc29tZSBtaW5vcgo+IGVycm9y
L3RpbWVkb3V0IGlzc3VlIHdoaWNoIGhhdmUgYWxyZWFkeSBiZWVuIHRyYWNrZWQuCgpUaGFua3Mg
YSBsb3QgZm9yIHlvdXIgdGltZSB0byB0ZXN0IQoKPiAoVGhhbmtzIGZvciB5b3VyIHdvcmsgb24g
dGhlIHJlbGVhc2UsIEknbSBhbHJlYWR5IG9uIHZhY2F0aW9uIHRoaXMgd2VlaywKPiBzcGVjaWFs
bHkgY29tZSB0byByZXBseSB0byB5b3UgZm9yIGFkZGluZyBjb25maWRlbmNlIGluIHRoZSBuZXcg
cGFja2FnZTopLgoKQWgsIEkgYXBwcmVjaWF0ZSB0aGF0IGEgbG90LCB0aGFuayB5b3UhCgpLaW5k
IHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
