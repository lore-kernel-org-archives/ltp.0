From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Nov 2015 16:18:05 +0100
Subject: [LTP] [PATCH] runtest/controllers: cgroup_fj tests
In-Reply-To: <1446737260-23183-1-git-send-email-chnyda@suse.com>
References: <1446737260-23183-1-git-send-email-chnyda@suse.com>
Message-ID: <20151111151805.GA19399@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Removed irrelevant testcases
> 1) Removed testcases with "all", it is irrelevant to mount all
> cgroups when some are already mounted and it is not possible to
> mount them several times in newer kernel.
> 2) Removed "none" testcases. Cannot find what -onone is supposed
> to do when cgroups are mounted. Maybe the author confused with
> 	"mount -t cgroup none /cgroups"

This is fine but you should remove the now-unused logic from the tests,
there would be a couple of unused if [ "$subsystem" == "all" ], etc.
after this patch.

-- 
Cyril Hrubis
chrubis@suse.cz
