Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DE4CF9C5B
	for <ltp@archiver.kernel.org>; Sat, 21 Sep 2024 05:54:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A29633C30E5
	for <ltp@archiver.kernel.org>; Sat, 21 Sep 2024 07:54:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D25EA3C0243
 for <ltp@lists.linux.it>; Sat, 21 Sep 2024 07:54:38 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 9D682100066B
 for <ltp@lists.linux.it>; Sat, 21 Sep 2024 07:54:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=lQob5yFC/rMRmZO9xzB3VFkqHHI9BWYpkoSWyl5Mbyk=; b=C
 +8GMx1yf+9rmAJqpYuMLk1ZKdisHywvebVg1FYZcAxAfZVedZbJRCajgFrR+mH/I
 QjyQ2zYb5kAWIrHGia+udfrbprEkAWS/pyYDnPMbO0CubfUJwXXAwDUYjgWlXF1D
 Wr2s+h/tLgYOeRTHBGSToyqI1wAWSLf7kXV/brkHH4=
Received: from ice_yangxiao$163.com ( [160.86.227.245] ) by
 ajax-webmail-wmsvr-40-148 (Coremail) ; Sat, 21 Sep 2024 13:54:29 +0800
 (CST)
X-Originating-IP: [160.86.227.245]
Date: Sat, 21 Sep 2024 13:54:29 +0800 (CST)
From: =?GBK?B?0e7P/g==?= <ice_yangxiao@163.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZuljrzDTzU3VtI5O@yuki.lan>
References: <20240809025825.4055-1-ice_yangxiao@163.com>
 <ZuljrzDTzU3VtI5O@yuki.lan>
X-NTES-SC: AL_Qu2ZBPSSt0gt7yGYZukfmkwah+o+X8G2vf0j1YJUO514jCHr/S4MeXBMBkD/wNCOFBG9rheYfgF/5eVlWY13YoU139Kost73eYnTMdHKKEQ4pg==
MIME-Version: 1.0
Message-ID: <5886c6f2.1ce6.19213255e77.Coremail.ice_yangxiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lCgvCgD3ny6VX+5mpmYCAA--.22552W
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqRphXmVODCY53AAHsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/{fanotify17,
 getxattr05}: simplify code by using save_restore
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


At 2024-09-17 19:10:39, "Cyril Hrubis" <chrubis@suse.cz> wrote:
>Hi!
>> -	/*
>> -	 * The default value of max_user_namespaces is set to 0 on some distros,
>> -	 * We need to change the default value to call unshare().
>> -	 */
>> -	if (access(SELF_USERNS, F_OK) != 0) {
>> +	if (access(SELF_USERNS, F_OK) != 0)
>>  		user_ns_supported = 0;
>> -	} else if (!access(MAX_USERNS, F_OK)) {
>> -		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
>> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
>
>Here the original code writes 10 to the MAX_USERNS.
>
>> -	}
>>  
>>  	/*
>>  	 * In older kernels those limits were fixed in kernel and fanotify is
>> @@ -244,21 +234,18 @@ static void setup(void)
>>  	setup_rlimit(max_groups * 2);
>>  }
>>  
>> -static void cleanup(void)
>> -{
>> -	if (orig_max_userns != -1)
>> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns);
>> -}
>> -
>>  static struct tst_test test = {
>>  	.test = test_fanotify,
>>  	.tcnt = ARRAY_SIZE(tcases),
>>  	.setup = setup,
>> -	.cleanup = cleanup,
>>  	.needs_root = 1,
>>  	.forks_child = 1,
>>  	.mount_device = 1,
>>  	.mntpoint = MOUNT_PATH,
>> +	.save_restore = (const struct tst_path_val[]) {
>> +		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
>> +		{}
>> +	},
>
>And here you are initializing it to 1024? Shouldn't the value here be 10

>too?


Hi Cyril,


Sorry for the late reply.



If more than 10 user namspaces is currently used on system, it is still successfully to set
max_user_namespaces to 10.  However, these tests fail with ENOSPC. for example:
# lsns -t user -l -n | wc -l
17

root@fedora40:~/ltp/testcases/kernel/syscalls/fanotify# ./fanotify17
...
fanotify17.c:174: TINFO: Test #0: Global groups limit in init user ns
fanotify17.c:130: TPASS: Created 128 groups - below groups limit (128)
fanotify17.c:174: TINFO: Test #1: Global groups limit in privileged user ns
fanotify17.c:154: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
tst_test.c:452: TBROK: Invalid child (6958) exit value 1



Just try to fix the issue by increasing the setting of max_user_namespaces.
BTW, it may be better to get the number of user namespaces in use and then add 10.


Best Regards,
Xiao Yang

>
>>  };
>>  #else
>>  	TST_TEST_TCONF("system doesn't have required fanotify support");
>> diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
>> index d9717a695..3dff8e27f 100644
>> --- a/testcases/kernel/syscalls/getxattr/getxattr05.c
>> +++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
>> @@ -40,11 +40,9 @@
>>  
>>  #define TEST_FILE	"testfile"
>>  #define SELF_USERNS	"/proc/self/ns/user"
>> -#define MAX_USERNS	"/proc/sys/user/max_user_namespaces"
>>  #define UID_MAP	"/proc/self/uid_map"
>>  
>>  static acl_t acl;
>> -static int orig_max_userns = -1;
>>  static int user_ns_supported = 1;
>>  
>>  static struct tcase {
>> @@ -149,23 +147,13 @@ static void setup(void)
>>  		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
>>  	}
>>  
>> -	/* The default value of max_user_namespaces is set to 0 on some distros,
>> -	 * We need to change the default value to call unshare().
>> -	 */
>> -	if (access(SELF_USERNS, F_OK) != 0) {
>> +	if (access(SELF_USERNS, F_OK) != 0)
>>  		user_ns_supported = 0;
>> -	} else if (!access(MAX_USERNS, F_OK)) {
>> -		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
>> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
>> -	}
>>  
>>  }
>>  
>>  static void cleanup(void)
>>  {
>> -	if (orig_max_userns != -1)
>> -		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns);
>> -
>>  	if (acl)
>>  		acl_free(acl);
>>  }
>> @@ -181,7 +169,11 @@ static struct tst_test test = {
>>  	.tags = (const struct tst_tag[]) {
>>  		{"linux-git", "82c9a927bc5d"},
>>  		{}
>> -},
>> +	},
>> +	.save_restore = (const struct tst_path_val[]) {
>> +		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
>
>And same here.
>
>> +		{}
>> +	},
>>  };
>>  
>>  #else /* HAVE_SYS_XATTR_H && HAVE_LIBACL*/
>> -- 
>> 2.45.2
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>-- 
>Cyril Hrubis
>chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
