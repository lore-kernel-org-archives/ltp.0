Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1W5AiJ-0001Ou-Ak
	for ltp-list@lists.sourceforge.net; Mon, 20 Jan 2014 09:00:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W5AiF-0007So-Ko
	for ltp-list@lists.sourceforge.net; Mon, 20 Jan 2014 09:00:11 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s0K8s0g0009268
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Jan 2014 16:54:20 +0800
Message-ID: <52DCE3E7.9060109@cn.fujitsu.com>
Date: Mon, 20 Jan 2014 16:52:55 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <52DCE226.4030500@cn.fujitsu.com>
In-Reply-To: <52DCE226.4030500@cn.fujitsu.com>
Subject: Re: [LTP] lib/tst_mkfs.c:  problem about tst_mkfs()
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
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On 01/20/2014 04:45 PM, Wang Xiaoguang wrote:
> Hi,
> 
>     When I used tst_mkfs() to build a file system with extra mkfs
> options, like that:
>     tst_mkfs(NULL, device, "ext4", "-b 1024"); /* device is /dev/loop0 */
>  
>     It will output this error message:
>     TINFO  :  Formatting /dev/loop0 with ext4 extra opts='-b 1024'
>     mke2fs 1.42.7 (21-Jan-2013)
>     mkfs.ext4: invalid blocks '/dev/loop0' on device 'ext4'
> 
> I look through tst_mkfs()'s implementations,
>     the call chain is: tst_mkfs =>  tst_run_cmd => tst_run_cmd_fds
> =>  _exit(execvp(argv[0], (char *const *)argv));
> 
>    in this case argv will be like that:
>    char *argv[] = {"mkfs", "-t", "ext4", "-b 1024", "/dev/loop0", NULL},
> then we finally call mkfs like that:
>    mkfs -t ext4 "-b 1024" /dev/loop0  # this may make command mkfs parse
>                                                            # arguments failed.
> 
> Indeed the right command should be:  mkfs -t ext4 -b 1024 /dev/loop0.
> 
> So I think there are some problems here, if we want to pass extra fs options.
> Would you please review this? If so, I can send a patch to fix this.

Should be fixed, please send a patch.

Thanks,
Wanlong Gao

> 
> Thanks,
> Xiaoguang Wang
> 
> 
> ------------------------------------------------------------------------------
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today. 
> http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
