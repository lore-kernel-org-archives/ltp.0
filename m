Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FE0D35662
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 08:01:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 463523CA727
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 09:01:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 777893CA521
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 09:01:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E3D996009FB
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 09:01:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E6FE233A89;
 Wed, 28 Jan 2026 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769587291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vFOkWq8wHpqNohMSbO02A+bYAHzZxMPI2qKrk6t9d4A=;
 b=2wLIAmI1OenbxPmyMUhHOevZWC9/HYLxtPjMit4AwIQSmRfOq6h/GQglUg/GCLKqErvp6R
 +otkQLCbiMx4MonZuXAOYAXCXx1oAH/W+uzWrW3ZSkV4WB9APbF1A69P1Zord9JdQObD/k
 SG0bTEKiSNWkUHxDQ9zoulMU8Z/QAV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769587291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vFOkWq8wHpqNohMSbO02A+bYAHzZxMPI2qKrk6t9d4A=;
 b=AJUxZ/dMzxFRdaLBwe4McpR0lm0fyMgJR6GpWyIiqYi07RfD94/nFGMDb3zagN5qOQom16
 MC/O5CnS4M4/iEAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="oImQ9VA/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WUBFissp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769587290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vFOkWq8wHpqNohMSbO02A+bYAHzZxMPI2qKrk6t9d4A=;
 b=oImQ9VA/RRjALW6CPEeoFHtXmzWZuoKDGgVVdVK/okbEZ+I1Fa6Tiod8RoV2jiUaWLjcH3
 7doNBq+s0BQzUJLlf15GQ5G6bYwKDtVDFuzJS1SKQa+RVud4BaCGj1/ywlxineO6XJ2MpX
 Mn2gku0PqWjFkHMcUsWEGTTpUXXcVc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769587290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vFOkWq8wHpqNohMSbO02A+bYAHzZxMPI2qKrk6t9d4A=;
 b=WUBFissphxEd3JkBCQ/w5ugtJGiQTFIaIeLkouYDUbqasfMEOXKTB8lblMvGCetvN5NryY
 /9sHx57Vice/YxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B5813EA61;
 Wed, 28 Jan 2026 08:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e/ylIlrCeWkABwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 08:01:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 28 Jan 2026 09:01:19 +0100
Message-ID: <20260128080121.18878-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E6FE233A89
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc/ground_rules: Add Kernel features check rules
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

U2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Ci0tLQpCYXNlZCBvbiBh
IGRpc2N1c3Npb24gdmFyaW91cyBkaXNjdXNzaW9uczoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bHRwLzIwMjYwMTIzMTIyNTQ1LkdBMTIyMzMxQHBldmlrLwpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sdHAvMjAyNjAxMjgwNzI0NDUuR0IxMzQ5NUBwZXZpay8KCktpbmQgcmVnYXJkcywKUGV0cgoK
IGRvYy9kZXZlbG9wZXJzL2dyb3VuZF9ydWxlcy5yc3QgfCAxNyArKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kb2MvZGV2ZWxv
cGVycy9ncm91bmRfcnVsZXMucnN0IGIvZG9jL2RldmVsb3BlcnMvZ3JvdW5kX3J1bGVzLnJzdApp
bmRleCAwNWU0NzNjYWQ1Li45MGZlN2E2NGVlIDEwMDY0NAotLS0gYS9kb2MvZGV2ZWxvcGVycy9n
cm91bmRfcnVsZXMucnN0CisrKyBiL2RvYy9kZXZlbG9wZXJzL2dyb3VuZF9ydWxlcy5yc3QKQEAg
LTE3NCwzICsxNzQsMjAgQEAgVGhlc2UgcGF0Y2hlcyBzaG91bGQgYWxzbyBhZGQgYSBbU1RBR0lO
R10ga2V5d29yZCBpbnRvIHRoZSBwYXRjaCBzdWJqZWN0LCBlLmcuCiBJbiBhIGNhc2UgdGhhdCBh
IHRlc3QgZm9yIHVucmVsZWFzZWQga2VybmVsIGlzIHJlYWxseSBuZWVkZWQgdG8gYmUgbWVyZ2Vk
IHdlIGRvCiBub3QgYWRkIGl0IHRvIHRoZSBsaXN0IG9mIHRlc3QgZXhlY3V0ZWQgYnkgZGVmYXVs
dCBhbmQga2VlcCBpdCBpbgogOm1hc3RlcjpgcnVudGVzdC9zdGFnaW5nYCBmaWxlIHVudGlsIHRo
ZSBrZXJuZWwgY29kZSBpcyBmaW5hbGl6ZWQuCisKK0tlcm5lbCBmZWF0dXJlcyBjaGVjaworLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCisKK1dlIHByZWZlciB0byB1c2UgOmM6dHlwZTpgLm5lZWRzX2tj
b25maWdzIDx0c3RfdGVzdD5gIChrZXJuZWwga2NvbmZpZyBjaGVjaykuCitCdXQgZG8gKm5vdCog
dXNlIGl0IHdoZW4gdGhlcmUgaXMgYW5vdGhlciB3YXkgdG8gZGV0ZWN0IHRoZSBmdW5jdGlvbmFs
aXR5IChlLmcuCit2aWEgZGV0ZWN0aW5nIGZ1bmN0aW9uYWxpdHkgdmlhIGBgL3Byb2N8c3lzYGAp
ICphbmQqIGFueSBvZiB0aGVzZSBydWxlcyBhcHBsaWVzOgorCistIEtlcm5lbCBhbGxvd3MgdG8g
ZGlzYWJsZSBmdW5jdGlvbmFsaXR5IHZpYSBga2VybmVs4oCZcyBjb21tYW5kLWxpbmUgcGFyYW1l
dGVyCisgIDxodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9hZG1pbi1ndWlk
ZS9rZXJuZWwtcGFyYW1ldGVycy5odG1sPmBfCisgIChpdCBjYW4gYmUgZGlzYWJsZWQgaW4gcnVu
dGltZSkuCistIEl0J3MgYSBjaGVjayBmb3IgYSBmdW5jdGlvbmFsaXR5IHdoaWNoIGNhbiBiZSBj
b21waWxlZCBhcyBtb2R1bGUKKyAgKGB0cmlzdGF0ZQorICA8aHR0cHM6Ly9kb2NzLmtlcm5lbC5v
cmcva2J1aWxkL2tjb25maWctbGFuZ3VhZ2UuaHRtbCNtZW51LWF0dHJpYnV0ZXM+YF8sCisgIG1v
ZHVsIG1pZ2h0IG5vdCBiZSBhdmFpbGFibGUpLgorLSBOZXcga2VybmVsIGZ1bmN0aW9uYWxpdHkg
d2hpY2ggaXMgdW5saWtlbHkgdG8gYmUgYmFja3BvcnRlZCAodXNlCisgIDpjOnR5cGU6YC5taW5f
a3ZlciA8dHN0X3Rlc3Q+YCBpbnN0ZWFkKS4KLS0gCjIuNTEuMAoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
