Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236BEC47DD9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 09:35:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BD5A3CB170
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 10:35:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D5233CB170
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 10:35:00 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4243F60F154
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 10:34:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2DD805FC16;
 Fri, 22 Mar 2024 09:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711100098;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZrAR5/R2UZ6LvEactb0nB8yp4Kd56LAzendoCbpyn8=;
 b=LpiP3Kl2OVVMklPf6tFrmU2/K2uTzLuNU1SJeDrhmBPRNiOtJHrCX8yspcuKq5XdT5PF8x
 9NQh5kkkHCPHxMKDYdJjVXr/pwAQN7zgs0dbVaGKJRfXVG9E4z0IICofhGPTIxnY32DkLm
 pnR7tkMApyJxDXbdYeX6rLGPJiQcMFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711100098;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZrAR5/R2UZ6LvEactb0nB8yp4Kd56LAzendoCbpyn8=;
 b=HqZVP/goRdQuukcKu2CAWRWxl4d9QVDWw778R43b5fEoxm8AVoeU9eq7VJM/Xf3200Q8+3
 QhJupXaho0H4rgDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711100098;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZrAR5/R2UZ6LvEactb0nB8yp4Kd56LAzendoCbpyn8=;
 b=LpiP3Kl2OVVMklPf6tFrmU2/K2uTzLuNU1SJeDrhmBPRNiOtJHrCX8yspcuKq5XdT5PF8x
 9NQh5kkkHCPHxMKDYdJjVXr/pwAQN7zgs0dbVaGKJRfXVG9E4z0IICofhGPTIxnY32DkLm
 pnR7tkMApyJxDXbdYeX6rLGPJiQcMFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711100098;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZrAR5/R2UZ6LvEactb0nB8yp4Kd56LAzendoCbpyn8=;
 b=HqZVP/goRdQuukcKu2CAWRWxl4d9QVDWw778R43b5fEoxm8AVoeU9eq7VJM/Xf3200Q8+3
 QhJupXaho0H4rgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16AF7136AD;
 Fri, 22 Mar 2024 09:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fg/aBMJQ/WWWSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 22 Mar 2024 09:34:58 +0000
Date: Fri, 22 Mar 2024 10:34:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20240322093452.GA604328@pevik>
References: <fae6ad10f98ab50a1a3e362706d65ea13fdda3ff.1711044800.git.jstancek@redhat.com>
 <cf3287a8009ab6104a4dec45b7b8160f35a358b0.1711045522.git.jstancek@redhat.com>
 <20240322051132.GB572447@pevik>
 <CAASaF6wqF_avAiziA-OSEfoAi6n9xCPeEERNu=OswCa078_1YA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wqF_avAiziA-OSEfoAi6n9xCPeEERNu=OswCa078_1YA@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.84 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.34)[76.09%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/timer_getoverrun01: use
 kernel_timer_t type
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBGcmksIE1hciAyMiwgMjAyNCBhdCA2OjEx4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEphbiwKCj4gPiAuLi4KPiA+ID4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy90aW1lcl9nZXRvdmVycnVuL3RpbWVyX2dldG92ZXJydW4wMS5jCj4g
PiA+IEBAIC0xOSwxMCArMTksMTEgQEAKPiA+ID4gICNpbmNsdWRlIDx0aW1lLmg+Cj4gPiA+ICAj
aW5jbHVkZSAidHN0X3NhZmVfY2xvY2tzLmgiCj4gPiA+ICAjaW5jbHVkZSAibGFwaS9zeXNjYWxs
cy5oIgo+ID4gPiArI2luY2x1ZGUgImxhcGkvY29tbW9uX3RpbWVycy5oIgoKPiA+ID4gIHN0YXRp
YyB2b2lkIHJ1bih2b2lkKQo+ID4gPiAgewo+ID4gPiAtICAgICB0aW1lcl90IHRpbWVyOwo+ID4g
PiArICAgICBrZXJuZWxfdGltZXJfdCB0aW1lcjsKCj4gPiBHb29kIGNhdGNoLgo+ID4gUmV2aWV3
ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKPiA+IEJUVyBpbiB2MSB5b3UgdXNl
ZCBtZW1zZXQoJnRpbWVyLCAwLCBzaXplb2YodGltZXJfdCkpOwo+ID4gQ291bGQgaGF2ZSB3ZSB1
c2VkIHdpdGggY3VycmVudCBjb21waWxlcnMganVzdCB0aW1lcl90IHRpbWVyID0ge30gaW5zdGVh
ZCBvZgo+ID4gbWVtc2V0KCk/IE9yIHdoYXQgaXMgdGhlIHJlYXNvbiB3ZSBrZWVwIHVzaW5nIG1l
bXNldCgpIGluc3RlYWQgb2Yge30/Cgo+IEkgdHJlYXRlZCBpdCBhcyBvcGFxdWUgdHlwZS4gSWYg
aXQgd2FzIGEgc2NhbGFyLCBwbGFpbiB7fSBkb2Vzbid0IHdvcmsgd2l0aCBhbGwKPiBjb21waWxl
cnMuIEZvciBleGFtcGxlIHRoaXMgZmFpbHMgdG8gY29tcGlsZSBmb3IgbWUgd2l0aCBnY2MgMTE6
Cj4gaW50IG1haW4oKSB7IGludCBpID0ge307IHJldHVybiBpOyB9Cgo+ICQgZ2NjICAtV3BlZGFu
dGljIGEuYwo+IGEuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKPiBhLmM6MToyMjogd2Fybmlu
ZzogSVNPIEMgZm9yYmlkcyBlbXB0eSBpbml0aWFsaXplciBicmFjZXMgWy1XcGVkYW50aWNdCj4g
ICAgIDEgfCBpbnQgbWFpbigpIHsgaW50IGkgPSB7fTsgcmV0dXJuIGk7IH0KPiAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgIF4KPiBhLmM6MToyMjogZXJyb3I6IGVtcHR5IHNjYWxhciBpbml0
aWFsaXplcgo+IGEuYzoxOjIyOiBub3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3Ig4oCYaeKA
mSkKCj4gInswfSIgc2hvdWxkIHdvcmsgLSBJIGd1ZXNzIEkgd2FzIGp1c3QgYmVpbmcgdG9vIGNh
cmVmdWwuCgpUaGFua3MgZm9yIGluZm8sIEphbi4gSSBzdXBwb3NlIHRoZSBwcm9ibGVtIGlzIGFs
c28gb24gb2xkZXIKZ2NjIChub3RoaW5nIGdjYyAxMSBzcGVjaWZpYykuIFdlIGNvbXBpbGUgYWxz
byBvbiBnY2MgNC44IGFuZCA3LjMuCgpJcyBpdCBhbHNvIHByb2JsZW0gZm9yIG9sZGVyIGNsYW5n
PwoKSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSBpdCBzaG91bGQgYmUgc2FmZSB0byB1c2UgezB9
LCBhbmQge30gcHJvYmFibHkgd2FpdHMKZm9yIHRoZSBmdXR1cmUuCgpLaW5kIHJlZ2FyZHMsClBl
dHIKCj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQZXRyCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
