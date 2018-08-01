From: Li Wang <liwang@redhat.com>
Date: Wed, 1 Aug 2018 19:09:05 +0800
Subject: [LTP] [RFC] [PATCH] lib: Fix result propagation after exec() +
	tst_reinit()
In-Reply-To: <20180731130852.22739-1-chrubis@suse.cz>
References: <20180731130852.22739-1-chrubis@suse.cz>
Message-ID: <CAEemH2e8nv3AhxRy3v=WJvi8eeAjDcxLp4v2GM_5Nb9jfUZnQA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jul 31, 2018 at 9:08 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> The result pointer wasn't initialized in tst_reinit(), which haven't
> allowed for test result propagation to the main test process and there
> is actually no reason not to do that. So this commit initializes the
> results pointer in tst_reinit() and also adds a needs_ipc_path flag to
> tst_test structure, which causes the library not to unlink the IPC file
> after it has been mapped and also inserts LTP_IPC_PATH to the
> environment.
>
> This commit also adds a test that also shows the usage of the API.
> ...
>
>         ptr = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
> fd, 0);
> +       results = ptr;
>

The ptr seems redundant here, I suggest to remove it from tst_reinit().

Others looks good to me.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180801/187c7173/attachment.html>
