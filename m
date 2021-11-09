Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28416C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 09:36:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B08561159
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 09:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B08561159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78CAC3C07C6
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:36:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5D7D3C0781
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:36:15 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F851100196B
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:36:15 +0100 (CET)
Received: by mail-pg1-x533.google.com with SMTP id g184so17975052pgc.6
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 01:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lQMnB9T3crxoYSygpH2bn0ajBk9lpoq1PxAYN49q1Jw=;
 b=hQ93T6YcqqL6W83cjxI3NAHhLRO3DCffCktqfeVkP5S6mfKmGRX377OsFJjZuQUAud
 QDOAgPq0aYUc7uDf/B9/ebUMZWr+SzVklsxzHTp1Z/RAbA2jRDMuKFWCsYeSp4QLg9UF
 AHNoCHkjSZkkwuFrXY8bKUg1MPrrVsnw5bYQmZqUvpWbZ6eBS0s3+kfVQ1NpHQG+fjZ8
 nB4h/5HW6E83qxW8WjkLKwvqEFiyeR284yjx9LiULzYgqtV2WvLZeRvl6IozY9uk0PGa
 jMFzaDhJZTBGsiQSzZtpNcbAOytjZZu5YnJpZ7U1lGksMZysMkviDzQp9SCaVG368RaU
 ZdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lQMnB9T3crxoYSygpH2bn0ajBk9lpoq1PxAYN49q1Jw=;
 b=ogTjflt6RCjiGQa3e8u9q/RZL9wAlV7jv7B0p8oLiQs8Sohdfa2eNJspc2UZiDQ/TT
 z3oR++BZVkHt/rmlc56IuBf0jRR74Q1Luk6l4HCxGtMfADD809Ueqkbk5KY+5LLGac/y
 1b+KjbkvjYozqh2ttO0pFREqTjmTNhIYo5vEXz3yjL2FxvYnPSfefEURRZlVXsCIdWtI
 snY6kjFsnDrJEI9zpXn9XfjcdAeLlDpeaeyAyuU+lfKjO05uE0kt5XCjFT7voKQj8vu7
 1D1jdjtuVUheLzwb1gFNHmDPSiNfqv0+IeH+DEq6C45e7yuajR2zMv2wMboT55QA26Br
 MIPA==
X-Gm-Message-State: AOAM533gCiuXshDUwgaGCe7N4hLoj5LkZWndGVRu4LefKeHzEKGQIZOp
 Fqgyooz0PrRMQLWjJOaiqFpnIg==
X-Google-Smtp-Source: ABdhPJwPIAdtCFWaT+S5ZYdykx9kVw8YmjxiWg/YMxQf2fm4D+8/9jDAEXriNfHBX2koC+A97O1iJA==
X-Received: by 2002:a63:9d84:: with SMTP id i126mr4768334pgd.330.1636450573627; 
 Tue, 09 Nov 2021 01:36:13 -0800 (PST)
Received: from google.com ([2401:fa00:9:211:49d1:39e8:a7a5:de38])
 by smtp.gmail.com with ESMTPSA id s2sm17639532pfk.198.2021.11.09.01.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 01:36:13 -0800 (PST)
Date: Tue, 9 Nov 2021 20:36:02 +1100
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YYpBAlufyR0nlI7S@google.com>
References: <cover.1635849607.git.repnop@google.com>
 <229fb61317343cf30d481d05da272657c7572f59.1635849607.git.repnop@google.com>
 <CAOQ4uxgphXO16-u2fsm9Ts4nxY3AzSPpyMbKMWb2AtWs2ASB7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgphXO16-u2fsm9Ts4nxY3AzSPpyMbKMWb2AtWs2ASB7Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/fanotify21: add new test checking
 the returned pidfd from fanotify in FAN_REPORT_PIDFD mode
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 05, 2021 at 06:21:56AM +0200, Amir Goldstein wrote:
> > +next_event:
> > +               i += event->event_len;
> > +               if (event->fd >= 0)
> > +                       SAFE_CLOSE(event->fd);
> > +
> > +               if (info && info->pidfd >= 0)
> > +                       SAFE_CLOSE(info->pidfd);
> > +
> > +               if (event_pidfd_fdinfo)
> > +                       free(event_pidfd_fdinfo);
> 
> Need to reset event_pidfd_fdinfo = NULL
> to avoid double free in do_cleanup

But, the variable event_pidfd_fdinfo is not referenced nor is visible
outside the scope of the do_test() function and therefore no double
free would occur, right?

> > +       }
> > +}
> > +
> > +static void do_cleanup(void)
> > +{
> > +       if (fanotify_fd >= 0)
> > +               SAFE_CLOSE(fanotify_fd);
> > +
> > +       if (self_pidfd_fdinfo)
> > +               free(self_pidfd_fdinfo);

Variables self_pidfd_fdinfo do_cleanup() and event_pidfd_fdinfo
do_test() are different.

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
