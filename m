Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Vm4rw-00010g-Gf
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 16:55:12 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vm4rv-0002r9-KX
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 16:55:12 +0000
Message-ID: <52977568.9070306@imgtec.com>
Date: Thu, 28 Nov 2013 16:55:04 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <528DE213.1030106@cn.fujitsu.com> <20131128143504.GF19263@rei.Home>
In-Reply-To: <20131128143504.GF19263@rei.Home>
Subject: Re: [LTP] [PATCH v3]  dup3(2): add EINVAL error number test
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

On 11/28/2013 02:35 PM, chrubis@suse.cz wrote:
> Hi!
>> +static void cleanup(void)
>> +{
>> +	TEST_CLEANUP;
>> +
>> +	SAFE_CLOSE(cleanup, old_fd);
>
> Take care not to call cleanup() from within a cleanup()
>
> If the close() here will fail, the cleanup will be called, then the
> close() will fail and the cleanup will be called... untill the end of
> the stack and the test will eventually SegFault.
>
> Also if the SAFE_CREAT() in setup() will fail, the close() will fail
> too, because the old_fd will be set to -1.
>
> I've fixed that this time and pushed (see diff bellow), thanks.
>
>
> @@ -117,7 +117,8 @@ static void cleanup(void)
>   {
>          TEST_CLEANUP;
>
> -       SAFE_CLOSE(cleanup, old_fd);
> +       if (old_fd > 0)
> +               SAFE_CLOSE(NULL, old_fd);
>
>          tst_rmdir();
>   }
>

Hello,

This test does not seem to compile on uClibc based systems

I am getting this:
dup3_02.c:53: error: 'O_CLOEXEC' undeclared here (not in a function)

-- 
markos


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
