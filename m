From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 May 2021 07:03:57 +0200
Subject: [LTP] [PATCH] typo: Add necessary spaces in the outputs
In-Reply-To: <CAEemH2en6C3dUzspuVwNVmRiUeBQWK38bLPT7+ZwErVFQG+i-w@mail.gmail.com>
References: <20210518064506.203781-1-xieziyao@huawei.com>
 <CAEemH2en6C3dUzspuVwNVmRiUeBQWK38bLPT7+ZwErVFQG+i-w@mail.gmail.com>
Message-ID: <YKXtvaeckoJ2HJzJ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On Tue, May 18, 2021 at 2:45 PM Xie Ziyao <xieziyao@huawei.com> wrote:

> > Add necessary spaces in the outputs.

> > Signed-off-by: Xie Ziyao <xieziyao@huawei.com>

> Reviewed-by: Li Wang <liwang@redhat.com>

Actually, for some of these it'd be good to join the string:

e.g.: testcases/kernel/fs/fsx-linux/fsx-linux.c
warn("save_buffer: short write, 0x%x bytes instead "
 			     "of 0x%llx\n",

The rule could be: anything <= 100 (instead of 80 which was common in the past).
This is related to the change in checkpatch.pl (kernel) a year ago
bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")

Feel free to ignore it.

Kind regards,
Petr
