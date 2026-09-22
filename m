Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01A4C98302
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 17:37:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03A343E6CE8
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 19:37:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A5753E5364
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 19:37:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A5DE1000A57
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 19:37:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 812591F8BB;
 Tue, 22 Sep 2026 17:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790098632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIGkeZ1eE5dwO3ghtDru57Byrf5xieqEAphLxCduwAo=;
 b=JSPBwjTI6hj8OM8Xt71IOjwTeMknxeubYCwPlZ2YdKDE5V6cYf7GPgd+mvWnfey4sAu8+M
 GWboMJpeF8i8UzY93JpNU92B/Xi8ic66zL2nwfRAHevv0QeQ8oQN/7BjyDM/PLikGvr+li
 O6l9XPq280ca8L8FvJ9pThwab5VLfOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790098632;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIGkeZ1eE5dwO3ghtDru57Byrf5xieqEAphLxCduwAo=;
 b=QeFTlnPjvAhfVOGi7ckRVyH7V0Bpp5FRNffTf4NsEnAlZ0/Mm/OcbRakg/QqYKoaTHs+xO
 k9vcQLArhMRQFVAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790098628;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIGkeZ1eE5dwO3ghtDru57Byrf5xieqEAphLxCduwAo=;
 b=KE6iJLit4epwmqmJsK9w3Dz5jB4PrXsOIfFmn4oReFuf5Wd9x2tjchTm49ao/e0MDRnuRx
 swhvx/XcVFzaTLAp4uv9gh9pWeOngNIiXHKA0l/w5sHc9Ei3I3XZvgUMFASgNmsdkfIqgf
 UUUH7oZAhJEUjOLCN0T7Wb4mWz1Wo4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790098628;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIGkeZ1eE5dwO3ghtDru57Byrf5xieqEAphLxCduwAo=;
 b=Huwe8wAkT/LqtLgrJKRv653xB1OCf6zYdzwqo96Lzijs3vB/y1CJp6mruHnd45Qo6tI4g+
 dj7Y8PfsNFAT/1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B845132D3;
 Tue, 22 Sep 2026 17:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /6Z9N8O8smpfBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 17:37:08 +0000
Date: Tue, 22 Sep 2026 19:36:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260922173658.GC2287170@pevik>
References: <apgVur5s_potD6ND@yuki.lan>
 <20260902160113.1207205-1-nirmoyd@nvidia.com>
 <aqlkQAUnD06oQ5KR@yuki.lan>
 <DM6PR12MB40280BDE504322942351D8F5C2B92@DM6PR12MB4028.namprd12.prod.outlook.com>
 <CAASaF6y3QWQ--uJBWiizRC8AGo30TbzTWWXB=EameXje3diisA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6y3QWQ--uJBWiizRC8AGo30TbzTWWXB=EameXje3diisA@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 REDIRECTOR_URL(0.00)[aka.ms]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linux.it:email,suse.cz:email,suse.cz:replyto,outlook.com:url,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getrusage03: account for percpu RSS counter
 batching
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
Cc: Nirmoy Das <nirmoyd@nvidia.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTmlybW95LCBKYW4sIGFsbCwKCndvdWxkIHlvdSBoYXZlIHRpbWUgdG8gbG9vayBvbiB0aGlz
IGdldHJ1c2FnZTAzIGZhaWx1cmUgb24gYWFyY2g2ND8KCkkgZ3Vlc3MgdGhpcyBvbmUgWzFdIGlz
IGNsb3NlciB0aGFuIHRoZSBvbmUgZnJvbSBKYW4gWzJdLgoKSSdtIG5vdCBzdXJlIGlmIHdlIGhh
dmUgdGltZSB0byBmaXggdGhpcyBiZWZvcmUgTFRQIHJlbGVhc2UgKEkgZ3Vlc3MgQ3lyaWwgcGxh
bnMKaXQgc29tZXRpbWVzIG5leHQgd2VlaykgYnV0IGl0J2QgYmUgd29ydGggdG8gZml4IGl0IGV2
ZW4gYWZ0ZXIgdGhlIHJlbGVhc2UuCgpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L2x0cC9wYXRjaC8yMDI2MDkwMjE2MDExMy4xMjA3MjA1LTEtbmlybW95ZEBudmlkaWEu
Y29tLwpbMl0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2x0cC9wYXRjaC9h
MzA4ZTEyMTk4Y2U5NjMwNTc2MWEwMDk4NThmYTRhODBjOTFmOTMyLjE3ODg1MTg4NTAuZ2l0Lmpz
dGFuY2VrQHJlZGhhdC5jb20vCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gT24gV2VkLCBTZXAgMTYs
IDIwMjYgYXQgNTo1OeKAr1BNIE5pcm1veSBEYXMgPG5pcm1veWRAbnZpZGlhLmNvbT4gd3JvdGU6
Cgo+ID4gSGkgQ3lyaWwsCgo+ID4gSSB0ZXN0ZWQgSmFu4oCZcyBwYXRjaCBvbiBhIG1hY2hpbmUg
IHdpdGggMzUyIG9ubGluZSBDUFVzIGFuZCA2NCBLaUIgcGFnZXMuIFBpbm5pbmcgd2FzIGNvbmZp
cm1lZCwgYnV0IGJvdGggdGhlCj4gPiBiYXNlbGluZSBhbmQgSmFu4oCZcyBwYXRjaCBmYWlsZWQg
MTAvMTAgcnVuczoKCj4gPiBjaGlsZC5jaGlsZHJlbiA9IDI3MDMzNiwgZXhwZWN0ZWQgMzA3MjAw
Cgo+ID4gUGlubmluZyBrZWVwcyB0aGUgYWxsb2NhdGlvbiB1cGRhdGVzIG9uIG9uZSBDUFUsIGJ1
dCBnZXRfbW1fY291bnRlcigpCj4gPiBzdGlsbCByZWFkcyBvbmx5IHRoZSBnbG9iYWwgY291bnQu
IE9uZSBiYXRjaCBoZXJlIGlzCj4gPiBtYXgoMzIsIDM1MiAqIDIpID0gNzA0IHBhZ2VzLCBvciA0
NTA1NiBLaUIuIFRoZSAzNjg2NCBLaUIgc2hvcnRmYWxsCj4gPiBmaXRzIHdpdGhpbiB0aGF0IGJh
dGNoIGJ1dCBleGNlZWRzIHRoZSBleGlzdGluZyAyMDQ4MCBLaUIgREVMVEFfTUFYLgoKPiA+IEkg
YWxzbyB0ZXN0ZWQgYSBzbWFsbCBmb2xsb3ctdXAgdGhhdCBpbmNyZWFzZXMgb25seSB0aGUgbG93
ZXIgYWxsb3dhbmNlCj4gPiBmb3IgdGhlIDEwMCwgMzAwIGFuZCA0MDAgTWlCIGNoZWNrcy4gSXQg
cGFzc2VkIDEwLzEwIHJ1bnMsIHdpdGggYWxsIG5pbmUKPiA+IHN1YnRlc3RzIHBhc3NpbmcgZWFj
aCB0aW1lLgoKPiA+IEkgd2lsbCBzZW5kIHRoaXMgZm9sbG93LXVwIG9uY2UgSmFu4oCZcyBwYXRj
aCBpcyBtZXJnZWQuCgo+IEJhc2VkIG9uIHlvdXIgdGVzdHMgaXQgZG9lcyBzb3VuZCBsaWtlIGl0
J3MgYW4gaW5jb21wbGV0ZSBmaXgsIHNvCj4gSSdkIHN1Z2dlc3QgeW91IG1vZGlmeSBpdCBhcyB5
b3Ugc2VlIGZpdCwgYW5kIHNlbmQgdjIuCgo+IFRoYW5rcywKPiBKYW4KCgo+ID4gUmVnYXJkcywK
PiA+IE5pcm1veQoKPiA+IEZyb206IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+ID4g
RGF0ZTogVHVlc2RheSwgMTUuIFNlcHRlbWJlciAyMDI2IGF0IDE3OjI5Cj4gPiBUbzogTmlybW95
IERhcyA8bmlybW95ZEBudmlkaWEuY29tPgo+ID4gQ2M6IGx0cEBsaXN0cy5saW51eC5pdCA8bHRw
QGxpc3RzLmxpbnV4Lml0PjsgSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyXSBnZXRydXNhZ2UwMzogYWNjb3VudCBmb3IgcGVyY3B1IFJT
UyBjb3VudGVyIGJhdGNoaW5nCgo+ID4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBj
aHJ1YmlzQHN1c2UuY3ouIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2Fr
YS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQoKPiA+IEhpIQo+ID4gPiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTAzLmMKPiA+
ID4gaW5kZXggYTJjZGQ2MTU4Li4zOGExMDA1NzYgMTAwNjQ0Cj4gPiA+IC0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTAzLmMKPiA+ID4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMuYwo+ID4gPiBAQCAt
MTMsOSArMTMsMTMgQEAKPiA+ID4gICAqIHRoaXMgcHJvZ3JhbS4KPiA+ID4gICAqLwoKPiA+ID4g
KyNkZWZpbmUgX0dOVV9TT1VSQ0UKPiA+ID4gICNpbmNsdWRlIDxzdGRsaWIuaD4KPiA+ID4gICNp
bmNsdWRlIDxzdGRpby5oPgoKPiA+ID4gKyNpbmNsdWRlICJsYXBpL2NwdXNldC5oIgo+ID4gPiAr
I2luY2x1ZGUgInRzdF9zYWZlX3N0ZGlvLmgiCj4gPiA+ICsjaW5jbHVkZSAidHN0X2NwdS5oIgo+
ID4gPiAgI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gPiA+ICAjaW5jbHVkZSAiZ2V0cnVzYWdlMDMu
aCIKCj4gPiA+IEBAIC0yMywxMiArMjcsOTkgQEAKCj4gPiA+ICBzdGF0aWMgc3RydWN0IHJ1c2Fn
ZSBydTsKPiA+ID4gIHN0YXRpYyBsb25nIG1heHJzc19pbml0Owo+ID4gPiArc3RhdGljIGxvbmcg
bG93ZXJfYWxsb3dhbmNlOwoKPiA+ID4gIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCByZXNvdXJj
ZVtdID0gewo+ID4gPiAgICAgICBURVNUQklOLAo+ID4gPiAgICAgICBOVUxMLAo+ID4gPiAgfTsK
Cj4gPiA+ICtzdGF0aWMgbG9uZyBjb3VudF9vbmxpbmVfY3B1cyh2b2lkKQo+ID4gPiArewo+ID4g
PiArICAgICBGSUxFICpmcCA9IFNBRkVfRk9QRU4oIi9wcm9jL3N0YXQiLCAiciIpOwo+ID4gPiAr
ICAgICBjaGFyIGxpbmVbQlVGU0laXTsKPiA+ID4gKyAgICAgbG9uZyBjb3VudCA9IDA7Cj4gPiA+
ICsKPiA+ID4gKyAgICAgd2hpbGUgKGZnZXRzKGxpbmUsIHNpemVvZihsaW5lKSwgZnApKSB7Cj4g
PiA+ICsgICAgICAgICAgICAgaWYgKGxpbmVbMF0gPT0gJ2MnICYmIGxpbmVbMV0gPT0gJ3AnICYm
IGxpbmVbMl0gPT0gJ3UnICYmCj4gPiA+ICsgICAgICAgICAgICAgICAgIGxpbmVbM10gPj0gJzAn
ICYmIGxpbmVbM10gPD0gJzknKQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgY291bnQrKzsK
PiA+ID4gKyAgICAgfQo+ID4gPiArCj4gPiA+ICsgICAgIGlmIChmZXJyb3IoZnApKQo+ID4gPiAr
ICAgICAgICAgICAgIHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJmZ2V0cygvcHJvYy9zdGF0KSIp
Owo+ID4gPiArCj4gPiA+ICsgICAgIFNBRkVfRkNMT1NFKGZwKTsKPiA+ID4gKwo+ID4gPiArICAg
ICBpZiAoIWNvdW50KQo+ID4gPiArICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJObyBvbmxp
bmUgQ1BVcyBmb3VuZCBpbiAvcHJvYy9zdGF0Iik7Cj4gPiA+ICsKPiA+ID4gKyAgICAgcmV0dXJu
IGNvdW50Owo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICtzdGF0aWMgdm9pZCBwaW5fdG9fY3B1KHZv
aWQpCj4gPiA+ICt7Cj4gPiA+ICsgICAgIGxvbmcgbmNwdXMgPSB0c3RfbmNwdXNfbWF4KCk7Cj4g
PiA+ICsgICAgIHNpemVfdCBzaXplID0gQ1BVX0FMTE9DX1NJWkUobmNwdXMpOwo+ID4gPiArICAg
ICBjcHVfc2V0X3QgKm1hc2sgPSBDUFVfQUxMT0MobmNwdXMpOwo+ID4gPiArICAgICBpbnQgY3B1
ID0gLTE7Cj4gPiA+ICsKPiA+ID4gKyAgICAgaWYgKCFtYXNrKQo+ID4gPiArICAgICAgICAgICAg
IHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJDUFVfQUxMT0MoKSIpOwo+ID4gPiArCj4gPiA+ICsg
ICAgIENQVV9aRVJPX1Moc2l6ZSwgbWFzayk7Cj4gPiA+ICsgICAgIGlmIChzY2hlZF9nZXRhZmZp
bml0eSgwLCBzaXplLCBtYXNrKSA8IDApIHsKPiA+ID4gKyAgICAgICAgICAgICBDUFVfRlJFRSht
YXNrKTsKPiA+ID4gKyAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAic2NoZWRf
Z2V0YWZmaW5pdHkoKSIpOwo+ID4gPiArICAgICB9Cj4gPiA+ICsKPiA+ID4gKyAgICAgZm9yIChs
b25nIGkgPSAwOyBpIDwgbmNwdXM7IGkrKykgewo+ID4gPiArICAgICAgICAgICAgIGlmIChDUFVf
SVNTRVRfUygoaW50KWksIHNpemUsIG1hc2spKSB7Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBjcHUgPSAoaW50KWk7Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ID4g
KyAgICAgICAgICAgICB9Cj4gPiA+ICsgICAgIH0KPiA+ID4gKwo+ID4gPiArICAgICBpZiAoY3B1
IDwgMCkgewo+ID4gPiArICAgICAgICAgICAgIENQVV9GUkVFKG1hc2spOwo+ID4gPiArICAgICAg
ICAgICAgIHRzdF9icmsoVEJST0ssICJzY2hlZF9nZXRhZmZpbml0eSgpIHJldHVybmVkIGFuIGVt
cHR5IENQVSBtYXNrIik7Cj4gPiA+ICsgICAgIH0KPiA+ID4gKwo+ID4gPiArICAgICBDUFVfWkVS
T19TKHNpemUsIG1hc2spOwo+ID4gPiArICAgICBDUFVfU0VUX1MoY3B1LCBzaXplLCBtYXNrKTsK
PiA+ID4gKyAgICAgaWYgKHNjaGVkX3NldGFmZmluaXR5KDAsIHNpemUsIG1hc2spIDwgMCkgewo+
ID4gPiArICAgICAgICAgICAgIENQVV9GUkVFKG1hc2spOwo+ID4gPiArICAgICAgICAgICAgIHRz
dF9icmsoVEJST0sgfCBURVJSTk8sICJzY2hlZF9zZXRhZmZpbml0eSgpIik7Cj4gPiA+ICsgICAg
IH0KPiA+ID4gKwo+ID4gPiArICAgICBDUFVfRlJFRShtYXNrKTsKPiA+ID4gK30KPiA+ID4gKwo+
ID4gPiArc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiA+ID4gK3sKPiA+ID4gKyAgICAgbG9uZyBv
bmxpbmVfY3B1cyA9IGNvdW50X29ubGluZV9jcHVzKCk7Cj4gPiA+ICsgICAgIGxvbmcgYmF0Y2gg
PSBNQVgoMzJMLCBvbmxpbmVfY3B1cyAqIDIpOwo+ID4gPiArICAgICBsb25nIHBhZ2Vfc2l6ZSA9
IFNBRkVfU1lTQ09ORihfU0NfUEFHRVNJWkUpOwo+ID4gPiArICAgICBsb25nIGJhdGNoX2tpYiA9
IGJhdGNoICogcGFnZV9zaXplIC8gMTAyNDsKPiA+ID4gKwo+ID4gPiArICAgICBsb3dlcl9hbGxv
d2FuY2UgPSBNQVgoMjAgKiAxMDI0TCwgYmF0Y2hfa2liKTsKPiA+ID4gKyAgICAgaWYgKGxvd2Vy
X2FsbG93YW5jZSA+PSAxMDI0MDBMKQo+ID4gPiArICAgICAgICAgICAgIHRzdF9icmsoVENPTkYs
ICJQZXItQ1BVIFJTUyBhbGxvd2FuY2UgaXMgdG9vIGxhcmdlOiAlbGkgS2lCIiwKPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIGxvd2VyX2FsbG93YW5jZSk7Cgo+ID4gQXMgbG9uZyBhcyB3ZSBw
aW4gdG8gYSBzaW5nbGUgQ1BVIHRoZSB3aG9sZSBiYXRjaCBhY2NvdW50aW5nIHNob3VsZG4ndAo+
ID4gYmUgbmVlZGVkLgoKPiA+IEZZSSBKYW4gc2VuZCBhIHNpbWlsYXIgcGF0Y2ggdGhhdCBqdXN0
IHBpbnMgdGhlIHByb2Nlc3MgdG8gYSBzaW5nbGUgQ1BVOgoKPiA+IGh0dHBzOi8vbmFtMTEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGNod29y
ay5rZXJuZWwub3JnJTJGcHJvamVjdCUyRmx0cCUyRnBhdGNoJTJGYTMwOGUxMjE5OGNlOTYzMDU3
NjFhMDA5ODU4ZmE0YTgwYzkxZjkzMi4xNzg4NTE4ODUwLmdpdC5qc3RhbmNlayU0MHJlZGhhdC5j
b20lMkYmZGF0YT0wNSU3QzAyJTdDbmlybW95ZCU0MG52aWRpYS5jb20lN0M1Yzg4ZmM0ZTU0OTA0
MzA1NjliMDA4ZGYxMzNlMTRmMyU3QzQzMDgzZDE1NzI3MzQwYzFiN2RiMzllZmQ5Y2NjMTdhJTdD
MCU3QzAlN0M2MzkyNTA4Mjk1MzE3NzM1NTYlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJY
QjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtG
T0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPXFPa1dRN1Zz
VndGUzM4UzF6UWd4dWU1ZW84a05xVUolMkJFSGw0ck44MHFJUSUzRCZyZXNlcnZlZD0wCgo+ID4g
QXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhhdCBzaG91bGQgYmUgZW5vdWdoIHRvIGZpeCB0aGUgdGVz
dC4KCj4gPiAtLQo+ID4gQ3lyaWwgSHJ1YmlzCj4gPiBjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
