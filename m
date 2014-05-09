Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WieWx-0008Tw-8n
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 06:43:39 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WieWv-0003st-Ni
	for ltp-list@lists.sourceforge.net; Fri, 09 May 2014 06:43:39 +0000
Date: Fri, 9 May 2014 02:43:30 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1138074762.2685108.1399617810196.JavaMail.zimbra@redhat.com>
In-Reply-To: <536C6B8D.9070804@linux.vnet.ibm.com>
References: <536C6B8D.9070804@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] readahead02: change the test pass to 2M
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
To: madanvs@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Madan" <madanvs@linux.vnet.ibm.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 9 May, 2014 7:45:49 AM
> Subject: [LTP]  readahead02: change the test pass to 2M
> 
> Max readahead size has been limited since commit:
>    commit 6d2be915e589b58cb11418cbe1f22ff90732b6ac
>    Author: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
>    Date:   Thu Apr 3 14:48:23 2014 -0700
>      mm/readahead.c: fix readahead failure for memoryless NUMA nodes
>                      and limit readahead pages
> 
> Updating the change in the readahead behaviour of max 2M cache.
> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=c7252018cef0da5db35cd03aa7b6c44ab597a0b7
> 
> Signed-off-by:Hoisaleshwara Madan V S <hoisalvs@in.ibm.com>

I posted a similar patch:
  http://article.gmane.org/gmane.linux.ltp/20466
which keeps sizes, but makes multiple readahead calls.

Regards,
Jan

> 
> Patch :
> 
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c
> b/testcases/kernel/syscalls/readahe
> index 66158f0..dc6a191 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -306,13 +306,14 @@ static void test_readahead(void)
>          tst_resm(TINFO, "cache can hold at least: %ld kB", cached_max);
>          tst_resm(TINFO, "read_testfile(0) used cache: %ld kB", cached);
>          tst_resm(TINFO, "read_testfile(1) used cache: %ld kB", cached_ra);
> -
> -       if (cached_max * 1024 >= testfile_size) {
> +
> +        /* readahead will cache max of 2 M */
> +       if (cached_max * 1024 >= 2 * 1024) {
>                  /*
>                   * if cache can hold ~testfile_size then cache increase
>                   * for readahead should be at least testfile_size/2
>                   */
> -               if (cached_ra * 1024 > testfile_size / 2)
> +               if (cached_ra * 1024 > 2 * 1024)
>                          tst_resm(TPASS, "using cache as expected");
>                  else
>                          tst_resm(TWARN, "using less cache than expected");
> 
> 
> 
> ------------------------------------------------------------------------------
> Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
> &#149; 3 signs your SCM is hindering your productivity
> &#149; Requirements for releasing software faster
> &#149; Expert tips and advice for migrating your SCM now
> http://p.sf.net/sfu/perforce
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
