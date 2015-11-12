From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2015 15:49:49 +0100
Subject: [LTP] [PATCH V2] cgroup_fj: testcases
In-Reply-To: <1447260458-3331-1-git-send-email-chnyda@suse.com>
References: <1447260458-3331-1-git-send-email-chnyda@suse.com>
Message-ID: <20151112144949.GE19653@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +exist_subsystem;
>  setup;
>  if [ $mounted -ne 1 ]; then
>  	mount_cgroup;
         ^
This appears to be a patch over the "cgroup_fj: V3 fix and clean up"
and therefore the patch does not apply.

Can you please rebase it over the V4 that has been commited and resend?

-- 
Cyril Hrubis
chrubis@suse.cz
