Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7678AC433FE
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 11:12:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD7323CD14B
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 12:12:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E87E83CD123
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 12:12:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55695100092C
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 12:12:05 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7268C1F8B5;
 Tue, 15 Nov 2022 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668510724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WBvGpcLh+m36di/Rq6bKDyrZWsyC66vR4zNwliID+yg=;
 b=RypB5dZoXdmbmtbmFufNkqtM/o647izdCSpkAPof6+XOWzxvZDohoD5bGkVrNdu4eusgj0
 5J3VSglVA5aSpB3nXZQj/bYqIAz8WA/fowe9qYz1a2u7r18/Y9MCxJi1T4dLxpnTe81yg0
 JpK6/8UOge23ErtDDDUMeXYhiSiV9NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668510724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WBvGpcLh+m36di/Rq6bKDyrZWsyC66vR4zNwliID+yg=;
 b=woH/meMHM0K9s9r3lGBpTlT2UTreteoFKK65Qt9lsnLqvkisHP7En76Cp4mj2NNp/WLpjx
 FIjv3EClvsxLaRBg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 321082C142;
 Tue, 15 Nov 2022 11:12:04 +0000 (UTC)
References: <20221112040107.3953862-1-liwang@redhat.com>
 <87pmdpsfdv.fsf@suse.de>
 <CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com>
 <87h6z0sh8o.fsf@suse.de>
 <CAEemH2c-90baLEbom4yF8oVjh9n7O4uKkXS5SBmx2rSBRsZBBQ@mail.gmail.com>
 <CAEemH2d=65BMhY4RFXHS1d5dkbq7v2QDskfE_5b_WnttDXT+Fg@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 15 Nov 2022 11:04:36 +0000
Organization: Linux Private Site
In-reply-to: <CAEemH2d=65BMhY4RFXHS1d5dkbq7v2QDskfE_5b_WnttDXT+Fg@mail.gmail.com>
Message-ID: <87zgcsqxoc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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
Reply-To: rpalethorpe@suse.de
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Li Wang <liwang@redhat.com> writes:

> On Tue, Nov 15, 2022 at 6:00 PM Li Wang <liwang@redhat.com> wrote:
>
>  Richard Palethorpe <rpalethorpe@suse.de> wrote:
>   
>  >  
>  >  Practically speaking we have to assume a large amount of time has passed
>  >  when using ITIMER_REAL. It has to be *much* larger than a VM is likely
>  >  to be paused for and then successfully resumed. Or the amount of time a
>  >  clock may be corrected by (for e.g. with NTP).
>  >
>  > Hmm, not sure if I understand correctly above, will that
>  > timer value be out of the range but reasonable?
>  >
>  > Or is there any additional situation we should cover?
>
>  Sorry that is confusing.
>
>  The question is what happens if the clock jumps backwards?
>
>  I don't see anything which says it_value.tv_sec can't go out of
>  range. OTOH I would expect it to compensate for large jumps in time.
>
>  If the test randomly fails because it_value.tv_sec > time_sec then what
>  action will we take?
>
> Or, we do nothing on this, just let the test report TFAIL, because that
> is not what this test can control.
>
>  
>  
>  How about increasing the time_sec on virtual machine?

It could happen on bare metal as well.

>
>  Seems no perfect way to completely resolve but only reducing
>  the odds of happening. 
>
>  Or do you have another better suggestion?

TBH I don't know if it will happen. An acceptable outcome for me is to
print the time at the beginning and end of the test. Then if the test
fails we can see if it was due to a time jump and start investigating
what the kernel is supposed to do in this case.

The alternative is to find out now what the kernel should do. We could
also write a test which deliberately changes the system time during an
interval. Depending how motivated you are.

>
>  --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
>  +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
>  @@ -142,6 +142,11 @@ static void setup(void)
>   
>          time_sec  = 9 + time_step / 1000;
>          time_usec = 3 * time_step;
>  +
>  +       if (tst_is_virt(VIRT_ANY)) {
>  +               tst_res(TINFO, "Running in a VM, multiply the time_sec by 10.");
>  +               time_sec *= 10;
>  +       }
>   }
>
>   
>  -- 
>  Regards,
>  Li Wang


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
