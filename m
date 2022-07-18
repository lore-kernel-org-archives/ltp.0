Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8CDCCA481
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 10:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046EE3C9650
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 12:02:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29BC93C913B
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 12:02:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3691A600790
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 12:02:22 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 61FAB20D96;
 Mon, 18 Jul 2022 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658138542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WH5WuG534UNCt4+WYgS90d2LcK4CfoeJPsl9xrBubX4=;
 b=J7LddrgcnHkw8kid+SwC74cHo0v3hQcq6VI6cvxoXZYAKQlmoPx+j+UXDBxB4fgGE83Jrz
 pAPOyHOIihkS0DCH+g/EIDcwGTLaVkeoWC/5p71jTtCXa+wMiy/NSuqT8/Cma1JuHLELi7
 oX2QrfKczPJdTIoj5HCX8DQ+/g363dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658138542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WH5WuG534UNCt4+WYgS90d2LcK4CfoeJPsl9xrBubX4=;
 b=ASOb/UoQE7a8BeRKdLZV6+6W5w4ZBsSht5s8s9llUZpbNmdJ3xL41tbVzxA9+qqCylGVlz
 B0lUnBDPiWjMwPDw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2418B2C141;
 Mon, 18 Jul 2022 10:02:22 +0000 (UTC)
References: <TY2PR01MB442719179C60B4DB6D275B5CFD889@TY2PR01MB4427.jpnprd01.prod.outlook.com>
 <CAEemH2fMfQYhfaV5_LeZCxfkCY=FKCqXc+SrZzQLVjzTf4yf8g@mail.gmail.com>
 <8e16d91c-8307-8ea4-bde7-28ef093c1205@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Mon, 18 Jul 2022 10:33:20 +0100
In-reply-to: <8e16d91c-8307-8ea4-bde7-28ef093c1205@fujitsu.com>
Message-ID: <87tu7eivrm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Do we have some simple way to get the current
 cgroup.procs path?
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
Reply-To: rpalethorpe@suse.de
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgoieHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbSIgPHh1eWFuZzIwMTguanlAZnVqaXRz
dS5jb20+IHdyaXRlczoKCj4gSGkgTGkKPj4gSGkgWHUsCj4+IAo+PiBPbiBUaHUsIEp1bCAxNCwg
MjAyMiBhdCAyOjAyIFBNIHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20gCj4+IDxtYWlsdG86eHV5
YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4gPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20gCj4+IDxt
YWlsdG86eHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbT4+IHdyb3RlOgo+PiAKPj4gICAgIEhpIFJp
Y2hhcmQsIExJCj4+IAo+PiAgICAgSSBhbSB3cml0dGluZyBhIHNpbXBsZSByZWdyZXNzaW9uIHRl
c3RbMV10aGF0IHJlZmVyIHRvIGtlcm5lbAo+PiAgICAgc2VsZnRlc3QgY2dyb3VwIHRlc3RfY29y
ZVsyXS4gSSBtYXkgbmFtZSBpdCBhcyBtZW1jb250cm9sMDUuYy4KPj4gCj4+ICAgICBJdCB0ZXN0
cyBjZ3JvdXAgbWlncmF0aW9uIHBlcm1pc3Npb24gY2hlY2sgc2hvdWxkIGJlIHBlcmZvcm1lZCBi
YXNlZAo+PiAgICAgb24gdGhlIGNyZWRlbnRpYWxzIGF0IHRoZSB0aW1lIG9mIG9wZW4gaW5zdGVh
ZCBvZiB3cml0ZS4KPj4gCj4+ICAgICBJIGhhdmUgdXNlZCBsdHAgY2dyb3VwIGZyYW1ld29yaywg
YnV0IGx0cCBjZ3JvdXAgb25seSB1c2UKPj4gICAgIFNBRkVfQ0dST1VQX1BSSU5URiB0byB3cml0
ZSB2YWx1ZS4KPj4gCj4+ICAgICBIb3cgY2FuIGdldCB0aGUgY2dyb3VwIHJvb3RfZGlyIGx0cF9k
aXIgcGF0aD8gU28gSSBjYW4gb3BlbiB0aGlzIGZkCj4+ICAgICBhbmQgY2hhbmdlL3NhdmUgZWZm
ZWN0aXZlIHVpZCBiZXR3ZWVuIG9wZW4gYW5kIHdyaXRlPwo+PiAKPj4gTm90IHN1cmUgaWYgSSBm
dWxseSB1bmRlcnN0YW5kIHlvdXIgcmVxdWlyZW1lbnRzLgo+PiBDYW4gd2UgYWNoaWV2ZcKgdGhp
cyB0ZXN0IGJ5IGNyZWF0aW5nIGEgdHdvLWxheWVywqBzdWJkaXJlY3Rvcnk/Cj4KPiBJIHRoaW5r
IHllcy4KCkkgdGhpbmsgeW91IG11c3QgaGF2ZSBtdWx0aXBsZSBsYXllcnMuIE90aGVyd2lzZSB5
b3UgY291bGQgYnJlYWsgb3RoZXIKdGVzdHMgcnVubmluZyBpbiBwYXJhbGxlbC4KCj4KPj4gCj4+
IERvZXMgb25seSB0aGUgcm9vdC9sdHBfZGlyIG1hbmRhdG9yeSBmb3IgY29tcGxldGluZ8KgeW91
ciB0ZXN0Pwo+Cj4gSXQgYWxzbyBuZWVkIGdldHRpZCBzdWJkaXJlY3RvcnkgYW5kIGNncm91cCBu
YW1lLgoKWW91IGNvdWxkIGNyZWF0ZSBhbiBhY2Nlc3NvciBmdW5jdGlvbiBpbiB0aGUgbGlicmFy
eSB0byBnZXQgZGlyX2ZkIGZyb20KY2dyb3VwX2Rpci4KClRoaXMgaXMgY29tcGxpY2F0ZWQgYnkg
VjEgQ0dzIHdoZXJlIGEgdHN0X2NnX2dyb3VwIGNhbiBoYXZlIG11bHRpcGxlCnN0cnVjdCBjZ3Jv
dXBfZGlyJ3MuIFRoaXMgaXNuJ3QgYSBwcm9ibGVtIGZvciBzZWxmdGVzdHMgYmVjYXVzZSB0aGV5
Cm9ubHkgc3VwcG9ydCBWMiwgYnV0IGl0IHdvdWxkIGJlIG5pY2UgdG8gbWFrZSBhcyBtYW55IHRl
c3RzIGFzIHBvc3NpYmxlCndvcmsgd2l0aCBWMS4KClRoZSBlYXNpZXN0IHNvbHV0aW9uIEkgY2Fu
IHRoaW5rIG9mIGlzIHRvIHdyaXRlIGEgbGlicmFyeSBmdW5jdGlvbiBsaWtlClNBRkVfQ0dfR1JP
VVBfRUFDSF9ESVIodm9pZCAoKmNvbnN0IGZuX3B0cikoaW50IGRpcl9mZCkpIHdoaWNoIHRha2Vz
IGEKY29uc3QgZnVuY3Rpb24gcG9pbnRlciBhbmQgZXhlY3V0ZXMgaXQgd2l0aCB0aGUgRkQgb2Yg
ZWFjaApkaXJlY3RvcnkuIFRoZW4geW91IGNhbiB1c2UgdGhlIGludGVybmFsIGZvcl9lYWNoX2Rp
ciBtYWNybyBsaWtlClNBRkVfQ0dST1VQX1BSSU5URi4KCj4+IElmIHllcywgSSB0aGluayB0c3Rf
Y2dfcHJpbnRfY29uZmlnKCkgbWF5YmUgZml0cyB5b3VyIHB1cnBvc2UsCj4+IGJ1dCB0aGF0IHdv
dWxkIG5lZWQgYWRkaXRpb25hbCBmdW5jdGlvbiBoZWxwIGV4dHJhY3RpbmcgdGhhdC4KPj4gCj4+
IFRha2UgYSByZWZlcmVuY2UgdG8gc2VlIGhvdyBMdWtlIGdldHMgdGhlIHJvb3QgcGF0aCAoaW4g
c2hlbGwpOgo+PiBodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyMi1BcHJp
bC8wMjg3NzIuaHRtbAo+PiA8aHR0cHM6Ly9saXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIw
MjItQXByaWwvMDI4NzcyLmh0bWw+Cj4KPiBUaGFua3MsIEkgcHJlZmVyIHRvIHVzZSBjIGFwaSBh
bmQgd2lsbCB0aGluayBhYm91dCBpdCBjb250aW51ZWx5Lgo+Cj4gQmVzdCBSZWdhcmRzCj4gWWFu
ZyBYdQo+PiAKPj4gCj4+IC0tIAo+PiBSZWdhcmRzLAo+PiBMaSBXYW5nCgoKLS0gClRoYW5rIHlv
dSwKUmljaGFyZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
