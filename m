Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E5DC07548
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 08:23:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0482D3CC279
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 09:23:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CD633CC191
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 09:23:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5F7A608A99
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 09:23:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E5861F8B2;
 Wed, 15 Nov 2023 08:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700036601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32lzGuqWXg1H70rNy72zPEwYWPp8J918OmC+nK6txxI=;
 b=ttsyz+/U/UmW/oRRcT03dn5BKQT0M+v4wv5hT2R4TujnHvBvFXDPuVQnLhvDJubb9whEeW
 0a+VUciHTfQ6SiqaJnoEZM0npl7nHefUf1uktB4liaBxp9az2WRx/j+XdEpOBPYD8xoTk5
 olQAzB6bWSv5S+i2PmJFcaLldmwIkcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700036601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32lzGuqWXg1H70rNy72zPEwYWPp8J918OmC+nK6txxI=;
 b=FuOKRMzmlqj+Cwj5TFCTh84nEFTw6bhlWwOmiGA6zFktS2ei4Up9WkeH8F4/tcMmyETPsd
 xAkxUrvvzXsyCfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E3B513592;
 Wed, 15 Nov 2023 08:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AWWcFfl/VGW6DQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Nov 2023 08:23:21 +0000
Date: Wed, 15 Nov 2023 09:23:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: =?utf-8?B?5rKz5Y6f6aKv5aSq?= <souta.kawahara@miraclelinux.com>
Message-ID: <20231115082319.GA2404362@pevik>
References: <20231114123140.1144-1-mdoucha@suse.cz>
 <20231114123140.1144-6-mdoucha@suse.cz>
 <20231114153907.GA2357693@pevik>
 <CAC+q_wXvSSgeXWQNk7pbmEU5SbmvBvKtumtFB9io1wwFnXjwHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAC+q_wXvSSgeXWQNk7pbmEU5SbmvBvKtumtFB9io1wwFnXjwHQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-10.29 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-2.99)[-0.996]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] Add test for CVE 2023-31248
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

PiBIaSBNYXJ0aW4sIFBldHIuCgoKPiAyMDIz5bm0MTHmnIgxNeaXpSjmsLQpIDA6MzkgUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+OgoKPiA+IEhpIE1hcnRpbiwKCj4gPiAuLi4KPiA+ID4gKysr
IGIvdGVzdGNhc2VzL25ldHdvcmsvaXB0YWJsZXMvbmZ0MDIuYwo+ID4gLi4uCj4gPiA+ICsvKiBD
aGFpbiBjcmVhdGlvbiBhbmQgZGVsZXRpb24gY29uZmlnICovCj4gPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHRzdF9uZXRsaW5rX2F0dHJfbGlzdCBuZXdjaGFpbl9jb25maWdbXSA9IHsKPiA+ID4g
KyAgICAge05GVEFfVEFCTEVfTkFNRSwgVEFCTkFNRSwgc3RybGVuKFRBQk5BTUUpICsgMSwgTlVM
TH0sCj4gPiA+ICsgICAgIHtORlRBX0NIQUlOX05BTUUsIENIQUlOTkFNRSwgc3RybGVuKENIQUlO
TkFNRSkgKyAxLCBOVUxMfSwKPiA+ID4gKyAgICAge05GVEFfQ0hBSU5fSUQsICZjaGFpbl9pZCwg
c2l6ZW9mKGNoYWluX2lkKSwgTlVMTH0sCgo+ID4gVW5mb3J0dW5hdGVseSB0aGUgY3VycmVudCBv
bGRlc3QgZGlzdHJvcyAoTGVhcCA0MiBhbmQgVWJ1bnR1IEJpb25pYykgYXJlIHRvbyBvbGQKPiA+
IGZvciBORlRBX0NIQUlOX0lELCBORlRBX1JVTEVfQ0hBSU5fSUQsIGNvdWxkIHlvdSBwbGVhc2Ug
YWRkIHRoZW0gdG8gTEFQST8KCj4gSXQgd2FzIHRoZSBzYW1lIG9uIFJIRUw4IChhbmQvb3Igb3Ro
ZXIgY2xvbmUgT1MpLgoKPiBBbmQsIEkgd291bGQgbGlrZSB0byBzZWUgdGhpcyB0ZXN0IGFkZGVk
IHRvIHJ1bnRlc3QvY3ZlIGFuZCAuZ2l0aWdub3JlLgoKR29vZCBwb2ludCwgdGhhbmtzLiBNYXli
ZSBpdCBjb3VsZCBiZSBhbHNvIGluIHJ1bnRlc3QvbmV0LnRjcF9jbWRzLgoKPiA+ICsgICAgICAg
aWYgKHRzdF90YWludF9jaGVjaygpKSB7Cj4gPiArICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJ
TCwgIktlcm5lbCBpcyB2dWxuZXJhYmxlIik7Cj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOwo+
ID4gKyAgICAgICB9Cgo+IE5vdCBhIHByb2JsZW0gd2l0aCB0aGUgdGVzdCBpdHNlbGYgYnV0LCBJ
ZiBUQUlOVF9XIHdhcyBhbHJlYWR5IHNldCwKPiB0aGUgdGVzdCByZXBvcnQgVFBBU1MgYnkgbWlz
c3Rha2UuCj4gQmVsb3cgcGF0Y2ggbWFza3MgVEFJTlRfVyBpZiB0aGF0IHRhaW50IGZsYWcgd2Fz
IHNldCBiZWZvcmUgdGVzdCBzdGFydGVkLgoKPiBjb21taXQgZGU5YjVjMjYzNjIwNGFiMDZkYmIz
YzdkYzU3Mjk2ZDczYWM1NzJhYwo+IEF1dGhvcjogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhh
dC5jb20+Cj4gRGF0ZTogICBUdWUgQXByIDIxIDE0OjE1OjQ4IDIwMjAgKzAyMDAKCj4gICAgIGxp
YjogdHN0X3RhaW50OiBJZ25vcmUgV0FSTiB0YWludCBmbGFnIGlmIGFscmVhZHkgc2V0Cgo+ICAg
ICBUaGlzIGNvbW1pdCBjaGFuZ2VzIHRoZSBsaWJyYXJ5IHNvIHRoYXQgaXQgaWdub3JlcyB0aGUg
dGFpbnQgd2FybiBmbGFnCj4gICAgIGlmIGl0IHdhcyBzZXQgcHJpb3IgdG8gdGhlIHRlc3QgcnVu
LiBJdCB0dXJucyBvdXQgdGhhdCB0aGUgd2FybiB0YWludAo+ICAgICBmbGFnIGlzIG5vdCB3ZWxs
IGRlZmluZWQgYW5kIGNvdWxkIGJlIGVhc2lseSBzZXQgb24gYSBmcmVzaGx5IGJvb3RlZAo+ICAg
ICBrZXJuZWwgZm9yIGV4YW1wbGUgd2hlbiBidWdneSBCSU9TIGlzIGRldGVjdGVkLgoKPiAgICAg
T3RoZXIgcmVjZW50IGV4YW1wbGUgaXMgZGlzYWJsaW5nIGlwIGZvcndhcmQgb24ga3ZtIGd1ZXN0
czoKPiAgICAgICBodHRwczovL2dpdGh1Yi5jb20vY29udGFpbmVycy9saWJwb2QvaXNzdWVzLzU4
MTUKPiAgICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvYTQ3YjZhM2ItYzA2NC0y
ZjUzLTdjZjYtZDBkMDcyMGU5ZDk5QHJlZGhhdC5jb20vCgo+ICAgICBTaWduZWQtb2ZmLWJ5OiBD
eXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiAgICAgU2lnbmVkLW9mZi1ieTogSmFuIFN0
YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gICAgIENjOiBDaGFuZyBZaW4gPGN5aW5AcmVk
aGF0LmNvbT4KPiAgICAgUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoK
PiBkaWZmIC0tZ2l0IGEvbGliL3RzdF90YWludC5jIGIvbGliL3RzdF90YWludC5jCj4gaW5kZXgg
YTVkYmY3N2QyLi40OTE0NmFhY2IgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF90YWludC5jCj4gKysr
IGIvbGliL3RzdF90YWludC5jCj4gQEAgLTgyLDkgKzgyLDE0IEBAIHZvaWQgdHN0X3RhaW50X2lu
aXQodW5zaWduZWQgaW50IG1hc2spCj4gICAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJL
ZXJuZWwgaXMgdG9vIG9sZCBmb3IgcmVxdWVzdGVkIG1hc2siKTsKCj4gICAgICAgICB0YWludF9t
YXNrID0gbWFzazsKPiAtCj4gICAgICAgICB0YWludCA9IHRzdF90YWludF9yZWFkKCk7Cj4gLSAg
ICAgICBpZiAoKHRhaW50ICYgbWFzaykgIT0gMCkKPiArCj4gKyAgICAgICBpZiAodGFpbnQgJiBU
U1RfVEFJTlRfVykgewo+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRDT05GLCAiSWdub3Jpbmcg
YWxyZWFkeSBzZXQga2VybmVsIHdhcm5pbmcgdGFpbnQiKTsKPiArICAgICAgICAgICAgICAgdGFp
bnRfbWFzayAmPSB+VFNUX1RBSU5UX1c7Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgaWYgKCh0
YWludCAmIHRhaW50X21hc2spICE9IDApCj4gICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ss
ICJLZXJuZWwgaXMgYWxyZWFkeSB0YWludGVkOiAldSIsIHRhaW50KTsKPiAgfQoKPiBPdGhlciB0
ZXN0cyByZWx5IG9uIFRBSU5UX1cgdG8gZGVjaWRlIHRoZSByZXN1bHQgYWxzbyByZXBvcnQgVFBB
U1MgYnkKPiBtaXNzdGFrZSBpZiBUQUlOVF9XIHdhcyBhbHJlYWR5IHNldC4KPiBJbiBteSBwYXRj
aCB2MSBhYm91dCBDVkUtMjAyMy0zMTI0OCBjaGVjayBlcnJvciA9PSBFTk9FTlQuIEluIHRoaXMK
PiBjYXNlLCB0ZXN0IHJlcG9ydHMgY29ycmVjdCByZXN1bHQuCj4gSXQgbWF5IGJlIGRpZmZpY3Vs
dCB0byBpbXBsZW1lbnQgdGVzdCBsaWtlIHBhdGNoIHYxIHVzaW5nIHRoZSBpbnRlcm5hbAo+IHRz
dF9uZXRsaW5rIEFQSSwgYnV0IHdlIHNob3VsZCBiZSBhd2FyZSBvZiB0aGlzIGlzc3VlLgoKQ2Mg
SmFuLiBCdXQgaWYgSSByZWFkIGl0IGNvcnJlY3RseSBpZiB0aGUga2VybmVsIGlzIGFscmVhZHkg
dGFpbnRlZCB3aXRoClRBSU5UX1csIHRoaXMgZmxhZyBpcyBpbmRlZWQgc2tpcHBlZCwgYnV0IGl0
IGNhbiBzdGlsbCBiZSBkZXRlY3RlZCB2aWEKVFNUX1RBSU5UX0QgKG9vcHMpLgoKS2luZCByZWdh
cmRzLApQZXRyCgoKPiBCZXN0IHJlZ2FyZHMuCj4gU291dGEgS2F3YWhhcmEgPHNvdXRhLmthd2Fo
YXJhQG1pcmFjbGVsaW51eC5jb20+CgoKCj4gPiBPdGhlcndpc2UgdGhlIHBhdGNoc2V0IGxvb2tz
IG9rLgoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiAtLQo+ID4gTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
