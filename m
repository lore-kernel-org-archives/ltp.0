From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Nov 2017 14:52:14 +0300
Subject: [LTP] [PATCH] runpwtests03:skip read check for
 cpufreq/stats/reset file
In-Reply-To: <1511164904-10019-1-git-send-email-shuang.qiu@oracle.com>
References: <1511164904-10019-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <1db5e071-42ca-5cc7-f9d9-e28abd25e01e@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/20/2017 11:01 AM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
>
> According to the cpufreq-stats doc,cpufreq/stats/reset is
> write-only attribute of cpu freq sysfs file.
> So skip the cat checking for this file.
>
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> ---
>  testcases/kernel/power_management/runpwtests03.sh |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
> index d4ea88b..00f6e02 100755
> --- a/testcases/kernel/power_management/runpwtests03.sh
> +++ b/testcases/kernel/power_management/runpwtests03.sh
> @@ -35,6 +35,7 @@ check_cpufreq_sysfs_files() {
>  			-name "*" -type f)
>  		for files in ${cpufiles}
>  		do
> +			[ "$files" = "/sys/devices/system/cpu/cpu${cpu}/cpufreq/stats/reset" ] && continue
>  			cat ${files} >/dev/null 2>&1

May be better update the above 'find' command to match only files that
have read permission, e.g. add '-readable' option?

Thanks,
Alexey

