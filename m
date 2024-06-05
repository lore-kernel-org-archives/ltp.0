Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CDEC27C52
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 07:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717574135; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=AGesa7xsL2bzcLqd3jiz/0X8NtAHwmwxCr5IlkzaHWA=;
 b=DW6UAOV5U5lLR263OgFBGSFesJalPwc12QFaEkojIINXNRJqyqaRfIuCqSLqQn7q4IYKP
 us5AvJe3jc3Njg/1HZtmqZTXnU1TWOE6dSgXhvaeYR2J2uud2akBXbRkgXvFle8bY8U9O+Z
 3qIMng9jIDX44Np/tv+PUZmqQnRU6jE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D673D096F
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 09:55:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 215323D094E
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 09:55:13 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D497760DDCA
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 09:55:12 +0200 (CEST)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e724bc466fso75733811fa.3
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717574112; x=1718178912; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JoNgxIRqlPeFIBkgU71u0Hr59ln8YHxoJs71MTcqZhs=;
 b=hC7Z4QEFaos6cOOM0OJseU63WNtfvv7hPXsC30vlDxdZdunjo6IrDP87KZ2kq1b4v9
 HQyLdlZQ981/Z3QG+TLyUu0+QgyGVabWEpiWosK9iL8elMDjr/aG/TVodlsC4RH9iKUo
 yF9Txx//DXEyb9qMMX96SH8Fp3Y3CAb8rITnaDL0gxHA+tPNx4ste4vrX2sILXEyOAMR
 lxTarfHK0+8EES1zTi2GDhxRjccudACUqmHZhdiQBjA8LbxDZcWTBsLf24MsUOj6rg1j
 jsWtFSO8lENVI3++1Bh/1Voi9CzQs/tN2+7F2JlDOBiZ2L+vN0NnNjtQuFY64SZJuXpv
 sLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717574112; x=1718178912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JoNgxIRqlPeFIBkgU71u0Hr59ln8YHxoJs71MTcqZhs=;
 b=JjbN5KMpdF8m9NU1XC896MXkBMlBf2QV51YYGz8178cyzKjTur9HQ9AEp7PWY1wbtT
 DWwlvQ+aBGMeUVKLORrxrHBikiA6Ajc+l7QQuZYayAuZQ27OfN0uKcdV9YbbP8WYax+2
 f7wuka77/GIjdiD9wd6GOzui4lK/dXV2cFVLiO8jk+6aw30a9YnGWWKLMhUY2A7FPJFk
 rGsv8jaRv8+SuVuWOI6r76VFhZyafyaGGzoABNb0rumP3BUr40PfflBB+deFIRwUADTb
 ZqUGUG6/pQtdAOp7chxRRN/veCl35X4VF9FwuMnxOs4xjMJ3FidO+XiD/mUsRsG2sLQL
 tFPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8x8hOuOiuoW9QcwAa14aTsA/kGkvdFsGpK7/Njvp0nQ2m8wWV3yUMyGFTLunS6/MLpTQvj0ApcVkS6tYhWp3uM8k=
X-Gm-Message-State: AOJu0Yy8jpfSJTNoBGSoN3HjR+0irnNsaQWoqd/HfPUcEoxTUmRCU3WT
 IvczHrGoKGQhTIF2TxPGzhp6BYocnD9gkpwHDgDjOuyzSYt8C3Oo2ELp2iLd+VM=
X-Google-Smtp-Source: AGHT+IGKx75clFiZATNhO8UcTkBmkgwXv+v3lftbuNVv2K0galvwc5GnjbNU9Vf5M5P4//qe5rHvJg==
X-Received: by 2002:a05:651c:88:b0:2ea:7f2f:d374 with SMTP id
 38308e7fff4ca-2eac7a0f8d4mr11146191fa.29.1717574111943; 
 Wed, 05 Jun 2024 00:55:11 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.36.118])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70244900ee9sm7805010b3a.124.2024.06.05.00.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 00:55:11 -0700 (PDT)
Message-ID: <fef1d74f-897e-41b9-adca-92bd2b51416a@suse.com>
Date: Wed, 5 Jun 2024 09:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>, 
 Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it,
 Avinesh Kumar <akumar@suse.de>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <20240605065755.GB348321@pevik> <20240605073806.GA355314@pevik>
Content-Language: en-US
In-Reply-To: <20240605073806.GA355314@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 6/5/24 09:38, Petr Vorel wrote:
> Hi all,
>
> [ Cc the test author more experienced maintainers ]
>
>> Hi Andrea,
>>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>> This patch will fix unlink09 test by checking for filesystems which
>>> are not supporting inode attributes.
>>> Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
>>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>>> ---
>>> This will fix the 2cf78f47a6 and resolve issues on filesystems
>>> which are not supporting inode attributes.
>>> ---
>>>   testcases/kernel/syscalls/unlink/unlink09.c | 38 +++++++++++++++++++----------
>>>   1 file changed, 25 insertions(+), 13 deletions(-)
>>> diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
>>> index cc4b4a07e..ed6f0adc3 100644
>>> --- a/testcases/kernel/syscalls/unlink/unlink09.c
>>> +++ b/testcases/kernel/syscalls/unlink/unlink09.c
>>> @@ -11,6 +11,8 @@
>>>    *
>>>    * - EPERM when target file is marked as immutable or append-only
>>>    * - EROFS when target file is on a read-only filesystem.
>>> + *
>>> + * Test won't be executed if inode attributes are not supported.
>> While this is good, wouldn't be better to use approach from Avinesh to add
>> O_RDWR (or whatever flag) to get test supported everywhere instead of skip?
>> https://patchwork.ozlabs.org/project/ltp/patch/20240603124653.31967-1-akumar@suse.de/
> OK, I got hint from Andrea, that this is inspired by statx04.c:86, which is
> filtering vfat and exfat. Here the problem was on system which has tmpfs, but
> just more strict default setup (likely umask). Therefore I still think that
> approach from Avinesh is correct.
statx04.c:86 is an example of what LTP tests do: they check if a feature 
is available or not in the specific environment.
In our case, we need to skip filesystems which are not supporting inode 
attributes, due to the usage of ioctl(FS_IOC_GETFLAGS). And this is what
unlink09 does in my patch.

The Avinesh approach only changes flags for open(), which is still ok, 
but not enough and probably SAFE_CREAT() is better in our case.
But if FS doesn't support inode attributes, test fails generating noise 
that requires debugging on the system as well, just to understand if 
there's a bug or not.

And this is (of course) something that we would like to avoid...

> BTW shouldn't this test use .all_filesystems = 1 ? Or is it unlink() really VFS
> only code? I see some specific functions in fs/*/, e.g. btrfs_unlink() or
> ext4_unlink(), which are used for struct inode_operations unlink member.
> Then, obviously also Andrea's check would be needed (otherwise is unlikely that
> somebody would have TMPDIR on vfat or exfat).
>
> Kind regards,
> Petr
>
>>>    */
>>>   #include <sys/ioctl.h>
>>> @@ -22,8 +24,8 @@
>>>   #define DIR_EROFS "erofs"
>>>   #define TEST_EROFS "erofs/test_erofs"
>>> -static int fd_immutable;
>>> -static int fd_append_only;
>>> +static int fd_immutable = -1;
>>> +static int fd_append_only = -1;
>>>   static struct test_case_t {
>>>   	char *filename;
>>> @@ -43,12 +45,18 @@ static void setup(void)
>>>   {
>>>   	int attr;
>>> -	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
>>> -	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
>>> +	fd_immutable = SAFE_CREAT(TEST_EPERM_IMMUTABLE, 0600);
>>> +	TEST(ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr));
>>> +
>>> +	if (TST_RET == -1 && TST_ERR == ENOTTY) {
>>> +		SAFE_CLOSE(fd_immutable);
>>> +		tst_brk(TCONF | TTERRNO, "Inode attributes not supported");
>>> +	}
>>> +
>>>   	attr |= FS_IMMUTABLE_FL;
>>>   	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
>>> -	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
>>> +	fd_append_only = SAFE_CREAT(TEST_EPERM_APPEND_ONLY, 0600);
>>>   	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
>>>   	attr |= FS_APPEND_FL;
>>>   	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
>>> @@ -58,15 +66,19 @@ static void cleanup(void)
>>>   {
>>>   	int attr;
>>> -	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
>>> -	attr &= ~FS_IMMUTABLE_FL;
>>> -	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
>>> -	SAFE_CLOSE(fd_immutable);
>>> +	if (fd_immutable != -1) {
>> I thought we could return when fd_immutable == -1:
>> 	if (fd_immutable != -1)
>> 		return;
>> But obviously this is can be also result of the first test (not only by the
>> setup), thus you're correct.
>> BTW verify_unlink() could be made simpler to return on if (TST_RET).
>>> +		SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
>>> +		attr &= ~FS_IMMUTABLE_FL;
>>> +		SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
>>> +		SAFE_CLOSE(fd_immutable);
>>> +	}
>>> -	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
>>> -	attr &= ~FS_APPEND_FL;
>>> -	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
>>> -	SAFE_CLOSE(fd_append_only);
>>> +	if (fd_append_only != -1) {
>>> +		SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
>>> +		attr &= ~FS_APPEND_FL;
>>> +		SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
>>> +		SAFE_CLOSE(fd_append_only);
>>> +	}
>> Am I mistaken that this check should have been added before?
>>>   }
>>>   static void verify_unlink(unsigned int i)
>>> ---
>>> base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
>> I see useful b4 feature :).
>>> change-id: 20240604-unlink09-dc4802f872f9
>> But I wonder what is this for (what tool use change-id).
>> Kind regards,
>> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
