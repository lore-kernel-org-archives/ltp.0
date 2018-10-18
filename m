From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 18 Oct 2018 19:03:34 +0300
Subject: [LTP] [PATCH v2 1/1] net: Fix missing ping6
In-Reply-To: <20181018144211.8298-1-pvorel@suse.cz>
References: <20181018144211.8298-1-pvorel@suse.cz>
Message-ID: <61a9206d-2af4-396a-44dc-ecff4f4ce27f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18.10.2018 17:42, Petr Vorel wrote:
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index a4467da7c..29080f92b 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -756,3 +756,11 @@ export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
>  if [ -n "$TST_USE_LEGACY_API" ]; then
>  	tst_net_remote_tmpdir
>  fi
> +
> +if ! tst_cmd_available ping6; then
> +	ping6()
> +	{

What about printing the message on the first usage only?

                if [ -z "$ping6_warn_printed" ]; then
                        tst_res_ TINFO "ping6 ..."
                        ping6_warn_printed=yes
                fi

> +		ping -6 $@
> +	}
> +	tst_res_ TINFO "ping6 binary/symlink is missing, using workaround. Please, report missing ping6 to your distribution."
> +fi

The rest looks good.
