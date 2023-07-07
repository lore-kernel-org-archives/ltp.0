Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1988C001B0
	for <ltp@archiver.kernel.org>; Fri,  7 Jul 2023 08:14:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E659D3CBDBB
	for <ltp@archiver.kernel.org>; Fri,  7 Jul 2023 10:14:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2BD33C30A8
 for <ltp@lists.linux.it>; Fri,  7 Jul 2023 10:14:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5860C60095D
 for <ltp@lists.linux.it>; Fri,  7 Jul 2023 10:14:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C933A227BA;
 Fri,  7 Jul 2023 08:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688717647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcBmBKYFezS5yxbN0qCzJk9YaOVjDq7evZbvw8l/i0A=;
 b=x6eWyaZ7dt5Ainfxm3E1Zy2+qrc4/CNFCaaaLdwe+0G2vzxXh5LRtzotBgYEI0iQr8G9ns
 +qEl4ODXxvjG7QLEb1679Zr2J5rNM1Z1tXo045a8HfKjS3s/higCAkKIWpNeyjEbkAOpAB
 it8/W+X/k+9Rp+L5dCFYt+oK1+gMlyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688717647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcBmBKYFezS5yxbN0qCzJk9YaOVjDq7evZbvw8l/i0A=;
 b=UTf3M6+KojNdzei8z1wTgGi6LXFAarT+XwBJzmfD1gLp4EAHsHCXfbRuiSm++AwsIiK9i+
 C5XMU0yzj+WlMGBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BF1B139E0;
 Fri,  7 Jul 2023 08:14:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iXXWGE/Jp2RJNAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jul 2023 08:14:07 +0000
Date: Fri, 7 Jul 2023 10:14:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexander Aring <aahringo@redhat.com>
Message-ID: <20230707081404.GA571797@pevik>
References: <20230530203707.2965684-1-aahringo@redhat.com>
 <20230530203707.2965684-2-aahringo@redhat.com>
 <20230621090331.GA365741@pevik>
 <CAK-6q+jVapf==Sg_BqWr0KTGA+uKgaaSZQwO=5tWzve9=Dok2Q@mail.gmail.com>
 <20230702191813.GB360317@pevik>
 <CAK-6q+hsZxurnnd2snKr12R5UwieCnWhvgr5_OoDKAXorHNhTA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK-6q+hsZxurnnd2snKr12R5UwieCnWhvgr5_OoDKAXorHNhTA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fcntl40: test for owner values on classic
 posix lock
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

PiBIaSwKCj4gT24gU3VuLCBKdWwgMiwgMjAyMyBhdCAzOjE44oCvUE0gUGV0ciBWb3JlbCA8cHZv
cmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEFsZXgsCgo+ID4gLi4uCj4gPiA+ID4gPiArICog
W0Rlc2NyaXB0aW9uXQo+ID4gPiA+ID4gKyAqIFRlc3RzIGdmczIgZGxtIHBvc2l4IG9wIHF1ZXVl
IGhhbmRsaW5nIGluIHRoZSBrZXJuZWwuCj4gPiA+ID4gPiArICogSXQgaXMgcmVjb21tZW5kZWQg
dG8gcnVuIHdhdGNoIC1uIDAuMSAiZGxtX3Rvb2wgcGxvY2tzICRMUyIKPiA+ID4gPiA+ICsgKiBh
c2lkZSB0byBtb25pdG9yIGRsbSBwbG9jayBoYW5kbGluZy4KPiA+ID4gPiA+ICsgKgo+ID4gPiA+
ID4gKyAqIFtIb3cgdG8gdXNlIGl0XQo+ID4gPiA+ID4gKyAqIENhbGwgaXQgd2l0aCBUTVBESVI9
L21udCAuL2ZjbnRsNDAgd2hlcmUgVE1QRElSIGlzIGEgZ2ZzMiBtb3VudHBvaW50Lgo+ID4gPiA+
IEkgd29uZGVyIGlmIHdlIGNvdWxkIGNoZWNrIGZvciBHRlMyX01BR0lDICh3ZSdkIG5lZWQgdG8g
YWRkIGl0IHRvCj4gPiA+ID4gaW5jbHVkZS90c3RfZnMuaCA9PiAweDAxMTYxOTcwKSBhbmQgcXVp
dCB0aGUgdGVzdCB3aXRoIHRzdF9icmsoVENPTkYpIGlmIFRNUERJUgo+ID4gPiA+IGlzIG5vdCBv
biBnZnMyLgoKPiA+ID4gPiBBVE0gd2UgZG9uJ3QgaGF2ZSBhbnkgaGVscGVyIGluIHN0cnVjdCB0
c3RfdGVzdCwgd2hpY2ggd291bGQgZG8gaXQuCgoKPiA+ID4gSSB3aWxsIG1lbnRpb24gdGhhdCBn
ZnMyIGlzIG9ubHkgYW4gZXhhbXBsZSBoZXJlLiBJdCBiZWNvbWVzCj4gPiA+IGludGVyZXN0aW5n
IHdoZW4gYSBmaWxlIHN5c3RlbSBpbXBsZW1lbnRzIGl0cyBvd24gLmxvY2soKSBjYWxsYmFjayBP
Ugo+ID4gPiBpZiBzb21lYm9keSB3YW50cyB0byB0ZXN0IGZpbGUgc3lzdGVtIGNvcmUsIHdoZW4g
YSBmaWxlc3lzdGVtIGRvZXMgbm90Cj4gPiA+IGltcGxlbWVudCBpdHMgb3duIC5sb2NrKCkuCgo+
ID4gSSBzZWUgLmxvY2sgaXMgaW1wbGVtZW50ZWQgaW4gOXAsIGFmcywgY2VwaCwgY2lmcywgb2Nm
czIsIG9yYW5nZWZzLCBldmVuIE5GUy4KPiA+ICJmaWxlIHN5c3RlbSBjb3JlIjogZG8geW91IG1l
YW4gVkZTPyBCZWNhdXNlIHRoYXQgd291bGQgYmUgbW9yZSB1c2FibGUgdGhhbiB0aGUKPiA+IGZp
bGVzeXN0ZW1zIGFib3ZlICh3aGljaCBhcmUgcXVpdGUgZXhvdGljKS4KCgo+IEl0IGRlcGVuZHMg
aGVyZSB3aGF0IHRoZXkgYXJlIGRvaW5nIGluIC5sb2NrKCkgLSBJZiB0aGV5IGp1c3QgY2FsbAo+
IGxvY2tzX2xvY2tfZmlsZV93YWl0KCkgb3Igc2ltaWxhciBoZWxwZXJzIGRlcGVuZGluZyBvbiB0
aGUgY2FsbCwgdGhlbgo+IHRoZXkgZG9uJ3QgZG8gbXVjaCBkaWZmZXJlbnQgdGhhbiB3aGF0IHZm
cyBpcyBkb2luZy4KPiBJbiBjYXNlIG9mIGdmczIvb2NmcyBpdCBpcyB2ZXJ5IHNwZWNpYWwsIGl0
IHJlZGlyZWN0cyB0aGVpciBjYWxscyB0bwo+IERMTSBhbmQgRExNIGhhcyBpdHMgb3duIHdob2xl
IHBvc2l4IGltcGxlbWVudGF0aW9uIGJlaGluZCBpdC4gV2Ugb25seQo+IGNhbGwgbG9ja3NfbG9j
a19maWxlX3dhaXQoKSB0byBrZWVwIHRoZSBMaW51eCBib29ra2VlcGluZyBpbgo+IC9wcm9jL2xv
Y2tzLgoKPiBXaGF0IEkgYW0gZG9pbmcgaGVyZSBpcyBtb3N0bHkgdHJ1c3RpbmcgdGhlIExpbnV4
IGltcGxlbWVudGF0aW9uIGFuZAo+IGNvbXBhcmluZyByZXN1bHRzIGZyb20gZS5nLiB0bXBmcyB3
aXRoIEdGUzIgYW5kIEkgZm91bmQgaXNzdWVzLgoKPiBGb3Igbm93IEkgdHJ1c3QgdGhlIExpbnV4
IGltcGxlbWVudGF0aW9uIGFuZCBjaGVjayBpZiB3ZSBoYXZlIGEKPiBkaWZmZXJlbnQgcmVzdWx0
IGhlcmUuIEkgbmVlZCB0byBiZSB2ZXJ5IGNhcmVmdWwgaGVyZSBiZWNhdXNlCj4gR0ZTMi9PQ0ZT
MiBhcmUgY2x1c3RlciBmaWxlc3lzdGVtcyBhbmQgdGhlIGZjbnRsKCkgaW50ZXJmYWNlIHdhcyBu
ZXZlcgo+IG1hZGUgZm9yIGNsdXN0ZXIgZmlsZXN5c3RlbXMuIEhvd2V2ZXIgSSBjdXJyZW50bHkg
b25seSB0ZXN0ICJvbmUgbm9kZSIKPiBsb2NraW5nIGFuZCB0aGlzIHNob3VsZCBkZWxpdmVyIHRo
ZSBzYW1lIHJlc3VsdHMgYXMgdG1wZnMsIGV0Yy4KClRoYW5rcyBmb3IgaW5mby4gIEknbSBzdGls
bCBub3Qgc3VyZSBpZiB0aGlzIGlzIHVzZWZ1bCBvbmx5IGZvciBnZnMyL29jZnMKYW5kIHdlIHNo
b3VsZCBwcmVwYXJlIGJsb2NrIGRldmljZSB3aXRoIGdmczIgb3Igb2NmcyBhbmQgdGVzdCBmaWxl
c3lzdGVtIG9uIGl0LgpPciBpZiBpdCB3b3VsZCBiZSB1c2VmdWwgdG8gdGVzdCBvdGhlciBmaWxl
c3lzdGVtIGltcGxlbWVudGF0aW9uLiBJbiB0aGlzIGxhdHRlcgpjYXNlIHdlIHVzdWFsbHkgdXNl
IC5hbGxfZmlsZXN5c3RlbXMgKHdlIGRvbid0IGhhdmUgcHJvcGVyIGRvY3MgZm9yCi5hbGxfZmls
ZXN5c3RlbXMsIHRoZSBjbG9zZXN0IGlzIFsxXSkgYW5kIHRlc3QgaXMgdGhlbiBydW4gb24gdmFy
aW91cyBjb21tb24KZmlsZXN5c3RlbXMgKHNlZSBmc190eXBlX3doaXRlbGlzdFtdIGluIGxpYi90
c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmMpLCBidXQgaW4KdGhhdCBjYXNlIGdmczIgd291bGQgYmUg
c2tpcHBlZCAoaXQncyBub3QgYSBjb21tb24gZmlsZXN5c3RlbSkuCgpJbiBjYXNlIHByZXBhcmlu
ZyBibG9jayBkZXZpY2Ugd2l0aCBnZnMyIHNvbWV0aGluZyBsaWtlIHRoaXMgbWlnaHQgd29yazoK
CnN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKCS4uLgoJLmRldl9mc190eXBlID0gImdm
czIiLAoJLmZvcm1hdF9kZXZpY2UgPSAxLAoJLmRldl9mc19vcHRzID0gKGNvbnN0IGNoYXIgKmNv
bnN0IFtdKXsgIi10IiwgIm15Y2x1c3RlcjpteWdmczIiLCAiLXAiLCAibG9ja19kbG0iLCAiLWoi
ICwgIjIiICwgTlVMTH0sCgpLaW5kIHJlZ2FyZHMsClBldHIKClsxXSBodHRwczovL2dpdGh1Yi5j
b20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC93aWtpL0MtVGVzdC1BUEkjMTEzLWZpbGVzeXN0ZW0t
dHlwZS1kZXRlY3Rpb24tYW5kLXNraXBsaXN0Cgo+IC0gQWxleAoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
