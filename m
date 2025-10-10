Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CE1CCD185
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 11:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760094373; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=j7zRizZc4G0WIhOelPiOsw6m5t5+a1nqngZellpG6Yo=;
 b=BN5xTgsFsBH30zvrR559e8EUw59C2rvXe5Q9sd/VTKf4jwTtD9VJO1vQNCYldJsqLR6zS
 uhw1cK1fy9iFWn/wO8MPJhD7QmJdKOvee9vFT2n7QLamUd/C50+e14qG5s5vcxvIj9X0DE+
 pdJ7e02yQDVFeiMSGTVaQfweJsXfeaE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D19F33CE9C5
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 13:06:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96A663CE966
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 13:05:52 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED1F6100053A
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 13:05:51 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so10577925e9.2
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760094351; x=1760699151; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWIAiEZWHmqwWARRE++RSuUIjxmjjnRgIPBXq/RI+lM=;
 b=fFdytSmsKbmVAu7iKKwKkObbtgpZ39WPBEG9Qvf5cZRrc2dbVuxsXV2Va8PTxG1iDz
 N/NsMXJJpZh8H/+mkxyPGVxXWAYN9rjJnHjfd+eS6BAGyo8VDU0AFLphSWnRuySbRezy
 rIDtHlrlzwrVFodX+GTJim4zLqS5mTmXm428x4XPNbz658TYyn0oH5YvzeqL5ky/NU7u
 GhZh+vs8IiRvSy6TnlhmKf03VoI6jqMGsV4OpzSy0AZonSZOEKb2o7KGsxaQogLjq3N4
 YkV9bhtrzc0zjyIZRKCbig2nSssEhy1i31rVnYEwjcVAxeYwuv5QfnVeHt2F+wFEpljs
 jotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094351; x=1760699151;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MWIAiEZWHmqwWARRE++RSuUIjxmjjnRgIPBXq/RI+lM=;
 b=kS7nv5S8xA/fcAQI9c+2EG5htoIe1/qHxRW+Rt+7eKjm8VHAbTp9/JdSLLM5KoBnVo
 3qEqMwTJQSICft0MYgVxwU26Dug1Jc65S/nPQkughL3nsS71onxkgewmXDBezxJOXkAJ
 Y8djXm1n53nffKrJfQ8vcL/Uev4pQ9GTD7GPT74cThFvMoiNp8iyokJN85qTK2cYp+9t
 OwC+Nn6V0G0npiqiIFqj+7+nLZTkG691jTAjncwEnv2V1oC3xOZuNMzU1zLI9kRgbJVb
 zZ6cqS8Cf3gE0QphD+BGzVq07w0ODUdE1+qyFpYuBT485z7PUM9nMP8ekHfjhmZVATgr
 vIzQ==
X-Gm-Message-State: AOJu0YxUKbqqNkwDboJymC9Eo7ow225BYflmaUamsWW6YM6IE2/mkQ5Q
 fk8N82i9j04TQHwFN1Akgrry9f3UZGAmcLrYFooxCJ5zr1qNTiV1AihDi4yXKaastPk=
X-Gm-Gg: ASbGncsM7oJhhtxMl72PQmuMi4ukXjcWivIhe9Nc1ZO9MnQvF5G+xQlnPmOuPPkdf26
 9sPMJTPwl3tCyqImR/n/dl3+rRpNm0ncsf1BWz4Lwf6fussIGoWbFTMyhjwm81vRbMBzXkqcfcd
 IN/sLaYmcqk3vv2lGMfCxI9FAkob54BQB2lzOfqZlcbWqwbNU011HAcsMrUHK2rJC5lRjTIhc6s
 9lglqautYBtJFNScdqhO4yWGEErE8aNEjLKl3vqDCO2gnFZUg73ndrUOdUkh4PtnDxC/voUop+n
 HAot5zbszj/aMHXpBDh6Yp41H5hhg2axT+akiDkZNWbJkooOeHQC38KAl8KfPbVHIV4FSrr+RZ1
 BgTCgver5xFZ86JzFLCXL2J96RertGVIwJd36kT01H8Uga9WzQFPq61/YpKA0B9XRc6CNUICb+P
 oy7oxdDVwe1KqrlYH9Afq+w8MkiNkNHsjqMbKCZpSHZRUJ3w==
X-Google-Smtp-Source: AGHT+IHRfnjHGaiAtYbB3LhJ6oRvYFr2bhl/bI/Ldu43eMY4/vO+3SWKvS2kL2aXSGcKl9kXFcl5Ng==
X-Received: by 2002:a05:600c:3548:b0:45b:4a98:91cf with SMTP id
 5b1f17b1804b1-46fa9aa24b3mr78111835e9.15.1760094351247; 
 Fri, 10 Oct 2025 04:05:51 -0700 (PDT)
Received: from localhost
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49c4027sm39311555e9.17.2025.10.10.04.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 04:05:50 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 10 Oct 2025 13:05:50 +0200
Message-Id: <DDELDHZA33UZ.1OOCM2J6AC6I7@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.21.0
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-10-bf458fa66358@suse.com> <aOY20kqNr9kZAPuY@yuki.lan>
In-Reply-To: <aOY20kqNr9kZAPuY@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 10/10] Add setxattrat02 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Wed Oct 8, 2025 at 12:02 PM CEST, Cyril Hrubis wrote:
> Hi!
>> +} tcases[] = {
>> +	{
>> +		.dfd = &invalid_fd,
>> +		.args = &args,
>> +		.args_size = sizeof(struct xattr_args),
>> +		.exp_errno = EBADF,
>> +		.reason = "Invalid directory file descriptor",
>> +	},
>
> Maybe it would make sense to use tst_fd to hammer the syscall with all
> kinds of strange file descriptors.
>

This makes sense for a new test, in this test it's better to keep this
approach.

>> +	{
>> +		.dfd = &tmpdir_fd,
>> +		.at_flags = -1,
>> +		.args = &args,
>> +		.args_size = sizeof(struct xattr_args),
>> +		.exp_errno = EINVAL,
>> +		.reason = "Invalid AT flags",
>> +	},
>> +	{
>> +		.dfd = &tmpdir_fd,
>> +		.at_flags = AT_SYMLINK_NOFOLLOW + 1,
>> +		.args = &args,
>> +		.args_size = sizeof(struct xattr_args),
>> +		.exp_errno = EINVAL,
>> +		.reason = "Out of bound AT flags",
>> +	},
>> +	{
>> +		.dfd = &tmpdir_fd,
>> +		.args = &null_args,
>> +		.args_size = sizeof(struct xattr_args),
>> +		.exp_errno = EINVAL,
>> +		.reason = "Invalid arguments",
>> +	},
>> +	{
>> +		.dfd = &tmpdir_fd,
>> +		.args = &args,
>> +		.args_size = SIZE_MAX,
>> +		.exp_errno = E2BIG,
>> +		.reason = "Arguments size is too big",
>> +	},
>> +	{
>> +		.dfd = &tmpdir_fd,
>> +		.args = &args,
>> +		.args_size = sizeof(struct xattr_args) - 1,
>> +		.exp_errno = EINVAL,
>> +		.reason = "Invalid arguments size",
>> +	},
>> +};
>> +
>> +static void run(unsigned int i)
>> +{
>> +	struct tcase *tc = &tcases[i];
>> +
>> +	args->flags = XATTR_CREATE;
>> +	args->value = (uint64_t)XATTR_TEST_VALUE;
>> +	args->size = XATTR_TEST_VALUE_SIZE;
>> +
>> +	TST_EXP_FAIL(tst_syscall(__NR_setxattrat,
>> +		tc->dfd, FNAME, tc->at_flags, XATTR_TEST_KEY,
>> +		tc->args, tc->args_size),
>> +		tc->exp_errno, "%s", tc->reason);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	char *tmpdir;
>> +
>> +	tmpdir = tst_tmpdir_path();
>> +	tmpdir_fd = SAFE_OPEN(tmpdir, O_DIRECTORY);
>
> Here as well, just use AT_FDCWD.
>

Ok.

>> +	SAFE_TOUCH(FNAME, 0777, NULL);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (tmpdir_fd != -1)
>> +		SAFE_CLOSE(tmpdir_fd);
>> +
>> +	SAFE_UNLINK(FNAME);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.needs_root = 1,
>> +	.needs_tmpdir = 1,
>> +	.bufs = (struct tst_buffers []) {
>> +		{&args, .size = sizeof(struct xattr_args)},
>> +		{},
>> +	}
>> +};
>> 
>> -- 
>> 2.51.0
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp




-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
