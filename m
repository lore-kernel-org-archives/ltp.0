Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12A6C47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 11:15:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E94473D0610
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 12:15:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 585863CFA84
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 12:15:13 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B5FF020075F
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 12:15:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB73F1FD9F;
 Fri, 26 Jan 2024 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706267710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E5WPD16uh6LHY81Zml51pmF/4NVSqXt7pUD4XJwVNCM=;
 b=XjNXH/zTXsujdH/YZf0fj2QIQTENgGvkzaGC/bwxyZPn8QxCcAhjY2w03T0tVVoD633J11
 ghChbamWBfcP7aDvoOu0wPL3HVsOoafynJeSrAXA1WGEmKQxwRTpfJ1bAq99EAsOszkGR+
 sEfgTg9LFkzM9hQGSj3DvKLOFx1hi0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706267710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E5WPD16uh6LHY81Zml51pmF/4NVSqXt7pUD4XJwVNCM=;
 b=RnxH2mjET6U7E/4MVKtXCvlg6ojJQwDJuBuV7QTrBhJYAt4M97fzqcuGEd+W+8TkFrvB3z
 XkBM0GO1gqWAWvBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706267709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E5WPD16uh6LHY81Zml51pmF/4NVSqXt7pUD4XJwVNCM=;
 b=DOAUaE0kEozZ7jA/iQn0iVqMn0ezSncmcY7t7gBv4pgXRQ1Cccf0tqKhJ1bJjP6JDcYwJ8
 Mn6WMLHx6mBzAAASOPYyKWB0IZe3vt+Foyke4nFCDz3p2B5BGwVPdHZuXXWWISLa/E3PnV
 2R3HU+MjkgaqMu2qtE4ma3Qy5pBPQl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706267709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E5WPD16uh6LHY81Zml51pmF/4NVSqXt7pUD4XJwVNCM=;
 b=OQdBDHM2m5a/0xxL1d4uA4+xwzk+VX+BFbRCd9jXkB/w55Ltws/wFvzL5e73Nv4uzdwxFX
 DIa5NS2haMEDgQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3A41134C3;
 Fri, 26 Jan 2024 11:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OeRcLj2Us2UQMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jan 2024 11:15:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 Jan 2024 12:15:06 +0100
Message-ID: <20240126111506.491324-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DOAUaE0k;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OQdBDHM2
X-Spamd-Result: default: False [0.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[37.35%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EB73F1FD9F
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] lapi/io_uring: <sys/types.h> => <linux/types.h>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhpcyBmaXhlcyBjb21waWxhdGlvbiBvbiBvbGQgdG9vbGNoYWluczoKClNvbWUgb2xkIHRvb2xj
aGFpbnMgcmVxdWlyZSB0byBhZGQgPGxpbnV4L3R5cGVzLmg+IHRvIG1pc3Npbmcga2VybmVsCnR5
cGVzOgoKdHN0X3NhZmVfaW9fdXJpbmcuYzogSW4gZnVuY3Rpb24g4oCYc2FmZV9pb191cmluZ19p
bml04oCZOgp0c3Rfc2FmZV9pb191cmluZy5jOjM0OjQ1OiBlcnJvcjog4oCYX191MzLigJkgdW5k
ZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgIDM0IHwgICAgICAgICAgICAg
ICAgIHBhcmFtcy0+c3FfZW50cmllcyAqIHNpemVvZihfX3UzMik7CiAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fgoKaW9fdXJpbmcwMi5jOiBJ
biBmdW5jdGlvbiDigJhkcmFpbl9mYWxsYmFja+KAmToKaW9fdXJpbmcwMi5jOjEwNjozNDogZXJy
b3I6IOKAmF9fdTY04oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQog
IDEwNiB8ICAgICAgICAgICAgICAgICBzcWVfcHRyLT5hZGRyID0gKF9fdTY0KSZzcGFtX2hlYWRl
cjsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fgppb191cmlu
ZzAyLmM6MTA2OjM0OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRl
ZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgppb191cmluZzAyLmM6
IEluIGZ1bmN0aW9uIOKAmHJ1buKAmToKaW9fdXJpbmcwMi5jOjIyMToyNjogZXJyb3I6IOKAmF9f
dTY04oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogIDIyMSB8ICAg
ICAgICAgc3FlX3B0ci0+YWRkciA9IChfX3U2NCkmYmVlZl9oZWFkZXI7CiAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+CgpOZXdlciBrZXJuZWwgaGVhZGVycyBpbmNsdWRlcyA8
bGludXgvdHlwZXMuaD4gaW4gPGxpbnV4L2lvX3VyaW5nLmg+LCBidXQKd2Ugc3RpbGwgc3VwcG9y
dCBjb21waWxlcnMgd2l0aG91dCB0aGlzIGhlYWRlci4gVGhlcmVmb3JlIHJlcGxhY2UKPHN5cy90
eXBlcy5oPiBpbiBsYXBpIGhlYWRlciB3aXRoIDxsaW51eC90eXBlcy5oPi4KCkZpeGVzOiAzZjJm
ZjU0MzEgKCJBZGQgc2FmZSBmdW5jdGlvbnMgZm9yIGlvX3VyaW5nIHRvIExUUCBsaWJyYXJ5IikK
Rml4ZXM6IGM0ZjY2OWYxMyAoIkFkZCB0ZXN0IGZvciBDVkUgMjAyMC0yOTM3MyIpClNpZ25lZC1v
ZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgotLS0KQ2hhbmdlcyB2MS0+djI6Ciog
Rml4IGFsc28gaW9fdXJpbmcwMi5jCgogaW5jbHVkZS9sYXBpL2lvX3VyaW5nLmggfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xhcGkvaW9fdXJpbmcuaCBiL2luY2x1ZGUvbGFwaS9pb191cmluZy5oCmluZGV4
IDAzYzQ1MTkwZS4uYzA1NTE3NTk1IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xhcGkvaW9fdXJpbmcu
aAorKysgYi9pbmNsdWRlL2xhcGkvaW9fdXJpbmcuaApAQCAtMTEsOSArMTEsOSBAQAogCiAjaW5j
bHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8ZmNudGwuaD4KLSNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KICNpbmNsdWRlIDxzeXMvdWlvLmg+CiAjaW5jbHVkZSA8c3RkbGliLmg+CisjaW5jbHVkZSA8
bGludXgvdHlwZXMuaD4KIAogI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKIAotLSAKMi40My4w
CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
