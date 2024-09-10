Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722FEECE564
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 10:13:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E06A13C1A84
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 12:13:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 334C13C0E9B
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 12:13:01 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 854B760298F
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 12:13:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 71CF01F7CF;
 Tue, 10 Sep 2024 10:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725963179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oY7KahOMWSZGJC4j+88a+UF3cECqaO31R+0rT8y/83s=;
 b=e2m4mUgJo3FWTWvlFUSMkcj4Xm6MjoxjSteyFU6NzKXzSC5Pjy9ISF7nhejNJ2uZtPj9bq
 aDfi5S8DusTJlt112Q0T5uj/G4jGf3ovVs2GpaCM3CY0zSegYU88BbvGXudQ4CC7Aw85FW
 tmh8Anxf4ZhzMNPaG0gSzfAnpo74v/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725963179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oY7KahOMWSZGJC4j+88a+UF3cECqaO31R+0rT8y/83s=;
 b=9Geup2+0pGsUnNQSvjcay1sUPdujGZ+mBBbsYc/aos6uhSX2RbBHS4Y0JC/2T3urlbOmFz
 JuN9/E8cH/wiRFDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725963179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oY7KahOMWSZGJC4j+88a+UF3cECqaO31R+0rT8y/83s=;
 b=e2m4mUgJo3FWTWvlFUSMkcj4Xm6MjoxjSteyFU6NzKXzSC5Pjy9ISF7nhejNJ2uZtPj9bq
 aDfi5S8DusTJlt112Q0T5uj/G4jGf3ovVs2GpaCM3CY0zSegYU88BbvGXudQ4CC7Aw85FW
 tmh8Anxf4ZhzMNPaG0gSzfAnpo74v/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725963179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oY7KahOMWSZGJC4j+88a+UF3cECqaO31R+0rT8y/83s=;
 b=9Geup2+0pGsUnNQSvjcay1sUPdujGZ+mBBbsYc/aos6uhSX2RbBHS4Y0JC/2T3urlbOmFz
 JuN9/E8cH/wiRFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F103132CB;
 Tue, 10 Sep 2024 10:12:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m7s0Fqsb4Ga0WwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 10 Sep 2024 10:12:59 +0000
Date: Tue, 10 Sep 2024 12:11:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <ZuAbaUHY8ZPjN5ey@yuki.lan>
References: <20240910094755.57438-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240910094755.57438-1-maxj.fnst@fujitsu.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] posix/conformance/interfaces/sem_timedwait/2-1:
 add _GNU_SOURCE define
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

SGkhCj4gVG8gZ2V0IHJpZCBvZiBlcnJvciAi4oCYTUFQX0FOT05ZTU9VU+KAmSB1bmRlY2xhcmVk
IChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikiCj4gb24gc29tZSBzeXN0ZW1zIChGZWRvcmEg
MzcsIGV0YykuCgpUaGF0IGRvZXMgbm90IHNvdW5kIHJpZ2h0LCB0aGUgb3BlbiBwb3NpeCB0ZXN0
c3VpdGUgbXVzdCBub3QgZGVwZW5kIG9uCmFueXRoaW5nIEdOVSBzcGVjaWZpYy4KCkFsc28gTUFQ
X0FOT05ZTU9VUyBpcyByZXF1aWVyZWQgdG8gYmUgdGhlcmUgYnkgUE9TSVggc28gc2V0dGluZwpf
R05VX1NPVVJDRSBkb2VzIG5vdCBzZWVtIHRvIGJlIGEgZ29vZCBzb2x1dGlvbi4KCj4gU2lnbmVk
LW9mZi1ieTogTWEgWGluamlhbiA8bWF4ai5mbnN0QGZ1aml0c3UuY29tPgo+IC0tLQo+ICAuLi4v
Y29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zZW1fdGltZWR3YWl0LzItMS5jICAgICAgICAgICAgICAg
ICAgIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYgLS1n
aXQgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNl
cy9zZW1fdGltZWR3YWl0LzItMS5jIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2Nv
bmZvcm1hbmNlL2ludGVyZmFjZXMvc2VtX3RpbWVkd2FpdC8yLTEuYwo+IGluZGV4IDJlY2E4ZGZm
Ni4uNGNjZWY3MjYxIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0
ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3NlbV90aW1lZHdhaXQvMi0xLmMKPiArKysgYi90ZXN0
Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zZW1fdGlt
ZWR3YWl0LzItMS5jCj4gQEAgLTExLDYgKzExLDcgQEAKPiAgICovCj4gIAo+ICAKPiArI2RlZmlu
ZSBfR05VX1NPVVJDRQo+ICAjaW5jbHVkZSA8c3RkaW8uaD4KPiAgI2luY2x1ZGUgPGVycm5vLmg+
Cj4gICNpbmNsdWRlIDx1bmlzdGQuaD4KPiAtLSAKPiAyLjQyLjAKPiAKPiAKPiAtLSAKPiBNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKCi0tIApD
eXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
