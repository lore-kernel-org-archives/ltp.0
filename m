From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 21 Sep 2015 10:00:56 -0400 (EDT)
Subject: [LTP] [PATCH v2] containers/netns/: fix kernel supporting check
In-Reply-To: <1442800874-3449-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <55FA99A3.8040006@cn.fujitsu.com>
 <1442800874-3449-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1823012470.14554531.1442844056556.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Guangwen Feng" <fenggw-fnst@cn.fujitsu.com>
> To: jstancek@redhat.com
> Cc: ltp@lists.linux.it, "Guangwen Feng" <fenggw-fnst@cn.fujitsu.com>
> Sent: Monday, 21 September, 2015 4:01:14 AM
> Subject: [PATCH v2] containers/netns/: fix kernel supporting check
> 
> On RHEL5.11GA, test result should be TCONF but not TFAIL since
> setns() is not supported, so fix this.
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

I slightly modified description, added setns_check to .gitignore,
tested on RHEL5.6 and pushed.

Thanks,
Jan

> ---
>  testcases/kernel/containers/netns/netns_helper.sh |  4 +++
>  testcases/kernel/containers/netns/netns_sysfs.sh  |  5 ++++
>  testcases/kernel/containers/share/setns_check.c   | 32
>  +++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>  create mode 100644 testcases/kernel/containers/share/setns_check.c
> 
> diff --git a/testcases/kernel/containers/netns/netns_helper.sh
> b/testcases/kernel/containers/netns/netns_helper.sh
> index cea1541..ac08125 100755
> --- a/testcases/kernel/containers/netns/netns_helper.sh
> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> @@ -110,6 +110,10 @@ netns_setup()
>  
>  	case "$1" in
>  	ns_exec)
> +		setns_check
> +		if [ $? -eq 32 ]; then
> +			tst_brkm TCONF "setns not supported"
> +		fi
>  		netns_ns_exec_setup
>  		TST_CLEANUP=netns_ns_exec_cleanup
>  		;;
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh
> b/testcases/kernel/containers/netns/netns_sysfs.sh
> index c10fa36..06de00f 100755
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -26,6 +26,11 @@ TCID="netns_sysfs"
>  TST_TOTAL=2
>  . test.sh
>  
> +setns_check
> +if [ $? -eq 32 ]; then
> +	tst_brkm TCONF "setns not supported"
> +fi
> +
>  cleanup()
>  {
>  	tst_rmdir
> diff --git a/testcases/kernel/containers/share/setns_check.c
> b/testcases/kernel/containers/share/setns_check.c
> new file mode 100644
> index 0000000..7ba891c
> --- /dev/null
> +++ b/testcases/kernel/containers/share/setns_check.c
> @@ -0,0 +1,32 @@
> +/* Copyright (c) 2015 Fujitsu Ltd.
> + * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of version 2 the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + ***********************************************************************
> + * Check for setns() availability, should be called before ns_exec.
> + *
> + */
> +
> +#include "test.h"
> +#include "linux_syscall_numbers.h"
> +
> +char *TCID = "setns_check";
> +
> +int main(void)
> +{
> +	if (syscall(__NR_setns, -1, 0) == -1 && errno == ENOSYS)
> +		tst_brkm(TCONF, NULL, "setns is not supported in the kernel");
> +	else
> +		return 0;
> +}
> --
> 1.8.4.2
> 
> 
