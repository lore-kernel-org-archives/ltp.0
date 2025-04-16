Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99E5C369BD
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 12:15:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39E5C3CB95D
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 14:15:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BCA63CB5B0
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 14:15:27 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F15F410005FE
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 14:15:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7566C1F461;
 Wed, 16 Apr 2025 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744805724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbIY2W5BTKIjioDi99XuIsQt9dOtjFe86sMpdqvFWRY=;
 b=gt6HCmYWCyNEvgeowael/FEkQcTe+3X5yONxpA69R8zhMitUajbGaVKEKLdn/Ajunz5z3A
 5r/JInSBJlkYj6JInBuJJ4q+4Aq3gYH8+zfiXE+LqEC+36LM6Wv36HUpcfJDIt0fJJ0P8d
 kR2QgMqkjcFN4hSksZLmdlz61hXWyF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744805724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbIY2W5BTKIjioDi99XuIsQt9dOtjFe86sMpdqvFWRY=;
 b=DJon8Pleyx1HKpEG2GJl6rvvk4LeAQovr+CoVrMOZQfMLmoSzKlvZpD7RtgYkngKxr2Cxn
 4lHKqxjI1jeysEAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744805724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbIY2W5BTKIjioDi99XuIsQt9dOtjFe86sMpdqvFWRY=;
 b=gt6HCmYWCyNEvgeowael/FEkQcTe+3X5yONxpA69R8zhMitUajbGaVKEKLdn/Ajunz5z3A
 5r/JInSBJlkYj6JInBuJJ4q+4Aq3gYH8+zfiXE+LqEC+36LM6Wv36HUpcfJDIt0fJJ0P8d
 kR2QgMqkjcFN4hSksZLmdlz61hXWyF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744805724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbIY2W5BTKIjioDi99XuIsQt9dOtjFe86sMpdqvFWRY=;
 b=DJon8Pleyx1HKpEG2GJl6rvvk4LeAQovr+CoVrMOZQfMLmoSzKlvZpD7RtgYkngKxr2Cxn
 4lHKqxjI1jeysEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61C7C139A1;
 Wed, 16 Apr 2025 12:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uBTYFlyf/2cqJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Apr 2025 12:15:24 +0000
Date: Wed, 16 Apr 2025 14:15:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "John.Morin@gd-ms.com" <John.Morin@gd-ms.com>
Message-ID: <20250416121523.GB589568@pevik>
References: <BN1P110MB067481F2145E0C1A6A34240CDFB7A@BN1P110MB0674.NAMP110.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN1P110MB067481F2145E0C1A6A34240CDFB7A@BN1P110MB0674.NAMP110.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [1.00 / 50.00];
 RSPAMD_URIBL(4.50)[gd-ms.com:email]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_EQ_ADDR_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,linux-test-project.readthedocs.io:url,tst_test.sh:url,gd-ms.com:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Bug: ROD_SILENT does not preserve its argument list
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi John,

> Hello:
> Submitting bug against ROD_SILENT.
> Sincerely,

NOTE: if you put the above below first '---', we read it on the mailing list,
but it will not be part of the commit message, see example [1].

>   *   John Morin.

> ==== Bug in ROD_SILENT ====
> Need to quote "$@" in ROD_SILENT so each parameter is individually quoted. Otherwise, the original structure of its arguments is lost.

> ==== Fix ====
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 718a6b0ca..cfa327a8a 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -153,7 +153,7 @@ ROD_SILENT()
> {
>         local tst_out

> -       tst_out="$(tst_rod $@ 2>&1)"
> +       tst_out=$(tst_rod "$@" 2>&1)
>         if [ $? -ne 0 ]; then
>                 echo "$tst_out"
>                 tst_brk TBROK "$@ failed"

> ==== Test showing bug ====
> Test "test1" is an LTP tests. The runs the same command using ROD and ROD_SILENT. The command it runs simply greps for string "blah1 blah2" in file data2. When run, ROD passes while ROD_SILENT fails. This is because ROD_SILENT does not preserve quoted arguments.

> % cat data2
> --- blah1 blah2 blah3 ---

Thank you for a valid fix + example how to test, merged as [2].

IMHO this was broken from the original implementation
14cefa9 ("tst_test.sh: Implement ROD_BASE in C") [3].

FYI patch was not applicable neither to the current master nor to the latest
LTP release 20250130. It was not difficult to apply the patch manually, but for
bigger changes it's better when the patch apply.

Before merging I reworded the commit message and added your SBT:

Signed-off-by: John Morin <John.Morin@gd-ms.com>

> % cat test1
> #!/bin/bash

Also, LTP uses POSIX shell syntax [4] (FYI it's better to test against /bin/dash, or
use checkbashisms, to make sure there is no bashism).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20250402224148.435022-1-pvorel@suse.cz/
[2] https://github.com/linux-test-project/ltp/commit/0c0076fbaf6e0059b470fadff6240fc56952c218
[3] https://github.com/linux-test-project/ltp/commit/14cefa9387de5c23174c1a013dc2a04bb3717d4d
[4] https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html#shell-coding-style

> TST_TESTFUNC="do_test"
> do_test()
> {
>     ROD        grep "blah1 blah2" data2
>     ROD_SILENT grep "blah1 blah2" data2
>     tst_res TPASS "pass"
> }
> . tst_test.sh
> tst_run

> % ./test1 # Note ROD passes while ROD_SILENT fails
> > ./test1
> test1 1 TINFO: Running: test1
> test1 1 TINFO: Tested kernel: ...
> test1 1 TINFO: timeout per run is 0h 5m 0s
> --- blah1 blah2 blah3 ---
> grep: blah2: No such file or directory
> data2:--- blah1 blah2 blah3 ---
> test1 1 TBROK: grep blah1 blah2 data2 failed

> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
