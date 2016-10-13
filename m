From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Oct 2016 16:26:04 +0200
Subject: [LTP] [PATCH 1/1] controllers/cgroup_fj: fix longtime wait
 cgroup_fj_proc.
In-Reply-To: <1476327906-8985-1-git-send-email-shuwang@redhat.com>
References: <1476327906-8985-1-git-send-email-shuwang@redhat.com>
Message-ID: <20161013142604.GA14300@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On some machines, when many cgroup_fj_proc created on the background,
> killall may failed to find and kill them all as the processes are
> just created and not ready. And that will cause the ltp testrun wait
> forever. So changed to use kill -9 instead.

What is the exact race here? What exactly "just created and not ready"
means here?

-- 
Cyril Hrubis
chrubis@suse.cz
