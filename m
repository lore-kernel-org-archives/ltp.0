Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB59EC433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 05:39:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB6CE3C9F27
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 06:39:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 916B93C3206
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 06:39:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A723A601D1B
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 06:39:27 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0CBE11F37D;
 Thu, 17 Feb 2022 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645076367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DTH/Zt+9cpGFOOnaaiLzAwIWW+ZCNSDEEIzomEX7seU=;
 b=QBCbkQ+RgtGekvt7WPGiDaF2LZeuW7PLsoxLQIsow9Se37DEUpX2Y7OO5SqqoS8/G/bcF5
 4Db5ZsWC9bJFFz2D/1HuJNAJ8A3DqbKj4+LKyPars8soZTnlZ3aXtV1bWfHNHDNkHRbgsT
 kziZumvXCFLsVHz2d45/Uzj3Km6Ta80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645076367;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DTH/Zt+9cpGFOOnaaiLzAwIWW+ZCNSDEEIzomEX7seU=;
 b=XY9JW7VUfy659jPtM6jf2pTib2NrBVDAcJUJdQ1JSxYUcMSOjFddE2Lv+btQd+edhhGn3X
 ivuDEQjzOhXVEqAQ==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BD015A3B83;
 Thu, 17 Feb 2022 05:39:26 +0000 (UTC)
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-3-rpalethorpe@suse.com>
 <CAEemH2fjSLAdY4xO7WMekGX=3sPFjt0xVknNxJedk1-agsb3zQ@mail.gmail.com>
 <Yg0XwAb1LOso6dtf@rei>
 <CAEemH2fwb6ggm+aA4DmvbO4Ut0nDK46AyZ7efJSXqsLFPMcwPw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 17 Feb 2022 05:37:50 +0000
In-reply-to: <CAEemH2fwb6ggm+aA4DmvbO4Ut0nDK46AyZ7efJSXqsLFPMcwPw@mail.gmail.com>
Message-ID: <87sfsijbld.fsf@suse.de>
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
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> On Wed, Feb 16, 2022 at 11:27 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
>  Hi!
>  > To be honest, I only wanted that tst_cg_test pointer :).
>  > 
>  > But I have no objection to renaming 'tst_cgroup_*' to 'tst_cg_*'
>  > for the whole APIs. (Though I don't like it)
>  > 
>  > Let's hear more voices from peers.
>
>  Actually I like it, having the common prefix shortened to just tst_cg_
>  makes it easier to read, at least for me.
>
> Well, two to one, thanks for the comments :).
>
> @Richard Palethorpe  Hi Richard,
> Feel free to push 1/3 and 2/3 patches, in case someone (I guess Luke)
> waiting for the code rebase on it. 
>
> We can hold patch 3/3(memcontrol04) for a while for fail debugging.
> (I am involved in another stuff these days, will look back on that
> soon)

Ah, OK, thanks, I will do that. I just sent a V2 with these in, but I
had not read your's and Cyril's messages.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
