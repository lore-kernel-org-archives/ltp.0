Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490B7ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:54:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73AE73CAC26
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 15:54:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99E913C2A0E
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 15:54:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A1819140004E
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 15:54:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D3EF0338D0;
 Mon, 31 Oct 2022 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667228069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bj4G/GV8dsUEImbCCumBvSuBbnMIuNp7Bpfen8/XJc=;
 b=Rvp3GDVTTlbHeylZbK+Q7E1QNqrDmQH6xv6OcttoyJv1/AK1nBtYySJWP82C8usOWsbe5m
 MxhPxFRnLPqwjfCcvj3HRsxw9baipNX5qZOI4ynN+sXBVoQ91AkZbbbgLCaoGWyoyuomUh
 u22a3VdoO/obY4pCH4R9KE41Tb3qrgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667228069;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9bj4G/GV8dsUEImbCCumBvSuBbnMIuNp7Bpfen8/XJc=;
 b=/vs2lVk0kub3myuh4W7HUKESzZCydbP21+kdf7OqKdBnAnZKPRfkbFLN3OgeniYMyd2h4t
 tLko22eoJGl+66DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B971A13451;
 Mon, 31 Oct 2022 14:54:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V2pdLKXhX2PTCgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 31 Oct 2022 14:54:29 +0000
Date: Mon, 31 Oct 2022 15:56:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y1/iBcq+iYFsxDJ+@yuki>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-2-tsahu@linux.ibm.com>
 <CAEemH2e+FUZnQws-9pW5E25Uq01T0zaHzsk8QUa2KJsCKQpDBA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e+FUZnQws-9pW5E25Uq01T0zaHzsk8QUa2KJsCKQpDBA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Why not consider encapsulating these two new fields in 'struct
> tst_hugepage' ?
> 
> Then the tst_test in the case can simply initialize to:
> 
> ....
> static struct tst_test test = {
>     .needs_root = 1,
>     .taint_check = TST_TAINT_D | TST_TAINT_W,
>     .setup = setup,
>     .test_all = run_test,
>     .hugepages = {1, TST_NEEDS, 1, 1},
> };

I do not like that we have magic constants in the .hugepages that are
not self describing. I would treat the hugetltbfs just as we treat
devfs, that would be:

#define MNTPOINT "hugetlbfs/"
#define HUGEFILE MNTPOINT "hugefile"

static int huge_fd;

static void setup(void)
{
	huge_fd = tst_creat_unlinked(HUGEFILE);
	...
}

static void cleanup(void)
{
	if (huge_fd > 0)
		SAFE_CLOSE(huge_fd);
}

static struct tst_test test = {
	...
	.mntpoint = MNTPOINT,
	.needs_hugetlbfs = 1,
	.setup = setup,
	.cleanup = cleanup,
	...
}


What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
