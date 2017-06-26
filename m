From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Jun 2017 12:04:47 +0200
Subject: [LTP] [PATCH 1/1] ver_linux: Print sysctl settings
In-Reply-To: <20170425100335.20017-1-pvorel@suse.cz>
References: <20170425100335.20017-1-pvorel@suse.cz>
Message-ID: <20170626100447.f3kviwhmtjy2qbdu@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  ver_linux | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/ver_linux b/ver_linux
> index a403b4e43..f58de9f65 100755
> --- a/ver_linux
> +++ b/ver_linux
> @@ -87,3 +87,7 @@ free
>  echo
>  echo '/proc/cpuinfo'
>  cat /proc/cpuinfo
> +
> +echo
> +echo 'sysctl settings:'
> +sysctl -a

Ping.
It might be useful to get output of env to see environment variables.


Kind regards,
Petr
