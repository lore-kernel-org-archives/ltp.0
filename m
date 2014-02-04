Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WAfEb-0003w4-9m
	for ltp-list@lists.sourceforge.net; Tue, 04 Feb 2014 12:36:13 +0000
Date: Tue, 4 Feb 2014 13:35:40 +0100
From: chrubis@suse.cz
Message-ID: <20140204123539.GA5785@rei>
References: <1390287317-18512-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390287317-18512-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib/tst_mkfs.c: fix a bug when calling tst_mkfs()
 with extra mkfs options
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> When we used tst_mkfs() to build a file system with extra mkfs options, like that:
>     tst_mkfs(NULL, device, "ext4", "-b 1024"); /* device is /dev/loop0 */
> 
> It will output some error message, like that:
>     TINFO  :  Formatting /dev/loop0 with ext4 extra opts='-b 1024'
>     mke2fs 1.42.7 (21-Jan-2013)
>     mkfs.ext4: invalid blocks '/dev/loop0' on device 'ext4'
> 
> In tst_mkfs()'s implementations:
>    argv is defined as below statments:
>        const char *argv[] = {"mkfs", "-t", fs_type, NULL, NULL, NULL, NULL};
>    So in the above mkfs case,
>        the argv's value will be {"mkfs", "-t", "ext4", "-b 1024", "/dev/loop0", NULL};
>    then when finally calling execvp(argv[0], (char *const *)argv), the number of
> arguments is 5. It's like that we call (mkfs -t ext4 "-b 1024" /dev/loop0) in shell,
> but the right command shoule be (mkfs -t ext4 -b 1024 /dev/loop0 # 6 args).
> Of course, the true reason is that we didn't assign correct arguments to argv array
> towards extra mkfs options.
> 
>    Here we use system(3) to avoid this problem. We only pass the command string
> to system(3), avoid parsing extra mkfs options and assigning them to argv array ourselvs.

NACK. The code gets ugly this way.

What I would rather is to change the fs_opts to array of strings so
it could be called as:

const char *const opts[] = {
	"-b", "1024", NULL,
};

tst_mkfs(NULL, device, "ext4", opts);

The change in tst_mkfs() would be fairly simple, we would create argv[]
array which size would depend on number of options passed and set the
pointers accordingly.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
