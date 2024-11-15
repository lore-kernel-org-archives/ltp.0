Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA70D6DDE3
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 14:00:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3D013D772E
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 15:00:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E0DB3D76B7
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 15:00:15 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 101F361F8F1
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 15:00:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D46BD1F79D;
 Fri, 15 Nov 2024 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731679213;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Qr1EEXUJk35NYEmSBwkp2pvoiQZqlsNLon3PmN+7Vc=;
 b=yT2eMo4aAMtSwcAIJ68IgljtC061QkziWubvJY0u8yFV+V8xuQqwDu94gUmV2RUkXmhWFH
 Pe5bDRqO2GO1IHT3IRfKfjjRbU7ZX23gYK3idtdyRwxsoGY4Y/P7/6cTT3+pdmtgHiSXIe
 SrPYhWEYMNcp+O7Iaat3a/86243BqWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731679213;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Qr1EEXUJk35NYEmSBwkp2pvoiQZqlsNLon3PmN+7Vc=;
 b=mFVOH06giYWY1xSJuC5z/Kvfmot0DS3t/JV88qRXp8fOd1N4cQ5nxjNAtPyQmT5LYefpkm
 CqSvMJ+aoJyPkPAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731679211;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Qr1EEXUJk35NYEmSBwkp2pvoiQZqlsNLon3PmN+7Vc=;
 b=agW7WypqhPmob5E1DH/XDLOoDlSg857ZXtEtF+MHYyff090BERrZJ3YU4V9h6m8ake6m/L
 YoyvU6Fvbhc7BmxuEQ0GYD1SGX3U+Sy5pIM5blZ6m3xywBLp+fZR5ZQHZVbMFB16vU1iGV
 vqQhikqof0eaylKpv52xBS6HTgcZEA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731679211;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Qr1EEXUJk35NYEmSBwkp2pvoiQZqlsNLon3PmN+7Vc=;
 b=PCvRvL4/MiZUJOVq+jiExhmhxdK+s7XajqA6C5JT2/2sPFZ9mXXg8PLUlUsMoSLVdQsIBo
 SgBmdk69a/f3b3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 845B5134B8;
 Fri, 15 Nov 2024 14:00:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ymjLHOtTN2eoHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Nov 2024 14:00:11 +0000
Date: Fri, 15 Nov 2024 15:00:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20241115140005.GD1718754@pevik>
References: <20241114144029.349559-1-pvorel@suse.cz>
 <20241114144029.349559-4-pvorel@suse.cz>
 <CAASaF6z3quzaFkgo47SZgpPxK=Ny_2f3C07LR7=8eVFrTa6CfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6z3quzaFkgo47SZgpPxK=Ny_2f3C07LR7=8eVFrTa6CfQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] mq_timedsend01: Workaround segfault on libc
 variant on 32 bit
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

SGkgSmFuLAoKPiBPbiBUaHUsIE5vdiAxNCwgMjAyNCBhdCAzOjQw4oCvUE0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEVGQVVMVCB0ZXN0IHNlZ2ZhdWx0cyBvbiBuZXdl
ciBrZXJuZWxzIChlLmcuIDYuNCkgb24gbGliYyB2YXJpYW50IG9uCj4gPiAzMmJpdC4gIFNpbWls
YXJseSB0byAxZDRkNWEwNzUwIHVzZSB0eXBpY2FsIExUUCB3b3JrYXJvdW5kIHRvIHRlc3QgYnkK
PiA+IGZvcmtlZCBjaGlsZCArIGNoZWNraW5nIHRoZSB0ZXJtaW5hdGluZyBzaWduYWwuCi4uLgo+
ID4gK3N0YXRpYyB2b2lkIHRlc3RfYmFkX2FkZHIodW5zaWduZWQgaW50IGkpCj4gPiArewo+ID4g
KyAgICAgICBzdHJ1Y3QgdGltZTY0X3ZhcmlhbnRzICp0diA9ICZ2YXJpYW50c1t0c3RfdmFyaWFu
dF07Cj4gPiArICAgICAgIHBpZF90IHBpZDsKPiA+ICsgICAgICAgaW50IHN0YXR1czsKPiA+ICsK
PiA+ICsgICAgICAgcGlkID0gU0FGRV9GT1JLKCk7Cj4gPiArICAgICAgIGlmICghcGlkKSB7Cj4g
PiArICAgICAgICAgICAgICAgdmVyaWZ5X21xdF9zZW5kX3JlY2VpdmUoaSwgcGlkKTsKPiA+ICsg
ICAgICAgICAgICAgICBfZXhpdCgwKTsKPiA+ICsgICAgICAgfQo+ID4gKwo+ID4gKyAgICAgICBT
QUZFX1dBSVRQSUQocGlkLCAmc3RhdHVzLCAwKTsKPiA+ICsKPiA+ICsgICAgICAgaWYgKFdJRkVY
SVRFRChzdGF0dXMpICYmICFXRVhJVFNUQVRVUyhzdGF0dXMpKQo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybjsKPiA+ICsKPiA+ICsgICAgICAgaWYgKHR2LT50c190eXBlID09IFRTVF9MSUJDX1RJ
TUVTUEVDICYmCj4gPiArICAgICAgICAgICAgICAgV0lGU0lHTkFMRUQoc3RhdHVzKSAmJiBXVEVS
TVNJRyhzdGF0dXMpID09IFNJR1NFR1YpIHsKPiA+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRQ
QVNTLCAiQ2hpbGQga2lsbGVkIGJ5IGV4cGVjdGVkIHNpZ25hbCIpOwo+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybjsKPiA+ICsgICAgICAgfQo+ID4gKwo+ID4gKyAgICAgICB0c3RfcmVzKFRGQUlM
LCAiQ2hpbGQgJXMiLCB0c3Rfc3Ryc3RhdHVzKHN0YXR1cykpOwo+ID4gK30KPiA+ICsKPiA+ICtz
dGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBpKQo+ID4gK3sKPiA+ICsgICAgICAgc3Ry
dWN0IHRpbWU2NF92YXJpYW50cyAqdHYgPSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRdOwo+ID4gKyAg
ICAgICBjb25zdCBzdHJ1Y3QgdGVzdF9jYXNlICp0YyA9ICZ0Y2FzZVtpXTsKPiA+ICsgICAgICAg
dW5zaWduZWQgaW50IGo7Cj4gPiArICAgICAgIHBpZF90IHBpZCA9IC0xOwo+ID4gKwo+ID4gKyAg
ICAgICB0c3RfdHNfc2V0X3NlYygmdHMsIHRjLT50dl9zZWMpOwo+ID4gKyAgICAgICB0c3RfdHNf
c2V0X25zZWMoJnRzLCB0Yy0+dHZfbnNlYyk7Cj4gPiArCj4gPiArICAgICAgIGlmICh0Yy0+YmFk
X3RzX2FkZHIpIHsKCj4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBydW4gYmFkX21zZ19hZGRyL0VG
QVVMVCB0ZXN0IGFsc28gaW4gY2hpbGQ/CgpGaXJzdCwgdGhhbmtzIGEgbG90IGEgcmV2aWV3LgpJ
J20gbm90IHN1cmUgbXlzZWxmLiBTbyBmYXIgaXQncyBub3QgbmVlZGVkIChwcm9ibGVtIGlzIG9u
bHkgd2l0aCBzdHJ1Y3QKdGltZXNwZWMgKmFic190aW1lb3V0IG5vdCB3aXRoIGNvbnN0IGNoYXIg
bXNnX3B0cltdKS4gQnV0IE9UT0ggaXQgZG9lcyBub3QKaGFybS4gRG9pbmcgdGhpcyBtaWdodCBw
cmV2ZW50IHNvbWUgZmFpbHVyZSBpbiB0aGUgZnV0dXJlLgoKS2luZCByZWdhcmRzLApQZXRyCgo+
ID4gKyAgICAgICAgICAgICAgIHRlc3RfYmFkX2FkZHIoaSk7Cj4gPiArICAgICAgICAgICAgICAg
cmV0dXJuOwo+ID4gKyAgICAgICB9Ci4uLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
