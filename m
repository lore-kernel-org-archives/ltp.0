Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC41C2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 22:47:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F9093D394B
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 00:47:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE1513D0681
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 00:46:54 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 193B5601165
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 00:46:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEB991F806;
 Tue,  9 Jul 2024 22:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720565212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCKzK3PauZv22t00+Zu3sIP61bNZqFT8hcklXZpy3Js=;
 b=lQa7LI9iqnSPqkg7E2VCf+6uyVja8w2cmHvOvUFANYYN4fOp3765fdA34t1tBU/ncsZPSy
 7dR8whU8q4bvFgp5iwRTvwklKO3Kkf5qUT4nDJcI5bYlq/1iPfyAxQqXCxaMoaFFtabFf9
 /oF+jQgWLBInEoZtZojpyCdq+mgDPho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720565212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCKzK3PauZv22t00+Zu3sIP61bNZqFT8hcklXZpy3Js=;
 b=x5Ep4bwXeHfGW19p+V1JA/zLaWQuOQivqw03Hf+uOAcQjURPG96AM8MnBdzzL3Jr9Xe5xu
 XsAxdgAurzci8RBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720565212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCKzK3PauZv22t00+Zu3sIP61bNZqFT8hcklXZpy3Js=;
 b=lQa7LI9iqnSPqkg7E2VCf+6uyVja8w2cmHvOvUFANYYN4fOp3765fdA34t1tBU/ncsZPSy
 7dR8whU8q4bvFgp5iwRTvwklKO3Kkf5qUT4nDJcI5bYlq/1iPfyAxQqXCxaMoaFFtabFf9
 /oF+jQgWLBInEoZtZojpyCdq+mgDPho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720565212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCKzK3PauZv22t00+Zu3sIP61bNZqFT8hcklXZpy3Js=;
 b=x5Ep4bwXeHfGW19p+V1JA/zLaWQuOQivqw03Hf+uOAcQjURPG96AM8MnBdzzL3Jr9Xe5xu
 XsAxdgAurzci8RBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E81E1369A;
 Tue,  9 Jul 2024 22:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id okCDOdu9jWb9KwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Jul 2024 22:46:51 +0000
Date: Wed, 10 Jul 2024 00:46:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Message-ID: <20240709224650.GB214763@pevik>
References: <IA1PR10MB724059C5A7A69CE2A4AF257698DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
 <CAEemH2fLGJY6D+GAgmFcoCk5jSw7-K5VkoDb1CEqTbwqfKw+Wg@mail.gmail.com>
 <IA1PR10MB7240E961E4C697B7379EB66E98DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <IA1PR10MB7240E961E4C697B7379EB66E98DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Gulam Mohamed <gulam.mohamed@oracle.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgR3VsYW0sIGFsbCwKClsgQ2MgbGludXgtYmxvY2sgYW5kIGF1dGhvciBhbmQgY29tbWl0dGVy
IG9mIHRoZSBjaGFuZ2UgaW4ga2VybmVsIF0KCj4gSGkgTGkgV2FuZywKCj4gRnJvbTogTGkgV2Fu
ZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gU2VudDogU2F0dXJkYXksIEp1bHkgNiwgMjAyNCA5OjEz
IEFNCj4gVG86IEd1bGFtIE1vaGFtZWQgPGd1bGFtLm1vaGFtZWRAb3JhY2xlLmNvbT4KPiBDYzog
bHRwQGxpc3RzLmxpbnV4Lml0Cj4gU3ViamVjdDogUmU6IFtMVFBdIFJlcXVlc3QgZm9yIE1vZGlm
aWNhdGlvbiBvZiB0ZXN0IGNhc2VzCgo+IEhpIEd1bGFtLAoKPiBPbiBTYXQsIEp1bCA2LCAyMDI0
IGF0IDM6NDjigK9BTSBHdWxhbSBNb2hhbWVkIHZpYSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdDxt
YWlsdG86bHRwQGxpc3RzLmxpbnV4Lml0Pj4gd3JvdGU6Cj4gSGkgVGVhbSwKCj4gICAgIFRoaXMg
aXMgcmVnYXJkaW5nIHRoZSBjaGFuZ2UgaW4ga2VybmVsIGJlaGF2aW9yIGFib3V0IHRoZSB3YXkg
dGhlIGxvb3AgZGV2aWNlIGlzIGRldGFjaGVkLgoKPiAgICAgICAgICAgICAgIEN1cnJlbnQgYmVo
YXZpb3IKPiAgICAgICAgICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAgICAgICAg
ICAgICBXaGVuIHRoZSBMT09QX0NMUl9GRCBpb2N0bCBjb21tYW5kIGlzIHNlbnQgdG8gZGV0YWNo
IHRoZSBsb29wIGRldmljZSwgdGhlIGVhcmxpZXIgYmVoYXZpb3Igd2FzIHRoYXQgdGhlIGxvb3Ag
ICAgIGRldmljZSB1c2VkIHRvIGJlIGRldGFjaGVkIGF0IHRoYXQgaW5zdGFuY2UgaXRzZWxmIGlm
IHRoZXJlIHdhcyBhIHNpbmdsZSBvcGVuZXIgb25seS4gSWYKPiAgICAgICAgICAgICAgICB0aGVy
ZSB3ZXJlIG11bHRpcGxlIG9wZW5lcnMgb2YgdGhlIGxvb3AgZGV2aWNlLCB0aGUgYmVoYXZpb3Ig
d2FzIHRvIGRlZmVyIHRoZSBkZXRhY2ggb3BlcmF0aW9uIGF0IHRoZSBsYXN0IGNsb3NlIG9mIHRo
ZSBkZXZpY2UuCgo+ICAgICAgICAgICAgICAgTmV3IGJlaGF2aW9yCj4gICAgICAgICAgICAgICAt
LS0tLS0tLS0tLS0tLS0tLS0KPiAgICAgICAgICAgICAgIEFzIHBlciB0aGUgbmV3IGJlaGF2aW9y
LCBpcnJlc3BlY3RpdmUgb2Ygd2hldGhlciB0aGVyZSBhcmUgYW55IG9wZW5lcnMgb2YgdGhlIGxv
b3AgZGV2aWNlIG9yIG5vdCwgdGhlIGRldGFjaCBvcGVyYXRpb24gaXMgZGVmZXJyZWQgdG8gdGhl
IGxhc3QgY2xvc2Ugb2YgdGhlIGRldmljZS4gVGhpcyB3YXMgZG9uZSB0byBhZGRyZXNzIGFuIGlz
c3VlLCBkdWUKPiAgICAgICAgICAgICAgIHRvIHJhY2UgY29kaXRpb25zLCByZWNlbnRseSB3ZSBo
YWQgaW4ga2VybmVsLgoKPiAgICAgICAgICAgICAgIFdpdGggdGhlIG5ldyBrZXJuZWwgYmVoYXZp
b3IgaW4gcGxhY2UsIHNvbWUgb2YgdGhlIExUUCB0ZXN0IGNhc2VzIGluICJ0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2lvY3RsLyIgYXJlIGZhaWxpbmcgYXMgdGhlIGRldmljZSBpcyBjbG9zZWQg
YXQgdGhlIGVuZCBvZiB0aGUgdGVzdCBhbmQgdGhlIHRlc3QgY2FzZXMgYXJlIGV4cGVjdGluZyBm
b3IgdGhlCj4gICAgICAgICAgICAgICAgcmVzdWx0cyB3aGljaCBjYW4gb2NjdXIgYWZ0ZXIgdGhl
IGRldmljZSBpcyBkZXRhY2hlZC4gU29tZSBvZiB0aGUgdGVzdCBjYXNlcyB3aGljaCBhcmUgZmFp
bGluZyBhcmU6Cgo+ICAgICAgICAgICAgICAgMS4gaW9jdGwwNCwgaW9jdGwwNSwgaW9jdGwwNiwg
aW9jdGwwNywgaW9jdGwwOQo+ICAgICAgICAgICAgICAgMi4gaW9jdGxfbG9vcDAxLCBpb2N0bF9s
b29wMDIsIGlvY3RsX2xvb3AwMywgaW9jdGxfbG9vcDA0LCBpb2N0bF9sb29wMDUsIGlvY3RsX2xv
b3AwNiwgaW9jdGxfbG9vcDA3Cgo+ICAgICAgICAgICAgICAgVGhlIG1haW4gcm9vdCBjYXVzZSBv
ZiB0aGUgbW9zdCBvZiB0aGUgdGVzdCBmYWlsdXJlcywgaXMgdGhlIGZ1bmN0aW9uICJ0c3RfZGV0
YWNoX2RldmljZV9ieV9mZCgpIiB3aGVyZSB0aGUgZnVuY3Rpb24gaXMgZXhwZWN0aW5nIGVycm9y
IEVOWElPIHdoaWNoIGlzIHJldHVybmVkIG9ubHkgYWZ0ZXIgdGhlIGRldmljZSBpcyBkZXRhY2hl
ZC4gQnV0Cj4gICAgICAgICAgICAgICBkZXRhY2gsIGFzIHBlciBuZXcgYmVoYXZpb3IsIGhhcHBl
bnMgb25seSBhZnRlciB0aGUgbGFzdCBjbG9zZSAoaS5lIGFmdGVyIHRoaXMgZnVuY3Rpb24gaXMg
cmV0dXJuZWQpLCB0aGUgdGVzdCB3aWxsIGZhaWwgd2l0aCBmb2xsb3dpbmcgZXJyb3I6Cgo+ICAg
ICAgICAgICAgICAgImlvY3RsKC9kZXYvbG9vcDAsIExPT1BfQ0xSX0ZELCAwKSBubyBFTlhJTyBm
b3IgdG9vIGxvbmciCgo+ICAgICAgICAgICAgICAgU2ltaWxhcmx5LCBzb21lIG90aGVyIHRlc3Qg
Y2FzZXMgYXJlIGV4cGVjdGluZyByZXN1bHRzIHdoaWNoIGFyZSByZXR1cm5lZCBhZnRlciB0aGUg
ZGV0YWNoIG9wZXJhdGlvbiwgYnV0IGFzIHRoZSBkZXRhY2ggZGlkIG5vdCBoYXBwZW4sIHVuZXhw
ZWN0ZWQgdmFsdWVzIGFyZSByZXR1cm5lZCByZXN1bHRpbmcgaW4gdGhlIHRlc3QgZmFpbHVyZS4K
Cj4gICAgICAgICAgICAgICBTbywgY2FuIExUUCBtYWludGFpbmVycyB0ZWFtIGNoYW5nZSB0aGUg
aW1wYWN0ZWQgdGVzdCBjYXNlcyB0byBhY2NvbW1vZGF0ZSB0aGUgbmV3IGJlaGF2aW9yIG9mIGtl
cm5lbCBmb3IgdGhlIGRldGFjaCBvcGVyYXRpb24gb2YgdGhlIGxvb3AgZGV2aWNlPwoKCj4gVGhh
bmtzIGZvciBoaWdobGlnaHRpbmcgdGhlIGlzc3VlLCBjYW4geW91IHRlbGwgd2hpY2gga2VybmVs
IHZlcnNpb24gKGNvbW1pdCA/KQo+IGludHJvZHVjZWQgdGhhdCBjaGFuZ2UsIHRoZW4gd2UgY291
bGQgYWRqdXN0IHRoZSB0ZXN0IGFnYWluc3QgdGhlIGRpZmZlcmVudCBrZXJuZWxzLgoKPiBUaGFu
a3MgZm9yIHRoZSBoZWxwLiBUaGUgcGF0Y2ggaXMgYWxyZWFkeSBpbiBxdWV1ZSBieSB0aGUgYmxv
Y2sgbWFpbnRhaW5lcnMgZm9yIDYuMTEuIFNlZW1zIGxpa2UgaXQgd2lsbCBiZSBtZXJnZWQgc29v
bi4KClRoYW5rcyBmb3IgeW91ciByZXBvcnQuIEkgc3VwcG9zZSB5b3UgYXJlIHRhbGtpbmcgYWJv
dXQgY29tbWl0IDE4MDQ4YzFhZjc4MzYKKCJsb29wOiBGaXggYSByYWNlIGJldHdlZW4gbG9vcCBk
ZXRhY2ggYW5kIGxvb3Agb3BlbiIpIFsxXSwgcmlnaHQ/IFRoZSBjb21taXQgaXMKYWxyZWFkeSBp
biB0aGUgbmV4dCB0cmVlIFsyXS4KCktpbmQgcmVnYXJkcywKUGV0cgoKWzFdIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5kay9jZ2l0L2xpbnV4LWJsb2NrL2NvbW1pdC8/aD1mb3ItNi4xMS9ibG9jayZpZD0x
ODA0OGMxYWY3ODM2YjhlMzE3MzlkOWVhZWZlYmMyYmY3NjI2MWY3ClsyXSBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L2Nv
bW1pdC8/aD1uZXh0LTIwMjQwNzA5JmlkPTE4MDQ4YzFhZjc4MzZiOGUzMTczOWQ5ZWFlZmViYzJi
Zjc2MjYxZjcKCj4gUmVnYXJkcywKPiBHdWxhbSBNb2hhbWVkLgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
