Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X1X6i-0002e9-Iy
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 08:38:36 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X1X6g-0001DP-Qd
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 08:38:36 +0000
Date: Mon, 30 Jun 2014 04:38:26 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <982989271.447892.1404117506779.JavaMail.zimbra@redhat.com>
In-Reply-To: <1404116297.3148.7.camel@G08JYZSD130126>
References: <1404116297.3148.7.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] waitid/waitid02.c: Add new ECHILD errno test
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Monday, 30 June, 2014 10:18:17 AM
> Subject: [LTP] [PATCH] waitid/waitid02.c: Add new ECHILD errno test
> 
> * Add new ECHILD errno test for waitid(2)
> 	idtype and id (waitid()) is not a child of the calling process.
> 
> * Cleanup: remove an useless tst_exit()
> 
> * Add tst_count = 0
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Hi,

looks good to me. I'm assuming the reason for setup/cleanup
is that you wanted some unrelated child to be present.

Regards,
Jan

> ---
>  testcases/kernel/syscalls/waitid/waitid02.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/waitid/waitid02.c
> b/testcases/kernel/syscalls/waitid/waitid02.c
> index 3806655..6259fa3 100644
> --- a/testcases/kernel/syscalls/waitid/waitid02.c
> +++ b/testcases/kernel/syscalls/waitid/waitid02.c
> @@ -130,6 +130,16 @@ struct testcase_t tdat[] = {
>  		.setup = setup6,
>  		.cleanup = cleanup6
>  	},
> +	{
> +		.msg = "P_PID, WEXITED not a child of the calling process",
> +		.idtype = P_PID,
> +		.id = 1,
> +		.options = WEXITED,
> +		.exp_ret = -1,
> +		.exp_errno = ECHILD,
> +		.setup = setup2,
> +		.cleanup = cleanup2
> +	},
>  
>  };
>  
> @@ -281,13 +291,12 @@ int main(int ac, char **av)
>  	const char *msg;
>  
>  	msg = parse_opts(ac, av, NULL, NULL);
> -	if (msg != NULL) {
> +	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> -		tst_exit();
> -	}
>  
>  	setup();
>  	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +		tst_count = 0;
>  		for (testno = 0; testno < TST_TOTAL; testno++)
>  			test_waitid(&tdat[testno]);
>  	}
> --
> 1.9.3
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
