Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADB5F44858
	for <ltp@archiver.kernel.org>; Sat, 11 Apr 2026 10:10:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E778C3E268C
	for <ltp@archiver.kernel.org>; Sat, 11 Apr 2026 12:10:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1AAF3E1476
 for <ltp@lists.linux.it>; Sat, 11 Apr 2026 11:46:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5DC4F1400153
 for <ltp@lists.linux.it>; Sat, 11 Apr 2026 11:46:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2550C5BD0B;
 Sat, 11 Apr 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CC1E4A2C9;
 Sat, 11 Apr 2026 09:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pPIpFXUY2mmOOgAAD6G6ig
 (envelope-from <>); Sat, 11 Apr 2026 09:46:29 +0000
From: acervesato@ltp-agent
To: Ricardo Branco <rbranco@suse.de>
Date: Sat, 11 Apr 2026 09:46:23 +0000
Message-ID: <20260411094623.3963-1-ltp-ci@noreply.github.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411092452.211540-1-rbranco@suse.de>
References: <20260411092452.211540-1-rbranco@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_NO_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 noreply.github.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Sat, 11 Apr 2026 12:10:08 +0200
Subject: Re: [LTP] userfaultfd: Use two-step handshake to probe features
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

SGkgUmljYXJkbywKCm91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2gu
CgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3Vn
aCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRo
IHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdn
ZXN0aW9ucy4KCk9uIFNhdCwgMTEgQXByIDIwMjYgMTE6MjQ6NTEgKzAyMDAsIFJpY2FyZG8gQnJh
bmNvIHdyb3RlOgo+IHVzZXJmYXVsdGZkOiBVc2UgdHdvLXN0ZXAgaGFuZHNoYWtlIHRvIHByb2Jl
IGZlYXR1cmVzCgo+ICsgICAgICAgaWYgKCEodWZmZGlvX2FwaS5mZWF0dXJlcyAmIFVGRkRfRkVB
VFVSRV9QQUdFRkFVTFRfRkxBR19XUCkpCj4gKyAgICAgICAgICAgICAgIHRzdF9icmsoVENPTkYs
ICJVRkZEX0ZFQVRVUkVfUEFHRUZBVUxUX0ZMQUdfV1Agbm90IHN1cHBvcnRlZCIpOwo+ICsgICAg
ICAgU0FGRV9DTE9TRSh1ZmZkKTsKCnRzdF9icmsoKSBsb25nam1wcyBvdXQgb2YgcnVuKCksIHNv
IFNBRkVfQ0xPU0UgbmV2ZXIgZXhlY3V0ZXMg4oCUIGNsb3NlIHVmZmQKYmVmb3JlIGNhbGxpbmcg
dHN0X2JyaygpLiB1c2VyZmF1bHRmZDA1LmMgYWxzbyBoYXMgbm8gLmNsZWFudXAsIHNvIHRoZSBw
YWdlCm1tYXAgZnJvbSBzZXRfcGFnZXMoKSBsZWFrcyB0b287IGFkZCAuY2xlYW51cCA9IHJlc2V0
X3BhZ2VzIHRvIHN0cnVjdCB0c3RfdGVzdC4KClsuLi5dCgo+ICsgICAgICAgaWYgKCEodWZmZGlv
X2FwaS5mZWF0dXJlcyAmIFVGRkRfRkVBVFVSRV9QT0lTT04pKQo+ICsgICAgICAgICAgICAgICB0
c3RfYnJrKFRDT05GLCAiVUZGRF9GRUFUVVJFX1BPSVNPTiBub3Qgc3VwcG9ydGVkIik7Cj4gKyAg
ICAgICBTQUZFX0NMT1NFKHVmZmQpOwoKU2FtZSBpc3N1ZTogY2xvc2UgdWZmZCBiZWZvcmUgY2Fs
bGluZyB0c3RfYnJrKCkuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
