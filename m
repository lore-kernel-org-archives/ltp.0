Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AB1C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 13:19:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70ADE3C9D96
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 15:19:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C98C3C87C6
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:19:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 633141000997
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:19:08 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BEF071FCD7
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658841547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYe5Rd8RO6kbs3W8KWALukhKo6nuq2FEvXW/PmbT/X0=;
 b=OlTT0BIdhf2VEbechEScQlmLjdaAk3YhVGHxheOYnC2D4adQenq1OvMZ3lav9a1LxmeqbH
 EGeuZB/nEX617ZeKBerO4RiFnnFGOmyjqODvpkBlVwNYeAXiqEWB2AN5EsOcRYpQa3+ES0
 Ob07cYoqJrWjJz85unIXJlCTJ6+29Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658841547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYe5Rd8RO6kbs3W8KWALukhKo6nuq2FEvXW/PmbT/X0=;
 b=dX/C44O+rY5eBhjm9ZqhKFFeVKZKwbtedpqUnWT0EjQaDXHTAEk5rKiTZOkkmfoTlPlHZY
 dt9vOCTwR2AdN/DA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 913372C141;
 Tue, 26 Jul 2022 13:19:07 +0000 (UTC)
References: <Yt+RA5chfBh54kvI@pevik>
 <20220726115234.25310-1-rpalethorpe@suse.com> <Yt/YIR+anMcbsEp2@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Jul 2022 13:53:02 +0100
In-reply-to: <Yt/YIR+anMcbsEp2@pevik>
Message-ID: <878rog3tbo.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tools: Check headers with checkpatch.pl
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

SGVsbG8sCgpQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JpdGVzOgoKPiBIaSBSaWNoaWUs
Cj4KPj4gY2hlY2twYXRjaC5wbCBkb2Vzbid0IGxvYWQgaW5jbHVkZWQgaGVhZGVycyBzbyB0aGV5
IG11c3QgYmUgcGFzc2VkIHRvCj4+IGl0IHNwZWNpZmljYWxseS4gVGhpcyBjaGFuZ2UgYXV0b21h
dGljYWxseSBpbmNsdWRlcyBoZWFkZXJzIGZyb20gdGhlCj4+IGN1cnJlbnQgZGlyZWN0b3J5LiBN
YW51YWwgaW50ZXJ2ZW50aW9uIGlzIHN0aWxsIHJlcXVpcmVkIGlmIGEgdGVzdAo+PiBhdXRob3Ig
Y2hhbmdlcyBhIGhlYWRlciBsb2NhdGVkIGVsc2V3aGVyZS4gSG93ZXZlciB5b3UgY2FuIG5vdyB3
cml0ZQo+PiAnbWFrZSBjaGVjay1oZWFkZXIuaCcsIG9uY2UgaW4gdGhlIGNvcnJlY3QgZGlyZWN0
b3J5Lgo+Cj4+IE5vdGUgdGhhdCBvdXIgU3BhcnNlIGJhc2VkIHRvb2wgKGFtb25nc3Qgb3RoZXJz
KSBsb2FkcyBoZWFkZXJzIGFuZAo+PiBjaGVja3MgYXQgbGVhc3Qgc29tZSBvZiB0aGUgY29udGVu
dC4KPgo+IFRoYW5rcyBhIGxvdCBmb3IgaW1wbGVtZW50aW5nIHRoaXMuCj4KPiBMR1RNLCBqdXN0
IGEgc21hbGwgbml0OiB0YXJnZXQgZm9yIGhlYWRlcnMgY29udGFpbiAuaCBleHRlbnNpb24uCj4g
U2hvdWxkbid0IHdlIGFkZCAuYyBmb3IgQyBzb3VyY2VzIGZvciBjb25zaXN0ZW5jeT8KPgo+IEl0
J8SRIHN0cmFuZ2UsIHRoYXQgbWFrZSBjaGVjayBpbiB0ZXN0Y2FzZXMvbWlzYy9tYXRoL2Zsb2F0
LyBkb2VzIG5vdCBpbmNsdWRlCj4gdGZsb2F0LmgsIGJ1dCBtYWtlIGNoZWNrLXRmbG9hdC5oIHBy
aW50cyBlcnJvcnMuIEJ1dCBtYWtlIGNoZWNrIGluIGxpYi8gd29ya3MgYXMKPiBleHBlY3RlZCAo
YWRkcyBhbHNvICouaCkuCgpUaGUgU3BhcnNlIGJhc2VkIHRvb2wgZG9lcyBpbmNsdWRlIGhlYWRl
cnMgdGhvdWdoLiBTbyByZWFsbHkgd2UgYXJlCmNoZWNraW5nIHRoZSB0YXJnZXQgd2hpY2ggaW5j
bHVkZXMgbW9yZSB0aGFuIGp1c3QgYSBzaW5nbGUgYyBmaWxlLgoKPgo+IFJldmlld2VkLWJ5OiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCgoKLS0g
ClRoYW5rIHlvdSwKUmljaGFyZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
