Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D03CC43334
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 08:35:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1C123CA78A
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 10:35:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2689D3CA16B
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 10:35:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F795600AA1
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 10:35:34 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4B64B1FD4C;
 Wed, 13 Jul 2022 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657701334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CcsBBbemJwPnREj8tUcGtqYBeLDK85WV0Rb0buPzp3s=;
 b=BJ/2pHkXbNnHfTFeBIIZK9+C7zTuLNqlfrU5AON0AgJDEBieZg/cptr5j4lSS/Tth2GZh5
 uTTDK6JayWctFwZVWdAzcIMoe1cRbOEyqznFtt3Io4SkUf29BmMApL/9YZ4yawoXTVuWCf
 erYJs5aGcZo5a/6X98xFnRLAQa4ADEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657701334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CcsBBbemJwPnREj8tUcGtqYBeLDK85WV0Rb0buPzp3s=;
 b=29egoYKkhz8DyFsT88GI2fB5xWVcR3WZlWzZxkJDRz32bg0P8E5Vfsut9piqSGhsjFOuvx
 Z82YwHDwj+9CZZBQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4DBB22C141;
 Wed, 13 Jul 2022 08:35:33 +0000 (UTC)
References: <Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020> <87wncknkfe.fsf@suse.de>
 <CABGWkvqF9f4vOYUQeYuaDGT7yuB=8=h=yPpuG04VwicNP=wgMA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Wed, 13 Jul 2022 09:23:28 +0100
In-reply-to: <CABGWkvqF9f4vOYUQeYuaDGT7yuB=8=h=yPpuG04VwicNP=wgMA@mail.gmail.com>
Message-ID: <87v8s1l8a3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [can] c4e54b063f:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/workqueue.c
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
Cc: lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
 Jeroen Hofstee <jhofstee@victronenergy.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-can@vger.kernel.org,
 lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Dario Binacchi <dario.binacchi@amarulasolutions.com> writes:

> Hello,
>
> On Mon, Jul 11, 2022 at 10:05 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>>
>> Hello,
>>
>> kernel test robot <oliver.sang@intel.com> writes:
>>
>> > Greeting,
>> >
>> > FYI, we noticed the following commit (built with gcc-11):
>> >
>> > commit: c4e54b063f42f20a6b3ad1ffa61c574e631e0216 ("can: slcan: use CAN network device driver API")
>> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
>> > master
>>
>> I guess the problem is this may sleep with soft irqs disabled.
>>
>> static int slc_close(struct net_device *dev)
>> {
>>         struct slcan *sl = netdev_priv(dev);
>>         int err;
>>
>>         spin_lock_bh(&sl->lock); <-- takes lock
>>         if (sl->tty) {
>>                 if (sl->can.bittiming.bitrate &&
>>                     sl->can.bittiming.bitrate != CAN_BITRATE_UNKNOWN) {
>>                         spin_unlock_bh(&sl->lock);
>>                         err = slcan_transmit_cmd(sl, "C\r");
>>                         spin_lock_bh(&sl->lock);
>>                         if (err)
>>                                 netdev_warn(dev,
>>                                             "failed to send close command 'C\\r'\n");
>>                 }
>>
>>                 /* TTY discipline is running. */
>>                 clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
>>         }
>>         netif_stop_queue(dev);
>>         close_candev(dev); <-- calls cancel_delayed_work_sync()
>>
>
> I would try (since I am unable to replicate the test) to move the
> spin_unlock_bh()
> before calling close_candev().

I haven't tried, but I think it should replicate every time with
lockdep/lock debugging enabled.

> Can the patch be sent now or do I have to wait until the code is in
> mainline?

IMO it *has* to be fixed before going into mainline :-p. I can't comment on
the correctness of the proposed fix though.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
