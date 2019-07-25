From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Jul 2019 22:42:04 +0200
Subject: [LTP] [PATCH v2 LTP]:Skip the test if "htop" is used.
In-Reply-To: <20190725013011.39342-1-siliangx.yu@intel.com>
References: <20190725013011.39342-1-siliangx.yu@intel.com>
Message-ID: <20190725204204.GA31486@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> From: "Yu,Siliang" <siliangx.yu@intel.com>

> In some distro, "htop" is used instead "top", which doesn't support '-b'. Skip the test if "htop" is used.
> ---
>  .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh    | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> index 18a11197e..ddb6abf95 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> @@ -49,6 +49,11 @@ done

>  LOOP_COUNT=1

> +realtop=$(which top | xargs realpath | xargs basename)
> +if [[ $realtop == "htop" ]] ; then
== is also a bashism, please use = (+ [[ ]] => [ ]).

> +	tst_brkm TCONF "$realtop is used instead of top, Skip the test..."
> +fi
OK, v2. This looks better than v2, but I'd really use command version output
(top -v) to detect top vs. htop.

> +
>  if [ $(get_present_cpus_num) -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi

Kind regards,
Petr

PS: please don't use ltp-request and ltp-owner, these aren't meant for patch
submission.
