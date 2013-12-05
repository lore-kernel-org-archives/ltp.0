Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VoRWm-0008Pj-39
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 05:31:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoRWk-0004Nl-KX
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 05:31:08 +0000
Message-ID: <52A00F3C.8040607@cn.fujitsu.com>
Date: Thu, 05 Dec 2013 13:29:32 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <529FF665.9000004@cn.fujitsu.com>
	<201312050024.50466.vapier@gentoo.org>
In-Reply-To: <201312050024.50466.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/3] fcntl/fcntl29.c: add F_DUPFD_CLOEXEC test for
 fcntl(2)
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
To: Wang xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

On 12/05/2013 01:24 PM, Mike Frysinger wrote:
> On Wednesday 04 December 2013 22:43:33 Xiaoguang Wang wrote:
>> +#if defined(F_DUPFD_CLOEXEC)
>> ...
>> +#else
>> +
>> +int main(int ac, char **av)
>> +{
>> +	tst_brkm(TCONF, NULL, "This test can only run on kernels"
>> +		 "that are 2.6.24 and higher");
>> +}
>> +#endif
> 
> an ifdef test on a define provided by the C library is not a good marker to 
> control kernel version functionality
> 
>> +			TEST(fcntl(test_fd, F_DUPFD_CLOEXEC, dup_fd));
>> +			if (TEST_RETURN < 0) {
>> +				tst_brkm(TFAIL | TTERRNO, cleanup, "fcntl "
>> +					 "test F_DUPFD_CLOEXEC failed");
>> +			}
> 
> what happens when you run this on an older kernel ?  should you be doing a 
> runtime kernel version test here ?

Yeah, why not use "tst_kvercmp()" here?

Thanks,
Wanlong Gao

> -mike
> 
> 
> 
> ------------------------------------------------------------------------------
> Sponsored by Intel(R) XDK 
> Develop, test and display web and hybrid apps with a single code base.
> Download it for free now!
> http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
