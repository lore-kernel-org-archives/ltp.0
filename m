From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 9 Nov 2015 07:10:45 -0500 (EST)
Subject: [LTP] [PATCH 1/2] Simplify grep actions in power_management.
In-Reply-To: <1447056334-28420-1-git-send-email-sunyuan3@huawei.com>
References: <1447056334-28420-1-git-send-email-sunyuan3@huawei.com>
Message-ID: <1718322603.5529740.1447071045814.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Yuan Sun" <sunyuan3@huawei.com>
> To: chrubis@suse.cz, jstancek@redhat.com
> Cc: ltp@lists.linux.it
> Sent: Monday, 9 November, 2015 9:05:33 AM
> Subject: [PATCH 1/2] Simplify grep actions in power_management.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Both pushed.

Regards,
Jan

> ---
>  testcases/kernel/power_management/pm_include.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/power_management/pm_include.sh
> b/testcases/kernel/power_management/pm_include.sh
> index 366c914..d06286b 100755
> --- a/testcases/kernel/power_management/pm_include.sh
> +++ b/testcases/kernel/power_management/pm_include.sh
> @@ -87,8 +87,8 @@ get_supporting_govr() {
>  }
>  
>  is_hyper_threaded() {
> -	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> -	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> +	siblings=`grep siblings /proc/cpuinfo | uniq | cut -f2 -d':'`
> +	cpu_cores=`grep "cpu cores" /proc/cpuinfo | uniq | cut -f2 -d':'`
>  	[ $siblings -gt $cpu_cores ]; echo $?
>  }
>  
> @@ -131,8 +131,8 @@ is_multi_socket() {
>  }
>  
>  is_multi_core() {
> -	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> -	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> +	siblings=`grep siblings /proc/cpuinfo | uniq | cut -f2 -d':'`
> +	cpu_cores=`grep "cpu cores" /proc/cpuinfo | uniq | cut -f2 -d':'`
>  	if [ $siblings -eq $cpu_cores ]; then
>  		[ $cpu_cores -gt 1 ]; echo $?
>  	else
> @@ -142,8 +142,8 @@ is_multi_core() {
>  }
>  
>  is_dual_core() {
> -	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> -        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq \
> +	siblings=`grep siblings /proc/cpuinfo | uniq | cut -f2 -d':'`
> +	cpu_cores=`grep "cpu cores" /proc/cpuinfo | uniq \
>  			| cut -f2 -d':'`
>          if [ $siblings -eq $cpu_cores ]; then
>                  [ $cpu_cores -eq 2 ]; echo $?
> --
> 1.9.1
> 
> 
