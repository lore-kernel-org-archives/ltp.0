Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38746E7C4F7
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 08:39:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B78393CD996
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 10:39:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E82C3CB1CD
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 10:39:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1529E1BB9FA9
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 10:39:03 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 76B871F74D
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696495142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tU6EKfr7CMC92TECAsAiA6HnsNIC6abDG9LfyUdYYng=;
 b=JDSO3v7o8/zJcV8JC3gvxGHUqXNhJ2QPpc+KKTjEvKqxhFTJeaOEDk1s6wcNXsA6Ncti7r
 wG9CfxKo9F/U0hk0QXyOETcJyBKTNbHdgaV3rmaQ03kAVeuUAQmqJ/QTqZvP0ipLBJYDU7
 9QmqSje3hn5PT9P8+lwhHwdNikZ+dhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696495142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tU6EKfr7CMC92TECAsAiA6HnsNIC6abDG9LfyUdYYng=;
 b=qDbCIfAEhnVLUltSoLaTBGXJYM71f9cMtLNAaHTl4lv0h37VdXf6z/JRaxduYBtZnKb0P7
 CH79n2Fjfrmh5MDQ==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2EA2A2C142;
 Thu,  5 Oct 2023 08:39:02 +0000 (UTC)
References: <20230928104458.12115-1-rpalethorpe@suse.com>
 <2299373.ElGaqSPkdT@linux-9lzf>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Marius Kittler <mkittler@suse.de>
Date: Thu, 05 Oct 2023 09:07:12 +0100
Organization: Linux Private Site
In-reply-to: <2299373.ElGaqSPkdT@linux-9lzf>
Message-ID: <87r0m91n17.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpNYXJpdXMgS2l0dGxlciA8bWtpdHRsZXJAc3VzZS5kZT4gd3JpdGVzOgoKPj4gVGhl
IGNvbnRhaW5lciBjYW4gYmUgYnVpbHQgd2l0aCBhIGNvbW1hbmQgbGlrZToKPj4gCj4+IHBvZG1h
biBidWlsZCAtdCB0dW1ibGV3ZWVkL2x0cCBcCj4+ICAgICAgICAtLWJ1aWxkLWFyZyBQUkVGSVg9
cmVnaXN0cnkub3BlbnN1c2Uub3JnL29wZW5zdXNlLyBcCj4+ICAgICAgICAtLWJ1aWxkLWFyZyBE
SVNUUk9fTkFNRT10dW1ibGV3ZWVkIFwKPj4gICAgICAgIC0tYnVpbGQtYXJnIERJU1RST19SRUxF
QVNFPTIwMjMwOTI1IC4KPj4gCj4+IE9yIGp1c3QKPj4gCj4+IHBvZG1hbiBidWlsZCAtdCBhbHBp
bmUvbHRwIC4KPj4gCj4+IEl0IGNvbnRhaW5zIEtpcmsgaW4gL29wdC9raXJrLiBTbwo+PiAKPj4g
Y2QgL29wdC9raXJrICYmIC4va2lyayAtZiBsdHAgLXIgc3lzY2FsbHMKPj4gCj4+IHdpbGwgcnVu
IHNvbWUgdGVzdHMuCj4KPiBJdCB3b3VsZCBsaWtlbHkgbWFrZSBzZW5zZSB0byBhZGQgYSBzZWN0
aW9uIHdpdGggdGhlc2UgaW5mb3JtYXRpb24gaW4gdGhlIAo+IFJFQURNRSBhcyB3ZWxsLgoKSSBh
Z3JlZSwgYnV0IEkgdGhpbmsgSSB3aWxsIGJlIGRvaW5nIHNvbWUgbW9yZSB3b3JrIHdpdGggY29u
dGFpbmVycyB3aXRoCktpcmsgYW5kIExUWC4gU28gSSB3b3VsZCBwcmVmZXIgdG8gZG9jdW1lbnQg
aXQgYWZ0ZXIgSSBrbm93IG1vcmUgYWJvdXQKdGhlIGJlc3Qgd29ya2Zsb3cuCgo+Cj4gSSdtIGFs
c28gd29uZGVyaW5nIGFib3V0IHRoZSB3b3JrZmxvdyBvZiBtYWtpbmcgY2hhbmdlcyAoZS5nLiB0
byBhIHNpbmdsZSB0ZXN0KSAKPiBhbmQgdGhlbiByZS1jb21waWxpbmcgYW5kIHJlLXJ1bm5pbmcg
dGhlIHNwZWNpZmljIHRlc3QuIE1heWJlIHRoYXQncyBhbHNvIHdvcnRoIAo+IGNvbnNpZGVyaW5n
L2RvY3VtZW50aW5nLgoKVEJIIEkgZG9uJ3QgaGF2ZSBhIGdvb2Qgd29ya2Zsb3cgZm9yIHRoYXQu
IEkga25vdyB0aGF0IHdlIGNhbiBtb3VudCB0aGUKc291cmNlIGluIGEgdm9sdW1lLiBIb3dldmVy
IHdlIHByb2JhYmx5IG5lZWQgdG8gbW92ZSB0aGUgYnVpbGQgb3V0IG9mCnRoZSB0cmVlLiBJJ2Qg
YmUgaW50ZXJlc3RlZCBpbiBzdWdnZXN0aW9ucy4KCj4KPj4gCj4+IE5vdGUgYSBtdWNoIHNtYWxs
ZXIgY29udGFpbmVyIGNhbiBiZSBmb3VuZCBhdDoKPj4gaHR0cHM6Ly9yZWdpc3RyeS5vcGVuc3Vz
ZS5vcmcvY2dpLWJpbi9jb292ZXJ2aWV3P3NyY2hfdGVybT1wcm9qZWN0JTNEJTVFYmVuYwo+PiBo
bWFyaytjb250YWluZXIlM0QuKiBUaGlzIGlzIGNyZWF0ZWQgd2l0aCBTVVNFJ3MgYnVpbGQgc3lz
dGVtIHdoaWNoIGRvZXMgbm90Cj4+IHVzZSBjb250YWluZXIgZmlsZXMKPj4gCj4+IFNpZ25lZC1v
ZmYtYnk6IFJpY2hhcmQgUGFsZXRob3JwZSA8cnBhbGV0aG9ycGVAc3VzZS5jb20+Cj4+IENjOiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPj4gQ2M6IE1hcml1cyBLaXR0bGVyIDxta2l0dGxl
ckBzdXNlLmRlPgo+PiAtLS0KPj4gCj4+IFJGQyBjb21tZW50czoKPj4gICAgICogQWRkIGdpdCBj
bGVhbiAtZmRYIHdoaWNoIHNob3VsZCByZW1vdmUgYW55IGJ1aWxkIGFydGlmYWN0cwo+PiAgICAg
ICB0aGlzIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBzdWdnZXN0aW9uIG9mIGp1c3QgZG9pbmcgYSBj
aGVjay4gSSBqdXN0Cj4+ICAgICAgIGZvdW5kIGl0IGVhc2llciB0byByZW1vdmUgdGhlIGJ1aWxk
IGZpbGVzLgo+Cj4gV2hlcmUgd2UgZG9jdW1lbnQgdGhlIHVzYWdlIG9mIHRoZSBjb250YWluZXIg
d2Ugc2hvdWxkIGFsc28gZG9jdW1lbnQgdGhhdCAKPiBpdCdsbCBkbyB0aGlzIGtpbmQgb2YgY2xl
YW51cCBzbyB0aGVyZSBhcmUgbm8gc3VycHJpc2VzLgoKVG8gYmUgY2xlYXIgdGhpcyBvbmx5IGhh
cHBlbnMgaW5zaWRlIHRoZSBjb250YWluZXIgYW5kICpzaG91bGQqIG9ubHkKcmVtb3ZlIHRoaW5n
cyBjb3ZlcmVkIGJ5IC5naXRpZ25vcmUgKGkuZS4gYnVpbGQgYXJ0aWZhY3RzKS4gU28gZG9lcyBp
dApuZWVkIGRvY3VtZW50aW5nIGluIHRoYXQgY2FzZT8KCj4KPj4gICAgICogQWRkZWQgc2VwZXJh
dGUgYWxwaW5lIGFuZCB0dW1ibGV3ZWVkIHJ1bnRpbWUgc2NyaXB0cy4gQWdhaW4gaXQncwo+PiAg
ICAgICBkaWZmZXJlbnQgZnJvbSB0aGUgc3VnZ2VzdGlvbiBqdXN0IGJlY2F1c2UgaXQncyBlYXNp
ZXIgdG8gYWRkCj4+ICAgICAgIHNlcGVyYXRlIHNjcmlwdHMgdGhhbiBhZGRpbmcgYSBzd2l0Y2gK
Pj4gICAgICogT2J2aW91c2x5IGEgbnVtYmVyIG9mIGRpc3Ryb3MgYXJlIG1pc3NpbmcgcnVudGlt
ZSBzY3JpcHRzLiBUaGV5IGNhbgo+PiAgICAgICBiZSBhZGRlZCB3aGVuIHNvbWVvbmUgaXMgbW90
aXZhdGVkIHRvIGRvIHNvLgo+PiAKPiDigKYKPj4gK1JVTiBta2RpciAvYnVpbGQKPj4gK1dPUktE
SVIgL2J1aWxkCj4+ICtDT1BZIC4gL2J1aWxkCj4+ICtSVU4gLi9jaS8ke0RJU1RST19OQU1FfS5z
aAo+PiArUlVOIGdpdCBjbGVhbiAtZmRYCj4+ICtSVU4gLi9idWlsZC5zaCAtcCAkTFRQUk9PVCAt
aQo+PiArCj4KPiBJdCBtaWdodCBtYWtlIHNlbnNlIHRvIGNvbWJpbmUgY29uc2VjdXRpdmUgcnVu
IGNvbW1hbmRzIChzZWUKPiBodHRwczovL2dpdGh1Yi5jb20vaGFkb2xpbnQvaGFkb2xpbnQvd2lr
aS9ETDMwNTkpLgoKSSB0aGluayB0aGlzIGRlcGVuZHMgb24gZXhhY3RseSBob3cgY2FjaGluZyB3
b3JrcyBhbmQgd2hlcmUgdGhlIGJlc3QKcGxhY2UgdG8gcHV0IGdpdCBjbGVhbiBpcy4gSWRlYWxs
eSB3ZSBvbmx5IHdhbnQgdG8gcnVuIHRoZSBjaSBzY3JpcHQKd2hlbiB0aGUgZGVwZW5kZW5jaWVz
IGNoYW5nZS4KCk1heWJlIHdlIHNob3VsZCBhbHNvIHNwbGl0IHRoZSBDT1BZLCB0byBtYWtlIHN1
cmUgdGhlIGNvbnRhaW5lcgpydW50aW1lIGNhbiBkZXRlY3Qgd2hpY2ggZmlsZXMgaGF2ZSBjaGFu
Z2VkLgoKTW9yZSBpbXBvcnRhbnRseSBJIHRoaW5rIHRoaXMgcmVsYXRlcyB0byB5b3VyIGNvbW1l
bnQgb24gd29ya2Zsb3cgZm9yCmNoYW5naW5nIGEgc2luZ2xlIHRlc3QuIElkZWFsbHkgd2Ugc2hv
dWxkIGJlIGFibGUgdG8gY2hhbmdlIGFuZCBjb21waWxlCmEgc2luZ2xlIHRlc3Qgd2l0aG91dCBk
b2luZyBhIGJ1bmNoIG9mIHVuZWNlc3Nhcnkgd29yay4gUmlnaHQgbm93IEkgYW0Kbm90IHN1cmUg
aG93IHRvIGRvIHRoYXQ/CgotLSAKVGhhbmsgeW91LApSaWNoYXJkLgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
