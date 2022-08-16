Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DC1C2BB41
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 08:35:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB9673C98AA
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 10:35:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BD9E3C9413
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 10:35:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2D7E60019B
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 10:35:44 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 991303408F;
 Tue, 16 Aug 2022 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660638943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dNRRaccNEHXoOOky2adhIMxXMz9t8Rugu+J0PLt+pOs=;
 b=GOFk0OyElIpzbEZyjos6UzWM9nhA8XN68h5xLwRjS0SOGtSPvCWKNlrbvaEtULjVFYC/Nc
 SUYvD7oOgjLIcYvrdvfcaPvn0mA1y2Om+7YCJfWkz/1kqKGYdKwZnm/8UjKNL7zGVLr2Aj
 3dnDV1SuTr/5AoSjjwqZQVtGXTfZBOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660638943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dNRRaccNEHXoOOky2adhIMxXMz9t8Rugu+J0PLt+pOs=;
 b=goM9fwKFghOGq0y19xiyLcARv8z/gPhAFV8V9HpVJLVHNIig0DEqnPJdAAMmN+NvXzxWsy
 /dt/ZqyVKtyZ3FDA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 36FB52C143;
 Tue, 16 Aug 2022 08:35:43 +0000 (UTC)
References: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659521981-2241-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87zggks3pe.fsf@suse.de>
 <031f32b2-70fd-8b6d-e2ec-f1d3d1bdcaa5@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Tue, 16 Aug 2022 09:18:32 +0100
In-reply-to: <031f32b2-70fd-8b6d-e2ec-f1d3d1bdcaa5@fujitsu.com>
Message-ID: <87fshwlh5t.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

"xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:

> Hi Richard
>> Hello,
>> 
>> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>> 
>>> safe_cg_open is used to open the sub control's file ie cgroup.procs
>>> and returns the fd.
>>>
>>> safe_cg_fchown is used to use fchownat to change file's uid and gid.
>>>
>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> ---
>>>   include/tst_cgroup.h | 15 +++++++++++++++
>>>   lib/tst_cgroup.c     | 39 +++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 54 insertions(+)
>>>
>>> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
>>> index d06847cc6..292c9baa4 100644
>>> --- a/include/tst_cgroup.h
>>> +++ b/include/tst_cgroup.h
>>> @@ -188,6 +188,21 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
>>>   			 char *const out, const size_t len)
>>>   			 __attribute__ ((nonnull));
>>>   
>>> +#define SAFE_CG_OPEN(cg, file_name, flags)			\
>>> +	safe_cg_open(__FILE__, __LINE__, (cg), (file_name), (flags))
>>> +
>>> +int safe_cg_open(const char *const file, const int lineno,
>>> +		 const struct tst_cg_group *const cg,
>>> +		 const char *const file_name, int flags);
>>> +
>>> +#define SAFE_CG_FCHOWN(cg, file_name, owner, group)		\
>>> +	safe_cg_fchown(__FILE__, __LINE__,			\
>>> +			   (cg), (file_name), (owner), (group))
>>> +
>>> +void safe_cg_fchown(const char *const file, const int lineno,
>>> +		    const struct tst_cg_group *const cg,
>>> +		    const char *const file_name, uid_t owner, gid_t group);
>>> +
>>>   #define SAFE_CG_PRINTF(cg, file_name, fmt, ...)			\
>>>   	safe_cg_printf(__FILE__, __LINE__,				\
>>>   			   (cg), (file_name), (fmt), __VA_ARGS__)
>>> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
>>> index 1cfd79243..dedc0f65b 100644
>>> --- a/lib/tst_cgroup.c
>>> +++ b/lib/tst_cgroup.c
>>> @@ -1297,6 +1297,45 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
>>>   	return read_ret;
>>>   }
>>>   
>>> +int safe_cg_open(const char *const file, const int lineno,
>>> +			const struct tst_cg_group *cg,
>>> +			const char *const file_name, int flags)
>>> +{
>>> +	const struct cgroup_file *const cfile =
>>> +		cgroup_file_find(file, lineno, file_name);
>>> +	struct cgroup_dir *const *dir;
>>> +	const char *alias;
>>> +	int fd;
>>> +
>>> +	for_each_dir(cg, cfile->ctrl_indx, dir) {
>>> +		alias = cgroup_file_alias(cfile, *dir);
>>> +		if (!alias)
>>> +			continue;
>>> +
>>> +		fd = safe_openat(file, lineno, (*dir)->dir_fd, alias,
>>> flags);
>> 
>> This will only return the last fd that gets opened. That's OK if the
>> file only exists on a single V1 controller, but if it exists on multiple
>> controllers (e.g. any cgroup.* file) then we will open multiple files
>> and only return the fd for the last of them.
>
> Sorry for the late reply. I just copy these code from safe_cg_printf.
> So safe_cg_printf have the same situation that write value to muliple 
> files under the created cgroup directory.
>
> So what should we do? Add a fd arrat member in  cgroup_file  struct?

I'm not sure what you mean, but I can see a few options.

1. Pass a pointer to a function which takes the fd, for e.g.

safe_cg_open(..., void (*const on_open)(int fd))
{
        ...
        for_each_dir(...) {
            ...
            fd = safe_openat(...);
            on_open(fd);
            close(fd);
        }
        ...
}

2. Allocate and return an array of open fd's
3. Pass an array as large as the maximum number controllers which is
   populated with open fd's.

Which option to pick I think depends on what results in the simplest
test code.

>
> Best Regards
> Yang Xu
>
>> 


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
