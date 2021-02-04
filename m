From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Feb 2021 14:08:29 +0800
Subject: [LTP] [PATCH v1 2/3] syscalls/mallinfo02: Add a basic test to
 check use mmap or sbrk
In-Reply-To: <601A713F.7020301@cn.fujitsu.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1611654925-8994-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <YBLaQvt2g3z8Xy1A@yuki.lan> <601A713F.7020301@cn.fujitsu.com>
Message-ID: <CAEemH2efATKDx6T-j=GZKm6N4XZ3qTR22ZwzLPi5pBHkFkMEJQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

...
>
> So I use this code "MAX(info.fordblks, 131072)" to get the right value
> to trigger mmap.
>

My 2 cents:

From what I understand, once we request memory larger than the upper
limit DEFAULT_MMAP_THRESHOLD_MAX, Glibc will always make use
of mmap() because it will be out of any value it can adjust in dynamical.
So that we don't be bothered with this issue anymore.

Or:

Invoking mallopt(M_MMAP_THRESHOLD, ...) function in front of the
SAFE_MALLOC helps to fix the threshold. In such a case, the dynamic
adjustment of the mmap threshold will be disabled.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210204/74a8a9ec/attachment.htm>
