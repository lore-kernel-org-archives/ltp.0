Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YcxUX-0006N1-QA
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 14:50:09 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YcxUW-0007Yl-VV
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 14:50:09 +0000
Message-ID: <551AB4B5.4020902@oracle.com>
Date: Tue, 31 Mar 2015 17:52:37 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/6] lib6/runcc.c: use TCONF instead of TBROK when
 no C compiler is present
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
On 03/31/2015 10:46 AM, Xing Gu wrote:
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>   testcases/network/lib6/runcc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/network/lib6/runcc.c b/testcases/network/lib6/runcc.c
> index 91a0b16..3a89598 100644
> --- a/testcases/network/lib6/runcc.c
> +++ b/testcases/network/lib6/runcc.c
> @@ -93,7 +93,7 @@ int runcc(char *tname, char *filename0, char *program)
>   		 cflags, filename0, filename);
>   	es = system(cmd);
>   	if (WEXITSTATUS(es) == 127) {
> -		tst_resm(TBROK, "can't run C compiler: \"%s\"", cmd);
> +		tst_resm(TCONF, "can't run C compiler: \"%s\"", cmd);
>   		if (unlink(filename) < 0)
>   			tst_resm(TWARN, "%s; unlink \"%s\" failed: %s", tname,
>   				 filename, strerror(errno));

Why not 'tst_brkm(TCONF, ...)', do we need to proceed further?

Thanks,
Alexey

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
