Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <serge.hallyn@canonical.com>) id 1PpKv1-0005e3-Tx
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 13:26:15 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PpKv0-00018a-Ns
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 13:26:15 +0000
Date: Tue, 15 Feb 2011 07:26:03 -0600
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20110215132603.GA3092@localhost>
References: <4D5A47E5.3060108@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D5A47E5.3060108@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] unshare01.c: TEST_RETURN is used wrong
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Quoting Peng Haitao (penght@cn.fujitsu.com):
> Hi Garrett,
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/unshare/unshare01.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
> index e19d73d..9ae5e8f 100644
> --- a/testcases/kernel/syscalls/unshare/unshare01.c
> +++ b/testcases/kernel/syscalls/unshare/unshare01.c
> @@ -206,7 +206,7 @@ int main(int ac, char **av) {
>  			}
>  
>  			pid1 = fork();
> -			if (TEST_RETURN == -1) {
> +			if (pid1 == -1) {

Looking at the rest of that file, isn't the right fix to
wrap 'pid1 = fork();' in a TEST() macro?

-serge

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
