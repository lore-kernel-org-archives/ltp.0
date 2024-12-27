Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9CAE7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 11:16:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74AA23EE877
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 12:16:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 601033DA1D9
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 12:16:01 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E4DC51010C3B
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 12:15:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 613203368A;
 Fri, 27 Dec 2024 11:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735298158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuI9Kb4zCeWE+d8+28GXlU5/M00405yGebcP3Lu2qsA=;
 b=rAWQJKuBRqkI3bK4O8zrOwEamNDzhKFawZzkJZmvoUDa9HXufzFoCGvnckqO/EgXOluCk9
 4uREleTrCs7i8vUmUpKj/PeM0Y/2cL7XmPqtJ/OmpkxCKsExZfSo0ViVRnynzTK7jwq1Vr
 7NLu/xBNZ0K3ycYw09ta6JvlZF4uwgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735298158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuI9Kb4zCeWE+d8+28GXlU5/M00405yGebcP3Lu2qsA=;
 b=kSWS7sNWY/qnqrubWc0BewWq4ZVXgWy/INHLlodCFPn8zmW+Hwh/jNgfGwCiHI4v+o+Azr
 omT0k4XkMOeRmUAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735298158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuI9Kb4zCeWE+d8+28GXlU5/M00405yGebcP3Lu2qsA=;
 b=rAWQJKuBRqkI3bK4O8zrOwEamNDzhKFawZzkJZmvoUDa9HXufzFoCGvnckqO/EgXOluCk9
 4uREleTrCs7i8vUmUpKj/PeM0Y/2cL7XmPqtJ/OmpkxCKsExZfSo0ViVRnynzTK7jwq1Vr
 7NLu/xBNZ0K3ycYw09ta6JvlZF4uwgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735298158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuI9Kb4zCeWE+d8+28GXlU5/M00405yGebcP3Lu2qsA=;
 b=kSWS7sNWY/qnqrubWc0BewWq4ZVXgWy/INHLlodCFPn8zmW+Hwh/jNgfGwCiHI4v+o+Azr
 omT0k4XkMOeRmUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F9DC13A30;
 Fri, 27 Dec 2024 11:15:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CNbuOm2Mbmf+XwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 11:15:57 +0000
Date: Fri, 27 Dec 2024 12:15:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241227111548.GH317565@pevik>
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-10-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241218184518.16190-10-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 09/13] testcases/kernel/mem: Move KSM bits to ksm
 tests
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

SGkgQ3lyaWwsCgo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9r
c20va3NtX3Rlc3QuaAo+IEBAIC0wLDAgKzEsMjk5IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gKy8qCj4gKyAqIENvcHlyaWdodCAoYykgTGludXgg
VGVzdCBQcm9qZWN0LCAyMDExLTIwMjEKPiArICogQ29weXJpZ2h0IChjKSBDeXJpbCBIcnViaXMg
PGNocnViaXNAc3VzZS5jej4gMjAyNAo+ICsgKi8KPiArI2lmbmRlZiBLU01fVEVTVF8KPiArI2Rl
ZmluZSBLU01fVEVTVF8KPiArCj4gKyNpbmNsdWRlIDxzeXMvd2FpdC5oPgo+ICsKPiArc3RhdGlj
IGlubGluZSB2b2lkIGNoZWNrKGNoYXIgKnBhdGgsIGxvbmcgaW50IHZhbHVlKQo+ICt7Cj4gKwlj
aGFyIGZ1bGxwYXRoW0JVRlNJWl07Cj4gKwlsb25nIGFjdHVhbF92YWw7Cj4gKwo+ICsJc25wcmlu
dGYoZnVsbHBhdGgsIEJVRlNJWiwgUEFUSF9LU00gIiVzIiwgcGF0aCk7Cj4gKwlTQUZFX0ZJTEVf
U0NBTkYoZnVsbHBhdGgsICIlbGQiLCAmYWN0dWFsX3ZhbCk7CgpGWUkgdGhlcmUgaXMgYW4gb2xk
IHdhcm5pbmcgKG5vdCByZWxldmFudCB0byB0aGlzIGNoYW5nZSksIG5vdCBzdXJlIGlmIGl0J3Mg
YW4KZmFsc2UgcG9zaXRpdmUgb3IgaG93IHRvIGZpeCBpdDoKCm1lbS5jOiBJbiBmdW5jdGlvbiDi
gJh3cml0ZV9jcHVzZXRz4oCZOgptZW0uYzo1NTU6NTI6IHdhcm5pbmc6IOKAmC9vbmxpbmXigJkg
ZGlyZWN0aXZlIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcgNyBieXRlcyBpbnRvIGEg
cmVnaW9uIG9mIHNpemUgYmV0d2VlbiAxIGFuZCA4MTkyIFstV2Zvcm1hdC10cnVuY2F0aW9uPV0K
ICA1NTUgfCAgICAgICAgICAgICAgICAgICAgICAgICBzbnByaW50ZihwYXRoMSwgQlVGU0laLCAi
JXMvb25saW5lIiwgcGF0aCk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fiAKCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
