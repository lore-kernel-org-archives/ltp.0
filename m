Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F789C433FE
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 13:49:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C9B63C98D5
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 14:49:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AC9C3C98A8
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 14:49:38 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A1E951000A4A
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 14:49:37 +0100 (CET)
Received: by mail-il1-x12d.google.com with SMTP id s1so17056260ilj.7
 for <ltp@lists.linux.it>; Wed, 02 Feb 2022 05:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DXZdCtyffwL4vCc6tPbTtK79j9gtn5iG0VXS2LnY834=;
 b=BwaIgE3LKN9ZF0ds7GsfEMRubG61ipkFszlhwVOSbdPV3aMgRaveZCSpjdXAkCkLXc
 plubooe+bwRQmWOgLpFlkZgmGpC0KbF4kmCNbZcSmFhGHGSlZtKK2NZ92AzM60+h/E16
 IhaRBKGuLsR7r0lBNyJMsW0zRgDlrIiAIrQbuX0YecZuMBHmqZAYNYUtzMnTQt315ygv
 hwfQEG4df/bL9xZMGAzhGG5s6YsQiu01k8zWSuLlgqTPsDyyoSRulmkwPtOmzZv3vXo1
 T8MUCd8fEv8L5QB3xsimdLEdQKN6jfRx2lkmkFXdwun1xtV5vSuLfkIuTJdSHG9FaUp6
 uN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DXZdCtyffwL4vCc6tPbTtK79j9gtn5iG0VXS2LnY834=;
 b=wT8AqIBhyh8YBtrx0nh+b1bm3ltj0azmq5l56ojJoeyQG5xXwNZFEwdHwaPUHGuy51
 OecFwe7uIWvXzpAlz0mJJmnWnSDxJdbLHBTVWkXsTRZ5/IXmy5pJY/0EQutnPEKamRXG
 I8YVfq53aOK5bKPjeE3gUFX4CCTLxo1e1NnYIshM6t7TzxgWJxgDHfTC9Jz/zcs7Pn1x
 2tmfRqFignfjDdptHcyMX1JCjSZOuaa0RLJ2x0X4JRRdRZG3C7KPDsBjiEE5P+OipvCV
 iJ3WQ4g8XfonGaNSmmSRfCC2lSQ+K0q7d5OqN8idRRBFf0OMQcxM8zB6za+tiJfelm9O
 RmEw==
X-Gm-Message-State: AOAM531IX9Bt4M7qur8hQFRdtl4anXJZsYQqx6hWXeE8Z4uQ/mUY1Zab
 YfhTpJ6JojfmNRB9BLD0v0wPVBNrrRbsSyxuso0=
X-Google-Smtp-Source: ABdhPJx1FQImVhmi2FyjUGW44ZE7PEXt6lJs6jbJyL90VmbF2fpIq9L6iSexL8uEYxQUuobpwxaiCKdw6WiNN1f4ajM=
X-Received: by 2002:a05:6e02:1b85:: with SMTP id
 h5mr18702420ili.107.1643809776280; 
 Wed, 02 Feb 2022 05:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
 <YdxN6HBJF+ATgZxP@pevik>
In-Reply-To: <YdxN6HBJF+ATgZxP@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Feb 2022 15:49:25 +0200
Message-ID: <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>,
 Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jan 10, 2022 at 5:16 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> v5.16 released => patchset merged.
> Thanks!
>

Guys,

Looks like we have a regression.
With kernel v5.17-rc1, test fanotify22 blocks on the first test case,
because the expected ECORRUPTED event on remount,abort is never received.
The multiple error test cases also fail for the same reason.

Gabriel,

Are you aware of any ext4 change that could explain this regression?

In any case, Petr, I suggest adding a short timeout to the test
instead of the default 5min.
Test takes less than 1 second on my VM on v5.16, so...

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
