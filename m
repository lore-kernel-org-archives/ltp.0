Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UU6Hz-0005Dz-O4
	for ltp-list@lists.sourceforge.net; Mon, 22 Apr 2013 02:15:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UU6Hx-0005Tk-77
	for ltp-list@lists.sourceforge.net; Mon, 22 Apr 2013 02:15:31 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r3M2FL7n021224
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Apr 2013 10:15:22 +0800
Message-ID: <51749D4A.9030305@cn.fujitsu.com>
Date: Mon, 22 Apr 2013 10:15:38 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <5170BAC7.1010202@cn.fujitsu.com> <5170BBCE.3090503@cn.fujitsu.com>
In-Reply-To: <5170BBCE.3090503@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]syscalls/adjtimex01.c: Test for mode
	ADJ_OFFSET_SINGLESHOT
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 04/19/2013 11:36 AM, DAN LI wrote:
> 
> Additional test for mode ADJ_OFFSET_SINGLESHOT.
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>

Applied, thank you.

Wanlong Gao

> ---
>  testcases/kernel/syscalls/adjtimex/adjtimex01.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex01.c b/testcases/kernel/syscalls/adjtimex/adjtimex01.c
> index b995e8e..d16a5f3 100644
> --- a/testcases/kernel/syscalls/adjtimex/adjtimex01.c
> +++ b/testcases/kernel/syscalls/adjtimex/adjtimex01.c
> @@ -42,7 +42,7 @@ static void setup(void);
>  static void cleanup(void);
> 
>  char *TCID = "adjtimex01";
> -int TST_TOTAL = 1;
> +int TST_TOTAL = 2;
> 
>  static struct timex tim_save;
> 
> @@ -66,10 +66,26 @@ int main(int ac, char **av)
>  		TEST(adjtimex(&tim_save));
> 
>  		if ((TEST_RETURN >= 0) && (TEST_RETURN <= 5)) {
> -			tst_resm(TPASS, "adjtimex() returned %ld", TEST_RETURN);
> +			tst_resm(TPASS, "adjtimex() with mode %u returned %ld",
> +				 SET_MODE, TEST_RETURN);
>  		} else {
> -			tst_resm(TFAIL | TTERRNO, "Test Failed, adjtimex()"
> -				 "returned %ld", TEST_RETURN);
> +			tst_resm(TFAIL | TTERRNO,
> +				"Test Failed, adjtimex() with mode %u "
> +				"returned %ld", SET_MODE, TEST_RETURN);
> +		}
> +
> +		/* Call adjtimex(2) */
> +		tim_save.modes = ADJ_OFFSET_SINGLESHOT;
> +
> +		TEST(adjtimex(&tim_save));
> +
> +		if ((TEST_RETURN >= 0) && (TEST_RETURN <= 5)) {
> +			tst_resm(TPASS, "adjtimex() with mode %u returned %ld",
> +				 ADJ_OFFSET_SINGLESHOT, TEST_RETURN);
> +		} else {
> +			tst_resm(TFAIL | TTERRNO,
> +				"Test Failed, adjtimex() with mode %u returned "
> +				"%ld", ADJ_OFFSET_SINGLESHOT, TEST_RETURN);
>  		}
>  	}
> 


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
