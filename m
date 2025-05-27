Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DDAC54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:43:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF4B93C5837
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:43:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 032CC3C5371
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:43:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7FF381A00A43
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:43:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 732CC21D91;
 Tue, 27 May 2025 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748346196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXCKWZGEc3pbGvyZRfRj8ysoD7zIxFfPreRb1h4X4Ts=;
 b=ReQqVL3BpWWc9lBhMsdO0e2ntsdJawk8HqdMYywoAe6tb8CVjhVB5wMxHy2ivwi8HbWK06
 Gvspw0X+ZO6HgbArrTDbEsfLkEMzH1qBv/Ru7+o97/fz8TnQiUILetXBlWPxfikjkvlCw/
 4l8KJn3wdgIcytcDo0KOZb3OEWiQ8MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748346196;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXCKWZGEc3pbGvyZRfRj8ysoD7zIxFfPreRb1h4X4Ts=;
 b=Cr4x1nGs08z2Kvt8r4P5KSZRQqYin60vVwyaSl217oJ0zL1NpUKUJN3JpZrybFWTab/OOe
 SG0Hh92Q0F4zrQBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C+R52lH+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3xMyeX9H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748346195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXCKWZGEc3pbGvyZRfRj8ysoD7zIxFfPreRb1h4X4Ts=;
 b=C+R52lH+dscfwSZaDxKHEM3zHYbCyTJum9IVsR9pC8KNeRhejxd5GCCXBU1uebIY4idfsX
 X4BSjs53lD84Zk+kpnPhV3/5qARql4liRIDhMGkkVVFyIRw73rZVHSlVCs1QOJoAqP+pbF
 CJYu1fBDQPPLq82bz0A6s/WRT81IXyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748346195;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXCKWZGEc3pbGvyZRfRj8ysoD7zIxFfPreRb1h4X4Ts=;
 b=3xMyeX9Hh7FKfeoMJuBcFl+lVPD9Aen7MAx20O20hCL5W5GDKHqNILaGaZXvTiHjpnfckZ
 0pIAhtP83cNV9cAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 632EB136E0;
 Tue, 27 May 2025 11:43:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fBE6FlOlNWhzCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 27 May 2025 11:43:15 +0000
Date: Tue, 27 May 2025 13:43:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aDWlb8u0apR22wv6@yuki.lan>
References: <20250526143429.22997-1-chrubis@suse.cz>
 <20250526155132.GA151544@pevik>
 <CAEemH2eyj5k5tUAQyo+b-JXKF5-GcLzQA5SXbP7xpqU1xU73NQ@mail.gmail.com>
 <20250527093436.GC173684@pevik>
 <CAEemH2cCL9LpBRMnfJtShmdtwKTHLMC2hQeC_sFKyh4KWwUt0Q@mail.gmail.com>
 <20250527110043.GA186218@pevik> <aDWfJ97gIGTRpMQI@yuki.lan>
 <20250527113244.GA188735@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250527113244.GA188735@pevik>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 732CC21D91
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gRllJIGFsc28gdGVzdGNhc2VzL2xpYi90c3Rfc3VwcG9ydGVkX2ZzLmMgdXNlcyBpdDoK
PiAKPiB0c3Rfc3VwcG9ydGVkX2ZzLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6Cj4gdHN0X3N1
cHBvcnRlZF9mcy5jOjE1MjoyMzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0
aW9uIOKAmHRzdF9nZXRfc3VwcG9ydGVkX2ZzX3R5cGVz4oCZIFstV2ltcGxpY2l0LWZ1bmN0aW9u
LWRlY2xhcmF0aW9uXQo+ICAgMTUyIHwgICAgICAgICBmaWxlc3lzdGVtcyA9IHRzdF9nZXRfc3Vw
cG9ydGVkX2ZzX3R5cGVzKChjb25zdCBjaGFyICogY29uc3QqKXNraXBsaXN0KTsKPiAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+IHRzdF9z
dXBwb3J0ZWRfZnMuYzoxNTI6MjE6IGVycm9yOiBhc3NpZ25tZW50IHRvIOKAmGNvbnN0IGNoYXIg
KiBjb25zdCrigJkgZnJvbSDigJhpbnTigJkgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0
aG91dCBhIGNhc3QgWy1XaW50LWNvbnZlcnNpb25dCj4gICAxNTIgfCAgICAgICAgIGZpbGVzeXN0
ZW1zID0gdHN0X2dldF9zdXBwb3J0ZWRfZnNfdHlwZXMoKGNvbnN0IGNoYXIgKiBjb25zdCopc2tp
cGxpc3QpOwo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICBeCj4gbWFrZTogKioqIFsuLi8u
Li9pbmNsdWRlL21rL3J1bGVzLm1rOjQ4OiB0c3Rfc3VwcG9ydGVkX2ZzXSBFcnJvciAxCj4gCj4g
VGhlcmVmb3JlIHdlIG5lZWQgZWl0aGVyIHJlbGF0aXZlIHBhdGggKGJlbG93KSBvciB0d2VhayBD
RkxBR1MgdG8gYWRkIC1JLgoKSWYgaXQncyB1c2VkIGZyb20gc2hlbGwgaGVscGVyIGFzIHdlbGwg
d2UgaGF2ZSBhIHRzdF9wcml2YXRlLmggaGVhZGVyIGluCmluY2x1ZGUvIGZvciB0aGF0IGFscmVh
ZHksIHNvIEkgZ3Vlc3Mgd2Ugc2hvdWxkIHVzZSB0aGF0IG9uZSBpbnN0ZWFkLgoKLS0gCkN5cmls
IEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
