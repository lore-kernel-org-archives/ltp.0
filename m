From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Oct 2020 18:38:05 +0800
Subject: [LTP] [PATCH 09/11] travis: Install docparse dependencies
In-Reply-To: <20201005133054.23587-10-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
 <20201005133054.23587-10-chrubis@suse.cz>
Message-ID: <CAEemH2eAy-037WvoBVqGfUVOvHNuFv=mRdexgS77xhpxGKXJeg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:
...
> --- a/travis/fedora.sh
> +++ b/travis/fedora.sh
> @@ -2,7 +2,10 @@
>  # Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
>  set -ex
>
> -yum -y install \
> +yum="yum -y install"
> +
> +$yum \
> +       asciidoc \
>         autoconf \
>         automake \
>         make \
> @@ -12,8 +15,10 @@ yum -y install \
>         findutils \
>         libtirpc \
>         libtirpc-devel \
> +       perl-JSON \

Package perl-libwww-perl is needed for fedora/centos as well.

-- 
Regards,
Li Wang

