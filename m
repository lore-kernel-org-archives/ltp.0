Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DC4C52D54
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722585528; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=SPT/GZYOP0e/js2kDF2nk7lz02rArRjLZgNtRfvCRwc=;
 b=Y4fXcfcgC3yFIvhcKZe/4M1wENmFmB9oJ527le+CrzE6glllUEYlHhxdQFNXN/1p/LMjE
 lhpN1KrAQ8LBipgWwUVYRusm/580ooe4GgE0r0RUknGAH+nxaOGZJQyEwLfQQcDcn83MAiA
 qwxxHO/FINO3Ltify+TfAc0IW8eGRyM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2108F3D1F1C
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 09:58:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D6B03D1D69
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 09:58:26 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 754C81A01169
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 09:58:25 +0200 (CEST)
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-36887ca3da2so3630019f8f.2
 for <ltp@lists.linux.it>; Fri, 02 Aug 2024 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722585505; x=1723190305; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FD9R99ybC/DMsbNQ/rxFayZFlcWsSwSls1oRsOgDDl4=;
 b=YQ1dxTpKPPevRbTtY8SRHnwAl1pI3+lht1+Z4G2v6YRPkoQuL/u5bbUVnckgcVRNzG
 NvYnSWbUVjZJslAl9RWZoIfxyDuin9GC6kJvW/clD/GXVtyIyTHIOJpZYIDnDVQ+BI9g
 OEH69hJL7hVhMozsz6egTFCQKqq3jbfkxaxGw1XlUU7yzLpCdA4zrxkmfUr7YuR+9e9v
 TAzLF+nkpsBhwMhltdlNUjC4wh4t2HpnAt/Xek8Si0nE+AXAGvTcY17ZMpI3LpX4aujY
 nJb/GIm47dDrPMpUqDswbBWcdzJDJM7+WPUFZ02rSXivaU5OiJOaGJ4JnyoI3BpdzSLh
 9TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722585505; x=1723190305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FD9R99ybC/DMsbNQ/rxFayZFlcWsSwSls1oRsOgDDl4=;
 b=KNm25Jm/349CLpS7lFNvQKMZw4ZlEroGY6eCXcgujIYDVQitx4PQ5lARmZXtjgozlT
 HeR0+FYm7QZ/iHaNTtQhc/EHydEEvjGO0a2GQgLKRVOqvuI0Ghe7kyHOOslD2pfuEFFO
 KGDYL3Jm8ttRY6hBF2KRbcemJkdiGvKWyKXDfYVm6xtDQvlQ4v7IuV6nSN+nReycHG0W
 PS5DNT2Gtki+5AKEyuw0R1VhUfs5GlGzRDx17i7/nTAP5X6EbFa9oJP4HwKdwP/zLPXp
 e5ZDbL8G6M55MCai6wj/VAXTP4FJSdMmfE5hTbuxsxSMimJ0R9D6fn8g9sIdXcElY1t+
 VXPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW38deLRJcvsun2y1txiLzF2HgxJ/dZfHMf8LeC6wy6LpJp+Apc2kBrTQIlnjjs1DzzcG1E9gG6CUR3Qc8Kwe6U65Y=
X-Gm-Message-State: AOJu0YzKi5xw6xBrXS628zvdMkfqQNIRwzyldUQdmBdZgVEpmcXy31EF
 /33xgBBmt0ZOJ5gT57IYarKOipiWVEkG5s8cjR7s9kaz1KzjtNxb8yus/VB5sJw=
X-Google-Smtp-Source: AGHT+IEmOL2nniedOG75wzDqiUBVdguoVwPD1B+InPRrABQRIUx1D8nOPXkDqFaP0l/O8hEPdBL+qw==
X-Received: by 2002:a05:6000:1fa2:b0:368:7ee2:b7c8 with SMTP id
 ffacd0b85a97d-36bbc0e6721mr1658442f8f.1.1722585504181; 
 Fri, 02 Aug 2024 00:58:24 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cbdbsm1301380f8f.13.2024.08.02.00.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 00:58:23 -0700 (PDT)
Message-ID: <bedfd109-8848-43a8-8bf5-6ef3f1334f1c@suse.com>
Date: Fri, 2 Aug 2024 09:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
 <20240801165756.GA1526142@pevik>
 <20240802.011554-broke.flocks.valiant.camp-sk9TjsxvPYf@cyphar.com>
 <20240802054252.GA1582980@pevik>
 <b0de5bc7-2b94-47cc-9610-fbec1347aecc@suse.com>
 <20240802074948.GA1595727@pevik>
Content-Language: en-US
In-Reply-To: <20240802074948.GA1595727@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
 linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
 Alexey Gladkov <legion@kernel.org>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 8/2/24 09:49, Petr Vorel wrote:
>> Hi!
>> On 8/2/24 07:42, Petr Vorel wrote:
>>>> On 2024-08-01, Petr Vorel <pvorel@suse.cz> wrote:
>>>>> Hi all,
>>>>>> This is a patch-set that implements fchmodat2() syscall coverage.
>>>>>> fchmodat2() has been added in kernel 6.6 in order to support
>>>>>> AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
>>>>>> There's no man pages yet, so please take the following links as
>>>>>> main documentation along with kernel source code:
>>>>> I would hope that it'd be at least Christian's fork [1], but it's not there.
>>>>> I suppose nobody is working on the man page.
>>>>>> https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
>>>>>> https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/
>>>>>> ***********
>>>>>> * WARNING *
>>>>>> ***********
>>>>>> fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
>>>>> For a record, it's fchmodat2_01.c (from this patchset) which is failing (on
>>>>> 6.10.1-1.g4c78d6f-default Tumbleweed and 6.6.21-0-lts Alpine, both x86_64 VMs).
>>>>> Andrea, I would personally just skip test on EOPNOTSUPP (that's what we do in
>>>>> LTP on EOPNOTSUPP). The question why is not supported and whether is going to be
>>>>> fixed.
>>>>> Looking into glibc change 65341f7bbe ("linux: Use fchmodat2 on fchmod for flags
>>>>> different than 0 (BZ 26401)") one year old change from glibc-2.39 [2] it looks
>>>>> just accepted behavior (glibc returns EOPNOTSUPP on symlink):
>>>>> +  /* Some Linux versions with some file systems can actually
>>>>> +     change symbolic link permissions via /proc, but this is not
>>>>> +     intentional, and it gives inconsistent results (e.g., error
>>>>> +     return despite mode change).  The expected behavior is that
>>>>> +     symbolic link modes cannot be changed at all, and this check
>>>>> +     enforces that.  */
>>>>> +  if (S_ISLNK (st.st_mode))
>>>>> +    {
>>>>>          __close_nocancel (pathfd);
>>>>> -      return ret;
>>>>> +      __set_errno (EOPNOTSUPP);
>>>>> +      return -1;
>>>>> +    }
>>>>> Also musl also behaves the same on his fallback on old kernels [3]
>>>>> (it started 10 years ago on 0dc48244 ("work around linux's lack of flags
>>>>> argument to fchmodat syscall") when SYS_fchmodat was used and kept when this
>>>>> year SYS_fchmodat2 started to be used in d0ed307e):
>>>>> 	int ret = __syscall(SYS_fchmodat2, fd, path, mode, flag);
>>>>> 	if (ret != -ENOSYS) return __syscall_ret(ret);
>>>>> 	if (flag != AT_SYMLINK_NOFOLLOW)
>>>>> 		return __syscall_ret(-EINVAL);
>>>>> 	struct stat st;
>>>>> 	int fd2;
>>>>> 	char proc[15+3*sizeof(int)];
>>>>> 	if (fstatat(fd, path, &st, flag))
>>>>> 		return -1;
>>>>> 	if (S_ISLNK(st.st_mode))
>>>>> 		return __syscall_ret(-EOPNOTSUPP);
>>>>>> According to documentation, the feature has been implemented in
>>>>>> kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
>>>>>> on symbolic files. Also kselftests, which are meant to test the
>>>>>> functionality, are not working and they are treating fchmodat2()
>>>>>> syscall failure as SKIP. Please take a look at the following code
>>>>>> before reviewing:
>>>>>> https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123
>>>>> I see there is a kselftest workaround in 4859c257d295 ("selftests: Add fchmodat2
>>>>> selftest") [4], where fchmodat2 failure on symlink is simply skipped.
>>>>> Aleksa, you're probably aware of this fchmodat2() failure on symlinks. Does
>>>>> anybody work or plan to work on fixing it? LTP has policy to not cover kernel
>>>>> bugs, if it's not expected to be working we might just skip the test as well.
>>>> If I understand the bug report, the issue is that fchmodat2() doesn't
>>>> work on symlinks?
>>> Yes.
>>>> This is intentional -- Christian fixed a tree-wide bug a while ago[1]
>>>> where some filesystems would change the mode of symlinks despite
>>>> returning an error (usually EOPNOTSUPP) and IIRC a few others would
>>>> happily change the mode of symlinks.
>>> Ah, I've seen this in the past. Thanks a lot for reminding me.
>>>> The current intended behaviour is to always return EOPNOTSUPP, and AFAIK
>>>> there is no plan to re-enable the changing of symlink modes. EOPNOTSUPP
>>>> was chosen because that's what filesystems were already returning.
>>>> (While this is a little confusing, VFS syscalls return EINVAL for an
>>>> unsupported flag, not EOPNOTSUPP.)
>>>> The benefit of an AT_SYMLINK_NOFOLLOW flag is not just to to allow a
>>>> syscall to operate on symlinks, it also allows programs to safely
>>>> operate on path components without worrying about symlinks being
>>>> followed (this is relevant for container runtimes, where we are
>>>> operating on untrusted filesystem roots -- though in the case of
>>>> fchmodat2(2) you would probably just use AT_EMPTY_PATH in practice). So
>>>> an error here is actually what you want as a program that uses
>>>> AT_SYMLINK_NOFOLLOW (since the actual operation is intentionally not
>>>> supported by filesystems).
>> Thanks for the explanation. I also have a question around this topic:
>> AT_SYMLINK_NOFOLLOW has been added in order to avoid symlinks being
>> followed. But if filesystems are not supporting it, why do we have this
>> feature?
> @Aleksa please correct me if I'm wrong.
>
> AFAIK (reading 5d1f903f75a8 commit message [1] and Aleksa's comments) previously
> it was an idea which many of the filesystem implemented wrongly - a mess
> regardless whether supported by the filesystem or not. I particularly like
> changing the mode but fail EOPNOTSUPP. And because glibc and musl did EOPNOTSUPP
> anyway (I found that as well), the best was just to follow this in kernel and
> unify all filesystems behavior by disabling this in VFS.
>
>> Also, is it an unsupported feature only on certain filesystems?
> Disabled in VFS => unsupported on all filesystems.
Ah right, that's quite obvious indeed.
>>> Thanks a lot for explaining the background!
>>>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d1f903f75a80daa4dfb3d84e114ec8ecbf29956
>>>>> I see a RFC UAPI related patchset [5] which touches include/uapi/linux/fcntl.h,
>>>>> but AFAIK it's not related to this problem.
>>>> Yeah this is unrelated, that patch is about clarifying how AT_* flags
>>>> are allocated, not syscall behaviour.
>>> Thanks!
>>>>> Kind regards,
>>>>> Petr
>>> @Andrea, I guess we want something like this:
>>> +++ testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
>>> @@ -43,9 +43,10 @@ static void test_symbolic_link(void)
>>>    	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
>>>    	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
>>> -	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
>>> -	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
>>> -	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
>>> +	if (tst_kvercmp(6, 6, 0) >= 0) {
>>> +		TST_EXP_FAIL(tst_syscall(__NR_fchmodat2, fd_dir, SNAME, 0640,
>>> +					 AT_SYMLINK_NOFOLLOW), EOPNOTSUPP);
>>> +	}
>>>    }
>>>    static void test_empty_folder(void)
>> I think it makes more sense to filter out only filesystems which are not
>> supporting this feature (see my comment above).
> Due disabled in VFS since 5d1f903f75a8 all filesystems fail with EOPNOTSUPP,
> thus failure in LTP (TBROK), which needs to be handled.  Before 5d1f903f75a8
> some of them actually changed the mode (e.g. btrfs, ext4, xfs), but that's no
> longer the case. And because it got backported to all stable/LTS, we can expect
> this is the correct behavior.
>
> Kind regards,
> Petr
>
>> Best regards,
>> Andrea

I guess we can just assume EOPNOTSUPP for the test. I will add the .tag 
and errno check.

Thanks,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
