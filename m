Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF670C25B10
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 12:59:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D63573CE52D
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 14:59:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 949873CE48C
 for <ltp@lists.linux.it>; Fri, 10 May 2024 14:59:22 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D4634602A1E
 for <ltp@lists.linux.it>; Fri, 10 May 2024 14:59:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 30A7C66F42;
 Fri, 10 May 2024 12:59:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 168BC139AA;
 Fri, 10 May 2024 12:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uSh0BCgaPmZlegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 May 2024 12:59:20 +0000
Date: Fri, 10 May 2024 14:59:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240510125918.GA430715@pevik>
References: <20240131180659.23587-1-pvorel@suse.cz>
 <20240131180659.23587-2-pvorel@suse.cz> <ZjzwBy0g2pRvqW0y@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZjzwBy0g2pRvqW0y@yuki>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 30A7C66F42
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] hugemmap: Move MNTPOINT definition to header
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

Hi Cyril,

first, thanks a lot for looking into this.

> Hi!
> > Also, change it from "hugetlbfs/" to the usual "mntpoint".

> Isn't that actually a regression? The name was more descriptive when it
> was hugetlbfs/...

I agree with a readability point.

From following library code in lib/tst_test.c I expect we mount only once:

	if (!!tst_test->needs_rofs + !!tst_test->needs_devfs +
	    !!tst_test->needs_device + !!tst_test->needs_hugetlbfs > 1) {
		tst_brk(TBROK,
			"Two or more of needs_{rofs, devfs, device, hugetlbfs} are set");
	}

Therefore it's really only readability point due .needs_hugetlbfs (but again,
I agree with it, I guess you want to see the path in the test output and dmesg
logs or when directory is not umounted due bug, right?)

Is there any other .mntpoint value which should be preserved as a different
(I suppose no, but maybe I overlooked)?

BTW without this specific hugetlbfs case I would even suggest to use always
MNTPOINT in whole source tree and remove tst_test->mntpoint (but that might be
also step back - readability might suffer).

> I guess that it makes sense to move the MNTPOINT to the hugetlb.h but I
> would keep the actual directory name the same...

E.g. in hugetlb.h:

#define MNTPOINT "hugetlbfs/"

nit: IMHO it can be just "hugetlbfs"? tst_creat_unlinked calls:

	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
			path, tid);

=> there is / after %s which is path parameter.

... and in tst_test.h:

#ifndef MNTPOINT
# define MNTPOINT "mntpoint"
#endif

This should be safe, because hugetlb.h includes tst_test.h.

> I would have defined MNTPOINT in the tst_test.h rather than in tst_fs.h.
(from your other email)

But what about OVL_BASE_MNTPOINT in tst_fs.h? I guess all of these should be on
the same place, right? (in 1st commit)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
