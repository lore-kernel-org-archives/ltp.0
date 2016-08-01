From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 1 Aug 2016 06:12:33 -0400 (EDT)
Subject: [LTP] [PATCH] madvise06: make bug detection more reliable
In-Reply-To: <3b5c21485cf55776374b37327f39f5daa29f94da.1469184742.git.jstancek@redhat.com>
References: <3b5c21485cf55776374b37327f39f5daa29f94da.1469184742.git.jstancek@redhat.com>
Message-ID: <1077319971.10228993.1470046353126.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: ltp@lists.linux.it
> Cc: liwan@redhat.com
> Sent: Friday, 22 July, 2016 12:56:41 PM
> Subject: [LTP] [PATCH] madvise06: make bug detection more reliable
> 
> 1. set up memory cgroup
> This allows us to get swapped memory faster, and also
> eliminates problems with running testcase on big systems.
> 
> 2. check for expected effects in a loop
> madvise_willneed() reads memory asynchronously, so we check
> multiple times with delay in-between. Because we can't
> distinguish between bad kernel and slow I/O, bad kernel
> will make test check for 5 seconds before giving up.
> As last resort we check presence of first page.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/madvise/madvise06.c | 142
>  ++++++++++++++++++--------
>  1 file changed, 101 insertions(+), 41 deletions(-)
> 

I tested this on 4.7-rc7 and pushed.

Regards,
Jan
