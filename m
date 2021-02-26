From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Feb 2021 11:10:32 +0100
Subject: [LTP] [PATCH v2 2/2] syscalls/getpid02: Convert to new API
In-Reply-To: <20210225110118.583486-2-ruansy.fnst@cn.fujitsu.com>
References: <20210225110118.583486-1-ruansy.fnst@cn.fujitsu.com>
 <20210225110118.583486-2-ruansy.fnst@cn.fujitsu.com>
Message-ID: <YDjJGBR8YVJL5YWs@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	pid_t proc_id;		/* process id of the test process */
>  	pid_t pid;		/* process id of the child process */
>  	pid_t pproc_id;		/* parent process id */
                                  ^
				  I've removed these three useless
				  comments.

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
