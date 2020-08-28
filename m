From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Aug 2020 09:18:57 +0200
Subject: [LTP] [PATCH v2] travis: Use centos:7 instead of centos:6
In-Reply-To: <1598339667-24948-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200825064706.GA7135@x230>
 <1598339667-24948-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200828071857.GB24100@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> I have this idea when I meet ALG_SET_AEAD_ASSOCLEN undefined error on centos7.
> It is more friendly for centos7 user and more meaningful. centos6 is outdated
> and we should drop it.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/.travis.yml b/.travis.yml
> index e8e3189af..3c5ff99b7 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -44,7 +44,7 @@ matrix:
>            compiler: clang

>          - os: linux
> -          env: DISTRO=centos:6 TREE=out
> +          env: DISTRO=centos:7 TREE=out
>            compiler: gcc

>          - os: linux
