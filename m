Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18717CCD195
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 13:34:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AE343CEE1D
	for <ltp@archiver.kernel.org>; Thu, 16 Oct 2025 15:34:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A111F3C7B08
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 15:34:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 04096600292
 for <ltp@lists.linux.it>; Thu, 16 Oct 2025 15:34:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2C0121D42;
 Thu, 16 Oct 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC9A71340C;
 Thu, 16 Oct 2025 13:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LkjqKGz08GikSgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Oct 2025 13:34:36 +0000
Date: Thu, 16 Oct 2025 15:35:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aPD0oQRSUqVATsZs@yuki.lan>
References: <20250917102737.GA336745@pevik>
 <aa769509-d4b8-46eb-b02d-699a573b0080@suse.com>
 <20250929083156.GA199802@pevik> <aPDlzuox-54oxTtp@yuki.lan>
 <20251016130952.GA281409@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251016130952.GA281409@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: C2C0121D42
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] 'nobody' user for testing
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> OK, I can write it unless Jan plans to work on it (Jan, please let me know).
> 
> I propose to have the usual LTP approach to have functionality used by C API
> (e.g. lib/tst_sudo.c) and reused by thin wrapper available for shell API
> (testcases/lib/tst_sudo.c).
> 
> Few C API tests would use it (prctl06 and other mentioned previously [1] as 3)),
> in shell API only these 2 IMA tests.

There are likely more nuances in the tests that use C, some set real
uid/git some only uid etc. So I wouldn't bother adding helper for six
tests or so and write directly just the shell helper.

> > And I think that the question if we need a separate user for LTP testing is
> > orthogonal.
> 
> Agree. I just brought these two topics together as they are related.
> So, as a separate topic/effort, do you see any room for C API functions for 1)
> and 2) in [1]?

Technically most of the C tests does not even need an user to be created
on the system. They just need UID/GID that is not priviledged, kernel
does not really care about the users in /etc/passwd that's purely
userspace thing. All that kernel does is to compare numbers before it
allows/disallows access. So we may get away with a function that returns
UID and GID suitable for the tests, or even a global varible.

Possibly we may add:

struct tst_usr {
	uid_t uid;
	gid_t gid;
};

struct tst_usr tst_usr = {
	.uid = 65534,
	.gid = 65534,
};

and add an option to override these values with TST_USR_UID and
TST_USR_GID.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
