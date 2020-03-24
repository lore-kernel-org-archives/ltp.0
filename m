From: Veronika Kabatova <vkabatov@redhat.com>
Date: Tue, 24 Mar 2020 07:12:07 -0400 (EDT)
Subject: [LTP] 
 =?utf-8?q?=F0=9F=92=A5_PANICKED=3A_Test_report_for=09kerne?=
 =?utf-8?q?l_5=2E5=2E12-rc1-8b841eb=2Ecki_=28stable=29?=
In-Reply-To: <20200324062213.GA1961100@kroah.com>
References: <cki.936A32626F.M0L95JS69X@redhat.com>
 <20200324062213.GA1961100@kroah.com>
Message-ID: <970614328.15180583.1585048327050.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Greg KH" <greg@kroah.com>
> To: "CKI Project" <cki-project@redhat.com>
> Cc: "Memory Management" <mm-qe@redhat.com>, "Ondrej Mosnacek" <omosnace@redhat.com>, "Linux Stable maillist"
> <stable@vger.kernel.org>, "Jan Stancek" <jstancek@redhat.com>, "LTP Mailing List" <ltp@lists.linux.it>
> Sent: Tuesday, March 24, 2020 7:22:13 AM
> Subject: Re: ? PANICKED: Test report for	kernel 5.5.12-rc1-8b841eb.cki (stable)
> 
> On Tue, Mar 24, 2020 at 05:42:38AM -0000, CKI Project wrote:
> > 
> > Hello,
> > 
> > We ran automated tests on a recent commit from this kernel tree:
> > 
> >        Kernel repo:
> >        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >             Commit: 8b841eb697e1 - Linux 5.5.12-rc1
> > 
> > The results of these automated tests are provided below.
> > 
> >     Overall result: FAILED (see details below)
> >              Merge: OK
> >            Compile: OK
> >              Tests: PANICKED
> > 
> > All kernel binaries, config files, and logs are available for download
> > here:
> > 
> >   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/23/502039
> > 
> > One or more kernel tests failed:
> > 
> >     ppc64le:
> >      ? xfstests - ext4
> > 
> >     aarch64:
> >      ? LTP
> > 
> >     x86_64:
> >      ? xfstests - ext4
> 
> Ok, it's time I start just blacklisting this report again, it's not
> being helpful in any way :(
> 
> Remember, if something starts breaking, I need some way to find out what
> caused it to break...
> 

Hi Greg,

do you have any specific suggestions about what to include to help you out?
The linked console logs contain call traces for the panics [0]. Is there
anything else that would help you with debugging those? We're planning on
releasing core dumps, would those be helpful?



[0]: While these are new ones and not matching what we saw previously
     (that's why they weren't filtered out), the following commits from
     block tree should likely fix them:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=fd1bb3ae54a9a2e0c42709de861c69aa146b8955
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=c8997736650060594845e42c5d01d3118aec8d25
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=576682fa52cbd95deb3773449566274f206acc58
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=4d38a87fbb77fb9ff2ff4e914162a8ae6453eff5



Veronika

> greg k-h
> 
> 
> 

