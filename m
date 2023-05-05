Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690BFC77B7C
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 17:32:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A08D3CB742
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 19:32:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3F2B3CB335
 for <ltp@lists.linux.it>; Fri,  5 May 2023 19:31:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ACD83200966
 for <ltp@lists.linux.it>; Fri,  5 May 2023 19:31:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DBD5B1FE93;
 Fri,  5 May 2023 17:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683307904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9mwCSG0RCrDQ79jQd5K/UTuu+wOZMRT9gjr6Ou4f1g=;
 b=O6UO85eECYbVpDDB8RS82BEGGeVhWOYbo3fu+7fRgq/aR9+ZOjMCCZJ4mCatyk9xm9WEm/
 vBFtDEttJHI4Ggm2go5sbNCjhlTJZAJGNa6C47HRD7mhKjWzi+Mm5B2bdjf1ztwnNJTJ7V
 VeRyjAu1CNffkLMjYirdswoAxDbPOS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683307904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9mwCSG0RCrDQ79jQd5K/UTuu+wOZMRT9gjr6Ou4f1g=;
 b=U9ZF7czoKAwObeQVnxRyJFQYELUIZnMAUn6bAkcxYwVH/YlxPRU5d7r8tabETv3/s4U3BR
 hHAAEzH5RNFOJ0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9749013513;
 Fri,  5 May 2023 17:31:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Oxj7HoA9VWRTRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 May 2023 17:31:44 +0000
Date: Fri, 5 May 2023 19:31:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230505173137.GB31348@pevik>
References: <20230321110337.22970-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230321110337.22970-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] starvation.c: New case for sched starvation
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

SGkgV2VpLAoKY291bGQgeW91IHBsZWFzZSBmaXggd2FybmluZ3M/IEJvdGggc2hvdWxkIGJlIHRy
aXZpYWwuCgpzdGFydmF0aW9uLmM6IEluIGZ1bmN0aW9uIOKAmGNoaWxk4oCZOgpzdGFydmF0aW9u
LmM6NzA6MTogd2FybmluZzogbm8gcmV0dXJuIHN0YXRlbWVudCBpbiBmdW5jdGlvbiByZXR1cm5p
bmcgbm9uLXZvaWQgWy1XcmV0dXJuLXR5cGVdCiAgIDcwIHwgfQogICAgICB8IF4KSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3QuaDoxMTAsCiAgICAgICAg
ICAgICAgICAgZnJvbSBzdGFydmF0aW9uLmM6MjI6CnN0YXJ2YXRpb24uYzogSW4gZnVuY3Rpb24g
4oCYZG9fdGVzdOKAmToKLi4vLi4vLi4vLi4vaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaDo0OTM6
NTE6IHdhcm5pbmc6IHBhc3NpbmcgYXJndW1lbnQgNCBvZiDigJhzYWZlX3NpZ25hbOKAmSBmcm9t
IGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUgWy1XaW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNd
CiAgNDkzIHwgICAgICAgICBzYWZlX3NpZ25hbChfX0ZJTEVfXywgX19MSU5FX18sIChzaWdudW0p
LCAoaGFuZGxlcikpCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBefn5+fn5+fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKCopKHZvaWQpCnN0YXJ2YXRpb24uYzo4
MTo5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYU0FGRV9TSUdOQUzigJkKICAgODEg
fCAgICAgICAgIFNBRkVfU0lHTkFMKFNJR1VTUjEsIGhhbmRsZXIpOwogICAgICB8ICAgICAgICAg
Xn5+fn5+fn5+fn4KLi4vLi4vLi4vLi4vaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaDo0OTA6MzQ6
IG5vdGU6IGV4cGVjdGVkIOKAmHNpZ2hhbmRsZXJfdOKAmSBidXQgYXJndW1lbnQgaXMgb2YgdHlw
ZSDigJh2b2lkICgqKSh2b2lkKeKAmQogIDQ5MCB8ICAgICAgICAgaW50IHNpZ251bSwgc2lnaGFu
ZGxlcl90IGhhbmRsZXIpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+
fl5+fn5+fn4KCm1ha2UgY2hlY2stc3RhcnZhdGlvbgptYWtlIC1DICIvaG9tZS9wZXZpay9pbnN0
YWxsL3NyYy9sdHAuZ2l0L3Rvb2xzL3NwYXJzZSIgYWxsCi4uLgpDSEVDSyB0ZXN0Y2FzZXMva2Vy
bmVsL3NjaGVkL2Nmcy1zY2hlZHVsZXIvc3RhcnZhdGlvbi5jCnN0YXJ2YXRpb24uYzo4MDo5OiB3
YXJuaW5nOiBpbmNvcnJlY3QgdHlwZSBpbiBhcmd1bWVudCA0IChkaWZmZXJlbnQgYXJndW1lbnQg
Y291bnRzKQpzdGFydmF0aW9uLmM6ODA6OTogICAgZXhwZWN0ZWQgdm9pZCAoICpbdXNlcnR5cGVd
IGhhbmRsZXIgKSggLi4uICkKc3RhcnZhdGlvbi5jOjgwOjk6ICAgIGdvdCB2b2lkICggKiApKCAu
Li4gKQoKCj4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cgo+IEFkZCBz
Y2hlZHVsbGVyIHRocmVhZCBzdGFydmF0aW9uIHRlc3QgY2FzZSBiYXNlIGZvbGxvd2luZyBsaW5r
Ogo+IGh0dHBzOi8vbHduLm5ldC9tbC9saW51eC1rZXJuZWwvOWZkMmMzN2EwNTcxM2MyMDZkY2Jk
NTg2NmY2N2NlNzc5ZjMxNWU5ZS5jYW1lbEBnbXguZGUvCm5pdDogd2Ugc2hvdWxkIHVzZSBsb3Jl
LCBub3QgbHduOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC85ZmQyYzM3YTA1NzEzYzIw
NmRjYmQ1ODY2ZjY3Y2U3NzlmMzE1ZTllLmNhbWVsQGdteC5kZS8KCi4uLgo+ICsrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFydmF0aW9uLmMKPiBAQCAtMCwwICsx
LDk3IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4g
Ky8qIENvcHlyaWdodCAyMDIzIE1pa2UgR2FsYnJhaXRoIDxlZmF1bHQtQVQtZ214LmRlPiAqLwpZ
b3UgY2FuIGFkZCB5b3VyIGNyZWRpdCBmb3IgcG9ydGluZyB0byBMVFAgOikuCgo+ICsvKlwKPiAr
ICoKPiArICogW0Rlc2NyaXB0aW9uXQo+ICsgKgo+ICsgKiBUaHJlYWQgc3RhcnZhdGlvbiB0ZXN0
Lgo+ICsgKiBUaGlzIGNhc2UgY29weSBmcm9tIGZvbGxvd2luZyBsaW5rOgo+ICsgKiBodHRwczov
L2x3bi5uZXQvbWwvbGludXgta2VybmVsLzlmZDJjMzdhMDU3MTNjMjA2ZGNiZDU4NjZmNjdjZTc3
OWYzMTVlOWUuY2FtZWxAZ214LmRlLwpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzlmZDJj
MzdhMDU3MTNjMjA2ZGNiZDU4NjZmNjdjZTc3OWYzMTVlOWUuY2FtZWxAZ214LmRlLwo+ICsgKgpQ
bGVhc2UgYXZvaWQgZXh0cmEgYmxhbmsgbGluZSBoZXJlLgo+ICsgKi8KPiArCj4gKyNkZWZpbmUg
X0dOVV9TT1VSQ0UKPiArI2luY2x1ZGUgPHN0ZGlvLmg+Cj4gKyNpbmNsdWRlIDxzaWduYWwuaD4K
PiArI2luY2x1ZGUgPHVuaXN0ZC5oPgo+ICsjaW5jbHVkZSA8c3lzL3R5cGVzLmg+Cj4gKyNpbmNs
dWRlIDxzeXMvd2FpdC5oPgo+ICsjaW5jbHVkZSA8c3RkbGliLmg+Cj4gKyNpbmNsdWRlIDxzY2hl
ZC5oPgo+ICsKPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gKwo+ICtzdGF0aWMgdW5zaWduZWQg
bG9uZyBsb29wID0gMTAwMDAwMDA7Ckl0J2QgYmUgbmljZSB0byBoYXZlIG9wdGlvbiB0byBydW4g
bGVzcyBpdGVyYXRpb25zLgo+ICsKPiArc3RhdGljIGludCB3YWl0X2Zvcl9waWQocGlkX3QgcGlk
KQo+ICt7Cj4gKwlpbnQgc3RhdHVzLCByZXQ7Cj4gKwo+ICthZ2FpbjoKPiArCXJldCA9IHdhaXRw
aWQocGlkLCAmc3RhdHVzLCAwKTsKPiArCWlmIChyZXQgPT0gLTEpIHsKPiArCQlpZiAoZXJybm8g
PT0gRUlOVFIpCj4gKwkJCWdvdG8gYWdhaW47Cj4gKwo+ICsJCXJldHVybiAtMTsKPiArCX0KPiAr
Cj4gKwlpZiAoV0lGU0lHTkFMRUQoc3RhdHVzKSkKPiArCQlyZXR1cm4gMDsKPiArCj4gKwlyZXR1
cm4gLTE7Cj4gK30KSSdtIG5vdCBzdXJlIGJ5IHRoaXMgcGFydC4gSSdkIGJlIGdvb2QgaWYgc29t
ZWJvZHkgZWxzZSByZXZpZXdlZCBpdC4KV2UgY2Fubm90IHVzZSB0c3RfcmVhcF9jaGlsZHJlbigp
LCBiZWNhdXNlIHdlIHdhbnQgdG8gYmUgc2lnbmFsZWQuCgo+ICsKPiArc3RhdGljIHZvaWQgc2V0
dXAodm9pZCkKPiArewo+ICsJY3B1X3NldF90IG1hc2s7Cj4gKwo+ICsJQ1BVX1pFUk8oJm1hc2sp
Owo+ICsKPiArCUNQVV9TRVQoMCwgJm1hc2spOwo+ICsKPiArCVRTVF9FWFBfUE9TSVRJVkUoc2No
ZWRfc2V0YWZmaW5pdHkoMCwgc2l6ZW9mKG1hc2spLCAmbWFzaykpOwo+ICt9Cj4gKwo+ICtzdGF0
aWMgdm9pZCBoYW5kbGVyKHZvaWQpCj4gK3sKPiArCWlmIChsb29wID4gMCkKPiArCQktLWxvb3A7
Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgY2hpbGQodm9pZCkKPiArewo+ICsJcGlkX3QgcHBpZCA9
IGdldHBwaWQoKTsKPiArCj4gKwlUU1RfQ0hFQ0tQT0lOVF9XQUlUKDApOwo+ICsKPiArCXdoaWxl
ICgxKQo+ICsJCWtpbGwocHBpZCwgU0lHVVNSMSk7ClNBRkVfS0lMTChwcGlkLCBTSUdVU1IxKSA/
Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIGRvX3Rlc3Qodm9pZCkKPiArewo+ICsJcGlkX3QgY2hp
bGRfcGlkOwo+ICsKPiArCWNoaWxkX3BpZCA9IFNBRkVfRk9SSygpOwo+ICsKPiArCWlmICghY2hp
bGRfcGlkKQo+ICsJCWNoaWxkKCk7Cj4gKwo+ICsJU0FGRV9TSUdOQUwoU0lHVVNSMSwgaGFuZGxl
cik7Cj4gKwlUU1RfQ0hFQ0tQT0lOVF9XQUtFKDApOwo+ICsKPiArCXdoaWxlIChsb29wKQo+ICsJ
CXNsZWVwKDEpOwo+ICsKPiArCWtpbGwoY2hpbGRfcGlkLCBTSUdURVJNKTsKPiArCVRTVF9FWFBf
UEFTUyh3YWl0X2Zvcl9waWQoY2hpbGRfcGlkKSk7Cj4gK30KPiArCj4gK3N0YXRpYyBzdHJ1Y3Qg
dHN0X3Rlc3QgdGVzdCA9IHsKPiArCS50ZXN0X2FsbCA9IGRvX3Rlc3QsCj4gKwkuc2V0dXAgPSBz
ZXR1cCwKPiArCS5mb3Jrc19jaGlsZCA9IDEsCj4gKwkubmVlZHNfY2hlY2twb2ludHMgPSAxLAo+
ICsJLm1heF9ydW50aW1lID0gMTIwLApBcmUgeW91IHN1cmUgMiBtaW4gaXMgZW5vdWdoPyBNYXli
ZSB3ZSBuZWVkIHRvIHVzZSB0c3RfcmVtYWluaW5nX3J1bnRpbWUoKSB0bwpjaGVjayBpZiB3ZSdy
ZSBub3QgcnVubmluZyBvdXQgb2YgdGltZS4KQWxzbywgaWYgd2Ugc2V0IGdldG9wdCB0byBjaG9v
c2UgbnVtYmVyIG9mIG9wdGlvbnMsIHdlJ2QgbmVlZCB0byBhZGp1c3QgaXQgYnkKdHN0X3NldF9t
YXhfcnVudGltZSgpLgoKS2luZCByZWdhcmRzLApQZXRyCgo+ICt9OwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
