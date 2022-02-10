Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978F0C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 07:34:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 080933C9DDA
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 08:34:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 341EC3C9DB4
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 08:34:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 833DC6009D9
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 08:34:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8F76F210F6;
 Thu, 10 Feb 2022 07:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644478445;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxaSwN/QQsXF37FkXMNvqzdVKXgjKxaFZ+IoTpFvaVY=;
 b=Lc91NAnVv5XqtSA5EpiaVhRztXBdmGygcyMT69tVnvRfe16HuQ5LhHhCBbSOY3ciRr/xZB
 B9DgLx4X1M+fzfjnBfrQmimDfVhZl2CO6Z+gBEAoRCiLRi2mQMGUZktnMepTAr0RatVMoQ
 A8DQ+EtrtkAChOaZtx6CKgJcHLo67pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644478445;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxaSwN/QQsXF37FkXMNvqzdVKXgjKxaFZ+IoTpFvaVY=;
 b=8UX16Z9XEVvw9dJq3KdygFiosgHIc7fo+zahtcTQNYERCpXMjbe/DsnbXLNiij8BLNz3ob
 jCVGxit7gBdhSvAA==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5D212A3B85;
 Thu, 10 Feb 2022 07:34:05 +0000 (UTC)
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-3-rpalethorpe@suse.com>
 <CAEemH2fjSLAdY4xO7WMekGX=3sPFjt0xVknNxJedk1-agsb3zQ@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 10 Feb 2022 07:32:27 +0000
In-reply-to: <CAEemH2fjSLAdY4xO7WMekGX=3sPFjt0xVknNxJedk1-agsb3zQ@mail.gmail.com>
Message-ID: <87a6ezkwes.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] API/cgroup: Shorten cgroup to cg in most
 symbols
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> On Tue, Feb 8, 2022 at 10:04 PM Richard Palethorpe via ltp <ltp@lists.linux.it> wrote:
>
>  With the current naming it is common to have 'group' repeated 3 or
>  even 4 times in one line. This causes a number of readability
>  problems. Renaming it to cg reduces the amount of repetition.
>
>  The one place it is not renamed is in tst_test because it won't cause
>  repetition there. Meanwhile it is easier to search the internet for
>  'linux cgroup' than 'linux cg'.
>
>  Li Wang suggested renaming tst_cg to tst_cg_test because it is
>  consistent with tst_cg_drain. However I think tst_cg is used so often
>  that it is more important to have shorter lines.
>
> To be honest, I only wanted that tst_cg_test pointer :).

I understand, but I saw that a lot of lines had become too long with
other changes. It's starting to get difficult to manage.

>
> But I have no objection to renaming 'tst_cgroup_*' to 'tst_cg_*'
> for the whole APIs. (Though I don't like it)
>
> Let's hear more voices from peers.

;-)


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
