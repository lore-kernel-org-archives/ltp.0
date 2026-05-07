Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F700CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:32:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E59C93E6A69
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:32:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A007F3E2C33
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:32:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 23A551A001E0
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:32:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 711BD5D770;
 Thu,  7 May 2026 08:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778142755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PiS8ntp4QSWyS2bwMqR4q0aFHRNBydk7UQ0jF/kfJw=;
 b=eQoE5mU3WR3oDAi8dSz8lI1tJX81+l8y4VpncSc2WhicZycgiZmN02cs5juKeyJoQz8mnu
 fEB7XlcOaMuDpXa1Qt8/4/lS4tBvapdg1xmRKdvJK6scV5pL67RNVoXKXixBiy2uLDsxMv
 BZ+m/lSYC38J1Tgli1WM+9aQaJO1gUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778142755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PiS8ntp4QSWyS2bwMqR4q0aFHRNBydk7UQ0jF/kfJw=;
 b=OLdGL+ADZ7fvmOyo9J8TZJYTkfEli9SV8x9wqCLHfwVZSMhyqAlnfHTcPRZChkr8Z3fUdD
 aV+imS+389TAW4Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778142755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PiS8ntp4QSWyS2bwMqR4q0aFHRNBydk7UQ0jF/kfJw=;
 b=eQoE5mU3WR3oDAi8dSz8lI1tJX81+l8y4VpncSc2WhicZycgiZmN02cs5juKeyJoQz8mnu
 fEB7XlcOaMuDpXa1Qt8/4/lS4tBvapdg1xmRKdvJK6scV5pL67RNVoXKXixBiy2uLDsxMv
 BZ+m/lSYC38J1Tgli1WM+9aQaJO1gUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778142755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PiS8ntp4QSWyS2bwMqR4q0aFHRNBydk7UQ0jF/kfJw=;
 b=OLdGL+ADZ7fvmOyo9J8TZJYTkfEli9SV8x9wqCLHfwVZSMhyqAlnfHTcPRZChkr8Z3fUdD
 aV+imS+389TAW4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 380BB593A7;
 Thu,  7 May 2026 08:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tzCJCSNO/GmfSAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 07 May 2026 08:32:35 +0000
Message-ID: <47b59750-b00c-4f04-956b-38d1695e2ffa@suse.de>
Date: Thu, 7 May 2026 10:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260411092452.211540-1-rbranco@suse.de>
 <20260415080623.164440-1-rbranco@suse.de> <afjANI7jr23hP4IJ@yuki.lan>
 <bc75c487-59db-47a8-a2f3-db860919b35b@suse.de> <afjb4yWvM8Abh98q@yuki.lan>
 <f834cba1-003e-4751-9a84-ddb6a21c282e@suse.de> <afndbbVfw4hV3c5i@yuki.lan>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <afndbbVfw4hV3c5i@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Use two-step handshake to probe
 features
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiA1LzUvMjYgMjowNyBQTSwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+IEhpIQo+Pj4gSG93ZXZl
ciBJIHdvdWxkIHB1dCB0aGlzIGNvZGUgaW50byBhIGNvbW1vbiBoZWFkZXIgYW5kIGNhbGwgaXQg
b25seSBpbgo+Pj4gdGhlIHRlc3Qgc2V0dXAgKHNvIHRoYXQgaXQncyBub3QgZXhlY3V0ZWQgb24g
ZWFjaCB0ZXN0IGl0ZXJhdGlvbikuCj4+Pgo+Pj4gI2RlZmluZSBDSEVDS19VRkZEX0ZMQUcoZmxh
ZykgZG8geyBcCj4+PiAgICAgICAgICAgLi4uIFwKPj4+IAlpZiAoISh1ZmZkaW9fYXBpLmZlYXR1
cmVzICYgKGZsYWcpKSkgXAo+Pj4gCQl0c3RfYnJrKFRDT05GLCAjZmxhZyAiIG5vdCBzdXBwb3J0
ZWQiKTsgXAo+Pj4gCS4uLiBcCj4+PiB9IHdoaWxlICgwKQo+Pj4KPj4gV2lsbCBhZGQgdGhpcyBt
YWNyby7CoCBMZXQncyBrZWVwIGRvaW5nIHRoZSAyIHN0ZXAgaGFuZHNoYWtlIHRob3VnaC4KPiBT
dXJlLCBzb3VuZHMgZ29vZCB0byBtZS4KPgpKdXN0IGRpZCBpdCBpbiBhIDItcGFydCB2My4KCkNo
ZWVycywKUgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
