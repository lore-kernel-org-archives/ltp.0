Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936D5C3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:55:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C87AD3D0ECD
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 15:55:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 909CE3C0FBE
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 15:55:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 62A221000D18
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 15:55:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD78E21A58;
 Thu, 11 Jul 2024 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720706109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBQsQEHGoz8DHiBQ9FDhQkcrtOJCib9DOFTihIWuVUg=;
 b=uQXzofrvu0irluB3uQuMgllTgYyclFr6Fql4smwII0P7bt9v1cdlcKcvmCpQE0NzlmPNsT
 4udmNt0z36RoGkibYPAZd1HgDTj07QeIyOJmKnDHg+hbcyHmSHiwy6nlgGh7SGNSpL+QMq
 91yrNNZkPYBmabrsVzaWNqb4ULAPmJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720706109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBQsQEHGoz8DHiBQ9FDhQkcrtOJCib9DOFTihIWuVUg=;
 b=Jl0eiumjCjaN9ywfzlpDi2Udpg6Oi8txSgK7v2KA0e0XCoPLqLBef1EZLaUb/I/8FF5Bcu
 T5XHQ343LvqDd5BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720706108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBQsQEHGoz8DHiBQ9FDhQkcrtOJCib9DOFTihIWuVUg=;
 b=gKgmfoaI5xomgPuDnPh31crtTBtoIXW7hGq7okPRigthlOI9UU+VfgasSBrkG9oZM3WBM9
 o7mBfClmXL1qLowA92TYD4h3itF9Vp2sZTlPzQ0YLTdBZ3Vsi1aVBhhLxAUK+0n+UaOmvY
 gyoz9TEHACjdgiRsyRRJxsu3UEG0s1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720706108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBQsQEHGoz8DHiBQ9FDhQkcrtOJCib9DOFTihIWuVUg=;
 b=T0jEtMkPqex6CSGkiDhVlLxO2eDBe+OqdRZ04OP6nx10pM5rj1AHzAsBZ3IX6ZG2a3LQxe
 /r4xHbPxbJ36c3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B71F8139E0;
 Thu, 11 Jul 2024 13:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id omgoLDzkj2YJBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jul 2024 13:55:08 +0000
Date: Thu, 11 Jul 2024 15:55:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Message-ID: <20240711135507.GA84439@pevik>
References: <IA1PR10MB724059C5A7A69CE2A4AF257698DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <CAEemH2fLGJY6D+GAgmFcoCk5jSw7-K5VkoDb1CEqTbwqfKw+Wg@mail.gmail.com>
 <IA1PR10MB7240E961E4C697B7379EB66E98DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <20240709224650.GB214763@pevik>
 <IA1PR10MB724000DDC9B27E375CADCFBA98A52@IA1PR10MB7240.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <IA1PR10MB724000DDC9B27E375CADCFBA98A52@IA1PR10MB7240.namprd10.prod.outlook.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; REDIRECTOR_URL(0.00)[urldefense.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,oracle.com:email,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Request for Modification of test cases
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBQZXRyLAoKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxMCwgMjAy
NCA0OjE3IEFNCj4gPiBUbzogR3VsYW0gTW9oYW1lZCA8Z3VsYW0ubW9oYW1lZEBvcmFjbGUuY29t
Pgo+ID4gQ2M6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPjsgbHRwQGxpc3RzLmxpbnV4Lml0
OyBDeXJpbCBIcnViaXMKPiA+IDxjaHJ1YmlzQHN1c2UuY3o+OyBHdWxhbSBNb2hhbWVkIDxndWxh
bS5tb2hhbWVkQG9yYWNsZS5jb20+OyBKZW5zCj4gPiBBeGJvZSA8YXhib2VAa2VybmVsLmRrPjsg
bGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnCj4gPiBTdWJqZWN0OiBSZTogW0xUUF0gUmVxdWVz
dCBmb3IgTW9kaWZpY2F0aW9uIG9mIHRlc3QgY2FzZXMKCj4gPiBIaSBHdWxhbSwgYWxsLAoKPiA+
IFsgQ2MgbGludXgtYmxvY2sgYW5kIGF1dGhvciBhbmQgY29tbWl0dGVyIG9mIHRoZSBjaGFuZ2Ug
aW4ga2VybmVsIF0KCj4gPiA+IEhpIExpIFdhbmcsCgo+ID4gPiBGcm9tOiBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4KPiA+ID4gU2VudDogU2F0dXJkYXksIEp1bHkgNiwgMjAyNCA5OjEzIEFN
Cj4gPiA+IFRvOiBHdWxhbSBNb2hhbWVkIDxndWxhbS5tb2hhbWVkQG9yYWNsZS5jb20+Cj4gPiA+
IENjOiBsdHBAbGlzdHMubGludXguaXQKPiA+ID4gU3ViamVjdDogUmU6IFtMVFBdIFJlcXVlc3Qg
Zm9yIE1vZGlmaWNhdGlvbiBvZiB0ZXN0IGNhc2VzCgo+ID4gPiBIaSBHdWxhbSwKCj4gPiA+IE9u
IFNhdCwgSnVsIDYsIDIwMjQgYXQgMzo0OOKAr0FNIEd1bGFtIE1vaGFtZWQgdmlhIGx0cAo+ID4g
PGx0cEBsaXN0cy5saW51eC5pdDxtYWlsdG86bHRwQGxpc3RzLmxpbnV4Lml0Pj4gd3JvdGU6Cj4g
PiA+IEhpIFRlYW0sCgo+ID4gPiAgICAgVGhpcyBpcyByZWdhcmRpbmcgdGhlIGNoYW5nZSBpbiBr
ZXJuZWwgYmVoYXZpb3IgYWJvdXQgdGhlIHdheSB0aGUgbG9vcAo+ID4gZGV2aWNlIGlzIGRldGFj
aGVkLgoKPiA+ID4gICAgICAgICAgICAgICBDdXJyZW50IGJlaGF2aW9yCj4gPiA+ICAgICAgICAg
ICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gICAgICAgICAgICAgICBXaGVuIHRo
ZSBMT09QX0NMUl9GRCBpb2N0bCBjb21tYW5kIGlzIHNlbnQgdG8gZGV0YWNoIHRoZSBsb29wCj4g
PiBkZXZpY2UsIHRoZSBlYXJsaWVyIGJlaGF2aW9yIHdhcyB0aGF0IHRoZSBsb29wICAgICBkZXZp
Y2UgdXNlZCB0byBiZSBkZXRhY2hlZCBhdAo+ID4gdGhhdCBpbnN0YW5jZSBpdHNlbGYgaWYgdGhl
cmUgd2FzIGEgc2luZ2xlIG9wZW5lciBvbmx5LiBJZgo+ID4gPiAgICAgICAgICAgICAgICB0aGVy
ZSB3ZXJlIG11bHRpcGxlIG9wZW5lcnMgb2YgdGhlIGxvb3AgZGV2aWNlLCB0aGUgYmVoYXZpb3Ig
d2FzIHRvCj4gPiBkZWZlciB0aGUgZGV0YWNoIG9wZXJhdGlvbiBhdCB0aGUgbGFzdCBjbG9zZSBv
ZiB0aGUgZGV2aWNlLgoKPiA+ID4gICAgICAgICAgICAgICBOZXcgYmVoYXZpb3IKPiA+ID4gICAg
ICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gICAgICAgICAgICAgICBBcyBwZXIg
dGhlIG5ldyBiZWhhdmlvciwgaXJyZXNwZWN0aXZlIG9mIHdoZXRoZXIgdGhlcmUgYXJlIGFueQo+
ID4gb3BlbmVycyBvZiB0aGUgbG9vcCBkZXZpY2Ugb3Igbm90LCB0aGUgZGV0YWNoIG9wZXJhdGlv
biBpcyBkZWZlcnJlZCB0byB0aGUgbGFzdAo+ID4gY2xvc2Ugb2YgdGhlIGRldmljZS4gVGhpcyB3
YXMgZG9uZSB0byBhZGRyZXNzIGFuIGlzc3VlLCBkdWUKPiA+ID4gICAgICAgICAgICAgICB0byBy
YWNlIGNvZGl0aW9ucywgcmVjZW50bHkgd2UgaGFkIGluIGtlcm5lbC4KCj4gPiA+ICAgICAgICAg
ICAgICAgV2l0aCB0aGUgbmV3IGtlcm5lbCBiZWhhdmlvciBpbiBwbGFjZSwgc29tZSBvZiB0aGUg
TFRQIHRlc3QgY2FzZXMgaW4KPiA+ICJ0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsLyIg
YXJlIGZhaWxpbmcgYXMgdGhlIGRldmljZSBpcyBjbG9zZWQgYXQgdGhlIGVuZAo+ID4gb2YgdGhl
IHRlc3QgYW5kIHRoZSB0ZXN0IGNhc2VzIGFyZSBleHBlY3RpbmcgZm9yIHRoZQo+ID4gPiAgICAg
ICAgICAgICAgICByZXN1bHRzIHdoaWNoIGNhbiBvY2N1ciBhZnRlciB0aGUgZGV2aWNlIGlzIGRl
dGFjaGVkLiBTb21lIG9mIHRoZQo+ID4gdGVzdCBjYXNlcyB3aGljaCBhcmUgZmFpbGluZyBhcmU6
Cgo+ID4gPiAgICAgICAgICAgICAgIDEuIGlvY3RsMDQsIGlvY3RsMDUsIGlvY3RsMDYsIGlvY3Rs
MDcsIGlvY3RsMDkKPiA+ID4gICAgICAgICAgICAgICAyLiBpb2N0bF9sb29wMDEsIGlvY3RsX2xv
b3AwMiwgaW9jdGxfbG9vcDAzLAo+ID4gPiBpb2N0bF9sb29wMDQsIGlvY3RsX2xvb3AwNSwgaW9j
dGxfbG9vcDA2LCBpb2N0bF9sb29wMDcKCj4gPiA+ICAgICAgICAgICAgICAgVGhlIG1haW4gcm9v
dCBjYXVzZSBvZiB0aGUgbW9zdCBvZiB0aGUgdGVzdCBmYWlsdXJlcywgaXMgdGhlIGZ1bmN0aW9u
Cj4gPiAidHN0X2RldGFjaF9kZXZpY2VfYnlfZmQoKSIgd2hlcmUgdGhlIGZ1bmN0aW9uIGlzIGV4
cGVjdGluZyBlcnJvciBFTlhJTwo+ID4gd2hpY2ggaXMgcmV0dXJuZWQgb25seSBhZnRlciB0aGUg
ZGV2aWNlIGlzIGRldGFjaGVkLiBCdXQKPiA+ID4gICAgICAgICAgICAgICBkZXRhY2gsIGFzIHBl
ciBuZXcgYmVoYXZpb3IsIGhhcHBlbnMgb25seSBhZnRlciB0aGUgbGFzdCBjbG9zZSAoaS5lCj4g
PiBhZnRlciB0aGlzIGZ1bmN0aW9uIGlzIHJldHVybmVkKSwgdGhlIHRlc3Qgd2lsbCBmYWlsIHdp
dGggZm9sbG93aW5nIGVycm9yOgoKPiA+ID4gICAgICAgICAgICAgICAiaW9jdGwoL2Rldi9sb29w
MCwgTE9PUF9DTFJfRkQsIDApIG5vIEVOWElPIGZvciB0b28gbG9uZyIKCj4gPiA+ICAgICAgICAg
ICAgICAgU2ltaWxhcmx5LCBzb21lIG90aGVyIHRlc3QgY2FzZXMgYXJlIGV4cGVjdGluZyByZXN1
bHRzIHdoaWNoIGFyZQo+ID4gcmV0dXJuZWQgYWZ0ZXIgdGhlIGRldGFjaCBvcGVyYXRpb24sIGJ1
dCBhcyB0aGUgZGV0YWNoIGRpZCBub3QgaGFwcGVuLAo+ID4gdW5leHBlY3RlZCB2YWx1ZXMgYXJl
IHJldHVybmVkIHJlc3VsdGluZyBpbiB0aGUgdGVzdCBmYWlsdXJlLgoKPiA+ID4gICAgICAgICAg
ICAgICBTbywgY2FuIExUUCBtYWludGFpbmVycyB0ZWFtIGNoYW5nZSB0aGUgaW1wYWN0ZWQgdGVz
dCBjYXNlcyB0bwo+ID4gYWNjb21tb2RhdGUgdGhlIG5ldyBiZWhhdmlvciBvZiBrZXJuZWwgZm9y
IHRoZSBkZXRhY2ggb3BlcmF0aW9uIG9mIHRoZQo+ID4gbG9vcCBkZXZpY2U/CgoKPiA+ID4gVGhh
bmtzIGZvciBoaWdobGlnaHRpbmcgdGhlIGlzc3VlLCBjYW4geW91IHRlbGwgd2hpY2gga2VybmVs
IHZlcnNpb24KPiA+ID4gKGNvbW1pdCA/KSBpbnRyb2R1Y2VkIHRoYXQgY2hhbmdlLCB0aGVuIHdl
IGNvdWxkIGFkanVzdCB0aGUgdGVzdCBhZ2FpbnN0IHRoZQo+ID4gZGlmZmVyZW50IGtlcm5lbHMu
Cgo+ID4gPiBUaGFua3MgZm9yIHRoZSBoZWxwLiBUaGUgcGF0Y2ggaXMgYWxyZWFkeSBpbiBxdWV1
ZSBieSB0aGUgYmxvY2sgbWFpbnRhaW5lcnMKPiA+IGZvciA2LjExLiBTZWVtcyBsaWtlIGl0IHdp
bGwgYmUgbWVyZ2VkIHNvb24uCgo+ID4gVGhhbmtzIGZvciB5b3VyIHJlcG9ydC4gSSBzdXBwb3Nl
IHlvdSBhcmUgdGFsa2luZyBhYm91dCBjb21taXQKPiA+IDE4MDQ4YzFhZjc4MzYKPiA+ICgibG9v
cDogRml4IGEgcmFjZSBiZXR3ZWVuIGxvb3AgZGV0YWNoIGFuZCBsb29wIG9wZW4iKSBbMV0sIHJp
Z2h0PyBUaGUKPiA+IGNvbW1pdCBpcyBhbHJlYWR5IGluIHRoZSBuZXh0IHRyZWUgWzJdLgoKPiA+
IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gWWVzLCB0aGlzIGlzIHRoZSBvbmUgSSB3YXMgdGFs
a2luZyBhYm91dC4KCkkgdGVzdGVkIGZldyBpb2N0bCogdGVzdHMgb24gIDYuMTAuMC1yYzctbmV4
dC0yMDI0MDcxMSBhbmQgaW5kZWVkIGF0IGxlYXN0CmlvY3RsX2xvb3AwMiBmYWlsczoKCnRzdF90
ZXN0LmM6MTY1MjogVElORk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBzCnRzdF9kZXZp
Y2UuYzo5NzogVElORk86IEZvdW5kIGZyZWUgZGV2aWNlIDAgJy9kZXYvbG9vcDAnCmlvY3RsX2xv
b3AwMi5jOjU0OiBUSU5GTzogVXNpbmcgTE9PUF9TRVRfRkQgdG8gc2V0dXAgbG9vcGRldmljZQpp
b2N0bF9sb29wMDIuYzo2NTogVFBBU1M6IC9zeXMvYmxvY2svbG9vcDAvcm8gPSAxCmlvY3RsX2xv
b3AwMi5jOjY2OiBUUEFTUzogL3N5cy9ibG9jay9sb29wMC9sb29wL2JhY2tpbmdfZmlsZSA9ICcv
dG1wL0xUUF9pb2NFbTNpejIvdGVzdC5pbWcnCmlvY3RsX2xvb3AwMi5jOjc1OiBUUEFTUzogbG9f
ZmxhZ3Mgb25seSBoYXMgZGVmYXVsdCBMT19GTEFHU19SRUFEX09OTFkgZmxhZwppb2N0bF9sb29w
MDIuYzo4MTogVFBBU1M6IENhbiBub3Qgd3JpdGUgZGF0YSBpbiBSTyBtb2RlOiBFUEVSTSAoMSkK
aW9jdGxfbG9vcDAyLmM6ODc6IFRQQVNTOiBMT09QX0NIQU5HRV9GRCBzdWNjZWVkZWQKaW9jdGxf
bG9vcDAyLmM6ODg6IFRQQVNTOiAvc3lzL2Jsb2NrL2xvb3AwL3JvID0gMQppb2N0bF9sb29wMDIu
Yzo4OTogVFBBU1M6IC9zeXMvYmxvY2svbG9vcDAvbG9vcC9iYWNraW5nX2ZpbGUgPSAnL3RtcC9M
VFBfaW9jRW0zaXoyL3Rlc3QxLmltZycKaW9jdGxfbG9vcDAyLmM6OTU6IFRQQVNTOiBMT09QX0NI
QU5HRV9GRCBmYWlsZWQgYXMgZXhwZWN0ZWQ6IEVJTlZBTCAoMjIpCmlvY3RsX2xvb3AwMi5jOjU0
OiBUSU5GTzogVXNpbmcgTE9PUF9DT05GSUdVUkUgd2l0aCByZWFkX29ubHkgZmxhZwppb2N0bF9s
b29wMDIuYzo2MTogVEJST0s6IGlvY3RsKDUsKDB4NEMwQSksLi4uKSBmYWlsZWQ6IEVCVVNZICgx
NikKCkknbGwgdHJ5IHRvIGhhdmUgbG9vayBvbiB0aGUgZml4LgoKS2luZCByZWdhcmRzLApQZXRy
Cgo+IFJlZ2FyZHMsCj4gR3VsYW0gTW9oYW1lZC4KCj4gPiBbMV0gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5kay9jZ2l0L2xpbnV4LQo+ID4gYmxvY2svY29t
bWl0Lz9oPWZvci0KPiA+IDYuMTEqYmxvY2smaWQ9MTgwNDhjMWFmNzgzNmI4ZTMxNzM5ZDllYWVm
ZWJjMmJmNzYyNjFmN19fO0x3ISFBQ1dWNQo+ID4gTjlNMlJWOTloUSFLRTJYdmRIVGt5SU1Ka2tD
cjhOXzE0Y0p6anVSa0J6ci1ZR3AtCj4gPiBnb2h5ZEV3N1BWWFlfNGpkaXo5eFFJZlQ0MVhHWnEy
QWxicl9zSUlWZFJmVVEkCj4gPiBbMl0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC8KPiA+IG5leHQv
bGludXgtbmV4dC5naXQvY29tbWl0Lz9oPW5leHQtCj4gPiAyMDI0MDcwOSZpZD0xODA0OGMxYWY3
ODM2YjhlMzE3MzlkOWVhZWZlYmMyYmY3NjI2MWY3X187ISFBQ1dWNU45Cj4gPiBNMlJWOTloUSFL
RTJYdmRIVGt5SU1Ka2tDcjhOXzE0Y0p6anVSa0J6ci1ZR3AtCj4gPiBnb2h5ZEV3N1BWWFlfNGpk
aXo5eFFJZlQ0MVhHWnEyQWxicl9zSUdzbGw4OWckCgo+ID4gPiBSZWdhcmRzLAo+ID4gPiBHdWxh
bSBNb2hhbWVkLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
