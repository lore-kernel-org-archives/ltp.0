Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEE6D185DD
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 12:13:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFE2B3C5F49
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 13:13:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26A763C5709
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 13:13:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C844B2002CA
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 13:13:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 793835C481;
 Thu,  8 Jan 2026 12:13:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45A7A3EA63;
 Thu,  8 Jan 2026 12:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0eIYDlKfX2mxPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Jan 2026 12:13:06 +0000
Date: Thu, 8 Jan 2026 13:13:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <20260108121304.GA12024@pevik>
References: <20260108103606.35227-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260108103606.35227-1-po-hsu.lin@canonical.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 793835C481
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCHv2] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17.9
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

SGkgUG8tSHN1IExpbiwKCj4gVGhlIGtlcm5lbCBjaGFuZ2UgNzhmMGUzM2NkNmM5MyAoImZzL25h
bWVzcGFjZTogY29ycmVjdGx5IGhhbmRsZSBlcnJvcnMKPiByZXR1cm5lZCBieSBncmFiX3JlcXVl
c3RlZF9tbnRfbnMiKSBmcm9tIDYuMTggaGFzIGJlZW4gcG9ydGVkIHRvIHVwc3RyZWFtCj4gNi4x
Ny45IFsxXVsyXS4KCj4gVGhlcmVmb3JlIGNoYW5nZSB0aGUgZXhwZWN0YXRpb24gZnJvbSA+PSA2
LjE4IHRvID49IDYuMTcuOSBhY2NvZGluZ2x5LgoKPiBbMV0gaHR0cHM6Ly9sd24ubmV0L0FydGlj
bGVzLzEwNDc2ODQvCj4gWzJdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29tbWl0Lz9oPXY2LjE3LjkmaWQ9OGZmOTdhZGUK
Cj4gdjI6IGFkZCBjb21tZW50cyBmb3IgdGhpcyBjaGFuZ2UgaW50byB0aGUgY29kZS4KCj4gU2ln
bmVkLW9mZi1ieTogUG8tSHN1IExpbiA8cG8taHN1LmxpbkBjYW5vbmljYWwuY29tPgo+IC0tLQo+
ICAuLi4va2VybmVsL3N5c2NhbGxzL2xpc3Rtb3VudC9saXN0bW91bnQwNC5jICAgIHwgMTggKysr
KysrKysrKystLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQoKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saXN0
bW91bnQvbGlzdG1vdW50MDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGlzdG1vdW50
L2xpc3Rtb3VudDA0LmMKPiBpbmRleCAyYjhiNDkxMDEuLjU5ZGE0NmNmZCAxMDA2NDQKPiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xpc3Rtb3VudC9saXN0bW91bnQwNC5jCj4gKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saXN0bW91bnQvbGlzdG1vdW50MDQuYwo+IEBA
IC03LDYgKzcsMTAgQEAKPiAgICogVmVyaWZ5IHRoYXQgbGlzdG1vdW50KCkgcmFpc2VzIHRoZSBj
b3JyZWN0IGVycm9ycyBhY2NvcmRpbmcgd2l0aAo+ICAgKiBpbnZhbGlkIGRhdGE6Cj4gICAqCj4g
KyAqIC0gRUJBREY6IGludmFsaWQgbW50X25zX2ZkCj4gKyAqIFRoaXMgY2hlY2sgd2FzIGludHJv
ZHVjZWQgZm9yIGtlcm5lbCBjb21taXQgNzhmMGUzM2NkNmM5ICgiZnMvbmFtZXNwYWNlOgo+ICsg
KiBjb3JyZWN0bHkgaGFuZGxlIGVycm9ycyByZXR1cm5lZCBieSBncmFiX3JlcXVlc3RlZF9tbnRf
bnMiKSBpbnRyb2R1Y2VkCj4gKyAqIGluIHY2LjE4LXJjNyBhbmQgYmFja3BvcnRlZCB0byB2Ni4x
Ny45LgoKVEw7RFIKUGxlYXNlIGVpdGhlciBmaXggUlNUIHN5bnRheCBvciBtb3ZlIHRleHQgb3V0
c2lkZSAvKlwgc2VjdGlvbi4KCklNSE8gdGhpcyBpcyBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWws
IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBpdCBpbiB0aGUgdGVzdApjYXRhbG9nIGRvY3MgWzFdLiBJ
IHdvdWxkIGp1c3QgcHV0IHRoaXMgY29tbWVudCBhYm92ZSBtYWNybyBkZWZpbml0aW9uOiAjZGVm
aW5lCkJFRk9SRV82XzE3XzkgMS4KCkFsc28gdGhpcyBpcyBhIHdyb25nIFJTVCBzeW50YXguIEZZ
SSB3ZSBwYXJzZSB0aGlzIGludG8gc3BoaW54IGRvY3MgWzFdIGFuZAp0aGlzIGJyZWFrcyBmb3Jt
YXR0aW5nIG9mIHRoZSBsaXN0OgoKKiBFQkFERjogaW52YWxpZCBtbnRfbnNfZmQKClRoaXMgY2hl
Y2sgd2FzIGludHJvZHVjZWQgZm9yIGtlcm5lbCBjb21taXQgNzhmMGUzM2NkNmM5ICjigJxmcy9u
YW1lc3BhY2U6IGNvcnJlY3RseSBoYW5kbGUgZXJyb3JzIHJldHVybmVkIGJ5IGdyYWJfcmVxdWVz
dGVkX21udF9uc+KAnSkgaW50cm9kdWNlZCBpbiB2Ni4xOC1yYzcgYW5kIGJhY2twb3J0ZWQgdG8g
djYuMTcuOS4gLSBFRkFVTFQ6IHJlcSBvciBtbnRfaWQgYXJlIHVuYWNjZXNzaWJsZSBtZW1vcmll
cyAtIEVJTlZBTDogaW52YWxpZCBmbGFncyBvciBtbnRfaWQgcmVxdWVzdCAtIEVOT0VOVDogbm9u
LWV4aXN0ZW50IG1vdW50IHBvaW50CgpJZiB5b3UgcnVuOgokIGNkIGRvYzsgbWFrZSBzZXR1cCAm
JiBtYWtlCgp5b3UnbGwgZ2V0IGxvY2FsIGJ1aWxkIG9mIHRoZSBkb2N1bWVudGF0aW9uLCBzZWUg
Li9odG1sL3VzZXJzL3Rlc3RfY2F0YWxvZy5odG1sI2xpc3Rtb3VudDA0CgpLaW5kIHJlZ2FyZHMs
ClBldHIKClsxXSBmaWxlOi8vL2hvbWUvcGV2aWsvaW5zdGFsbC9zcmMvbHRwLmdpdC9kb2MvaHRt
bC91c2Vycy90ZXN0X2NhdGFsb2cuaHRtbCNsaXN0bW91bnQwNAoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
