From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Aug 2021 15:34:30 +0200
Subject: [LTP] [PATCH v5 3/3] syscalls/msgstress: tune limit of
 processes for small machines
In-Reply-To: <20210820100028.97487-4-krzysztof.kozlowski@canonical.com>
References: <20210820100028.97487-1-krzysztof.kozlowski@canonical.com>
 <20210820100028.97487-4-krzysztof.kozlowski@canonical.com>
Message-ID: <YR+vZjqYBh/f6yAZ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Forking the exactly amount of processes as the limit (either from
> max_pids or from cgroups) is risky - OS might be doing some work and

This comment does not seem to match the code. We apply the reserve to
the cgroup limit only. If we wanted to make sure that the reserve is
applied even in the case where there is no systemd cgroup we would have
to apply it in the tst_get_free_pids_() just before we check if
used_pids >= max_pids instead.

-- 
Cyril Hrubis
chrubis@suse.cz
