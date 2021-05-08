From: Li Wang <liwang@redhat.com>
Date: Sat, 8 May 2021 15:08:22 +0800
Subject: [LTP] [PATCH v2] controllers/cpuset: Restore the value of
 cpuset.sched_load_balance
In-Reply-To: <1619684694-116827-1-git-send-email-wangxin410@huawei.com>
References: <1619684694-116827-1-git-send-email-wangxin410@huawei.com>
Message-ID: <CAEemH2ddDeXCix9EPeeydWSHTA6d--TPW+ZV9nG9xOCtns_3sQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Thu, Apr 29, 2021 at 4:08 PM Wang Xin <wangxin410@huawei.com> wrote:
>
> When we run the cpuhotplug03 test case on the arm64 machine,
> we conclude that no error occurs when the cpuhotplug03 case is executed alone,
> but once the cpuset_sched_domains case is executed first,
> After cpuhotplug03 is executed, the error "cpuhotplug03 1 TFAIL: No cpuhotplug_do_spin_loop processes found on" occurs.
> The cpuset_sched_domains test case changes the value of cpuset.sched_load_balance in the cpuset cgroup subsystem,
> but does not restore the value at the end of the test.
> Modify the cpuset_funcs.sh file. The test result shows that the problem is solved successfully.
>
> Signed-off-by: Wang Xin <wangxin410@huawei.com>
Reviewed-by: Li Wang <liwang@redhat.com>

This just does saves/restore action in setup/cleanup phase, looks no
harmful to merge in this release.


--
Regards,
Li Wang

