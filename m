From: Li Wang <liwan@redhat.com>
Date: Mon, 3 Dec 2018 16:41:30 +0800
Subject: [LTP] [PATCH] syscalls/migrate_pages03: skip migratition of
	shared pages
In-Reply-To: <12d3ccf40055c225b97a4a94ed1c6a46d4fd2048.1543508512.git.jstancek@redhat.com>
References: <12d3ccf40055c225b97a4a94ed1c6a46d4fd2048.1543508512.git.jstancek@redhat.com>
Message-ID: <CAEemH2cLauQLtEPMjOsGdaFfndAW+Nzr=qiFWPyEWfaLjQh6ww@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Nov 30, 2018 at 12:29 AM Jan Stancek <jstancek@redhat.com> wrote:
>
> Fixes: #431
>
> Migrating shared pages (as root) includes also executable pages
> (glibc, etc.) Kernel might need to invalidate icache, which can
> be an expensive operation on some architectures (arm64).
>
> This test is repeating migration thousands of times, and because
> migration (and icache flush) runs for each page, it all stacks
> up and test is hitting a timeout.
>
> It's enough for this reproducer to migrate pages it allocates
> and merges (via KSM), so do the migration as unprivileged user
> and we can avoid the overhead of migrating everything. Such
> scenario is already covered by migrate_pages02.

I'm OK to drop privileges before calling migrate_pages() in this
testcase, but if we can start a new topic in LKML for more discussion
that would be better?

>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Li Wang <liwang@redhat.com>

--
Regards,
Li Wang
