Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YTv08-0004ak-Ku
	for ltp-list@lists.sourceforge.net; Fri, 06 Mar 2015 16:21:24 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YTv07-0001a1-4k
	for ltp-list@lists.sourceforge.net; Fri, 06 Mar 2015 16:21:24 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t26GLG28021801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Mar 2015 11:21:16 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t26GLFTi002847
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Mar 2015 11:21:15 -0500
Message-ID: <54F9D3FA.6040503@redhat.com>
Date: Fri, 06 Mar 2015 17:21:14 +0100
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <1425569098-19519-1-git-send-email-jjaburek@redhat.com>
In-Reply-To: <1425569098-19519-1-git-send-email-jjaburek@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/sync_file_range01: support 31-bit s390
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
To: ltp-list@lists.sourceforge.net

On 03/05/2015 04:24 PM, Jiri Jaburek wrote:
> The ifdef'd part is identical to how arm/ppc handles big endianness,
> however the syscall number and argument order are different.
> 
> Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
> ---
>  testcases/kernel/syscalls/sync_file_range/sync_file_range01.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
> index 3d26f8f..3eac52d 100644
> --- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
> +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
> @@ -196,7 +196,7 @@ void setup(void)
>  static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
>  				 unsigned int flags)
>  {
> -
> +/* arm and powerpc */
>  #if (defined(__arm__) || defined(__powerpc__) || defined(__powerpc64__))
>  #if (__WORDSIZE == 32)
>  #if __BYTE_ORDER == __BIG_ENDIAN
> @@ -210,10 +210,16 @@ static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
>  #else
>  	return ltp_syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
>  #endif
> +
> +/* s390 */
> +#elif (defined(__s390__) || defined(__s390x__)) && __WORDSIZE == 32
> +       return ltp_syscall(__NR_sync_file_range, fd, (int)(offset >> 32),
> +               (int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
> +

Ugh, I somehow managed to leave spaces instead of tabs here, will post
v2 with correct formatting, sorry.

> +/* other */
>  #else
>  	return ltp_syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
>  #endif
> -
>  }
>  
>  /******************************************************************************/
> 


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
