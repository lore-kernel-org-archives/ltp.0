From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 29 Aug 2016 14:50:50 +0200
Subject: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
In-Reply-To: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160829125050.GD30021@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In my environment, if TMPDIR is on NFSv4, this test case fails with:
> 
> lsmod01 1 TFAIL : lsmod output different from /proc/modules.
>   21c21
>   < sunrpc 207591 28
>   ---
>   > sunrpc 207591 29
> 
> To avoid such problems I separate the process of getting data from
> /proc/modules and the process of parsing it in the pipe structure.

So the sunrpc module gets its ref counter incremented from somewhere of
the nfs kernel code once we open file on NFS?

But shouldn't the shell open the temp file the output is redirected to
before it executes the command line anyway?

-- 
Cyril Hrubis
chrubis@suse.cz
