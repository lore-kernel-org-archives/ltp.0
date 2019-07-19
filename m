From: Zhang, Yixin <yixin.zhang@intel.com>
Date: Fri, 19 Jul 2019 18:50:12 +0800
Subject: [LTP] [PATCH LTP] - cpuhotplug06.sh:Add judgment for command
 "top".
In-Reply-To: <20190719040655.54345-1-siliangx.yu@intel.com>
References: <20190719040655.54345-1-siliangx.yu@intel.com>
Message-ID: <20190719105012.GA18145@yixin-dev>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Siliang,
There is some issue in your patch:

1. The "top" tool is not 100% located at /usr/bin/, you should use "which" cmd
    to check it
2. [[ -L "/usr/bin/top" ]] does not mean the case should go to TCONF. The real
    logic is the check the realpath of the top tool and check it's name, if the
    real name is not "top" (like "htop" in Clear Liunx case), TCONF the case.
    We don't care if it's a symlink or not, we just care if it's using the
    oringal top or an other top which may not support "top -b".
3. The error log is not correct. Clear Linux use symlink or Clear Liunx use
    "htop" doesn't go to the conclusion that if a distro use symlink or it use
    "htop" or some other "Xtop" so it's Clear Linux. We should not mention a
    specific distro name here. Same for commit message.
4. Take care of white spaces v.s. <tab>

Yixin

On 2019-07-19 at 12:06:55 +0800, Siliang,Yu wrote:
> From: "Yu,Siliang" <siliangx.yu@intel.com>
> 
> Only on clear linux OS,"top" is a link file.
> If it's clear linux,skip the test.
> 
> Signed-off-by: Yu,Siliang <siliangx.yu@intel.com>
> ---
>  .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh     | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> index 18a11197e..d5877d085 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> @@ -49,6 +49,10 @@ done
>  
>  LOOP_COUNT=1
>  
> +if [[ -L "/usr/bin/top" ]];then
> +        tst_brkm TCONF "Invalid argument on Clear Linux Skip the test..."
> +fi
> +
>  if [ $(get_present_cpus_num) -lt 2 ]; then
>  	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>  fi
> -- 
> 2.22.0
> 
