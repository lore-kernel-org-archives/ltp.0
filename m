Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE772C52D70
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 06:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722579237; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=m+ttwu4BnSrtK4OQP3Yovm/mypkfC6guqJmhjReh/Lk=;
 b=qm4Tz+lL4AOfwLOsLWB7R2EwRhd5XRGOQrodmsXsyt3kE8aQsQoiU9xL7OvfAABUScku6
 FR3C4JCRLlm6ff3qgsiibekClrq20jgYKPHeu4uzUv/1FQHQ4VSszCNcWqgRYKgVvJp2e3b
 GXAPmbSJRAGaObGZeao2bUIO2QXo1Jo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EF573D1F35
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 08:13:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC3B63D1E9C
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 08:13:34 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1A8F16008E3
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 08:13:33 +0200 (CEST)
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-5b7b6a30454so1960730a12.2
 for <ltp@lists.linux.it>; Thu, 01 Aug 2024 23:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722579212; x=1723184012; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q/1Z5Rn3gKus7O9I2KHQuzF6OLvb+n+dFqmCow1dkgw=;
 b=LQvOXHU6F28S1W+4neJu3fuS8eH1zis/Z+YWHlMOg7NRbvg7y5RxTDaANKJL/XFJCk
 rBKHDdoze15wjLKHnOMbPCYek56k9y64W3hhjzuOxTttPUaVbZOQdFwAx3CKAfYJNOnN
 pcGN+XeWTYtOFaNDEpBstJejWzbxxJtZqm9mRFQ1wCMVqsPTsfYx1iBtJdqEohL/ZMhj
 6ZfLK0PdgayJ/wgaIAPJ1AMxXYHuLxHRw//H4GiLJywolI93ImVypXygJ9yEEAiyWG6S
 lJA220e2KH8KrWEALpW9tNDgZ7y1I22aogdYKj15ajExTv8eT/o3sEujj2xSsGf/jk73
 QmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722579212; x=1723184012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q/1Z5Rn3gKus7O9I2KHQuzF6OLvb+n+dFqmCow1dkgw=;
 b=nSnHtvBcnZLvSGnsGe4rtqw2hgAw5efaFLV3O7dBNifQNRZrlr5kpNoeL/3Jm4+zZu
 XV1aj4xGl/ZQqOUsMzdXv1BtVbn/mCo21KJA8p8r8cOKU9SnqHh8h6aoqGgeeAcj1HBG
 RiftXhPUgk0CZZKchq9c7eDMwlyDtEpGQFr9SqomLV6GGNjn9C1dM1aPKvcMxait7o5Q
 QzNbmK2U2LNxYcAUK1OcIBUMDFGU7G1oWrjfxoNSFafToWMl7QGvZ9izc4PUcP1NugtL
 r2FqkiV2L0YnU0v1nGbq5OeXjv5xgK/OfK412pZVGcWdK7vIhMTHbnRADbejS6x+tYC5
 clbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9CU+wj9erQEYqlFcwAvi/t4BL8tIpG2GY0uxsVnvAYyPhVfaYk8aYuCLNp54Hihp1VzkAnqVqgN3Z4naBcrAiOdw=
X-Gm-Message-State: AOJu0YyrjFbsCZKtJP6poo+05V+wEZ5U7MryCOLu5lcqxczVrNxEY7qe
 L5+U3q76PpULEaq74+PFRrbJzFBaS1bKl6uqfW4zsx9CJTHcrDkgF7/GVwSdwAI=
X-Google-Smtp-Source: AGHT+IG7b5dSMQLA27l9A8T19BbU96oeHKjPQe7cmcMJyxRw07PCz5+OXnehgoGI+Yz3mYwymImUZA==
X-Received: by 2002:a17:907:9410:b0:a7a:8522:5eec with SMTP id
 a640c23a62f3a-a7dc509fd36mr183494066b.53.1722579211775; 
 Thu, 01 Aug 2024 23:13:31 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d515fesm57847266b.107.2024.08.01.23.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:13:31 -0700 (PDT)
Message-ID: <b0de5bc7-2b94-47cc-9610-fbec1347aecc@suse.com>
Date: Fri, 2 Aug 2024 08:13:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
 <20240801165756.GA1526142@pevik>
 <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
 <20240802054252.GA1582980@pevik>
Content-Language: en-US
In-Reply-To: <20240802054252.GA1582980@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
 =?UTF-8?Q?Ga=C3=ABl_PORTAY?= <gael.portay@rtone.fr>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
 ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 8/2/24 07:42, Petr Vorel wrote:
>> On 2024-08-01, Petr Vorel <pvorel@suse.cz> wrote:
>>> Hi all,
>>>> This is a patch-set that implements fchmodat2() syscall coverage.
>>>> fchmodat2() has been added in kernel 6.6 in order to support
>>>> AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
>>>> There's no man pages yet, so please take the following links as
>>>> main documentation along with kernel source code:
>>> I would hope that it'd be at least Christian's fork [1], but it's not there.
>>> I suppose nobody is working on the man page.
>>>> https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
>>>> https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/
>>>> ***********
>>>> * WARNING *
>>>> ***********
>>>> fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
>>> For a record, it's fchmodat2_01.c (from this patchset) which is failing (on
>>> 6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both x86_64 VMs).
>>> Andrea, I would personally just skip test on EOPNOTSUPP (that's what we do in
>>> LTP on EOPNOTSUPP). The question why is not supported and whether is going to be
>>> fixed.
>>> Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchmod for flags
>>> different than 0 (BZ 26401)") one year old change from glibc-2.39 [2] it looks
>>> just accepted behavior (glibc returns EOPNOTSUPP on symlink):
>>> +  /* Some Linux versions with some file systems can actually
>>> +     change symbolic link permissions via /proc, but this is not
>>> +     intentional, and it gives inconsistent results (e.g., error
>>> +     return despite mode change).  The expected behavior is that
>>> +     symbolic link modes cannot be changed at all, and this check
>>> +     enforces that.  */
>>> +  if (S_ISLNK (st.st_mode))
>>> +    {
>>>         __close_nocancel (pathfd);
>>> -      return ret;
>>> +      __set_errno (EOPNOTSUPP);
>>> +      return -1;
>>> +    }
>>> Also musl also behaves the same on his fallback on old kernels [3]
>>> (it started 10 years ago on 0dc48244 ("work around linux's lack of flags
>>> argument to fchmodat syscall") when SYS_fchmodat was used and kept when this
>>> year SYS_fchmodat2 started to be used in d0ed307e):
>>> 	int ret = __syscall(SYS_fchmodat2, fd, path, mode, flag);
>>> 	if (ret != -ENOSYS) return __syscall_ret(ret);
>>> 	if (flag != AT_SYMLINK_NOFOLLOW)
>>> 		return __syscall_ret(-EINVAL);
>>> 	struct stat st;
>>> 	int fd2;
>>> 	char proc[15+3*sizeof(int)];
>>> 	if (fstatat(fd, path, &st, flag))
>>> 		return -1;
>>> 	if (S_ISLNK(st.st_mode))
>>> 		return __syscall_ret(-EOPNOTSUPP);
>
>>>> According to documentation, the feature has been implemented in
>>>> kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
>>>> on symbolic files. Also kselftests, which are meant to test the
>>>> functionality, are not working and they are treating fchmodat2()
>>>> syscall failure as SKIP. Please take a look at the following code
>>>> before reviewing:
>>>> https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123
>>> I see there is a kselftest workaround in 4859c257d295 ("selftests: Add fchmodat2
>>> selftest") [4], where fchmodat2 failure on symlink is simply skipped.
>>> Aleksa, you're probably aware of this fchmodat2() failure on symlinks. Does
>>> anybody work or plan to work on fixing it? LTP has policy to not cover kernel
>>> bugs, if it's not expected to be working we might just skip the test as well.
>> If I understand the bug report, the issue is that fchmodat2() doesn't
>> work on symlinks?
> Yes.
>
>> This is intentional -- Christian fixed a tree-wide bug a while ago[1]
>> where some filesystems would change the mode of symlinks despite
>> returning an error (usually EOPNOTSUPP) and IIRC a few others would
>> happily change the mode of symlinks.
> Ah, I've seen this in the past. Thanks a lot for reminding me.
>
>> The current intended behaviour is to always return EOPNOTSUPP, and AFAIK
>> there is no plan to re-enable the changing of symlink modes. EOPNOTSUPP
>> was chosen because that's what filesystems were already returning.
>> (While this is a little confusing, VFS syscalls return EINVAL for an
>> unsupported flag, not EOPNOTSUPP.)
>> The benefit of an AT_SYMLINK_NOFOLLOW flag is not just to to allow a
>> syscall to operate on symlinks, it also allows programs to safely
>> operate on path components without worrying about symlinks being
>> followed (this is relevant for container runtimes, where we are
>> operating on untrusted filesystem roots -- though in the case of
>> fchmodat2(2) you would probably just use AT_EMPTY_PATH in practice). So
>> an error here is actually what you want as a program that uses
>> AT_SYMLINK_NOFOLLOW (since the actual operation is intentionally not
>> supported by filesystems).
Thanks for the explanation. I also have a question around this topic: 
AT_SYMLINK_NOFOLLOW has been added in order to avoid symlinks being 
followed. But if filesystems are not supporting it, why do we have this 
feature? Also, is it an unsupported feature only on certain filesystems?
> Thanks a lot for explaining the background!
>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d1f903f75a80daa4dfb3d84e114ec8ecbf29956
>>> I see a RFC UAPI related patchset [5] which touches include/uapi/linux/fcntl.h,
>>> but AFAIK it's not related to this problem.
>> Yeah this is unrelated, that patch is about clarifying how AT_* flags
>> are allocated, not syscall behaviour.
> Thanks!
>
>>> Kind regards,
>>> Petr
> @Andrea, I guess we want something like this:
>
> +++ testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> @@ -43,9 +43,10 @@ static void test_symbolic_link(void)
>   	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
>   	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
>   
> -	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
> -	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
> -	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
> +	if (tst_kvercmp(6, 6, 0) >= 0) {
> +		TST_EXP_FAIL(tst_syscall(__NR_fchmodat2, fd_dir, SNAME, 0640,
> +					 AT_SYMLINK_NOFOLLOW), EOPNOTSUPP);
> +	}
>   }
>   
>   static void test_empty_folder(void)

I think it makes more sense to filter out only filesystems which are not 
supporting this feature (see my comment above).

Best regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
