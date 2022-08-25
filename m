Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EF7ECAA24
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 16:13:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 989713CA44E
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 18:13:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91D893C3090
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 18:13:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9A98160063D
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 18:13:15 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B5D425BD02;
 Thu, 25 Aug 2022 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661443993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JIUYoK7u01HUthXY+td1AYIfyWjr4XL6DgYx7kvQGfw=;
 b=QCp7zHkG7KC0/mTvEWIV2s45F+2WWk8EfW3DwfkIsYzwCpiWZC5XKjviWt1YU+PPzBVL5a
 AFx3VIdF/ZVXYo5wmKBZp/pqvTZrTA9NpjglLx0mXmKo17uwaBh+do+jlsbpMrh9TOZwpM
 jihaFm4mdDtSZNyYq/fGdcZy3uoOYQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661443993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JIUYoK7u01HUthXY+td1AYIfyWjr4XL6DgYx7kvQGfw=;
 b=fgYpMItWKyB0CEXQqzdsRudTFuWVw9yuA2k13WjShkp+/Cn8mgZ/vAxq2sjwF7a8nicWbS
 Tjp2n8hcO3i3KFDA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 825A22C141;
 Thu, 25 Aug 2022 16:13:13 +0000 (UTC)
References: <1660813232-2378-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <1661252479-2363-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1661252479-2363-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <875yig2wuo.fsf@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 25 Aug 2022 17:08:53 +0100
In-reply-to: <875yig2wuo.fsf@suse.de>
Message-ID: <871qt42tev.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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


Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>
>> safe_cg_open is used to open the sub control's file ie cgroup.procs
>> and returns the opened fd number. The opened fd array is stored in
>> fds argument.
>>
>> safe_cg_fchown is used to use fchownat to change file's uid and gid.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>  include/tst_cgroup.h | 44 +++++++++++++++++++++++++++++
>>  lib/tst_cgroup.c     | 66 +++++++++++++++++++++++++++-----------------
>>  2 files changed, 85 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
>> index d06847cc6..70c5b3fd4 100644
>> --- a/include/tst_cgroup.h
>> +++ b/include/tst_cgroup.h
>> @@ -89,6 +89,32 @@ enum tst_cg_ver {
>>  	TST_CG_V2 = 2,
>>  };
>>  
>> +/* Controller sub-systems */
>> +enum cgroup_ctrl_indx {
>> +	CTRL_MEMORY = 1,
>> +	CTRL_CPU,
>> +	CTRL_CPUSET,
>> +	CTRL_IO,
>> +	CTRL_PIDS,
>> +	CTRL_HUGETLB,
>> +	CTRL_CPUACCT,
>> +	CTRL_DEVICES,
>> +	CTRL_FREEZER,
>> +	CTRL_NETCLS,
>> +	CTRL_NETPRIO,
>> +	CTRL_BLKIO,
>> +	CTRL_MISC,
>> +	CTRL_PERFEVENT,
>> +	CTRL_DEBUG
>> +};
>> +
>> +#define CTRLS_MAX CTRL_DEBUG
>> +
>> +/* At most we can have one cgroup V1 tree for each controller and one
>> + * (empty) v2 tree.
>> + */
>> +#define ROOTS_MAX (CTRLS_MAX + 1)
>
> These need TST_CG_ prepending to them to stop name collisions.

Actually, I think the easiest thing to do is not export these. Instead
you could leave these alone and export "#define TST_CG_ROOTS_MAX 32".

The rest of the patch-set looks great.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
