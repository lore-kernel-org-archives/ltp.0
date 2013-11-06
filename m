Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VeAkk-0000Wj-8p
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 21:35:06 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VeAki-0001pT-8n
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 21:35:06 +0000
Date: Wed, 6 Nov 2013 16:34:58 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1924029835.23120751.1383773698263.JavaMail.root@redhat.com>
In-Reply-To: <1383755951-21231-1-git-send-email-jlayton@redhat.com>
References: <1383755951-21231-1-git-send-email-jlayton@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] diotest3: fix -f argument
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
To: Jeff Layton <jlayton@redhat.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Jeff Layton" <jlayton@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Wednesday, 6 November, 2013 5:39:11 PM
> Subject: [LTP] [PATCH] diotest3: fix -f argument
> 
> The '-f' argument to diotest3 is currently ignored. During options
> processing it's copied to the buffer, then subsequently overwritten
> by the default in a later sprintf() call.
> 
> Move the setting of the default prior to the options processing.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

Hi Jeff,

pushed. I checked also other diotest*.c, but diotest3.c
was the only one having this issue.

Thanks,
Jan

> ---
>  testcases/kernel/io/direct_io/diotest3.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/io/direct_io/diotest3.c
> b/testcases/kernel/io/direct_io/diotest3.c
> index ac460ed..002a6d0 100644
> --- a/testcases/kernel/io/direct_io/diotest3.c
> +++ b/testcases/kernel/io/direct_io/diotest3.c
> @@ -238,6 +238,8 @@ int main(int argc, char *argv[])
>  	int numchild = 1;	/* Number of children. Default 5 */
>  	int i, fail_count = 0, failed = 0, total = 0;
>  
> +	sprintf(filename, "testdata-3.%ld", syscall(__NR_gettid));
> +
>  	/* Options */
>  	while ((i = getopt(argc, argv, "b:o:i:n:f:")) != -1) {
>  		switch (i) {
> @@ -277,7 +279,6 @@ int main(int argc, char *argv[])
>  			prg_usage();
>  		}
>  	}
> -	sprintf(filename, "testdata-3.%ld", syscall(__NR_gettid));
>  
>  	setup();
>  
> --
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> November Webinars for C, C++, Fortran Developers
> Accelerate application performance with scalable programming models. Explore
> techniques for threading, error checking, porting, and tuning. Get the most
> from the latest Intel processors and coprocessors. See abstracts and register
> http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
