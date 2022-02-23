Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E88C433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 14:09:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F6EE3C9AD9
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 15:09:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29AFB3C96B4
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 15:09:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9FE0B1402F88
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 15:09:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B40A21155;
 Wed, 23 Feb 2022 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645625373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z8PSrg0g8lrQC1eVXJaDLK96s5BgbSPhSBExLpzb9Vc=;
 b=YzFsc4yOsz5D4smPC7mORDfP+qpZjs2OISLTEYSZqvbnX8A9gDY16RcAwO3QKBgokfRMfc
 rzE4FKEwEcwygJ5a13AJJP6Cah3xJzgrJcR/0NPWlVSLx5sCiF9HcBt9DNmJH97X/EsJRt
 +s7lAeQLVv2elTbyjXSkA/PTeQsqUYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645625373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z8PSrg0g8lrQC1eVXJaDLK96s5BgbSPhSBExLpzb9Vc=;
 b=JEMMoBq0NDkKObw/HLwMwPhKfBZYvXeYnEV6deSd0ASKEOutnpS7hlfXVGSmRl+7tkqkSL
 MCRd+6RSeF3HwmCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4638713D76;
 Wed, 23 Feb 2022 14:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CKFDEB1AFmJmPwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Feb 2022 14:09:33 +0000
Date: Wed, 23 Feb 2022 15:11:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YhZAokgMMBLJfamN@yuki>
References: <b32ed0e56099520bc3e75455e2472841aa0b3020.1645096642.git.jstancek@redhat.com>
 <CAEemH2cM9-qHgu2F1=H9W0sWZFkGu1BvWdNvGyREsf+s9kHSSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cM9-qHgu2F1=H9W0sWZFkGu1BvWdNvGyREsf+s9kHSSQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/perf_event_open03: skip test on slower
 systems
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Generally, this method looks good, but maybe better to limit this
> check_progress() only perform on -debug kernel?  Otherwise,

I guess that it may be pretty useful on embedded systems as well. Having
TCONF message with "system too slow" rather than a timeout sounds like
an improvement to me.

> Reviewed-by: Li Wang <liwang@redhat.com>
> 
> 
> ======= FYI ==========
> I'm seeking a fair way to make a global evaluation of the test
> system to reset timeout dynamically for the whole LTP.
> 
> My original design thoughts:
> 
>   Create the numbers of threads equal to CPUs and bind them to
>   the corresponding cpu for running. Use mutex lock to sync up
>   each thread launch at the same time to collect the basic data
>   for their CPU. Then we can compare the CPU state under the idle or
>   busy time to get a relatively stationary _value_ to measure the system
>   performance.
> 
> But so far the test method is not stable&reliable as expected.
> 
>   // do float computing + dirty 10*pagesz memory  in a limited times
>   one_unit_of_operation();
> 
>   // count the CPU looping numbers with (type = idel, calcu)
>   // and call one_unit_opertaion() in 1 sec
>   cpu_1sec_looping(int type);
> 
>   idlespeed_loops = cpu_1sec_looping(idel);
>   calculate_loops = cpu_1sec_looping(calcu);
>   ...
>   // count the _value_ from all CPU average loops
>   ratio = calculate_avg / idealspeed_avg;

I'm not sure how useful this would be, I guess that the speed of
different syscalls will differ quite a bit on different kernel versions.
Maybe the whole system is too complex and cannot be described by
something as simple as this. But I guess that we will not know unless we
try.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
