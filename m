Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P85oo-0003rx-EV
	for ltp-list@lists.sourceforge.net; Tue, 19 Oct 2010 06:37:06 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P85on-00032y-1g
	for ltp-list@lists.sourceforge.net; Tue, 19 Oct 2010 06:37:06 +0000
Received: by ywl5 with SMTP id 5so1059360ywl.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Oct 2010 23:36:59 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4CBD28A3.5000709@windriver.com>
Date: Mon, 18 Oct 2010 23:36:55 -0700
Message-Id: <5D6F1275-BDFB-4A5F-A313-5ECE5752028F@gmail.com>
References: <4CBBAD30.6070403@windriver.com>
	<AANLkTi=aC63h6rTNsqJ5tJ22FOuAR9+SLyp-vTW9KYDK@mail.gmail.com>
	<4CBD28A3.5000709@windriver.com>
Subject: Re: [LTP] [patch] sync_file_range01 change for arm
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
To: "lina.zhao" <lina.zhao@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Oct 18, 2010, at 10:12 PM, lina.zhao wrote:

> now endianness has been checked! see the patch
>> On Sun, Oct 17, 2010 at 7:13 PM, lina.zhao <lina.zhao@windriver.com> wrote:
>>  
>>> Hi,
>>> 
>>> arm use __NR_sync_file_range2 not __NR_sync_file_range for system call.
>>> the test casecheck __NR_sync_file_range for arm,
>>> So test react "System doesn't support" for arm.
>>> but actually arm use __NR_sync_file_range2 to support the system call.
>>> 
>>> powerpc is big endian, arm is small endian, so the parameter dealing is
>>> different.
>>>    
>> 
>>    Not true. ARM can be biendian, just like MIPS...
>>    A better test needs to be derived for endianness than this.
>> -Garrett
>> 
>>  
> 
> From cc07d890ae71837512731a0bf31006db8d717f8a Mon Sep 17 00:00:00 2001
> From: Lina Zhao <lina.zhao@windriver.com>
> Date: Tue, 19 Oct 2010 10:44:39 +0800
> Subject: [PATCH] sync_file_rang01.c changed for arm
> 
> ---
> .../syscalls/sync_file_range/sync_file_range01.c   |   36 ++++++++++++++------
> 1 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
> index 53619b5..a66ce85 100644
> --- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
> +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
> @@ -96,12 +96,13 @@
> #include "usctest.h"
> #include "linux_syscall_numbers.h"
> 
> -#if defined(__powerpc__) || defined(__powerpc64__)
> +#if defined(__powerpc__) || defined(__powerpc64__)|| defined(__arm__)
> #ifndef __NR_sync_file_range2
> #define __NR_sync_file_range2 -1	//DUMMY VALUE
> int arch_support = 0;		//Architecure is not supported
> #else
> int arch_support = 1;		//Architecture is supported
> +char call_num = 1;		//Use __NR_sync_file_range2 as syscall
> #endif
> #else
> #ifndef __NR_sync_file_range
> @@ -109,6 +110,7 @@ int arch_support = 1;		//Architecture is supported
> int arch_support = 0;
> #else
> int arch_support = 1;
> +char call_num = 0;
> #endif
> #endif
> 
> @@ -139,7 +141,7 @@ struct test_data_t {
> 	int error;
> } test_data[] = {
> 	{
> 	&bfd, 0, 1, SYNC_FILE_RANGE_WRITE, EBADF}, {
> 	&sfd, 0, 1, SYNC_FILE_RANGE_WAIT_AFTER, ESPIPE}, {
> 	&filed, -1, 1, SYNC_FILE_RANGE_WAIT_BEFORE, EINVAL}, {
> 	&filed, 0, -1, SYNC_FILE_RANGE_WRITE, EINVAL}, {
> @@ -238,22 +240,33 @@ static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
> 				 unsigned int flags)
> {
> 
> -#if (defined(__powerpc64__) || defined(__powerpc__)) && (__WORDSIZE==32)
> +	if (call_num){
> +#if (__WORDSIZE==64)
> 
> -	return syscall(__NR_sync_file_range2, fd, flags, (int)(offset >> 32),
> -		       (int)offset, (int)(nbytes >> 32), (int)nbytes);
> +	return syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
> 
> -#elif (defined(__powerpc64__) || defined(__powerpc__)) && (__WORDSIZE==64)
> +#elif (__WORDSIZE==32)
> 
> -	return syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
> -#else
> +	if (check_endian())	//little_endian 
> +		return syscall(__NR_sync_file_range2, fd, flags,(int)offset,
> +                	(int)(offset >> 32),(int)nbytes,(int)(nbytes >> 32));
> +	else			//big_endian
> +		return syscall(__NR_sync_file_range2, fd, flags, (int)(offset >> 32),
> +			(int)offset, (int)(nbytes >> 32), (int)nbytes);
> +#endif
> +	else
> 
> 	return syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
> -#endif
> 
> -	return 0;
> }
> 
> +static int check_endian( void )
> +{
> +	int x = 1;
> +	return ((char)(x) == x);
> +}
> +
> +
> /******************************************************************************/
> /*                                                                            */
> /* Function:    main                                                          */
> @@ -294,7 +307,8 @@ int main(int ac,		/* number of command line parameters                      */
> 	}
> #else
> 	/* For other archs, need kernel version > 2.6.16 */
> -
> +	if (arch_support)printf("arch supported!\n");
> +	if (tst_kvercmp(2, 6, 17) < 0)printf("kernel cmp fail\n");
> 	if (!arch_support || (tst_kvercmp(2, 6, 17) < 0)) {
> 		tst_resm(TCONF, "System doesn't support execution of the test");
> 		tst_exit();

	Close... here's one solution I've seen:

http://c-faq.com/misc/endiantest.html

	And FWIW this should be available as a generalized function / macro in include / lib .
Cheers,
-Garrett
------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
