From: Li Wang <liwan@redhat.com>
Date: Tue, 26 Nov 2019 13:21:50 +0800
Subject: [LTP] 
	=?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E3?=
	=?utf-8?q?=2E13-6b6ca63=2Ecki_=28stable-queue-tree=29?=
In-Reply-To: <cki.0F29252F52.BT1NZETF9R@redhat.com>
References: <cki.0F29252F52.BT1NZETF9R@redhat.com>
Message-ID: <CAEemH2cu9zXQqqvs+jTsO_JTx-wH6YTyZgfE3oaiRRUkU5S2yg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 26, 2019 at 5:41 AM CKI Project <cki-project@redhat.com> wrote:

>
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: git://
> git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
>             Commit: 6b6ca63a8174 - net/mlx5: Update the list of the PCI
> supported devices
>
> The results of these automated tests are provided below.
>
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: FAILED
>
> All kernel binaries, config files, and logs are available for download
> here:
>
>   https://artifacts.cki-project.org/pipelines/307695
>
> One or more kernel tests failed:
>
>     ppc64le:
>      ? LTP
>

tag=dio30 stime=1574695439
cmdline="diotest6 -b 65536 -n 100 -i 100 -o 1024000"
contacts=""
analysis=exit
<<<test_output>>>
diotest06    1  TPASS  :  Read with Direct IO, Write without
diotest06    2  TFAIL  :  diotest6.c:150: readv failed, ret = 1269760:
errno=ENOTTY(25): Inappropriate ioctl for device
diotest06    3  TFAIL  :  diotest6.c:215: Write Direct-child 83 failed
diotest06    1  TPASS  :  Read with Direct IO, Write without
...
diotest06 2 TFAIL : diotest6.c:334: Write with Direct IO, Read without
diotest06    1  TPASS  :  Read with Direct IO, Write without
diotest06    2  TFAIL  :  diotest6.c:334: Write with Direct IO, Read without
diotest06    1  TPASS  :  Read with Direct IO, Write without
diotest06    2  TFAIL  :  diotest6.c:334: Write with Direct IO, Read without
diotest06    3  TPASS  :  Read, Write with Direct IO
diotest06 0 TINFO : 1/3 testblocks failed

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191126/c3bbe8af/attachment-0001.htm>
