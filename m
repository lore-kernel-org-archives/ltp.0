From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 May 2021 13:20:34 +0200
Subject: [LTP] [PATCH 3/6] API/cgroups: Check for unknown controller name
In-Reply-To: <20210513152125.25766-4-rpalethorpe@suse.com>
References: <20210513152125.25766-1-rpalethorpe@suse.com>
 <20210513152125.25766-4-rpalethorpe@suse.com>
Message-ID: <YKT0gqiSkeGdRt8w@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
So as far as I can tell this only shuffles code around but the
functionality is the same since we moved the controller check from the
tst_cgroup_ver() and tst_cgroup_require() to a common function.

I'm not sure that this is worth the trouble.

-- 
Cyril Hrubis
chrubis@suse.cz
