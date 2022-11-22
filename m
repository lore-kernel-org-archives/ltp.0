Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00791C433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 10:00:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0B053CCAF7
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 11:00:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E7043CCAB4
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 11:00:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F445200E0A
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 11:00:00 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C845F1F86C;
 Tue, 22 Nov 2022 09:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669111199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d63d2HM6Ug9nxDJJNk0Yy0Wk/erMD/oo9U66ME5Q2lE=;
 b=w2xkzgr4o3PWxwbPR+r+7NonIDo19cq03zVP+HPOYEdFPyFbSGmMCU67wsigE02ZN/ygSx
 rXaOpoRg5QpDIBz91uwJ2Yjufw82a8VRFj5nhE7JA+6jLUUaMWhtpxwBlapxRkdActQon/
 J/zCn2s6Z43tnXXRyEbvIQn2Dk0DSoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669111199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d63d2HM6Ug9nxDJJNk0Yy0Wk/erMD/oo9U66ME5Q2lE=;
 b=VlsCmajL1L25YBEhcPZmZNHUYa1+Qs0m332xdpWBAgIhzbEbAcnSt772kDdosb/weIYgkV
 NrJENsy7uT0mXlAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 870A12C142;
 Tue, 22 Nov 2022 09:59:59 +0000 (UTC)
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz> <Y3ZaOqpTvvBgUTTi@pevik>
 <20221121091438.qpx3u5vpdu5afucg@quack3> <Y3tF2XF1xVlOE3fA@pevik>
 <20221121095345.2m7aze7xtlmxb4hy@quack3> <87r0xwfk0m.fsf@suse.de>
 <Y3yFs2/jU1IBL+Xx@pevik>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Nov 2022 08:57:49 +0000
Organization: Linux Private Site
In-reply-to: <Y3yFs2/jU1IBL+Xx@pevik>
Message-ID: <87edtvfgww.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify10: Add support for multiple event
 files
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JpdGVzOgoKPj4gSGVsbG8sCj4K
Pj4gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JpdGVzOgo+Cj4+ID4gT24gTW9uIDIxLTExLTIy
IDEwOjMzOjEzLCBQZXRyIFZvcmVsIHdyb3RlOgo+PiA+PiBIaSBKYW4sIGFsbCwKPgo+PiA+PiA+
IE9uIFRodSAxNy0xMS0yMiAxNjo1ODo1MCwgUGV0ciBWb3JlbCB3cm90ZToKPj4gPj4gPiA+IEhp
IEphbiwgYWxsLAo+Cj4+ID4+ID4gPiA+ICsjZGVmaW5lIGZvcmVhY2hfcGF0aCh0YywgYnVmLCBw
bmFtZSkgXAo+PiA+PiA+ID4gPiArCWZvciAoaW50IHBpdGVyID0gMDsgZm9ybWF0X3BhdGhfY2hl
Y2soKGJ1ZiksICh0YyktPnBuYW1lIyNfZm10LAlcCj4+ID4+ID4gPiBVbmZvcnR1bmF0ZWx5IHdl
IHN0aWxsIHN1cHBvcnQgQzk5IGR1ZSBvbGQgY29tcGlsZXIgb24gQ2VudE9TIDcsCj4+ID4+ID4g
PiB0aGVyZWZvcmUgaW50IHBpdGVyIG5lZWRzIHRvIGJlIGRlZmluZWQgb3V0c2lkZSBvZiBmb3Ig
bG9vcC4KPgo+PiA+PiA+IEh1bSwgYnV0IHZhcmlhYmxlIGRlY2xhcmF0aW9uIGluIHRoZSBmb3Ig
bG9vcCBpcyBwYXJ0IG9mIEM5OSBzdGFuZGFyZCAoYXMKPj4gPj4gPiB0aGUgZXJyb3IgbWVzc2Fn
ZSBhbHNvIHNheXMpLiBTbyBkaWQgeW91IHdhbnQgdG8gc2F5IHlvdSBhcmUgY29tcGlsaW5nCj4+
ID4+ID4gYWdhaW5zdCBDODkgc3RhbmRhcmQ/IEFuZCBDZW50T1MgNyBzaGlwcyB3aXRoIEdDQyA0
LjguNSBBRkFJQ1Mgd2hpY2ggc2hvdWxkCj4+ID4+ID4gYmUgZnVsbHkgQzk5IGNvbXBsaWFudCBC
VFcuIFNvIHdoYXQncyB0aGUgc2l0dWF0aW9uIGhlcmU/Cj4+ID4+IEknbSBzb3JyeSwgSSBkaWRu
J3QgZXhwcmVzcyBjbGVhcmx5IG15c2VsZi4gWWVzLCA0LjguNSBzdXBwb3J0cyBDOTksCj4+ID4+
IGJ1dCB0aGUgZGVmYXVsdCBpcyBDOTAgWzFdLgo+Cj4+ID4gT0ssIHRoYW5rcyBmb3IgZXhwbGFu
YXRpb24uCj4KPj4gPj4gPiBUaGF0IGJlaW5nIHNhaWQgSSBjYW4gd29ya2Fyb3VuZCB0aGUgcHJv
YmxlbSBpbiB0aGUgbWFjcm8sIGl0IHdpbGwganVzdCBiZQo+PiA+PiA+IHNvbWV3aGF0IHVnbGll
ci4gU28gYmVmb3JlIGRvaW5nIHRoYXQgSSdkIGxpa2UgdG8gdW5kZXJzdGFuZCB3aGV0aGVyCj4+
ID4+ID4gZm9sbG93aW5nIEM4OSBpcyByZWFsbHkgcmVxdWlyZWQuLi4KPgo+PiA+PiBJJ20gZG9u
J3QgcmVtZW1iZXIgd2h5IHdlIGhhdmUganVzdCBub3Qgc3BlY2lmaWVkIC1zdGQ9Li4uIGFscmVh
ZHksIEN5cmlsIGhhZAo+PiA+PiBzb21lIG9iamVjdGlvbnMsIHRodXMgQ2MgaGltLgo+Cj4+ID4+
IENlbnQwUyBFT0wgaW4gMjAyNC0wNiwgd2UgbWlnaHQgcmVjb25zaWRlciB0byBhZGQgLXN0ZD0u
Li4gdG8gZW5kdXAgdGhpcyBhZ29ueQo+PiA+PiAoZXJyb3JzIGxpa2UgdGhpcyBvZnRlbiBuZWVk
IHRvIGJlIGZpeGVkKS4KPgo+PiA+PiBbMV0gaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2Nz
L2djYy00LjguNS9nY2MvU3RhbmRhcmRzLmh0bWwKPgo+PiA+IEdpdmVuIEN5cmlsJ3MgcmVwbHks
IHNob3VsZCBJIHJld29yayBteSBwYXRjaCBvciBhcmUgd2UgZmluZSB3aXRoIHVzaW5nCj4+ID4g
Qzk5Pwo+Cj4+IFdlbGwgLXN0ZD1jOTkgZG9lc24ndCB3b3JrLCBidXQgd2UgY2FuIHVzZSAtc3Rk
PWdudTk5LiBJZiB0aGF0IGRvZXNuJ3QKPj4gZml4IGl0IHRoZW4gd2Ugc2hvdWxkIGRyb3AgY2Vu
dG9zMDcgbm93IElNTy4KPiBJJ2QgYmUgb2sgdG8gcHV0IGZhbm90aWZ5MTA6IENGTEFHUyArPSAt
c3RkPWdudTk5IG9yIGV2ZW4gQ0ZMQUdTICs9IC1zdGQ9Z251OTkKPiAoZm9yIGFsbCB0ZXN0cykg
aW50byBmYW5vdGlmeSdzIE1ha2VmaWxlLCB3aGljaCBmaXhlcyB0aGUgcHJvYmxlbS4KPiBVbmxl
c3MgYW55Ym9keSBvYmplY3RzLCBJIGNhbiBjaGFuZ2UgaXQgYmVmb3JlIG1lcmdlLgoKV2UgZGVm
aW5pdGVseSBzaG91bGRuJ3QgZG8gdGhhdC4gV2UndmUgaGFkIHRoaXMgaXNzdWUgYmVmb3JlIGFu
ZCBpdCB3aWxsCmNvbWUgdXAgYWdhaW4uIFRoZW4gd2UnbGwgaGF2ZSBhIGJ1bmNoIG9mIHRlc3Rz
IHdpdGggdGhpcyBmbGFnIGFkZGVkLgoKPgo+IEBSaWNoaWU6IHdlIG5lZWQgdG8ga2VlcCBDZW50
MFMgNyB3b3JraW5nIHVudGlsIGl0cyBFT0wgaW4gMjAyNC0wNi4KCkl0IGFwcGVhcnMgdGhvdWdo
IHRoYXQgdGhleSBoYXZlIG5vdCB1cGRhdGVkIHRoZSBHQ0MgcGFja2FnZSBzaW5jZSAyMDE0LgoK
SXQgbG9va3MgbGlrZSBnbGliYyBhbmQgdGhlIGtlcm5lbCByZWNlaXZlIHVwZGF0ZXMuIFNvIGl0
J3MgZmVhc2libGUKc29tZW9uZSBpcyBydW5uaW5nIExUUCBvbiBDZW50b3M3LiBIb3dldmVyIGZv
ciBTTEVTIHZlcnNpb25zIHRoaXMgb2xkIHdlCihzdGF0aWNhbGx5KSBjb21waWxlIG9uIGEgbmV3
ZXIgcmVsZWFzZSBvciBpbnN0YWxsIGEgbmV3ZXIgR0NDIHBhY2thZ2UKZXRjLiBPciBpbiB0aGlz
IGNhc2UgeW91IGNvdWxkIGV2ZW4ganVzdCBhZGRlZCAnLXN0ZD1nbnU5OScgdG8gdGhlIG1ha2UK
Y29tbWFuZCBvbiBDZW50b3M3LgoKU28gSSBoYXZlIHRvIHF1ZXN0aW9uIHdoZXRoZXIgd2Ugc2hv
dWxkIHN1cHBvcnQgY29tcGlsYXRpb24gb24gdGFyZ2V0cwp0aGlzIG9sZCB0byB0aGUgZXh0ZW50
IHRoYXQgd2UgZG8/IEknZCByYXRoZXIgdHJ5IHRvIHN1cHBvcnQgbW9yZQpkaXN0cm8ncyAoZS5n
LiBidWlsZHJvb3QsIG5peG9zKSBvciBuZXcgY29tcGlsZXJzIChlLmcuIGFyb2NjKSB0aGF0CnBv
dGVudGlhbGx5IHdpbGwgaGVscCB3aXRoIGRldmVsb3BtZW50LgoKSSBkb24ndCB0aGluayB3ZSBz
aG91bGQgbWFrZSBpdCBpbXBvc3NpYmxlIHRvIHVzZSBvbGRlciBkaXN0cm9zLCBidXQgd2UKc2hv
dWxkIG9mZmxvYWQgc29tZSB3b3JrIG9udG8gZG93bnN0cmVhbS4gVGhlIGV4cGVjdGVkIHJlc3Vs
dCBvZgpzdGlja2luZyB3aXRoIG9sZGVyIHJlbGVhc2VzIGlzIHRoYXQgYmFja3BvcnRzIGFuZCB0
d2Vha3MgYXJlIHJlcXVpcmVkLgoKQ2VudE9TIFN0cmVhbSA4IGlzIG9uIEdDQyA4IGFuZCBTdHJl
YW0gOSBoYXMgR0NDIDExLCB3aHkgbm90IHB1dCB0aGF0IGluCkNJPwoKPgo+IEkgZ3Vlc3MgdGhl
IHJlYXNvbiBub3QgdG8gc3BlY2lmeSBpdCBpbiB0b3AgbGV2ZWwgTWFrZWZpbGUgd2FzIHRvIGhh
dmUgTFRQIGNvZGUKPiBiZWluZyB0ZXN0ZWQgb24gbmV3ZXIgc3RhbmRhcmRzLiBVbmxlc3MgdGhl
cmUgaXMgYSBnb29kIHJlYXNvbiBmb3IgaXQsIEknZCB2b3RlCj4gZm9yIHB1dHRpbmcgLXN0ZD1n
bnU5OSBpbnRvIHRvcCBsZXZlbCBDRkxBR1MgKGFuZCBpbmNyZWFzZSBpdCBhZnRlcgo+IENlbnRP
UyA3IEVPTCkuCgpZb3UgY291bGQgbWVyZ2UgbXkgcGF0Y2ggd2l0aCB0aGlzIG9uZS4KCj4KPiBL
aW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4+ID4gCQkJCQkJCQlIb256YQo+Cj4+ID4+ID4gPiBmYW5v
dGlmeTEwLmM6NDcwOjI6IGVycm9yOiDigJhmb3LigJkgbG9vcCBpbml0aWFsIGRlY2xhcmF0aW9u
cyBhcmUgb25seSBhbGxvd2VkIGluIEM5OSBtb2RlCj4+ID4+ID4gPiAgIGZvciAoaW50IHBpdGVy
ID0gMDsgZm9ybWF0X3BhdGhfY2hlY2soKGJ1ZiksICh0YyktPnBuYW1lIyNfZm10LCBcCj4+ID4+
ID4gPiAgIF4KPgo+PiA+PiA+ID4gZmFub3RpZnkxMC5jOjQ3MDoxMTogZXJyb3I6IHJlZGVmaW5p
dGlvbiBvZiDigJhwaXRlcuKAmQo+PiA+PiA+ID4gICBmb3IgKGludCBwaXRlciA9IDA7IGZvcm1h
dF9wYXRoX2NoZWNrKChidWYpLCAodGMpLT5wbmFtZSMjX2ZtdCwgXAo+PiA+PiA+ID4gICAgICAg
ICAgICBeCj4+ID4+ID4gPiBLaW5kIHJlZ2FyZHMsCj4+ID4+ID4gPiBQZXRyCgoKLS0gClRoYW5r
IHlvdSwKUmljaGFyZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
