Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OvYbq-0003hy-VA
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 16:43:54 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OvYbp-0005P8-87
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 16:43:54 +0000
Received: by iwn2 with SMTP id 2so7624612iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Sep 2010 09:43:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OFD6B689AE.1AE38E72-ON8525779D.0054A722-8525779E.0049DA86@us.ibm.com>
References: <OFD6B689AE.1AE38E72-ON8525779D.0054A722-8525779E.0049DA86@us.ibm.com>
Date: Tue, 14 Sep 2010 09:43:47 -0700
Message-ID: <AANLkTimGFWgvZcinBK-SHkY2H-Ew6D+x=L2EyedRQKn4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] 20100831 release hugetlb tests bug and patch (re-post
 with sign-off line)
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
To: Scott Romanowski <romansc@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Sep 14, 2010 at 6:26 AM, Scott Romanowski <romansc@us.ibm.com> wrote:
> The various hugetlb tests don't check to see if they are trying to allocate
>> SHMMAX memory, nor do they try to compensate for multiple processes --
> each process will try to get half of memory, so eventually a request will
> fail.
>
> I suggest adding a function to lib/system_specific_hugepages_info.c and
> include/system_specific_hugepages_info.h, and replacing the existing
> calculation with a call to the new function in
> testcases\kernel\mem\hugetlb\hugeshmat\hugeshmat01.c
> testcases\kernel\mem\hugetlb\hugeshmat\hugeshmat02.c
> testcases\kernel\mem\hugetlb\hugeshmat\hugeshmat03.c
> testcases\kernel\mem\hugetlb\hugeshmctl\hugeshmctl01.c
> testcases\kernel\mem\hugetlb\hugeshmctl\hugeshmctl02.c
> testcases\kernel\mem\hugetlb\hugeshmctl\hugeshmctl03.c
> testcases\kernel\mem\hugetlb\hugeshmdt\hugeshmdt01.c
> testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget01.c
> testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget02.c
> testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget03.c
> testcases\kernel\mem\hugetlb\hugeshmget\hugeshmget05.c
>
> With this change you can run all the tests with multiple forked processes,
> except hugeshmget02 and hugeshmget03.
>
> hugeshmget02 creates a large shared memory segment, then loops, trying to
> shmget() it in various invalid ways. Once it has finished looping, it
> deletes the segment. If you run it with multiple parallel processes, once
> one process finishes its loop and deletes the segment, the others fail.
>
> hugeshmget03 allocates all of the available huge memory, then loops, trying
> to allocate one more chunk and expecting an error. It finally deallocates
> all the memory. However, running this test in multiple parallel processes
> can cause false errors as follows:
> - The numerous processes allocate all of huge memory.
> - process 1 tries to allocate more. It fails, finishes its loops, and then
> releases all the memory it allocated.
> - process 2, which hasn't finished all its loops then tries to allocate
> more, and succeeds, which is a failure.
>
>
> The patches:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff -r 90778db5a87c include/system_specific_hugepages_info.h
> --- a/include/system_specific_hugepages_info.h Mon Sep 13 11:19:49 2010
> -0400
> +++ b/include/system_specific_hugepages_info.h Mon Sep 13 14:51:14 2010
> -0400
> @@ -24,5 +24,13 @@
> int get_no_of_hugepages(void);
> /*Returns Hugepages Size from /proc/meminfo*/
> int hugepages_size(void);
> +
> +/* Returns number of bytes to allocate, based on total huge memory,
> + a fraction, SHMMAX, and the number of parallel processes that will be
> + allocating memory. fraction is the fraction of total memory to use.
> + E.g., a fraction of 0.5 will allocate from 1/2 the total, 0.333 would use
> 1/3.
> + A fraction of 1 would allocate from all the huge memory.
> +*/
> +size_t calculate_huge_pages_shm_to_be_allocated( double fraction );
> #endif
>
> diff -r 90778db5a87c lib/system_specific_hugepages_info.c
> --- a/lib/system_specific_hugepages_info.c Mon Sep 13 11:19:49 2010 -0400
> +++ b/lib/system_specific_hugepages_info.c Mon Sep 13 14:51:14 2010 -0400
> @@ -26,8 +26,10 @@
> */
>
> #include <fcntl.h>
> +#include <linux/shm.h>
> #include <sys/types.h>
> #include <test.h>
> +#include "usctest.h"
>
> #define BUFSIZE 512
>
> @@ -76,3 +78,29 @@
> #endif
> }
>
> +/* Calculate how much memory to allocate based on the available huge memory
> and
> + how many parallel processes are going to allocate it.
> +*/
> +size_t calculate_huge_pages_shm_to_be_allocated( double fraction )
> +{
> +#ifdef __linux__
> + size_t bytes_to_allocate;
> +
> + bytes_to_allocate = (size_t)(fraction * (double)get_no_of_hugepages() *
> (double)hugepages_size() * 1024.0);
> +
> + /* Now divide that up amongst the processes */
> + if( STD_COPIES > 1 )
> + bytes_to_allocate /= (size_t)STD_COPIES;
> + /* and limit to SHMMAX */
> + if( bytes_to_allocate > SHMMAX )
> + bytes_to_allocate = (size_t)SHMMAX;
> +
> + #ifdef DEBUG
> + printf( "calculate_huge_pages_shm_to_be_allocated(%lf) returns %lu\n",
> divider, (unsigned long)bytes_to_allocate );
> + #endif
> +
> + return bytes_to_allocate;
> +#else
> + return (size_t)-1;
> +#endif
> +}

1. It doesn't make sense why you're doing this, unless you're
purposely trying to impose a limit to get the consumer to fail on the
next round. What happens if you make this 0 instead?
2. Also, have you tried inverting the logic to test out whether or not
this case functions as expected (i.e. #ifndef __linux__ ... #else
return (size_t) -1; #endif)?
3. This also exposes type bugs in the tests; example:

unsigned long huge_pages_shm_to_be_allocated;

Note that the above is unsigned long, not size_t. This logic is
present in a handful of the hugetlb testcases.

Thanks,
-Garrett

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
