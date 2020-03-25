From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Mar 2020 16:27:49 +0800
Subject: [LTP] [PATCH v2 1/2] lib: Implement SAFE_RUN() macro (new API
 only)
In-Reply-To: <20200323091852.29106-1-pvorel@suse.cz>
References: <20200323091852.29106-1-pvorel@suse.cz>
Message-ID: <CAEemH2fdecDCWuRhhDq6og=gtcHPO5hUxxzt-7F4vxqR6bW7KA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Mon, Mar 23, 2020 at 5:19 PM Petr Vorel <pvorel@suse.cz> wrote:

> Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> +       switch ((rval = tst_run_cmd(argv, stdout_path, stderr_path, 1))) {
> +       case 0:
> +               break;
> +       case 255:
> +               tst_brk(TCONF, "%s:%d: %s not found in $PATH", file,
> lineno, argv[0]);
> +               break;
>

Yes, we can remove this TCONF after adding the command checking in
tst_run_cmd_fds_(). So now I think it's OK to apply this patchset and do
the remaining work separately. Thanks Petr!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200325/139db264/attachment.htm>
