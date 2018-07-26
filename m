From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 26 Jul 2018 15:51:33 +0800
Subject: [LTP] [PATCH] syscalls/madvise02.c: Fix ENOMEM errno tests
In-Reply-To: <65184495.35943072.1532591172754.JavaMail.zimbra@redhat.com>
References: <1532671538-22356-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <65184495.35943072.1532591172754.JavaMail.zimbra@redhat.com>
Message-ID: <5B597D85.4080809@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/07/26 15:46, Jan Stancek wrote:
> ----- Original Message -----
>> With commit 212a4b9 on some distros(e.g. RHEL6.9/7.5), running
>> madvise02 got the following error:
>> ------------------------------------------------------
>> ...
>> madvise02.c:181: CONF: MADV_UNMERGEABLE is not supported
>> madvise02.c:196: FAIL: madvise succeeded unexpectedly
>> madvise02.c:196: FAIL: madvise succeeded unexpectedly
>> madvise02.c:181: CONF: MADV_WILLNEED is not supported
>> ...
>> -------------------------------------------------------
>>
>> If MAP_SIZE was equal to a pagesize, shared_anon may get the same
>> address which was a part of file2 and already unmapped, so that the
>> whole address of file2 became valid again.  Subsequently, ENOMEM
>> errno tests succeeded, so changing the order of mmaps to make
>> shared_anon get different address.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Hi,
>
> I changed patch to move MUNMAP() instead and added comment
> explaining why.
>
> You can review it here:
>    https://github.com/linux-test-project/ltp/commit/030e321ce1dfdc3a8daf7ef5a5b7bb7734cf2d9f
Hi Jan,

Thanks for your quick review, and it seems better to me. :-)

Thanks,
Xiao Yang
> Thanks,
> Jan
>
>
>



