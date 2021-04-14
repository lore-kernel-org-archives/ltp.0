From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 14 Apr 2021 11:00:56 +0100
Subject: [LTP] [PATCH v2] controllers/memcg: Add testcase for
 kmem_limit_in_bytes of memory cgroup
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B50C0@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B50C0@dggeml531-mbx.china.huawei.com>
Message-ID: <87h7k92olk.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

zhaogongyi <zhaogongyi@huawei.com> writes:

> Hi Richard,
>
> Calling setpgid in this testcase is aim to make the task group be controlled by memory.kmem.limit_in_bytes since we have set the pgid to cgroup.procs.
>

Please see cgroup_procs_write_start in cgroup/cgroup.c. It calls
find_task_by_vpid which interprets pid as PIDTYPE_PID not PIDTYPE_PGID.

-- 
Thank you,
Richard.
