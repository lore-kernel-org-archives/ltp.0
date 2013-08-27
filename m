Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VE8un-0006Oe-B7
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 02:21:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VE8ul-0005OC-Ma
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 02:21:53 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r7R2LcbK005047
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 10:21:43 +0800
Message-ID: <521C0D06.7040602@cn.fujitsu.com>
Date: Tue, 27 Aug 2013 10:20:54 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <521AF0C8.6020704@cn.fujitsu.com>
In-Reply-To: <521AF0C8.6020704@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mount/mount05.c: format the device when necessary
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 08/26/2013 02:08 PM, DAN LI wrote:
> 
> Format the device only when "-D device" & "-T type" are specified.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/mount/mount05.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mount/mount05.c b/testcases/kernel/syscalls/mount/mount05.c
> index 4b2a07c..b4be67b 100644
> --- a/testcases/kernel/syscalls/mount/mount05.c
> +++ b/testcases/kernel/syscalls/mount/mount05.c
> @@ -113,7 +113,6 @@ int main(int argc, char *argv[])
>  void setup(void)
>  {
>  	tst_require_root(NULL);
> -	tst_mkfs(NULL, device, fstype, NULL);
> 
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> 
> @@ -122,9 +121,12 @@ void setup(void)
>  	SAFE_MKDIR(cleanup, mntpoint_src, DIR_MODE);
>  	SAFE_MKDIR(cleanup, mntpoint_des, DIR_MODE);
> 
> -	if (dflag && tflag)
> +	if (dflag && tflag) {

If "-T" option is not specified, the default fs_type is "ext2",
then we can also format the device.

> +		tst_mkfs(NULL, device, fstype, NULL);

And here "fstype" should be changed to "fs_type", right?

Thanks,
Wanlong Gao

> +
>  		if (mount(device, mntpoint_src, fs_type, 0, NULL) == -1)
>  			tst_brkm(TBROK | TERRNO, cleanup, "mount failed");
> +	}
> 
>  	SAFE_FILE_PRINTF(cleanup, file_src, "TEST FILE");
> 


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
