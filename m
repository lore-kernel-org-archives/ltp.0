Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xjpau-00069n-Ms
	for ltp-list@lists.sourceforge.net; Thu, 30 Oct 2014 13:16:52 +0000
Date: Thu, 30 Oct 2014 14:16:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141030131621.GC14847@rei.suse.de>
References: <3b5ef63b19fe7ac52dc6d3454760f2de344d62e8.1413538123.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b5ef63b19fe7ac52dc6d3454760f2de344d62e8.1413538123.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] cpuset_syscall_testset.sh: check TCONF for
 test 15, 16
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, jbeckenbach@lancope.com

Hi!
> If HAVE_DECL_MPOL_F_MEMS_ALLOWED is not defined, test 15 and 16,
> returns -1, which is evaluted as failure.
> 
> Treat it as TCONF, but don't break the execution, cpuset_syscall_testset.sh
> script is expecting to handle stopping/waiting for children by itself.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  .../cpuset_syscall_test/cpuset_syscall_test.c      |    6 +++---
>  .../cpuset_syscall_test/cpuset_syscall_testset.sh  |   14 ++++++++++++--
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
> index e202295..407b8c9 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
> +++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
> @@ -128,7 +128,7 @@ void sigint_handler(int __attribute__ ((unused)) signo)
>  void test_setaffinity(void)
>  {
>  	cpu_set_t tmask;
> -	int i;
> +	unsigned int i;
>  	CPU_ZERO(&tmask);
>  	for (i = 0; i < 8 * sizeof(mask); i++) {
>  		if ((1 << i) & mask)
> @@ -140,7 +140,7 @@ void test_setaffinity(void)
>  void test_getaffinity(void)
>  {
>  	cpu_set_t tmask;
> -	int i;
> +	unsigned int i;
>  	CPU_ZERO(&tmask);
>  	ret = sched_getaffinity(0, sizeof(tmask), &tmask);
>  	for (i = 0; i < 8 * sizeof(mask); i++) {
> @@ -190,7 +190,7 @@ void test_get_mempolicy(void)
>  	ret = get_mempolicy(NULL, bitmask_mask(nmask), bitmask_nbits(nmask), 0,
>  			    MPOL_F_MEMS_ALLOWED);
>  #else
> -	ret = -1;
> +	tst_resm(TCONF, "don't have MPOL_F_MEMS_ALLOWED");
>  #endif
>  
>  	bitmask_displaylist(str, 256, nmask);
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> index 561c3b9..bf1ec6c 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
> @@ -299,7 +299,12 @@ test14()
>  
>  test15()
>  {
> -	do_syscall_test 0 0 --get_mempolicy 0 || return 1
> +	do_syscall_test 0 0 --get_mempolicy 0
> +	ret=$?
> +
> +	grep "TCONF" "$TEST_OUTPUT" && return 0
> +	[ $ret -ne 0 ] && return 1
> +
>  	allowed_list="$(awk '/Mems_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
>  	test "$(cat "$TEST_OUTPUT")" = "0"
>  	if [ $? -ne 0 ]; then
> @@ -316,7 +321,12 @@ test15()
>  
>  test16()
>  {
> -	do_syscall_test 0 0-1 --get_mempolicy 0 || return 1
> +	do_syscall_test 0 0-1 --get_mempolicy 0
> +	ret=$?
> +
> +	grep "TCONF" "$TEST_OUTPUT" && return 0

I do not like much that we grep the test output for TCONF when we can
simply set ret to TCONF in the test and check the return value here...

Otherwise it's fine.

> +	[ $ret -ne 0 ] && return 1
> +
>  	allowed_list="$(awk '/Mems_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
>  	test "$(cat "$TEST_OUTPUT")" = "0-1"
>  	if [ $? -ne 0 ]; then

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
