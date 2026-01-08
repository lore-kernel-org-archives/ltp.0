Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB92D185F3
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 13:32:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B66B63C5F55
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 14:32:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 506573C54E7
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 14:31:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 93A50200248
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 14:31:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F14595C669;
 Thu,  8 Jan 2026 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767879109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUa7sWi91grF4G9o6UKWtndXvUgfWt696RjfaIzdwDI=;
 b=ePDPQcRWDwlN+K3OkOX/e5sllPJGecv6WFayn6xvbByBkKJ2n1aBL0kXSGO2eWLwgkjlSZ
 cc/jvyeZFoTcUhv3H/3v5AtpEI0HxxI/MAYcOygSh799Cq5tigM9Kr/9dC/RwFlO7iqMrQ
 TgJXoT5qw6tgnHN5jWPEh09f+xeVUJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767879109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUa7sWi91grF4G9o6UKWtndXvUgfWt696RjfaIzdwDI=;
 b=sY1QW9JNEdFwOdR4d1CcI6S6++++FqLK1PPPXh7KaHq+0eJ7VjiU79jrwbwHd0MHzDJyjR
 SHYU0h2+3aNV0kBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767879108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUa7sWi91grF4G9o6UKWtndXvUgfWt696RjfaIzdwDI=;
 b=wKZDFx3ImY/1u2wbJhB00G3nM0Ku6tMI36pJA5VrqFUbwjvqpTzaWGDq8V3JuiiTQwi0y7
 u4ve9jD/Wsi9LxY56bqyD59beBVqn+XOHpaT7x1CZkr2q5zJc1A5naBgAd41ZETqWeOTnZ
 9CzQCVcv2trnKrd5QaSAUTKRzk9ouJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767879108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUa7sWi91grF4G9o6UKWtndXvUgfWt696RjfaIzdwDI=;
 b=NKyrJCWBEmrBri+FC+MpNZrXzumKC2OyJvYyNGqnGPEJ+RsZXIl/3qaVoVInCIk6Hi+B4k
 St8i7bOpJIF/TBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C62F73EA63;
 Thu,  8 Jan 2026 13:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oA8pL8SxX2ljDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Jan 2026 13:31:48 +0000
Date: Thu, 8 Jan 2026 14:31:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260108133147.GB4263@pevik>
References: <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik>
 <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
 <20251215165247.GC282302@pevik>
 <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
 <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
 <aV6DCbns02E4BCTj@yuki.lan> <20260107160656.GB791855@pevik>
 <aV6G0gxYWHSFkls0@yuki.lan>
 <CAASaF6wOSvi+07Pq5O6+f1Hkrq6WWMgpCaooJxWrO9uOvRM3pw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wOSvi+07Pq5O6+f1Hkrq6WWMgpCaooJxWrO9uOvRM3pw@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
Cc: ltp@lists.linux.it, Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBXZWQsIEphbiA3LCAyMDI2IGF0IDU6MTXigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkhCj4gPiA+IFRoYW5rcyBmb3IgeW91ciBpbnB1dC4gSSB1
bmRlcnN0YW5kIHRoYXQgeW91J3JlIGZvciByZXBsYWNpbmcgaW4gaW9jdGxfbnMwNi5jOgoKPiA+
ID4gICAgICAgaW50IGV4aXN0cyA9IGFjY2VzcygiL3Byb2Mvc2VsZi9ucy91c2VyIiwgRl9PSyk7
Cgo+ID4gPiAgICAgICBpZiAoZXhpc3RzIDwgMCkKPiA+ID4gICAgICAgICAgICAgICB0c3RfcmVz
KFRDT05GLCAibmFtZXNwYWNlIG5vdCBhdmFpbGFibGUiKTsKCj4gPiA+IHdpdGggLm5lZWRzX2tj
b25maWdzOgoKPiA+ID4gICAgICAgLm5lZWRzX2tjb25maWdzID0gKGNvbnN0IGNoYXIgKltdKSB7
Cj4gPiA+ICAgICAgICAgICAgICAgIkNPTkZJR19VU0VSX05TIiwKPiA+ID4gICAgICAgICAgICAg
ICBOVUxMCj4gPiA+ICAgICAgIH0KCj4gPiA+IEJlY2F1c2UgdGhhdCB3YXMgbXkgcXVlc3Rpb24g
LSByZWFsbHkgYWx3YXlzIHByZWZlciBrY29uZmlnIGV2ZW4gdGhlcmUgaXMgYQo+ID4gPiBzaW1w
bGUgcnVudGltZSBzb2x1dGlvbj8gSSdkIGxpa2UgdG8gaGF2ZSBzb21lICJydWxlIiBsaWtlIGNv
bmNsdXNpb24gd2UgY2FuCj4gPiA+IHBvaW50IGR1cmluZyByZXZpZXcuCgo+ID4gSSB0aGluayB0
aGF0IGZyb20gYSBsb25nIHRlcm0gdmlldyB0aGlzIGlzIGdvaW5nIHRvIGJlIHNpbXBsZXIgc29s
dXRpb24KPiA+IHRoYW4gaGF2aW5nIG1hbnkgZGlmZmVyZW50IHR5cGVzIG9mIGNoZWNrcy4gVGhl
IGxlc3MgZGl2ZXJzZSB0aGVzZQo+ID4gY2hlY2tzIGFyZSB0aGUgZWFzaWVyIHRoZXkgYXJlIHRv
IHJldmlldyBhbmQgbWFpbnRhaW4uIEhlbmNlIEkgbGVhbgo+ID4gdG93YXJkcyBrZXJuZWwgY29u
ZmlnIGNoZWNrcyBldmVuIHRob3VnaCB0aGV5IGFyZSBzbG93ZXIgKG1vc3RseQo+ID4gdW5tZWFz
dXJhYmxlIG9uIHRvZGF5J3MgaGFyd2FyZSkgdGhhbiB0aGUgYWx0ZXJuYXRpdmVzLgoKPiBJIHRo
aW5rIEkgbGVhbiBvcHBvc2l0ZSB3YXksIGFuZCByYXRoZXIgaGF2ZSBhIGNoZWNrIGZvciByaWdo
dAo+IGVudmlyb25tZW50IHRvIHN1cHBvcnQgdGhlIHRlc3QuCj4gWW91IGNhbiBoYXZlIGZlYXR1
cmUgWCBlbmFibGVkIGluIGtlcm5lbCBjb25maWcsIGJ1dCBzdGlsbCBkaXNhYmxlZAo+IGxhdGVy
IGF0IGJvb3QvcnVudGltZQo+IChlLmcuIG1heF91c2VyX25hbWVzcGFjZXM9MCksIG9yIGEgbW9k
dWxlIHNpbXBseSBub3QgYmVpbmcgbG9hZGVkLgoKKzEsIGFsbCAidHJpc3RhdGUiIGNvbmZpZ3Vy
ZWQgYXMgbW9kdWxlIG1pZ2h0IGJlIG1pc3NpbmcuIChvcGVuU1VTRSBKZU9TIHN1ZmZlcnMKd2l0
aCB0aGlzIHdoZW4gbWluaW1hbCBrZXJuZWwgaXMgaW5zdGFsbGVkKS4KCkJ1dCAiYm9vbCIgYXJl
IHNhZmUgdW5sZXNzIGRlcGVuZCBvbiAidHJpc3RhdGUiIGNvbmZpZ3VyZWQgYXMgbW9kdWxlIChu
b3QgdGhlCmNhc2Ugb2YgQ09ORklHX1VTRVJfTlMpLgoKS2luZCByZWdhcmRzLApQZXRyCgo+ID4g
LS0KPiA+IEN5cmlsIEhydWJpcwo+ID4gY2hydWJpc0BzdXNlLmN6CgoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
