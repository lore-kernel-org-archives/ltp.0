Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2A0EB64DA
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 04:54:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 662E73CB651
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 06:54:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 591A43CAB8D
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 06:53:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ECCB01000533
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 06:53:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 226CD1F8A8;
 Fri, 14 Jul 2023 04:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689310429;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kTr2b47cm/zQn8utQD1uvXh7tGS8xv0pIRssUyD7iQ=;
 b=c+DPIfCvts0nSU6VSZA7cFa6LmMW+Jvc6MtslhiqdhH6O4sS4rPFVMyGcbzyFLTzbURthe
 11mtGes0LNJ9SaVlfosB43OOcHWJQkZ0PXah0QlEyGZNMfJP/b9a9x5q7CEfeOVSFnIBiB
 TAOaliYgem8eEGH80LenjQ1ZxdcIdBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689310429;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kTr2b47cm/zQn8utQD1uvXh7tGS8xv0pIRssUyD7iQ=;
 b=5KPykW0MfTYlLsxY8UVNzeW2C9VI5ealHSREsIYm8W4Gb6xVTOa6TWH4q/2oXicu3HBvJT
 FxRG9sBr/NyfdKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0602138F8;
 Fri, 14 Jul 2023 04:53:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JIKwONzUsGRlcgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jul 2023 04:53:48 +0000
Date: Fri, 14 Jul 2023 06:53:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230714045347.GA824361@pevik>
References: <20230704091933.496989-1-pvorel@suse.cz>
 <20230704091933.496989-2-pvorel@suse.cz>
 <20230704092536.GA497945@pevik> <ZK_m_8OuewzitKmH@yuki>
 <CAEemH2eE8PUY_at7C-aUX+75ALdM-jjm71L=M-ETYc94RKJFcg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eE8PUY_at7C-aUX+75ALdM-jjm71L=M-ETYc94RKJFcg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/3] Makefile: Add C header with generated LTP
 version
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

SGkgQ3lyaWwsIExpLAoKPiBPbiBUaHUsIEp1bCAxMywgMjAyMyBhdCA3OjU34oCvUE0gQ3lyaWwg
SHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIQo+ID4gPiBvYnZpb3VzbHkg
dGhpcyBpcyB3cm9uZywgYmVjYXVzZSAkKHRvcF9zcmNkaXIpL1ZlcnNpb24gKGx0cC12ZXJzaW9u
LmgKPiA+ID4gZGVwZW5kZW5jeSkgaXMgbm90IHNwZWNpZmllZCBpbiB0aGUgdG9wIGxldmVsIE1h
a2VmaWxlIChvbmx5IFZlcnNpb24gaXMKPiA+ID4gdGhlcmUpLiBCdXQgSSdtIG5vdCBzdXJlIGlm
IGl0IHNob3VsZCBiZSBjaGFuZ2VkIHRvCj4gPiA+ICQodG9wX3NyY2RpcikvVmVyc2lvbi4KCj4g
PiA+IEkgc3VwcG9zZSBsdHAtdmVyc2lvbi5oIHNob3VsZCBiZSBpbiBpbmNsdWRlLwoKPiA+IE5v
dCByZWFsbCwgYXMgbG9uZyBhcyBpdCdzIHVzZWQgb25seSBpbiB0aGUgbGlicmFyeSBpdCBjYW4g
c3RheSBpbiB0aGUKPiA+IGxpYi8KCj4gPiA+ICwgYnV0IGhlcmUgSSdtIGNvbXBsZXRlbHkgbG9z
dCB3aXRoIGRlcGVuZGVuY2llcyB1bmRlciBsaWIvLiBNeSBnb2FsCj4gPiA+IGlzIHRvIHR5cGUg
bWFrZSBpbiBsaWIvIGFuZCBtYWtlIHN1cmUgdGhlIGhlYWRlciBpcyBnZW5lcmF0ZWQKPiA+ID4g
KGRlcGVuZGVuY2llcyBjb3JyZWN0bHkgcmVzb2x2ZWQpLgoKPiA+IFRoZXJlIGlzIGFub3RoZXIg
cHJvYmxlbSBhcyB3ZWxsLCBjdXJyZW50bHkgdGhlIFZlcnNpb24gZmlsZSBpcwo+ID4gZ2VuZXJh
dGVkIGF0IHRoZSBlbmQgb2YgdGhlIExUUCBidWlsZCwgdGhhdCBtZWFucyBpZiB5b3UgZG8gYSBn
aXQgcHVsbAo+ID4gYW5kIG1ha2UgaXQncyBub3QgdXBkYXRlZCB1bnRpbCB0aGUgYnVpbGQgaGFz
IGZpbmlzaGVkLgoKPiA+IEFsc28gd2Ugd2lsbCBoYXZlIHRvIHJlYnVpbGQgdHN0X3Rlc3QuYyBl
YWNoIHRpbWUgVmVyc2lvbiBmaWxlIGhhcyBiZWVuCj4gPiByZXdyaXR0ZW4sIHdoaWNoIGFjdHVh
bGx5IGhhcHBlbnMgZWFjaCB0aW1lIG1ha2UgaXMgYnVpbGQgaW4gdGhlIHRvcAo+ID4gbGV2ZWwg
ZGlyZWN0b3J5LCB3aGljaCB3b3VsZCBjYXVzZSB1c2VsZXNzIHJlYnVpbGRzLgoKPiA+IFRoZSBi
ZXN0IEkgY291bGQgY2FtZSB1cCB3aXRoOgoKPiA+IC0tLQo+ID4gIGxpYi8uZ2l0aWdub3JlICAg
ICB8ICAyICsrCj4gPiAgbGliL01ha2VmaWxlICAgICAgIHwgMTMgKysrKysrKysrKysrKwo+ID4g
IGxpYi9nZW5fdmVyc2lvbi5zaCB8IDE2ICsrKysrKysrKysrKysrKysKPiA+ICAzIGZpbGVzIGNo
YW5nZWQsIDMxIGluc2VydGlvbnMoKykKPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgbGliLy5naXRp
Z25vcmUKPiA+ICBjcmVhdGUgbW9kZSAxMDA3NTUgbGliL2dlbl92ZXJzaW9uLnNoCgo+ID4gZGlm
ZiAtLWdpdCBhL2xpYi8uZ2l0aWdub3JlIGIvbGliLy5naXRpZ25vcmUKPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cj4gPiBpbmRleCAwMDAwMDAwMDAuLjE3ODg2N2E5NAo+ID4gLS0tIC9kZXYvbnVs
bAo+ID4gKysrIGIvbGliLy5naXRpZ25vcmUKPiA+IEBAIC0wLDAgKzEsMiBAQAo+ID4gK2x0cC12
ZXJzaW9uLmgKPiA+ICtjYWNoZWQtdmVyc2lvbgo+ID4gZGlmZiAtLWdpdCBhL2xpYi9NYWtlZmls
ZSBiL2xpYi9NYWtlZmlsZQo+ID4gaW5kZXggOWI5OTA2ZjI1Li4zNzExMTllZGUgMTAwNjQ0Cj4g
PiAtLS0gYS9saWIvTWFrZWZpbGUKPiA+ICsrKyBiL2xpYi9NYWtlZmlsZQo+ID4gQEAgLTIwLDYg
KzIwLDE5IEBAIHBjX2ZpbGUgICAgICAgICAgICAgICAgICAgICAgOj0KPiA+ICQoREVTVERJUikv
JChkYXRhcm9vdGRpcikvcGtnY29uZmlnL2x0cC5wYwoKPiA+ICBJTlNUQUxMX1RBUkdFVFMgICAg
ICAgICAgICAgICAgOj0gJChwY19maWxlKQoKPiA+ICt0c3RfdGVzdC5vOiBsdHAtdmVyc2lvbi5o
Cj4gPiArCj4gPiArbHRwLXZlcnNpb24uaDogZ2VuX3ZlcnNpb24KPiA+ICsKPiA+ICtNQUtFX1RB
UkdFVFMrPWdlbl92ZXJzaW9uCj4gPiArCj4gPiArLlBIT05ZOiBnZW5fdmVyc2lvbgo+ID4gK2dl
bl92ZXJzaW9uOgo+ID4gKyAgICAgICBAZWNobyBHRU4gbHRwLXZlcnNpb24uaAo+ID4gKyAgICAg
ICBALi9nZW5fdmVyc2lvbi5zaAo+ID4gKwo+ID4gK0NMRUFOX1RBUkdFVFMrPWx0cC12ZXJzaW9u
LmggY2FjaGVkLXZlcnNpb24KPiA+ICsKPiA+ICAkKHBjX2ZpbGUpOgo+ID4gICAgICAgICB0ZXN0
IC1kICIkKEBEKSIgfHwgbWtkaXIgLXAgIiQoQEQpIgo+ID4gICAgICAgICBpbnN0YWxsIC1tICQo
SU5TVEFMTF9NT0RFKSAiJChidWlsZGRpcikvJChARikiICIkQCIKPiA+IGRpZmYgLS1naXQgYS9s
aWIvZ2VuX3ZlcnNpb24uc2ggYi9saWIvZ2VuX3ZlcnNpb24uc2gKPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNzU1Cj4gPiBpbmRleCAwMDAwMDAwMDAuLjdlY2ZiOTA3Nwo+ID4gLS0tIC9kZXYvbnVsbAo+
ID4gKysrIGIvbGliL2dlbl92ZXJzaW9uLnNoCj4gPiBAQCAtMCwwICsxLDE2IEBACj4gPiArIyEv
YmluL3NoCj4gPiArCj4gPiArdG91Y2ggY2FjaGVkLXZlcnNpb247Cj4gPiArCj4gPiAraWYgZ2l0
IGRlc2NyaWJlID4vZGV2L251bGwgMj4mMTsgdGhlbgo+ID4gKyAgICAgICBWRVJTSU9OPWBnaXQg
ZGVzY3JpYmVgCj4gPiArZWxzZQo+ID4gKyAgICAgICBWRVJTSU9OPWBjYXQgJCh0b3Bfc3JjZGly
KS9WRVJTSU9OYAo+ID4gK2ZpCj4gPiArCj4gPiArQ0FDSEVEX1ZFUlNJT049YGNhdCBjYWNoZWQt
dmVyc2lvbmAKPiA+ICsKPiA+ICtpZiBbICIkQ0FDSEVEX1ZFUlNJT04iICE9ICIkVkVSU0lPTiIg
XTsgdGhlbgo+ID4gKyAgICAgICBlY2hvICIkVkVSU0lPTiIgPiBjYWNoZWQtdmVyc2lvbgo+ID4g
KyAgICAgICBlY2hvICIjZGVmaW5lIExUUF9WRVJTSU9OIFwiJFZFUlNJT05cIiIgPiBsdHAtdmVy
c2lvbi5oCgpDeXJpbCwgdGhhbmsgeW91IGZvciB5b3VyIHRpbWUhIExHVE0sIEknbGwgdGVzdCBp
dCBzb29uLgoKPiBXaGF0IHdlIGFyZSBkb2luZyBpbiB0aG9zZSBlZmZvcnRzIGlzIHRvIGhhdmUg
YW4gYXZhaWxhYmxlIG1hY3JvCj4gTFRQX1ZFUlNJT04sIHJpZ2h0PwpZZXMuCgo+IFNvIHdoeSBu
b3QgdXNlIHRoZSBzY3JpcHQgdG8gYXBwZW5kIHRoYXQgb25lIGxpbmUgaW4gdHN0X3Rlc3QuaCBk
aXJlY3RseT8KV2UnZCBoYXZlIHRvIGhhdmUgdHN0X3Rlc3QuaC5pbiB3aGljaCB3b3VsZCBiZSBi
ZSBraW5kIG9mIHNrZWxldG9uIGZvcgp0c3RfdGVzdC5oLiBPdGhlcndpc2UgdHN0X3Rlc3QuaCB3
b3VsZCBiZSBjb25zdGFudGx5ICJtb2RpZmllZCIgYnkgdGhpcyBsaW5lLgoKPiBUaGUgbHRwLXZl
cnNpb24uaCBsb29rcyBxdWl0ZSByZWR1bmRhbnQgYW5kIHdlIGNvdWxkIGV2ZW4gcHV0IHRoaXMg
c2NyaXB0Cj4gaW50byBidWlsZC5zaCB0b2dldGhlciwgSU1ITy4KCkl0IG11c3QgYmUgc29tZWhv
dyBtYWtlIGJhc2VkLCBiZWNhdXNlIG5vdCBldmVyeWJvZHkgdXNlcyBidWlsZC5zaC4KCktpbmQg
cmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
