Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DEBCCD195
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 14:35:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C03E3CEEB6
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 16:35:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B10003CEE83
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 16:35:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0D429200063
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 16:35:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3EB9B1FE69;
 Fri, 17 Oct 2025 14:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760711730;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBlzT8LXQdJh+wFxfRWeLkwxwrCPaUmvT/UeXIZwpGI=;
 b=wY+7p4AJxkS3/oHtT2tKc9zLgFh0nAddhm/oiHg9P3etwHNss/a/f/TWdeKuUZdfmrK4U5
 bB89o+z1FyFlT+GqzQqkV+DtwdFy2RquMRZTRHdYFexy9G3u5Zbwb3Gz2rzkTxJ+LxvI1O
 UMfHaXSyS7U5DmI2j+mTfU9S/ngzC7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760711730;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBlzT8LXQdJh+wFxfRWeLkwxwrCPaUmvT/UeXIZwpGI=;
 b=c+x1dNjlUY42RnHGOMLKTWQUoxqoOybZH+xiGzkGYgOs9prRLNlLNzXgTtMbt40IUy3Mzs
 5JhPQtSii3WTdTBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760711730;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBlzT8LXQdJh+wFxfRWeLkwxwrCPaUmvT/UeXIZwpGI=;
 b=wY+7p4AJxkS3/oHtT2tKc9zLgFh0nAddhm/oiHg9P3etwHNss/a/f/TWdeKuUZdfmrK4U5
 bB89o+z1FyFlT+GqzQqkV+DtwdFy2RquMRZTRHdYFexy9G3u5Zbwb3Gz2rzkTxJ+LxvI1O
 UMfHaXSyS7U5DmI2j+mTfU9S/ngzC7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760711730;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBlzT8LXQdJh+wFxfRWeLkwxwrCPaUmvT/UeXIZwpGI=;
 b=c+x1dNjlUY42RnHGOMLKTWQUoxqoOybZH+xiGzkGYgOs9prRLNlLNzXgTtMbt40IUy3Mzs
 5JhPQtSii3WTdTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C826713A71;
 Fri, 17 Oct 2025 14:35:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BWJLLjFU8mg3YAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Oct 2025 14:35:29 +0000
Date: Fri, 17 Oct 2025 16:35:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251017143524.GA339521@pevik>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251017101011.3811-2-wegao@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] lib: Add support option for .needs_cmds
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

SGkgV2VpLAoKPiArKysgYi9pbmNsdWRlL3RzdF90ZXN0LmgKPiBAQCAtNTI0LDcgKzUyNCw3IEBA
IHN0cnVjdCB0c3RfZnMgewo+ICAgKgo+ICAgKiBAdGFnczogQSB7fSB0ZXJtaW5hdGVkIGFycmF5
IG9mIHRlc3QgdGFncy4gU2VlIHN0cnVjdCB0c3RfdGFnIGZvciBkZXRhaWxzLgo+ICAgKgo+IC0g
KiBAbmVlZHNfY21kczogQSBOVUxMIHRlcm1pbmF0ZWQgYXJyYXkgb2YgY29tbWFuZHMgcmVxdWly
ZWQgZm9yIHRoZSB0ZXN0IHRvIHJ1bi4KPiArICogQG5lZWRzX2NtZHM6IEEgTlVMTCB0ZXJtaW5h
dGVkIGFycmF5IG9mIHN0cnVjdCB0c3RfY21kIHJlcXVpcmVkIGZvciB0aGUgdGVzdCB0byBydW4u
Cj4gICAqCj4gICAqIEBuZWVkc19jZ3JvdXBfdmVyOiBJZiBzZXQgdGhlIHRlc3Qgd2lsbCBydW4g
b25seSBpZiB0aGUgc3BlY2lmaWVkIGNncm91cAo+ICAgKiAgICAgICAgICAgICAgICAgICAgdmVy
c2lvbiBpcyBwcmVzZW50IG9uIHRoZSBzeXN0ZW0uCj4gQEAgLTYxNyw3ICs2MTcsNyBAQCBzdHJ1
Y3QgdHN0X2ZzIHsKCj4gIAljb25zdCBzdHJ1Y3QgdHN0X3RhZyAqdGFnczsKCj4gLQljb25zdCBj
aGFyICpjb25zdCAqbmVlZHNfY21kczsKPiArCXN0cnVjdCB0c3RfY21kICpuZWVkc19jbWRzOwoK
QXMgSSB3cm90ZSBpbiBhbGwgcHJldmlvdXMgdmVyc2lvbnMsIGNoYW5naW5nIHN0cnVjdCB1c2Vk
IGluIHN0cnVjdCB0c3RfdGVzdAphbG9uZSB3aXRob3V0IGNoYW5naW5nIHdpbGwgYnJlYWsgdGhp
cyBwYXJ0aWN1bGFyIGNvbW1pdC4KClNlZSB3aGVuIEkgYXBwbHkganVzdCB0aGlzIGNvbW1pdC46
Cmh0dHBzOi8vZ2l0aHViLmNvbS9wZXZpay9sdHAvYWN0aW9ucy9ydW5zLzE4NTk1ODkxNTg2Cmh0
dHBzOi8vZ2l0aHViLmNvbS9wZXZpay9sdHAvY29tbWl0cy9yZWZzL2hlYWRzL3dlaS9uZWVkc19j
bWRzLnY0LmZpcnN0LWNvbW1pdC1icm9rZW4vCgpDQyBsaWIvbmV3bGliX3Rlc3RzL3RzdF9leHBp
cmF0aW9uX3RpbWVyCnRzdF9uZWVkc19jbWRzMDEuYzoxNToyMzogZXJyb3I6IGluaXRpYWxpemF0
aW9uIG9mIOKAmHN0cnVjdCB0c3RfY21kICrigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0
eXBlIOKAmGNvbnN0IGNoYXIgKirigJkgWy1XaW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAg
IDE1IHwgICAgICAgICAubmVlZHNfY21kcyA9IChjb25zdCBjaGFyICpbXSkgewogICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICBeCnRzdF9uZWVkc19jbWRzMDEuYzoxNToyMzogbm90ZTogKG5l
YXIgaW5pdGlhbGl6YXRpb24gZm9yIOKAmHRlc3QubmVlZHNfY21kc+KAmSkKCi4uLgoKcXVvdGFj
dGwwMS5jOjIyNjoyMzogZXJyb3I6IGluaXRpYWxpemF0aW9uIG9mIOKAmHN0cnVjdCB0c3RfY21k
ICrigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIOKAmGNvbnN0IGNoYXIgKiBjb25z
dCrigJkgWy1XaW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAgMjI2IHwgICAgICAgICAubmVl
ZHNfY21kcyA9IChjb25zdCBjaGFyICpjb25zdCBbXSkgewogICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICBeCgpQbGVhc2UgeW91IG5lZWQgdG8gaGF2ZSB0aGlzIGNvbW1pdCB0b2dldGhlciB3
aXRoICJVcGRhdGUgdGVzdCBjYXNlcyB1c2UgbmV3Cm5lZWRzX2NtZHMiIGNvbW1pdCBpbnRvIHNp
bmdsZSBjb21taXQgKHNxdWFzaCB0aGVzZSB0d28gaW50byBhIHNpbmdsZSBjb21taXQpLgoKT3Ig
YW0gSSBtaXNzaW5nIHNvbWV0aGluZz8KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
