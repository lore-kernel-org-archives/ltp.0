Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59592C83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 19:50:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C99FB3CCDC6
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 21:50:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 579B93CC935
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 21:50:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF26E60055F
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 21:50:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04DC721233;
 Wed, 23 Jul 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADAF613ABE;
 Wed, 23 Jul 2025 19:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rffaKPQ8gWg9CgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Jul 2025 19:50:12 +0000
Date: Wed, 23 Jul 2025 21:50:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250723195011.GD162896@pevik>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <a911cbc1-ad7e-4b0e-97f0-4e2c594c7084@suse.com>
 <20250723124127.GA154226@pevik>
 <3a8c2634-09d2-4d29-951a-4e5c5b1adef1@suse.com>
 <CAEjxPJ7bj-4_PSKiSuH57UZJWof7ky9QECkUeaeWX8T81wHtjQ@mail.gmail.com>
 <CAEjxPJ5g5EGQ-3Vq7b7YTnW6O0O=GM6yxxFa8cvfJ8uSjYTUTw@mail.gmail.com>
 <abbb4f90-d163-447a-bbb2-e860371e0179@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abbb4f90-d163-447a-bbb2-e860371e0179@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 04DC721233
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Stephen,

> On 7/23/25 3:13 PM, Stephen Smalley wrote:
> > To be more precise, the bug is only triggerable for LSMs that
> > implement the listsecurity LSM hook (to return a synthesized security
> > xattr regardless of whether one is set in the filesystem), which are
> > only SELinux and Smack.

+1

> Thanks for the clarification. I guess we have a solution: we can take a look
> at /sys/kernel/security/lsm and verify if smack/selinux are enabled.

Given that "selinux" is *not* in /sys/kernel/security/lsm when "security=selinux
selinux=0 enforcing=0" as kernel cmdline and it on "security=selinux selinux=1
enforcing=0" this is really the best solution.

Thank you both for your patience to get a reliable test!

Kind regards,
Petr

> - Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
