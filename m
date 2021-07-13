From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 13 Jul 2021 14:06:57 +0200
Subject: [LTP] Failing test on failing shell commands
In-Reply-To: <9c05b592-e474-6a3e-2dc1-ec075a0bc558@canonical.com>
References: <9c05b592-e474-6a3e-2dc1-ec075a0bc558@canonical.com>
Message-ID: <632cda7e-fe23-a0b6-cad8-4bd3aceac1d3@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13/07/2021 13:56, Krzysztof Kozlowski wrote:
> 
> Hi all,
> 
> I have a failing memcg_use_hierarchy_test (in
> testcases/kernel/controllers/memcg/functional/) which hits unexpected
> OOM on one of earlier commands, already in the test:
> 
>  18         echo 1 > memory.use_hierarchy
>  19         echo $PAGESIZE > memory.limit_in_bytes
>  20 
>  21         mkdir subgroup  
> mkdir: cannot create directory ?subgroup?: Cannot allocate memory
> /home/ubuntu/ltp-install/testcases/bin/memcg_use_hierarchy_test.sh: 22: cd: can't cd to subgroup
> 
> The command did not fail, as there is no "set -e" and test fails later.

Ah, I wanted to say:
"The command did not fail entire test, as there is no "set -e" and test
fails later."

> However there could be a case where such failure does not trigger later
> issue and test is a false-positive.
> 
> What is the practice for LTP shell tests to handle kind of preparation
> commands? Maybe this should be something like:
> 
> --------
> 
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
> index 8be342499ece..f8dd8946f80b 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
> @@ -18,8 +18,8 @@ test1()
>         echo 1 > memory.use_hierarchy
>         echo $PAGESIZE > memory.limit_in_bytes
>  
> -       mkdir subgroup
> -       cd subgroup
> +       EXPECT_PASS mkdir subgroup
> +       EXPECT_PASS cd subgroup
>         test_proc_kill $((PAGESIZE * 3)) "--mmap-lock1" $((PAGESIZE * 2)) 0
>  
>         cd ..
> 
> Best regards,
> Krzysztof
> 


Best regards,
Krzysztof
