Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0766CC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:41:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F3EA3C7B03
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:41:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA16F3C2204
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:40:53 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78E5C626D79
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:40:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95C151F387;
 Fri, 17 Jan 2025 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737110451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBSLEq/lX5CjYOlJFmrKKF8GSHB0Xtb2n97eWceaPQU=;
 b=JuS9yilAhDUZFMDi6RaiaF5X+ToZL3ZuSay52vlsuKrd+tz6aHyhP9O+k//G49UhQDYSgG
 qt0DV2QJWy7cCZuWoCE69v4q1vThIz7RyT9cDpmLqwb0Ax42d1RMJ5wZAhdCjTfHjoDwxn
 w3UbqEexViW16myDo51uO6MmzWHNXk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737110451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBSLEq/lX5CjYOlJFmrKKF8GSHB0Xtb2n97eWceaPQU=;
 b=2qfgItXg64O1KW7keFTu/UxK5UFZKqRICcxDTKLOnEWYu5oLupW8SjjIFtHh+0BVP1X/jn
 vsbnA0QFO6OlALBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JuS9yilA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2qfgItXg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737110451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBSLEq/lX5CjYOlJFmrKKF8GSHB0Xtb2n97eWceaPQU=;
 b=JuS9yilAhDUZFMDi6RaiaF5X+ToZL3ZuSay52vlsuKrd+tz6aHyhP9O+k//G49UhQDYSgG
 qt0DV2QJWy7cCZuWoCE69v4q1vThIz7RyT9cDpmLqwb0Ax42d1RMJ5wZAhdCjTfHjoDwxn
 w3UbqEexViW16myDo51uO6MmzWHNXk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737110451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBSLEq/lX5CjYOlJFmrKKF8GSHB0Xtb2n97eWceaPQU=;
 b=2qfgItXg64O1KW7keFTu/UxK5UFZKqRICcxDTKLOnEWYu5oLupW8SjjIFtHh+0BVP1X/jn
 vsbnA0QFO6OlALBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A00513332;
 Fri, 17 Jan 2025 10:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id goJvCrMzimeqHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 10:40:51 +0000
Date: Fri, 17 Jan 2025 11:40:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250117104041.GA753841@pevik>
References: <20250114124023.4702-1-wegao@suse.com>
 <20250114143217.21018-1-wegao@suse.com>
 <20250114143217.21018-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250114143217.21018-3-wegao@suse.com>
X-Rspamd-Queue-Id: 95C151F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] ptrace06: Refactor the test using new LTP
 API
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

SGkgV2VpLAoKLi4uCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvcHRyYWNlL3B0cmFjZTA2X2NoaWxkLmMKPiBAQCAtMCwwICsxLDE2IEBACj4gKy8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gKy8qCj4gKyAqIENvcHly
aWdodCAoYykgMjAxOCBMaW51eCBUZXN0IFByb2plY3QKPiArICogQ29weXJpZ2h0IChDKSAyMDE1
IEN5cmlsIEhydWJpcyBjaHJ1YmlzQHN1c2UuY3oKPiArICovCj4gKwo+ICsjZGVmaW5lIFRTVF9O
T19ERUZBVUxUX01BSU4KPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gKwo+ICtpbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQoKcHRyYWNlMDZfY2hpbGQuYzoxMDoxNDogd2FybmluZzog
dW51c2VkIHBhcmFtZXRlciDigJhhcmdj4oCZIFstV3VudXNlZC1wYXJhbWV0ZXJdCiAgIDEwIHwg
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKCj4gK3sKPiArCm5pdDogZW1wdHkgbGlu
ZSBeCj4gKwl0c3RfcmVzKFRQQVNTLCAiJXMgZXhlY3V0ZWQiLCBhcmd2WzBdKTsKPiArCj4gKwly
ZXR1cm4gMDsKPiArfQoKSSBzdWdnZXN0IHRvIG1lcmdlIHRoZSBwYXRjaHNldCB3aXRoIHRoaXMg
Y2hhbmdlIGluIHRoaXMgY29tbWl0LgoKQEN5cmlsOiBDYW4gSSBhZGQgeW91ciBSQlQ/CgpLaW5k
IHJlZ2FyZHMsClBldHIKCisrKyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3B0cmFjZS9wdHJh
Y2UwNl9jaGlsZC5jCkBAIC03LDkgKzcsOCBAQAogI2RlZmluZSBUU1RfTk9fREVGQVVMVF9NQUlO
CiAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKIAotaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3Zb
XSkKK2ludCBtYWluKGludCBhcmdjIExUUF9BVFRSSUJVVEVfVU5VU0VELCBjaGFyICphcmd2W10p
CiB7Ci0KIAl0c3RfcmVzKFRQQVNTLCAiJXMgZXhlY3V0ZWQiLCBhcmd2WzBdKTsKIAogCXJldHVy
biAwOwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
