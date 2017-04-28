From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 28 Apr 2017 02:58:16 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] tst_kvcmp: Add support for extra kernel
	versions
In-Reply-To: <20170427145030.GA28668@rei.lan>
References: <20170421155244.29773-1-chrubis@suse.cz>
 <343130515.905228.1493020687050.JavaMail.zimbra@redhat.com>
 <20170426150641.GA6165@rei.suse.de>
 <1624205915.3497140.1493281707439.JavaMail.zimbra@redhat.com>
 <20170427130152.GA14404@rei.lan>
 <316485995.3602202.1493299267158.JavaMail.zimbra@redhat.com>
 <20170427145030.GA28668@rei.lan>
Message-ID: <393298286.4053142.1493362696367.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> Hi!
> I've pushed the original patch with added -77 to the example in the
> commit message.
> 
> Now this patch should fix the missing commands:
> 
> From da7a8f38d34659f4e02631c2e0a0f49e59edfbfa Mon Sep 17 00:00:00 2001
> From: Cyril Hrubis <chrubis@suse.cz>
> Date: Thu, 27 Apr 2017 16:48:02 +0200
> Subject: [PATCH] cpuset: Make use of tst_kvcmp
> 
> The tst_kvercmp2 was removed in:
> 
> commit 4847f1c13dabbfadd612aa812e2c99973f35f230
> Author: Cyril Hrubis <chrubis@suse.cz>
> Date:   Mon Nov 14 13:44:45 2016 +0100
> 
>     apicmd: Get rid of tst_kvercmp* binaries.
> 
> And these calls were not fixed beforehand.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh          | 6
>  ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git
> a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
> b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
> index 63a9dc5..992b8f2 100755
> ---
> a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
> +++
> b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
> @@ -128,8 +128,7 @@ test_cpus()
>  		base_op_test "$CPUSET/1/cpus" "0,1-$((nr_cpus-2))," "0-$((nr_cpus-2))"
>  	fi
>  
> -	tst_kvercmp2 3 0 0 "RHEL6:2.6.32"
> -	if [ $? -eq 0 ]; then
> +	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
>  		base_op_test "$CPUSET/1/cpus" "0-" "WRITE_ERROR"
>  	else
>  		base_op_test "$CPUSET/1/cpus" "0-" "0"
> @@ -164,8 +163,7 @@ test_mems()
>  		base_op_test "$CPUSET/1/mems" "0,1-$((nr_mems-2))," "0-$((nr_mems-2))"
>  	fi
>  
> -	tst_kvercmp2 3 0 0 "RHEL6:2.6.32"
> -	if [ $? -eq 0 ]; then
> +	if tst_kvcmp -lt "3.0 RHEL6:2.6.32"; then
>  		base_op_test "$CPUSET/1/mems" "0-" "WRITE_ERROR"
>  	else
>  		base_op_test "$CPUSET/1/mems" "0-" "0"
> --
> 2.10.2
> 
> 
> OK to commit?

Yes.

Thanks,
Jan
