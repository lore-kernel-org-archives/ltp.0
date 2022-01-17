Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C71C433EF
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 09:21:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18E123C9603
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 10:21:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FF313C9550
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 10:21:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AC6BB600078
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 10:21:01 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9900521129;
 Mon, 17 Jan 2022 09:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642411260;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJsiG8/IrlS57V8wHyJX+HkJXYwtO1x01cFuaNwLi9s=;
 b=xX3MQAqWwxisqNjRIbBpbDG66B1JCmVpcM3sG6Fwfg6QUN2aQNfR4L3FkwyYlBTqTu+972
 RXzBzCstHQBTvgzOTqwD21PEWP+wtnS6nYfIzCguDul6bmTJosUEp33djKqQpyLWen7M2B
 4tSYx4IuSHlrhXR8ltTn01Kef2mZ8nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642411260;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJsiG8/IrlS57V8wHyJX+HkJXYwtO1x01cFuaNwLi9s=;
 b=XgSKgKy26CQ126foI06V4iWpLGYOcrcW0Sp9T8dLUB/yJ5yIc42iqKVx4e703Zwb6SJXRC
 JlNQMRu8/ro7VwBg==
Received: from g78 (unknown [10.163.24.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5C29FA3B81;
 Mon, 17 Jan 2022 09:21:00 +0000 (UTC)
References: <20220113123418.1911231-1-liwang@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 17 Jan 2022 09:05:40 +0000
In-reply-to: <20220113123418.1911231-1-liwang@redhat.com>
Message-ID: <87wniyzpj8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: rewrite cgroup_find_ctrl with using
 for_each_ctrl
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
Cc: ltp@lists.linux.it, luke.nowakowskikrijger@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> It is safe to start from controllers[0] to traverse each of
> the controller whatever V2 or V1, then we can make use of it
> in the cgroup_find_ctrl() function.

Right, it seems we never set ctrl_root on "cgroup" nor is it added to
ctrl_field. So it will be skipped in other loops. This might not be what
people expect, but I'm not sure what to do about that.

>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  lib/tst_cgroup.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 2ef599d9e..10b65364b 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -214,7 +214,7 @@ static const char *cgroup_v2_ltp_mount = "unified";
>  #define for_each_v1_root(r)			\
>  	for ((r) = roots + 1; (r)->ver; (r)++)
>  #define for_each_ctrl(ctrl)			\
> -	for ((ctrl) = controllers + 1; (ctrl)->ctrl_name; (ctrl)++)
> +	for ((ctrl) = controllers; (ctrl)->ctrl_name; (ctrl)++)
>  
>  /* In all cases except one, this only loops once.
>   *
> @@ -325,15 +325,14 @@ void tst_cgroup_print_config(void)
>  __attribute__ ((nonnull, warn_unused_result))
>  static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
>  {
> -	struct cgroup_ctrl *ctrl = controllers;
> -
> -	while (ctrl->ctrl_name && strcmp(ctrl_name, ctrl->ctrl_name))
> -		ctrl++;
> +	struct cgroup_ctrl *ctrl;
>  
> -	if (!ctrl->ctrl_name)
> -		ctrl = NULL;
> +	for_each_ctrl(ctrl) {
> +		if (!strcmp(ctrl_name, ctrl->ctrl_name))
> +			return ctrl;
> +	}
>  
> -	return ctrl;
> +	return NULL;
>  }
>  
>  /* Determine if a mounted cgroup hierarchy is unique and record it if so.

Nice simplification!

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
