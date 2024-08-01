Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F150C3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:17:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 143553D1F56
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:17:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 164853D1DCB
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:17:41 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A81D5200C68
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:17:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E5AFB1FB4C;
 Thu,  1 Aug 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D22DC13946;
 Thu,  1 Aug 2024 12:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tb0jMuN8q2bKWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 01 Aug 2024 12:17:39 +0000
Date: Thu, 1 Aug 2024 14:20:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Zqt9cFOXlEb-QqHo@rei>
References: <20240801104004.15514-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240801104004.15514-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E5AFB1FB4C
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] cpuset_memory_test.c: Use $TMPDIR as prefix
 for HUGEPAGE file path
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

SGkhCj4gVGVzdCBjYXNlIHdpbGwgZmFpbCB3aXRoIGZvbGxvd2luZyBlcnJvciBpZiBydW5uaW5n
IG9wZXJhdGlvbiBzeXN0ZW0KPiB3aGljaCBmb3JjZSByb290IHBhdGggcmVhZCBPTkxZLgo+IAo+
IG1rZGlyOiBjYW5ub3QgY3JlYXRlIGRpcmVjdG9yeSDigJgvaHVnZXRsYuKAmTogUmVhZC1vbmx5
IGZpbGUgc3lzdGVtCgpDYW4gd2UgcGxlYXNlIHN0b3AgYXBwbHlpbmcgYmFuZCBhaWRzIG92ZXIg
dGhlIG1lc3MgY2FsbGVkIGNwdXNldCB0ZXN0cwphbmQgc3RhcnQgYWN0dWFsbHkgcmV3cml0aW5n
IHRoZW0gaW50byBzb21ldGhpbmcgc2FuZXI/CgpJIHdvdWxkIHN0YXJ0IGJ5IHJlaW1wbGVtZW50
aW5nIHRoZSB0ZXN0NiBhcyBhIHNlcGFyYXRlIEMgdGVzdGNhc2Ugc28KdGhhdCB3ZSBjYW4gbWFr
ZSB1c2Ugb2YgYWxsIHRoZSBpbmZyYXN0cnVjdHVyZSBmb3IgaHVnZXBhZ2VzIHdlIGhhdmUgaW4K
dGhlIHRzdF90ZXN0LgoKLS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
