From: Enji Cooper <yaneurabeya@gmail.com>
Date: Thu, 21 Jan 2021 07:37:05 -0800
Subject: [LTP] [PATCH 1/1] travis: Test NUMA also on Fedora/CentOS
In-Reply-To: <20210121105959.1002-1-pvorel@suse.cz>
References: <20210121105959.1002-1-pvorel@suse.cz>
Message-ID: <4303D927-20AA-4161-A91B-460FE14E1703@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed by: Enji Cooper <yaneurabeya@gmail.com>

> On Jan 21, 2021, at 03:00, Petr Vorel <pvorel@suse.cz> wrote:
> 
> ?Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> tested (affected distros only)
> https://travis-ci.org/github/pevik/ltp/builds/755505691
> 
> Kind regards,
> Petr
> 
> travis/fedora.sh | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/travis/fedora.sh b/travis/fedora.sh
> index 665915a47..ef2d32f47 100755
> --- a/travis/fedora.sh
> +++ b/travis/fedora.sh
> @@ -13,6 +13,7 @@ $yum \
>    gcc \
>    git \
>    findutils \
> +    numactl-devel \
>    libtirpc \
>    libtirpc-devel \
>    perl-JSON \
> -- 
> 2.30.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
