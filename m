Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8174BC5AE59
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 16:12:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 005A23C0546
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 18:12:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CACE3C0546
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 18:12:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9B5302003B6
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 18:11:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1932E21ADF;
 Tue,  3 Jun 2025 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748967118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=196OsLp2emtUkIqIU6F1PN6DFyUsS9S1sq05HvUwtng=;
 b=HYm6Ht2Kuji9CPz5CgWhM/iE+vSXKbzbmJXmv/g2d2ws+Jh7voMnVl2BGv7rCGe/nhDMrw
 EnPsra8SGYmjf/OZOcyzm4FOYukVUQP6J9HERv7vJFDZQkPIiwmnTj5hnH0wQDEvngWjCv
 gUiyqMFFsQlqP07qVgwQUbCjDRcxkUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748967118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=196OsLp2emtUkIqIU6F1PN6DFyUsS9S1sq05HvUwtng=;
 b=9p0V8zMzjtaeJ+F6GOvFgZgMIp2GHyRxj9gtv5z3h+yAV/8RnNUIRvCKMXbEL53REDd+tb
 fJAc87x7WxC/LIAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748967118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=196OsLp2emtUkIqIU6F1PN6DFyUsS9S1sq05HvUwtng=;
 b=HYm6Ht2Kuji9CPz5CgWhM/iE+vSXKbzbmJXmv/g2d2ws+Jh7voMnVl2BGv7rCGe/nhDMrw
 EnPsra8SGYmjf/OZOcyzm4FOYukVUQP6J9HERv7vJFDZQkPIiwmnTj5hnH0wQDEvngWjCv
 gUiyqMFFsQlqP07qVgwQUbCjDRcxkUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748967118;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=196OsLp2emtUkIqIU6F1PN6DFyUsS9S1sq05HvUwtng=;
 b=9p0V8zMzjtaeJ+F6GOvFgZgMIp2GHyRxj9gtv5z3h+yAV/8RnNUIRvCKMXbEL53REDd+tb
 fJAc87x7WxC/LIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1A5013A92;
 Tue,  3 Jun 2025 16:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OIFJNc0eP2hMRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Jun 2025 16:11:57 +0000
Date: Tue, 3 Jun 2025 18:11:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250603161148.GA1080027@pevik>
References: <20250602170831.404641-1-pvorel@suse.cz>
 <aD7P6mPoJbe_CAgP@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aD7P6mPoJbe_CAgP@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] configure: Fix build on kernel 6.14 headers
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

> Hi!
> Let's push this now, it's simple enough and fixes the CI.

I'm sorry, it did not fix the problem due the old problem of indirect include
<linux/mount.h> by <linux/fs.h> on Alpine v3.22 (the default Alpine version in
GitHub action), which uses 6.14.2 kernel headers:

    In file included from /usr/include/linux/fs.h:19,
                     from /usr/include/linux/btrfs.h:29,
                     from statmount02.c:23:
    /usr/include/linux/mount.h:155:8: error: redefinition of 'struct statmount'
      155 | struct statmount {
          |        ^~~~~~~~~
    In file included from statmount.h:12,
                     from statmount02.c:20:
    ../../../../include/lapi/mount.h:58:8: note: originally defined here
       58 | struct statmount {
          |        ^~~~~~~~~
    /usr/include/linux/mount.h:193:8: error: redefinition of 'struct mnt_id_req'
      193 | struct mnt_id_req {
          |        ^~~~~~~~~~
    ../../../../include/lapi/mount.h:49:8: note: originally defined here
       49 | struct mnt_id_req {
          |        ^~~~~~~~~~

But we still support old Leap 42 (glibc 2.22 based), which requires for
statmount04.c old fallbacks for <sys/mount.h> but also new mount API
defined in <linux/mount.h>, otherwise it fails:

    statmount03.c:62:4: error: 'MS_PRIVATE' undeclared here (not in a function)
      { MS_PRIVATE, TST_TO_STR_(MS_PRIVATE) },
        ^
    statmount03.c:63:4: error: 'MS_SHARED' undeclared here (not in a function)
      { MS_SHARED, TST_TO_STR_(MS_SHARED) },
        ^
    statmount03.c:64:4: error: 'MS_SLAVE' undeclared here (not in a function)
      { MS_SLAVE, TST_TO_STR_(MS_SLAVE) },
        ^
    In file included from ../../../../include/tst_test.h:185:0,
                     from statmount.h:11,
                     from statmount04.c:21:
    statmount04.c: In function 'setup':
    statmount03.c:65:4: error: 'MS_UNBINDABLE' undeclared here (not in a function)
      { MS_UNBINDABLE, TST_TO_STR_(MS_UNBINDABLE) },
        ^
    statmount04.c:57:35: error: 'MS_BIND' undeclared (first use in this function)
      SAFE_MOUNT(DIR_A, DIR_A, "none", MS_BIND, NULL);
                                       ^
    ../../../../include/tst_safe_macros.h:244:25: note: in definition of macro 'SAFE_MOUNT'
          (filesystemtype), (mountflags), (data))
                             ^
    In file included from ../../../../include/tst_test.h:185:0,
                     from statmount.h:11,
                     from statmount03.c:21:
    statmount03.c: In function 'run':
    statmount04.c:57:35: note: each undeclared identifier is reported only once for each function it appears in
      SAFE_MOUNT(DIR_A, DIR_A, "none", MS_BIND, NULL);
                                       ^
    ../../../../include/tst_safe_macros.h:244:25: note: in definition of macro 'SAFE_MOUNT'
          (filesystemtype), (mountflags), (data))
                             ^
    statmount03.c:74:35: error: 'MS_BIND' undeclared (first use in this function)
      SAFE_MOUNT(DIR_B, DIR_A, "none", MS_BIND, NULL);

I suppose we should have 2 or 3 lapi files:

1) lapi/mount.h
mount definitions (guarded by #ifndef) - the old ones from <sys/mount.h> e.g.
MS_REC, MS_PRIVATE and probably the new ones from <linux/mount.h>, e.g.
MNT_ID_REQ_SIZE_VER0. None of <sys/mount.h> <linux/mount.h> should be included
in it.

2) lapi/linux_mount.h
mount structs (nowadays vast majority if not all from <linux/mount.h> only).
This header can include <linux/mount.h> and lapi/mount.h.
That allows to have configure.ac to safely use <linux/mount.h> for detection.

3) lapi/sys_mount.h
Optional helper header which would include lapi/mount.h and <sys/mount.h>
(to keep the current approach that lapi headers include system headers so that
tests does not need to do it.

WDYT?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
