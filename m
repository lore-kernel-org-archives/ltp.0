Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7D1C3064D
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 15:23:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 707A83D10A5
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 17:23:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD38D3D1069
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 17:23:22 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 79620600C35
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 17:23:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3DB6A1F892;
 Tue, 25 Jun 2024 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719329000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dvyc8ct377jI9S2LY58UHzaAnyzs70JqaCe6nAsU5PI=;
 b=ycPXIUOJkKIVcmT3OkZhanBpnwN3utsYWqzNO3YiZFzKTOXz4X2tX9qs1sZ/Y8fLhuxC9r
 olWXJjnwuVqI0gaBIVExz4XU3JjBgFX0eYdwUnvWEhfK7SC6tALIO1E9FDrZoKhoXNVMDo
 rcrD/urxjGNArhar8lNoytPyUL+svmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719329000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dvyc8ct377jI9S2LY58UHzaAnyzs70JqaCe6nAsU5PI=;
 b=7g8orwLyBMs/sh9RgBpAudevqHaISLSnsMmfO1cAU5fX8xdmzA1GGfyaqln/Bl5+SMHgmU
 sDZgQHkRZ8RG8PBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ycPXIUOJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7g8orwLy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719329000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dvyc8ct377jI9S2LY58UHzaAnyzs70JqaCe6nAsU5PI=;
 b=ycPXIUOJkKIVcmT3OkZhanBpnwN3utsYWqzNO3YiZFzKTOXz4X2tX9qs1sZ/Y8fLhuxC9r
 olWXJjnwuVqI0gaBIVExz4XU3JjBgFX0eYdwUnvWEhfK7SC6tALIO1E9FDrZoKhoXNVMDo
 rcrD/urxjGNArhar8lNoytPyUL+svmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719329000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dvyc8ct377jI9S2LY58UHzaAnyzs70JqaCe6nAsU5PI=;
 b=7g8orwLyBMs/sh9RgBpAudevqHaISLSnsMmfO1cAU5fX8xdmzA1GGfyaqln/Bl5+SMHgmU
 sDZgQHkRZ8RG8PBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 247441384C;
 Tue, 25 Jun 2024 15:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DUAXCOjgembJPQAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 25 Jun 2024 15:23:20 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Jun 2024 17:23:19 +0200
Message-ID: <2272693.vFx2qVVIhK@localhost>
Organization: SUSE
In-Reply-To: <20240620060203.558528-1-pvorel@suse.cz>
References: <20240620060203.558528-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; HAS_ORG_HEADER(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3DB6A1F892
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test: Document @message, @scall, @sample
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

SGksCgpSZXZpZXdlZC1ieTogQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+CgpPbiBUaHVy
c2RheSwgSnVuZSAyMCwgMjAyNCA4OjAyOjAz4oCvQU0gR01UKzIgeW91IHdyb3RlOgo+IEFsbCB1
bmRvY3VtZW50ZWQgbWVtYmVycyBhcmUgaW4gdGhlIGxpYnJhcnkgInVuZGVzY3JpYmVkIiwKPiBi
ZXR0ZXIgdG8gZG9jdW1lbnQgdGhlIHB1cnBvc2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4gIGluY2x1ZGUvdHN0X3Rlc3QuaCB8IDYgKysr
KysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS90c3RfdGVzdC5oIGIvaW5jbHVkZS90c3RfdGVzdC5oCj4gaW5kZXggOGRjMjBkMTEw
Li4yMDk2MGU5YjkgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS90c3RfdGVzdC5oCj4gKysrIGIvaW5j
bHVkZS90c3RfdGVzdC5oCj4gQEAgLTQyOCw2ICs0MjgsMTAgQEAgc3RydWN0IHRzdF91bGltaXRf
dmFsIHsKPiAgICogICAgICAgICAgICBjYW4gYmUgc2V0LiBNYXkgYmUgZXhlY3V0ZWQgc2V2ZXJh
bCB0aW1lcyBpZiB0ZXN0IHdhcyBwYXNzZWQgJy1pJwo+ICAgKiAgICAgICAgICAgIG9yICctZCcg
Y29tbWFuZCBsaW5lIHBhcmFtZXRlcnMuCj4gICAqCj4gKyAqIEBzY2FsbDogSW50ZXJuYWwgb25s
eSAodGltZXIgbWVhc3VyZW1lbnQgbGlicmFyeSkuCj4gKyAqCj4gKyAqIEBzYW1wbGU6IEludGVy
bmFsIG9ubHkgKHRpbWVyIG1lYXN1cmVtZW50IGxpYnJhcnkpLgo+ICsgKgo+ICAgKiBAcmVzb3Vy
Y2VfZmlsZXM6IEEgTlVMTCB0ZXJtaW5hdGVkIGFycmF5IG9mIGZpbGVuYW1lcyB0aGF0IHdpbGwg
YmUgY29waWVkCj4gICAqICAgICAgICAgICAgICAgICAgdG8gdGhlIHRlc3QgdGVtcG9yYXJ5IGRp
cmVjdG9yeSBmcm9tIHRoZSBMVFAgZGF0YWZpbGVzCj4gICAqICAgICAgICAgICAgICAgICAgZGly
ZWN0b3J5Lgo+IEBAIC02NDIsNiArNjQ2LDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkKPiAgLyoqCj4gICAqIFRTVF9URVNUX1RDT05GKCkgLSBFeGl0IHRlc3RzIHdpdGggYSBU
Q09ORiBtZXNzYWdlLgo+ICAgKgo+ICsgKiBAbWVzc2FnZTogRXJyb3IgbWVzc2FnZSAodGhlIHJl
YXNvbiB0byBza2lwIHRlc3QpLgo+ICsgKgo+ICAgKiBUaGlzIG1hY3JvIGlzIHVzZWQgaW4gdGVz
dCB0aGF0IGNvdWxkbid0IGJlIGNvbXBpbGVkIGVpdGhlciBiZWNhdXNlIGN1cnJlbnQKPiAgICog
Q1BVIGFyY2hpdGVjdHVyZSBpcyB1bnN1cHBvcnRlZCBvciBiZWNhdXNlIG9mIG1pc3NpbmcgZGV2
ZWxvcG1lbnQgbGlicmFyaWVzLgo+ICAgKi8KPiAKClJlZ2FyZHMsCkF2aW5lc2gKCgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
