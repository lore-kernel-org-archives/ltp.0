From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 6 Nov 2015 04:01:51 -0500 (EST)
Subject: [LTP] [PATCH 2/2] Optimise grep action in cpuset_syscall_test
In-Reply-To: <1444872089-30094-2-git-send-email-sunyuan3@huawei.com>
References: <1444872089-30094-1-git-send-email-sunyuan3@huawei.com>
 <1444872089-30094-2-git-send-email-sunyuan3@huawei.com>
Message-ID: <73184761.4412729.1446800511159.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Yuan Sun" <sunyuan3@huawei.com>
> To: jstancek@redhat.com
> Cc: ltp@lists.linux.it
> Sent: Thursday, 15 October, 2015 3:21:29 AM
> Subject: [PATCH 2/2] Optimise grep action in cpuset_syscall_test
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>  .../cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh     | 12
>  ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git
> a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> index 771b642..9d3e4c8 100755
> ---
> a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> +++
> b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> @@ -188,7 +188,7 @@ test7()
>  	do_syscall_test 0 0 --mbind=1 0 || return $?
>  	memory_addr="$(cat $TEST_OUTPUT)"
>  	memory_addr=${memory_addr##*0x}
> -	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
> +	allowed_list=$(grep "$memory_addr" $TEST_PROCNUMA | \
>  			awk '{print $2}')
>  	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
>  	test "$allowed_list" = "0" || return 1
> @@ -204,7 +204,7 @@ test8()
>  	do_syscall_test 0 0-1 --mbind=1 0 || return $?
>  	memory_addr="$(cat $TEST_OUTPUT)"
>  	memory_addr=${memory_addr##*0x}
> -	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
> +	allowed_list=$(grep "$memory_addr" $TEST_PROCNUMA | \
>  			awk '{print $2}')
>  	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
>  	test "$allowed_list" = "0"
> @@ -220,7 +220,7 @@ test9()
>  	do_syscall_test 0 0-1 --mbind=6 0 || return $?
>  	memory_addr="$(cat $TEST_OUTPUT)"
>  	memory_addr=${memory_addr##*0x}
> -	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
> +	allowed_list=$(grep "$memory_addr" $TEST_PROCNUMA | \
>  			awk '{print $2}')
>  	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
>  	test "$allowed_list" = "1"
> @@ -236,12 +236,12 @@ test10()
>  	do_syscall_test 0 0 --mbind=6 1 || return $?
>  	memory_addr="$(cat $TEST_OUTPUT)"
>  	memory_addr=${memory_addr##*0x}
> -	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
> +	allowed_list=$(grep "$memory_addr" $TEST_PROCNUMA | \
>  			awk '{print $2}')
>  	allowed_list="$(echo $allowed_list | sed -e s/bind://)"
>  
> -	task_policy=$(cat $TEST_PROCNUMA | grep -e "  *stack  *anon" | \
> -			awk '{print $2}')
> +	task_policy=$(grep -e "  *stack  *anon" | \
> +			awk '{print $2}' $TEST_PROCNUMA)

Shouldn't this last one be:
+	task_policy=$(grep -e "  *stack  *anon" $TEST_PROCNUMA | \
+			awk '{print $2}')

Regards,
Jan

>  
>  	test "$allowed_list" = "$task_policy"
>  	if [ $? -ne 0 ]; then
> --
> 1.9.1
> 
> 
