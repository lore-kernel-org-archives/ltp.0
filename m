Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PhYYW-0000fM-6M
	for ltp-list@lists.sourceforge.net; Tue, 25 Jan 2011 02:22:52 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PhYYU-0005CZ-Ox
	for ltp-list@lists.sourceforge.net; Tue, 25 Jan 2011 02:22:52 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0P2MiXL008583
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Jan 2011 21:22:44 -0500
Date: Mon, 24 Jan 2011 21:22:44 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1803283961.139211.1295922164654.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1524114322.122004.1295852492822.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] fix the -I option and enable a larger numble to I
 option
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

Hi,Garrett,

could you please review the patch, and give me your comments.
any suggestions are welcome.

Thanks a lot!

----- Original Message -----
> From: "Zhouping Liu" <zliu@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, January 24, 2011 3:01:32 PM
> Subject: [LTP][PATCH] fix the -I option and enable a larger numble to I option
> Hi Garrett,
> Please review.
> when running a test case with setting -I options a number, it's
> useless.
> e.g when I run testcase/kernel/mem/hugetlbfs/hugemmap/hugemmap01,
> [root@dell-per805-01 hugemmap]# ./hugemmap01 -I 3600 -H
> /var/hugetlbfs/
> hugemmap01 1 TPASS : call succeeded
> [root@dell-per805-01 hugemmap]#
> the test returned immediately, but no running for 3600 seconds, and
> other test cases all
> have this problem. I found it was that the variable stop_time in
> lib/parse_opts.c was integer that's not
> enough large, I changed it to a larger type(long long type), then it
> was okay, and support a larger number.
> 
> Zhouping Liu
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
> lib/parse_opts.c | 8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/parse_opts.c b/lib/parse_opts.c
> index 338cbea..f8b1743 100644
> --- a/lib/parse_opts.c
> +++ b/lib/parse_opts.c
> @@ -706,7 +706,7 @@ usc_test_looping(counter)
> int counter;
> {
> static int first_time = 1;
> - static int stop_time = 0; /* stop time in rtc or usecs */
> + static long long stop_time = 0; /* stop time in rtc or usecs */
> static int delay; /* delay in clocks or usecs */
> int hertz=0; /* clocks per second or usecs per second */
> int ct, end; /* current time, end delay time */
> @@ -731,7 +731,7 @@ int counter;
> 
> if (STD_LOOP_DURATION) {
> ct=get_current_time();
> - stop_time=(int)((float)hertz * STD_LOOP_DURATION) + ct;
> + stop_time = (long long)hertz * (long long)STD_LOOP_DURATION + (long
> long)ct;
> }
> 
> /*
> @@ -776,7 +776,7 @@ int counter;
> keepgoing++;
> }
> 
> - if (STD_LOOP_DURATION != 0.0 && get_current_time() < stop_time) {
> + if (STD_LOOP_DURATION != 0.0 && (long long)get_current_time() <
> stop_time) {
> keepgoing++;
> }
> 
> @@ -896,4 +896,4 @@ char **argv;
> exit(0);
> }
> 
> -#endif /* UNIT_TEST */
> \ No newline at end of file
> +#endif /* UNIT_TEST */
> --
> 1.7.1

-- 

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
