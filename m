Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE0DC433EF
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:16:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8696F6023E
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8696F6023E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EE983C7188
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:16:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5D143C68BB
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:16:02 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E577E2013A3
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:16:01 +0100 (CET)
Received: by mail-pg1-x536.google.com with SMTP id e65so19844994pgc.5
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DNVFVEatazx7RnBC6aevijY+JQbTvYMGtq7++AYqAYo=;
 b=F3NlBlSzEzBkurZWTXz9veZ7ZIBj0J0WMPxkbYjQjOoPY2q2XsbP3XfgB9nBMvfUB8
 +T5n0RwTQVL89s7O1njFp/UYIZUQWMY5RK6YtIQ8TrEDcFwiBExN7fjaGD91mV12JdMO
 F9JvEsof1N52hRoB//HU2lOinFZZLhHTBE0J3UlnKMPnB2frGezx8whz6t+OfO8vAqsY
 HGSd4PF/w0Q6jof7AYZEB4RuhPC1sz/V9czgYbWXVgujycuay6F/D6hYxqNqQ2i9A8vX
 7ctP7s2sQQ01uJieqpmCjvuf1Dk3IiZpv4M2K7mmTgTvSWphGiC630agbRHnfhTd+ipc
 +Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DNVFVEatazx7RnBC6aevijY+JQbTvYMGtq7++AYqAYo=;
 b=XL7OXlRhAjKw4wfs/qyzsUZPwOFjAcqPl0F8vGSLnc6RChOD4xhUYY60aN1f734EUi
 qBDmBak9JF91nJJ+hGaIg0MOLyeL5S5i+jSTW66YbRklVoXHuxo4aXjM7YRNOuC370Q5
 RBKTgyvHhkaHOVn9uS12HDCjrchYz//gWKv81QPmGwUaZKe5Ns3PCL3YoV0W+ZpMq/AT
 JcdFPk9Je60t4Yfd9923WyXc95n5S3MNeprWoubEZMTYva6dIqri+8EGBdVTjWjtnZVi
 ZwxAiFmxCgJpMCWZXOcm6K9orHRLxV7m7NAWhdeCi5RDCz9sPpIeGn0NIdUaENAsiYLY
 TtzQ==
X-Gm-Message-State: AOAM530uUvDkfPN/UGTjoP8fhJHe2KoNpyATxkYZWzPfGt+7ah7reMlN
 7FA8vJhkP7tlFzlroyXNlBPHSxljXDNSUA==
X-Google-Smtp-Source: ABdhPJyOnwDsqg9yzSiV48jcml3Ck5qL8saaPcjYYwLYUJRsEMepzrZdYqet4ReUvvQrMaNJbPC5dw==
X-Received: by 2002:a63:6c4a:: with SMTP id h71mr22478886pgc.173.1635851760305; 
 Tue, 02 Nov 2021 04:16:00 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com.
 [35.240.157.64])
 by smtp.gmail.com with ESMTPSA id m22sm18822596pfo.176.2021.11.02.04.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 04:15:59 -0700 (PDT)
Date: Tue, 2 Nov 2021 11:15:53 +0000
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YYEd6cqlz+6PkIZu@google.com>
References: <cover.1635849607.git.repnop@google.com>
 <b404edc9a25e9ec09fc975b1bac1947c5eb0408a.1635849607.git.repnop@google.com>
 <CAOQ4uxjhFNJkfKYuQdKpWtn4ZCMr3Er-mp+Jp0oekPTp2Xm1BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjhFNJkfKYuQdKpWtn4ZCMr3Er-mp+Jp0oekPTp2Xm1BQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/fanotify20: add new test for
 FAN_REPORT_PIDFD
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 02, 2021 at 01:02:48PM +0200, Amir Goldstein wrote:
> On Tue, Nov 2, 2021 at 12:57 PM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > This test ensures that the fanotify API returns the expected error
> > status code -EINVAL when an invalid flag is supplied alongside the new
> > FAN_REPORT_PIDFD initialization flag. Currently, FAN_REPORT_TID is the
> > only initialization flag that is not permitted in conjunction with
> > FAN_REPORT_PIDFD, so we explicitly provide test coverage for this.
> >
> > We also add an extra trivial test case to ensure that the
> > initialization behavior with the other FAN_REPORT_* related flags is
> > working as intended.
> >
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> > Changes since v1:
> >  - Introduced a new macro
> >    REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL() that is
> >    responsible for testing whether the supplied initialization flags
> >    are supported by the underlying kernel. This is used from
> >    do_setup(). Using this is less ambiguous then using something like
> >    REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS().
> 
> Not like this.
> Please start your branch with the first two prep patches from
> Gabriel's LTP post (including my reviewed-by tag) preserving
> Gabriel's authorship and signed-of-by and adding your own
> signed-off-by.
> 
> Your LTP tests are expected to be merged before Gabriel's test
> because your tests are for a 5.15 feature.
> Once your tests are merge, Gabriel would be able to rebase on master
> and drop his prep patches.

Am I reading all the words, or only some of the words?

AFAICT, the macro that I've defined here is different to that of what
has been implemented in Gabriel's series.

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
