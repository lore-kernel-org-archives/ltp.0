Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1XbItW-0007qr-53
	for ltp-list@lists.sourceforge.net; Tue, 07 Oct 2014 00:44:50 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XbItT-0007Mg-Fs
	for ltp-list@lists.sourceforge.net; Tue, 07 Oct 2014 00:44:49 +0000
Message-ID: <5433374A.3040406@cn.fujitsu.com>
Date: Tue, 7 Oct 2014 08:43:54 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <a710c99deb86fdad787e0530013b20913de57dbe.1412604688.git.jstancek@redhat.com>
In-Reply-To: <a710c99deb86fdad787e0530013b20913de57dbe.1412604688.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v2] checkpoints: introduce
	TST_CHECKPOINT_CREATE
Reply-To: gaowanlong@cn.fujitsu.com
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
To: ltp-list@lists.sourceforge.net

On 10/06/2014 10:55 PM, Jan Stancek wrote:
> Rename tst_checkpoint_init to tst_checkpoint_create.
> Add tst_checkpoint_init, which only initializes checkpoint struct.
> Update existing testcases to use TST_CHECKPOINT_CREATE.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>


Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


> ---
>  include/tst_checkpoint.h                           |   10 ++++++++--
>  lib/tests/tst_checkpoint_child.c                   |    2 +-
>  lib/tests/tst_checkpoint_child_exits.c             |    2 +-
>  lib/tests/tst_checkpoint_no_child.c                |    2 +-
>  lib/tests/tst_checkpoint_parent.c                  |    2 +-
>  lib/tests/tst_checkpoint_parent_exits.c            |    2 +-
>  lib/tst_checkpoint.c                               |   20 ++++++++++++++------
>  .../kernel/containers/mountns/mountns_helper.h     |    4 ++--
>  testcases/kernel/syscalls/creat/creat07.c          |    2 +-
>  testcases/kernel/syscalls/flock/flock03.c          |    2 +-
>  testcases/kernel/syscalls/setpgid/setpgid03.c      |    2 +-
>  testcases/kernel/syscalls/waitid/waitid02.c        |    2 +-
>  12 files changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
> index 4d04c0e..6ea3366 100644
> --- a/include/tst_checkpoint.h
> +++ b/include/tst_checkpoint.h
> @@ -51,10 +51,16 @@ struct tst_checkpoint {
>   * Checkpoint initializaton, must be done first.
>   */
>  #define TST_CHECKPOINT_INIT(self) \
> -        tst_checkpoint_init(__FILE__, __LINE__, self)
> +	tst_checkpoint_init(__FILE__, __LINE__, self)
>  
>  void tst_checkpoint_init(const char *file, const int lineno,
> -                         struct tst_checkpoint *self);
> +			 struct tst_checkpoint *self);
> +
> +#define TST_CHECKPOINT_CREATE(self) \
> +	tst_checkpoint_create(__FILE__, __LINE__, self)
> +
> +void tst_checkpoint_create(const char *file, const int lineno,
> +			   struct tst_checkpoint *self);
>  
>  /*
>   * Wait called from parent. In case parent waits for child.
> diff --git a/lib/tests/tst_checkpoint_child.c b/lib/tests/tst_checkpoint_child.c
> index 9ce93f5..a13a9a2 100644
> --- a/lib/tests/tst_checkpoint_child.c
> +++ b/lib/tests/tst_checkpoint_child.c
> @@ -35,7 +35,7 @@ int main(void)
>  
>  	tst_tmpdir();
>  
> -	TST_CHECKPOINT_INIT(&checkpoint);
> +	TST_CHECKPOINT_CREATE(&checkpoint);
>  
>  	pid = fork();
>  
> diff --git a/lib/tests/tst_checkpoint_child_exits.c b/lib/tests/tst_checkpoint_child_exits.c
> index 3488ba2..d2e3f74 100644
> --- a/lib/tests/tst_checkpoint_child_exits.c
> +++ b/lib/tests/tst_checkpoint_child_exits.c
> @@ -35,7 +35,7 @@ int main(void)
>  
>  	tst_tmpdir();
>  
> -	TST_CHECKPOINT_INIT(&checkpoint);
> +	TST_CHECKPOINT_CREATE(&checkpoint);
>  
>  	pid = fork();
>  
> diff --git a/lib/tests/tst_checkpoint_no_child.c b/lib/tests/tst_checkpoint_no_child.c
> index fcf2745..2e72198 100644
> --- a/lib/tests/tst_checkpoint_no_child.c
> +++ b/lib/tests/tst_checkpoint_no_child.c
> @@ -39,7 +39,7 @@ int main(void)
>  
>  	tst_tmpdir();
>  
> -	TST_CHECKPOINT_INIT(&checkpoint);
> +	TST_CHECKPOINT_CREATE(&checkpoint);
>  	TST_CHECKPOINT_SIGNAL_CHILD(cleanup, &checkpoint);
>  	fprintf(stderr, "Parent: checkpoint reached\n");
>  
> diff --git a/lib/tests/tst_checkpoint_parent.c b/lib/tests/tst_checkpoint_parent.c
> index a2ae621..a42b37a 100644
> --- a/lib/tests/tst_checkpoint_parent.c
> +++ b/lib/tests/tst_checkpoint_parent.c
> @@ -35,7 +35,7 @@ int main(void)
>  
>  	tst_tmpdir();
>  
> -	TST_CHECKPOINT_INIT(&checkpoint);
> +	TST_CHECKPOINT_CREATE(&checkpoint);
>  
>  	pid = fork();
>  
> diff --git a/lib/tests/tst_checkpoint_parent_exits.c b/lib/tests/tst_checkpoint_parent_exits.c
> index 59c5356..3056c2c 100644
> --- a/lib/tests/tst_checkpoint_parent_exits.c
> +++ b/lib/tests/tst_checkpoint_parent_exits.c
> @@ -35,7 +35,7 @@ int main(void)
>  
>  	tst_tmpdir();
>  
> -	TST_CHECKPOINT_INIT(&checkpoint);
> +	TST_CHECKPOINT_CREATE(&checkpoint);
>  
>  	pid = fork();
>  
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 7391a28..ebc379e 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -74,12 +74,6 @@ void tst_checkpoint_init(const char *file, const int lineno,
>  	static unsigned int fifo_counter = 0;
>  	int rval;
>  
> -	if (!tst_tmpdir_created()) {
> -		tst_brkm(TBROK, NULL, "Checkpoint could be used only in test "
> -		                      "temporary directory at %s:%d",
> -				      file, lineno);
> -	}
> -	
>  	/* default values */
>  	rval = snprintf(self->file, TST_FIFO_LEN, "tst_checkopoint_fifo_%u",
>  			fifo_counter++);
> @@ -90,6 +84,20 @@ void tst_checkpoint_init(const char *file, const int lineno,
>  	}
>  	self->retval = 1;
>  	self->timeout = 5000;
> +}
> +
> +void tst_checkpoint_create(const char *file, const int lineno,
> +			   struct tst_checkpoint *self)
> +
> +{
> +
> +	if (!tst_tmpdir_created()) {
> +		tst_brkm(TBROK, NULL, "Checkpoint could be used only in test "
> +				      "temporary directory at %s:%d",
> +				      file, lineno);
> +	}
> +
> +	tst_checkpoint_init(file, lineno, self);
>  
>  	if (mkfifo(self->file, 0666)) {
>  		tst_brkm(TBROK | TERRNO, NULL,
> diff --git a/testcases/kernel/containers/mountns/mountns_helper.h b/testcases/kernel/containers/mountns/mountns_helper.h
> index cb9c16d..d4a6a91 100644
> --- a/testcases/kernel/containers/mountns/mountns_helper.h
> +++ b/testcases/kernel/containers/mountns/mountns_helper.h
> @@ -57,8 +57,8 @@ static void setup(void)
>  	tst_require_root(NULL);
>  	check_newns();
>  	tst_tmpdir();
> -	TST_CHECKPOINT_INIT(&checkpoint1);
> -	TST_CHECKPOINT_INIT(&checkpoint2);
> +	TST_CHECKPOINT_CREATE(&checkpoint1);
> +	TST_CHECKPOINT_CREATE(&checkpoint2);
>  	SAFE_MKDIR(cleanup, DIRA, 0777);
>  	SAFE_MKDIR(cleanup, DIRB, 0777);
>  	SAFE_TOUCH(cleanup, DIRA"/A", 0, NULL);
> diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
> index a9f5253..4b8958f 100644
> --- a/testcases/kernel/syscalls/creat/creat07.c
> +++ b/testcases/kernel/syscalls/creat/creat07.c
> @@ -108,7 +108,7 @@ static void setup(char *app)
>  
>  	TST_RESOURCE_COPY(cleanup, TEST_APP, NULL);
>  	
> -	TST_CHECKPOINT_INIT(&checkpoint);
> +	TST_CHECKPOINT_CREATE(&checkpoint);
>  
>  	TEST_PAUSE;
>  }
> diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.c
> index b2734b5..446dc84 100644
> --- a/testcases/kernel/syscalls/flock/flock03.c
> +++ b/testcases/kernel/syscalls/flock/flock03.c
> @@ -186,7 +186,7 @@ static void setup(void)
>  
>  	tst_tmpdir();
>  
> -	TST_CHECKPOINT_INIT(&checkpoint);
> +	TST_CHECKPOINT_CREATE(&checkpoint);
>  
>  	fd = creat(FILE_NAME, 0666);
>  	if (fd < 0) {
> diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
> index a107c50..c1b9951 100644
> --- a/testcases/kernel/syscalls/setpgid/setpgid03.c
> +++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
> @@ -155,7 +155,7 @@ static void setup(void)
>  
>  	tst_tmpdir();
>  
> -	TST_CHECKPOINT_INIT(&checkpoint);
> +	TST_CHECKPOINT_CREATE(&checkpoint);
>  	checkpoint.timeout = 10000;
>  
>  	umask(0);
> diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
> index 6259fa3..d497b6b 100644
> --- a/testcases/kernel/syscalls/waitid/waitid02.c
> +++ b/testcases/kernel/syscalls/waitid/waitid02.c
> @@ -240,7 +240,7 @@ static void setup(void)
>  {
>  	TEST_PAUSE;
>  	tst_tmpdir();
> -	TST_CHECKPOINT_INIT(&checkpoint);
> +	TST_CHECKPOINT_CREATE(&checkpoint);
>  }
>  
>  static void cleanup(void)
> 


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
