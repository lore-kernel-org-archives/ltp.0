Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XS4zP-0007iw-Vf
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 14:04:48 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XS4zO-0002tS-0R
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 14:04:47 +0000
Message-ID: <5411ABF0.9070704@oracle.com>
Date: Thu, 11 Sep 2014 18:04:32 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <722837953.31209749.1410431446352.JavaMail.zimbra@redhat.com>
In-Reply-To: <722837953.31209749.1410431446352.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] fcntl14: dup code clean up
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
To: Xiong Zhou <xzhou@redhat.com>, ltp-list@lists.sourceforge.net

Hi!

On 09/11/2014 02:30 PM, Xiong Zhou wrote:
> And block3 description message fix from "mandatory locking"
> to "negative whence".
>
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> ---
>   testcases/kernel/syscalls/fcntl/fcntl14.c | 36 +++++++++++--------------------
>   1 file changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
> index 30a1ea9..9db88e8 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl14.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
> @@ -969,6 +969,15 @@ void catch1(int sig)
>   	got1++;
>   }
>
> +static void testcheck_end(int check_fail, char *msg)
> +{
> +	if (check_fail) {
> +		tst_resm(TFAIL, "%s FAILED", msg);
> +	} else {
> +		tst_resm(TPASS, "%s PASSED", msg);
> +	}
> +}

There are many places left in fcntl14.c where you can put this 
"deduplication". Why aren't you doing it? ;)

> +
>   int main(int ac, char **av)
>   {
>   	int lc;
> @@ -1009,20 +1018,11 @@ int main(int ac, char **av)
>   		 * mandatory locking
>   		 */
>   		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 0, 0, 36);
> -		if (fail) {
> -			tst_resm(TFAIL, "Block 1, test 1 FAILED");
> -		} else {
> -			tst_resm(TPASS, "Block 1, test 1 PASSED");
> -		}
> +		testcheck_end(fail, "Block 1, test 1");
>
>   		/* Now try with negative values for L_start and L_len */
>   		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 5, 36, 45);
> -
> -		if (fail) {
> -			tst_resm(TFAIL, "Block 1, test 2 FAILED");
> -		} else {
> -			tst_resm(TPASS, "Block 1, test 2 PASSED");
> -		}
> +		testcheck_end(fail, "Block 1, test 2");
>
>   		tst_resm(TINFO, "Exit block 1");
>
> @@ -1094,13 +1094,7 @@ int main(int ac, char **av)
>   		close(fd);
>   		unlink(tmpname);
>
> -		if (fail) {
> -			tst_resm(TINFO, "Test with mandatory "
> -				 "locking FAILED");
> -		} else {
> -			tst_resm(TINFO, "Test with mandatory "
> -				 "locking PASSED");
> -		}
> +		testcheck_end(fail, "Test with negative whence locking");
>   		tst_resm(TINFO, "Exit block 3");
>
>   /* //block4: */
> @@ -1223,11 +1217,7 @@ int main(int ac, char **av)
>   		close(fd);
>   		unlink(tmpname);
>
> -		if (fail) {
> -			tst_resm(TINFO, "Test of locks on file FAILED");
> -		} else {
> -			tst_resm(TINFO, "Test of locks on file PASSED");
> -		}
> +		testcheck_end(fail, "Test of locks on file");
>   		tst_resm(TINFO, "Exit block 4");
>   	}
>   	cleanup();
>

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
