Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03556C369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 08:43:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B38B3CBC0E
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 10:43:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 346413C0266
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 10:43:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6FF991000759
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 10:43:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA76D1F7A4;
 Tue, 29 Apr 2025 08:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745916193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDZZweZyrHa2+Gzr3jc7G2P43qoTesIoxwm6OGiNgU4=;
 b=q0nNX88ouN9/yPZ0TJ6jti0Pdo6BSGUY8HhYMCQFXnViAG5KSx7TdVozR4Pp/DuUIZgAkZ
 zwNBPTX9WLSGZUY4iM25o9dl/B8PADZaaMJS+6/uxEDwwWVICx2Mm1uYGSOJB1gzcCs2so
 g/vO1SCzWKD79CGD1Wvi/ub9o2tm7ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745916193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDZZweZyrHa2+Gzr3jc7G2P43qoTesIoxwm6OGiNgU4=;
 b=Fm5AymBdUKpG1br3WJBcNN1phAY/BBLvnr3uRHCaHS6lxxd4TVsxr9GjOcVe3KyEGKVDaS
 +ODxpKeu2yWBphAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745916192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDZZweZyrHa2+Gzr3jc7G2P43qoTesIoxwm6OGiNgU4=;
 b=BS7sO1HHA8L8FC3PF7GPTRIOCDYRmZYM7t+7u4n4j3VSz7zOPF0Pj77tGCqIdGqCNVZ0ZS
 BR7zx5dT+fg80tTTT0zh+ZmCCxDXllORmTvuYb8IAo23ZVd1ZhsNukxYZezqEUw6SSJ4G4
 Ap5HWmaTMZh6NE2EUCkHvLN/H9Lu7Qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745916192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDZZweZyrHa2+Gzr3jc7G2P43qoTesIoxwm6OGiNgU4=;
 b=SuZECzIOBoB50ir53rKFsKuSEdJTsij+pHLGqLoXDwEM5p/9gUwSfRmCOuFllzmu6EsJgO
 J0FV6PCUvCJ35kAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CE4513931;
 Tue, 29 Apr 2025 08:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DRfTICCREGinCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Apr 2025 08:43:12 +0000
Date: Tue, 29 Apr 2025 10:43:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250429084311.GA238584@pevik>
References: <20250408161745.9757-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250408161745.9757-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-2.41 / 50.00]; BAYES_HAM(-1.91)[94.52%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tlibio: Get rid of support for old UNIXes
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

SGkgQ3lyaWwsCgo+IFJlbW92ZXMgc3VwcG9ydCBmb3Igb2Jzb2xldGUgVU5JWGVzIENSQVksIHNn
aSwgZXRjLgoKPiBBbHNvIHJlbW92ZXMgdGhlIFVDTElCQyBpZmRlZnMgdGhhdCBkaXNhYmxlZCBt
b3N0IG9mIHRoZSBjb2RlIGJlY2F1c2UKPiBhaW8gaXMgbm90IHN1cHBvcnRlZCBvbiBVQ0xJQkMu
CgpSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpHcmVhdCB3b3JrLCB0
aGFua3MhClJlbW92aW5nIHVudXNlZCBjb2RlIGlzIGFsd2F5cyB1c2VmdWwuCgpDb2RlIGlzIHJl
YWxseSBvbGQgYW5kIHdvdWxkIGRlc2VydmUgcmVmYWN0b3JpbmcuCgpLaW5kIHJlZ2FyZHMsClBl
dHIKCnRsaWJpby5jOiBJbiBmdW5jdGlvbiDigJhsaW9fd3JpdGVfYnVmZmVy4oCZOgp0bGliaW8u
Yzo2MTc6MTc6IHdhcm5pbmc6IOKAmHNpZ3NldOKAmSBpcyBkZXByZWNhdGVkOiBVc2UgdGhlIHNp
Z25hbCBhbmQgc2lncHJvY21hc2sgZnVuY3Rpb25zIGluc3RlYWQgWy1XZGVwcmVjYXRlZC1kZWNs
YXJhdGlvbnNdCiAgNjE3IHwgICAgICAgICAgICAgICAgIHNpZ3NldChzaWcsIGxpb19hc3luY19z
aWduYWxfaGFuZGxlcik7CiAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fgpJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUvc3lzL3BhcmFtLmg6Mjgs
CiAgICAgICAgICAgICAgICAgZnJvbSB0bGliaW8uYzo4MzoKL3Vzci9pbmNsdWRlL3NpZ25hbC5o
OjM2NzoyMzogbm90ZTogZGVjbGFyZWQgaGVyZQogIDM2NyB8IGV4dGVybiBfX3NpZ2hhbmRsZXJf
dCBzaWdzZXQgKGludCBfX3NpZywgX19zaWdoYW5kbGVyX3QgX19kaXNwKSBfX1RIUk9XCiAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgp0bGliaW8uYzo2OTg6MjU6IHdhcm5pbmc6
IOKAmHNpZ2hvbGTigJkgaXMgZGVwcmVjYXRlZDogVXNlIHRoZSBzaWdwcm9jbWFzayBmdW5jdGlv
biBpbnN0ZWFkIFstV2RlcHJlY2F0ZWQtZGVjbGFyYXRpb25zXQogIDY5OCB8ICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpZ2hvbGQoc2lnKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+Ci91c3IvaW5jbHVkZS9zaWduYWwuaDozNTU6MTI6IG5vdGU6IGRlY2xhcmVkIGhl
cmUKICAzNTUgfCBleHRlcm4gaW50IHNpZ2hvbGQgKGludCBfX3NpZykgX19USFJPVwogICAgICB8
ICAgICAgICAgICAgXn5+fn5+fgp0bGliaW8uYzo3MDU6MzM6IHdhcm5pbmc6IOKAmHNpZ3JlbHNl
4oCZIGlzIGRlcHJlY2F0ZWQ6IFVzZSB0aGUgc2lncHJvY21hc2sgZnVuY3Rpb24gaW5zdGVhZCBb
LVdkZXByZWNhdGVkLWRlY2xhcmF0aW9uc10KICA3MDUgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpZ3JlbHNlKHNpZyk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBefn5+fn5+fgovdXNyL2luY2x1ZGUvc2lnbmFsLmg6MzU5OjEyOiBub3RlOiBkZWNs
YXJlZCBoZXJlCiAgMzU5IHwgZXh0ZXJuIGludCBzaWdyZWxzZSAoaW50IF9fc2lnKSBfX1RIUk9X
CiAgICAgIHwgICAgICAgICAgICBefn5+fn5+fgp0bGliaW8uYzo3MjU6MjU6IHdhcm5pbmc6IOKA
mHNpZ2hvbGTigJkgaXMgZGVwcmVjYXRlZDogVXNlIHRoZSBzaWdwcm9jbWFzayBmdW5jdGlvbiBp
bnN0ZWFkIFstV2RlcHJlY2F0ZWQtZGVjbGFyYXRpb25zXQogIDcyNSB8ICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpZ2hvbGQoc2lnKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+Ci91c3IvaW5jbHVkZS9zaWduYWwuaDozNTU6MTI6IG5vdGU6IGRlY2xhcmVkIGhlcmUK
ICAzNTUgfCBleHRlcm4gaW50IHNpZ2hvbGQgKGludCBfX3NpZykgX19USFJPVwogICAgICB8ICAg
ICAgICAgICAgXn5+fn5+fgp0bGliaW8uYzo3MzI6MzM6IHdhcm5pbmc6IOKAmHNpZ3JlbHNl4oCZ
IGlzIGRlcHJlY2F0ZWQ6IFVzZSB0aGUgc2lncHJvY21hc2sgZnVuY3Rpb24gaW5zdGVhZCBbLVdk
ZXByZWNhdGVkLWRlY2xhcmF0aW9uc10KICA3MzIgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpZ3JlbHNlKHNpZyk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBefn5+fn5+fgovdXNyL2luY2x1ZGUvc2lnbmFsLmg6MzU5OjEyOiBub3RlOiBkZWNsYXJl
ZCBoZXJlCiAgMzU5IHwgZXh0ZXJuIGludCBzaWdyZWxzZSAoaW50IF9fc2lnKSBfX1RIUk9XCiAg
ICAgIHwgICAgICAgICAgICBefn5+fn5+fgp0bGliaW8uYzo3NTk6MjU6IHdhcm5pbmc6IOKAmHNp
Z2hvbGTigJkgaXMgZGVwcmVjYXRlZDogVXNlIHRoZSBzaWdwcm9jbWFzayBmdW5jdGlvbiBpbnN0
ZWFkIFstV2RlcHJlY2F0ZWQtZGVjbGFyYXRpb25zXQogIDc1OSB8ICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpZ2hvbGQoc2lnKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+
fn5+Ci91c3IvaW5jbHVkZS9zaWduYWwuaDozNTU6MTI6IG5vdGU6IGRlY2xhcmVkIGhlcmUKICAz
NTUgfCBleHRlcm4gaW50IHNpZ2hvbGQgKGludCBfX3NpZykgX19USFJPVwogICAgICB8ICAgICAg
ICAgICAgXn5+fn5+fgp0bGliaW8uYzo3NjY6MzM6IHdhcm5pbmc6IOKAmHNpZ3JlbHNl4oCZIGlz
IGRlcHJlY2F0ZWQ6IFVzZSB0aGUgc2lncHJvY21hc2sgZnVuY3Rpb24gaW5zdGVhZCBbLVdkZXBy
ZWNhdGVkLWRlY2xhcmF0aW9uc10KICA3NjYgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNpZ3JlbHNlKHNpZyk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+fgovdXNyL2luY2x1ZGUvc2lnbmFsLmg6MzU5OjEyOiBub3RlOiBkZWNsYXJlZCBo
ZXJlCiAgMzU5IHwgZXh0ZXJuIGludCBzaWdyZWxzZSAoaW50IF9fc2lnKSBfX1RIUk9XCiAgICAg
IHwgICAgICAgICAgICBefn5+fn5+fgp0bGliaW8uYzo1MDc6MjI6IHdhcm5pbmc6IHVudXNlZCBw
YXJhbWV0ZXIg4oCYd3Jk4oCZIFstV3VudXNlZC1wYXJhbWV0ZXJdCiAgNTA3IHwgICAgICAgICAg
ICAgICAgIGxvbmcgd3JkKSAgICAgICAvKiB0byBhbGxvdyBmdXR1cmUgZmVhdHVyZXMsIHVzZSB6
ZXJvIGZvciBub3cgKi8KICAgICAgfCAgICAgICAgICAgICAgICAgfn5+fn5efn4KdGxpYmlvLmM6
IEluIGZ1bmN0aW9uIOKAmGxpb19yZWFkX2J1ZmZlcuKAmToKdGxpYmlvLmM6OTk5OjE3OiB3YXJu
aW5nOiDigJhzaWdzZXTigJkgaXMgZGVwcmVjYXRlZDogVXNlIHRoZSBzaWduYWwgYW5kIHNpZ3By
b2NtYXNrIGZ1bmN0aW9ucyBpbnN0ZWFkIFstV2RlcHJlY2F0ZWQtZGVjbGFyYXRpb25zXQogIDk5
OSB8ICAgICAgICAgICAgICAgICBzaWdzZXQoc2lnLCBsaW9fYXN5bmNfc2lnbmFsX2hhbmRsZXIp
OwogICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn4KL3Vzci9pbmNsdWRlL3NpZ25hbC5oOjM2
NzoyMzogbm90ZTogZGVjbGFyZWQgaGVyZQogIDM2NyB8IGV4dGVybiBfX3NpZ2hhbmRsZXJfdCBz
aWdzZXQgKGludCBfX3NpZywgX19zaWdoYW5kbGVyX3QgX19kaXNwKSBfX1RIUk9XCiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgp0bGliaW8uYzoxMDgwOjI1OiB3YXJuaW5nOiDi
gJhzaWdob2xk4oCZIGlzIGRlcHJlY2F0ZWQ6IFVzZSB0aGUgc2lncHJvY21hc2sgZnVuY3Rpb24g
aW5zdGVhZCBbLVdkZXByZWNhdGVkLWRlY2xhcmF0aW9uc10KIDEwODAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICBzaWdob2xkKHNpZyk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
Xn5+fn5+fgovdXNyL2luY2x1ZGUvc2lnbmFsLmg6MzU1OjEyOiBub3RlOiBkZWNsYXJlZCBoZXJl
CiAgMzU1IHwgZXh0ZXJuIGludCBzaWdob2xkIChpbnQgX19zaWcpIF9fVEhST1cKICAgICAgfCAg
ICAgICAgICAgIF5+fn5+fn4KdGxpYmlvLmM6MTA4NzozMzogd2FybmluZzog4oCYc2lncmVsc2Xi
gJkgaXMgZGVwcmVjYXRlZDogVXNlIHRoZSBzaWdwcm9jbWFzayBmdW5jdGlvbiBpbnN0ZWFkIFst
V2RlcHJlY2F0ZWQtZGVjbGFyYXRpb25zXQogMTA4NyB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2lncmVsc2Uoc2lnKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+Ci91c3IvaW5jbHVkZS9zaWduYWwuaDozNTk6MTI6IG5vdGU6IGRlY2xh
cmVkIGhlcmUKICAzNTkgfCBleHRlcm4gaW50IHNpZ3JlbHNlIChpbnQgX19zaWcpIF9fVEhST1cK
ICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+CnRsaWJpby5jOjExMDc6MjU6IHdhcm5pbmc6IOKA
mHNpZ2hvbGTigJkgaXMgZGVwcmVjYXRlZDogVXNlIHRoZSBzaWdwcm9jbWFzayBmdW5jdGlvbiBp
bnN0ZWFkIFstV2RlcHJlY2F0ZWQtZGVjbGFyYXRpb25zXQogMTEwNyB8ICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpZ2hvbGQoc2lnKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+Ci91c3IvaW5jbHVkZS9zaWduYWwuaDozNTU6MTI6IG5vdGU6IGRlY2xhcmVkIGhlcmUK
ICAzNTUgfCBleHRlcm4gaW50IHNpZ2hvbGQgKGludCBfX3NpZykgX19USFJPVwogICAgICB8ICAg
ICAgICAgICAgXn5+fn5+fgp0bGliaW8uYzoxMTE0OjMzOiB3YXJuaW5nOiDigJhzaWdyZWxzZeKA
mSBpcyBkZXByZWNhdGVkOiBVc2UgdGhlIHNpZ3Byb2NtYXNrIGZ1bmN0aW9uIGluc3RlYWQgWy1X
ZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnNdCiAxMTE0IHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaWdyZWxzZShzaWcpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn5+fn5+fn4KL3Vzci9pbmNsdWRlL3NpZ25hbC5oOjM1OToxMjogbm90ZTogZGVjbGFy
ZWQgaGVyZQogIDM1OSB8IGV4dGVybiBpbnQgc2lncmVsc2UgKGludCBfX3NpZykgX19USFJPVwog
ICAgICB8ICAgICAgICAgICAgXn5+fn5+fn4KdGxpYmlvLmM6MTE0MToyNTogd2FybmluZzog4oCY
c2lnaG9sZOKAmSBpcyBkZXByZWNhdGVkOiBVc2UgdGhlIHNpZ3Byb2NtYXNrIGZ1bmN0aW9uIGlu
c3RlYWQgWy1XZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnNdCiAxMTQxIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgc2lnaG9sZChzaWcpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIF5+
fn5+fn4KL3Vzci9pbmNsdWRlL3NpZ25hbC5oOjM1NToxMjogbm90ZTogZGVjbGFyZWQgaGVyZQog
IDM1NSB8IGV4dGVybiBpbnQgc2lnaG9sZCAoaW50IF9fc2lnKSBfX1RIUk9XCiAgICAgIHwgICAg
ICAgICAgICBefn5+fn5+CnRsaWJpby5jOjExNDg6MzM6IHdhcm5pbmc6IOKAmHNpZ3JlbHNl4oCZ
IGlzIGRlcHJlY2F0ZWQ6IFVzZSB0aGUgc2lncHJvY21hc2sgZnVuY3Rpb24gaW5zdGVhZCBbLVdk
ZXByZWNhdGVkLWRlY2xhcmF0aW9uc10KIDExNDggfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpZ3JlbHNlKHNpZyk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBefn5+fn5+fgovdXNyL2luY2x1ZGUvc2lnbmFsLmg6MzU5OjEyOiBub3RlOiBkZWNsYXJl
ZCBoZXJlCiAgMzU5IHwgZXh0ZXJuIGludCBzaWdyZWxzZSAoaW50IF9fc2lnKSBfX1RIUk9XCiAg
ICAgIHwgICAgICAgICAgICBefn5+fn5+fgp0bGliaW8uYzo4ODg6MjI6IHdhcm5pbmc6IHVudXNl
ZCBwYXJhbWV0ZXIg4oCYd3Jk4oCZIFstV3VudXNlZC1wYXJhbWV0ZXJdCiAgODg4IHwgICAgICAg
ICAgICAgICAgIGxvbmcgd3JkKSAgICAgICAvKiB0byBhbGxvdyBmdXR1cmUgZmVhdHVyZXMsIHVz
ZSB6ZXJvIGZvciBub3cgKi8KICAgICAgfCAgICAgICAgICAgICAgICAgfn5+fn5efn4KdGxpYmlv
LmM6IEluIGZ1bmN0aW9uIOKAmGxpb19jaGVja19hc3luY2lv4oCZOgp0bGliaW8uYzoxMjQ5OjE3
OiB3YXJuaW5nOiDigJhzaWdyZWxzZeKAmSBpcyBkZXByZWNhdGVkOiBVc2UgdGhlIHNpZ3Byb2Nt
YXNrIGZ1bmN0aW9uIGluc3RlYWQgWy1XZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnNdCiAxMjQ5IHwg
ICAgICAgICAgICAgICAgIHNpZ3JlbHNlKGFpb2NicC0+YWlvX3NpZ2V2ZW50LnNpZ2V2X3NpZ25v
KTsKICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn4KL3Vzci9pbmNsdWRlL3NpZ25hbC5o
OjM1OToxMjogbm90ZTogZGVjbGFyZWQgaGVyZQogIDM1OSB8IGV4dGVybiBpbnQgc2lncmVsc2Ug
KGludCBfX3NpZykgX19USFJPVwogICAgICB8ICAgICAgICAgICAgXn5+fn5+fn4KdGxpYmlvLmM6
IEluIGZ1bmN0aW9uIOKAmGxpb193YWl0NGFzeW5jaW/igJk6CnRsaWJpby5jOjEzODk6MjU6IHdh
cm5pbmc6IOKAmHNpZ3JlbHNl4oCZIGlzIGRlcHJlY2F0ZWQ6IFVzZSB0aGUgc2lncHJvY21hc2sg
ZnVuY3Rpb24gaW5zdGVhZCBbLVdkZXByZWNhdGVkLWRlY2xhcmF0aW9uc10KIDEzODkgfCAgICAg
ICAgICAgICAgICAgICAgICAgICBzaWdyZWxzZShhaW9jYnAtPmFpb19zaWdldmVudC5zaWdldl9z
aWdubyk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn4KL3Vzci9pbmNs
dWRlL3NpZ25hbC5oOjM1OToxMjogbm90ZTogZGVjbGFyZWQgaGVyZQogIDM1OSB8IGV4dGVybiBp
bnQgc2lncmVsc2UgKGludCBfX3NpZykgX19USFJPVwogICAgICB8ICAgICAgICAgICAgXn5+fn5+
fn4KdGxpYmlvLmM6MTM5NzoyNTogd2FybmluZzog4oCYc2lncmVsc2XigJkgaXMgZGVwcmVjYXRl
ZDogVXNlIHRoZSBzaWdwcm9jbWFzayBmdW5jdGlvbiBpbnN0ZWFkIFstV2RlcHJlY2F0ZWQtZGVj
bGFyYXRpb25zXQogMTM5NyB8ICAgICAgICAgICAgICAgICAgICAgICAgIHNpZ3JlbHNlKGFpb2Ni
cC0+YWlvX3NpZ2V2ZW50LnNpZ2V2X3NpZ25vKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICBefn5+fn5+fgovdXNyL2luY2x1ZGUvc2lnbmFsLmg6MzU5OjEyOiBub3RlOiBkZWNsYXJl
ZCBoZXJlCiAgMzU5IHwgZXh0ZXJuIGludCBzaWdyZWxzZSAoaW50IF9fc2lnKSBfX1RIUk9XCiAg
ICAgIHwgICAgICAgICAgICBefn5+fn5+fgpDQyBsaWIvdGxpYmlvLm8KQVIgbGlibHRwLmEKUkFO
TElCIGxpYmx0cC5hCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
