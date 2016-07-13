From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Jul 2016 09:31:40 -0400 (EDT)
Subject: [LTP] [PATCH] cgroup_fj/cgroup_fj_common.sh:cpuset prefix issue
In-Reply-To: <1468338221-4074-1-git-send-email-shuang.qiu@oracle.com>
References: <1468338221-4074-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <2080549983.4465369.1468416700370.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "shuang qiu" <shuang.qiu@oracle.com>
> To: ltp@lists.linux.it
> Sent: Tuesday, 12 July, 2016 5:43:41 PM
> Subject: [LTP]  [PATCH] cgroup_fj/cgroup_fj_common.sh:cpuset prefix issue
> 
> From: Shuang Qiu <shuang.qiu@oracle.com>
> 
> As the legacy of:
>   commit 8793d854edbc2774943a4b0de3304dc73991159a
>   Author: Paul Menage <menage@google.com>
>   Date:   Thu Oct 18 23:39:39 2007 -0700
>   Task Control Groups: make cpusets a client of cgroups
> there is no cpuset. prefix for cpuset subsystem if ever mount it as cpuset
> type.
> So try either $mount_point/XXXX or $mount_point/cpuset.XXXX.
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>

Pushed with small tweaks to commit message.

Regards,
Jan
