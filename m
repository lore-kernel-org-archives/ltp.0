Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FFAC433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 07:34:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95A853CA05D
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 08:34:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE9783C9FF4
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 08:34:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A57BB14000AA
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 08:34:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9508C210DC;
 Tue, 15 Feb 2022 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644910470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lotg+WbCGiMeXqTLrwUx8QsUFCipjaHsVZIPxoPFHWg=;
 b=r0W3W6OP7uH/K8nTZLn1U8fhun/vf3KI7UIAX32YeytFrwDnWPOU7PloUduFRt2ah8aRwB
 mp/iYjHrbKJN5o8leTeebEMmNLhX65UyHa71m89NbEXhLDkkX+wUS/AODq7G+40J76CIje
 YrWHVu6kaDZDuTpG8AzWYGUoUmcVEFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644910470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lotg+WbCGiMeXqTLrwUx8QsUFCipjaHsVZIPxoPFHWg=;
 b=EfSReA6myltzLzjkrwgd9xUTVM1MSmCTqzdXBOITZvLuqbgeO9gEAR3DfX/VhYOriRkcOy
 C25AY/NN172pETBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 610F513BD8;
 Tue, 15 Feb 2022 07:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S0hXFYZXC2KiRQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 15 Feb 2022 07:34:30 +0000
Date: Tue, 15 Feb 2022 08:34:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YgtXhDRi0/U9nc4Z@pevik>
References: <20220214165129.32686-1-mdoucha@suse.cz>
 <CAEemH2c=+3_HBez0Pn6Yyx+v4PXJpwD3HZtPt87BR6AohtKvUw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c=+3_HBez0Pn6Yyx+v4PXJpwD3HZtPt87BR6AohtKvUw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup.sh: Fix race condition
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> It doesn't work for all platforms and we can not guarantee how long it will
> cost before PID 1 reaps zombie process.

> Also, I just get to know that  Docker does not run processes under a
> special init process that properly reaps child processes, so that it is
> possible for the container to end up with zombie processes that cause
> all sorts of trouble.

> I even try adding `kill -SIGCHLD 1` but does not work as expected.

> See CI jobs:
>   https://github.com/wangli5665/ltp/runs/5194270998?check_suite_focus=true
> <https://mail.google.com/mail/u/1/%E2%80%8Bhttps://github.com/wangli5665/ltp/runs/5194270998?check_suite_focus=true>

> Therefore, I suggest giving a chance to my refined patch V2 :).

> --- a/lib/newlib_tests/test_children_cleanup.sh
> +++ b/lib/newlib_tests/test_children_cleanup.sh
> @@ -10,10 +10,16 @@ rm "$TMPFILE"
>  if [ "x$CHILD_PID" = "x" ]; then
>         echo "TFAIL: Child process was not created"
>         exit 1
> +elif grep -q "Z (zombie)" /proc/$CHILD_PID/status; then
> +       echo "TPASS: Child process is in zombie state"
> +       exit 0
>  elif ! kill -s 0 $CHILD_PID &>/dev/null; then
>         echo "TPASS: Child process was cleaned up"
>         exit 0
>  else
>         echo "TFAIL: Child process was left behind"
> +       echo "cat /proc/$CHILD_PID/status"
> +       echo "---------------------------"
> +       cat /proc/$CHILD_PID/status
>         exit 1
>  fi

Li's approach LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
