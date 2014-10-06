Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xb4Qo-0001e5-6j
	for ltp-list@lists.sourceforge.net; Mon, 06 Oct 2014 09:18:14 +0000
Date: Mon, 6 Oct 2014 11:18:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141006091801.GA8551@rei.suse.cz>
References: <7e6611cd7abcfc04cb31b87314394481711e4c7a.1412258926.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e6611cd7abcfc04cb31b87314394481711e4c7a.1412258926.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH/RFC] checkpoints: fix usage in children started
 via exec
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

Hi!
> creat07 and setpgid03 are currently failing in following way:
>   CHILD: Failed to open fifo '': No such file or directory at creat07_child.c:31
>   creat07     1  TBROK  :  tst_checkpoint.c:126: Checkpoint timeouted after 5000 msecs at creat07.c:78
>   creat07     2  TBROK  :  tst_checkpoint.c:126: Remaining cases broken
> 
> These testcases start children via exec, so allow them to initialize
> checkpoint in way which is using FIFO already created by parent.
> 
> This patch adds "TST_CHECKPOINT_MAKE_NAME", which allows child to
> generate same FIFO names as parent did and configure checkpoint
> structure to use same FIFO created in parent.
> 
> One possible issue is that if multiple checkpoints are used,
> child needs to initialise these in same order as parent created them,
> but given we mostly use only fork, this should be rather
> exceptional use.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_checkpoint.h                           |    5 ++++
>  lib/tst_checkpoint.c                               |   23 ++++++++++++-------
>  testcases/kernel/syscalls/creat/creat07_child.c    |    3 ++
>  .../kernel/syscalls/setpgid/setpgid03_child.c      |    3 ++
>  4 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
> index 4d04c0e..f9c242f 100644
> --- a/include/tst_checkpoint.h
> +++ b/include/tst_checkpoint.h
> @@ -56,6 +56,11 @@ struct tst_checkpoint {
>  void tst_checkpoint_init(const char *file, const int lineno,
>                           struct tst_checkpoint *self);
>  
> +#define TST_CHECKPOINT_MAKE_NAME(buf, len) \
> +	tst_checkpoint_make_name(__FILE__, __LINE__, buf, len)
> +void tst_checkpoint_make_name(const char *file, const int lineno,
> +				   char *buf, int len);

IMHO it would be more clear to rename the checkpoint_init() to
checkpoint_create() and use checkpoint_init() for initializing the
structure only. The renaming should be as easy as doing in-place sed
script.

Otherwise I think that it would be cleaner to just pass the checkpoint
pointer to the function that initializes the checkpoint because the
string lenght is static and known at the compile time and passing it
to the function explicitly may only introduce errors.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
