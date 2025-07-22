Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F880C83F25
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 08:03:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E03B3CCC78
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 10:03:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7514F3CB8B7
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 10:03:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A03C11000A50
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 10:03:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5472A1F785;
 Tue, 22 Jul 2025 08:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753171405;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/RW/BQs9JtOTtL8OdaMrQlI9hDp0KoAb1coznKv9LEA=;
 b=VGhEZzJS8AZcJ7eK+rOb3C+bLI1c1LA/pFO/TPbOPU8LyEQK2xptLRV0DZMw8zmEGKxlCQ
 wBpe2E35hq1mew4wVXuqoelevib1KBy8/Tqw5kIBbqu9p64d478WZG8Uyl8fQJ1xrmiwZb
 PeXCggzMZR7NZqRJU5EEQfjcnd1lEXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753171405;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/RW/BQs9JtOTtL8OdaMrQlI9hDp0KoAb1coznKv9LEA=;
 b=IyijJCutUnfXX+M+4BQyiDoF3Sl57JxkMYllsO5xcgo2zcgXy4qu7/Oe7OPZk2JtxLYn5E
 7BJiLSu9gXt8HZDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FMTV5CCE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/UWs8N8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753171404;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/RW/BQs9JtOTtL8OdaMrQlI9hDp0KoAb1coznKv9LEA=;
 b=FMTV5CCE/WhUub5pm3ms8wciAM5yv/VuwpnOVQSpSIQPX46D8t/YxcoQr5p6D1frIIoIpX
 C7HKnFpS/Rp4a+6myJVXHmdGggJfdZdNv0OsY1M+/5nwnDWt53FA7Fxqutcydh7anAnIrf
 ujM2KnxoQ3Ff9Dkp2ty+ytir9MVRcAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753171404;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/RW/BQs9JtOTtL8OdaMrQlI9hDp0KoAb1coznKv9LEA=;
 b=/UWs8N8EYZDS9Nm5pKEJauRe2Sppr7rnVtOCAB9OqCy2+NIGBro8fTUnz9YQgyHQlMmy0H
 COhGjM7QfZn6wPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 212E8132EA;
 Tue, 22 Jul 2025 08:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q0H3BsxFf2iSBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 08:03:24 +0000
Date: Tue, 22 Jul 2025 10:03:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>,
 Jan Stancek <jstancek@redhat.com>
Message-ID: <20250722080322.GA19816@pevik>
References: <20250718162928.71364-1-mdoucha@suse.cz>
 <64694997-ff37-4a60-80cd-b780616bdf98@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <64694997-ff37-4a60-80cd-b780616bdf98@suse.com>
X-Rspamd-Queue-Id: 5472A1F785
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SUBJECT_HAS_QUESTION(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] .all_filesystems imply .needs_root? [was Re: [PATCH]
 open14: Rewrite to new API]
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > +static struct tst_test test = {
> > +	.setup = setup,
> > +	.test_all = run,
> > +	.cleanup = cleanup,
> > +	.mntpoint = MNTPOINT,
> > +	.all_filesystems = 1
> We need .needs_root if we acquire a device.

We LTP library allows to run test under non-root user with rw permissions to
/dev/loop-control:

tst_device.c:110: TINFO: Not allowed to open /dev/loop-control. Are you root?: EACCES (13)
tst_device.c:149: TINFO: No free devices found
tst_device.c:362: TBROK: Failed to acquire device

In openSUSE that would be to run tests with user which is in disk group.
Although this should theoretically work, root is often required for something
else:

$ open14
...
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1938: TINFO: === Testing on ext2 ===
...
open14.c:141: TINFO: Closing temporary files
open14.c:146: TPASS: Multiple files test passed
open14.c:168: TINFO: Testing linked temp files access mode
open14.c:186: TFAIL: Unexpected access mode: 1755 != 7755
open14.c:186: TFAIL: Unexpected access mode: 1755 != 7755
open14.c:186: TFAIL: Unexpected access mode: 1755 != 7755
open14.c:186: TFAIL: Unexpected access mode: 1755 != 7755
open14.c:186: TFAIL: Unexpected access mode: 1755 != 7755

Obviously with root everything works:
...
open14.c:193: TPASS: File access modes are correct

Also I'm not sure if anybody would bother with configuring group for a test
user. I suppose most of testers run LTP under root.

Also, not all tests define needs_device for these tests:

$ git grep -l -e needs_device -e all_filesystems testcases/ | wc -l
121

$ git grep -l needs_root $(git grep -l -e needs_device -e all_filesystems testcases/) | wc -l
108

Therefore I wonder if we should just imply .needs_root on .all_filesystems (and
other flags). Also doc could be tweaked to show .needs_root in the test catalog
for these tests [1].

And there are other flags which effectively enforce root, e.g. .mount_device
(mount() requires CAP_SYS_ADMIN). Here IMHO implying root makes even more sense.

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html

> > +};
...

> - Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
