Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDDDC28CF5
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 12:36:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5B533C9717
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 13:36:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 561683C963F
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A53541A009BD
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C208D218E5;
 Wed, 26 Jan 2022 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643200555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RsySCa7bneTouz+aEim3LxLPkXu4Dy1mLhqaN2w8po4=;
 b=fYA4LJ9jnNVQk1xuva/E0exJ4hKtzvz+DOsx2utg2FzssS3peE0DkbD4/GmsF+9ohdFfag
 Hq/DuQksBXazg8uwA2LUtQgzAkw8DWuHcLYbYA9P+IZmxJK3SzgwV+Q9Kpe96weHvj19Fb
 axES/IZSCxvaLy4y2ydn8k0xJcuGQMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643200555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RsySCa7bneTouz+aEim3LxLPkXu4Dy1mLhqaN2w8po4=;
 b=N7QjWPO3NzJhJJxExk9P7dkVe+3r1FXUHt9937qp7FtcXYCTymyGSrO/w4v1NWyMpI/qpY
 YDJMD1NwbiPFRDBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88D0413BB5;
 Wed, 26 Jan 2022 12:35:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SrNbHytA8WGkOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 12:35:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 13:35:40 +0100
Message-Id: <20220126123547.13298-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] m4: Fix warnings, remove old checks
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpjaGFuZ2VzIHYxLT52MjoKKiBuZXcgY29tbWl0cyB0byByZW1vdmUgbHRwLXNjYW5uZXIg
YW5kIHZhcmlvdXMgY2hlY2tzLgoKVGhlcmUgYXJlIHN0aWxsIHNvbWUgQUNfTElOS19JRkVMU0Ug
bGVmdCBhbmQgc29tZSBjaGVjayBjb3VsZCBiZSBmb3IKc3VyZSBmaXhlZCAoZS5nLiBMSUJOVU1B
X0FQSV9WRVJTSU9OIDIgaXMgb2xkIGVub3VnaCB0byByZW1vdmUgdGhlIGNoZWNrKSwKYnV0IGxl
dMKncyBwb3N0cG9uZSBpdCB0byBsYXRlci4KCkkgYWxzbyB3YW50ZWQgdG8gZnVydGhlciBjbGVh
biBsaWIvY2xvbmVyLmMgLSBJIHdhbnRlZCB0byByZW1vdmUKbHRwX2Nsb25lXyBhbmQgX19jbG9u
ZTIgZm9yIGlhNjQgWzFdLiBpYTY0IGlzIEVPTCBbMl0sIGJ1dCBocHBhIGlzIHN0aWxsCnN1cHBv
cnRlZCBbM10uIE1heWJlIEkgc2hvdWxkIGFzayBKYW1lcyBCb3R0b21sZXkgYW5kCmxpbnV4LXBh
cmlzY0B2Z2VyLmtlcm5lbC5vcmcgd2hldGhlciB0aGV5IGV2ZW4gdXNlIExUUCBmb3IgdGVzdGlu
Zy4KClRlc3RlZDoKaHR0cHM6Ly9naXRodWIuY29tL3BldmlrL2x0cC9hY3Rpb25zL3J1bnMvMTc1
MDc4Nzg5OQoob3BlbnN1c2UvbGVhcCBoYXMgaW5zdGFsbGF0aW9uIHByb2JsZW0sIG5vdCByZWxh
dGVkIHRvIHRoaXMgaXNzdWUpCgpLaW5kIHJlZ2FyZHMsClBldHIKClsxXSBodHRwczovL2dpdGh1
Yi5jb20vcGV2aWsvbHRwL2NvbW1pdC9lN2RhODk4ZTE2YWQ1OTJmNmJjMzExYzNiYWQ2ZTBjODI5
NzdmZWM0ClsyXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD0yMjgzNDViZjk4Y2Q3OGY5MWQwMDc0Nzhh
NTFmOWE0NzE0ODllNDRhClszXSBodHRwczovL3BhcmlzYy53aWtpLmtlcm5lbC5vcmcvaW5kZXgu
cGhwL01haW5fUGFnZSNQQS1SSVNDX05FV1MKCgpQZXRyIFZvcmVsICg3KToKICBwYW46IFJlbW92
ZSBsdHAtc2Nhbm5lcgogIG00OiBSZW1vdmUgY2hlY2sgZm9yIGlvX3NldF9ldmVudGZkCiAgbTQ6
IFJlbW92ZSBjaGVjayBmb3Igc3RydWN0IHBlcmZfZXZlbnRfYXR0cgogIHJlYWx0aW1lL200OiBT
aW1wbGlmeSBleHAxMCBjaGVjawogIG00OiBSZW1vdmUgY2hlY2sgZm9yIE1SRU1BUF9GSVhFRAog
IG00OiBSZW1vdmUgY2hlY2sgZm9yIGNsb25lKCkgc3VwcG9ydHMgNyBhcmdzCiAgbTQ6IEZpeCB3
YXJuaW5ncwoKIC5naXRpZ25vcmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMSAtCiBJTlNUQUxMICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDIgLQogY29uZmlndXJlLmFjICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI4
ICstCiBsaWIvY2xvbmVyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAg
LQogbTQvbHRwLWNsb25lN2FyZ3MubTQgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE3IC0K
IG00L2x0cC1ldmVudGZkLm00ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArLQog
bTQvbHRwLWtlcm5lbF9kZXZlbC5tNCAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstCiBt
NC9sdHAtbXJlbWFwX2ZpeGVkLm00ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTIgLQogbTQv
bHRwLXBlcmZfZXZlbnRfb3Blbi5tNCAgICAgICAgICAgICAgICAgICAgIHwgIDE2IC0KIHBhbi9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCAtCiBwYW4vZGVi
dWcuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgODQgLS0tCiBwYW4vZGVi
dWcuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNjcgLS0tCiBwYW4vbHRw
LXNjYW5uZXIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxNzUgLS0tLS0tLQogcGFu
L3JlcG9ydGVyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjcwIC0tLS0tLS0t
LS0KIHBhbi9yZXBvcnRlci5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA4MCAt
LS0KIHBhbi9zY2FuLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0MiAt
LQogcGFuL3NjYW4ubCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNDU2IC0t
LS0tLS0tLS0tLS0tLS0tCiBwYW4vc3ltYm9sLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCA0NjcgLS0tLS0tLS0tLS0tLS0tLS0KIHBhbi9zeW1ib2wuaCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDEwNCAtLS0tCiBwYW4vdGFnX3JlcG9ydC5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCA0NzggLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMv
Y3ZlL2N2ZS0yMDE1LTMyOTAuYyAgICAgICAgICAgICAgICAgfCAgIDcgKy0KIHRlc3RjYXNlcy9r
ZXJuZWwvbWVtL3RocC90aHAwMi5jICAgICAgICAgICAgICB8ICAgNSAtCiB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2V2ZW50ZmQvZXZlbnRmZDAxLmMgfCAgMTggKy0KIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbXJlbWFwL21yZW1hcDA1LmMgICB8ICAxMSAtCiAuLi4vcGVyZl9ldmVudF9v
cGVuL3BlcmZfZXZlbnRfb3BlbjAxLmMgICAgICAgfCAgMTYgKy0KIC4uLi9wZXJmX2V2ZW50X29w
ZW4vcGVyZl9ldmVudF9vcGVuMDIuYyAgICAgICB8ICAgOCArLQogLi4uL3BlcmZfZXZlbnRfb3Bl
bi9wZXJmX2V2ZW50X29wZW4wMy5jICAgICAgIHwgICA3ICstCiB0ZXN0Y2FzZXMvcmVhbHRpbWUv
Y29uZmlndXJlLmFjICAgICAgICAgICAgICAgfCAgIDQgKy0KIHRlc3RjYXNlcy9yZWFsdGltZS9t
NC9jaGVjay5tNCAgICAgICAgICAgICAgICB8ICAgNiArLQogdGVzdGNhc2VzL3JlYWx0aW1lL200
L2x0cC1leHAxMC5tNCAgICAgICAgICAgIHwgIDM3IC0tCiAzMCBmaWxlcyBjaGFuZ2VkLCAzMCBp
bnNlcnRpb25zKCspLCAyNDIzIGRlbGV0aW9ucygtKQogZGVsZXRlIG1vZGUgMTAwNjQ0IG00L2x0
cC1jbG9uZTdhcmdzLm00CiBkZWxldGUgbW9kZSAxMDA2NDQgbTQvbHRwLW1yZW1hcF9maXhlZC5t
NAogZGVsZXRlIG1vZGUgMTAwNjQ0IG00L2x0cC1wZXJmX2V2ZW50X29wZW4ubTQKIGRlbGV0ZSBt
b2RlIDEwMDY0NCBwYW4vZGVidWcuYwogZGVsZXRlIG1vZGUgMTAwNjQ0IHBhbi9kZWJ1Zy5oCiBk
ZWxldGUgbW9kZSAxMDA2NDQgcGFuL2x0cC1zY2FubmVyLmMKIGRlbGV0ZSBtb2RlIDEwMDY0NCBw
YW4vcmVwb3J0ZXIuYwogZGVsZXRlIG1vZGUgMTAwNjQ0IHBhbi9yZXBvcnRlci5oCiBkZWxldGUg
bW9kZSAxMDA2NDQgcGFuL3NjYW4uaAogZGVsZXRlIG1vZGUgMTAwNjQ0IHBhbi9zY2FuLmwKIGRl
bGV0ZSBtb2RlIDEwMDY0NCBwYW4vc3ltYm9sLmMKIGRlbGV0ZSBtb2RlIDEwMDY0NCBwYW4vc3lt
Ym9sLmgKIGRlbGV0ZSBtb2RlIDEwMDY0NCBwYW4vdGFnX3JlcG9ydC5jCiBkZWxldGUgbW9kZSAx
MDA2NDQgdGVzdGNhc2VzL3JlYWx0aW1lL200L2x0cC1leHAxMC5tNAoKLS0gCjIuMzQuMQoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
