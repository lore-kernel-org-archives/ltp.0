Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF92C433FE
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 11:04:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 690F73CD147
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 12:04:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 497703C2306
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 12:04:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C3CDE140004D
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 12:04:00 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DD0E21F8C5
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668510239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d89HWGNVmdPAk/ASyu7nzR6V+Ls89ypQKSfh25Qdi3Q=;
 b=pNiqI8+7oOuN6on32GGcwpWzd3bG0e7nLEz16TXVNeNEYg5XbO7Z3ANoacnt7blj3R1rdt
 qcUvKhR6/yCRKt5gV/nwPKg1VJGSWRaMFs3qDjQsZoCFftFmXTDraBfCd4+RpjBg/ECTge
 dsO7VTe9lQf46CxhTgAXshLqGwiJGH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668510239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d89HWGNVmdPAk/ASyu7nzR6V+Ls89ypQKSfh25Qdi3Q=;
 b=6ZMHJW72FI8cZoJ1Tq6RgedkvfTZLcQFWuCVKNS/J63bCe9a6zVqIgW9sSp4I0e+7K0h6/
 IFOnRZWjPUE9paCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A92C02C142;
 Tue, 15 Nov 2022 11:03:59 +0000 (UTC)
References: <20221114093233.4668-1-mdoucha@suse.cz> <Y3JBzeBst/HufYqu@yuki>
 <7d899a16-7b4b-3ee9-8cba-949274610077@suse.cz> <Y3JeiXgTqAJbzBtB@yuki>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2022 11:03:38 +0000
Organization: Linux Private Site
In-reply-to: <Y3JeiXgTqAJbzBtB@yuki>
Message-ID: <874jv0scm8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] save_restore: Introduce new struct field for
 flags
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

SGVsbG8sCgpDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gd3JpdGVzOgoKPiBIaSEKPj4g
PiBXb3VsZCB5b3UgY29uc2lkZXIgYWRkaW5nIFRTVF9TUl9UQ09ORl9NSVNTSU5HIGFuZCBUU1Rf
U1JfVENPTkZfUk8/Cj4+IAo+PiBJIGNvdWxkIHNldCBib3RoIHRvIDAsIGlmIHRoYXQncyBPSy4K
Pgo+IEkgc3VwcG9zZSB0aGF0IHdvdWxkIHdvcmsgZmluZS4KPgo+PiA+PiArKiAnVFNUX1NSX0ZB
SUxfTUlTU0lORycg4oCTIEVuZCB0ZXN0IHdpdGggJ1RCUk9LJyBpZiB0aGUgZmlsZSBkb2VzIG5v
dCBleGlzdAo+PiA+IAo+PiA+IFRoaXMgRkFJTCBwYXJ0IGluIHRoaXMgbmFtZSBpcyBxdWl0ZSBt
aXNsZWFkaW5nIHNpbmNlIHRoZSB0ZXN0IGVuZHMgd2l0aAo+PiA+IFRCUk9LLiBJIHdvdWxkIHNh
eSB0aGF0IGl0IHdvdWxkIGJlIG11Y2ggbW9yZSBjbGVhciBpZiBpdCB3YXMgbmFtZWQKPj4gPiBU
U1RfU1JfVEJST0tfTUlTU0lORy4KPj4gCj4+IFRoZW4gSSBzaG91bGQgYWxzbyByZW5hbWUgVFNU
X1NSX1JFUVVJUkVEIHRvIFRTVF9TUl9UQlJPSywgcmVuYW1lIAo+PiBUU1RfU1JfQ09ORF9BQ0NF
U1MgdG8gVFNUX1NSX1NLSVAgYW5kIGFkZCBUU1RfU1JfVENPTkYgZm9yIHRoZSB0d28gbmV3IAo+
PiBmbGFncy4KPgo+IFRoYXQgc291bmRzIGdvb2QgdG8gbWUsIGl0J3MgbXVjaCBjbG9zZWx5IG1h
cHBlZCB0byB0aGUgYWN0dWFsIHRlc3QKPiByZXN1bHQgdHlwZXMgYW5kIHNob3VsZCBiZSBjbGVh
ciBlbm91Z2guCgpVaCwgT0ssIHBsZWFzZSBpZ25vcmUgbXkgY29tbWVudCBvbiB0aGUgc2FtZSBz
dWJqZWN0LgoKPgo+IC0tIAo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jegoKCi0tIApU
aGFuayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
