Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E581FC77B78
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 07:39:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D2033CBE81
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 09:39:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B3B13CB332
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 09:39:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 54B9E1A009BB
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 09:39:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66AB5219A6;
 Fri, 21 Apr 2023 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682062770;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIGWWso/zKWvblgiL0RpyFFnPazcUJ93hWaL+Clwh6s=;
 b=CS3/3r6Ey48CwxHnNrGVSCQ60m+pj3CeUF1UPJyLS5GoJVcOqSygsnL5GmRMTngDhJG0It
 jCS/17WHuGPhF5mnIbib3Mde1wOT54W8K3hyYeUuxuTAq4RFfnc7znJ89i4Hf7djBCq4x5
 caQMDTXDfvuA+tlOOUSWEGsCOG062rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682062770;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIGWWso/zKWvblgiL0RpyFFnPazcUJ93hWaL+Clwh6s=;
 b=0i47gWkPGKi0HsxNfZnqNYfbTBOlPooTjBlPWtIrKsNy7hT/lztyZ1wxqkxZ2PkzF7yZw0
 bESjoeX8Z+aCjnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36CE713456;
 Fri, 21 Apr 2023 07:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9KTOC7I9QmQ9FQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Apr 2023 07:39:30 +0000
Date: Fri, 21 Apr 2023 09:39:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230421073936.GA2747101@pevik>
References: <20230413111434.2103422-1-pvorel@suse.cz>
 <CAEemH2fZU=b60mSD8PoZoQiJ7WQ+rhWiOqPO4XGyhS9aB2QDcA@mail.gmail.com>
 <CAEemH2eu2LCyM3g+2BcD2ZFaGSZ2R+V7-zbYc3Kg4kb=vqtiDA@mail.gmail.com>
 <20230419095939.GA2577418@pevik>
 <CAEemH2fAojMkcK2xEw+aM5oh9Csed-eOtHAs98OCydVRfyCzGQ@mail.gmail.com>
 <20230420145315.GA2694798@pevik>
 <CAEemH2fm9CFvxRBm9iiHiaS3-UqcVec7k3kXaYJP8J=CbJju6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fm9CFvxRBm9iiHiaS3-UqcVec7k3kXaYJP8J=CbJju6Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Remove possible double/trailing
 slashes from TMPDIR
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

PiBPbiBUaHUsIEFwciAyMCwgMjAyMyBhdCAxMDo1M+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToKCj4gPiBIaSBMaSwKPiA+IC4uLgo+ID4gPiA+ID4gPj4gKysrIGIvbGli
L3RzdF90bXBkaXIuYwo+ID4gPiA+ID4gPj4gQEAgLTEyNCwxNiArMTI0LDI4IEBAIGNoYXIgKnRz
dF9nZXRfdG1wZGlyKHZvaWQpCgo+ID4gPiA+ID4gPj4gIGNvbnN0IGNoYXIgKnRzdF9nZXRfdG1w
ZGlyX3Jvb3Qodm9pZCkKPiA+ID4gPiA+ID4+ICB7Cj4gPiA+ID4gPiA+PiAtICAgICAgIGNvbnN0
IGNoYXIgKmVudl90bXBkaXIgPSBnZXRlbnYoIlRNUERJUiIpOwo+ID4gPiA+ID4gPj4gKyAgICAg
ICBjaGFyICplbnZfdG1wZGlyID0gZ2V0ZW52KCJUTVBESVIiKTsKCgo+ID4gPiA+ID4gPiBJdCBz
ZWVtcyB0aGF0IG1vZGlmeWluZyB0aGUgZW52aXJvbm1lbnQgdmFyaWFibGVzIGlzIGdlbmVyYWxs
eQo+ID4gPiA+ID4gPiBub3QgYSBnb29kIHByYWN0aWNlLgoKPiA+ID4gPiA+ID4gVGhlIGdldGVu
digpIGZ1bmN0aW9uIHJldHVybnMgYSBwb2ludGVyIHRvIHRoZSB2YWx1ZSBvZiBhbgo+ID4gPiA+
ID4gPiBlbnZpcm9ubWVudCB2YXJpYWJsZSwgd2hpY2ggaXMgc3RvcmVkIGluIHRoZSBtZW1vcnkg
bWFuYWdlZAo+ID4gPiA+ID4gPiBieSB0aGUgc3lzdGVtLiBBbnkgYXR0ZW1wdCB0byBtb2RpZnkg
dGhpcyBtZW1vcnkgZGlyZWN0bHkgY2FuCj4gPiA+ID4gPiA+IGNhdXNlIHVuZXhwZWN0ZWQgYmVo
YXZpb3Igb3IgZXZlbiBjcmFzaCB0aGUgcHJvZ3JhbS4KCj4gPiA+ID4gPiA+IEluc3RlYWQgb2Yg
bW9kaWZ5aW5nIHRoZSByZXR1cm4gdmFsdWUgb2YgZ2V0ZW52KCksIGl0IGlzCj4gPiByZWNvbW1l
bmRlZAo+ID4gPiA+ID4gPiB0byBjcmVhdGUgYSBjb3B5IG9mIHRoZSB2YWx1ZSBhbmQgbW9kaWZ5
IHRoZSBjb3B5IGluc3RlYWQuCgo+ID4gPiA+IERvIHlvdSBtZWFuIHRvIHVzZSBzdHJkdXAoKT8K
Cgo+ID4gPiBZZWFoLCBzb21ldGhpbmcgbGlrZSB0aGF0LCBvciB3ZSBkZWNsYXJlIGEgYnVmZmVy
LCBhbmQgdXNlIHN0cmNweSgpCj4gPiA+IHRvIGNvcHkgdGhlIHN0cmluZyBwb2ludGVkIHRvIGJ5
IHRoZSByZXR1cm4gdmFsdWUgb2YgZ2V0ZW52KCkgaW50byB0aGUKPiA+ID4gYnVmZmVyIHRoYXQg
d2UgY2FuIHNhZmVseSBtb2RpZnkuCgo+ID4gPiBJIHByZWZlciBpdCBpbiB0aGlzIHdheS4KCgo+
ID4gU3VyZSwgSSdsbCBwb3N0IG5ldyB2ZXJzaW9uIHdpdGggdGhpcy4gVW50aWwgdGhlbiBJIGtl
ZXAgdGhpcyBwYXRjaCBvcGVuIGlmCj4gPiBhbnlib2R5IHdhbnRzIHRvIGNvbW1lbnQgaXQuCgo+
ID4gPiA+IEFsc28gbWFuIGdldGVudigzKSBzYXlzOgoKPiA+ID4gPiAgICAgICAgQXMgdHlwaWNh
bGx5IGltcGxlbWVudGVkLCBnZXRlbnYoKSByZXR1cm5zIGEgcG9pbnRlciB0byBhIHN0cmluZwo+
ID4gPiA+ICAgICAgICB3aXRoaW4gdGhlIGVudmlyb25tZW50IGxpc3QuICBUaGUgY2FsbGVyIG11
c3QgdGFrZSBjYXJlIG5vdCB0bwo+ID4gPiA+ICAgICAgICBtb2RpZnkgdGhpcyBzdHJpbmcsIHNp
bmNlIHRoYXQgd291bGQgY2hhbmdlIHRoZSBlbnZpcm9ubWVudCBvZgo+ID4gPiA+ICAgICAgICB0
aGUgcHJvY2Vzcy4KCj4gPiA+ID4gPT4gSSB3b3VsZCBub3QgbWluZCAkVE1QRElSIGdvdCB1cGRh
dGVkIGluIHRoZSBlbnZpcm9ubWVudC4KCj4gPiA+ID4gPiBCdHcsIHRoZSB3aXNlIG1ldGhvZCBp
cyB0byB1c2Ugc2V0ZW52KCkgZnVuY3Rpb24gdG8gcmVzZXQKPiA+ID4gPiA+IGVudmlyb25tZW50
IHZhcmlhYmxlcyBpZiByZWFsbHkgbmVlZGVkLgoKPiA+ID4gPiBXZWxsLCBJIGRvbid0IGtub3cg
YW55IEMgdGVzdCB3aGljaCBuZWVkcyBpdCAob25seSBORlMgdGVzdHMgd2hpY2ggYXJlCj4gPiA+
ID4gc2hlbGwKPiA+ID4gPiB0ZXN0cykuIEJ1dCBJIHdhbnRlZCB0byBoYXZlIHRoZSBzYW1lIGJl
aGF2aW9yIGluIGJvdGggQVBJcy4KCj4gPiA+ID4gPiBUaGlzIGlzIGEgZGlmZmVyZW50IHBhcnQg
b2Ygc2hlbGwgQVBJIEkgaGF2ZSB0byBzYXkuCgo+ID4gPiA+IFllcywgdGhlIGJlaGF2aW9yIGlz
IHNsaWdodGx5IGRpZmZlcmVudCBmcm9tIHNoZWxsIEFQSSBbMV0sCj4gPiA+ID4gd2hlcmUgaXQg
bW9kaWZpZXMgJFRTVF9UTVBESVIgKGtlZXAgJFRNUERJUiB1bnRvdWNoZWQpLgoKCj4gPiA+ID4g
PiA+IE9yLCB0aGUgc2ltcGxlc3Qgd2F5IEkgZ3Vlc3MgaXMganVzdCBUQlJPSyBhbmQgdGVsbCB1
c2VycyB3aHkKPiA+ID4gPiA+ID4gdGhpcyBUTVBESVIgaXMgdW51c2FibGUuCgo+ID4gPiA+IElm
IHlvdSBwcmVmZXIgaXQncyBiZXR0ZXIgdG8gVEJST0sgb246Cj4gPiA+ID4gKiBkb3VibGUgc2xh
c2hlcwo+ID4gPiA+ICogdHJhaWxpbmcgc2xhc2gKCj4gPiA+ID4gSSBjYW4gZG8gdGhhdC4gQnV0
IGF0IGxlYXN0IG9uIHRyYWlsaW5nIHNsYXNoIGxvb2tzIHRvIG1lIHF1aXRlIHN0cmljdC4KCgo+
ID4gPiAtMSwgdHJhaWxpbmcgYW5kIGRvdWJsZSBzbGFzaCBhbGwgYWNjZXB0ZWQgYnkgc2hlbGwg
aW4gY29tbWFuZCBsaW5lLAo+ID4gPiBtYXliZSB3ZSBzaG91bGRuJ3Qgc2V0IGEgbW9yZSBzdHJp
Y3QgcG9saWN5IHRoYW4gdGhhdC4KCj4gPiBBZ3JlZSwgSSBqdXN0IGRpZG4ndCB1bmRlcnN0YW5k
IGJlZm9yZSB5b3VyIGNvbmNlcm4gKHlvdSBtb3N0bHkgb2JqZWN0ZWQKPiA+IHRoZSBDCj4gPiBj
b2RlLCBub3QgdGhlIGZhY3QgdGhhdCB0aGUgcmVzdWx0ZWQgcGF0aCBpcyBtb2RpZmllZCkuCgoK
PiBZZWFoLCBJIGp1c3QgZG91YnRlZCB0aGUgaW5jb3JyZWN0IHdheSBvZiBkb2luZyB0aGF0Lgo+
IChpbiBDIHByb2dyYW1taW5nKQoKPiBTb3JyeSBmb3IgdGhlIHVuY2xlYXIgZGVzY3JpcHRpb24s
IEknbSBhbHdheXMgZGlzdHJlc3NlZCBieSBteSBFbmdsaXNoCj4gc3BlbGxpbmcgbGV2ZWwgOi0o
LgoKRG9uJ3Qgd29ycnksIG1vc3Qgb2YgdXMgYXJlIG5vbi1uYXRpdmUgc3BlYWtlcnMsIHRodXMg
dGhlIHByb2JsZW0gaXMgc29tZXRpbWVzCm9uIHRoZSBvdGhlciBzaWRlIChtZSkgOikuCgpLaW5k
IHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
