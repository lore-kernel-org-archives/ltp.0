Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4A1C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 08:50:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F9113C7028
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 10:50:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F5973C2674
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 10:50:36 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1EDFB1A00A2E
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 10:50:36 +0200 (CEST)
Received: by mail-vk1-xa29.google.com with SMTP id c11so342264vkn.5
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 01:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QxFXOvbk3aBHe6xLBYd8bTzayc3QVLLc4QAr4/t9mNk=;
 b=cSDNKzuH2ganJbqH974NX9Uup+uDOTyusOwy4R8ObmTXWUv0c6XNkreXm/nhTU6VTV
 U2munNT5mWYUTyVLNKOHqikJbq7ZdFEfsIbs4DXTetxRDRsCCsrLxH/u85mLl3ZmIgoq
 SGPw4u9tSd/Lf4j6KED2375pj0jdAiPLCTlsQEo5H+MFWLbaKybPNBWFvQ7DL295ZssG
 zEsAlR+AuWpMBDngdjeFTENT8/Cgd1MvChc5BKYvQx+w0V6cjokty0YaXxRrhJY5SAAA
 OePofXMb0eQ+T51PvVF2hiCDNHyVsRrjrlLg4fUV/Q96snbAk0Bo540bwtcjPY8SNiJS
 xBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QxFXOvbk3aBHe6xLBYd8bTzayc3QVLLc4QAr4/t9mNk=;
 b=HRY/DGamwgcZ4P7/ZWatya8e5ydHC8+g5wPTyMeToee8Rx2uqEAeyr6C6E96yr2MHu
 za40jILsjbf0+4HzQAsCj5NLoLkuWtr/YN+k0m0+eQmd8qma4WWbKpVS00bGpioGRB+P
 ncXoPwmpZchDpRO1xx0/+1DX5njzv4h20Fm9WD59wt/uCbcp+ipJDqwR1/pu1bzumvcA
 qE6vUNvGGB0BtwtFNS5KiW3+FlkjJREnwRDhYYks8HLgUWs6rIYlqTO4H2evIMfilFqi
 EiXwBt0vBEOkNJo+VUlmlKrkBYm0nP1fNYsrYgKMyiWIz1M7xG9tfjiR86ExH0MZJXhY
 urng==
X-Gm-Message-State: AJIora9nDJwaZmpFyhUVBeIWplf2miwq8v2mWf8iXk9asUJe68lPXnHm
 jP7Pubgfeg0fLySYM67nJkBxLSspM90myf0YHlE=
X-Google-Smtp-Source: AGRyM1vPGONoP8SuCGvv7loemH7c4l81AzDBWiWW7d2FMVcIh1HOZVt7P9ocHWr+tvB5dXOnI7eVJuWPXbpL1EUpepY=
X-Received: by 2002:a1f:73c1:0:b0:35c:cb95:832 with SMTP id
 o184-20020a1f73c1000000b0035ccb950832mr1745957vkc.15.1655369435005; Thu, 16
 Jun 2022 01:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-3-amir73il@gmail.com>
 <YqrrkM0bWS+1X192@pevik>
In-Reply-To: <YqrrkM0bWS+1X192@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Jun 2022 11:50:23 +0300
Message-ID: <CAOQ4uxhnr_t+LTSsUiNQQW8nhOs7pvR2oHw9ii-mHPrhzUPiVQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] syscalls/fanotify23: Introduce
 FAN_MARK_EVICTABLE test
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 16, 2022 at 11:36 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir, Jan, all,
>
> > Verify that evictable mark does not pin inode to cache and that
> > drop_caches evicts inode from cache and removes the evictable mark.
>
> > Verify that evictable mark can be upgraded to non-evictable but not
> > downgraded to evictable afterwards.
>
> We have policy for merging tests for rc kernels [1], thus I merged this patch
> (added fanotify23 into runtest/staging).

Cool. I am glad this issue has been sorted out :)

>
> I'll discuss with others what to do with fanotify10 (old test getting new
> functionality for rc kernel).

Please note, fanotify10 already has:

        if (tc->ignored_onchild && tst_kvercmp(5, 9, 0) < 0) {
                tst_res(TCONF, "ignored mask in combination with flag
FAN_EVENT_ON_CHILD"
                                " has undefined behavior on kernel < 5.9");
                return;
        }

We could easily do the same for FAN_MARK_EVICTABLE
and 5.19.0 (although not sure how tst_kvercmp treats 5.19-rc1?)

I doubt that anyone would want to/be able to backport this feature
to older distro kernels, but even if they do, we could remove the
tst_kvercmp mitigation once 5.19.0 is release and leave only the
feature test if someone complains.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
