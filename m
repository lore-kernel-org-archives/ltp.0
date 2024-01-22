Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36151C47DD9
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 20:23:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C15A3CFBB6
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 21:23:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A75333C080E
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 21:23:31 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 98DE52009C8
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 21:23:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4ACF422010;
 Mon, 22 Jan 2024 20:23:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F205D13995;
 Mon, 22 Jan 2024 20:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eiXUNsDOrmUvQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 20:23:28 +0000
Date: Mon, 22 Jan 2024 21:23:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240122202325.GA119341@pevik>
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122091356.GF76754@pevik>
 <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
 <20240122110344.GB95077@pevik>
 <CAEemH2cNn1kyWrnqXHHeOteGT_FQ=PBVc55NFhkZbmkbMOoD=A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cNn1kyWrnqXHHeOteGT_FQ=PBVc55NFhkZbmkbMOoD=A@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4ACF422010
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

Hi Li,

> Great, and FYI.

> I just pushed a new commit to resolve the FIBMAP (unsupported on BTRFS)
> problem on my ltp:libswap branch.

> https://github.com/wangli5665/ltp/commit/699711bfe8c8dbc3597c46587345fa1197c054c9

> Hope you can try on your side and give some feedback :).

Unfortunately regardless of kernel version it fails:

# LTP_SINGLE_FS_TYPE=btrfs ./swapon01
...
tst_test.c:1669: TINFO: === Testing on btrfs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swa497AKp/mntpoint fstyp=btrfs flags=0
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:93: TINFO: File 'mntpoint/swapfile01' is not contiguous
libswap.c:34: TINFO: FS_NOCOW_FL attribute set on mntpoint/swapfile01
libswap.c:169: TFAIL: swapon() on btrfs failed: EINVAL (22)

Also, tst_brk() in is_swap_supported() causes test to fail quickly.
Given similar Martin's fix to shell API I merged today, which use tst_res +
return instead of tst_brk [1] I suggest to use tst_res + change return function
from void to int and handle another return in the test. That will allow to test
other filesystems (which is useful to see, if particular filesystem code is
broken or or VFS or some common code reused by all filesystems). This is the
reason why I don't think "quit as early as possible" is a good approach when
testing on all filesystems.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/5c73ad84f3e6db9a965df3ed4a846352136ed990

> > > https://github.com/wangli5665/ltp/tree/libswap

> > > And, I prefer to wait for Cryil's feedback before posting them in ML:)

> > +1

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
