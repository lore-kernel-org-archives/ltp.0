Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYJIf-0006dz-Ot
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 14:16:17 +0000
Date: Thu, 30 Dec 2010 15:31:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230143141.GA23205@saboteur.suse.cz>
References: <4D1824C1.1070306@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D1824C1.1070306@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]Do some cleanup for tst_brkloop
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

Missed this one (I've send similar patch just some minutes ago).

Acked-by: Cyril Hrubis <chrubis@suse.cz>

> ---
>  tools/apicmds/ltpapicmd.c |   36 ------------------------------------
>  1 files changed, 0 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
> index 78284a9..9c66ba3 100644
> --- a/tools/apicmds/ltpapicmd.c
> +++ b/tools/apicmds/ltpapicmd.c
> @@ -236,25 +236,6 @@ int main( int argc,
>          tst_res(trestype, file_name, arg_fmt);
>      }
>      else
> -    if (strcmp((char *)cmd_name, "tst_brkloop") == 0)
> -    {
> -        if (argc < 5)
> -        {
> -            fprintf(stderr, "Usage: %s TTYPE FNAME FUNC STRING\n"
> -            "\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
> -            "and TRETR.\n"
> -            "\tFNAME  - Print contents of this file after the message\n"
> -            "\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
> -            "\tSTRING - Message explaining the test result\n", cmd_name);
> -            exit (-1);
> -        }
> -        trestype = ident_ttype(argv++[0]);
> -        file_name = argv++[0];
> -        argv++;
> -        strcpy(arg_fmt, *argv);
> -        tst_brkloop(trestype, file_name, cleanup, arg_fmt);
> -    }
> -    else
>      if (strcmp((char *)cmd_name, "tst_brkm") == 0)
>      {
>          if (argc < 4)
> @@ -287,23 +268,6 @@ int main( int argc,
>          tst_resm(trestype, arg_fmt);
>      }
>      else
> -    if (strcmp((char *)cmd_name, "tst_brkloopm") == 0)
> -    {
> -        if (argc < 4)
> -        {
> -            fprintf(stderr, "Usage: %s TTYPE FUNC STRING\n"
> -            "\tTTYPE  - Test Result Type; one of TFAIL, TBROK, TCONF, "
> -            "and TRETR.\n"
> -            "\tFUNC   - Cleanup function (ignored), but MUST be provided\n"
> -            "\tSTRING - Message explaining the test result\n", cmd_name);
> -            exit (-1);
> -        }
> -        trestype = ident_ttype(argv++[0]);
> -        argv++;
> -        strcpy(arg_fmt, *argv);
> -        tst_brkloopm(trestype, cleanup, arg_fmt);
> -    }
> -    else
>      if (strcmp((char *)cmd_name, "tst_exit") == 0)
>          tst_exit();
>      else
> -- 
> 1.7.0.4
> 
> 
> 
> 
> 
> -- 
> Regards
> Bian Naimeng
> 
> 
> ------------------------------------------------------------------------------
> Learn how Oracle Real Application Clusters (RAC) One Node allows customers
> to consolidate database storage, standardize their database environment, and, 
> should the need arise, upgrade to a full multi-node Oracle RAC database 
> without downtime or disruption
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
