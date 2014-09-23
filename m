Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XWOeB-0001jZ-Ei
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 11:52:43 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XWOeA-0000Xf-I2
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 11:52:43 +0000
Message-ID: <54215F00.7040507@oracle.com>
Date: Tue, 23 Sep 2014 15:52:32 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <661064059.31210197.1410431541563.JavaMail.zimbra@redhat.com>
	<5411B637.2020104@oracle.com>
	<1793864039.34479334.1411109349130.JavaMail.zimbra@redhat.com>
In-Reply-To: <1793864039.34479334.1411109349130.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v2 3/3] splice01/tee01/utime: test back on NFS
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
To: Xiong Zhou <xzhou@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!

On 09/19/2014 10:49 AM, Xiong Zhou wrote:
>
> Tests splice01 tee01 and utime01/02/03 pass on NFS since 2.6.32 at least.

Could you add a kernel version check to the patch, please?

I'm sure there are distributions which still use older kernels.

For example, with 2.6.18-371.3.1.0.1.el5 and:
splice01 - fails
tee01 - fails
utime01/utime02/utime03 - pass

Thanks.


>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>   testcases/kernel/syscalls/splice/splice01.c | 5 -----
>   testcases/kernel/syscalls/tee/tee01.c       | 5 -----
>   testcases/kernel/syscalls/utime/utime01.c   | 1 -
>   testcases/kernel/syscalls/utime/utime02.c   | 1 -
>   testcases/kernel/syscalls/utime/utime03.c   | 1 -
>   5 files changed, 13 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
> index e96ff6d..7bd53b8 100644
> --- a/testcases/kernel/syscalls/splice/splice01.c
> +++ b/testcases/kernel/syscalls/splice/splice01.c
> @@ -134,11 +134,6 @@ static void setup(void)
>
>   	tst_tmpdir();
>
> -	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
> -		tst_brkm(TCONF, cleanup,
> -			 "Cannot do splice on a file on NFS filesystem");
> -	}
> -
>   	for (i = 0; i < TEST_BLOCK_SIZE; i++)
>   		buffer[i] = i & 0xff;
>
> diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
> index 6ea6f18..f87df5d 100644
> --- a/testcases/kernel/syscalls/tee/tee01.c
> +++ b/testcases/kernel/syscalls/tee/tee01.c
> @@ -146,11 +146,6 @@ static void setup(void)
>
>   	tst_tmpdir();
>
> -	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
> -		tst_brkm(TCONF, cleanup,
> -			 "Cannot do tee on a file on NFS filesystem");
> -	}
> -
>   	for (i = 0; i < TEST_BLOCK_SIZE; i++)
>   		buffer[i] = i & 0xff;
>
> diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
> index 3128965..4c41bc7 100644
> --- a/testcases/kernel/syscalls/utime/utime01.c
> +++ b/testcases/kernel/syscalls/utime/utime01.c
> @@ -114,7 +114,6 @@ int main(int ac, char **av)
>   	setup();
>
>   	switch ((type = tst_fs_type(cleanup, "."))) {
> -	case TST_NFS_MAGIC:
>   	case TST_V9FS_MAGIC:
>   		tst_brkm(TCONF, cleanup,
>   			 "Cannot do utime on a file on %s filesystem",
> diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
> index cbd30da..6624695 100644
> --- a/testcases/kernel/syscalls/utime/utime02.c
> +++ b/testcases/kernel/syscalls/utime/utime02.c
> @@ -120,7 +120,6 @@ int main(int ac, char **av)
>   	setup();
>
>   	switch ((type = tst_fs_type(cleanup, "."))) {
> -	case TST_NFS_MAGIC:
>   	case TST_V9FS_MAGIC:
>   		tst_brkm(TCONF, cleanup,
>   			 "Cannot do utime on a file on %s filesystem",
> diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
> index 858f6ca..32b0d29 100644
> --- a/testcases/kernel/syscalls/utime/utime03.c
> +++ b/testcases/kernel/syscalls/utime/utime03.c
> @@ -130,7 +130,6 @@ int main(int ac, char **av)
>   	setup();
>
>   	switch ((type = tst_fs_type(cleanup, "."))) {
> -	case TST_NFS_MAGIC:
>   	case TST_V9FS_MAGIC:
>   		tst_brkm(TCONF, cleanup,
>   			 "Cannot do utime on a file on %s filesystem",
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
