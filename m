Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBBCC433EF
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 08:27:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C1293C9751
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 09:27:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D6A33C9514
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 09:26:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B1B8560008A
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 09:26:57 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D83C8210FD;
 Thu, 27 Jan 2022 08:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643272016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JLnFL6ld7C/eH2xn7PwbLRI0woLEDwZUxjXDvhm92eQ=;
 b=lZVmgnfRl0fqEWzSInEpTG8QYlgXBThsJXQ301wXr+Wq1PIv1J5kNTjBf+djWBrnL4oyoO
 UaPNKRqubQkVeTCy1O+KxOIoSrwi9x2avhv/B7vKTdrhrwv73J4y6pfhEVoE7iPVWhD7S3
 JLxm9WSF4fjxvq2r3El3Rvpyda7Yxko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643272016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JLnFL6ld7C/eH2xn7PwbLRI0woLEDwZUxjXDvhm92eQ=;
 b=YCkC3vmm+Z4JDPigM1B4Y0UNkpcyFX5YpbnQhkLvkyL37UyqJxZz/lRYSwoe+OV+qMTjHm
 4zVbHJ0t2FLs/gBA==
Received: from g78 (unknown [10.163.24.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A9015A3B81;
 Thu, 27 Jan 2022 08:26:56 +0000 (UTC)
References: <20220127061225.23368-1-rpalethorpe@suse.com>
 <20220127061225.23368-7-rpalethorpe@suse.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 08:26:28 +0000
In-reply-to: <20220127061225.23368-7-rpalethorpe@suse.com>
Message-ID: <87bkzxy46n.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] memcontrol03: Copy from kselftest
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Richard Palethorpe <rpalethorpe@suse.com> writes:

> Note that the tolerances had to be increased slightly otherwise the
> test only passed on ext4 in upstream 5.16 on x86_64. In all cases it
> seems more memory is evicted from C than expected and not enough from
> D. This may indicate some tuning is possible, but does not look like a
> serious regression.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  .../kernel/controllers/memcg/memcontrol03.c   | 231 ++++++++++++++++++
>  1 file changed, 231 insertions(+)
>  create mode 100644 testcases/kernel/controllers/memcg/memcontrol03.c

Oops, I forgot to add the gitignore and runtest entries!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
