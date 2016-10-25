From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 25 Oct 2016 15:24:13 +0800
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh: add kernel
	version check
In-Reply-To: <1472544117-7584-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1472544117-7584-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <580F089D.9040401@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Ping, thanks!

Regards,
Guangwen Feng

On 08/30/2016 04:01 PM, Guangwen Feng wrote:
> Sysfs is not mount namespace aware until applying following kernel
> patches in mainline kernel v2.6.35:
> 
> a1b3f59 net: Expose all network devices in a namespaces in sysfs
> 417daa1 hotplug: netns aware uevent_helper
> d6523dd net/sysfs: Fix the bitrot in network device kobject namespace support
> 608b4b9 netns: Teach network device kobjects which namespace they are in
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> Tested-by: Matus Marhefka <mmarhefk@redhat.com>
> ---
>  testcases/kernel/containers/netns/netns_sysfs.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
> index 290cef8..b3a87ed 100644
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -29,6 +29,11 @@ DUMMYDEV_HOST="dummy_test0"
>  DUMMYDEV="dummy_test1"
>  . test.sh
>  
> +tst_kvercmp 2 6 35
> +if [ $? -eq 0 ]; then
> +	tst_brkm TCONF "sysfs is not mount namespace aware for kernels older than 2.6.35"
> +fi
> +
>  setns_check
>  if [ $? -eq 32 ]; then
>  	tst_brkm TCONF "setns not supported"
> 


