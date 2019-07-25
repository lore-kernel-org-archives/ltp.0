From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Jul 2019 22:27:24 +0200
Subject: [LTP] [PATCH LTP] -Cpuhotplug06:Skip the test if "htop" is used.
In-Reply-To: <20190724234502.105332-1-siliangx.yu@intel.com>
References: <20190724234502.105332-1-siliangx.yu@intel.com>
Message-ID: <20190725202723.GA23767@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> From: "Yu,Siliang" <siliangx.yu@intel.com>

> In some distro, "htop" is used instead "top", which doesn't support '-b'. Skip the test if "htop" is used.
Could you be more specific (which distro, ...)?
Do you mean binary is top and it's a symlink (or something) to htop?
Trying to detect '>' suggests you target to symlink and the command on linew 76 is top
top -b -d 00.10 > /dev/null 2>&1 &

But in that case it'd be better to parse 'top -v'.

> ---
>  .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh    | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> index 18a11197e..ecf4eedea 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> @@ -49,6 +49,11 @@ done

>  LOOP_COUNT=1

> +LNTOP=$(ls -l $(which top) | cut -s -d ">" -f2)
> +if [[ -n $LNTOP ]] && [[ $LNTOP != "top" ]] ; then
[[ ]] is a bashism, please use [ ].

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style

> +	tst_brkm TCONF "Command doesn't support , Skip the test..."
> +fi
> +
>  if [ $(get_present_cpus_num) -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi

Kind regards,
Petr
