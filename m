Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BA6C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 11:55:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E56B73D20D4
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 13:55:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DB733D1BF1
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 13:55:01 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C48A6096BA
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 13:55:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A18E81FF53;
 Fri,  9 Aug 2024 11:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723204500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5pY3U2lbcLJzHuz7naUBGiGGlTAWUZpZZqSKTeIWuU=;
 b=k8nNwzuOHGh7xbkvDiePP4ZKipHtVPdri9hq1V70h97AUXaNbFjkRHgb4IovAXmSFAZT5U
 UIXluUs7py0GEUavEjNNH4Ls6ZErVpOvK/BxVtQhAtAAHuWCTBSGtNjmQk2qqLn3WGgGCr
 MDqbukPwt4focpbIgzlNLP22ANR7IY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723204500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5pY3U2lbcLJzHuz7naUBGiGGlTAWUZpZZqSKTeIWuU=;
 b=n0N7hbL+OZmpf2+7EcXKUg0/suJwnmjliLuLs1BRnW/uR7RSpPQ55QvcXo3pa0Hzcyu6DB
 EQoEuEub7Dni0LBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723204497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5pY3U2lbcLJzHuz7naUBGiGGlTAWUZpZZqSKTeIWuU=;
 b=Q0Z9XxzbrRUgzwQDUF2yUmKN2SwNIUb0p9ekXJHPfujTd5ppd2C8U4XtSElIqyYVKi+Ase
 9FbVtixDUg8G97nC59EkbWKdVXcSHQrlsAFSHDQnrzur5DHJsmtxRSxEK231/Rd8izk2eN
 eqiy9JBOMOUDxWcPT1qfPAX4Mdu/G0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723204497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5pY3U2lbcLJzHuz7naUBGiGGlTAWUZpZZqSKTeIWuU=;
 b=PIDucZRjlLxV6pLuRCOIPsyAOrA9ebzctIcXeMrvh4RRiTCsDCrEzfp28TYTfVri4TqhEY
 r+GnVY633dVlgaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 869B813A7D;
 Fri,  9 Aug 2024 11:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v5fPH5EDtmajYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Aug 2024 11:54:57 +0000
Date: Fri, 9 Aug 2024 13:54:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240809115456.GB352642@pevik>
References: <20240809095505.352377-1-pvorel@suse.cz>
 <CAEemH2dVqP+r-u6XexYifVAyzNwSdeOsBk-NNrpdWgM3eNssew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dVqP+r-u6XexYifVAyzNwSdeOsBk-NNrpdWgM3eNssew@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] pkey01: Fix TBROK due missing results
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

SGkgTGksIGFsbCwKCj4gSGkgUGV0ciwKCj4gT24gRnJpLCBBdWcgOSwgMjAyNCBhdCA1OjU14oCv
UE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IFBLRVlfRElTQUJMRV9F
WEVDVVRFIGlzIHBwYzY0bGUgc3BlY2lmaWMgdGVzdC4gRHVlIG1lc3NhZ2VzIGJlaW5nCj4gPiBU
SU5GTyB0ZXN0IG9uIG90aGVyIGFyY2hzIGZhaWxzOgoKPiA+ICAgICB0c3RfdGVzdC5jOjE0OTg6
IFRCUk9LOiBUZXN0IDIgaGF2ZW4ndCByZXBvcnRlZCByZXN1bHRzIQoKCj4gQWggeWVzLCBJIHRo
aW5rIG9mIHdoeSBJIHVzZWQgdHN0X2JyayBpbiBteSBwcmV2aW91cyBwYXRjaC4KCgoKPiA+IENo
YW5naW5nIG1lc3NhZ2VzIHRvIFRDT05GLiBBbHNvIGV4aXQgbG9vcCBvbiAhZXhlY3V0ZV9zdXBw
b3J0ZWQgVENPTkYKPiA+IChubyBuZWVkIHRvIGhhdmUgMzB4IFRDT05GIHdpdGggdGhlIHNhbWUg
ZXJyb3IgbWVzc2FnZSwgYmVjYXVzZSB3ZSBoYXZlCj4gPiBQS0VZX0RJU0FCTEVfRVhFQ1VURSBs
YXN0KS4gVGhlIG90aGVyIFRDT05GIChvbiBNQVBfSFVHRVRMQikgbXVzdCBiZQo+ID4gcmVwZWF0
ZWQuCgoKPiBBZ3JlZWQuCgoKPiA+IEZpeGVzOiBkMmI4YTQ3NmMyICgicGtleTAxOiBBZGRpbmcg
dGVzdCBmb3IgUEtFWV9ESVNBQkxFX0VYRUNVVEUiKQo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiAtLS0KPiA+IEhpIExpLCBhbGwsCgo+ID4gaWYgeW91
IGRvbid0IGxpa2UgUEtFWV9ESVNBQkxFX0VYRUNVVEUgaGF2aW5nIHRvIGJlIHRoZSBsYXN0LCB3
ZSBjYW4KPiA+IGp1c3QgaGF2ZSAzMHggVENPTkYgKGp1c3QgdG8gY2hhbmdlIGJvdGggVElORk8g
dG8gVENPTkYpLiBXaGF0ZXZlciB5b3UKPiA+IHByZWZlci4KCgo+IEl0J3Mgb2theSwgSSBndWVz
cyBQS0VZX0RJU0FCTEVfRVhFQ1VURSBpcyBhbHJlYWR5IHRoZSBsYXN0IGZlYXR1cmUKPiBmb3Ig
bWVtIHByb3RlY3Rpb24sIFJFQUQsIFdSSVRFLCBFWEVDLCBhbmQgSSBkb24ndCBleHBlY3QgdGhl
cmUgd2lsbAo+IGJlIGEgbmV3IHBlcm1pc3Npb24gdG8gYXBwZWFyIDopLgoKVGhhbmtzIGZvciBh
IHF1aWNrIGFjaywgbWVyZ2VkICh3aXRoIGFkZGVkIGNvbW1lbnQgZm9yIHJldHVybiB2YWx1ZSBp
biB0aGUKY29kZSkuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gRmVlbCBmcmVlIHRvIGFkZDoKPiBS
ZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
