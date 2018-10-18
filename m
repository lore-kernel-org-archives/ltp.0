From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Oct 2018 10:20:08 +0800
Subject: [LTP] [PATCH v2] syscalls/fcntl: make OFD commands use
 fcntl64() syscall on 32-bit
In-Reply-To: <a278cb39d5c72eeb51184afdbcb085defea50195.1539784033.git.jstancek@redhat.com>
References: <a278cb39d5c72eeb51184afdbcb085defea50195.1539784033.git.jstancek@redhat.com>
Message-ID: <CAEemH2eTncHL_jUEWUWsvVya6QsowqU5+iAz-dViAV-Wy=UedA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 17, 2018 at 9:50 PM, Jan Stancek <jstancek@redhat.com> wrote:

> OFD commands require 64-bit argument (struct flock64). Until
> glibc commit 06ab719d30b0 ("Fix Linux fcntl OFD locks for
> non-LFS architectures (BZ#20251)") we relied on glibc passing
> arg directly to syscall.
>
> This creates problem for 32-bit version of the test, because old
> glibc is passing arg directly, while new one is casting it to
> struct flock.
>
> We could add a configure check for glibc version, but that may
> not help with other libc libraries.
>
> We could do a runtime check that exploits non-zero l_pid returning
> EINVAL. This however complicates SAFE_FCNTL macro substantially.
>
> This patch changes 32-bit version of test to use syscall directly.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181018/efd86850/attachment.html>
