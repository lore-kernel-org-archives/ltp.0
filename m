From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Oct 2019 13:51:52 +0200
Subject: [LTP] LTP-cpuset test cases
In-Reply-To: <MA1PR0101MB1815CC5CCC0A10DA6F658DE6989A0@MA1PR0101MB1815.INDPRD01.PROD.OUTLOOK.COM>
References: <MA1PR0101MB18158831A03644C622793C6B989B0@MA1PR0101MB1815.INDPRD01.PROD.OUTLOOK.COM>
 <20191007183111.GA26203@rei.lan>
 <MA1PR0101MB1815CC5CCC0A10DA6F658DE6989A0@MA1PR0101MB1815.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20191008115151.GC13411@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> cleanup(): Looks like removing /dev/cpuset folder or subfolders are not making load-balance state of system to be normal.
> With below fix, no more crash are being observed.
> 
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -154,6 +154,9 @@ cleanup()
>                                                         "$pid in the cpuset"
>                         fi
>                 done < "$subdir/tasks"
> +
> +               /bin/echo 0 > $subdir/cpuset.sched_load_balance
> +
>                 rmdir "$subdir"
>                 if [ $? -ne 0 ]; then
>                         tst_brkm TFAIL "Couldn't remove subdir - "
> @@ -161,6 +164,9 @@ cleanup()
>                 fi
>         done
> 
> +       /bin/echo 0 > $CPUSET/cpuset.sched_load_balance
> +       /bin/echo 0 > $CPUSET_TMP/cpuset.sched_load_balance
> +
>         umount "$CPUSET"
>         if [ $? -ne 0 ]; then
>                 tst_brkm TFAIL "Couldn't umount cgroup filesystem with"

Looks like a kernel bug to me.

-- 
Cyril Hrubis
chrubis@suse.cz
