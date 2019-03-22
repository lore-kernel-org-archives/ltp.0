From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Mar 2019 13:21:55 +0100
Subject: [LTP] [PATCH v2 0/2] Implement syscall multiplexing
In-Reply-To: <450197962.11087564.1553256285704.JavaMail.zimbra@redhat.com>
References: <20190321155112.13449-1-chrubis@suse.cz>
 <450197962.11087564.1553256285704.JavaMail.zimbra@redhat.com>
Message-ID: <20190322122154.GA5716@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Acked-by: Jan Stancek <jstancek@redhat.com>
> 
> This made me think, if we need something like tst_syscall_supported().
> If in future we'll have multiplex function with couple #ifdefs,
> we may hit TCONF (due to ENOSYS) before we iterate over all of them.

Valid point.

Another fix may involve forking a process for each testrun and handling
the exit value same way as we do for the all_filesystems flag, we would
have to hook up the multiplex before we fork the test process into the
tst_run_tcases() function.

-- 
Cyril Hrubis
chrubis@suse.cz
