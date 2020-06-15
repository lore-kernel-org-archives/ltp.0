From: Li Wang <liwang@redhat.com>
Date: Mon, 15 Jun 2020 15:47:31 +0800
Subject: [LTP] [PATCH v4] Wrapper for Syzkaller reproducers
In-Reply-To: <20200610072928.1331-1-rpalethorpe@suse.com>
References: <20200610072928.1331-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2fyJKyKwKzF4W35tM_sjbYQAf-Gx7-Vrhv6r+QdLE8+Bw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 10, 2020 at 3:29 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> Allows one to run the Syzkaller reproducers as part of the LTP.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Pter Vorel <pvorel@suse.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>

+
> +static void setup(void)
> +{
> +       tst_taint_init(TST_TAINT_W | TST_TAINT_D | TST_TAINT_L);
>

My only concern is that the limitation is too strict for syzkaller.

Because if one of the tests (near the top of the name rankings)
trigger a WARNING in SUT kernel, the syzwrap.c will be
skipping all remaining test cases.

Maybe we can just use 'TST_TAINT_D' here, and I wish to
hear more opinions from others.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200615/25a83f68/attachment.htm>
