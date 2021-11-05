Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE559C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 08:29:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9391E61212
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 08:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9391E61212
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 908423C740D
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 09:29:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F92F3C55CE
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 09:29:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AC8F86009EC
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 09:29:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7C9C1FD36;
 Fri,  5 Nov 2021 08:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636100966;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nzkkp+NJ+u6pYVohrsUmcNySbWjjcNz6q1ZuCYiZIXw=;
 b=XQjCm+QXmU4STiqRvWhqmAUDBqQVENu0IoIqeVK2wb1BOgYSEfSC9aFPrE+oGsZZXw7JEM
 PbgpJesFSMQxCim7DFV5Vkk7nn4aCV5FbrP+zqFvvcY2qhko4FK4RGS6KmRhwLT1hrVI2J
 A/HuX6/911wsy4aK4OaFNOznUX/MzpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636100966;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nzkkp+NJ+u6pYVohrsUmcNySbWjjcNz6q1ZuCYiZIXw=;
 b=pO8Rl+zPF1yntWi6y8baaSqcQJ2o1QMXncVnFxbe6nYvXOfbyxoKrwIKhv6TArV+yhmppL
 +BWK8vbWDh+EmCAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A95C713DFC;
 Fri,  5 Nov 2021 08:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jIi9J2brhGEDSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 08:29:26 +0000
Date: Fri, 5 Nov 2021 09:29:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YYTrZa/SEZfqANTn@pevik>
References: <7c11918db7c34d3aa0af98cb42b7970e@huawei.com>
 <YYSenZxvAG0Xgm71@google.com>
 <CAOQ4uxgN2Wx6aAcWYqSO_LNir5hTpAYhPEXHQPqhkQcpeHCPkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgN2Wx6aAcWYqSO_LNir5hTpAYhPEXHQPqhkQcpeHCPkQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify: Kill the child process before
 exit
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
Cc: Matthew Bobrowski <repnop@google.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> This would be the obvious solution.
> But simpler to skip zero values then stop the iterator.
+1
> This makes the cleanup helper reenetrant:

> static int stop_children(void)
> {
>         int child_ret;
>         int i, ret = 0;

>         for (i = 0; i < MAX_CHILDREN; i++) {
>                 if (!child_pid[i]) continue;
>                 SAFE_KILL(child_pid[i], SIGKILL);
>         }
>         for (i = 0; i < MAX_CHILDREN; i++) {
>                 if (!child_pid[i]) continue;
>                 SAFE_WAITPID(child_pid[i], &child_ret, 0);
>                 if (!WIFSIGNALED(child_ret))
>                         ret = 1;
>                 child_pid[i] = 0;
>        }

>         return ret;
> }

Amir, thanks! Zhao, could you please test this in your setup?
(+ please be verbose about your setup, it helps to decide in the future that fix
is still needed).

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
