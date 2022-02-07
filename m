Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCDDC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 13:42:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B741D3C9B0F
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:42:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F4CB3C0720
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 14:42:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2B7D01400B80
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 14:42:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 64F25210F8;
 Mon,  7 Feb 2022 13:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644241340;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6VYyzzUcIKou6Bfp5YgVZzuBLkVTeIJJtIx2De5+1Y=;
 b=qQLtQ9Qx51mRb4en4hj0PY0PYbVWrNaAXdvCFOXHPGREaojJTWKHcBEXudqe133Knub190
 1Zkajhjx9Tk5WCSBO+/awGYaIFWLmR3cjlON422TgXRiwR6RTTJRpa9pLk3N9fMyIp/9SC
 hsfkMLrr130AFJRHAW600bQT4kIZjXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644241340;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6VYyzzUcIKou6Bfp5YgVZzuBLkVTeIJJtIx2De5+1Y=;
 b=CUaw3nO+DnDnD7ly7I8/firhvhBIPlIP2yEx08cQcw+JwRNZdXx556uKhr5OSsCzUcyuaa
 eUS+wuhWtpN9HsAw==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3231EA3B85;
 Mon,  7 Feb 2022 13:42:20 +0000 (UTC)
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-3-rpalethorpe@suse.com>
 <CAEemH2cj2yDJDJL3bdL58M-aRAcU+ox3EMHc93gdr87=rXHvsg@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 07 Feb 2022 13:18:14 +0000
In-reply-to: <CAEemH2cj2yDJDJL3bdL58M-aRAcU+ox3EMHc93gdr87=rXHvsg@mail.gmail.com>
Message-ID: <87h79ax078.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] API/cgroup: Declare required controllers
 and version in test struct
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

> Hi Richard,
>
> This is a good improvement for the CG API. Nice work!!

Thanks.

>
> On Thu, Feb 3, 2022 at 4:20 PM Richard Palethorpe via ltp <ltp@lists.linux.it> wrote:
>
>  ...
>
>  --- a/include/tst_test.h
>  +++ b/include/tst_test.h
>  @@ -133,6 +133,14 @@ extern unsigned int tst_variant;
>
>   #define TST_NO_HUGEPAGES ((unsigned long)-1)
>
>  +/* CGroups Kernel API version */
>  +enum tst_cgroup_ver {
>  +       TST_CGROUP_V1 = 1,
>  +       TST_CGROUP_V2 = 2,
>  +};
>
> We can move this into 'tst_cgroup.h' if included that header in tst_test.h.
>
> (As we decide to integrate the CG structure in tst_test, it
> seems better to include that tst_cgorup.h file though that
> makes some binaries become larger.)

Yes, thinking about it tst_cgroup.h only declares a few symbols now
anyway.

Also agreed with all the other points.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
