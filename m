Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1XbIvW-0007vn-Pu
	for ltp-list@lists.sourceforge.net; Tue, 07 Oct 2014 00:46:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XbIvV-0007Q3-IT
	for ltp-list@lists.sourceforge.net; Tue, 07 Oct 2014 00:46:54 +0000
Message-ID: <543337C0.90906@cn.fujitsu.com>
Date: Tue, 7 Oct 2014 08:45:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <a710c99deb86fdad787e0530013b20913de57dbe.1412604688.git.jstancek@redhat.com>
	<6cf14ee28f2a6fc0a131eeecd0f500214ed1f512.1412604688.git.jstancek@redhat.com>
In-Reply-To: <6cf14ee28f2a6fc0a131eeecd0f500214ed1f512.1412604688.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 2/2 v2] checkpoints: fix usage in children started
 via exec
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
> creat07 and setpgid03 are currently failing in following way:
>   CHILD: Failed to open fifo '': No such file or directory at creat07_child.c:31
>   creat07     1  TBROK  :  tst_checkpoint.c:126: Checkpoint timeouted after 5000 msecs at creat07.c:78
>   creat07     2  TBROK  :  tst_checkpoint.c:126: Remaining cases broken
> 
> These testcases start children via exec, so only initialize
> checkpoint struct, FIFO has been already created by parent.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Tested-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  testcases/kernel/syscalls/creat/creat07_child.c    |    8 ++++++--
>  .../kernel/syscalls/setpgid/setpgid03_child.c      |    8 +++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat07_child.c b/testcases/kernel/syscalls/creat/creat07_child.c
> index f3e6aa0..1641601 100644
> --- a/testcases/kernel/syscalls/creat/creat07_child.c
> +++ b/testcases/kernel/syscalls/creat/creat07_child.c
> @@ -24,10 +24,14 @@
>  
>  char *TCID = "creat07_child";
>  
> -static struct tst_checkpoint checkpoint = {.timeout = 5, .retval = 1};
> -
>  int main(void)
>  {
> +	struct tst_checkpoint checkpoint;
> +
> +	/* we are already in tmpdir, so only initialize checkpoint,
> +	 * fifo has been created by parent already. */
> +	TST_CHECKPOINT_INIT(&checkpoint);
> +
>  	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
>  
>  	for (;;) {
> diff --git a/testcases/kernel/syscalls/setpgid/setpgid03_child.c b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
> index c4cf892..c9ea87f 100644
> --- a/testcases/kernel/syscalls/setpgid/setpgid03_child.c
> +++ b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
> @@ -20,10 +20,16 @@
>  
>  char *TCID = "setpgid03_child";
>  
> -static struct tst_checkpoint checkpoint = { .timeout = 10000, .retval = 1};
>  
>  int main(void)
>  {
> +	struct tst_checkpoint checkpoint;
> +
> +	/* we are already in tmpdir, so only initialize checkpoint,
> +	 * fifo has been created by parent already. */
> +	TST_CHECKPOINT_INIT(&checkpoint);
> +	checkpoint.timeout = 10000;
> +
>  	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
>  	TST_CHECKPOINT_CHILD_WAIT(&checkpoint);
>  
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
