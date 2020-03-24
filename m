From: Greg KH <greg@kroah.com>
Date: Tue, 24 Mar 2020 07:22:13 +0100
Subject: [LTP] 
 =?utf-8?q?=F0=9F=92=A5_PANICKED=3A_Test_report_for_kernel_?=
 =?utf-8?q?5=2E5=2E12-rc1-8b841eb=2Ecki_=28stable=29?=
In-Reply-To: <cki.936A32626F.M0L95JS69X@redhat.com>
References: <cki.936A32626F.M0L95JS69X@redhat.com>
Message-ID: <20200324062213.GA1961100@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 24, 2020 at 05:42:38AM -0000, CKI Project wrote:
> 
> Hello,
> 
> We ran automated tests on a recent commit from this kernel tree:
> 
>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>             Commit: 8b841eb697e1 - Linux 5.5.12-rc1
> 
> The results of these automated tests are provided below.
> 
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: PANICKED
> 
> All kernel binaries, config files, and logs are available for download here:
> 
>   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/23/502039
> 
> One or more kernel tests failed:
> 
>     ppc64le:
>      ? xfstests - ext4
> 
>     aarch64:
>      ? LTP
> 
>     x86_64:
>      ? xfstests - ext4

Ok, it's time I start just blacklisting this report again, it's not
being helpful in any way :(

Remember, if something starts breaking, I need some way to find out what
caused it to break...

greg k-h
