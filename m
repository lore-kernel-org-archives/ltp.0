Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE097E7B601
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 12:29:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD7A33CDB20
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 14:29:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F7553CBDCE
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:29:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D485460080F
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:29:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0967F1F74D
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696422540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pGAmOpOzNhavSNcChVvuAFnOxpHpGYpWEoYBr5B7DA=;
 b=F1zdks6UWRy2NfmJIvL1KFdjtmtfzaH8kL4/cr0pt/F/cHb/kBBw/kmsj9XYTTapZSlkuT
 /SXve30XMKDSuIsOQr1aG4CHIGJqi8BEozSmnEMoUQ1jFFrOJoeckvaJaAVKEhzlDLTcdR
 IdyV3zPQ2ffdV0xUkFuC7pZqWoq+Ims=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696422540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pGAmOpOzNhavSNcChVvuAFnOxpHpGYpWEoYBr5B7DA=;
 b=mpUER8F0xqPmT+nGXdT5xPVVHsjNS3ZnhhnLfewRQcgu+9zzNZSB3R4FZh38vojJ9N2wDd
 JWEaDCqw4FM1EBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3C4313A2E
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 12:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P5mANotaHWXxMQAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Wed, 04 Oct 2023 12:28:59 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 04 Oct 2023 14:28:59 +0200
Message-ID: <2299373.ElGaqSPkdT@linux-9lzf>
In-Reply-To: <20230928104458.12115-1-rpalethorpe@suse.com>
References: <20230928104458.12115-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add simple Containerfile
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBUaGUgY29udGFpbmVyIGNhbiBiZSBidWlsdCB3aXRoIGEgY29tbWFuZCBsaWtlOgo+IAo+IHBv
ZG1hbiBidWlsZCAtdCB0dW1ibGV3ZWVkL2x0cCBcCj4gICAgICAgIC0tYnVpbGQtYXJnIFBSRUZJ
WD1yZWdpc3RyeS5vcGVuc3VzZS5vcmcvb3BlbnN1c2UvIFwKPiAgICAgICAgLS1idWlsZC1hcmcg
RElTVFJPX05BTUU9dHVtYmxld2VlZCBcCj4gICAgICAgIC0tYnVpbGQtYXJnIERJU1RST19SRUxF
QVNFPTIwMjMwOTI1IC4KPiAKPiBPciBqdXN0Cj4gCj4gcG9kbWFuIGJ1aWxkIC10IGFscGluZS9s
dHAgLgo+IAo+IEl0IGNvbnRhaW5zIEtpcmsgaW4gL29wdC9raXJrLiBTbwo+IAo+IGNkIC9vcHQv
a2lyayAmJiAuL2tpcmsgLWYgbHRwIC1yIHN5c2NhbGxzCj4gCj4gd2lsbCBydW4gc29tZSB0ZXN0
cy4KCkl0IHdvdWxkIGxpa2VseSBtYWtlIHNlbnNlIHRvIGFkZCBhIHNlY3Rpb24gd2l0aCB0aGVz
ZSBpbmZvcm1hdGlvbiBpbiB0aGUgClJFQURNRSBhcyB3ZWxsLgoKSSdtIGFsc28gd29uZGVyaW5n
IGFib3V0IHRoZSB3b3JrZmxvdyBvZiBtYWtpbmcgY2hhbmdlcyAoZS5nLiB0byBhIHNpbmdsZSB0
ZXN0KSAKYW5kIHRoZW4gcmUtY29tcGlsaW5nIGFuZCByZS1ydW5uaW5nIHRoZSBzcGVjaWZpYyB0
ZXN0LiBNYXliZSB0aGF0J3MgYWxzbyB3b3J0aCAKY29uc2lkZXJpbmcvZG9jdW1lbnRpbmcuCgo+
IAo+IE5vdGUgYSBtdWNoIHNtYWxsZXIgY29udGFpbmVyIGNhbiBiZSBmb3VuZCBhdDoKPiBodHRw
czovL3JlZ2lzdHJ5Lm9wZW5zdXNlLm9yZy9jZ2ktYmluL2Nvb3ZlcnZpZXc/c3JjaF90ZXJtPXBy
b2plY3QlM0QlNUViZW5jCj4gaG1hcmsrY29udGFpbmVyJTNELiogVGhpcyBpcyBjcmVhdGVkIHdp
dGggU1VTRSdzIGJ1aWxkIHN5c3RlbSB3aGljaCBkb2VzIG5vdAo+IHVzZSBjb250YWluZXIgZmls
ZXMKPiAKPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFBhbGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1
c2UuY29tPgo+IENjOiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiBDYzogTWFyaXVzIEtp
dHRsZXIgPG1raXR0bGVyQHN1c2UuZGU+Cj4gLS0tCj4gCj4gUkZDIGNvbW1lbnRzOgo+ICAgICAq
IEFkZCBnaXQgY2xlYW4gLWZkWCB3aGljaCBzaG91bGQgcmVtb3ZlIGFueSBidWlsZCBhcnRpZmFj
dHMKPiAgICAgICB0aGlzIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBzdWdnZXN0aW9uIG9mIGp1c3Qg
ZG9pbmcgYSBjaGVjay4gSSBqdXN0Cj4gICAgICAgZm91bmQgaXQgZWFzaWVyIHRvIHJlbW92ZSB0
aGUgYnVpbGQgZmlsZXMuCgpXaGVyZSB3ZSBkb2N1bWVudCB0aGUgdXNhZ2Ugb2YgdGhlIGNvbnRh
aW5lciB3ZSBzaG91bGQgYWxzbyBkb2N1bWVudCB0aGF0IAppdCdsbCBkbyB0aGlzIGtpbmQgb2Yg
Y2xlYW51cCBzbyB0aGVyZSBhcmUgbm8gc3VycHJpc2VzLgoKPiAgICAgKiBBZGRlZCBzZXBlcmF0
ZSBhbHBpbmUgYW5kIHR1bWJsZXdlZWQgcnVudGltZSBzY3JpcHRzLiBBZ2FpbiBpdCdzCj4gICAg
ICAgZGlmZmVyZW50IGZyb20gdGhlIHN1Z2dlc3Rpb24ganVzdCBiZWNhdXNlIGl0J3MgZWFzaWVy
IHRvIGFkZAo+ICAgICAgIHNlcGVyYXRlIHNjcmlwdHMgdGhhbiBhZGRpbmcgYSBzd2l0Y2gKPiAg
ICAgKiBPYnZpb3VzbHkgYSBudW1iZXIgb2YgZGlzdHJvcyBhcmUgbWlzc2luZyBydW50aW1lIHNj
cmlwdHMuIFRoZXkgY2FuCj4gICAgICAgYmUgYWRkZWQgd2hlbiBzb21lb25lIGlzIG1vdGl2YXRl
ZCB0byBkbyBzby4KPiAK4oCmCj4gK1JVTiBta2RpciAvYnVpbGQKPiArV09SS0RJUiAvYnVpbGQK
PiArQ09QWSAuIC9idWlsZAo+ICtSVU4gLi9jaS8ke0RJU1RST19OQU1FfS5zaAo+ICtSVU4gZ2l0
IGNsZWFuIC1mZFgKPiArUlVOIC4vYnVpbGQuc2ggLXAgJExUUFJPT1QgLWkKPiArCgpJdCBtaWdo
dCBtYWtlIHNlbnNlIHRvIGNvbWJpbmUgY29uc2VjdXRpdmUgcnVuIGNvbW1hbmRzIChzZWUKaHR0
cHM6Ly9naXRodWIuY29tL2hhZG9saW50L2hhZG9saW50L3dpa2kvREwzMDU5KS4KCgoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
