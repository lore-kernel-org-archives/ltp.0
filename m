Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YnRXB-000511-7V
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 12:56:13 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YnRXA-00046R-5z
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 12:56:13 +0000
Message-ID: <5540D4E3.30800@oracle.com>
Date: Wed, 29 Apr 2015 15:56:03 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <cover.1430305546.git.jstancek@redhat.com>
	<1fa1d110f42b66a5b550ddb72473d4ebee026c15.1430305546.git.jstancek@redhat.com>
In-Reply-To: <1fa1d110f42b66a5b550ddb72473d4ebee026c15.1430305546.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 2/4] cpu_hotplug: add get_hotplug_cpus,
	get_present_cpus
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>, ltp-list@lists.sourceforge.net



On 04/29/2015 02:17 PM, Jan Stancek wrote:
> From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   .../cpu_hotplug/include/cpuhotplug_hotplug.sh      | 73 +++++++++++++++++++++-
>   1 file changed, 70 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> index f553d0c..a1c6ef6 100644
> --- a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> @@ -126,11 +126,78 @@ get_cpus_num()
>   #
>   get_all_cpus()
>   {
> -    [ -d /sys/devices/system/cpu/cpu0 ] || return 1
> -    ls -dr /sys/devices/system/cpu/cpu[0-9]* | \
> -        sed "s/\/sys\/devices\/system\/cpu\///g" || return 2
> +    [ -d /sys/devices/system/cpu ] || return 1
> +    (cd /sys/devices/system/cpu; ls -d cpu[0-9]*)
>   }
>
> +# get_present_cpus()
> +#
> +#  Prints a list of present CPUs, regardless of whether they're
> +#  currently online or offline.
> +#
> +get_present_cpus()
> +{
> +    # if sysfs present mask is missing, assume all cpu are present
> +    if [ ! -e /sys/devices/system/cpu/present ]; then
> +        get_all_cpus
> +        return
> +    fi
> +
> +    local present_mask="/sys/devices/system/cpu/present"
Maybe use this variable in the above 'if [ ! -e 
/sys/devices/system/cpu/present]' ?


> +    local present_cpus=""
> +
> +    for part in $(cat $present_mask | tr "," " "); do
> +        if echo $part | grep -q "-"; then
> +            range_low=$(echo $part | cut -d - -f 1)
> +            range_high=$(echo $part | cut -d - -f 2)
> +        else
> +            range_low=$(part)
> +            range_high=$(part)
> +        fi
> +        for cpu in $(seq $range_low $range_high); do
> +            if [ -e /sys/devices/system/cpu/cpu$cpu ]; then
> +                present_cpus="$present_cpus cpu$cpu"
> +            fi
> +        done
> +    done
> +    echo $present_cpus
> +}
> +
> +# get_present_cpus_num()
> +#
> +#  Prints the number of present CPUs
> +#
> +get_present_cpus_num()
> +{
> +    return $(get_present_cpus | wc -w)
> +}
> +
> +# get_hotplug_cpus()
> +#
> +#  Prints a list of present hotpluggable CPUs, regardless of whether they're
> +#  currently online or offline.
> +#
> +get_hotplug_cpus()
> +{
> +    local present_cpus=$(get_present_cpus)
> +    local hotplug_cpus=""
> +
> +    for cpu in $present_cpus; do
> +        if [ -e /sys/devices/system/cpu/$cpu/online ]; then
> +            hotplug_cpus="$hotplug_cpus $cpu"
> +	fi
> +    done
> +    echo $hotplug_cpus
> +}
> +
> +# get_hotplug_cpus_num()
> +#
> +#  Prints the number of hotpluggable CPUs
> +#
> +get_hotplug_cpus_num()
> +{
> +    return $(get_hotplug_cpus | wc -w)
> +}
>
>   # get_all_cpu_states()
>   #
>

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
