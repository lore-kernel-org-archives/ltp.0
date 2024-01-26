Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931ABC47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 15:29:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E28BC3D0C06
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 16:29:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AADF43D0613
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 16:29:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 27A2D1011F69
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 16:29:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0E7521225;
 Fri, 26 Jan 2024 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706282981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sj/iyoIl4j1xasQWU5twZH5exDRHUtCpQC4WRaLe758=;
 b=TkKryjBvlmigCx2O1Ld5W5ViFhSh5QNf3bKowffe8s30MTNLP2/6tGXInfyieQe0Pm1w/P
 /00M3mG/osVp+8EsDgI+zz3Jc6cpAWgSZkjmbFS5HucpOMqLF3IwWbc6LejthI9lywEUf+
 2maQPTS9rpaYi5dNnVCVXmR9Shygxx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706282981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sj/iyoIl4j1xasQWU5twZH5exDRHUtCpQC4WRaLe758=;
 b=d180VA405gbiSQ5BER2VIovuGUA4iYQA/GH4RLjfMd0rqJSX3yTVHnPwrs/JN9LgdvSLpG
 gsdlLc8GW+3dhYDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706282980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sj/iyoIl4j1xasQWU5twZH5exDRHUtCpQC4WRaLe758=;
 b=ZEMs9uOkY0MFdbUSpo7F8ZgiT5xNAyPIkWkjxYvePSRwaiI6PwLcjSgHSOJQeGJaSeEL3u
 HXsJzpd+TPJv6lmBmoJvYLl0nQbxhykjXtAYhopf0pjAUSN5faObE5z6Egvbg84KURwctd
 nQQoH3M6DJMntTpfHMf/wRKSzilqOjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706282980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sj/iyoIl4j1xasQWU5twZH5exDRHUtCpQC4WRaLe758=;
 b=1+VZA7qwbia8BCIg7WNd+DPPY2aw9OvBl1GGPcx10+puP17TIHkl5kuDSmhP0mWotEwPKA
 P//xLrEjDYHwmcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9288134C3;
 Fri, 26 Jan 2024 15:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y2VPMuTPs2WiBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Jan 2024 15:29:40 +0000
Date: Fri, 26 Jan 2024 16:29:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZbPP8pdtXnOsgA5Q@yuki>
References: <20240126111506.491324-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240126111506.491324-1-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[22.47%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lapi/io_uring: <sys/types.h> =>
 <linux/types.h>
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

SGkhCj4gVGhpcyBmaXhlcyBjb21waWxhdGlvbiBvbiBvbGQgdG9vbGNoYWluczoKPiAKPiBTb21l
IG9sZCB0b29sY2hhaW5zIHJlcXVpcmUgdG8gYWRkIDxsaW51eC90eXBlcy5oPiB0byBtaXNzaW5n
IGtlcm5lbAo+IHR5cGVzOgo+IAo+IHRzdF9zYWZlX2lvX3VyaW5nLmM6IEluIGZ1bmN0aW9uIOKA
mHNhZmVfaW9fdXJpbmdfaW5pdOKAmToKPiB0c3Rfc2FmZV9pb191cmluZy5jOjM0OjQ1OiBlcnJv
cjog4oCYX191MzLigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4g
ICAgMzQgfCAgICAgICAgICAgICAgICAgcGFyYW1zLT5zcV9lbnRyaWVzICogc2l6ZW9mKF9fdTMy
KTsKPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xn5+fn4KPiAKPiBpb191cmluZzAyLmM6IEluIGZ1bmN0aW9uIOKAmGRyYWluX2ZhbGxiYWNr4oCZ
Ogo+IGlvX3VyaW5nMDIuYzoxMDY6MzQ6IGVycm9yOiDigJhfX3U2NOKAmSB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKPiAgIDEwNiB8ICAgICAgICAgICAgICAgICBzcWVf
cHRyLT5hZGRyID0gKF9fdTY0KSZzcGFtX2hlYWRlcjsKPiAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+Cj4gaW9fdXJpbmcwMi5jOjEwNjozNDogbm90ZTogZWFj
aCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1
bmN0aW9uIGl0IGFwcGVhcnMgaW4KPiBpb191cmluZzAyLmM6IEluIGZ1bmN0aW9uIOKAmHJ1buKA
mToKPiBpb191cmluZzAyLmM6MjIxOjI2OiBlcnJvcjog4oCYX191NjTigJkgdW5kZWNsYXJlZCAo
Zmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4gICAyMjEgfCAgICAgICAgIHNxZV9wdHItPmFk
ZHIgPSAoX191NjQpJmJlZWZfaGVhZGVyOwo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+Cj4gCj4gTmV3ZXIga2VybmVsIGhlYWRlcnMgaW5jbHVkZXMgPGxpbnV4L3R5cGVz
Lmg+IGluIDxsaW51eC9pb191cmluZy5oPiwgYnV0Cj4gd2Ugc3RpbGwgc3VwcG9ydCBjb21waWxl
cnMgd2l0aG91dCB0aGlzIGhlYWRlci4gVGhlcmVmb3JlIHJlcGxhY2UKPiA8c3lzL3R5cGVzLmg+
IGluIGxhcGkgaGVhZGVyIHdpdGggPGxpbnV4L3R5cGVzLmg+LgoKSSBkaWQgbG9vayB0d2ljZSBh
bmQgd2UgZG8gbm90IHNlZW0gdG8gdXNlIGFueXRoaW5nIGZyb20gdGhlCjxzeXMvdHlwZXMuaD4g
aW4gdGhlIGhlYWRlciwgc28gdGhpcyBzaG91bGQgYmUgc2FmZS4KClJldmlld2VkLWJ5OiBDeXJp
bCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNl
LmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
