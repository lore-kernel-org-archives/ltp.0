From: Jiri Jaburek <jjaburek@redhat.com>
Date: Wed, 26 Oct 2016 20:17:06 +0200
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh: add kernel
 version check
In-Reply-To: <1472544117-7584-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1472544117-7584-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <ed067bc2-ab8e-3b7e-476c-d24e39560700@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/30/16 10:01, Guangwen Feng wrote:
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

Just out of curiosity - I see this used on more places, but can't
understand why would you use this instead of simply

  if tst_kvercmp 2 6 35; then

Any reason behind that? Am I missing a test writing rule?

Thanks.

> +	tst_brkm TCONF "sysfs is not mount namespace aware for kernels older than 2.6.35"
> +fi
> +
>  setns_check
>  if [ $? -eq 32 ]; then
>  	tst_brkm TCONF "setns not supported"
> 

