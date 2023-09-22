Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F5CD4845
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 16:13:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2ECE3CDE61
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 18:13:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 583F73CB576
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 18:13:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63D07100B7BD
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 18:13:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC01F21D01;
 Fri, 22 Sep 2023 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695399185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bGASpT5K9ahvyetJpePPhA7+M6jfTyiHksc4/RYmDI=;
 b=OIFmKB610CCBRXh4/o8QPjrimFXBoveSvoHCyAR/TyJvAgxVBcuOTU2DQimW5D1yRInxxi
 rnEeD9fFC/qNVgM0OUhGqBVP8VDBUFSl1I6lzk6Qa05fYq3JiVboFJvD8Wsk04Sup7RHjR
 30YTyZfG1C3V+9ZFgwVDoFXizkTK5PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695399185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bGASpT5K9ahvyetJpePPhA7+M6jfTyiHksc4/RYmDI=;
 b=l1RGAmyrkeUUAxDBiNo7o1YZiAAP0zi1wgteYa/xnyAircy/wE+c+JY4yy67nGE06TCCab
 z501TitveyLm3HBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B633013478;
 Fri, 22 Sep 2023 16:13:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yCJWKxG9DWWHMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 22 Sep 2023 16:13:05 +0000
Date: Fri, 22 Sep 2023 18:13:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20230922161304.GA587441@pevik>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <CAEemH2fKvKrN_S1j34UpfzDpqob_sasuxGt8Ji81TkzEFpt_UQ@mail.gmail.com>
 <CAASaF6xMijTern9QA4B3zT93kDaZdxK_JMa=+bVMctOtdG5m7g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xMijTern9QA4B3zT93kDaZdxK_JMa=+bVMctOtdG5m7g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] Release scripts and docs
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmFuLCBMaSwKCj4gT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMTA6MTjigK9BTSBMaSBXYW5n
IDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cgo+ID4gSGkgUGV0ciwgQWxsLAoKPiA+IFRoYW5r
cyBmb3Igd3JpdGluZyBkb3duIHRoZSByZWxlYXNlIHByb2NlZHVyZSwgdmVyeSB1c2VmdWwuCgo+
ICsxIGZvciBoYXZpbmcgZG9jdW1lbnRlZCBzdGVwcwoKCj4gPiBCdXQgSSBkb3VidCB0aGF0IHdl
IHJlYWxseSBuZWVkIHRoZSBzY3JpcHRzIHRvIGRvIHJlbGVhc2Ugd29yawo+ID4gYXV0b21hdGlj
YWxseSBzaW5jZSB3ZSBfb25seV8gZG8gdGhlIHJlbGVhc2UgZXZlcnkgZm91ciBtb250aHMuCj4g
PiBJdCBzZWVtcyB0byBicmluZyBhZGRpdGlvbmFsIG1haW50ZW5hbmNlIHdvcmsgdW5uZWNlc3Nh
cmlseS4KCj4gPiBJIHBlcnNvbmFsbHkgdGhpbmsgdGhlIG1hbnVhbCBzdGVwIGlzIGRldGFpbGVk
IGVub3VnaCBmb3IgdXMuCj4gPiBCdXQgYW55d2F5LCBub3cgeW91IGhhdmUgZG9uZSB0aGUgYXV0
b21hdGlvbiwgSSBkb24ndCBoYXZlCj4gPiBhbiBvYmplY3Rpb24gdG8geW91ciBwYXRjaCBzZXQs
IGp1c3QgZmVlbCB0aGF0IHdlIGF1dG9tYXRlIGZvciB0aGUKPiA+IHNha2Ugb2YgYXV0b21hdGlv
biA6KS4KCj4gPiBJJ2QgbGlrZSB0byBoZWFyIG1vcmUgb3BpbmlvbnMsIGJ1dCBpZiBtb3N0IG9m
IHVzIHRoaW5rIHRoZSBzY3JpcHQgaXMKPiA+IG5lY2Vzc2FyeSwgSSdtIGhhcHB5IHRvIGFjY2Vw
dCB0aGVtIGFzIHdlbGwuCgo+IEFzIHNvbWVvbmUgd2hvIGhhc24ndCBkb25lIHJlbGVhc2UgYmVm
b3JlLCBJJ2QgcHJvYmFibHkgZG8gaXQKPiBtYW51YWxseSBmaXJzdC10aW1lIHRvIGRvdWJsZS1j
aGVjayBlYWNoIHN0ZXAuCgo+IEl0J3MgcHJvYmFibHkgbm90IG5lY2Vzc2FyeSwgYnV0IHBlb3Bs
ZSB3aG8gZGlkIHJlbGVhc2VzIG1hbnkgdGltZXMgbWF5Cj4gZmluZCBpdCB1c2VmdWwgLSBJJ20g
YXNzdW1pbmcgdGhlIHJlbGVhc2UgcHJvY2VkdXJlIGlzbid0IGNoYW5naW5nCj4gdGhhdCBmcmVx
dWVudGx5LgoKVGhhbmtzIGJvdGggZm9yIHlvdXIgaW5wdXQuCgpZZXMuIE1hbnVhbCBwcm9jZXNz
IGlzIGVycm9yIHByb25lLgoKQmVjYXVzZSBJIGRpZCB0YWdnaW5nIGFuZCB0YXJiYWxsIGdlbmVy
YXRpbmcgZm9yIGxhc3QgZmV3IHJlbGVhc2VzIEkgd2FudGVkIHRvCmF2b2lkIHJlLXJlYWRpbmcg
dGhlIGRvY3VtZW50YXRpb24gZHVyaW5nIGVhY2ggcmVsZWFzZSBhbmQgc3BlZWR1cCB0aGUgd2hv
bGUKcHJvY2Vzcy4gQmVjYXVzZSB0aGVyZSBpcyBhIGxvdCBvZiAibWFudWFsIiBjbGlja2luZyBl
dmVuIHdpdGhvdXQgaXQuCgpCVFcgdGhlIGNoYW5nZWxvZyBza2VsZXRvbiBzaG91bGQgYmUgc2Vw
YXJhdGVkIHRvIGJlIHVzZWZ1bCAoQ3lyaWwgZG9lcyBpdCkuCgpLaW5kIHJlZ2FyZHMsClBldHIK
Cj4gPiBPbiBXZWQsIFNlcCAyMCwgMjAyMyBhdCA1OjUz4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+IHdyb3RlOgoKPiA+PiBIaSwKCj4gPj4gY29weSBwYXN0aW5nIHJlbGVhc2UgaXMg
ZXJyb3IgcHJvbmUsIHRodXMgSSB3cm90ZSByZWxlYXNlIHNjcmlwdHMuCj4gPj4gQW55IGNoYW5n
ZSB5b3Ugd291bGQgaGF2ZSBsb29rIG9uIGl0IGJlZm9yZSByZWxlYXNlPwoKPiA+PiAyIGNvbW1p
dHMgd2VyZSBhbHJlYWR5IHBvc3RlZCBiZWZvcmUsIExpIGhhZCBzb21lIG5vdGVzIGFib3V0IHRo
ZQo+ID4+IHByb2NlZHVyZSwgdGh1cyBJIHVwZGF0ZWQgaXQuCgo+ID4+IEtpbmQgcmVnYXJkcywK
PiA+PiBQZXRyCgo+ID4+IFBldHIgVm9yZWwgKDUpOgo+ID4+ICAgdG9vbHM6IEFkZCBhIHNjcmlw
dCBmb3IgdGFnZ2luZyB0aGUgcmVsZWFzZQo+ID4+ICAgdG9vbHM6IEFkZCBzY3JpcHQgZm9yIGNy
ZWF0aW5nIHRhcmJhbGxzIGFuZCBtZXRhZGF0YQo+ID4+ICAgZG9jOiBSZW5hbWUgZmlsZXMgdG8g
bmFtZXMgZnJvbSBsdHAud2lraS5naXQKPiA+PiAgIGRvYzogQWRkIFJlbGVhc2UgcHJvY2VkdXJl
Cj4gPj4gICBkb2M6IFVwZGF0ZSByZWxlYXNlIHByb2NlZHVyZQoKPiA+PiAgLmdpdGh1Yi93b3Jr
Zmxvd3Mvd2lraS1taXJyb3IueW1sICAgICAgICAgICAgIHwgIDE2ICstLQo+ID4+ICAuLi5pbGQt
c3lzdGVtLWd1aWRlLnR4dCA9PiBCdWlsZC1TeXN0ZW0ucmVzdH0gfCAgIDAKPiA+PiAgZG9jL3tj
LXRlc3QtYXBpLnR4dCA9PiBDLVRlc3QtQVBJLmFzY2lpZG9jfSAgIHwgICAwCj4gPj4gIC4uLm1w
bGUudHh0ID0+IEMtVGVzdC1DYXNlLVR1dG9yaWFsLmFzY2lpZG9jfSB8ICAgMAo+ID4+ICAuLi4t
Yy1hcGkudHh0ID0+IEMtVGVzdC1OZXR3b3JrLUFQSS5hc2NpaWRvY30gfCAgIDAKPiA+PiAgLi4u
a3ZtLXRlc3QtYXBpLnR4dCA9PiBLVk0tVGVzdC1BUEkuYXNjaWlkb2N9IHwgICAwCj4gPj4gIC4u
LlAtTGlicmFyeS1BUEktV3JpdGluZy1HdWlkZWxpbmVzLmFzY2lpZG9jfSB8ICAgMAo+ID4+ICBk
b2MvTFRQLVJlbGVhc2UtUHJvY2VkdXJlLmFzY2lpZG9jICAgICAgICAgICAgfCAxMTYgKysrKysr
KysrKysrKysrKysrCj4gPj4gIC4uLmFpbnRhaW5lci1QYXRjaC1SZXZpZXctQ2hlY2tsaXN0LmFz
Y2lpZG9jfSB8ICAgMAo+ID4+ICAuLi5sLXRlc3QtYXBpLnR4dCA9PiBTaGVsbC1UZXN0LUFQSS5h
c2NpaWRvY30gfCAgIDAKPiA+PiAgLi4ua2VybmVsLC1saWJjLC10b29sY2hhaW4tdmVyc2lvbnMu
YXNjaWlkb2N9IHwgICAwCj4gPj4gIC4uLnMudHh0ID0+IFRlc3QtV3JpdGluZy1HdWlkZWxpbmVz
LmFzY2lpZG9jfSB8ICAgMAo+ID4+ICAuLi5zZXItZ3VpZGUudHh0ID0+IFVzZXItR3VpZGVsaW5l
cy5hc2NpaWRvY30gfCAgIDAKPiA+PiAgdG9vbHMvY3JlYXRlLXRhcmJhbGxzLW1ldGFkYXRhLnNo
ICAgICAgICAgICAgIHwgIDUyICsrKysrKysrCj4gPj4gIHRvb2xzL2xpYi5zaCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAzMSArKysrKwo+ID4+ICB0b29scy90YWctcmVsZWFz
ZS5zaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgODAgKysrKysrKysrKysrCj4gPj4gIDE2
IGZpbGVzIGNoYW5nZWQsIDI4MiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiA+PiAg
cmVuYW1lIGRvYy97YnVpbGQtc3lzdGVtLWd1aWRlLnR4dCA9PiBCdWlsZC1TeXN0ZW0ucmVzdH0g
KDEwMCUpCj4gPj4gIHJlbmFtZSBkb2Mve2MtdGVzdC1hcGkudHh0ID0+IEMtVGVzdC1BUEkuYXNj
aWlkb2N9ICgxMDAlKQo+ID4+ICByZW5hbWUgZG9jL3tjLXRlc3QtdHV0b3JpYWwtc2ltcGxlLnR4
dCA9PiBDLVRlc3QtQ2FzZS1UdXRvcmlhbC5hc2NpaWRvY30gKDEwMCUpCj4gPj4gIHJlbmFtZSBk
b2Mve25ldHdvcmstYy1hcGkudHh0ID0+IEMtVGVzdC1OZXR3b3JrLUFQSS5hc2NpaWRvY30gKDEw
MCUpCj4gPj4gIHJlbmFtZSBkb2Mve2t2bS10ZXN0LWFwaS50eHQgPT4gS1ZNLVRlc3QtQVBJLmFz
Y2lpZG9jfSAoMTAwJSkKPiA+PiAgcmVuYW1lIGRvYy97bGlicmFyeS1hcGktd3JpdGluZy1ndWlk
ZWxpbmVzLnR4dCA9PiBMVFAtTGlicmFyeS1BUEktV3JpdGluZy1HdWlkZWxpbmVzLmFzY2lpZG9j
fSAoMTAwJSkKPiA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvYy9MVFAtUmVsZWFzZS1Qcm9jZWR1
cmUuYXNjaWlkb2MKPiA+PiAgcmVuYW1lIGRvYy97bWFpbnRhaW5lci1wYXRjaC1yZXZpZXctY2hl
Y2tsaXN0LnR4dCA9PiBNYWludGFpbmVyLVBhdGNoLVJldmlldy1DaGVja2xpc3QuYXNjaWlkb2N9
ICgxMDAlKQo+ID4+ICByZW5hbWUgZG9jL3tzaGVsbC10ZXN0LWFwaS50eHQgPT4gU2hlbGwtVGVz
dC1BUEkuYXNjaWlkb2N9ICgxMDAlKQo+ID4+ICByZW5hbWUgZG9jL3tzdXBwb3J0ZWQta2VybmVs
LWxpYmMtdmVyc2lvbnMudHh0ID0+IFN1cHBvcnRlZC1rZXJuZWwsLWxpYmMsLXRvb2xjaGFpbi12
ZXJzaW9ucy5hc2NpaWRvY30gKDEwMCUpCj4gPj4gIHJlbmFtZSBkb2Mve3Rlc3Qtd3JpdGluZy1n
dWlkZWxpbmVzLnR4dCA9PiBUZXN0LVdyaXRpbmctR3VpZGVsaW5lcy5hc2NpaWRvY30gKDEwMCUp
Cj4gPj4gIHJlbmFtZSBkb2Mve3VzZXItZ3VpZGUudHh0ID0+IFVzZXItR3VpZGVsaW5lcy5hc2Np
aWRvY30gKDEwMCUpCj4gPj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSB0b29scy9jcmVhdGUtdGFyYmFs
bHMtbWV0YWRhdGEuc2gKPiA+PiAgY3JlYXRlIG1vZGUgMTAwNzU1IHRvb2xzL2xpYi5zaAo+ID4+
ICBjcmVhdGUgbW9kZSAxMDA3NTUgdG9vbHMvdGFnLXJlbGVhc2Uuc2gKCj4gPj4gLS0KPiA+PiAy
LjQwLjEKCgoKPiA+IC0tCj4gPiBSZWdhcmRzLAo+ID4gTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
