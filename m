Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2A2C5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 12:14:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A300C3CF978
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 13:14:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C6BE3CD03B
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:14:01 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0807D7AA913
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 13:14:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4AA61FC04;
 Fri, 23 Feb 2024 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708690440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxTH65LT++Ehltb86VzZfDQ7R5WU9HGbc6oK1mp68jM=;
 b=JmFgm9JcgtdUJ0EYig8cME4ZBYTb6tnK54Phr/z7FJL1x6y6L+cDoMOLRnG8KfEdKjfAZo
 uxQlBu99vPnh6Wct8WW0jQe7L4FSfTsl76b7EEhjrui3S2BF/EMzoFPRknxCeHHB2hSa8S
 Bad6c358NQmVMdH1en5HlY3nmzsD5xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708690440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxTH65LT++Ehltb86VzZfDQ7R5WU9HGbc6oK1mp68jM=;
 b=GrQKwQ7LHQh1uNiLueth0Q/FcQ5/3JkJfCz6XDHEcPeZEl76dcsVqejpCJZmXZhHxMsWW0
 SA+UyWSLsrfMwKDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708690439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxTH65LT++Ehltb86VzZfDQ7R5WU9HGbc6oK1mp68jM=;
 b=XsnEW3xOLjMyrA6IZgftTr7Z6txzs5ZXoQFo3ig3NZ4FZ+ywlrmTuKtoFueoGvfHVlHmvg
 FUBrJgjxu5PdSei433pEaZXjZ/DLlW3D+taHF5eL2JvZoNk5Aniq8Wf7hfwC7waGbXGHvF
 jtGPwLlkRVnffVbgzMlZ6fKN2PBjPsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708690439;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxTH65LT++Ehltb86VzZfDQ7R5WU9HGbc6oK1mp68jM=;
 b=VC1perO5tVUa9BrX41aP9xUDobb/x8l2woZwP8wI/VVnkIzguEwMU6yFWYT5lnQadcKTc2
 ePMnfIYn2xxS8CAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5254132C7;
 Fri, 23 Feb 2024 12:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eg/7LgeM2GVUcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 23 Feb 2024 12:13:59 +0000
Date: Fri, 23 Feb 2024 13:12:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZdiLwe8BNRDQRYiB@yuki>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-2-pvorel@suse.cz>
 <20240105120300.GA1482331@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240105120300.GA1482331@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XsnEW3xO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VC1perO5
X-Spamd-Result: default: False [0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[43.45%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D4AA61FC04
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gVGhpcyBpbnRyb2R1Y2VzIHdhcm5pbmc6Cj4gCj4gJCBtYWtlIG1ldGFwYXJzZQo+IElu
IGZpbGUgaW5jbHVkZWQgZnJvbSBtZXRhcGFyc2UuYzoxNzoKPiBJbiBmdW5jdGlvbiDigJhkYXRh
X25vZGVfc3RyaW5n4oCZLAo+ICAgICBpbmxpbmVkIGZyb20g4oCYbWFpbuKAmSBhdCBtZXRhcGFy
c2UuYzo4OTQ6NjoKPiBkYXRhX3N0b3JhZ2UuaDo4NDoyMDogd2FybmluZzogYXJyYXkgc3Vic2Ny
aXB0IOKAmHN0cnVjdCBkYXRhX25vZGVbMF3igJkgaXMgcGFydGx5IG91dHNpZGUgYXJyYXkgYm91
bmRzIG9mIOKAmHVuc2lnbmVkIGNoYXJbNl3igJkgWy1XYXJyYXktYm91bmRzPV0KPiAgICA4NCB8
ICAgICAgICAgbm9kZS0+dHlwZSA9IERBVEFfU1RSSU5HOwo+ICAgICAgIHwgICAgICAgICB+fn5+
fn5+fn5+fl5+fn5+fn5+fn5+fn4KPiBkYXRhX3N0b3JhZ2UuaDo3OTozNDogbm90ZTogb2JqZWN0
IG9mIHNpemUgNiBhbGxvY2F0ZWQgYnkg4oCYbWFsbG9j4oCZCj4gICAgNzkgfCAgICAgICAgIHN0
cnVjdCBkYXRhX25vZGUgKm5vZGUgPSBtYWxsb2Moc2l6ZSk7Cj4gICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn4KPiBIT1NUQ0MgbWV0YWRhdGEvbWV0
YXBhcnNlCj4gCj4gV2hhdCBhbSBJIG1pc3Npbmc/CgpUaGlzIGxvb2tzIGxpa2UgdGhlIGNvbXBp
bGVyIGlzIGNvbmZ1c2VkIGJ5IHRoZSB1bmlvbiBhbmQgZmxleGlibGUgYXJyYXkKYW5kIHN0YXRp
YyBhbmFseXNpcyBwcm9kdWNlcyBnaWJiZXJpc2guIFRoZSB2ZXJ5IGZhY3QgdGhhdCB0aGlzIGlz
CnRyaWdnZXJlZCBieSBhZGRpdGlvbiBvZiB1bnJlbGF0ZWQgcGllY2Ugb2YgY29kZSBzdXBwb3J0
cyB0aGF0IGh5cG90ZXNpcwphcyB3ZWxsLgoKLS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2Uu
Y3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
