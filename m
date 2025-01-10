Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB82E77188
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 17:13:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21C23C3179
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 18:13:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6B9C3C1D33
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 18:13:20 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8EA407C64ED
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 18:13:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 022652115B;
 Fri, 10 Jan 2025 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736529195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXDWZ20+ZuA1xNF49yZzHzLijXGJHFitfuGONtcFN+4=;
 b=k1t9uq8ahl5iLidbUUjBKY/eY04VHFDN0Mdy8hARImNUAKE3bnk1z9bX3N8livKTbdN69m
 /XUsqADA+PQwytPOZ1z9WTIMdX+AMKPCq1xSaBN2RPyEqyNX7mYOwfj3uCf72lfaUSYUlb
 CHR40lq0heXpnmY8LjuiLiflBLr4zVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736529195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXDWZ20+ZuA1xNF49yZzHzLijXGJHFitfuGONtcFN+4=;
 b=b/aNa4QP+3IvoQK8QmxPh4SwRLjYIajxXzk/TSGUJqM7RMUwYKZgjGLcBjsqDDr2PDBuL5
 wTTbID0XK0XxXDDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736529195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXDWZ20+ZuA1xNF49yZzHzLijXGJHFitfuGONtcFN+4=;
 b=k1t9uq8ahl5iLidbUUjBKY/eY04VHFDN0Mdy8hARImNUAKE3bnk1z9bX3N8livKTbdN69m
 /XUsqADA+PQwytPOZ1z9WTIMdX+AMKPCq1xSaBN2RPyEqyNX7mYOwfj3uCf72lfaUSYUlb
 CHR40lq0heXpnmY8LjuiLiflBLr4zVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736529195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXDWZ20+ZuA1xNF49yZzHzLijXGJHFitfuGONtcFN+4=;
 b=b/aNa4QP+3IvoQK8QmxPh4SwRLjYIajxXzk/TSGUJqM7RMUwYKZgjGLcBjsqDDr2PDBuL5
 wTTbID0XK0XxXDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA65F13763;
 Fri, 10 Jan 2025 17:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fe5NMCpVgWekKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jan 2025 17:13:14 +0000
Date: Fri, 10 Jan 2025 18:13:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250110171304.GB413134@pevik>
References: <20250109130032.50480-1-liwang@redhat.com>
 <CAEemH2e2D2xW5zJZsqUo8+f8Ta1GYUKCE4jNeaHECBbVmbY0TA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e2D2xW5zJZsqUo8+f8Ta1GYUKCE4jNeaHECBbVmbY0TA@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: redefine the overall timeout logic of test
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

SGkgTGksIEN5cmlsLAoKV2UgaGF2ZSBzb21lIHdhcm5pbmdzIGR1ZSB0aGlzIGNoYW5nZToKLQlp
bnQgbWF4X3J1bnRpbWU7CisJdW5zaWduZWQgaW50IHJ1bnRpbWU7Cgp0c3RfdGVzdC5jOiBJbiBm
dW5jdGlvbiDigJh0c3RfcmVtYWluaW5nX3J1bnRpbWXigJk6CnRzdF90ZXN0LmM6MTY5MTozMDog
d2FybmluZzogY29tcGFyaXNvbiBvZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVudCBz
aWduZWRuZXNzOiDigJh1bnNpZ25lZCBpbnTigJkgYW5kIOKAmGludOKAmSBbLVdzaWduLWNvbXBh
cmVdCiAxNjkxIHwgICAgICAgICBpZiAocmVzdWx0cy0+cnVudGltZSA+IGVsYXBzZWQpCiAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCnRzdF90ZXN0LmM6IEluIGZ1bmN0aW9u
IOKAmHNldF9vdmVyYWxsX3RpbWVvdXTigJk6CnRzdF90ZXN0LmM6MTcyMDozMDogd2FybmluZzog
Y29tcGFyaXNvbiBvZiB1bnNpZ25lZCBleHByZXNzaW9uIGluIOKAmDwgMOKAmSBpcyBhbHdheXMg
ZmFsc2UgWy1XdHlwZS1saW1pdHNdCiAxNzIwIHwgICAgICAgICBpZiAocmVzdWx0cy0+cnVudGlt
ZSA8IDApIHsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkkgc3VwcG9z
ZSB3ZSBkb24ndCBuZWVkIHRoaXMgY2hlY2sgYW55IG1vcmU6CgoJaWYgKHJlc3VsdHMtPnJ1bnRp
bWUgPCAwKSB7CgkJdHN0X2JyayhUQlJPSywgInJ1bnRpbWUgbXVzdCB0byBiZSA+IDAhICglZCki
LAoJCQlyZXN1bHRzLT5ydW50aW1lKTsKCX0KCmJlY2F1c2UgVFNUX1VOTElNSVRFRF9USU1FT1VU
IGlzIG5vdyB0ZXN0ZWQgYWdhaW5zdCB0c3RfdGVzdC0+dGltZW91dC4KCkNvdWxkIHlvdSBwbGVh
c2UgZml4IGl0IGJlZm9yZSBtZXJnZT8KCj4gPiAgdGltZW91dDogRGVmaW5lcyB0aGUgbWF4aW11
bSB0aW1lIGFsbG93ZWQgZm9yIHRoZSBlbnRpcmUgdGVzdCwgaW5jbHVkaW5nCj4gPiAgICAgICAg
ICAgc2V0dXAsIGV4ZWN1dGlvbiwgYW5kIGNsZWFudXAsIHdoZW4gbm8gZXhwbGljaXQgcnVudGlt
ZSBpcyBzZXQuCj4gPiAJICBCdXQgaWYgYSBydW50aW1lIGlzIGV4cGxpY2l0bHkgZGVmaW5lZCBh
bmQgdHN0X3JlbWFpbmluZ19ydW50aW1lKCkKPiA+IAkgIGlzIHVzZWQsIHRoZSB0aW1lb3V0IGFw
cGxpZXMgb25seSB0byB0aGUgc2V0dXAgYW5kIGNsZWFudXAgcGhhc2VzLAo+ID4gCSAgYXMgdGhl
IHJ1bnRpbWUgY29udHJvbHMgdGhlIHRlc3QgZXhlY3V0aW9uIGR1cmF0aW9uLgoKPiA+ICBydW50
aW1lOiBUaGUgbWF4aW11bSBydW50aW1lIG9mIHRoZSB0ZXN0J3MgbWFpbiBleGVjdXRpb24gbG9v
cCwgdXNlZAo+ID4gICAgICAgICAgIGluIHRlc3RzIHRoYXQgY2FsbCB0c3RfcmVtYWluaW5nX3J1
bnRpbWUoKS4gSXQgZW5zdXJlcyB0aGUKPiA+IAkgIG1haW4gZXhlY3V0aW9uIHJ1bnMgZm9yIGEg
Zml4ZWQgZHVyYXRpb24sIHJlZ2FyZGxlc3Mgb2Yga2VybmVsCj4gPiAJICBjb25maWd1cmF0aW9u
IChlLmcuLCBkZWJ1ZyBrZXJuZWwpLgoKSWYgSSBsb29rIGNvcnJlY3RseSBhdG0gd2UgaGF2ZSBu
b25lIHRlc3RzIHdpdGggYm90aCAudGltZW91dCBhbmQgLnJ1bnRpbWUuCgpJTUhPIG9ubHkgdGVz
dHMgd2l0aCB0c3RfcmVtYWluaW5nX3J1bnRpbWUoKSBvciBmdXp6eSBzeW5jIHNob3VsZCB1c2Ug
LnJ1bnRpbWUuCgpXaGVuIEkgY2hlY2s6CgokIGdpdCBncmVwIC1sIC1lIHRzdF9yZW1haW5pbmdf
cnVudGltZSAtZSB0c3RfZnV6enlfc3luYy5oICQoZ2l0IGxvZyAtLW9uZWxpbmUgLS1wcmV0dHk9
ImZvcm1hdDoiIC0tbmFtZS1vbmx5IC0xKSB8d2MgLWwKNjAKCiQgZ2l0IGdyZXAgICdcLnJ1bnRp
bWUnICQoZ2l0IGxvZyAtLW9uZWxpbmUgLS1wcmV0dHk9ImZvcm1hdDoiIC0tbmFtZS1vbmx5IC0x
KSB8d2MgLWwKNjAKCnRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVhZGFoZWFkL3JlYWRhaGVh
ZDAyLmMgdXNlcyAucnVudGltZSBidXQgKGFzIEN5cmlsCm5vdGVkKSB5b3Ugd2FudGVkIHRvIGFk
ZCBpdCAudGltZW91dCAoSSBhbHNvIHRoaW5rIGl0IHNob3VsZCB1c2UgLnRpbWVvdXQpLgoKQnV0
IHRlc3RjYXNlcy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFydmF0aW9uLmMgY2FsbHMK
dHN0X3JlbWFpbmluZ19ydW50aW1lKCkgYnV0IGl0J3Mgd2l0aG91dCAucnVudGltZS4gRG9uJ3Qg
d2Ugd2FudCB0byBzZXQgaXQ/CgpBbHNvIGl0IGdvdCBUQ09ORiBwcmV2aW91c2x5LCBJIG1pZ2h0
IHRyeSB0byBwdXQgaXQgYmFjayBhZnRlciB0aGlzIGlzIG1lcmdlZC4KCk9yIGJldHRlciBmb3Ig
d2hvbGUgdHJlZToKJCBnaXQgZ3JlcCAtbCAtZSB0c3RfcmVtYWluaW5nX3J1bnRpbWUgLWUgdHN0
X2Z1enp5X3N5bmMuaCB0ZXN0Y2FzZXMvIHx3YyAtbAo1NAoKJCBnaXQgZ3JlcCAtbCAnXC5ydW50
aW1lJyB0ZXN0Y2FzZXMvIHx3YyAtbAo1MwoKVGhlIGRpZmZlcmVuY2UgaXMgd2l0aCB0ZXN0Y2Fz
ZXMva2VybmVsL2lvL2x0cC1haW9kaW8vY29tbW9uLmggYW5kIGFsbCB0ZXN0cwp3aGljaCB1c2Ug
aXQgdXNlIC5ydW50aW1lLgoKPT4gZXZlcnl0aGluZyBsb29rcyBvay4KCj4gPiBPdmVyYWxsIHRp
bWVvdXQgaXMgc3RydWN0dXJlZCBhcyBmb2xsb3dzOgoKPiA+IHwgLS0gKGRlZmF1bHRfMzBzICsg
dGltZW91dCkgKiB0aW1lb3V0X211bCAtLSB8IC0tIHJ1bnRpbWUgKiBydW50aW1lX211bCAtLSB8
CgpJIGxpa2UgdGhlIGRpYWdyYW0gOikuIExhdGVyIG1heWJlIGl0IGNvdWxkIGJlIGFkZGVkIHRv
IHRzdF9yZW1haW5pbmdfcnVudGltZSgpLAp3aGljaCBkb2VzIG5vdCB1c2Ugc3BoaW54IGRvYyBi
dXQgaXQncyB1c2VkIGJ5IG1hbnkgdGVzdHMuIEFsc28sIG92ZXJhbGwgdGltZW91dAp3b3VsZCBk
ZXNlcnZlIG1vdmluZyBmcm9tIGRvYy9vbGQvQy1UZXN0LUFQSS5hc2NpaWRvYyB0byBzb21lIHNw
ZWNpZmljIHBhZ2UgaW4Kc3BoaW54IChtYXliZSBwYXJ0IG9mIGxpYi9SRUFETUUubWQgY29udmVy
c2lvbikuCgo+ICsgKiAgICAgICAgICAgc2V0IHRvIGEgc3VmZmljaWVudGx5bGFyZ2UgdmFsdWUg
b3IgVFNUX1VOTElNSVRFRF9USU1FT1VUIHRvIHJlbW92ZQptaXNzaW5nIHNwYWNlOgogICAgKiAg
ICAgICAgICAgc2V0IHRvIGEgc3VmZmljaWVudGx5IGxhcmdlIHZhbHVlIG9yIFRTVF9VTkxJTUlU
RURfVElNRU9VVCB0byByZW1vdmUKCkNvdWxkIHlvdSBwbGVhc2UgZml4IGl0IGJlZm9yZSBtZXJn
ZT8KClJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KCj4gPiAqIE1vdmUg
LnJ1bnRpbWUgdG8gLnRpbWVvdXQgZm9yIHNvbWUgdGVzdHMgKGZzcGxvdWdoLCBrc20wMiwga3Nt
MDQpCkZZSSBmc3Bsb3VnaCB1c2VzIHRzdF9zZXRfdGltZW91dCgpIG9ubHkuCgo+ID4gKiBEcm9w
IHRoZSBjaGFuZ2VzIG9uIHNoZWxsIHRlc3QgdGVzdF90aW1lb3V0LnNoCgpJIHdvbmRlciB3aGF0
IHRvIGRvIHdpdGggc2hlbGwgdGltZW91dCBpbiB0aGUgZnV0dXJlLiBOb3QgbmVlZGVkIHRvIGJl
IGNoYW5nZWQ/Cgo+ID4gLQlpZiAocmVzdWx0cy0+bWF4X3J1bnRpbWUgPT0gVFNUX1VOTElNSVRF
RF9SVU5USU1FKSB7Cj4gPiArCWlmICh0c3RfdGVzdC0+dGltZW91dCA9PSBUU1RfVU5MSU1JVEVE
X1RJTUVPVVQpIHsKPiA+ICAJCXRzdF9yZXMoVElORk8sICJUaW1lb3V0IHBlciBydW4gaXMgZGlz
YWJsZWQiKTsKCj4gK2FkZGl0aW9uYWwgc2FmZXR5IG1hcmdpbi4gSWYgdGVzdCB3aXRob3V0IGFu
IGV4cGxpY2l0IHJ1bnRpbWUsIHRoZSAndGltZW91dCcKbml0OiBJIHdvdWxkIGZvcm1hdCBhbHNv
ICdydW50aW1lJwogICthZGRpdGlvbmFsIHNhZmV0eSBtYXJnaW4uIElmIHRlc3Qgd2l0aG91dCBh
biBleHBsaWNpdCAncnVudGltZScsIHRoZSAndGltZW91dCcKCk1heWJlIHdlIGNvdWxkIHVuaWZ5
IGFsc28gdGhpcyBjb21taXQgbWVzc2FnZSB0bzoKCglpZiAodHN0X3Rlc3QtPnRpbWVvdXQgPT0g
VFNUX1VOTElNSVRFRF9USU1FT1VUKSB7CgkJdHN0X3JlcyhUSU5GTywgIlRlc3QgdGltZW91dCBp
cyBub3QgbGltaXRlZCIpOwoJCXJldHVybjsKCX0KCgo+IFRvIHBhdGNoIHJldmlld2VyOgoKPiBM
b29rcyBsaWtlIHRoaXMgcGF0Y2ggZmVsbCBiZWhpbmQgdGhlIGxhc3Qgb25lIGNvbW1pdCBmMTYy
YmZmMGFmMTljZTdkN2YzLAo+IHBsZWFzZSBkcm9wIHRoYXQgb25lIG1hbnVhbGx5IGlmIHlvdSB3
YW50IHRvIGFwcGx5IGl0IHdpdGhvdXQgY29uZmxpY3RzCj4gbG9jYWxseS4KCj4gSSB3aWxsIGRv
IGNvZGUgcmViYXNlIG9uY2UgZ2V0dGluZyBlbm91Z2ggUmV2aWV3ZWQtYnkgdGFncy4KCkknbSBz
b3JyeSBmb3IgbWVyZ2luZyBmMTYyYmZmMGFmMTljZTdkN2YzLiBJIHN1cHBvc2UgcmViYXNlIG1h
c3RlciBzaG91bGQgYmUgb2suCgpGb3IgbWUgd29ya2VkIHdpdGhvdXQgdGhlIG5lZWQgdG8gcmVz
b2x2ZSB0aGUgY29uZmxpY3Q6CmdpdCBjaGVja291dCBmMTYyYmZmMGFmMTljZTdkN2YzfgpnaXQg
YW0gWU9VUl9QQVRDSC5tYm94CmdpdCByZWJhc2UgbWFzdGVyCgpLaW5kIHJlZ2FyZHMsClBldHIK
Cj4gTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
