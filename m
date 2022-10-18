Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF2EC4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 08:46:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD2BD3CB031
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 10:46:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AD4E3C93EF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:46:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC77B1000944
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:46:06 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5316B33E78;
 Tue, 18 Oct 2022 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666082765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGs0lFH9m0TMWyR+jNJvrG22U4rMxaYDnHGrt1Goy7o=;
 b=SsusZb8yiz6giA9fH6h+qqOKi13UmjKQkdef6OhkVWXL8hjvIk9Dv/tkIhrfEmceGktKqy
 N+8tvnGTSUSR9aDDC+obvF2t4p3t/2R7HunCA0N0b7SByfXR3Kc7bs6WOqSouDrUPTiaBp
 XMsVC5aTowv2J1SgbTtWt8FmWQU+kiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666082765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGs0lFH9m0TMWyR+jNJvrG22U4rMxaYDnHGrt1Goy7o=;
 b=kbO4HijK7t43ybwG+UimRwNirNrQmJf56k7pzwZ0l4sqIDjKAtNRgd3SKovwygMILPf3A2
 u7Dq5TUuCeL2DSDg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 658C82C141;
 Tue, 18 Oct 2022 08:46:04 +0000 (UTC)
References: <20220822155413.24814-1-pvorel@suse.cz> <YwO3qbIO32hvryjw@pevik>
 <bc8d2cb9-e5d9-3284-13e2-acfea09725c2@fujitsu.com>
 <87y1tkx84j.fsf@suse.de>
 <8305046c-8a3d-fe6d-f587-67e8b2c172b5@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Tue, 18 Oct 2022 09:44:45 +0100
In-reply-to: <8305046c-8a3d-fe6d-f587-67e8b2c172b5@fujitsu.com>
Message-ID: <87fsflmsdx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] mount03: Convert to new API
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

> Hi Richard, Petr
>
>> 
>> "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:
>> 
>>> Hi Petr
>>>
>>>> Hi all,
>>>>
>>>> when running in loop, I sometimes still get error:
>>>>
>>>> i=0; while true; do i=$((i+1)); echo "== $i =="; ./mount03  || break; done
>>>> ...
>>>> === 100 ===
>>>> ...
>>>> tst_device.c:434: TINFO: No device is mounted at mntpoint
>>>> tst_test.c:1599: TINFO: Testing on ext4
>>>> tst_test.c:1065: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
>>>> mke2fs 1.46.5 (30-Dec-2021)
>>>> mount03.c:150: TINFO: Testing flag MS_RDONLY
>>>> mount03.c:48: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
>>>> mount03.c:150: TINFO: Testing flag MS_NODEV
>>>> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
>>>> mount03.c:150: TINFO: Testing flag MS_NOEXEC
>>>> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
>>>> mount03.c:150: TINFO: Testing flag MS_RDONLY
>>>> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
>>>> mount03.c:150: TINFO: Testing flag MS_NOSUID
>>>> mount03.c:153: TFAIL: mount(tst_device->dev, MNTPOINT, tst_device->fs_type, tc->flag, NULL) failed: EINVAL (22)
>>>> mount03.c:150: TINFO: Testing flag MS_NOATIME
>>>> mount03.c:111: TPASS: st.st_atime == atime (1661183501)
>>>
>>> I also meet nosuid work not as expected.
>>>
>>> st_test.c:1599: TINFO: Testing on ext4
>>> tst_test.c:1064: TINFO: Formatting /dev/loop0 with ext4 opts='' extra
>>> opts=''
>>> mke2fs 1.46.5 (30-Dec-2021)
>>> mount03.c:151: TINFO: Testing flag MS_RDONLY
>>> mount03.c:48: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
>>> mount03.c:151: TINFO: Testing flag MS_NODEV
>>> mount03.c:55: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
>>> mount03.c:151: TINFO: Testing flag MS_NOEXEC
>>> mount03.c:63: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
>>> mount03.c:151: TINFO: Testing flag MS_RDONLY
>>> mount03.c:70: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 3
>>> mount03.c:151: TINFO: Testing flag MS_NOSUID
>>> mount03_suid_child.c:22: TFAIL: setreuid(getuid(), 0) succeeded
>>> mount03.c:151: TINFO: Testing flag MS_NOATIME
>>> mount03.c:112: TPASS: st.st_atime == atime (1661280863)
>>> tst_device.c:434: TINFO: No device is mounted at mntpoint
>>>
>> 
>> I added some more debug info:
>> 
>> @@ -86,7 +89,20 @@ static void test_nosuid(void)
>>   		if (st.st_mode != SUID_MODE)
>>   			SAFE_CHMOD(BIN_PATH, SUID_MODE);
>>   
>> -		SAFE_SETREUID(nobody_uid, nobody_uid);
>> +		tst_res(TINFO, "dev %d:%d, rdev: %d:%d",
>> +			major(st.st_dev), minor(st.st_dev), major(st.st_rdev), minor(st.st_rdev));
>> +		SAFE_SETRESGID(nobody_gid, nobody_gid, nobody_gid);
>> +		SAFE_SETRESUID(nobody_uid, nobody_uid, nobody_uid);
>> +
>> +		uid_t uid, gid, euid, egid, suid, sgid;
>> +
>> +		getresuid(&uid, &euid, &suid);
>> +		getresgid(&gid, &egid, &sgid);
>> +		tst_res(TINFO, "uid: %d, gid: %d, euid: %d, egid: %d, suid: %d, sgid: %d",
>> +			uid, gid, euid, egid, suid, sgid);
>> +
>> +		tst_system("pwd");
>> +		tst_system("ls -l " MNTPOINT);
>>   		SAFE_EXECL(BIN_PATH, BIN_PATH, NULL);
>>   		tst_brk(TFAIL | TTERRNO, "Failed to execute %s", BIN_PATH);
>> 
>> and in the child
>> 
>>   int main(void)
>>   {
>> +	uid_t uid, gid, euid, egid, suid, sgid;
>>   	tst_reinit();
>>   
>> +	getresuid(&uid, &euid, &suid);
>> +	getresgid(&gid, &egid, &sgid);
>> +	tst_res(TINFO, "uid: %d, gid: %d, euid: %d, egid: %d, suid: %d, sgid: %d",
>> +		uid, gid, euid, egid, suid, sgid);
>> +
>>   	TST_EXP_FAIL(setreuid(getuid(), 0), EPERM);
>>   
>> 
>> This shows that BIN_PATH is being accessed from the wrong device AFAICT
>> 
>> mount03.c:166: TINFO: Testing flag MS_NOSUID
>> 
>> ...
>> 
>> 30 1 0:26 / /tmp rw,relatime - tmpfs ltp rw,size=512000k,inode64
>> 31 30 0:27 / /tmp/mouLkSN2v/mntpoint rw,nosuid,relatime - tmpfs /dev/loop0 rw,inode64
>> mount03.c:92: TINFO: dev 0:26, rdev: 0:0
>> mount03.c:101: TINFO: uid: 65534, gid: 65534, euid: 65534, egid: 65534, suid: 65534, sgid: 65534
>> /tmp/mouLkSN2v
>> total 688
>> -r-s--x--x 1 root 0 702952 Oct 13 11:29 mount03_suid_child
>> mount03_suid_child.c:25: TINFO: uid: 65534, gid: 65534, euid: 0, egid: 65534, suid: 0, sgid: 65534
>> mount03_suid_child.c:28: TFAIL: setreuid(getuid(), 0) succeeded
>> 
>> The device should be 0:27 not 0:26.
>> 
>> Indeed if I remove SAFE_CHMOD then the euid and suid are set to
>> nobody. Also if I mount /tmp as nosuid then the test passes. Possibly we
>> need to use absoute paths to ensure we are going through the mount
>> point.
>
> I use statfs struct f_flags member to debug, then found the mounted 
> filesystem doesn't have nosuid flag.
>
> It seems parent has umounted this dev and so child doesn't have nosuid 
> flag, so this case failed.
>
> --- a/testcases/kernel/syscalls/mount/mount03.c
> +++ b/testcases/kernel/syscalls/mount/mount03.c
> @@ -90,6 +90,7 @@ static void test_nosuid(void)
>                  SAFE_EXECL(BIN_PATH, BIN_PATH, NULL);
>                  tst_brk(TFAIL | TTERRNO, "Failed to execute %s", BIN_PATH);
>          }
> +       tst_reap_children();
>   }
>
>
> After this change, this case can pass when I run with -i 10.

Good catch; merged with this fix and a couple of others.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
