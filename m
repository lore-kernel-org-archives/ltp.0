Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B23C5478C
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 11:52:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE1523D1923
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 12:52:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 487AB3CE07F
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 12:52:16 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4F6686002EC
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 12:52:15 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4FDF202B3;
 Fri,  1 Mar 2024 11:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709293934;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jP31hCVjWWJI9vhaoMPMA6aWt5/8aV8yC4NTLjfOeTk=;
 b=pvnVIHqXzAdriooRerGm6jY+9ZVMtLwHCrxMz7PK9ujnFwOa0zY2dPm2KiyKtCDWJAN8Ok
 +oCSiBT9LgotLnL49JV2D20OQZnau7dybh7fs8BKtrWX8rIMrld1+Lgnfta/sZl9pUmloW
 kOqax48FZsfPWrajXZ43sRHz8FkhviA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709293934;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jP31hCVjWWJI9vhaoMPMA6aWt5/8aV8yC4NTLjfOeTk=;
 b=YKCrwQkAWRhDUSYXgx6PxpxAUy+fE0n3Qrr9NqppRHI2r5PySeVq4JwpTa+McUUYNKOkSf
 bLC2t3PM1X+/gJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709293934;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jP31hCVjWWJI9vhaoMPMA6aWt5/8aV8yC4NTLjfOeTk=;
 b=pvnVIHqXzAdriooRerGm6jY+9ZVMtLwHCrxMz7PK9ujnFwOa0zY2dPm2KiyKtCDWJAN8Ok
 +oCSiBT9LgotLnL49JV2D20OQZnau7dybh7fs8BKtrWX8rIMrld1+Lgnfta/sZl9pUmloW
 kOqax48FZsfPWrajXZ43sRHz8FkhviA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709293934;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jP31hCVjWWJI9vhaoMPMA6aWt5/8aV8yC4NTLjfOeTk=;
 b=YKCrwQkAWRhDUSYXgx6PxpxAUy+fE0n3Qrr9NqppRHI2r5PySeVq4JwpTa+McUUYNKOkSf
 bLC2t3PM1X+/gJAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BC8FD13581;
 Fri,  1 Mar 2024 11:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id amhIK27B4WXKOgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Mar 2024 11:52:14 +0000
Date: Fri, 1 Mar 2024 12:52:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240301115213.GD1661970@pevik>
References: <20240221084256.32661-1-wegao@suse.com>
 <20240222031018.12281-1-wegao@suse.com>
 <20240222031018.12281-3-wegao@suse.com>
 <CAEemH2deWNk7F_d+TPvX7M2gbCeiPsjdHKmHb06WtfpAp0OLBA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2deWNk7F_d+TPvX7M2gbCeiPsjdHKmHb06WtfpAp0OLBA@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[50.38%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] statx07.c: set umask to 0
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

PiBPbiBUaHUsIEZlYiAyMiwgMjAyNCBhdCAxMToxMeKAr0FNIFdlaSBHYW8gdmlhIGx0cCA8bHRw
QGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKCj4gPiBXaGVuIHN5c3RlbSdzIGRlZmF1bHQgdW1hc2sg
aXMgMDA3NywgdGhpcyB3aWxsIHRyaWdnZXIgZm9sbG93aW5nIGlzc3VlczoKPiA+IHN0YXR4MDcu
YzoxMDg6IFRGQUlMOiBzdGF0eCgpIHdpdGggQVRfU1RBVFhfRE9OVF9TWU5DIGZvciBtb2RlIDY0
NCA2MDAKCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiA+IC0t
LQo+ID4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdHgvc3RhdHgwNy5jIHwgMiArKwo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCj4gPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zdGF0eC9zdGF0eDA3LmMKPiA+IGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9zdGF0eC9zdGF0eDA3LmMKPiA+IGluZGV4IDRkYmY4M2UxOC4uMjI3YzMz
Yzk2IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zdGF0eC9zdGF0
eDA3LmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdHgvc3RhdHgwNy5j
Cj4gPiBAQCAtMTE2LDYgKzExNiw4IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiAgICAg
ICAgIGludCByZXQ7Cj4gPiAgICAgICAgIGNoYXIgc2VydmVyX3BhdGhbQlVGRl9TSVpFXTsKCj4g
PiArICAgICAgIHVtYXNrKDApOwo+ID4gKwo+ID4gICAgICAgICBjd2QgPSB0c3RfZ2V0X3RtcGRp
cigpOwoKPiA+ICAgICAgICAgU0FGRV9NS0RJUihTRVJWX1BBVEgsIERFRkFVTFRfTU9ERSk7CgoK
PiBCZXR0ZXIgdG8gcmVzdG9yZSB0aGUgb2xkIG1hc2sgcmlnaHQgYWZ0ZXIuCgorMSwgV2VpLCBj
YW4geW91IHBsZWFzZSBzZW5kIG5ldyB2ZXJzaW9uPwoKPiBPdGhlcndpc2UgbG9va3MgZ29vZC4K
CktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
