Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UUYuH-0007ZM-7N
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 08:48:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUYuF-0001lS-LI
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 08:48:57 +0000
Message-ID: <51764AFB.4080804@cn.fujitsu.com>
Date: Tue, 23 Apr 2013 16:48:59 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <8805528bb12e73785de99af72fa27fa90e535557.1366705953.git.jstancek@redhat.com>
In-Reply-To: <8805528bb12e73785de99af72fa27fa90e535557.1366705953.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] sendmsg02: fix compilation on kernel < 2.6.27
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

On 04/23/2013 04:37 PM, Jan Stancek wrote:
> Using SOCK_CLOEXEC and SOCK_NONBLOCK breaks compilation
> on older distros/kernels. These were originally taken from
> systemd sources, but as it turns out they are not needed to
> trigger this issue.
> 
> I confirmed, that issue can still be reproduced on 3.8 kernel
> and that testcase can be compiled at least back to RHEL5.3 (2.6.18).
> 
> Reported-by: DAN LI <li.dan@cn.fujitsu.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  testcases/kernel/syscalls/sendmsg/sendmsg02.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg02.c b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
> index 8f38f2c..c38d438 100644
> --- a/testcases/kernel/syscalls/sendmsg/sendmsg02.c
> +++ b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
> @@ -88,7 +88,7 @@ static void client(int id, int pipefd[])
>  	mh.msg_iovlen = 1;
>  
>  	do {
> -		fd = socket(AF_UNIX, SOCK_DGRAM|SOCK_CLOEXEC, 0);
> +		fd = socket(AF_UNIX, SOCK_DGRAM, 0);
>  		write(pipefd[1], &fd, 1);
>  		sendmsg(fd, &mh, MSG_NOSIGNAL);
>  		close(fd);
> @@ -109,7 +109,7 @@ static void server(int id, int pipefd[])
>  	snprintf(sa.sun_path, sizeof(sa.sun_path), "socket_test%d", id);
>  
>  	do {
> -		fd = socket(AF_UNIX, SOCK_DGRAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0);
> +		fd = socket(AF_UNIX, SOCK_DGRAM, 0);
>  		unlink(sa.sun_path);
>  		bind(fd, (struct sockaddr *) &sa, sizeof(struct sockaddr_un));
>  		read(pipefd[0], &fd, 1);
> 


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
