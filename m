Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1U2BM8-0007A2-6C
	for ltp-list@lists.sourceforge.net; Mon, 04 Feb 2013 02:00:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U2BM3-0001Vs-8X
	for ltp-list@lists.sourceforge.net; Mon, 04 Feb 2013 02:00:24 +0000
Message-ID: <510F160D.9080503@cn.fujitsu.com>
Date: Mon, 04 Feb 2013 09:59:41 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1359543471-19535-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1359543471-19535-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/open11: new open(2) test case
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 01/30/2013 06:57 PM, Eryu Guan wrote:
> +	{	/* open device special file O_WRONLY */
> +		.desc = "Open device special file O_WRONLY",
> +		.path = T_DEV,
> +		.flags = O_WRONLY,
> +		.mode = 0644,
> +		.err = 0,
> +	},
> +	{	/* open device special file O_RDWR */
> +		.desc = "Open device special file O_RDWR",
> +		.path = T_DEV,
> +		.flags = O_RDWR,
> +		.mode = 0644,
> +		.err = 0,
> +	},
> +	{	/* open device special file O_RDWR */
> +		.desc = "Open device special file O_RDWR",
> +		.path = T_DEV,
> +		.flags = O_RDWR,
> +		.mode = 0644,
> +		.err = 0,
> +	},

Why should this test twice?

Thanks,
Wanlong Gao

> +	/*
> +	 * Test open(2) non-existing file
> +	 */
> +	{	/* open non-existing regular file in existing dir */
> +		.desc = "Open non-existing regular file in existing dir",
> +		.path = T_DIR"/"T_NEW_REG,
> +		.flags = O_RDWR | O_CREAT,
> +		.mode = 0644,
> +		.err = 0,
> +	},


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
