Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E4BC433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 05:48:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2AFF6102A
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 05:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2AFF6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 226E93C89A0
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 06:48:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F8333C2E5C
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 06:48:41 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DE3FE6013F3
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 06:48:40 +0100 (CET)
Received: by mail-il1-x132.google.com with SMTP id e8so9160199ilu.9
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 21:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h2UaBAPk9+dX1nyaB3MzZPqLop0ttm08MjzVxvsPoZA=;
 b=UDyTUk11/a32o2RNnkegM+/PGeKx0rK+ZiY4hQ1KmX5J/NBWSK/ixBAe+8Op5lG3/m
 LWn0GK6/75QAo6QYXIZlF7HNwgE2gbXFwEJFfaL7f1zcntzCn44nYa6f/eKIWEfcmzSI
 F7XdOSzMZSl+cPTAkfW+38ia8PXRI6j8VoS4l4tLzMLHxWbXtOoytRIkFNyj2qFVMGUX
 9mg+haQO09LNcvDHvHZaNWYT8cVGJG6w3mfCbepCEPxYzVClHyLUV5Sq1e0+80akYkh5
 msyRyFk7vJ43a775F+9RCbg0WgrMJoafoBWwYPSl7cS0aYmHbU7eEp+ZEBe1dNH+8ggO
 xJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h2UaBAPk9+dX1nyaB3MzZPqLop0ttm08MjzVxvsPoZA=;
 b=kOnTxuZtmVm+dLxvsos7G2WPnLMCaYTiG5sTy8q0kXZFlpDYfx6hHQyZ3H6PwSbUxI
 NHCCHYIw3/dygQa9q9cxuXjWYJ68SaGaZIfKWYQKF0NelgRgXIo2oqpg5t30nMd/kB1M
 g1Pr+kP3OV4v5YRpRDFHSZrrL24prY5YSTB5OqrmsPT1iaVkX6VDGGdvNDomeU2DFs6V
 ca445bcUzeDSNfIqRJCB0ajLZtGmyk6sf3hbrpMR8FA0iTHVgPBVg4Jpn3+C1QjBYZSP
 sJbbyUdy+xhxVQE0kSg9W/WcO9+6ia23M8eJTnHWWQa5iD0X/84YLZSSh1ovGXMsO+7P
 CJJw==
X-Gm-Message-State: AOAM532rq8r1+rZAsXS8YbJqt10VztUV++ML14sbI8Y4fgTgSstkIHiX
 8ICpiTpIDiIZYdvIAEUepuG2P43dCg3IMfUOKNQ0f99U59M=
X-Google-Smtp-Source: ABdhPJw5DB8Y5GvFIbCY2VAUIdCUWYCzlqHFJthiqOrHqHNRz3pUwlq8nhvrhLT0/dgiYnXDQrcBtATNXhegN6UflvI=
X-Received: by 2002:a05:6e02:1ba6:: with SMTP id
 n6mr3196265ili.254.1637300919715; 
 Thu, 18 Nov 2021 21:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Nov 2021 07:48:29 +0200
Message-ID: <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: kernel@collabora.com, Matthew Bobrowski <repnop@google.com>,
 Khazhismel Kumykov <khazhy@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 19, 2021 at 1:57 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> FAN_FS_ERROR was merged into Linus tree, and the PIDFD testcases reached
> LTP.  Therefore, I'm sending a new version of the FAN_FS_ERROR LTP
> tests.  This is the v4 of this patchset, and it applies the feedback of
> the previous version.
>
> Thanks,
>
> ---
>
> Original cover letter:
>
> FAN_FS_ERROR is a new (still unmerged) fanotify event to monitor
> fileystem errors.  This patchset introduces a new LTP test for this
> feature.
>
> Testing file system errors is slightly tricky, in particular because
> they are mostly file system dependent.  Since there are only patches for
> ext4, I choose to make the test around it, since there wouldn't be much
> to do with other file systems.  The second challenge is how we cause the
> file system errors, since there is no error injection for ext4 in Linux.
> In this series, this is done by corrupting specific data in the
> test device with the help of debugfs.
>
> The FAN_FS_ERROR feature is flying around linux-ext4 and fsdevel, and
> the latest version is available on the branch below:
>
>     https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-v9
>
> A proper manpage description is also available on the respective mailing
> list, or in the branch below:
>
>     https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error
>
> Please, let me know your thoughts.
>

Gabriel,

Can you please push these v4 patches to your gitlab tree?

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
