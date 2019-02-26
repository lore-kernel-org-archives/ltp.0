From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Feb 2019 14:32:56 +0530
Subject: [LTP] [PATCH v4 9/9] syscalls/sync_file_range: add sync device
	test-case
In-Reply-To: <20190225152640.GD6132@rei.lan>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
 <1550739616-24054-10-git-send-email-sumit.garg@linaro.org>
 <20190225152640.GD6132@rei.lan>
Message-ID: <CAFA6WYP8GF3JuUZfn6wt-cKv+RZ5PDy6W_KOs0L753Mj_xE_xw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 25 Feb 2019 at 20:57, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> This tests fails for me for fuse based filesystems, the call returns 0
> but does not write anything, the questions is if this is desired
> behavior or not.
>

Interesting case. Do you see similar behaviour with other sync related syscalls?

AFAIK, fuse file-system operations are implemented in user-space
daemons exported to kernel as callbacks via libfuse. Maybe we need to
check fsync() callback operation [1] implementation?

[1] https://libfuse.github.io/doxygen/structfuse__operations.html

> Also we should as well add a second test here that sync only a middle of
> a written region of a file and expects that the data written are
> somewhere between a few percents of the synced size.
>

Sure, will add a test for this.

-Sumit

> --
> Cyril Hrubis
> chrubis@suse.cz
