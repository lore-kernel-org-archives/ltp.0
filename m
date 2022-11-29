Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0AEC4167B
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 11:09:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4B093CC5BD
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 12:09:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 367413C3057
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:09:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 956E7600838
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:09:22 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 67BEF1F74D;
 Tue, 29 Nov 2022 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669720161;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0z+m61Nk7gkW6cecuc/abAHy+OiIB8nFsA3I0vb021k=;
 b=bIFR87MPIall9Fp25/vicvW76EKqlbd00DaZ9AE1RNKeVvFBBbyH7aPmKaM2o43yNH4diE
 /wfzx1GV31UME2pLvzy51jyny1DvEH1uf3SLZfJ4VERhILHkgp8/SkX0aRrhk8SlS3zGDI
 zjA6zV4lnH6JmcAWrNj9aZ/v1ECqZgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669720161;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0z+m61Nk7gkW6cecuc/abAHy+OiIB8nFsA3I0vb021k=;
 b=OK6FBvI+8tMs74t1DSm4hsOB8TZXMK0qJTZePfufmNBIzp1GavCAibZCkYmUSnEhACP099
 CVPZv76ilOniVxDA==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 212BE2C141;
 Tue, 29 Nov 2022 11:09:21 +0000 (UTC)
References: <20221124114204.990-1-akumar@suse.de>
 <CAEemH2eVctJWX8AehwFDa0aorAyM_c+yabnB8zbwDoTUaVQLyg@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 29 Nov 2022 10:58:57 +0000
Organization: Linux Private Site
In-reply-to: <CAEemH2eVctJWX8AehwFDa0aorAyM_c+yabnB8zbwDoTUaVQLyg@mail.gmail.com>
Message-ID: <87r0xmt3ts.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statvfs01: Convert to new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JpdGVzOgoKPiBPbiBUaHUsIE5v
diAyNCwgMjAyMiBhdCA3OjQyIFBNIEF2aW5lc2ggS3VtYXIgPGFrdW1hckBzdXNlLmRlPiB3cm90
ZToKPgo+ICBBbHNvIEkndmUgcmVtb3ZlZCB0aGUgVElORk8gc3RhdGVtZW50cywgSSdtIG5vdCBz
dXJlIGlmIG9ubHkKPiAgcHJpbnRpbmcgdGhlIGRhdGEgaW4gbG9ncyBpcyBoZWxwZnVsIGluIGFu
eXdheS4KPgo+IFJlbW92aW5nIHRoZSBwcmludGluZyBpcyBPSywgYnV0IEkgYW0ganVzdCB3b25k
ZXJpbmcgdGhhdAo+IGNhbiB3ZSBmaW5kIGEgd2F5IHRvIGNoZWNrIGlmIHRoZSByZXR1cm5lZCB2
YWx1ZSBpbiAnYnVmJyBpcwo+IGluZGVlZCBjb3JyZWN0Pwo+Cj4gQXMgeW91IGNhbiBzZWUgdGhl
IOKAmHN0cnVjdCBzdGF0dmZz4oCYIGluY2x1ZGVzIG1hbnkgZnMga2V5Cj4gdmFsdWVzIHRoYXQg
d2UgbmVlZCB0byB0cnVzdCB3aGVuIHVzaW5nIHRoZW0uCj4KPiBzdHJ1Y3Qgc3RhdHZmcyB7Cj4g
ICAgICAgICB1bnNpZ25lZCBsb25nICBmX2JzaXplOyAgICAvKiBGaWxlc3lzdGVtIGJsb2NrIHNp
emUgKi8KPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgIGZfZnJzaXplOyAgIC8qIEZyYWdtZW50IHNp
emUgKi8KPiAgICAgICAgIGZzYmxrY250X3QgICAgIGZfYmxvY2tzOyAgIC8qIFNpemUgb2YgZnMg
aW4gZl9mcnNpemUgdW5pdHMgKi8KPiAgICAgICAgIGZzYmxrY250X3QgICAgIGZfYmZyZWU7ICAg
IC8qIE51bWJlciBvZiBmcmVlIGJsb2NrcyAqLwo+ICAgICAgICAgZnNibGtjbnRfdCAgICAgZl9i
YXZhaWw7ICAgLyogTnVtYmVyIG9mIGZyZWUgYmxvY2tzIGZvcgo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVucHJpdmlsZWdlZCB1c2VycyAqLwo+ICAgICAg
ICAgZnNmaWxjbnRfdCAgICAgZl9maWxlczsgICAgLyogTnVtYmVyIG9mIGlub2RlcyAqLwo+ICAg
ICAgICAgZnNmaWxjbnRfdCAgICAgZl9mZnJlZTsgICAgLyogTnVtYmVyIG9mIGZyZWUgaW5vZGVz
ICovCj4gICAgICAgICBmc2ZpbGNudF90ICAgICBmX2ZhdmFpbDsgICAvKiBOdW1iZXIgb2YgZnJl
ZSBpbm9kZXMgZm9yCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5wcml2aWxlZ2VkIHVzZXJzICovCj4gICAgICAgICB1bnNpZ25lZCBsb25nICBmX2ZzaWQ7
ICAgICAvKiBGaWxlc3lzdGVtIElEICovCj4gICAgICAgICB1bnNpZ25lZCBsb25nICBmX2ZsYWc7
ICAgICAvKiBNb3VudCBmbGFncyAqLwo+ICAgICAgICAgdW5zaWduZWQgbG9uZyAgZl9uYW1lbWF4
OyAgLyogTWF4aW11bSBmaWxlbmFtZSBsZW5ndGggKi8KPiAgfTsKCkkgc3VwcG9zZSBwcmV2aW91
c2x5IHByaW50aW5nIHRoZSB2YWx1ZXMgYXQgbGVhc3QgYWNjZXNzZWQgdGhlIG1lbW9yeS4KQWN0
dWFsbHkgdmFsaWRhdGluZyB0aGUgdmFsdWVzIGNvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2ggdGhv
dWdoLgoKV2UgKHByb2JhYmx5KSBrbm93IHRoYXQgbWF4aW11bSBmaWxlbmFtZSBzaG91bGQgYmUg
bGVzcyB0aGFuIDI1NSBjaGFycwooZm9yIGUuZy4pLCBidXQgSSB0aGluayB0aGVyZSBpcyBhIGdv
b2QgY2hhbmNlIHRoYXQgdHJ5aW5nIHRvIHZhbGlkYXRlCnRoaXMgd2lsbCByZXN1bHQgaW4gZmFs
c2UgcG9zaXRpdmVzIGFuZCBzdHVmZiB3ZSBtaWdodCB3YW50IHRvIHJldmVydC4KCi0tIApUaGFu
ayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
