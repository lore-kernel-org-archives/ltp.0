From: Li Wang <liwan@redhat.com>
Date: Thu, 30 Aug 2018 15:21:13 +0800
Subject: [LTP] [PATCH RFC v3 2/3] lib: introduce tst_timeout_remaining()
In-Reply-To: <5730db8dee0c566014c99bc0d264326fe1c923cc.1535466715.git.jstancek@redhat.com>
References: <920f7a911d8b32c3c2e673a9c608ded2526a616d.1535466715.git.jstancek@redhat.com>
 <5730db8dee0c566014c99bc0d264326fe1c923cc.1535466715.git.jstancek@redhat.com>
Message-ID: <CAEemH2cb3bdvy+cGLDZ=bpVnx2eZCRMxKRSBt+yGPzM2y5Civg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

I'm OK to go this way, as you said that with the remaining seconds return,
we can do something more for testcase. And I also suggest Richard to have
try on using it in fzsync API.


On Tue, Aug 28, 2018 at 10:40 PM, Jan Stancek <jstancek@redhat.com> wrote:

> Which returns number of seconds remaining till timeout.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_test.h        |   1 +
>  lib/newlib_tests/test18   | Bin 0 -> 384032 bytes
>  lib/newlib_tests/test18.c |  32 ++++++++++++++++++++++++++++++++
>  lib/tst_test.c            |  21 +++++++++++++++++++++
>  4 files changed, 54 insertions(+)
>  create mode 100755 lib/newlib_tests/test18
>

This test18 is a binary file which should not be submitted.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180830/87864da3/attachment.html>
