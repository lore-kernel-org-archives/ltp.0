Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vd90N-0005RA-KS
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 01:30:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vd90M-0005px-3i
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 01:30:59 +0000
Message-ID: <5276F7C3.4080606@cn.fujitsu.com>
Date: Mon, 04 Nov 2013 09:26:27 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1383466482-19441-1-git-send-email-nexus226@gmail.com>
In-Reply-To: <1383466482-19441-1-git-send-email-nexus226@gmail.com>
Subject: Re: [LTP] [PATCH v3] acct01: fix TBROK to TCONF if acct not
	implemented
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
To: Honggyu Kim <nexus226@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 11/03/2013 04:14 PM, Honggyu Kim wrote:
> acct system call is avaliable only when the kernel option is on.
> When it fails, acct returns -1 and sets errno correspondingly.
> ENOSYS is set when the system call is not implemented.
> Currently, ENOSYS is not checked when the TEST_FILE5 argument is passed.
> It just goes to TBROK regardless of the implementation in kernel.
> This patch modifies to check errno ENOSYS, and marks as TCONF in that case.

What's changed from V2 to V3?

Thanks,
Wanlong Gao

> 
> Signed-off-by: Honggyu Kim <nexus226@gmail.com>
> ---
>  testcases/kernel/syscalls/acct/acct01.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> index c38d4db..0fe973b 100644
> --- a/testcases/kernel/syscalls/acct/acct01.c
> +++ b/testcases/kernel/syscalls/acct/acct01.c
> @@ -103,8 +103,15 @@ static void setup(void)
>  	fd = SAFE_CREAT(cleanup, TEST_FILE5, 0777);
>  	SAFE_CLOSE(cleanup, fd);
>  
> -	if (acct(TEST_FILE5) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
> +	if (acct(TEST_FILE5) == -1) {
> +		if (errno == ENOSYS) {
> +			tst_brkm(TCONF, cleanup,
> +				 "BSD process accounting is not configured in "
> +				 "this kernel");
> +		} else {
> +			tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
> +		}
> +	}
>  
>  	/* turn off acct, so we are in a known state */
>  	if (acct(NULL) == -1) {
> 


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
