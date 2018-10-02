From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Oct 2018 15:09:28 +0200
Subject: [LTP] [RFC PATCH 5/5] runtest/numa: remove move_pages* test
	cases
In-Reply-To: <1536849882-28897-6-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1536849882-28897-6-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20181002130928.GH24796@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> since they are already defined in runtest/syscalls.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  runtest/numa | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/runtest/numa b/runtest/numa
> index 12aedbb..510c353 100644
> --- a/runtest/numa
> +++ b/runtest/numa
> @@ -1,13 +1 @@
>  Numa-testcases numa01.sh
> -move_pages01 move_pages01
> -move_pages02 move_pages02
> -move_pages03 move_pages03
> -move_pages04 move_pages04
> -move_pages05 move_pages05
> -move_pages06 move_pages06
> -move_pages07 move_pages07
> -move_pages08 move_pages08
> -move_pages09 move_pages09
> -move_pages10 move_pages10
> -move_pages11 move_pages11
> -move_pages12 move_pages12

Or we may remove the numa runtest file from the default scenario, given
that the move_pages tests are in syscalls and the numa01.sh is known to
be broken there is a little value in keeping it in default scenario.

And once I finish the numa01.sh rewrite, we will get set_mempolicy
syscall tests in syscalls runtest file anyways, so we may keep the numa
to be a separate runtest file for a case that someone wants to run only
numa related tests.

-- 
Cyril Hrubis
chrubis@suse.cz
