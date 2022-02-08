Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6698BC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 09:15:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 736463C9B2C
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:15:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A18F23C87BB
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 10:15:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1492B6002EB
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 10:15:38 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 10E42210F9;
 Tue,  8 Feb 2022 09:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644311738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onP6oukwk2B7ezlthJVjRAaarLZl+nwO1uxEg/+8aKk=;
 b=N9Dsyw/tfdASaTXlDECCJqakFs4y7Yhh0EFVRirY3SYE2wu1cH/3w2l+MJkkdTGeUGixco
 lof0nK5tGNC4W27OLu55z41Wfp/Gz+5HJDCK7hqwx6jtM4t2iF0Nbze0Snvo1slsTxQblr
 cEVqaoy5XxY0iXDB78/rsWdZcD0F9Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644311738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onP6oukwk2B7ezlthJVjRAaarLZl+nwO1uxEg/+8aKk=;
 b=6pmIf6l1CsDwrP/cfgsoDSMJq/HNH/PSUxdWzoEgjPtpMsvXFw0fjHY9/aH9bKSBp0emod
 Hyf/iejn6owwJeCA==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 86EF8A3B91;
 Tue,  8 Feb 2022 09:15:37 +0000 (UTC)
References: <20220207141618.2844-1-rpalethorpe@suse.com>
 <20220207141618.2844-3-rpalethorpe@suse.com>
 <CAEemH2d-K=X0aodrLV=4AiVE-GWDkHv3+Rxf_NUq8btH=jF77A@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 08 Feb 2022 09:09:40 +0000
In-reply-to: <CAEemH2d-K=X0aodrLV=4AiVE-GWDkHv3+Rxf_NUq8btH=jF77A@mail.gmail.com>
Message-ID: <87czjxwwgc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/5] API/cgroup: Declare required controllers
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

Hello,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> Richard Palethorpe <rpalethorpe@suse.com> wrote:
>  
>
>  --- a/include/tst_cgroup.h
>  +++ b/include/tst_cgroup.h
>  ...
>
>   /* A Control Group in LTP's aggregated hierarchy */
>   struct tst_cgroup_group;
>
>  +/* Populated with a reference to this tests's CGroup */
>  +extern const struct tst_cgroup_group *const tst_cgroup;
>  +extern const struct tst_cgroup_group *const tst_cgroup_drain;
>
>  
>
>  --- a/lib/tst_cgroup.c
>  +++ b/lib/tst_cgroup.c
>  @@ -18,7 +18,6 @@
>   #include "lapi/mount.h"
>   #include "lapi/mkdirat.h"
>   #include "tst_safe_file_at.h"
>  -#include "tst_cgroup.h"
>
>   struct cgroup_root;
>
>  @@ -138,6 +137,14 @@ struct tst_cgroup_group {
>          struct cgroup_dir *dirs[ROOTS_MAX + 1];
>   };
>
>  +/* If controllers are required via the tst_test struct then this is
>  + * populated with the test's CGroup.
>  + */
>  +static struct tst_cgroup_group test_group;
>  +static struct tst_cgroup_group drain_group;
>  +const struct tst_cgroup_group *const tst_cgroup = &test_group;
>
> What about declaring as 'tst_cgroup_test' ? i.e.
>
>     const struct tst_cgroup_group *const tst_cgroup_test = &test_group;
>
> As it is a reference to test's CGroup and the test_dir is the same
> layer with drain_dir, so this will be easier to understand the relationship
> with drain_group.
>
>  +const struct tst_cgroup_group *const tst_cgroup_drain =
>  &drain_group;

I agree with your logic, but the variable name is too long even without
'_test'. Perhaps we could shorten cgroup to cg? However I can submit a
separate patch for that.

>
> The rest part looks quite good.
> Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
