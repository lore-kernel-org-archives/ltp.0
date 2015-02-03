Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YIeZl-0006Rx-LQ
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 14:35:37 +0000
Date: Tue, 3 Feb 2015 15:35:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150203143524.GB18474@rei.scz.novell.com>
References: <20150126130448.GA25601@rei.suse.de>
	<1422885672-6254-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422885672-6254-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] doc: document tst_run_cmd
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +2.2.20 Executing a file
> +^^^^^^^^^^^^^^^^^^^^^^^

Maybe "Running executables" would be a bit better, as it is the title
looks strange to me.

> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "test.h"
> +
> +int tst_run_cmd(void (cleanup_fn)(void),
> +               const char *const argv[],
> +	       const char *stdout_path,
> +	       const char *stderr_path,
> +	       int pass_exit_val);
> +-------------------------------------------------------------------------------
> +
> +'tst_run_cmd' is a wrapper for 'vfork() + execvp()' which provides a way to execute
> +an external program.
> +
> +'argv[]' is a NULL-terminated list of pointers to the program name and its optional
> +arguments.

Maybe it would be better:

NULL-terminated array of strings starting with the program name which is
followed by optional arguments.

And maybe we can include an example to make it clear.

What about:

.Example
[source,c]
-------------------------------------------------------------------------------
#include "test.h"

const char *cmd[] = {"ls", "-l", NULL};

...
	/* Store output of 'ls -l' into a log.txt */
	tst_run_cmd(cleanup, cmd, "log.txt", NULL, 0);
...

-------------------------------------------------------------------------------


> +
> +A non-zero 'pass_exit_val' makes 'tst_run_cmd' return the program exit code to
> +the caller. A zero for 'pass_exit_val' makes 'tst_run_cmd' call 'cleanup_fn'

Maybe better:

makes 'tst_run_cmd' exit the tests on failure and call 'cleanup_fn' (if
not NULL) beforehand.

> +in case the program exits with a non-zero code.
> +
> +'stdout_path' and 'stderr_path' detirmine where to redirect the program
                                   ^
				   determine
> +stdout and stderr I/O streams.
> +

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
