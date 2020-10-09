From: Li Wang <liwang@redhat.com>
Date: Fri, 9 Oct 2020 14:37:42 +0800
Subject: [LTP] [PATCH] controllers/libcpuset.c: Add 'cpuset' prefix for
 cpuset files
In-Reply-To: <20200928061347.275858-1-yangx.jy@cn.fujitsu.com>
References: <20200928061347.275858-1-yangx.jy@cn.fujitsu.com>
Message-ID: <CAEemH2fwg58fCoNFCwMr4DgF+947kFU7-q__qZzL-ZE1ivkwaQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 28, 2020 at 2:32 PM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> cpuset_cpusetofpid() in cpuset_cpu_hog.c cannot find cpuset files by
> wrong names(without 'cpuset' prefix) so cpuset_load_balance_test.sh
> reported the following error:
> ---------------------------------------
> cpuset_load_balance 1 TFAIL: load balance test failed.
> ---------------------------------------
>
> Use correct names(with 'cpuset' prefix) to find cpuset files.
>
> Fixes: #690
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>

Pushed, thanks for fixing this.
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201009/99923533/attachment.htm>
