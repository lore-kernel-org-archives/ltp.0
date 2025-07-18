Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30238C83F17
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 10:31:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E00C3CC62B
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 12:31:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B79E73CC409
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 12:31:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C24FA1A00EA7
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 12:31:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 77B14211D1;
 Fri, 18 Jul 2025 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752834680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLjONwMdiIgyLHYgHhNNqzuLrvwGJB3Fg1xW+b9MgdQ=;
 b=YwREFDdyvKmOZGk7BvWj3NGx9M5vhcnRVwkfr4zAYZGtscjaXZLxGSIB3Dg6xklKc/VHoK
 8qnwF6Iup227YxV+Ub3fd9ROaDBRzn86pZl3k37KK6UHr3P0BRD3+big1DebRcMsLYx9dB
 UcRgtigyiw4vhAatWFp3mO+biIeOT0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752834680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLjONwMdiIgyLHYgHhNNqzuLrvwGJB3Fg1xW+b9MgdQ=;
 b=mXuILY/VEbpiPJUisSgT0aG5D2E38OK/tJjYFRgw2Ew5gtFnBZiiFXk3wlVgpxVjl/BA2b
 hR5+WHNKSNRxvQCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752834680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLjONwMdiIgyLHYgHhNNqzuLrvwGJB3Fg1xW+b9MgdQ=;
 b=YwREFDdyvKmOZGk7BvWj3NGx9M5vhcnRVwkfr4zAYZGtscjaXZLxGSIB3Dg6xklKc/VHoK
 8qnwF6Iup227YxV+Ub3fd9ROaDBRzn86pZl3k37KK6UHr3P0BRD3+big1DebRcMsLYx9dB
 UcRgtigyiw4vhAatWFp3mO+biIeOT0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752834680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLjONwMdiIgyLHYgHhNNqzuLrvwGJB3Fg1xW+b9MgdQ=;
 b=mXuILY/VEbpiPJUisSgT0aG5D2E38OK/tJjYFRgw2Ew5gtFnBZiiFXk3wlVgpxVjl/BA2b
 hR5+WHNKSNRxvQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56D7313A52;
 Fri, 18 Jul 2025 10:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id or5RFHgiemiwbQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Jul 2025 10:31:20 +0000
Date: Fri, 18 Jul 2025 12:31:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250718103119.GA1414439@pevik>
References: <20250718090523.1411073-1-pvorel@suse.cz>
 <CAEemH2eeyE4Lt5HEXSoQVo9fVmgyJxQgZau29gMOTibDSXHDxw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eeyE4Lt5HEXSoQVo9fVmgyJxQgZau29gMOTibDSXHDxw@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] getrlimit03: Simplify TCONF code
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
Cc: Steve Muckle <smuckle@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksIGFsbCwKClsgQ2MgYWxzbyBTdGV2ZSBdCgo+IEhpIFBldHIsCgo+IE9uIEZyaSwgSnVs
IDE4LCAyMDI1IGF0IDU6MDXigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6
Cgo+ID4gRU5PU1lTIGNoZWNrcyBhZGRlZCBpbiBmYWM3ODNiNWQ2IGFuZCBkMDcxZGUwMmU4IGFy
ZSB2ZXJib3NlLCB1c2UKPiA+IHRzdF9zeXNjYWxsKCkgdG8gaGFuZGxlIEVOT1NZUy4KCj4gPiBB
bHNvIGNoZWNrIGZvciBfX05SX2dldHJsaW1pdCBjYXVzZWQgVENPTkYgbWVzc2FnZSBiZWluZyBw
cmludGVkIG1vcmUKPiA+IHRpbWVzIChSTElNX05MSU1JVFMgPT4gMTYgb24geDg2XzY0KSwgd2hp
Y2ggaXMgYWxzbyBmaXhlZCBieSB1c2luZwo+ID4gdHN0X3N5c2NhbGwoKS4KCj4gPiBCZWNhdXNl
IGl0IHNob3VsZCBiZSBzYWZlIHRvIG5vdCB1c2Ugc3BlY2lmaWMgZXJybm8gdmFyaWFibGVzIHJl
bW92ZQo+ID4gZXJybm9fbCBhbmQgZXJybm9fdWwuCgo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiAtLS0KPiA+IEhpIGFsbCwKCj4gPiBAVGllemh1IGNh
biB5b3UgcGxlYXNlIHRlc3QgdGhpcyBwYXRjaD8KPiA+IEBMaSBIb3BlIEkgZGlkIG5vdCBvdmVy
bG9vayBhbnl0aGluZy4KCj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQZXRyCgo+ID4gIC4uLi9rZXJu
ZWwvc3lzY2FsbHMvZ2V0cmxpbWl0L2dldHJsaW1pdDAzLmMgICB8IDIzICsrKystLS0tLS0tLS0t
LS0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSkKCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRybGltaXQv
Z2V0cmxpbWl0MDMuYwo+ID4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJsaW1pdC9n
ZXRybGltaXQwMy5jCj4gPiBpbmRleCA4NDZlZjNjZWQ2Li5hMmRkMGNhNzljIDEwMDY0NAo+ID4g
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRybGltaXQvZ2V0cmxpbWl0MDMuYwo+
ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRybGltaXQvZ2V0cmxpbWl0MDMu
Ywo+ID4gQEAgLTc3LDcgKzc3LDcgQEAgc3RydWN0IHJsaW1pdF91bG9uZyB7Cgo+ID4gIHN0YXRp
YyBpbnQgZ2V0cmxpbWl0X3Vsb25nKGludCByZXNvdXJjZSwgc3RydWN0IHJsaW1pdF91bG9uZyAq
cmxpbSkKPiA+ICB7Cj4gPiAtICAgICAgIHJldHVybiBzeXNjYWxsKF9fTlJfZ2V0cmxpbWl0X3Vs
b25nLCByZXNvdXJjZSwgcmxpbSk7Cj4gPiArICAgICAgIHJldHVybiB0c3Rfc3lzY2FsbChfX05S
X2dldHJsaW1pdF91bG9uZywgcmVzb3VyY2UsIHJsaW0pOwo+ID4gIH0KCj4gPiAgY29uc3QgbG9u
ZyBSTElNX0lORklOSVRZX0wgPSBMT05HX01BWDsKPiA+IEBAIC05MCw3ICs5MCw3IEBAIHN0cnVj
dCBybGltaXRfbG9uZyB7Cgo+ID4gIHN0YXRpYyBpbnQgZ2V0cmxpbWl0X2xvbmcoaW50IHJlc291
cmNlLCBzdHJ1Y3QgcmxpbWl0X2xvbmcgKnJsaW0pCj4gPiAgewo+ID4gLSAgICAgICByZXR1cm4g
c3lzY2FsbChfX05SX2dldHJsaW1pdCwgcmVzb3VyY2UsIHJsaW0pOwo+ID4gKyAgICAgICByZXR1
cm4gdHN0X3N5c2NhbGwoX19OUl9nZXRybGltaXQsIHJlc291cmNlLCBybGltKTsKCgo+IEkgZ3Vl
c3MgYXQgbGVhc3Qgd2Ugc2hvdWxkIGF2b2lkIHVzaW5nIHRzdF9zeXNjYWxsKCkgaW4gZ2VybGlt
aXRfbG9uZywKPiBiZWNhdXNlIGl0IHdpbGwgbWlzcyAoYnJlYWsgd2l0aCBUQ09ORikgdGhlIG5l
eHQgZ2V0cmxpbWl0X3Vsb25nIHRlc3RzCj4gd2hlbiBydW5uaW5nIGFuIGFhcmNoMzIgdXNlciBi
aW5hcnkgb24gNjRiaXQga2VybmVsOgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXBy
b2plY3QvbHRwL2NvbW1pdC9mYWM3ODNiNWQ2NjMxZWZhNzBkMmVhMzI1NzE0Mjc2M2Q5NDRiYTMy
CgpUaGFua3MsIEkgZGlkIG1pc3MgdGhlIHBvaW50IG9mIHRoaXMgY29tbWl0IHdoZW4gSSBsb29r
ZWQgaW50byBpdCBlYXJsaWVyLgpSZWFkaW5nIGFnYWluIHRoZSBjb2RlIGFuZCBjb21taXQgbWVz
c2FnZXMgb2YgYm90aCBjb21taXRzLgoKSSBzdXBwb3NlIHlvdSdyZSByaWdodCBpdCdzIHNhZmUg
dG8gcXVpdCBnZXRybGltaXRfdWxvbmcoKSB2aWEgdHN0X3N5c2NhbGwoKQpiZWNhdXNlIGl0J3Mg
ZWl0aGVyIG9sZCBhcmNoIHdoaWNoIGhhcyBhbHdheXMgZ2V0cmxpbWl0KCkgc3lzY2FsbCBvciBu
ZXcgYXJjaAp3aGljaCBoYXMgYWx3YXlzIHVnZXRybGltaXQoKSBzeXNjYWxsLiBJbiB0aGF0IGNh
c2Ugd2UgY2FuIGxlYXZlIHRoZSBjb2RlIGFzIGlzCm9yIGFkZCB0c3Rfc3lzY2FsbCgpIHRvIGdl
dHJsaW1pdF91bG9uZygpICsgZXhwbGFuYXRpb24gYXQgZ2VybGltaXRfbG9uZygpIHdoeQp0c3Rf
c3lzY2FsbCgpIGlzIG5vdCB1c2VkLgoKQW5kIGlmIEknbSB3cm9uZyBhbmQgaXQncyBub3Qgc2Fm
ZSB0byBxdWl0IGdldHJsaW1pdF91bG9uZygpIHdpdGggdHN0X3N5c2NhbGwoKSwKdGhlbiB3ZSBz
aG91bGQgcmVtb3ZlIHRlc3QudGNudCA9IDEgYWRkZWQgcmVjZW50bHkuCgpLaW5kIHJlZ2FyZHMs
ClBldHIKCj4gPiAgfQo+ID4gICNlbmRpZgoKPiA+IEBAIC0xNDcsMTIgKzE0NywxMCBAQCBzdGF0
aWMgdm9pZCBydW4odW5zaWduZWQgaW50IHJlc291cmNlKQoKPiA+ICAgICAgICAgc3RydWN0IHJs
aW1pdF91bG9uZyBybGltX3VsOwo+ID4gICAgICAgICBpbnQgcmV0X3VsOwo+ID4gLSAgICAgICBp
bnQgZXJybm9fdWw7Cgo+ID4gICNpZmRlZiBTSUdORURfR0VUUkxJTUlUCj4gPiAgICAgICAgIHN0
cnVjdCBybGltaXRfbG9uZyBybGltX2w7Cj4gPiAgICAgICAgIGludCByZXRfbDsKPiA+IC0gICAg
ICAgaW50IGVycm5vX2w7Cj4gPiAgI2VuZGlmCgo+ID4gICAgICAgICBlcnJubyA9IDA7Cj4gPiBA
QCAtMTYxLDE1ICsxNTksOCBAQCBzdGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50IHJlc291cmNl
KQoKPiA+ICAgICAgICAgZXJybm8gPSAwOwo+ID4gICAgICAgICByZXRfdWwgPSBnZXRybGltaXRf
dWxvbmcocmVzb3VyY2UsICZybGltX3VsKTsKPiA+IC0gICAgICAgZXJybm9fdWwgPSBlcnJubzsK
PiA+IC0gICAgICAgaWYgKGVycm5vX3VsID09IEVOT1NZUykgewo+ID4gLSAgICAgICAgICAgICAg
IHRzdF9yZXMoVENPTkYgfCBURVJSTk8sCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAiJXMg
bm90IGltcGxlbWVudGVkIiwgX19OUl9nZXRybGltaXRfdWxvbmdfc3RyKTsKPiA+IC0gICAgICAg
ICAgICAgICB0ZXN0LnRjbnQgPSAxOwo+ID4gLSAgICAgICAgICAgICAgIHJldHVybjsKPiA+IC0g
ICAgICAgfQoKPiA+IC0gICAgICAgaWYgKGNvbXBhcmVfcmV0dmFsKHJlc291cmNlLCByZXRfdTY0
LCBlcnJub191NjQsIHJldF91bCwgZXJybm9fdWwsCj4gPiArICAgICAgIGlmIChjb21wYXJlX3Jl
dHZhbChyZXNvdXJjZSwgcmV0X3U2NCwgZXJybm9fdTY0LCByZXRfdWwsIGVycm5vLAo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgX19OUl9nZXRybGltaXRfdWxvbmdfc3RyKSB8fAo+ID4g
ICAgICAgICAgICAgY29tcGFyZV91NjRfdWxvbmcocmVzb3VyY2UsIHJsaW1fdTY0LnJsaW1fY3Vy
LAo+ID4gcmxpbV91bC5ybGltX2N1ciwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJybGltX2N1ciIpIHx8Cj4gPiBAQCAtMTgzLDE0ICsxNzQsOCBAQCBzdGF0aWMgdm9pZCBydW4o
dW5zaWduZWQgaW50IHJlc291cmNlKQo+ID4gICNpZmRlZiBTSUdORURfR0VUUkxJTUlUCj4gPiAg
ICAgICAgIGVycm5vID0gMDsKPiA+ICAgICAgICAgcmV0X2wgPSBnZXRybGltaXRfbG9uZyhyZXNv
dXJjZSwgJnJsaW1fbCk7Cj4gPiAtICAgICAgIGVycm5vX2wgPSBlcnJubzsKPiA+IC0gICAgICAg
aWYgKGVycm5vX2wgPT0gRU5PU1lTKSB7Cj4gPiAtICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09O
RiB8IFRFUlJOTywKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICJfX05SX2dldHJsaW1pdCgl
ZCkgbm90IGltcGxlbWVudGVkIiwKPiA+IF9fTlJfZ2V0cmxpbWl0KTsKPiA+IC0gICAgICAgICAg
ICAgICByZXR1cm47Cj4gPiAtICAgICAgIH0KCj4gPiAtICAgICAgIGlmIChjb21wYXJlX3JldHZh
bChyZXNvdXJjZSwgcmV0X3U2NCwgZXJybm9fdTY0LCByZXRfbCwgZXJybm9fbCwKPiA+ICsgICAg
ICAgaWYgKGNvbXBhcmVfcmV0dmFsKHJlc291cmNlLCByZXRfdTY0LCBlcnJub191NjQsIHJldF9s
LCBlcnJubywKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJfX05SX2dldHJsaW1pdCIp
IHx8Cj4gPiAgICAgICAgICAgICBjb21wYXJlX3U2NF9sb25nKHJlc291cmNlLCBybGltX3U2NC5y
bGltX2N1ciwgcmxpbV9sLnJsaW1fY3VyLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAicmxpbV9jdXIiKSB8fAo+ID4gLS0KPiA+IDIuNTAuMAoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
