Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OXfGV-0006Mj-U5
	for ltp-list@lists.sourceforge.net; Sat, 10 Jul 2010 18:59:07 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OXfGT-0004BH-M5
	for ltp-list@lists.sourceforge.net; Sat, 10 Jul 2010 18:59:07 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6AInSqP026211
	for <ltp-list@lists.sourceforge.net>; Sat, 10 Jul 2010 12:49:28 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6AIwvJ5119544
	for <ltp-list@lists.sourceforge.net>; Sat, 10 Jul 2010 12:58:57 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6AJ2BQN029443
	for <ltp-list@lists.sourceforge.net>; Sat, 10 Jul 2010 13:02:11 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <000301cb1da6$69538910$3bfa9b30$@co.jp>
References: <000301cb1da6$69538910$3bfa9b30$@co.jp>
Date: Sun, 11 Jul 2010 00:28:48 +0530
Message-Id: <1278788329.8215.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] fix hugeshmget01
Reply-To: subrata@linux.vnet.ibm.com
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

On Wed, 2010-07-07 at 16:31 +0900, Mitani wrote: 
> Hi,
> 
> 
> Sorry!!
> 
> I mistook to make following patch for hugetlb tests:
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10249.html
> 
> After the patch was applied, hugeshmget01 test will FAIL under the 
> condition that hugepages isn't effective.
> 
> In this patch, I moved the timing of "setup()" calling after the judgment 
> of hugepages.
> ------------
>         if ((msg = parse_opts(ac, av, (option_t *)NULL, NULL)) != (char
> *)NULL){
>                 tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
>         }
> 
>         /* The following loop checks looping state if -i option given */
>         if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
>              tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
>         else
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size()
> * 1024) / 2 ;
> 
>         setup();                        /* global setup */
> ------------
> 
> At first, the "cleanup()" function was called in exit handling when 
> hugepages was not effective.
> But I didn't change "cleanup" into "tst_exit".
> Therefore, in "cleanup()", exit handling fails to delete a non-existing 
> temporary directory.
> 
> 
> I maked patch for the latest git.
> I tested it in both conditions that hugepages is effective/ineffective.
> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

Thanks.

Regards--
Subrata

> 
> ============
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-07-04
> 03:15:03.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-07-05
> 16:37:41.000000000 +0900
> @@ -80,7 +80,7 @@
> 
>  	/* The following loop checks looping state if -i option given */
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
> +             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
>          else             
>                huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>          
> ============
> 
> 
> 
> Regards--
> 
> -Tomonori Mitani
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by Sprint
> What will you do first with EVO, the first 4G phone?
> Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
