Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YIfxi-00086L-Ls
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 16:04:26 +0000
Date: Tue, 3 Feb 2015 17:04:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150203160412.GA19511@rei.scz.novell.com>
References: <1422958307.24335.1.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422958307.24335.1.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH] Add io_cd and io_floppy to scenario_groups/default
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  scenario_groups/default | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 3a55702..89037aa 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -32,3 +32,5 @@ dma_thread_diotest
>  cpuacct
>  can
>  cpuhotplug
> +io_cd
> +io_floppy

The stress_floppy testcase can't handle the case when there is a floppy
drive on a computer but there is no disk inside. It should exit with
TCONF and hint the user that he needs to put a disk into the drive to
run the test.

Similarily the stress_cd does not handle this case. But even more it
fails on a machine without a cdrom drive (such as my notebook).

Until this gets fixed, these cannot be added to default run.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
