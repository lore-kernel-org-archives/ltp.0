Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B3DC433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 13:02:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E45F60F9B
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 13:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E45F60F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 844133C73D8
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 14:02:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E0743C2FC3
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 14:02:40 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CFF09140122F
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 14:02:39 +0100 (CET)
Received: by mail-il1-x131.google.com with SMTP id h2so9319035ili.11
 for <ltp@lists.linux.it>; Fri, 05 Nov 2021 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=14covRk9VIqYx+iigWd5Oy3gFSROrP7x153m363/8ps=;
 b=Sd92rfbwRkHR8aJHxXi8loHqRp4nbuHCTpo/jn9VFJjgQC8w8GWZYDg2LE0o5qc+Md
 k2wpeFSyYQXso7jRgO1iL/PjGpsWI6bSICznUfCXyImXXxyFotMzs0f6MuAAiXqBjiDU
 hAo3vUet1HJqPIMIpahXOTNFZhSYA/Mcup80X5aA9eCVrfVvKIK6+hYPYPM+WtrKRcMT
 QcEb4qcI9bfnVr5bAdXrj6iRLc/PBd4KGH1zAtDIAj5emkKjubJwHdiWsOCyA8vBx+AO
 CWQ8/PG+2xxAIPrX14qY88mltIZijg/NMwB+vsfsEYuPw2PkHQu0YdrMpDTPRHFwGOHM
 RUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=14covRk9VIqYx+iigWd5Oy3gFSROrP7x153m363/8ps=;
 b=l3PvSLIngJ82E2sIlX6L9zGOM3/WeYeZ/wxBQ/TgCBGOg04fLMvz2zLs1DPBb6Hfvj
 ydjHTcLh0szEWO+DpOklA5qe3HP29grDr8NQHZhNSRcRoSmAkUFKrZVX01o59Utb2MII
 1BqG5CbRI4/mTDHFhB3JnrPyhZEEMz4l7tDJkZVdUqTl1125sBsgmj04WqELIQ315KKM
 RThrwvgg3DHAq6oJY81aHJMuy2R3kRYqoe+ezzUAhjJP7yC14DXNHkg1SRWBQYYqSXK8
 aWrr0pHixDDPdjqX6w+4adKl0M+gz8ju/B3lSjH9CEk3BprGctiCeGMEJfEn7t9cNmxC
 sdqw==
X-Gm-Message-State: AOAM5330DciMnYb4BUeE7mD+Hk1owQdidlZO+6LUs4Uo/lvKgLJkXYJj
 KksT0VoiMnzgNP/1laQ2SzcNrF+pDJEOlU0zZtU=
X-Google-Smtp-Source: ABdhPJzpb0s/WltSrwq1p22I96wtFs2wQzG8uEBugl+1nqp7MIcWYhNBh48j/VFu542v/NJdUcFkMAE2qobDaVm4Rpc=
X-Received: by 2002:a92:d643:: with SMTP id x3mr39918549ilp.107.1636117357737; 
 Fri, 05 Nov 2021 06:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com>
 <YYUDDU0A9hLFbM4c@pevik>
In-Reply-To: <YYUDDU0A9hLFbM4c@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Nov 2021 15:02:26 +0200
Message-ID: <CAOQ4uxjpfmhC722jXban2jfSKT+xYQOyaG8OnwuphqM_G_HZ0A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 5, 2021 at 12:10 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Gabriel, all,
>
> > Hi,
>
> > Now that FAN_FS_ERROR is close to being merged, I'm sending a new
> > version of the LTP tests.  This is the v3 of this patchset, and it
> > applies the feedback of the previous version, in particular, it solves
> > the issue Amir pointed out, that ltp won't gracefully handle a test with
> > tcnt==0.  To solve that, I merged the patch that set up the environment
> > with a simple test, that only triggers a fs abort and watches the
> > event.
>
> > I'm also renaming the testcase from fanotify20 to fanotify21, to leave
> > room for the pidfs test that is also in the baking by Matthew Bobrowski.
>
> > One important detail is that, for the tests to succeed, there is a
> > dependency on an ext4 fix I sent a few days ago:
>
> > https://lore.kernel.org/linux-ext4/20211026173302.84000-1-krisman@collabora.com/T/#u
> It has been merged into Theodore Ts'o ext4 tree into dev branch as c1e2e0350ce3
> ("ext4: Fix error code saved on super block during file system abort")
>
> We should probably add it as .tags (see fanotify06.c).

No point in doing that.
There will be no kernel release which meets the test requirements
and has this bug.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
