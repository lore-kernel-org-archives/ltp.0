From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Mar 2019 18:17:27 -0400 (EDT)
Subject: [LTP] [PATCH v3] syscall: Add userfaultfd testcase
In-Reply-To: <20190315094558.17139-1-camann@suse.com>
References: <20190315094558.17139-1-camann@suse.com>
Message-ID: <100593127.9468868.1552688247623.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This tests the userfaultfd syscall to handle pagefault events.
> It does so by registering a userfaultfd object to the address of
> a memory page. In a second thread it handles the event and writes
> data in the monitored memory page to indicate success.
> 
> Signed-off-by: Christian Amann <camann@suse.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

Couple small nits below (no need to repost).

syscall -> syscalls in subject

> +
> +static int userfaultfd(int flags)

If glibc ever provides func, my money would be on this :-).
But looking at HEAD, we're safe now.

Thanks,
Jan
