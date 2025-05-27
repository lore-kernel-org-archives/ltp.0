Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DD1C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 05:23:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D6BF3C4D02
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 07:23:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8759E3C2F9C
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:22:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5345B1400E6B
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:22:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F52821D93;
 Tue, 27 May 2025 05:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748323366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeezQvPfp2MOY8+D3nbC3YteSbDuJl0GaVBP9QZnYlE=;
 b=UEPgWPQ+Y05u/MJhBRXYurm3+f59VFwDD07fEyNUIuh7AZAdGWKNmDDbnw2mkspMgrXbWW
 /MGC1/4ckhvFxn/awVrzoxdWwa2NfGGEVbqJhh+L2NYo/ziLcl7oQdt1neSODe3mwwXU3+
 rzgVs3uDna0DaOIvNR1k1YjxTnpCK24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748323366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeezQvPfp2MOY8+D3nbC3YteSbDuJl0GaVBP9QZnYlE=;
 b=f8uiwst7FeEAV1z08DkvJBklwuXEvPFWO2vR44u1YOZLZC2Vyi5gzUcXeydQPmCKGsw8ct
 SuVASKQVmBj+YEAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748323366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeezQvPfp2MOY8+D3nbC3YteSbDuJl0GaVBP9QZnYlE=;
 b=UEPgWPQ+Y05u/MJhBRXYurm3+f59VFwDD07fEyNUIuh7AZAdGWKNmDDbnw2mkspMgrXbWW
 /MGC1/4ckhvFxn/awVrzoxdWwa2NfGGEVbqJhh+L2NYo/ziLcl7oQdt1neSODe3mwwXU3+
 rzgVs3uDna0DaOIvNR1k1YjxTnpCK24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748323366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeezQvPfp2MOY8+D3nbC3YteSbDuJl0GaVBP9QZnYlE=;
 b=f8uiwst7FeEAV1z08DkvJBklwuXEvPFWO2vR44u1YOZLZC2Vyi5gzUcXeydQPmCKGsw8ct
 SuVASKQVmBj+YEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9117413964;
 Tue, 27 May 2025 05:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XY00GiVMNWiZCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 May 2025 05:22:45 +0000
Date: Tue, 27 May 2025 07:22:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250527052242.GA157657@pevik>
References: <20250526150854.145995-1-pvorel@suse.cz>
 <CAEemH2efaYBWr-TrMKCT5Ba3_bQtrbFGTY2WW-qwiJtQ=929Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2efaYBWr-TrMKCT5Ba3_bQtrbFGTY2WW-qwiJtQ=929Wg@mail.gmail.com>
X-Spamd-Result: default: False [-0.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.com,suse.cz];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.com:email]; 
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v3 1/1] test_controllers: Skip test when
 cgroup v2 is loaded
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
Cc: Michal =?iso-8859-2?Q?Koutn=FD?= <mkoutny@suse.com>,
 Ricardo B =?utf-8?B?LiBNYXJsacOocmU=?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBQZXRyLCBBbGwsCgo+IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4g
Li4uCj4gPiBUZXN0ZWQtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4g
PiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBKaW4gR3VvamllIDxndW9qaWUuamluQGdtYWlsLmNvbT4KPiA+IFsgcHZvcmVsOiBzaW1w
bGlmeSwgcmViYXNlZCBdCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4KCj4gUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKPiA+IElz
IGl0IGV2ZW4gdXNlZnVsIG5vd2FkYXlzIHdoZW4gd2UgaGF2ZSB2YXJpb3VzIEMgYW5kIHNoZWxs
IGJhc2VkCj4gPiB0ZXN0cz8gU2hvdWxkbid0IHdlIGp1c3QgZGVsZXRlIHRoZSB0ZXN0PwoKPiBJ
IHRoaW5rIHdlIG5lZWQgdG8gZGlzc29sdmUgdGhlIHRlc3RfY29udHJvbGxlci5zaCBmaWxlIHN0
ZXBseSwgcGFydCBvZgo+IHRoZW0gY2FuIGJlIGRlbGV0ZWQgKGUuZy4gYmxvY2tpbyksIGJ1dCBv
dGhlcnMgbmVlZCB0byBiZSBjaGVja2VkCj4gaWYgaXQgaXMgdXNlZnVsLCB0aGVuIGdvZXM6Cgo+
ICAxLiBEZWxldGUgdGhlIG92ZXJsYXBwZWQgdGVzdCBjb250ZW50cy4KPiAgMi4gUmV3cml0ZSB0
aGUgcmVzdCB3aXRoIHRoZSBuZXcgQVBJIGFuZCBtb3ZlIGludG8gcnVudGVzdC9jb250cm9sbGVy
cy4KCj4gPiBJdCBldmVuIHVzZXMgImJsb2NraW8iLCBzaG91bGRuJ3QgaXQgYmUgImJsa2lvIj8K
Cj4gSXQncyBvdXRkYXRlZCwgd2UgY2FuJ3QgZXZlbiBmaW5kIHRoZSBydW5faW9fdGhyb3R0bGVf
dGVzdC5zaCBmaWxlLAo+IEJldHRlciB0byByZW1vdmUgdGhlbToKCj4gLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9jb250cm9sbGVycy90ZXN0X2NvbnRyb2xsZXJzLnNoCj4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9jb250cm9sbGVycy90ZXN0X2NvbnRyb2xsZXJzLnNoCj4gQEAgLTQ4LDggKzQ4LDYg
QEAgdGhlbgo+ICAgICAgICAgQ1BVX0NPTlRST0xMRVJfVkFMVUU9YGdyZXAgLXcgY3B1IC9wcm9j
L2Nncm91cHMgfCBjdXQgLWY0YDsKPiAgICAgICAgIE1FTV9DT05UUk9MTEVSPWBncmVwIC13IG1l
bW9yeSAvcHJvYy9jZ3JvdXBzIHwgY3V0IC1mMWA7Cj4gICAgICAgICBNRU1fQ09OVFJPTExFUl9W
QUxVRT1gZ3JlcCAtdyBtZW1vcnkgL3Byb2MvY2dyb3VwcyB8IGN1dCAtZjRgOwo+IC0gICAgICAg
SU9USFJPVFRMRV9DT05UUk9MTEVSPWBncmVwIC13IGJsb2NraW8gL3Byb2MvY2dyb3VwcyB8IGN1
dCAtZjFgOwo+IC0gICAgICAgSU9USFJPVFRMRV9DT05UUk9MTEVSX1ZBTFVFPWBncmVwIC13IGJs
b2NraW8gL3Byb2MvY2dyb3VwcyB8IGN1dCAtZjRgOwo+ICAgICAgICAgRlJFRVpFUj1gZ3JlcCAt
dyBmcmVlemVyIC9wcm9jL2Nncm91cHMgfCBjdXQgLWYxYDsKPiAgICAgICAgIEZSRUVaRVJfVkFM
VUU9YGdyZXAgLXcgZnJlZXplciAvcHJvYy9jZ3JvdXBzIHwgY3V0IC1mNGA7Cgo+IEBAIC04NSwx
NSArODMsNiBAQCB0aGVuCj4gICAgICAgICAgICAgICAgIGVjaG8gIlNraXBwaW5nIGFsbCBtZW1v
cnkgY29udHJvbGxlciB0ZXN0Y2FzZXMuLi4uIjsKPiAgICAgICAgIGZpCgo+IC0gICAgICAgaWYg
WyAiJElPVEhST1RUTEVfQ09OVFJPTExFUiIgPSAiYmxvY2tpbyIgXSAmJiBbCj4gIiRJT1RIUk9U
VExFX0NPTlRST0xMRVJfVkFMVUUiID0gIjEiIF0KPiAtICAgICAgIHRoZW4KPiAtICAgICAgICAg
ICAgICAgJExUUFJPT1QvdGVzdGNhc2VzL2Jpbi9ydW5faW9fdGhyb3R0bGVfdGVzdC5zaDsKPiAt
ICAgICAgIGVsc2UKPiAtICAgICAgICAgICAgICAgZWNobyAiQ09OVFJPTExFUlMgVEVTVENBU0VT
OiBXQVJOSU5HIjsKPiAtICAgICAgICAgICAgICAgZWNobyAiRWl0aGVyIEtlcm5lbCBkb2VzIG5v
dCBzdXBwb3J0IGZvciBpbyBjb250cm9sbGVyCj4gb3IgZnVuY3Rpb25hbGl0eSBpcyBub3QgZW5h
YmxlZCI7Cj4gLSAgICAgICAgICAgICAgIGVjaG8gIlNraXBwaW5nIGFsbCBibG9jayBkZXZpY2Ug
SS9PIHRocm90dGxpbmcgdGVzdGNhc2VzLi4uLiI7Cj4gLSAgICAgICBmaQo+IC0KPiAgICAgICAg
IGlmIFsgIiRGUkVFWkVSIiA9ICJmcmVlemVyIiBdICYmIFsgIiRGUkVFWkVSX1ZBTFVFIiA9ICIx
IiBdCj4gICAgICAgICB0aGVuCj4gICAgICAgICAgICAgICAgICIkTFRQUk9PVC90ZXN0Y2FzZXMv
YmluL3J1bl9mcmVlemVyLnNoIgoKKzEsIGZlZWwgZnJlZSB0byByZW1vdmUgYWZ0ZXJ3YXJkcyB3
aXRoIG15IFJCVCBhZnRlciBJIG1lcmdlLgpJJ2xsIG1lcmdlIG15IHBhdGNoIHRvZGF5LgoKS2lu
ZCByZWdhcmRzLApQZXRyCgo+ID4gR2l2ZW4gdGhlIHRlc3QgaXMgc3RpbGwgc29tZWhvdyB1c2Vm
dWwsIGknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIHdvcnRoIHRvCj4gPiByZXdyaXRlIHRvIGNncm91
cF9saWIuc2ggKG9yIGV2ZW4gdG8gdGhlIEMgQVBJKSwgYnV0IElNSE8gbm93IGJlZm9yZSB0aGUK
PiA+IHJlbGVhc2UgSSB3b3VsZCBqdXN0IHNraXAgaXQgb24gdjIuCgo+IFN1cmUsIHNraXBwaW5n
IGZyb20gVjIgaXMgc2FmZSBlbm91Z2ggYnkgbm93LgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
