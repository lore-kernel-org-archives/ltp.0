Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7019C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 10:00:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFA461052
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 10:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AFA461052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B03C3C68A0
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:00:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5B1D3C658F
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 12:00:21 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D10A22010EA
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 12:00:19 +0200 (CEST)
Received: by mail-il1-x136.google.com with SMTP id w15so2321976ilv.5
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wVDq4qGtvBUIvYpOPIZ9ChGPxQN3o9QK0Et0DoTcGwU=;
 b=XN/x9/Q1SJ537/rjg6IB8vGfIF93SaLqygc1HFCyptmeYpOocq0P8B7OBAl0AOQKpe
 pPL5+shyk8R6y7LLi8UMkFz/ib0cBgCttHV1ONLMNY8n3/83ZrcloNnq8n5OFpRBMiiH
 twLvB/mZjg2wlbSF/QYiA+PFcynMOysfMaEs+n/l2sXOJF5TLSfMgzfbuXm2G5n6OxFs
 v6TLOcPe1OEsabnK1rlU3zGBjpE8AMcb2jXPudXBz/osA7IrQEgsjFnlP6A9AiVUJDRd
 lPoen1kiBW4ua82EcAr8Q11CMdoJwu5UJxBCuMzxmmaHmpOpXRnxkYUJFDnqf7Twql9i
 OmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wVDq4qGtvBUIvYpOPIZ9ChGPxQN3o9QK0Et0DoTcGwU=;
 b=Cc9BMKAaJHfUEMhe+HfDiI7v1Uyk7pzok8fRsAPmzRLaoHdkLml0bescLGlAZTJ/oI
 8rQOidAe0zdozpJcjiKRvQO6/QaVZcnnxpcsR+r+LCQN/2kqCrZu4N12/Pz7JMdjucX7
 YqvSflTv60sipMH4L6JibSVqo/96oecp6eV/hsEuKyxvNo/nWyLI3GnvrTK7EUpgHdMx
 njVCFBS8ZGA5s02TvhrtQwkaB7TIAq3/nuu82m+D5j379NIF2VjAfQIe6ZeGhwufhKWJ
 qEqNnv6ZDsiOcASEszgMvyUC7XNi2OXz4MYl4ygHZV3fxsApAUubWwY/6OhAmshpjEPW
 DMRA==
X-Gm-Message-State: AOAM533B7IR1y/DrwsmJ9ARH7oILfD0oX82v4+kj2qJHwAhjmgB7bdYT
 KWmo7B4ko385l67r4l7mT72wTL5pL0z+RqUAuF8=
X-Google-Smtp-Source: ABdhPJyCTIYtp5qhPBPELxj29cZ1X8S9hZBdzlU2Bkz8u6Vruts0jrfrSsG+Qdg9xt33e4wtVMZ4SaxS6c+OWFicsaU=
X-Received: by 2002:a92:c083:: with SMTP id h3mr18481400ile.107.1635328818750; 
 Wed, 27 Oct 2021 03:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-11-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-11-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 13:00:07 +0300
Message-ID: <CAOQ4uxia5Qhieui+keBLumWwGd2+wv88+FykWq-zMrDrHmZUrA@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 10/10] syscalls/fanotify20: Test capture of
 multiple errors
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
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 26, 2021 at 9:44 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> When multiple FS errors occur, only the first is stored.  This testcase
> validates this behavior by issuing two different errors and making sure
> only the first is stored, while the second is simply accumulated in
> error_count.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 7bcddcaa98cb..0083a018f2c6 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -78,6 +78,18 @@ static void tcase2_trigger_lookup(void)
>                         ret, BAD_DIR, errno, EUCLEAN);
>  }
>
> +static void tcase3_trigger(void)
> +{
> +       trigger_fs_abort();
> +       tcase2_trigger_lookup();

So after remount,abort filesystem operations can still be executed?
Then I guess my comment from the previous patch about running the test in a loop
is not relevant?

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
