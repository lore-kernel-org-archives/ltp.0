Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <markos.chandras@gmail.com>) id 1UFq22-00043y-NI
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 18:04:06 +0000
Received: from mail-we0-f174.google.com ([74.125.82.174])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UFq20-000305-Ln
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 18:04:06 +0000
Received: by mail-we0-f174.google.com with SMTP id r6so1292853wey.19
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Mar 2013 11:03:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1482749503.18144192.1363197480299.JavaMail.root@redhat.com>
References: <1363183294-21203-1-git-send-email-markos.chandras@gmail.com>
	<1482749503.18144192.1363197480299.JavaMail.root@redhat.com>
From: Markos Chandras <markos.chandras@gmail.com>
Date: Wed, 13 Mar 2013 18:03:36 +0000
Message-ID: <CAG2jQ8h+u3Ade6ONcde=jBLSipJtF1vzP9q7zE-m3qX-LM1fKQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH 1/2] syscalls/getdents: Use getdents64 if
 SYS_getdents is not defined
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 13 March 2013 17:58, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "Markos Chandras" <markos.chandras@gmail.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 13 March, 2013 3:01:34 PM
>> Subject: [LTP] [PATCH 1/2] syscalls/getdents: Use getdents64 if SYS_getdents  is not defined
>>
>> From: Markos Chandras <markos.chandras@imgtec.com>
>>
>> New Linux Kernel architectures do not define NR_getdents so we
>> try to use the getdents64 syscall instead
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>  testcases/kernel/syscalls/getdents/getdents.h |   15 +++++++++++++++
>>  1 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/getdents/getdents.h
>> b/testcases/kernel/syscalls/getdents/getdents.h
>> index 1d5e584..12d2be4 100644
>> --- a/testcases/kernel/syscalls/getdents/getdents.h
>> +++ b/testcases/kernel/syscalls/getdents/getdents.h
>> @@ -38,12 +38,23 @@
>>   * declare our own here.  Wheeeeee.
>>   */
>>
>> +#ifdef SYS_getdents
>>  struct linux_dirent {
>>       unsigned long   d_ino;
>>       unsigned long   d_off;
>>       unsigned short  d_reclen;
>>       char            d_name[];
>>  };
>> +#else
>> +/* Use the 64-bit definition */
>> +struct linux_dirent {
>> +     unsigned long long      d_ino;
>> +     long long               d_off;
>> +     unsigned short          d_reclen;
>> +     unsigned char           d_type;
>> +     char                    d_name[0];
>> +};
>> +#endif
>>
>>  static inline int
>>  getdents(unsigned int fd, struct dirent *dirp, unsigned int count)
>> @@ -57,7 +68,11 @@ getdents(unsigned int fd, struct dirent *dirp,
>> unsigned int count)
>>       unsigned int i;
>>
>>       ptrs.buf = buf;
>> +#ifdef SYS_getdents
>>       ret = syscall(SYS_getdents, fd, buf, count);
>> +#else
>> +     ret = syscall(SYS_getdents64, fd, buf, count);
>> +#endif
>
> Just a thought.. What about turning it to runtime check? There could be parameter to switch between
> SYS_getdents/SYS_getdents64 and we can have both (with/without that parameter) in runtest/syscalls.
> If it's supported it runs, if not ends with TCONF. That way we could have both version on arches
> that support both syscalls.
>

The problem is that for arches that don't have SYS_getdents defined,
you will not be able to compile LTP on them so you really need to
hide this codepath from them.

A similar commit that changes the codepath based on whether a
particular __NR_XX is defined is this
https://github.com/linux-test-project/ltp/commit/75201f160b9aa49af70d8f46fb1f087e63d603dd

I don't see an easy way to determine if __NR_XX is defined or not
during runtime.

-- 
Regards,
Markos Chandras

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
