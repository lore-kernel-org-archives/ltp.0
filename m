Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320B3EB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 09:44:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CE063CDC95
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 11:43:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AF863C8524
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 11:43:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B41C710001A1
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 11:43:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 80DEE219C3;
 Thu, 20 Jul 2023 09:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689846225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJ69L1u4UQZl9brSiEmO+rHdJR2dcx433s3M8aYKCjI=;
 b=AU+4Kql0E5lIVG7o65MRDWpYSxzmfZvXH6uU31jBsT4V/dDAy6UpIy2M50aOD7RBVAyt77
 J4HhOJFodNd7xbXlQW3QeCco768zIFD3G5QpLLFupGqtKZWLD8vaQRf+5SLPBDHSA8khR/
 NjA5XmqwKbcrlVbsRhfiRWY4gFvbAQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689846225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJ69L1u4UQZl9brSiEmO+rHdJR2dcx433s3M8aYKCjI=;
 b=Skd+TVkKv1rRUmfYoAlH5W+5uSW0uco7JUlDBSu8mYWjuE+ZGMB4hjvRxlOFU0+eqGDj2h
 gzzfnAv3BaWL07Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FB5F138EC;
 Thu, 20 Jul 2023 09:43:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IQ3iBNEBuWRJTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jul 2023 09:43:45 +0000
Date: Thu, 20 Jul 2023 11:43:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230720094343.GA1300426@pevik>
References: <20230718100050.1162482-1-pvorel@suse.cz>
 <CAEemH2fAuHrE4XyBjpudMCJJ4ZJ+9TOu=LpHXzizUp-uRqWXdA@mail.gmail.com>
 <20230719101225.GB1221211@pevik>
 <CAEemH2esxksDg1NznrCW4QKO3NvEFUENWVcc4s-jf+Yk1-_RHw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2esxksDg1NznrCW4QKO3NvEFUENWVcc4s-jf+Yk1-_RHw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] compat_16: Define USE_LEGACY_COMPAT_16_H for
 legacy tests
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
Cc: ltp@lists.linux.it,
 Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBQZXRyLAoKPiBPbiBXZWQsIEp1bCAxOSwgMjAyMyBhdCA2OjEy4oCvUE0gUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLAoKPiA+IC4uLgo+ID4gPiBJJ20g
bm90IHN1cmUgaGVyZSBpZiB3ZSByZWFsbHkgbmVlZCBDT01QQVRfMTZfSCBmb3IgY2hvb3Npbmcg
dHdvIGNvbXBhdAo+ID4gPiBoZWFkZXIgZmlsZS4KPiA+ID4gQXMgd2UgYWxyZWFkeSB1c2UgaGFy
ZCBjb2RlIGluIEMgc291cmNlIGZpbGUgbGlrZSAjaW5jbHVkZSAiY29tcGF0XzE2LmgiCj4gPiBv
cgo+ID4gPiAiY29tcGF0X3RzdF8xNi5oIiwKPiA+ID4gc28gY29tcGlsZSB3aXRoIC1JIHRoZSBo
ZWFkZXIgZGlyZWN0b3J5IGlzIGVub3VnaCBJIGd1ZXNzLgoKPiA+ID4gVHJ5IHRoaXMgc2ltcGxl
IGNvbXBhdF8xNi5taywgaXQgYXQgbGVhc3Qgd29ya3Mgd2VsbCBvbiBteSBzaWRlLgo+ID4gPiBP
ciwgZGlkIEkgbWlzcyBhbnl0aGluZyBpbiB0aGUgMTZiaXQgY29tcGlsYXRpb24/Cgo+ID4gSSBs
aWtlIHRoaXMgc2ltcGxpZmljYXRpb24uCgo+ID4gV2VsbCwgdG91Y2ggY29tcGF0XzE2LmggY2F1
c2VzIHJlYnVpbGRpbmcgdGVzdHMgd2hpY2ggdXNlIGNvbXBhdF90c3RfMTYuaC4KPiA+IEkgZG9u
J3QgbWluZCB0aGF0LiBCdXQgT1RPSCB0b3VjaCBjb21wYXRfdHN0XzE2LmggZG9lcyBub3QgdHJp
Z2dlcgo+ID4gcmVidWlsZGluZwo+ID4gdGVzdHMgd2hpY2ggdXNlIGNvbXBhdF90c3RfMTYuaCA6
KCAodGVzdGVkIG9uCj4gPiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHJlZ2lkKS4gQ291
bGQgeW91IHBsZWFzZSByZWNoZWNrIHRoYXQ/CgoKPiBHb29kIHBvaW50LCBJIG92ZXJsb29rZWQg
dGhlIHByZXJlcXVpc2l0ZSBmb3IgdGhlIHRhcmdldCBidWlsZCwgc28gaXQgbmVlZHMKPiBhZGRp
bmcgYmFjay4KCj4gQnV0IHdlIGRvbid0IGhhdmUgdGhlIG5lY2Vzc2FyeSB0byBrZWVwIElOVEVS
TUVESUFURSBvYmplY3Qgc3ludGF4LgoKPiBEZWxldGUgc29tZSBsaW5lcyBiYXNlZCBvbiB5b3Vy
IHBhdGNoOgoKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3V0aWxzL2NvbXBhdF8x
Ni5tawo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbHMvY29tcGF0XzE2Lm1r
Cj4gQEAgLTUzLDExICs1Myw4IEBAIENQUEZMQUdTICAgICAgICAgICAgICs9IC1JJChhYnNfc3Jj
ZGlyKQo+IC1JJChhYnNfc3JjZGlyKS8uLi91dGlscwo+ICBTUkNTICAgICAgICAgICAgICAgICAg
ID89ICQoc29ydCAkKHdpbGRjYXJkICQoYWJzX3NyY2RpcikvKi5jKSkKCj4gIE1BS0VfVEFSR0VU
UyAgICAgICAgICAgOj0gJChub3RkaXIgJChwYXRzdWJzdCAlLmMsJSwkKFNSQ1MpKSkKPiAtTUFL
RV9UQVJHRVRTX09CSlNfV09fQ09NUEFUXzE2IDo9ICQoYWRkc3VmZml4IC5vLCQoTUFLRV9UQVJH
RVRTKSkKPiAgTUFLRV9UQVJHRVRTICAgICAgICAgICArPSAkKGFkZHN1ZmZpeCBfMTYsJChNQUtF
X1RBUkdFVFMpKQoKPiAtIyBYWFggKGdhcnJjb29wKTogVGhpcyBjb2RlIHNob3VsZCBiZSBwdXQg
aW4gcXVlc3Rpb24gYXMgaXQgY2Fubm90IGJlCj4gYXBwbGllZAo+IC0jIChubyAuaCBmaWxlLCBu
byBUU1RfVVNFX05FV0VSNjRfU1lTQ0FMTCBkZWYpLgo+ICBERUZfMTYgICAgICAgICAgICAgICAg
IDo9IFRTVF9VU0VfQ09NUEFUMTZfU1lTQ0FMTAoKPiAgaWZlcSAoJChVU0VfTEVHQUNZX0NPTVBB
VF8xNl9IKSwxKQo+IEBAIC02NiwxMyArNjMsNyBAQCBlbHNlCj4gIENPTVBBVF8xNl9IICAgICA6
PSAkKGFic19zcmNkaXIpLy4uL3V0aWxzL2NvbXBhdF90c3RfMTYuaAo+ICBlbmRpZgoKPiAtaWZu
ZXEgKCQod2lsZGNhcmQgJChDT01QQVRfMTZfSCkpLCkKPiAtJChNQUtFX1RBUkdFVFNfT0JKU19X
T19DT01QQVRfMTYpOiAkKENPTVBBVF8xNl9IKQo+IC0uSU5URVJNRURJQVRFOiAkKE1BS0VfVEFS
R0VUU19PQkpTX1dPX0NPTVBBVF8xNikKPiAtZW5kaWYKPiAtCj4gICVfMTY6IENQUEZMQUdTICs9
IC1EJChERUZfMTYpPTEKPiAtIyBYWFggKGdhcnJjb29wKTogRW5kIHNlY3Rpb24gb2YgY29kZSBp
biBxdWVzdGlvbi4uCgo+ICAlXzE2Lm86ICUuYyAkKENPTVBBVF8xNl9IKQo+ICAgICAgICAgJChD
T01QSUxFLmMpICQoT1VUUFVUX09QVElPTikgJDwKCkxHVE0sIHdvdWxkIHlvdSBtaW5kIHRvIHNl
bmQgaXQgYXMgYSBmb2xsb3cgdXAgdG8gbXkgcGF0Y2gsIGFzIGFuIGFkZGl0aW9uYWwKY2xlYW51
cD8KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
