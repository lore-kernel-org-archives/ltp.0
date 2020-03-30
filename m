From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Mar 2020 14:13:43 +0800
Subject: [LTP] [PATCH 1/6] lib: Implement .needs_cmds
In-Reply-To: <20200327213924.18816-2-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-2-pvorel@suse.cz>
Message-ID: <CAEemH2c2Rq9x53fr2-KRaLpJ55xbuwVO96YWzJXAEdgcx2vvCQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Mar 28, 2020 at 5:39 AM Petr Vorel <pvorel@suse.cz> wrote:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New commit.
>
>  doc/test-writing-guidelines.txt | 15 +++++++++++++++
>  include/tst_test.h              |  3 +++
>  lib/tst_test.c                  | 11 +++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> index 32c9e87df..f7206f1bf 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -2023,6 +2023,21 @@ struct tst_test test = {
>  };
>
>  -------------------------------------------------------------------------------
>
> +2.2.35 Checking for required binaries
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>

Maybe better to talk commands but not binaries, since not all of the
commands are binary, there is possible python, perl or shell executable
file need check too. Isn't it?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200330/eb0ca710/attachment.htm>
