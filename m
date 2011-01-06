Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PavbF-0007mg-8T
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 19:34:17 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PavbE-00045a-CK
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 19:34:17 +0000
Received: by ywi6 with SMTP id 6so6588541ywi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Jan 2011 11:34:11 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4D25A173.8020708@cn.fujitsu.com>
Date: Thu, 6 Jan 2011 11:34:06 -0800
Message-Id: <D89B8908-7BC7-4034-BBD9-BA1D1B0EB608@gmail.com>
References: <4D259E4A.2050704@cn.fujitsu.com> <4D25A173.8020708@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 06/13]Add missing operators
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Jan 6, 2011, at 3:03 AM, tangchen wrote:

> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/msync/msync04.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/msync/msync04.c 
> b/testcases/kernel/syscalls/msync/msync04.c
> index 3e4b9a4..4e5dccb 100644
> --- a/testcases/kernel/syscalls/msync/msync04.c
> +++ b/testcases/kernel/syscalls/msync/msync04.c
> @@ -93,7 +93,7 @@ int main(int ac, char **av)
>      char *msg;        /* message returned from parse_opts */
> 
>      /* Parse standard options given to run the test. */
> -    if ((msg = parse_opts(ac, av, NULL, NULL)) NULL)
> +    if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
>          tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

	Patch is good despite the fact that the description is misleading.
	I checked in a different fix though.
Thanks,
-Garrett


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
