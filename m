Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3763C32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 10:40:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6E403CA251
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:40:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDBCA3CA1A4
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:40:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 53394100074D
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:40:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 469225CAF5;
 Fri, 19 Aug 2022 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660905636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7LlNFG/TV/B6gtMJhyQnGFD7BWMRrlhj4ATFfRS5gnQ=;
 b=eWfDzckh6+nbKuAgZhhYXASkxu1sJjzt2qI/B36aYMDt+JJZlNDcytAY60RLAOWx6Ea6CJ
 9xokAVwKGfemeF9X8Bz0vdMdP3KdnnfLbjUl4d+JRcs7Tprfxl5CvNY+lQUMGoSvmPIPYy
 aT329SNxWpvxFTGGipHoOBejMZS8MZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660905636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7LlNFG/TV/B6gtMJhyQnGFD7BWMRrlhj4ATFfRS5gnQ=;
 b=MFXfzncfs795nmfWzV3Phfa54GB78KHaVW8HMJILKNvC+oeDSCO/+i1n697icokwr9C+Th
 26VpHVl/8aZOpYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1986C13AE9;
 Fri, 19 Aug 2022 10:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2vGXBKRo/2JAHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Aug 2022 10:40:36 +0000
Date: Fri, 19 Aug 2022 12:40:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yv9ooj5RVoiQ1FhC@pevik>
References: <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
 <CAG4es9XhZ7ksvLxwRNO73FC4DQc7KteUQAUPwipbks6kGsvFmw@mail.gmail.com>
 <YvUhZ/9Yf7eZ4a32@yuki> <YvuRAR1DSi67PDzh@pevik>
 <CAG4es9XdXgmPOQK3i+FL3VD-Y8C39sAShwdM6bi7U-CJjk7BQg@mail.gmail.com>
 <YvyxCXTGYpLd8kbQ@pevik>
 <CAG4es9XkRDYnwDr9huepzGhEiHxWdu40DOK9ouA2yWGqv842ow@mail.gmail.com>
 <CAG4es9WmHd52fmjdt7RBkSXEtnGuC2jkBO6UdCTbaHOq8CDgVw@mail.gmail.com>
 <Yv9F8MnPGyLLE0Zm@pevik> <Yv9Msztwn77epwCP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yv9Msztwn77epwCP@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Thanks! The bug was closed as 'adding "cx" worked'. Reading topperc's comment it
> > looks like there no other way to fix the issue on clang than workaround with
> > volatile. Does it mean that it's a syscall problem and clang can do nothing
> > about it?

> It's problem with the inline assembly in the body of the while loop, the
> call to the syscall changes the register value that is used for the D
> variable in the case of clang, so the loop exits prematurely. We have to
> add cx register to the clobber list for that asm statement so that
> compiler knows that it's changed by the assembly.

> Interfacing assembly with C is a bit tricky since you have to explain
> to compiler which registers are changed from the assembly otherwise the
> results are undefined.

> The patch should look like:

> diff --git a/testcases/kernel/syscalls/signal/signal06.c b/testcases/kernel/syscalls/signal/signal06.c
> index 64f886ee3..78efd0fb9 100644
> --- a/testcases/kernel/syscalls/signal/signal06.c
> +++ b/testcases/kernel/syscalls/signal/signal06.c
> @@ -73,7 +73,7 @@ void test(void)
>                 /* sys_tkill(pid, SIGHUP); asm to avoid save/reload
>                  * fp regs around c call */
>                 asm ("" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP));
> -               asm ("syscall" : : : "ax");
> +               asm ("syscall" : : : "ax", "cx");

OK, I completely overlooked asm() in the test. Thanks!

Petr

>                 loop++;
>         }

> Although it may not be a complete as the llwm issue suggests we should
> have a look at calling conventions for the syscall and check if we need
> to add any other registers to the clobber list.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
