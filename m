Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24669C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 13:30:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BC9D3D1C2E
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:30:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E6E13D1BF1
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:30:09 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EC3681401122
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:30:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 48E311F7A2;
 Wed, 24 Jul 2024 13:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721827807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cg1fgXhj0fhhZtPUOvz3pwcCWmdzHJigsrInLoA9LBc=;
 b=Wsb3cUGeALoNnxBmEisyx2BnsAKbxHjUMvks2558/4XEIFlPwbZmuL9S8q2w3FTZkhLZVt
 vZU5V1nrzsxP7uj4ohvIs2IDCG1/myzNLG22NTw2uhvvzm8xNmXtvlIYvHYkYe9x5HhE33
 px0UlZqGlG7Q5IKaFl8u0ep6/D6B5WU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721827807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cg1fgXhj0fhhZtPUOvz3pwcCWmdzHJigsrInLoA9LBc=;
 b=IOsi4qhstlvw+OIOy0oOCm+H/9hkuUthESIBDMb0/1r0yNJ1cJTw9JQ+xhY7snVJ9h/UMr
 9RuGGWrk3Qf2zdCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721827806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cg1fgXhj0fhhZtPUOvz3pwcCWmdzHJigsrInLoA9LBc=;
 b=FbQADZSk26a8fJEiLOUOV9YUCPoMShRdKYG/XNoDF7NqtvHJo8vKlBS+PupzxQ/YUDw0+m
 aquNoyzy17ZFMP5934Z5ql5Y/8mexVE8MSppqnDrBuX2PFt2xz9BCSPQ+mLX5epqDciXWM
 2JU1ZnQRLMxpKUg0UX3DWOVQdEDEmr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721827806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cg1fgXhj0fhhZtPUOvz3pwcCWmdzHJigsrInLoA9LBc=;
 b=XzPpdopxuese9Xk2htE7qsxUsBohju/viqDq8YWGURCb+8AZEEWZWcYmGHouMaPWK0m2tH
 4a/AJ/cXotUlXeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 261B31324F;
 Wed, 24 Jul 2024 13:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B9YJCN4BoWZXFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jul 2024 13:30:06 +0000
Date: Wed, 24 Jul 2024 15:30:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240724133003.GB950793@pevik>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-9-c7b0e9edf9b0@suse.com>
 <20240716172725.GC549165@pevik>
 <CAEemH2fP9eGdHs1Wb5JLhS-H-XXxKB=73n8WAXqj3ZNxw9xDVA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fP9eGdHs1Wb5JLhS-H-XXxKB=73n8WAXqj3ZNxw9xDVA@mail.gmail.com>
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,huawei.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/11] Add landlock04 test
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
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Andrea,

> Hi Petr, Andrea,
...
> > ...
> > tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
> > tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
> > tst_test.c:1746: TINFO: === Testing on ext2 ===
> > tst_test.c:1111: TINFO: Formatting /dev/loop1 with ext2 opts='' extra
> > opts=''
> > mke2fs 1.47.0 (5-Feb-2023)
> > tst_test.c:1123: TINFO: Mounting /dev/loop1 to /tmp/LTP_lant6WbKJ/sandbox
> > fstyp=ext2 flags=0
> > landlock_common.h:30: TINFO: Landlock ABI v3
> > landlock04.c:151: TINFO: Testing LANDLOCK_ACCESS_FS_EXECUTE
> > landlock04.c:123: TINFO: Enable read/exec permissions for
> > /usr/lib/i386-linux-gnu/libc.so.6
> > landlock04.c:131: TBROK: landlock_add_rule(3, 1, 0xf7f13ff4, 0): EINVAL
> > (22)


> Possibly that's because the 'LANDLOCK_RULE_PATH_BENEATH'  was
> refactored from the v6.7 mainline kernel, so it can't add the rule correctly
> with older kernels.

> commit 0e0fc7e8eb4a11bd9f89a9c74bc7c0e144c56203
> Author: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Date:   Thu Oct 26 09:47:46 2023 +0800

>     landlock: Refactor landlock_add_rule() syscall

> But this is my guess (through reading the code), I didn't do more to
> verify that by installing such a kernel.

Thanks, Li,  for a hint. Quick test shows that it's working on 6.9.9, but broken
with with 6.6.x or 6.5.x, also reproduced on more distros. I'll verify this
specific commit, I suppose we should require 6.7, right?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
