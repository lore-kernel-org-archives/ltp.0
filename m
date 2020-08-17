From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Aug 2020 12:37:59 +0800
Subject: [LTP] [PATCH v2] lib/tst_cgroup: Reset cgroup.clone_children
 value
In-Reply-To: <1596848534-1901-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1596848534-1901-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2cD9oTuUht=CeuD_RgR=0KLGY6sRH25nmTsN0NEc7M86Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Aug 8, 2020 at 9:02 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> When running cgroup test cases(like cpuset01 or oom05) about cpuset
> subsystem
> firstly, then cpuset_inherit case will fail because the value of
> cgroup.clone_children has been changed into 1 on cgroup-v1. Reset this
> value
> when calling tst_cgroupN_umount.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>

I have tested and applied the patch. Thanks Xu!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200817/08a5d425/attachment.htm>
