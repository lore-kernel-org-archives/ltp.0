Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82B7C04A94
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 13:46:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55F563CB6DA
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 15:46:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CBC33C894D
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 15:46:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 70F5D1000F25
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 15:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691588778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDvRUWEU5rm6IaWA8MPbedgVj+HXF03ZRwhShAI4o84=;
 b=NnXKUTQ70KHB4GUpA9aV5b/KfAOU0ZPRz28z9XZtHSl/Z5dSwDfzqbOOpWg0MvbTjqX/gn
 UxFsPO33vFRpusBMuezodwQ894iWsOmUPUDuTrd7H3VJRKrW9rbo/zB/PZEEf1/2uM0DCu
 96/wUKo+gZJ5KSz1J2c2a4gANJ/rmU8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-p173wUuTOfqWogwSFV9VGA-1; Wed, 09 Aug 2023 09:46:17 -0400
X-MC-Unique: p173wUuTOfqWogwSFV9VGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B86EA3C11C79
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 13:46:16 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9067A2166B2A;
 Wed,  9 Aug 2023 13:46:16 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Li Wang <liwang@redhat.com>
References: <20230808124445.980419-1-liwang@redhat.com>
 <x49edkd4qia.fsf@segfault.boston.devel.redhat.com>
 <CAEemH2dEQYSr2dF2XY4Njv37g6dyqxkFOmaY_bZZSKG1MeKsgg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 09 Aug 2023 09:52:05 -0400
In-Reply-To: <CAEemH2dEQYSr2dF2XY4Njv37g6dyqxkFOmaY_bZZSKG1MeKsgg@mail.gmail.com>
 (Li Wang's message of "Wed, 9 Aug 2023 09:46:54 +0800")
Message-ID: <x491qgc492y.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] io_uring: enable I/O Uring before testing
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyaXRlczoKCj4gSGkgSmVmZiwKPgo+IFRoYW5r
cyBmb3IgY29tbWVudHMuCj4KPiBPbiBUdWUsIEF1ZyA4LCAyMDIzIGF0IDk6MTfigK9QTSBKZWZm
IE1veWVyIDxqbW95ZXJAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPj4gTGkgV2FuZyA8bGl3YW5nQHJl
ZGhhdC5jb20+IHdyaXRlczoKPj4KPj4gPiBHaXZlbiB0aGF0IHRoZSB1cHN0cmVhbSBrZXJuZWwg
aXMgZ29pbmcgdG8gaW50cm9kdWNlIGlvX3VyaW5nX2Rpc2FibGVkCj4+ID4ga25vYiB3aGljaCBk
aXNhYmxlcyB0aGUgY3JlYXRpb24gb2YgbmV3IGlvX3VyaW5nIGluc3RhbmNlcyBzeXN0ZW0td2lk
ZS4KPj4gPgo+PiA+IFRoZSBuZXcgc3lzY3RsIGlzIGRlc2lnbmVkIHRvIGxldCBhIHVzZXIgd2l0
aCByb290IG9uIHRoZSBtYWNoaW5lCj4+ID4gZW5hYmxlIGFuZCBkaXNhYmxlIGlvX3VyaW5nIHN5
c3RlbS13aWRlIGF0IHJ1bnRpbWUgd2l0aG91dCByZXF1aXJpbmcKPj4gPiBhIGtlcm5lbCByZWNv
bXBpbGF0aW9uIG9yIGEgcmVib290Lgo+PiA+Cj4+ID4gU2VlOgo+PiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvaW8tdXJpbmcvcGF0Y2gvMjAyMzA2MzAxNTEwMDMuMzYyMjc4
Ni0yLW1hdHRlb3JpenpvQGdvb2dsZS5jb20vCj4+ID4KPj4gPiBXaXRob3V0IHRoaXMgcGF0Y2gs
IExUUC9pb191cmluZyB0ZXN0IGNvbXBsYWluczoKPj4gPgo+PiA+ICAgaW9fdXJpbmcwMS5jOjgy
OiBURkFJTDogaW9fdXJpbmdfc2V0dXAoKSBmYWlsZWQ6IEVQRVJNICgxKQo+PiA+ICAgaW9fdXJp
bmcwMi5jOjIxMzogVEJST0s6IGlvX3VyaW5nX3NldHVwKCkgZmFpbGVkOiBFUEVSTSAoMSkKPj4K
Pj4gSnVzdCB0byBiZSBjbGVhciwgd2l0aCB0aGUgYWJvdmUga2VybmVsIHBhdGNoIGFwcGxpZWQg
aW9fdXJpbmcgaXMKPj4gZW5hYmxlZCBieSBkZWZhdWx0LiAgWW91IHNob3VsZG4ndCBuZWVkIHRv
IHNldCB0aGUgc3lzY3RsIHBhcmFtZXRlcgo+PiB1bmxlc3MgaW9fdXJpbmcgaXMgZXhwbGljaXRs
eSBkaXNhYmxlZCBieSB0aGUgYWRtaW5pc3RyYXRvciAodGhhdCBjYW4gYmUKPj4gYWNjb21wbGlz
aGVkIHZpYSB0aGUga2VybmVsIGNvbW1hbmQgbGluZSwgc3lzZnMsIG9yIHZpYSBzeXNjdGwuY29u
ZikuCj4+Cj4KPiBZZXMsIGJ1dCBpdCB3b24ndCBiZSBoYXJtZnVsIHRvIHNldCB0aGUgcGFyYW1l
dGVyIGV2ZW4gaWYgaXQncyBlbmFibGVkIGJ5Cj4gZGVmYXVsdCwKPiBMVFAgdXNlcyBzYXZlX3Jl
c3RvcmUgZmllbGQgdG8gbWFuYWdlIHN5c2ZzIGtub2IgdW5pZmllZCwgaXQgZ3VhcmFudGVlcyB0
aGUKPiB0ZXN0cyBjYW4gcmVhbGx5IGdldCBwZXJmb3JtZWQgd2hhdGV2ZXIgaW9fdXJpbmcgaXMg
ZW5hYmxlZCBvciBkaXNhYmxlZC4KPgo+IEkgd291bGQga2VlcCB0aGUgcGF0Y2ggYXMgaXQgaXMg
dW5sZXNzIHlvdSBpbnNpc3Qgb3Igb3RoZXJzIGhhdmUgYW4KPiBvYmplY3Rpb24uCgpJIGFncmVl
IHdpdGggdGhlIHBhdGNoLiAgSSBqdXN0IHRoaW5rIHRoZSBkZXNjcmlwdGlvbiBzaG91bGQgYmUg
dXBkYXRlZCwKYXMgaXQgaW1wbGllcyB0aGF0LCB3aXRob3V0IHRoZSBwYXRjaCwgdGhlIHRlc3Qg
d2lsbCBmYWlsLiAgVGhpcyBpcyBub3QKdGhlIGNhc2UgZm9yIGFuIHVwc3RyZWFtIGtlcm5lbC4K
ClRoYW5rcyEKSmVmZgoKPgo+Cj4+Cj4+IENoZWVycywKPj4gSmVmZgo+Pgo+PiA+Cj4+ID4gUmVw
cm90ZWQtYnk6IEplZmYgTW95ZXIgPGptb3llckByZWRoYXQuY29tPgo+PiA+IFNpZ25lZC1vZmYt
Ynk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+PiA+IC0tLQo+PiA+ICB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2lvX3VyaW5nL2lvX3VyaW5nMDEuYyB8IDUgKysrKysKPj4gPiAgdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb191cmluZy9pb191cmluZzAyLmMgfCA1ICsrKysrCj4+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+PiA+Cj4+ID4gZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fdXJpbmcvaW9fdXJpbmcwMS5jCj4+IGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb191cmluZy9pb191cmluZzAxLmMKPj4gPiBpbmRl
eCA3MDE1MWJiODUuLmFiMWVjMDBkNiAxMDA2NDQKPj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2lvX3VyaW5nL2lvX3VyaW5nMDEuYwo+PiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvaW9fdXJpbmcvaW9fdXJpbmcwMS5jCj4+ID4gQEAgLTI2NCw1ICsyNjQsMTAg
QEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+PiA+ICAgICAgIC5idWZzID0gKHN0
cnVjdCB0c3RfYnVmZmVycyBbXSkgewo+PiA+ICAgICAgICAgICAgICAgeyZpb3YsIC5pb3Zfc2l6
ZXMgPSAoaW50W10pe0JMT0NLX1NaLCAtMX19LAo+PiA+ICAgICAgICAgICAgICAge30KPj4gPiAr
ICAgICB9LAo+PiA+ICsgICAgIC5zYXZlX3Jlc3RvcmUgPSAoY29uc3Qgc3RydWN0IHRzdF9wYXRo
X3ZhbFtdKSB7Cj4+ID4gKyAgICAgICAgICAgICB7Ii9wcm9jL3N5cy9rZXJuZWwvaW9fdXJpbmdf
ZGlzYWJsZWQiLCAiMCIsCj4+ID4gKyAgICAgICAgICAgICAgICAgICAgIFRTVF9TUl9TS0lQX01J
U1NJTkcgfCBUU1RfU1JfVENPTkZfUk99LAo+PiA+ICsgICAgICAgICAgICAge30KPj4gPiAgICAg
ICB9Cj4+ID4gIH07Cj4+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aW9fdXJpbmcvaW9fdXJpbmcwMi5jCj4+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb191
cmluZy9pb191cmluZzAyLmMKPj4gPiBpbmRleCBjNWM3NzAwNzQuLmM5ZDRiYmNiMSAxMDA2NDQK
Pj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvX3VyaW5nL2lvX3VyaW5nMDIu
Ywo+PiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fdXJpbmcvaW9fdXJpbmcw
Mi5jCj4+ID4gQEAgLTI1NSw2ICsyNTUsMTEgQEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0
ID0gewo+PiA+ICAgICAgICAgICAgICAgVFNUX0NBUChUU1RfQ0FQX1JFUSwgQ0FQX1NZU19DSFJP
T1QpLAo+PiA+ICAgICAgICAgICAgICAge30KPj4gPiAgICAgICB9LAo+PiA+ICsgICAgIC5zYXZl
X3Jlc3RvcmUgPSAoY29uc3Qgc3RydWN0IHRzdF9wYXRoX3ZhbFtdKSB7Cj4+ID4gKyAgICAgICAg
ICAgICB7Ii9wcm9jL3N5cy9rZXJuZWwvaW9fdXJpbmdfZGlzYWJsZWQiLCAiMCIsCj4+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIFRTVF9TUl9TS0lQX01JU1NJTkcgfCBUU1RfU1JfVENPTkZfUk99
LAo+PiA+ICsgICAgICAgICAgICAge30KPj4gPiArICAgICB9LAo+PiA+ICAgICAgIC50YWdzID0g
KGNvbnN0IHN0cnVjdCB0c3RfdGFnW10pIHsKPj4gPiAgICAgICAgICAgICAgIHsibGludXgtZ2l0
IiwgIjkzOTJhMjdkODhiOSJ9LAo+PiA+ICAgICAgICAgICAgICAgeyJsaW51eC1naXQiLCAiZmYw
MDJiMzAxODFkIn0sCj4+Cj4+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
