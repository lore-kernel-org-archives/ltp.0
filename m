Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WYD92-00071j-I9
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 11:27:48 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYD8z-00005p-7H
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 11:27:48 +0000
Date: Thu, 10 Apr 2014 07:27:36 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <592669147.2947135.1397129256250.JavaMail.zimbra@redhat.com>
In-Reply-To: <1397122484-29192-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1397122484-29192-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] pipeio/pipeio.c: cleanup
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





----- Original Message -----
> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Thursday, 10 April, 2014 11:34:44 AM
> Subject: [LTP] [PATCH v2] pipeio/pipeio.c: cleanup
> 
> Delete some useless comments and fix some.
> 
> Use SAFE_* macros.
> 
> Make a re-arrangement on original code: let parent process
> work in do_parent(), child process work in do_child(), and
> arguments parse and initialization work in setup().
> 
> Delete several useless or pointless options:
>   Option C: this option is not supported and has no effect to this test.
> 
>   Option B: if this option is specified, the parent process will always
> return 0, which won't reflect the correct test results. I think it does
> not make much sense and remove it.
> 
>   Option d: this option is used to specify a directory, where named pipe
> is created, other than the current directory. Since tst_tmpdir() will
> create a temporary directory, so I think "-d" option can be removed.
> 
> printf() is not async-signal-safe, so use write(2) in signal handler
> directly.
> 
> Some cleanup.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/ipc/pipeio/pipeio.c | 955
>  ++++++++++++++++-------------------
>  1 file changed, 438 insertions(+), 517 deletions(-)
> 
> diff --git a/testcases/kernel/ipc/pipeio/pipeio.c
> b/testcases/kernel/ipc/pipeio/pipeio.c
> index 7dfbe44..3b2964c 100644
> --- a/testcases/kernel/ipc/pipeio/pipeio.c
> +++ b/testcases/kernel/ipc/pipeio/pipeio.c

Hi,

<snip>

> +static int Nchildcomplete;

I'd suggest sig_atomic_t here.

> +
> +static int error;
> +static int count;
> +static int num_writers = 1;	/* number of writers */
> +static int num_writes = 1;	/* number of writes per child */
> +static int loop;		/* loop indefinitely */
> +static int exit_error = 1;	/* exit on error #, zero means no exit */
> +static int size = 327;		/* default size */
> +static int unpipe;		/* un-named pipe if non-zero */
> +static int verbose;		/* verbose mode if set */
> +static int quiet;		/* quiet mode if set */
> +static int num_rpt;		/* ping number, how often to print message */
> +static int chld_wait;	/* max time to wait between writes, 1 == no wait */
> +static int parent_wait;	/* max time to wait between reads, 1 == no wait */
> +static int ndelay = O_NDELAY;	/* additional flag to open */
> +static char *writebuf;
> +static char *readbuf;
> +static char pname[PATH_MAX];	/* contains the name of the unamed pipe */
> +static char *blk_type = NON_BLOCKING_IO; /* blocking i/o or not */
> +static char *pipe_type;		/* type of pipe under test */
> +static int fds[2];		/* un-named pipe fds */
> +static int read_fd;
> +static int write_fd;
> +static int empty_read;
> +static int format = HEX;
> +static int format_size = -1;
> +static int iotype;		/* sync io */
> +static int sem_id;
> +static struct sembuf sem_op;

Some of these variables could be local: "fds" only in setup(),
"sem_op" could be local in do_child() and do_parent().

I'd suggest to also split this list of global variables, so it's clear
which are modified as part of setup and which change value
also throughout the run.

Split of code into functions looked OK to me.

Regards,
Jan

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
