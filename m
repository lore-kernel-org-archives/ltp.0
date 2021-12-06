Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C995FC433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 09:41:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F99B3C1CC5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 10:41:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29A603C0CCC
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 10:41:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 94B7360065A
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 10:41:43 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CBD401FD2F;
 Mon,  6 Dec 2021 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638783702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XQbmoAqD5YeE6KOuM3qbNuZhtNxJKqdCikNRlhqf29o=;
 b=dAAAmadAAG7iJllmWBPQt71SD00vvwv7UD5Y4w49BV3y+6NK5RjTP6lu9NWFcSbH/JrcfV
 54OwEMJt1TcWrA7y8ljg19mYPE6rerhJx7XqN6UaD9BpqGeIyllzF/bryeWlfbD9CXx2qS
 G+phnvTIIf3AtON5rvxyhsBQuUDh54w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638783702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XQbmoAqD5YeE6KOuM3qbNuZhtNxJKqdCikNRlhqf29o=;
 b=WviVZJvQToSfmAP+MudbMf7sLEmBaGh/G+H9z/+wGBKgDlGr60D0wmQJVn4VlFpKS0lZb7
 /kO6pXdWzEXU1CDQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7E66AA3B84;
 Mon,  6 Dec 2021 09:41:42 +0000 (UTC)
References: <20211130104330.32679-1-chrubis@suse.cz>
 <CAEemH2cJ-UOFAy0hzZad8uj1PCJA4VVt7SyQRwYPEUtYFGZgJA@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 06 Dec 2021 09:41:24 +0000
In-reply-to: <CAEemH2cJ-UOFAy0hzZad8uj1PCJA4VVt7SyQRwYPEUtYFGZgJA@mail.gmail.com>
Message-ID: <87ee6qcboq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] scripts/checkpatch.pl: Replace kstrto with
 tst_parse_
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Thanks, puashed!

Li Wang <liwang@redhat.com> writes:

> On Tue, Nov 30, 2021 at 6:42 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
>  Since there is no kstrto*() family of functions in LTP we do have
>  tst_parse_*() instead.
>
>  Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>
>  
> Reviewed-by: Li Wang <liwang@redhat.com>
>  
> -- 
> Regards,
> Li Wang


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
