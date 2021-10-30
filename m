Return-Path: <SRS0=DQX/=PS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68027C433EF
	for <ltp@archiver.kernel.org>; Sat, 30 Oct 2021 06:21:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A039C610E8
	for <ltp@archiver.kernel.org>; Sat, 30 Oct 2021 06:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A039C610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92F33C7008
	for <ltp@archiver.kernel.org>; Sat, 30 Oct 2021 08:21:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 890033C6F15
 for <ltp@lists.linux.it>; Sat, 30 Oct 2021 08:21:26 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7E99D200351
 for <ltp@lists.linux.it>; Sat, 30 Oct 2021 08:21:26 +0200 (CEST)
Received: by mail-io1-xd32.google.com with SMTP id m184so15290380iof.1
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hXp4ofDL0qHB+i/D2WT+Gdj9q3TTKFGh/0rQ7NHlnSI=;
 b=Ys+KvZ9OiMAAEFtnSoThgxqQAm+zWG42+03R7WVGztQyYHadMsUfCbIOfcesuEbj51
 //uOQS4zJC4xtVaLoNEb6Y8r+WNhOCbgS9d++aWi8vFf+R5jBAyUtwCPvvl21G8/Pp2h
 UGds6ly6QSlCWPmNvWyYv2imCo9RI4uT+bhBWVDrTBjAjoaFBeEOJTjWBhiqd1H5wEHy
 zQDPKaU+pGYT9MucDAOCCSJEGEYx5/ZIyyd7M9q31Ii7c5B6pG96WqMrHdlZHbD3+RHj
 yUXkozFnQICo2VXDP+1WCI04JmkyG5UcxRBlvpfe+5M8cj1R0Cgr93Lv8EV7j7axqtek
 MnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hXp4ofDL0qHB+i/D2WT+Gdj9q3TTKFGh/0rQ7NHlnSI=;
 b=EyN7kx1EuNKbL6U4330tsI5NHBnyHbhLBKbxv6fMoc6BgW0xt4WkFmYRT6PyeWNeL8
 Qn/CK99pbb4gZTXXBf1g/ENLqZ6GjlOD+jG8ugRhZEP+j982DF7MJJuEJjOCmUYMEdyZ
 Qgj2Jk6YSp+tXPe57/+RwCrbV7pPDSfaYg+2++8axnkD+BJVJNdeJiaPPWwMcxMg8atK
 ZdzRiqVQcL6wwaJf7eRBDbMDQrkuJsaVnHYurIZvZPIT40Ls9qn7Y+JGqMWnHdCnnGst
 OilRId5uXI4/EkeOE/evQSsuah+Atg/+fzcPHBebuc3tt2FcrMNkMT6ezDtgRTWRoHX0
 JAFg==
X-Gm-Message-State: AOAM532JGppt+tkxsB+YTn220aQx62tG6L0+Fv0KZcfKDb2F+Vqr+ZSL
 UHsSZhSG1yQD6nhNQT6Ofj3aXHteycSkgfDcfiA=
X-Google-Smtp-Source: ABdhPJw6kIhy7/JiL9DoCZQ4LFTrVLfT1piapt7j3fXMPYU7BW/wvUPgducKhnFY8XNj29fz9ck1QaU3Gi5Mzo+X8qo=
X-Received: by 2002:a5d:8792:: with SMTP id f18mr11075862ion.52.1635574885401; 
 Fri, 29 Oct 2021 23:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com>
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 30 Oct 2021 09:21:15 +0300
Message-ID: <CAOQ4uxhNCWTcp=e7g1giSQixo_bfxre=+6RucY_5RCqNM7ffVg@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Oct 30, 2021 at 12:17 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> Now that FAN_FS_ERROR is close to being merged, I'm sending a new
> version of the LTP tests.  This is the v3 of this patchset, and it
> applies the feedback of the previous version, in particular, it solves
> the issue Amir pointed out, that ltp won't gracefully handle a test with
> tcnt==0.  To solve that, I merged the patch that set up the environment
> with a simple test, that only triggers a fs abort and watches the
> event.
>
> I'm also renaming the testcase from fanotify20 to fanotify21, to leave
> room for the pidfs test that is also in the baking by Matthew Bobrowski.

Only Matthew posted two tests... anyway I don't think merge is going to be
a big problem. I am hoping that PIDFD tests could be merged soonish and
I recommended Matthew to base his tests over your first two macro prep
patches.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
