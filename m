Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88016C3DA6E
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 12:03:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA6563CBDB0
	for <ltp@archiver.kernel.org>; Fri,  5 Jan 2024 13:03:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 183523CBDB0
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 13:03:04 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 193B11A0C241
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 13:03:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14BC01F8B4
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 12:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704456183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8ugih2nfKOYyva9BYoHNf0yBBpjMjaN/8YP5ypO+tk=;
 b=vRVdPo0UTzAliGB+Z2QB+4LV/UW22I7ufAWcyGgBg/TlNUcxFZsrqi0lg/ZXQNAqwvub4p
 29n/fawdVZ7u4gu2xYRC2D3pu54Xu0z5zbULWhBzxD01YLLyXMBboKkPjRdvxHqaq/706W
 WctzgWVyfDYNhNtezSkP0XYM2v0QKOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704456183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8ugih2nfKOYyva9BYoHNf0yBBpjMjaN/8YP5ypO+tk=;
 b=mMouRtd9OS3LU0jVixLKcnV/YqxD/KuuRuGBeVJXojdnF6wehS1ckckmLhA5MtVgDc0fJV
 xGLxvg+N6pbvNvBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704456183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8ugih2nfKOYyva9BYoHNf0yBBpjMjaN/8YP5ypO+tk=;
 b=vRVdPo0UTzAliGB+Z2QB+4LV/UW22I7ufAWcyGgBg/TlNUcxFZsrqi0lg/ZXQNAqwvub4p
 29n/fawdVZ7u4gu2xYRC2D3pu54Xu0z5zbULWhBzxD01YLLyXMBboKkPjRdvxHqaq/706W
 WctzgWVyfDYNhNtezSkP0XYM2v0QKOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704456183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8ugih2nfKOYyva9BYoHNf0yBBpjMjaN/8YP5ypO+tk=;
 b=mMouRtd9OS3LU0jVixLKcnV/YqxD/KuuRuGBeVJXojdnF6wehS1ckckmLhA5MtVgDc0fJV
 xGLxvg+N6pbvNvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB129137E8
 for <ltp@lists.linux.it>; Fri,  5 Jan 2024 12:03:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Zuc2Jvbvl2U2egAAD6G6ig
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 05 Jan 2024 12:03:02 +0000
Date: Fri, 5 Jan 2024 13:03:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240105120300.GA1482331@pevik>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240104204614.1426027-2-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 URIBL_BLOCKED(0.00)[suse.cz:email]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[30.28%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] metaparse: Print parsing file on verbose
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAt
LS0KPiAgbWV0YWRhdGEvbWV0YXBhcnNlLmMgfCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspCgo+IGRpZmYgLS1naXQgYS9tZXRhZGF0YS9tZXRhcGFyc2UuYyBiL21ldGFk
YXRhL21ldGFwYXJzZS5jCj4gaW5kZXggMjM4NGM3M2M4Li5mZTZkNjg5MTEgMTAwNjQ0Cj4gLS0t
IGEvbWV0YWRhdGEvbWV0YXBhcnNlLmMKPiArKysgYi9tZXRhZGF0YS9tZXRhcGFyc2UuYwo+IEBA
IC04NjIsNiArODYyLDkgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKPiAgCQly
ZXR1cm4gMTsKPiAgCX0KCj4gKwlpZiAodmVyYm9zZSkKPiArCQlmcHJpbnRmKHN0ZGVyciwgIlxu
PT09ICVzID09PVxuIiwgYXJndltvcHRpbmRdKTsKPiArCgpUaGlzIGludHJvZHVjZXMgd2Fybmlu
ZzoKCiQgbWFrZSBtZXRhcGFyc2UKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIG1ldGFwYXJzZS5jOjE3
OgpJbiBmdW5jdGlvbiDigJhkYXRhX25vZGVfc3RyaW5n4oCZLAogICAgaW5saW5lZCBmcm9tIOKA
mG1haW7igJkgYXQgbWV0YXBhcnNlLmM6ODk0OjY6CmRhdGFfc3RvcmFnZS5oOjg0OjIwOiB3YXJu
aW5nOiBhcnJheSBzdWJzY3JpcHQg4oCYc3RydWN0IGRhdGFfbm9kZVswXeKAmSBpcyBwYXJ0bHkg
b3V0c2lkZSBhcnJheSBib3VuZHMgb2Yg4oCYdW5zaWduZWQgY2hhcls2XeKAmSBbLVdhcnJheS1i
b3VuZHM9XQogICA4NCB8ICAgICAgICAgbm9kZS0+dHlwZSA9IERBVEFfU1RSSU5HOwogICAgICB8
ICAgICAgICAgfn5+fn5+fn5+fn5efn5+fn5+fn5+fn5+CmRhdGFfc3RvcmFnZS5oOjc5OjM0OiBu
b3RlOiBvYmplY3Qgb2Ygc2l6ZSA2IGFsbG9jYXRlZCBieSDigJhtYWxsb2PigJkKICAgNzkgfCAg
ICAgICAgIHN0cnVjdCBkYXRhX25vZGUgKm5vZGUgPSBtYWxsb2Moc2l6ZSk7CiAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+CkhPU1RDQyBtZXRhZGF0
YS9tZXRhcGFyc2UKCldoYXQgYW0gSSBtaXNzaW5nPwoKPiAgCXJlcyA9IHBhcnNlX2ZpbGUoYXJn
dltvcHRpbmRdKTsKPiAgCWlmICghcmVzKQo+ICAJCXJldHVybiAwOwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
