Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1XK1jL-0001EZ-Uh
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 08:58:55 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XK1jK-00030O-3f
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 08:58:55 +0000
Message-ID: <53F46303.9060009@cn.fujitsu.com>
Date: Wed, 20 Aug 2014 16:57:39 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <98fd8c728c27239472b635ea5e61ee69c3685a16.1408524328.git.jstancek@redhat.com>
In-Reply-To: <98fd8c728c27239472b635ea5e61ee69c3685a16.1408524328.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] timerfd_settime01: initialise itimerspec new_value
Reply-To: gaowanlong@cn.fujitsu.com
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

On 08/20/2014 04:46 PM, Jan Stancek wrote:
> Before kernel validates that fd is valid, it checks itimerspec struct
> with timespec_valid(). This struct is currently not initialised in test,
> which can cause failures, for example:
> 
> timerfd_settime01    1  TFAIL  :  timerfd_settime01.c:121: timerfd_settime()
>                         failed unexpectedly; expected: 9 - Bad file
>                         descriptor: TEST_ERRNO=EINVAL(22): Invalid argument
> timerfd_settime01    2  TFAIL  :  timerfd_settime01.c:121: timerfd_settime()
>                         failed unexpectedly; expected: 14 - Bad address:
>                         TEST_ERRNO=EINVAL(22): Invalid argument
> 
> Fix this by giving fields in this struct some deterministic values
> (zero in this patch).
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  .../kernel/syscalls/timerfd/timerfd_settime01.c    |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
> index d12e40a..a1b04a5 100644
> --- a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
> +++ b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
> @@ -58,6 +58,7 @@ static void setup(void);
>  static void timerfd_settime_verify(const struct test_case_t *);
>  static void cleanup(void);
>  static int exp_enos[] = { EBADF, EFAULT, EINVAL, 0 };
> +static struct itimerspec new_value;
>  
>  int main(int argc, char *argv[])
>  {
> @@ -103,7 +104,6 @@ static void setup(void)
>  
>  static void timerfd_settime_verify(const struct test_case_t *test)
>  {
> -	struct itimerspec new_value;
>  	TEST(timerfd_settime(*test->fd, test->flags, &new_value,
>  			     test->old_value));
>  
> 


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
