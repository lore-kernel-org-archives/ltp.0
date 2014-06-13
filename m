Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WvQ5u-000409-RK
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 11:56:30 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvQ5s-0008LH-L7
	for ltp-list@lists.sourceforge.net; Fri, 13 Jun 2014 11:56:30 +0000
Date: Fri, 13 Jun 2014 07:56:18 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1183733259.23953127.1402660578711.JavaMail.zimbra@redhat.com>
In-Reply-To: <1402624697.2098.8.camel@G08JYZSD130126>
References: <1402624697.2098.8.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] syscalls: fix returning TCONF without device
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
> Sent: Friday, 13 June, 2014 3:58:17 AM
> Subject: [LTP] [PATCH 1/3] syscalls: fix returning TCONF without device
> 
> The cases are:
> 1. mknod07
> 2. lchown03
> 3. mkdir03
> 4. linkat02
> 5. mknodat02
> 6. fchown04
> 7. mkdirat02
> 8. link08
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Hi,

sorry if I missed some previous discussion, but what's the purpose
of this change?

I like TBROK here, because if you forget the required parameter,
testcase will end with non-zero exit code, which should be
easily visible for any test harness, while with TCONF the
problem can go unnoticed (with retcode == 0).

Regards,
Jan

> ---
>  testcases/kernel/syscalls/fchown/fchown04.c   | 2 +-
>  testcases/kernel/syscalls/lchown/lchown03.c   | 2 +-
>  testcases/kernel/syscalls/link/link08.c       | 2 +-
>  testcases/kernel/syscalls/linkat/linkat02.c   | 2 +-
>  testcases/kernel/syscalls/mkdir/mkdir03.c     | 2 +-
>  testcases/kernel/syscalls/mkdirat/mkdirat02.c | 2 +-
>  testcases/kernel/syscalls/mknod/mknod07.c     | 2 +-
>  testcases/kernel/syscalls/mknodat/mknodat02.c | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fchown/fchown04.c
> b/testcases/kernel/syscalls/fchown/fchown04.c
> index 68f6611..2a8b8c6 100644
> --- a/testcases/kernel/syscalls/fchown/fchown04.c
> +++ b/testcases/kernel/syscalls/fchown/fchown04.c
> @@ -91,7 +91,7 @@ int main(int ac, char **av)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	if (!device) {
> -		tst_brkm(TBROK, NULL,
> +		tst_brkm(TCONF, NULL,
>  			 "you must specify the device used for mounting with "
>  			 "-D option");
>  	}
> diff --git a/testcases/kernel/syscalls/lchown/lchown03.c
> b/testcases/kernel/syscalls/lchown/lchown03.c
> index ea8f38a..391afb4 100644
> --- a/testcases/kernel/syscalls/lchown/lchown03.c
> +++ b/testcases/kernel/syscalls/lchown/lchown03.c
> @@ -84,7 +84,7 @@ int main(int argc, char *argv[])
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	if (!device) {
> -		tst_brkm(TBROK, NULL,
> +		tst_brkm(TCONF, NULL,
>  			 "you must specify the device used for mounting with "
>  			 "-D option");
>  	}
> diff --git a/testcases/kernel/syscalls/link/link08.c
> b/testcases/kernel/syscalls/link/link08.c
> index aed5479..48274b4 100644
> --- a/testcases/kernel/syscalls/link/link08.c
> +++ b/testcases/kernel/syscalls/link/link08.c
> @@ -99,7 +99,7 @@ int main(int ac, char **av)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	if (!device) {
> -		tst_brkm(TBROK, NULL,
> +		tst_brkm(TCONF, NULL,
>  			 "you must specify the device used for mounting with "
>  			 "-D option");
>  	}
> diff --git a/testcases/kernel/syscalls/linkat/linkat02.c
> b/testcases/kernel/syscalls/linkat/linkat02.c
> index b899fa6..984ede6 100644
> --- a/testcases/kernel/syscalls/linkat/linkat02.c
> +++ b/testcases/kernel/syscalls/linkat/linkat02.c
> @@ -109,7 +109,7 @@ int main(int ac, char **av)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	if (!device) {
> -		tst_brkm(TBROK, NULL,
> +		tst_brkm(TCONF, NULL,
>  			 "you must specify the device used for mounting with "
>  			 "-D option");
>  	}
> diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c
> b/testcases/kernel/syscalls/mkdir/mkdir03.c
> index b037ad3..e897c2e 100644
> --- a/testcases/kernel/syscalls/mkdir/mkdir03.c
> +++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
> @@ -96,7 +96,7 @@ int main(int ac, char **av)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	if (!device) {
> -		tst_brkm(TBROK, NULL,
> +		tst_brkm(TCONF, NULL,
>  			 "you must specify the device used for mounting with "
>  			 "-D option");
>  	}
> diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat02.c
> b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
> index 827ad54..27de4e9 100644
> --- a/testcases/kernel/syscalls/mkdirat/mkdirat02.c
> +++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
> @@ -83,7 +83,7 @@ int main(int ac, char **av)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	if (!device) {
> -		tst_brkm(TBROK, NULL,
> +		tst_brkm(TCONF, NULL,
>  			 "you must specify the device used for mounting with "
>  			 "-D option");
>  	}
> diff --git a/testcases/kernel/syscalls/mknod/mknod07.c
> b/testcases/kernel/syscalls/mknod/mknod07.c
> index 5311cfc..df9f8d7 100644
> --- a/testcases/kernel/syscalls/mknod/mknod07.c
> +++ b/testcases/kernel/syscalls/mknod/mknod07.c
> @@ -106,7 +106,7 @@ int main(int ac, char **av)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	if (!device) {
> -		tst_brkm(TBROK, NULL, "you must specify the device "
> +		tst_brkm(TCONF, NULL, "you must specify the device "
>  			 "used for mounting with -D option");
>  	}
>  
> diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c
> b/testcases/kernel/syscalls/mknodat/mknodat02.c
> index 3de049b..eec5b98 100644
> --- a/testcases/kernel/syscalls/mknodat/mknodat02.c
> +++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
> @@ -103,7 +103,7 @@ int main(int ac, char **av)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	if (!device) {
> -		tst_brkm(TBROK, NULL, "you must specify the device "
> +		tst_brkm(TCONF, NULL, "you must specify the device "
>  			 "used for mounting with -D option");
>  	}
>  
> --
> 1.9.3
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
> Find What Matters Most in Your Big Data with HPCC Systems
> Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
> Leverages Graph Analysis for Fast Processing & Easy Data Exploration
> http://p.sf.net/sfu/hpccsystems
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
