From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Nov 2017 04:54:13 -0500 (EST)
Subject: [LTP] [PATCH v2 4/6] direct_io: diotest4: use getpagesize() for
 mmap if shm header is absent
In-Reply-To: <20171109003438.130802-5-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
 <20171109003438.130802-5-sspatil@google.com>
Message-ID: <2081314704.38722400.1510307653349.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> For some architectures, mmap(MAP_FIXED) has to be aligned to SHMLBA
> (instead of getpagesize()) --
> 
>    https://sourceforge.net/p/ltp/mailman/ltp-list/?viewmonth=200804
> 
> This dependency on SHMLBA causes the test to fail building for Android
> due to absence of sys/shm.h. Make the header dependency configurable and
> use getpagesize() as mmap granularity if the header is absent allowing
> the test to work on Android while not breaking the architectures that
> depend on the shm headers.
> 
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
> v1->v2
> ------
> - Instead of relying on __BIONIC__, fix by doing a header check for <sys/shm>
> and
>   if the header doesn't exist, use getpagesize() as mmap granularity,
>   otherwise
>   use SHMBA (as before)

Pushed.

Thanks,
Jan
