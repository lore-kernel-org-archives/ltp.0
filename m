From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 6 Apr 2018 04:54:22 -0400 (EDT)
Subject: [LTP] [RFC PATCH 6/6] syscalls/wait401: Rewrite to the new
 library
In-Reply-To: <20180405145015.7633-7-chrubis@suse.cz>
References: <20180405145015.7633-1-chrubis@suse.cz>
 <20180405145015.7633-7-chrubis@suse.cz>
Message-ID: <1134024977.11699650.1523004862083.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> + Get rid of the sleep(1) in the process
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

> +	pid = SAFE_FORK();
> +	if (!pid)
> +		exit(0);

This doesn't seem to test that wait4() waits. The child can
end before call to wait4().

What if added call to tst_process_state_wait() to child,
so it waits on parent to sleep? If parent sleeps, then
it's likely waiting on child.

Regards,
Jan
