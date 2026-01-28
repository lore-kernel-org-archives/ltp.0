Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A0CD25B45
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 11:24:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87BE23CAF03
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 12:24:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B87D23C4BEF
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 12:24:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 187D91400B73
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 12:24:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 79A645BCDF;
 Wed, 28 Jan 2026 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769599460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62GymyqONCdgkv2a3selUWNQi4Ao1j7Bc+evTI7juJM=;
 b=nyjw8MeLSUtLQ4yxzUan20OBFlySQhUayn1ihQE1NmDdtBajHiyq/QGQqTDiDL20g9jA9n
 +b1wgZHer/MzcW6A1wHAFN9/NHK56cwWDuovkTREJnYQSdFD4EV+/rs2SJmqmFl8YuaH0s
 5YnJ7iV4iwY1u7zNtw2SOqGUKX8LNcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769599460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62GymyqONCdgkv2a3selUWNQi4Ao1j7Bc+evTI7juJM=;
 b=QJ9L9y0+wuZuqLPO7Yq2vXNXAuVNMVf3PDc7NdXHxZWHIYcMSjeamMl2Yw+RD3SF9wftZN
 08qdnZmy4BNw1TDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769599460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62GymyqONCdgkv2a3selUWNQi4Ao1j7Bc+evTI7juJM=;
 b=nyjw8MeLSUtLQ4yxzUan20OBFlySQhUayn1ihQE1NmDdtBajHiyq/QGQqTDiDL20g9jA9n
 +b1wgZHer/MzcW6A1wHAFN9/NHK56cwWDuovkTREJnYQSdFD4EV+/rs2SJmqmFl8YuaH0s
 5YnJ7iV4iwY1u7zNtw2SOqGUKX8LNcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769599460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62GymyqONCdgkv2a3selUWNQi4Ao1j7Bc+evTI7juJM=;
 b=QJ9L9y0+wuZuqLPO7Yq2vXNXAuVNMVf3PDc7NdXHxZWHIYcMSjeamMl2Yw+RD3SF9wftZN
 08qdnZmy4BNw1TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E9D93EA61;
 Wed, 28 Jan 2026 11:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VzxzDeTxeWnERgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Wed, 28 Jan 2026 11:24:20 +0000
Message-ID: <42c5be4b-89cb-4a11-8e41-62f5afa7ab49@suse.de>
Date: Wed, 28 Jan 2026 12:24:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
 ltp@lists.linux.it
References: <aWjZX0fsrTJMqq49@yuki.lan> <aXi4P0YdKx5rFZ8C@yuki.lan>
 <b8a027d4-241c-4934-95c4-61df15ccebe6@suse.cz>
Content-Language: en-US
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <b8a027d4-241c-4934-95c4-61df15ccebe6@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDEvMjgvMjYgMTE6NTIgQU0sIE1hcnRpbiBEb3VjaGEgd3JvdGU6Cj4gT24gMS8yNy8yNiAx
NDowNiwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+PiBIaSEKPj4gQXJlIHRoZXJlIGFueSBvdGhlciBm
aXhlcyB0aGF0IHNob3VsZCBiZSBjb25zaWRlcmVkIGJlZm9yZSB0aGUgZ2l0IGlzCj4+IHRhZ2dl
ZD8KPgo+IEhpLAo+IG91ciBwcmUtcmVsZWFzZSB0ZXN0aW5nIGhhcyBmb3VuZCBhIGZhaWx1cmUg
aW4gdXNlcmZhdWx0ZmQwMyBvbiBrZXJuZWwgCj4gdjUuMTQgYmVjYXVzZSB0aGUgdGVzdCBjYW4n
dCBmaW5kIC9kZXYvdXNlcmZhdWx0ZmQuIEFjY29yZGluZyB0byAKPiBrZXJuZWwgZ2l0LCB0aGUg
ZmlsZSB3YXMgYWRkZWQgaW4gdGhpcyBjb21taXQ6Cj4KPiBodHRwczovL2dpdGh1Yi5jb20vdG9y
dmFsZHMvbGludXgvY29tbWl0LzJkNWRlMDA0ZTAwOWFkZDI3ZGI3NmM1Y2RjOWYxZjdmN2RjMDg3
ZTcgCj4KPgo+IHdoaWNoIHdhcyBmaXJzdCBtZXJnZWQgaW50byBrZXJuZWwgdjYuMS4gQnV0IHRo
ZSB0ZXN0IGhhcyAKPiAubWluX2t2ZXI9IjUuMTEiLgo+Cj4gUmljYXJkbywgaG93IGRpZCB5b3Ug
Y2hvb3NlIHRoZSBtaW5pbWFsIGtlcm5lbCB2ZXJzaW9uIGZvciB0aGlzIHRlc3Q/CgpodHRwczov
L2x3bi5uZXQvQXJ0aWNsZXMvODk3MjYwLwoKPgo+IEkgcmVjb21tZW5kIHJlbW92aW5nIHRoZSAu
bWluX2t2ZXIgYXR0cmlidXRlIGFuZCBjaGVja2luZyBmb3IgdGhlIAo+IHByZXNlbmNlIG9mIC9k
ZXYvdXNlcmZhdWx0ZmQgaW5zdGVhZC4gSWYgdGhlIGZpbGUgaXMgbWlzc2luZyBhbmQgdGhlIAo+
IGtlcm5lbCBpcyBvbGRlciB0aGFuIHY2LjEsIHRoZW4gVENPTkYsIG90aGVyd2lzZSBUQlJPSy4g
CgpPay7CoCBXaWxsIHRyeSB0byBzdWJtaXQgYSBmaXggQVNBUC4KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
