From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Aug 2021 17:52:19 +0200
Subject: [LTP] [PATCH 1/1] doc: Specify linux-stable-git rule
In-Reply-To: <20210715065805.14086-1-pvorel@suse.cz>
References: <20210715065805.14086-1-pvorel@suse.cz>
Message-ID: <YQq3s+33ceaJmvR7@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/c-test-api.txt | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 45784195b..9d26a483d 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -2205,6 +2205,10 @@ struct tst_test test = {
>  };
>  -------------------------------------------------------------------------------

> +NOTE: We don't track all backports to stable kernel but just those which are
> +      stable branch specific (unique), i.e. no commit in mainline. Example of
> +      commits: c4a23c852e80, cac68d12c531.
> +
>  Glibc git commit in a regression test for a glibc bug:
>  [source,c]
>  -------------------------------------------------------------------------------
Any comment on this? I should have marked it as [RFC].

Kind regards,
Petr
