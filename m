Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A709C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 12:04:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA9943C65D2
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 14:04:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6302F3C5372
 for <ltp@lists.linux.it>; Tue, 27 May 2025 14:04:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C67AA68840B
 for <ltp@lists.linux.it>; Tue, 27 May 2025 14:04:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 173DE1FE47;
 Tue, 27 May 2025 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748347449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ir8ny2Kshq+KnptaqAMijN9hp84fRBN6PQudDAs4xuI=;
 b=yjZXW7r4ZcRg/Kg82ek1jUKkNTVZrU96JADRLh/qM3rmj39tK6Pomvw/cLgIQH8SYcg1Ru
 zUFgPtCXeBJ6/rYvYEsF2emXJjQnwRhixHPjDy5XvME/+SN83OgS6KBeD+dsBkVwoswBfl
 aiNp52EoYFdXIhbkt1lQ8MdEPKVGw10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748347449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ir8ny2Kshq+KnptaqAMijN9hp84fRBN6PQudDAs4xuI=;
 b=Inc0tpWnU0F+a664jHozMEPkhHyLig7RHWqxI8WBbn7fgirzw7RSecaLnDW4t+p1fZ+H/Q
 EiORO8X+wHeXsbDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748347449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ir8ny2Kshq+KnptaqAMijN9hp84fRBN6PQudDAs4xuI=;
 b=yjZXW7r4ZcRg/Kg82ek1jUKkNTVZrU96JADRLh/qM3rmj39tK6Pomvw/cLgIQH8SYcg1Ru
 zUFgPtCXeBJ6/rYvYEsF2emXJjQnwRhixHPjDy5XvME/+SN83OgS6KBeD+dsBkVwoswBfl
 aiNp52EoYFdXIhbkt1lQ8MdEPKVGw10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748347449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ir8ny2Kshq+KnptaqAMijN9hp84fRBN6PQudDAs4xuI=;
 b=Inc0tpWnU0F+a664jHozMEPkhHyLig7RHWqxI8WBbn7fgirzw7RSecaLnDW4t+p1fZ+H/Q
 EiORO8X+wHeXsbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCD0813A62;
 Tue, 27 May 2025 12:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2+/xNDiqNWgbEAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 May 2025 12:04:08 +0000
Date: Tue, 27 May 2025 14:04:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250527120407.GB188735@pevik>
References: <20250526143429.22997-1-chrubis@suse.cz>
 <20250526155132.GA151544@pevik>
 <CAEemH2eyj5k5tUAQyo+b-JXKF5-GcLzQA5SXbP7xpqU1xU73NQ@mail.gmail.com>
 <20250527093436.GC173684@pevik>
 <CAEemH2cCL9LpBRMnfJtShmdtwKTHLMC2hQeC_sFKyh4KWwUt0Q@mail.gmail.com>
 <20250527110043.GA186218@pevik> <aDWfJ97gIGTRpMQI@yuki.lan>
 <20250527113244.GA188735@pevik> <aDWlb8u0apR22wv6@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aDWlb8u0apR22wv6@yuki.lan>
X-Spamd-Result: default: False [-4.50 / 50.00]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: LTP_SINGLE_FS_TYPE and
 LTP_FORCE_SINGLE_FS_TYPE
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

PiBIaSEKPiA+IEZZSSBhbHNvIHRlc3RjYXNlcy9saWIvdHN0X3N1cHBvcnRlZF9mcy5jIHVzZXMg
aXQ6Cgo+ID4gdHN0X3N1cHBvcnRlZF9mcy5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgo+ID4g
dHN0X3N1cHBvcnRlZF9mcy5jOjE1MjoyMzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9m
IGZ1bmN0aW9uIOKAmHRzdF9nZXRfc3VwcG9ydGVkX2ZzX3R5cGVz4oCZIFstV2ltcGxpY2l0LWZ1
bmN0aW9uLWRlY2xhcmF0aW9uXQo+ID4gICAxNTIgfCAgICAgICAgIGZpbGVzeXN0ZW1zID0gdHN0
X2dldF9zdXBwb3J0ZWRfZnNfdHlwZXMoKGNvbnN0IGNoYXIgKiBjb25zdCopc2tpcGxpc3QpOwo+
ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KPiA+IHRzdF9zdXBwb3J0ZWRfZnMuYzoxNTI6MjE6IGVycm9yOiBhc3NpZ25tZW50IHRvIOKA
mGNvbnN0IGNoYXIgKiBjb25zdCrigJkgZnJvbSDigJhpbnTigJkgbWFrZXMgcG9pbnRlciBmcm9t
IGludGVnZXIgd2l0aG91dCBhIGNhc3QgWy1XaW50LWNvbnZlcnNpb25dCj4gPiAgIDE1MiB8ICAg
ICAgICAgZmlsZXN5c3RlbXMgPSB0c3RfZ2V0X3N1cHBvcnRlZF9mc190eXBlcygoY29uc3QgY2hh
ciAqIGNvbnN0Kilza2lwbGlzdCk7Cj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgXgo+
ID4gbWFrZTogKioqIFsuLi8uLi9pbmNsdWRlL21rL3J1bGVzLm1rOjQ4OiB0c3Rfc3VwcG9ydGVk
X2ZzXSBFcnJvciAxCgo+ID4gVGhlcmVmb3JlIHdlIG5lZWQgZWl0aGVyIHJlbGF0aXZlIHBhdGgg
KGJlbG93KSBvciB0d2VhayBDRkxBR1MgdG8gYWRkIC1JLgoKPiBJZiBpdCdzIHVzZWQgZnJvbSBz
aGVsbCBoZWxwZXIgYXMgd2VsbCB3ZSBoYXZlIGEgdHN0X3ByaXZhdGUuaCBoZWFkZXIgaW4KPiBp
bmNsdWRlLyBmb3IgdGhhdCBhbHJlYWR5LCBzbyBJIGd1ZXNzIHdlIHNob3VsZCB1c2UgdGhhdCBv
bmUgaW5zdGVhZC4KCisxIChJIHdhcyBzZWFyY2hlZCBmb3Igc29tZSBzcGVjaWZpYyBoZWFkZXIs
IGJ1dCBmb3VuZCBvbmx5ICJwdWJsaWMiCmluY2x1ZGUvdHN0X2NvbW1vbi5oKS4KCktpbmQgcmVn
YXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
