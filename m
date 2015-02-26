Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQvP9-0005JL-Ft
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 10:10:51 +0000
Date: Thu, 26 Feb 2015 11:10:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150226101013.GB13639@rei.suse.de>
References: <1424855586-9818-1-git-send-email-alexey.kodanev@oracle.com>
	<1424855586-9818-2-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1424855586-9818-2-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 2/3] runtest/kernel_misc: add lock_torture.sh
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  runtest/kernel_misc |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/runtest/kernel_misc b/runtest/kernel_misc
> index c12c31e..6a29de6 100644
> --- a/runtest/kernel_misc
> +++ b/runtest/kernel_misc
> @@ -8,3 +8,4 @@ ltp_acpi ltp_acpi
>  cpufreq_boost cpufreq_boost
>  uaccess uaccess
>  rcu_torture rcu_torture.sh
> +lock_torture lock_torture.sh

This should be part of the previous patch. There is no need to enable it
in a separate patch.

-- 
Cyril Hrubis
chrubis@suse.cz

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
