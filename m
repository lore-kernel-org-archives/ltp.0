Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC122C7618A
	for <ltp@archiver.kernel.org>; Sun, 19 Mar 2023 17:05:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6791D3CCD33
	for <ltp@archiver.kernel.org>; Sun, 19 Mar 2023 18:05:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47B643C4C12
 for <ltp@lists.linux.it>; Sun, 19 Mar 2023 18:05:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B46F71A00244
 for <ltp@lists.linux.it>; Sun, 19 Mar 2023 18:05:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 52CC61FED4;
 Sun, 19 Mar 2023 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679245509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZCVpy3S7XwMxJPTPyGrRwGiX9llLmUkp+SY4pVwCBc=;
 b=KSE6M2lHFgVO1LLspcNs9GnThI6t2TnmTCoKJ+eOpYNEbDUfX1TSttX4RSSr1/SEo1lNIm
 IQ8ZAP4f9SKhf3Yd3vVDAb9Lk3iqBILpc+fhgHS/+6IcMfHaR+ZuOysIERhmxoyzBVKKa8
 bZMtgZ8aDgmzMgC8AyYu+RUfFdzXcrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679245509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZCVpy3S7XwMxJPTPyGrRwGiX9llLmUkp+SY4pVwCBc=;
 b=8yBqlYGgEpOnpUQZPpI9Gr1HJwO6yfnUFhH3gP2oiLynabwLR/aer3Vk2f9D1O5H7bwos/
 8WMLdM0nQfoJFRCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E950133E6;
 Sun, 19 Mar 2023 17:05:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ov+hGsRAF2RQeQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 19 Mar 2023 17:05:08 +0000
Date: Sun, 19 Mar 2023 18:05:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230319170503.GA157011@pevik>
References: <20230120010533.11202-1-wegao@suse.com>
 <20230302071555.18420-1-wegao@suse.com>
 <20230302071555.18420-2-wegao@suse.com>
 <20230315123119.GA164307@pevik>
 <CAEemH2fU8CC3-Xj=26VaeejphxHfFBOAE6pPzXFp3n32WC1v+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fU8CC3-Xj=26VaeejphxHfFBOAE6pPzXFp3n32WC1v+Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] Move semaphore/ tests to semop/
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

> Petr Vorel <pvorel@suse.cz> wrote:

> Hi Wei,

> > > There is no point in having two different directories with semop()
> > > testcaes so it would make sense to move these two tests into the
> > > syscalls/ipc/semop/ directory as semop04 and semop05.
> > > So we move ipc/semaphore/ tests to syscalls/ipc/semop/.
> > > Also update runtest files accordingly.



> > As I already stated, I'm not really sure this is good to do, but maybe I'm
> > missing something.  I wonder what others think about it.


> This patch makes sense. Petr, I know what you're concerned about,
> but it is correct to move them into syscalls/ipc/semop/.

> They essentially all belong to System V IPC way to use
> semaphore which includes <sys/sem.h>:
>   semid_ds
>   semget()
>   semctl()
>   semop()

> To distinguish from another POSIX IPC way which
> include <semaphore.h>:
>   sem_open()
>   sem_close()
>   sem_unlink()
>   sem_post(), sem_wait()
>   sem_getvalue()
>   sem_init()
>   sem_destrory()

> The sem02.c needs '-lpthread' only because it invoked pthread_attr_init/exit
> functions in the test, but not any POSIX IPC functions.

> So you have my reviewed-by in patch v4:
> Reviewed-by: Li Wang <liwang@redhat.com>

Li, thanks for having look, first patch in merged v4.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
