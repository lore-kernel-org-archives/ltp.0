Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2C2C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 11:20:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5E813C7FBE
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 12:20:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0741B3C1D8F
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 12:20:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B481A600F5F
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 12:20:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FCBE1F37D;
 Thu,  9 Dec 2021 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639048812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0EfkBiQVloXStfzlx52TAg1n1O8TaisAEl0X+Sh5tM=;
 b=qNdvWaITZTktFZOSv+UCKzk8FBLioY2A+0z8a8b7BT76ibWtk95AJRhd/FD5cMe7RdGXt8
 8RJ9Rt8814lWedZ7MfO0RSLLtHkuOafbNSqrxXFS9X2SeI34FtDzuDQJc4QpjBy9XlFNsu
 EVlhvAnlsPwUOBr90O0sky7UCvWy3uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639048812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0EfkBiQVloXStfzlx52TAg1n1O8TaisAEl0X+Sh5tM=;
 b=G5MmVSgYgDaBErfBIm/duqLHE8uKbOy4YUNv07NRiNvFMDO3APxMjgH8NPOX2sRxF26f5w
 njK50uPZMNnh+sCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C5C013343;
 Thu,  9 Dec 2021 11:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DqzSHGzmsWEoRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Dec 2021 11:20:12 +0000
Date: Thu, 9 Dec 2021 12:19:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YbHmRwf6ibQC5f0Q@pevik>
References: <20211208082625.26324-1-pvorel@suse.cz>
 <61B1CFC8.6060305@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61B1CFC8.6060305@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] m4: Fix warnings
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWHUsIGFsbCwKCgpbQ2MgYWxzbyBTYWdpLCB3aG8gaXMgYXVjdHVhbGx5IHVzaW5nIGx0cC1w
YW4gWzFdLApTYWdpOiBjb3VsZCB5b3UgcGxlYXNlIHRlc3QgdGhpcyBwYXRjaCBbMl0gb3IgaW4g
cGF0Y2h3b3JrIFszXQoKPiBIaSBQZXRyCgoKPiA+IGZyb20gYXV0b2NvbmYgMi43MToKCj4gPiAq
IHMvQUNfSEVMUF9TVFJJTkcvQVNfSEVMUF9TVFJJTkcvCgo+ID4gU2ltaWxhciByZXBsYWNlIHdh
cyBkb25lIGluIGF1dG9jb25mIGNvbW1pdCA1OTU4Y2UxNyAoIioKPiA+IGRvYy9hdXRvY29uZi50
ZXhpOiBSZXBsYWNlIEFDX0hFTFBfU1RSSU5HIEFTX0hFTFBfU1RSSU5HLiIpCj4gPiBmcm9tIDIu
NTguCgo+ID4gKiBzL0FDX1RSWV9MSU5LL0FDX0NPTVBJTEVfSUZFTFNFKFtBQ19MQU5HX1BST0dS
QU0vCj4gICAgKiBzL0FDX1RSWV9MSU5LL0FDX0xJTktfSUZFTFNFKFtBQ19MQU5HX1BST0dSQU0v
Cj4gICAgKiBzL0FDX1RSWV9DT01QSUxFL0FDX0NPTVBJTEVfSUZFTFNFKFtBQ19MQU5HX1BST0dS
QU0vCgp0aGFua3MhCgouLi4KPiA+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+ID4gQEAgLTI0LDcgKzI0
LDcgQEAgQUNfUFJPR19DQwo+ID4gICAjIDIuNjIuCj4gPiAgIEFDX0RFRlVOKFtBQ19QUk9HX0FS
XSwgW0FDX0NIRUNLX1RPT0woQVIsIGFyLCA6KV0pCj4gPiAgIEFDX1BST0dfQVIKPiA+IC1BQ19Q
Uk9HX0xFWAo+ID4gK0FDX1BST0dfTEVYKHl5d3JhcCkKPiAgRnJvbSB0aGlzIGF1dG9jb25mIGNv
bW1pdCBtZXNzYWdlLCBJZiAkMSBpcyBgeXl3cmFwJywKPiBhbmQgd2UgZG9uJ3QgZmluZCBhIGxp
YnJhcnkgdGhhdCBwcm92aWRlcyB5eXdyYXAsIHdlIGZhaWwuCgpGWUkgd2UgaGF2ZSB5eXdyYXAo
dm9pZCkgaW4gcGFuL3NjYW4ubApUbyBiZSBob25lc3QsIEknbSBhIGJpdCBsb3N0IGluIGRvY3Mg
WzRdOgoKCXl5d3JhcAoJSW5kaWNhdGUgdGhhdCB0aGUgbGlicmFyeSBpbiBMRVhMSUIgbmVlZHMg
dG8gZGVmaW5lIHRoZSBmdW5jdGlvbiB5eXdyYXAuIElmCglhIGxpYnJhcnkgdGhhdCBkZWZpbmVz
IHRoaXMgZnVuY3Rpb24gY2Fubm90IGJlIGZvdW5kLCBMRVggd2lsbCBiZSByZXNldCB0bwoJ4oCY
OuKAmS4KCglub3l5d3JhcAoJSW5kaWNhdGUgdGhhdCB0aGUgbGlicmFyeSBpbiBMRVhMSUIgZG9l
cyBub3QgbmVlZCB0byBkZWZpbmUgdGhlIGZ1bmN0aW9uCgl5eXdyYXAuIGNvbmZpZ3VyZSB3aWxs
IG5vdCBzZWFyY2ggZm9yIGl0IGF0IGFsbC4KCglQcmlvciB0byBBdXRvY29uZiAyLjcwLCBBQ19Q
Uk9HX0xFWCBkaWQgbm90IHRha2UgYW55IGFyZ3VtZW50cywgYW5kIGl0cwoJYmVoYXZpb3Igd2Fz
IGRpZmZlcmVudCBmcm9tIGVpdGhlciBvZiB0aGUgYWJvdmUgcG9zc2liaWxpdGllczogaXQgd291
bGQKCXNlYXJjaCBmb3IgYSBsaWJyYXJ5IHRoYXQgZGVmaW5lcyB5eXdyYXAsIGFuZCB3b3VsZCBz
ZXQgTEVYTElCIHRvIHRoYXQKCWxpYnJhcnkgaWYgaXQgZmluZHMgb25lLiBIb3dldmVyLCBpZiBh
IGxpYnJhcnkgdGhhdCBkZWZpbmVzIHRoaXMgZnVuY3Rpb24KCWNvdWxkIG5vdCBiZSBmb3VuZCwg
TEVYTElCIHdvdWxkIGJlIGxlZnQgZW1wdHkgYW5kIExFWCB3b3VsZCBub3QgYmUgcmVzZXQuCglU
aGlzIGJlaGF2aW9yIHdhcyBkdWUgdG8gYSBidWcsIGJ1dCBzZXZlcmFsIHBhY2thZ2VzIGNhbWUg
dG8gZGVwZW5kIG9uIGl0LAoJc28gQUNfUFJPR19MRVggc3RpbGwgZG9lcyB0aGlzIGlmIG5laXRo
ZXIgdGhlIHl5d3JhcCBub3IgdGhlIG5veXl3cmFwIG9wdGlvbgoJaXMgZ2l2ZW4uCgoJVXNhZ2Ug
b2YgQUNfUFJPR19MRVggd2l0aG91dCBjaG9vc2luZyBvbmUgb2YgdGhlIHl5d3JhcCBvciBub3l5
d3JhcCBvcHRpb25zCglpcyBkZXByZWNhdGVkLiBJdCBpcyB1c3VhbGx5IGJldHRlciB0byB1c2Ug
bm95eXdyYXAgYW5kIGRlZmluZSB0aGUgeXl3cmFwCglmdW5jdGlvbiB5b3Vyc2VsZiwgYXMgdGhp
cyBhbG1vc3QgYWx3YXlzIHJlbmRlcnMgdGhlIExFWExJQiB1bm5lY2Vzc2FyeS4KCj0+IHVzaW5n
IHl5d3JhcCBsZWFkcyBmb3IgKm5ldyogYXV0b2NvbmYgMi43MSB0bwoxKSBMRVggOj0gOiwgaW5z
dGVhZCBvZiBMRVggOj0gZmxleCBpbiBpbmNsdWRlL21rL2NvbmZpZy5tawoyKSBtaXNzaW5nICNk
ZWZpbmUgWVlURVhUX1BPSU5URVIgMSBpbiBpbmNsdWRlL2NvbmZpZy5oCgppLmUuIEFDX1BST0df
TEVYKG5veXl3cmFwKSBsZWFkcyB0byB0aGUgc2FtZSBiZWhhdmlvciBhcyB3aXRoIEFDX1BST0df
TEVYCndpdGhvdXQgYXJndW1lbnQgb24gMi43MSAob3IgYW55IHNldHVwIG9uICpvbGQqIDIuNjkg
YXV0b2NvbmYpLgoKQnV0IEknbSBub3QgcmVhbGx5IGV4cGVydCBvbiBmbGV4IChhbmQgaW5zdGVh
ZCBvZiBzcGVuZGluZyB0aW1lIHdpdGggbHRwLXBhbiBJJ2QKcHJlZmVyIHdvcmsgb24gdXBzdHJl
YW1pbmcgcnVubHRwLW5nIFs1XSkuCgpLaW5kIHJlZ2FyZHMsClBldHIKClsxXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9sdHAvMjAyMTExMjcxMjE2MDkuMjY4MzctMS1zYWdpbmFrYXNoQGdtYWls
LmNvbS8KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDIxMTIwODA4MjYyNS4yNjMy
NC0xLXB2b3JlbEBzdXNlLmN6LwpbM10gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9q
ZWN0L2x0cC9wYXRjaC8yMDIxMTIwODA4MjYyNS4yNjMyNC0xLXB2b3JlbEBzdXNlLmN6LwpbNF0g
aHR0cHM6Ly93d3cuZ251Lm9yZy9zb2Z0d2FyZS9hdXRvY29uZi9tYW51YWwvYXV0b2NvbmYtMi43
MC9odG1sX25vZGUvUGFydGljdWxhci1Qcm9ncmFtcy5odG1sCls1XSBodHRwczovL2dpdGh1Yi5j
b20vbWV0YW4tdWN3L3J1bmx0cC1uZwoKPiBJIHNlZSBvdGhlciBwcm9qZWN0cyB0aGF0IHRoZXkg
dXNlIEFDX1BST0dfTEVYKHl5d3JhcCkgb3IgCj4gQUNfUFJPR19MRVgobm95eXdyYXApLCBidXQg
ZG9uJ3QgZ2V0IHdoeS4KCj4gWzFdaHR0cHM6Ly9naXRodWIuY29tL3NlYXJjaD9xPSVFMiU4MCU5
REFDX1BST0dfTEVYJTI4eXl3cmFwJTI5JUUyJTgwJTlDJnR5cGU9Y29tbWl0cwpOT1RFOiBJIHRy
aWVkIHRvIHNlYXJjaCBvbiBEZWJpYW4gZGlzdHJvIGJhc2VkIHNlYXJjaCBodHRwczovL2NvZGVz
ZWFyY2guZGViaWFuLm5ldC8gOgpodHRwczovL2NvZGVzZWFyY2guZGViaWFuLm5ldC9zZWFyY2g/
cT1BQ19QUk9HX0xFWCUyOHl5d3JhcCUyOSZsaXRlcmFsPTEmcGVycGtnPTEKaHR0cHM6Ly9jb2Rl
c2VhcmNoLmRlYmlhbi5uZXQvc2VhcmNoP3E9QUNfUFJPR19MRVglMjhub3l5d3JhcCUyOSZsaXRl
cmFsPTEKQnV0IEkgZ290IGFjdHVhbGx5IGxlc3MgcmVzdWx0cyB0aGFuIG9uIGdpdGh1Yi4KCj4g
QmVzdCBSZWdhcmRzCj4gWWFuZyBYdQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
