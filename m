From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Sep 2019 11:00:56 +0200
Subject: [LTP] [PATCH v4 LTP] Skip the test if "htop" is used.
In-Reply-To: <20190910162337.60664-1-siliangx.yu@intel.com>
References: <20190910162337.60664-1-siliangx.yu@intel.com>
Message-ID: <20190911090055.GA13219@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yu,

> From: "Yu,Siliang" <siliangx.yu@intel.com>

> In clear linux os, "htop" is used instead "top", which doesn't support '-b'. Skip the test on clear linux.

> Signed-off-by: Yu,Siliang <siliangx.yu@intel.com>
> ---
>  .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh     | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> index 18a11197e..74a3dd2b1 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> @@ -49,6 +49,10 @@ done

>  LOOP_COUNT=1

> +if top -v | grep -q htop; then
> +	tst_brkm TCONF "htop is used instead of top, Skip the test(workaround: alias top='/path/to/real/top')"
> +fi
Merged, with slightly adjusted commit message.

Kind regards,
Petr
