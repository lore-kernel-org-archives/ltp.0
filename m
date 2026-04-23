Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5AFF99344
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 09:28:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E38903E5385
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 11:28:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 965F43E0E66
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:27:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C712B600774
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:27:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FF2F5BCED;
 Thu, 23 Apr 2026 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776936466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Szb/77FrY07rl0gE1fIlIEDTcWYlFSvdGAl1J9gVNes=;
 b=KfWMoPNcnfFZXgCW9cjsvXlQX6oPb1LzpxolFoXRWntmxAPQh0nPnBtD52lS/x+aKQJ6qO
 e7Wik//rzyPSOH8g9ngmH+hEyP3Q7hoKFPs76NQ4YRCOCtcXaw88F4pm+vn3vGOckW0ywG
 ZOXx4Y98TuRWg9w2C0hVan3Jn9zpVoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776936466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Szb/77FrY07rl0gE1fIlIEDTcWYlFSvdGAl1J9gVNes=;
 b=ozNopPqoUB9ccdHXL6R+I69BQ5sZbLzf8A0/Mp1npdzc2eRWMDcogcEk8l/tf9aTcD8jDw
 LxSuYX6X0pkE+/Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776936466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Szb/77FrY07rl0gE1fIlIEDTcWYlFSvdGAl1J9gVNes=;
 b=KfWMoPNcnfFZXgCW9cjsvXlQX6oPb1LzpxolFoXRWntmxAPQh0nPnBtD52lS/x+aKQJ6qO
 e7Wik//rzyPSOH8g9ngmH+hEyP3Q7hoKFPs76NQ4YRCOCtcXaw88F4pm+vn3vGOckW0ywG
 ZOXx4Y98TuRWg9w2C0hVan3Jn9zpVoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776936466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Szb/77FrY07rl0gE1fIlIEDTcWYlFSvdGAl1J9gVNes=;
 b=ozNopPqoUB9ccdHXL6R+I69BQ5sZbLzf8A0/Mp1npdzc2eRWMDcogcEk8l/tf9aTcD8jDw
 LxSuYX6X0pkE+/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00FDC593A3;
 Thu, 23 Apr 2026 09:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +g4COhHm6WmmMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 09:27:45 +0000
Date: Thu, 23 Apr 2026 11:27:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Leon Romanovsky <leon@kernel.org>
Message-ID: <20260423092744.GA664042@pevik>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
 <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
 <20260407132426.GC25645@pevik> <20260412141439.GD21470@unreal>
 <20260414073010.GB230573@pevik> <20260414091731.GT21470@unreal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260414091731.GT21470@unreal>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.de,lists.linux.it,gmail.com,redhat.com,ziepe.ca,vger.kernel.org,oss.oracle.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,bootlin.com:url,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] device-drivers/rdma: Add ucma_uaf01 test
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
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
 Eric Biggers <ebiggers3@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGVvbiwgYWxsLAoKPiBPbiBUdWUsIEFwciAxNCwgMjAyNiBhdCAwOTozMDoxMEFNICswMjAw
LCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gSGkgTGVvbiwgYWxsLAoKPiA+ID4gT24gVHVlLCBBcHIg
MDcsIDIwMjYgYXQgMDM6MjQ6MjZQTSArMDIwMCwgUGV0ciBWb3JlbCB3cm90ZToKPiA+ID4gPiBI
aSBBbmRyZWEsCgo+ID4gPiA+IGl0J3MgYmVlbiBsb25nIHRpbWUgc2luY2UgdGhpcyB1c2UtYWZ0
ZXItZnJlZSB3YXMgZml4ZWQsIGJ1dCBJTUhPIHN0aWxsIHVzZWZ1bAo+ID4gPiA+IHRvIGhhdmUg
YSB0ZXN0IChpdCdzIGFsc28ga2luZCBvZiBzbW9rZSB0ZXN0IGZvciByZG1hX2NtKS4KPiA+ID4g
PiBBbnl3YXksIExHVE0sIGJ1dCBpdCdkIGJlIG5pY2UgdG8gcmVwcm9kdWNlIHRoZSBidWcuCgo+
ID4gPiA+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KCj4gPiA+ID4g
PiBUZXN0IGZvciB1c2UtYWZ0ZXItZnJlZSBpbiBSRE1BIFVDTUEgdHJpZ2dlcmVkIGJ5IHJhY2lu
ZyBDUkVBVEVfSUQsCj4gPiA+ID4gPiBCSU5EX0lQLCBhbmQgTElTVEVOIG9wZXJhdGlvbnMuIFRo
cmVlIHRocmVhZHMgY29uY3VycmVudGx5IGlzc3VlCj4gPiA+ID4gPiB0aGVzZSBjb21tYW5kcyB0
byAvZGV2L2luZmluaWJhbmQvcmRtYV9jbSBhbmQgdGhlIHRlc3QgY2hlY2tzIGZvcgo+ID4gPiA+
ID4ga2VybmVsIHRhaW50IChLQVNBTiB1c2UtYWZ0ZXItZnJlZSBkZXRlY3Rpb24pLgoKPiA+ID4g
PiA+IFRoZSBidWcgd2FzIGZpeGVkIGJ5IGtlcm5lbCBjb21taXQgNWZlMjNmMjYyZTA1Cj4gPiA+
ID4gPiAoInVjbWE6IGZpeCBhIHVzZS1hZnRlci1mcmVlIGluIHVjbWFfcmVzb2x2ZV9pcCgpIiku
Cgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZl
c2F0b0BzdXNlLmNvbT4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gIHJ1bnRlc3Qva2VybmVsX21p
c2MgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ID4gPiA+ID4gIHRlc3Rj
YXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvTWFrZWZpbGUgICAgICAgICAgfCAgIDEgKwo+ID4g
PiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcmRtYS8uZ2l0aWdub3JlICAg
fCAgIDEgKwo+ID4gPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvcmRtYS9N
YWtlZmlsZSAgICAgfCAgIDcgKwo+ID4gPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRy
aXZlcnMvcmRtYS91Y21hX3VhZjAxLmMgfCAyMDggKysrKysrKysrKysrKysrKysrKysrKwo+ID4g
PiA+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMjE4IGluc2VydGlvbnMoKykKCj4gPiA+IDwuLi4+Cgo+
ID4gPiA+ID4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ID4gPiA+ICsJLnRl
c3RfYWxsID0gcnVuLAo+ID4gPiA+ID4gKwkuc2V0dXAgPSBzZXR1cCwKPiA+ID4gPiA+ICsJLmNs
ZWFudXAgPSBjbGVhbnVwLAo+ID4gPiA+ID4gKwkucnVudGltZSA9IDMwMCwKPiA+ID4gPiA+ICsJ
Lm5lZWRzX3Jvb3QgPSAxLAo+ID4gPiA+ID4gKwkudGFpbnRfY2hlY2sgPSBUU1RfVEFJTlRfVyB8
IFRTVF9UQUlOVF9ELAo+ID4gPiA+ID4gKwkubmVlZHNfa2NvbmZpZ3MgPSAoY29uc3QgY2hhciAq
W10pIHsKPiA+ID4gPiA+ICsJCSJDT05GSUdfSU5GSU5JQkFORCIsCj4gPiA+ID4gPiArCQkiQ09O
RklHX0lORklOSUJBTkRfVVNFUl9BQ0NFU1MiLAoKPiA+ID4gSeKAmW0gbm90IGZhbWlsaWFyIHdp
dGggdGhlIExUUCB0ZXN0cywgYnV0IEkgd2FudGVkIHRvIHBvaW50IG91dCB0aGF0IHRoZXNlCj4g
PiA+IGNvbmZpZyBvcHRpb25zIGFyZSBpbnN1ZmZpY2llbnQuIFlvdSBuZWVkIGFuIGFjdHVhbCBv
ciB2aXJ0dWFsIFJETUEgZGV2aWNlCj4gPiA+IGNvbm5lY3RlZCB0byByZG1hLWNtIGZvciB0aGUg
dGVzdHMgdG8gd29yayBjb3JyZWN0bHkuCgo+ID4gTGVvbiwgdGhhbmtzIGZvciBsb29raW5nIGlu
dG8gaXQuIEZZSSB0aGVzZSBhcmUganVzdCBjb25maWcgb3B0aW9ucyB0byBza2lwCj4gPiBrZXJu
ZWxzIHdpdGhvdXQgcmVxdWlyZWQga2VybmVsIG1vZHVsZXMuIAoKPiA+IFNvIHVzaW5nIC9kZXYv
aW5maW5pYmFuZC9yZG1hX2NtICh2aWEgUkRNQV9DTV9ERVYpIGlzIG5vdCBlbm91Z2gsIHdlIG5l
ZWQKPiA+IGFub3RoZXIgZGV2aWNlPwoKPiBZZXMsIGByZG1hLWNtYCBwcm92aWRlcyBhbiBpbnRl
cmZhY2UgZm9yIGFkZHJlc3MgcmVzb2x1dGlvbiBvbgo+IElCL2lXQVJQL1JvQ0UgbmV0d29ya3Mg
d2l0aG91dCByZXF1aXJpbmcga25vd2xlZGdlIG9mIHRoZSB1bmRlcmx5aW5nCj4gZmFicmljIGRl
dGFpbHMuCgo+IFdoZW4gYW4gSUIgZGV2aWNlIGlzIHJlZ2lzdGVyZWQsIFJETUEvY29yZSBpbnZv
a2VzIGBjbV9hZGRfb25lKClgLCB3aGljaAo+IGF0dGFjaGVzIGByZG1hLWNtYCB0byB0aGF0IGRl
dmljZS4KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ny4wL3NvdXJjZS9kcml2
ZXJzL2luZmluaWJhbmQvY29yZS9jbS5jI0w0MzM1CgpMZW9uLCB0aGFua3MgYSBsb3QgZm9yIGEg
Y2xhcmlmaWNhdGlvbi4gU2V0dGluZyBwYXRjaCAiY2hhbmdlcyByZXF1ZXN0ZWQiLgoKS2luZCBy
ZWdhcmRzLApQZXRyCgo+IFRoYW5rcwoKCj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQZXRyCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
