Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3EBCDB47E
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 08:20:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3862A3CEF1C
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 10:19:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80D133C88A4
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 10:19:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A38D7200B0D
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 10:19:45 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id F2CB921C37;
 Wed, 18 Oct 2023 08:19:44 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 818A02C142;
 Wed, 18 Oct 2023 08:19:44 +0000 (UTC)
References: <20231016184408.879977-1-pvorel@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2023 09:04:29 +0100
Organization: Linux Private Site
In-reply-to: <20231016184408.879977-1-pvorel@suse.cz>
Message-ID: <87r0lswdep.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-2.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: F2CB921C37
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/7] Remove scsi testsuite + various
 testscripts
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi,
>
> cleanup of 2 old scsi testsuites and some of legacy testscripts.
> IMHO the testsuites are not worth of fixing.

Very good. My only suggestion is to leave a tombstone in the
documentation (or github issues) any time we delete something big and
the thing it was supposed to test still should be tested.

Something like "There was a testsuite called X, it appeared to do
Y, but we had to remove it because of Z".

It could be useful when answering questions about test feasability and
for SEO.

Reviwed-by: Richard Palethorpe <rpalethorpe@suse.com>

>
> Kind regards,
> Petr
>
> Petr Vorel (7):
>   doc: Remove ltp-run-files.txt
>   fs: Remove scsi/ltpfs testsuite
>   fs: Remove scsi/ltpscsi testsuite
>   testscripts: Remove ltpdmmapper.sh
>   testscripts: Remove ltp-scsi_debug.sh
>   testscripts: Remove sysfs.sh
>   testcases: Remove autofs{1,4}.sh scripts
>
>  doc/Test-Writing-Guidelines.asciidoc          |   12 +
>  doc/ltp-run-files.txt                         |   96 -
>  testcases/kernel/fs/scsi/ltpfs/Ltpfs.h        |   71 -
>  testcases/kernel/fs/scsi/ltpfs/LtpfsCmds.c    |  315 -
>  testcases/kernel/fs/scsi/ltpfs/Makefile       |   30 -
>  testcases/kernel/fs/scsi/ltpfs/ltpfs.part1    |    4 -
>  testcases/kernel/fs/scsi/ltpfs/ltpfs.part2    |    3 -
>  testcases/kernel/fs/scsi/ltpfs/ltpfs.part3    |    3 -
>  testcases/kernel/fs/scsi/ltpfs/ltpfs.part4    |    3 -
>  testcases/kernel/fs/scsi/ltpfs/ltpfs.part5    |    3 -
>  testcases/kernel/fs/scsi/ltpfs/ltpfs.part6    |    3 -
>  testcases/kernel/fs/scsi/ltpfs/ltpfs.part7    |    3 -
>  testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh     |  154 -
>  testcases/kernel/fs/scsi/ltpfs/main.c         |  647 --
>  testcases/kernel/fs/scsi/ltpscsi/Makefile     |   47 -
>  testcases/kernel/fs/scsi/ltpscsi/llseek.c     |  123 -
>  testcases/kernel/fs/scsi/ltpscsi/llseek.h     |   10 -
>  testcases/kernel/fs/scsi/ltpscsi/ltpfsscsi.sh |  111 -
>  testcases/kernel/fs/scsi/ltpscsi/scsimain.c   | 7651 -----------------
>  testcases/kernel/fs/scsi/ltpscsi/sg_err.c     | 1379 ---
>  testcases/kernel/fs/scsi/ltpscsi/sg_err.h     |  162 -
>  testcases/kernel/fs/scsi/ltpscsi/sg_include.h |   42 -
>  testscripts/autofs1.sh                        |  273 -
>  testscripts/autofs4.sh                        |  259 -
>  testscripts/ltp-scsi_debug.sh                 |  218 -
>  testscripts/ltpdmmapper.sh                    |  204 -
>  testscripts/sysfs.sh                          |  121 -
>  27 files changed, 12 insertions(+), 11935 deletions(-)
>  delete mode 100644 doc/ltp-run-files.txt
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/Ltpfs.h
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/LtpfsCmds.c
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/Makefile
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part1
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part2
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part3
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part4
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part5
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part6
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/ltpfs.part7
>  delete mode 100755 testcases/kernel/fs/scsi/ltpfs/ltpfsio.sh
>  delete mode 100644 testcases/kernel/fs/scsi/ltpfs/main.c
>  delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/Makefile
>  delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/llseek.c
>  delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/llseek.h
>  delete mode 100755 testcases/kernel/fs/scsi/ltpscsi/ltpfsscsi.sh
>  delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/scsimain.c
>  delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/sg_err.c
>  delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/sg_err.h
>  delete mode 100644 testcases/kernel/fs/scsi/ltpscsi/sg_include.h
>  delete mode 100755 testscripts/autofs1.sh
>  delete mode 100755 testscripts/autofs4.sh
>  delete mode 100755 testscripts/ltp-scsi_debug.sh
>  delete mode 100755 testscripts/ltpdmmapper.sh
>  delete mode 100755 testscripts/sysfs.sh


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
