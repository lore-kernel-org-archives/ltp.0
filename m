From: Li Wang <liwang@redhat.com>
Date: Mon, 12 Jul 2021 10:00:36 +0800
Subject: [LTP] [PATCH 1/1] tst_net.sh: Declare prefix variable as empty
In-Reply-To: <20210709140143.9180-1-pvorel@suse.cz>
References: <20210709140143.9180-1-pvorel@suse.cz>
Message-ID: <CAEemH2fB5VakafKhTgcOsvwK6Q50AJ3WcpRY2fSLfhB86b03Nw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 9, 2021 at 10:01 PM Petr Vorel <pvorel@suse.cz> wrote:

> From: Petr Vorel <petr.vorel@gmail.com>
>
> in tst_ipaddr_un(). This is required to fix problem on dash, which
> (unlike bash and busybox ash implementation) takes value of previously
> defined variable, i.e.  guarding with local does not work:
>
> $ foo=ee; bar() { local foo; echo "foo: '$foo'"; }; bar
> foo: 'ee'
>

I'm thinking maybe we should avoid defining the same name
variables like that. But anyway, your fix should be worked.

Reviewed-by: Li Wang <liwang@redhat.com>



>
> It requires declare it as empty:
> $ foo=ee; bar() { local foo=; echo "foo: '$foo'"; }; bar
> foo: ''
>
> This problem seems to be on various dash versions from 0.5.8 to
> 0.5.11+git20200708+dd9ef66-5 (on Debian oldstable, stable, testing).
> It'd require to set all variables, but now fix just prefix, which is
> used in build.sh and it's quite common name.
>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index db1db4790..52975f37b 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -408,7 +408,7 @@ tst_ipaddr_un()
>         local max_net_id=$default_max
>         local min_net_id=0
>
> -       local counter host_id host_range is_counter max_host_id
> min_host_id net_id prefix tmp type
> +       local counter host_id host_range is_counter max_host_id
> min_host_id net_id prefix= tmp type
>
>         local OPTIND
>         while getopts "c:h:n:p" opt; do
> --
> 2.26.2
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210712/436494f8/attachment.htm>
