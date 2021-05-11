From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 May 2021 08:32:39 +0200
Subject: [LTP] [PATCH 1/2] kernel/syscalls: Modify incorrect use of
 TERRNO and replace functions with safe_macros
In-Reply-To: <20210402034612.127912-2-xieziyao@huawei.com>
References: <20210402034612.127912-1-xieziyao@huawei.com>
 <20210402034612.127912-2-xieziyao@huawei.com>
Message-ID: <YJolByrF7vYDiY5/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> - modify some incorrect use of TERRNO/TTERRNO in kernel/syscalls;
> - replace functions with safe_macros to check the return value in kernel/syscalls.
These two would be really better to put 2 commits.

Kind regards,
Petr
