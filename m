Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0164BC982ED
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 11:14:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F37393E6E51
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 13:14:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C0F73E6DDD
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 13:14:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DF7B1400327
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 13:14:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F03A1F74A;
 Mon, 21 Sep 2026 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789989254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SGDSIxvjHi8X1tXeQAVySkQ5Q8xJvwLVk+F4YiD88/Q=;
 b=CTYLIjiYx80TDYv3AJWAyvwfRBG9/luKXzc29m9ZTQS5U9Lp+xG5wv7IWuFQ0DcqhQo+Zm
 xqCiqsNnzkG7Cu+5ZNaVYNV1btt7buEu2Rj3ex2vE2m4OPvQhi+9TZgsHL+T4Khqp3EW17
 f1pMlFCC77NnwrfRi4ErlDREDzr8G8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789989254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SGDSIxvjHi8X1tXeQAVySkQ5Q8xJvwLVk+F4YiD88/Q=;
 b=Lo2DmxfHfPOg24DL8NhBs0gIfJ3MeyUtGVQo7lxv1I6wqXVY8bSsKU/Gk/0WNrfdrHhaFV
 wG0kCy0cY4ohh5BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789989250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SGDSIxvjHi8X1tXeQAVySkQ5Q8xJvwLVk+F4YiD88/Q=;
 b=Jl2qiFG3XsdFFD1wUFLUB9hT19e/FdhZ3QzzlBBSLG2gAIYL+8XmKqDg+CDu0+boQTbIUH
 7y7i4KjtSFhXdNheRFoNoaEzi4lw7qtQBCiqovqAloOUoF3Kq9qMEnwwy9e/Q5cN0GhCk+
 sfOR1bh5kygPhSLlqzVo1rIhYAQ0NNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789989250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SGDSIxvjHi8X1tXeQAVySkQ5Q8xJvwLVk+F4YiD88/Q=;
 b=LRZdGST9rbiqVWLky/Tb4gXB+9XNmR7di5TzNTdXr9+SG/whqluIRVevKn4Fef6NACI8n2
 oDZ7L1mNFCLrbsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7F60139DC;
 Mon, 21 Sep 2026 11:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rwa2IYERsWoLbQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 21 Sep 2026 11:14:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 21 Sep 2026 13:14:07 +0200
Message-ID: <20260921111407.2137467-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,linux.dev,suse.com,gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lapi/keyctl.h: Fix compilation on old kernel
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
Cc: linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

cHJpdiBtZW1iZXIgd2FzIGFkZGVkIGluIGtlcm5lbCB2NC4yMCAod2hpY2ggd2Ugc3RpbGwgc3Vw
cG9ydCkgaW4gY29tbWl0CjJlY2VmYTBhMTVmZDAgKCJrZXlzOiBGaXggdGhlIHVzZSBvZiB0aGUg
QysrIGtleXdvcmQgInByaXZhdGUiIGluCnVhcGkvbGludXgva2V5Y3RsLmgiKQoKVXNlIG1hY3Jv
IGRlZmluaXRpb24gdG8gZml4IG1pc3NpbmcgJ3ByaXYnIGluIHRoZSBvbGQgVUFQSSBoZWFkZXJz
LiBUaGlzCmZpeGVzIGVycm9yOgoKICAgIGtleWN0bDI1LmM6MjU6MTE6IGVycm9yOiDigJhzdHJ1
Y3Qga2V5Y3RsX2RoX3BhcmFtc+KAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHByaXbigJkKCkZp
eGVzOiBlZTAyMTE4ZTlmICgibGFwaS9rZXljdGwuaDogQWRkIGZhbGxiYWNrIGRlZmluaXRpb25z
IGZvciBleHRlbmRlZCBvcHMiKQpTdWdnZXN0ZWQtYnk6IGxpbnV4dGVzdHByb2plY3QuYWdlbnRA
Z21haWwuY29tClNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgotLS0K
WWV0IGFub3RoZXIgcHJlLXJlbGVhc2UgZml4LCByZXF1aXJlZCBmb3IgY29tcGlsYXRpb24gb24g
U0xFMTItU1A1LgoKS2luZCByZWdhcmRzLApQZXRyCgogaW5jbHVkZS9sYXBpL2tleWN0bC5oIHwg
NiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xhcGkva2V5Y3RsLmggYi9pbmNsdWRlL2xhcGkva2V5Y3RsLmgKaW5kZXggZmRiNjhk
MTcyNS4uZTFlNDZiNzg2NSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9sYXBpL2tleWN0bC5oCisrKyBi
L2luY2x1ZGUvbGFwaS9rZXljdGwuaApAQCAtNjksNiArNjksMTIgQEAgc3RydWN0IGtleWN0bF9k
aF9wYXJhbXMgewogfTsKICNlbmRpZgogCisvKiBGaXggZm9yIGtlcm5lbCA8IHY0LjIwICovCisj
aWYgZGVmaW5lZChIQVZFX1NUUlVDVF9LRVlDVExfREhfUEFSQU1TKSAmJiBcCisJIWRlZmluZWQo
SEFWRV9TVFJVQ1RfS0VZQ1RMX0RIX1BBUkFNU19QUklWKQorIyBkZWZpbmUgcHJpdiBwcml2YXRl
CisjZW5kaWYKKwogI2lmbmRlZiBIQVZFX1NUUlVDVF9LRVlDVExfS0RGX1BBUkFNUwogc3RydWN0
IGtleWN0bF9rZGZfcGFyYW1zIHsKIAljaGFyICpoYXNobmFtZTsKLS0gCjIuNTUuMAoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
