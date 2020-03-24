From: Veronika Kabatova <vkabatov@redhat.com>
Date: Tue, 24 Mar 2020 08:42:35 -0400 (EDT)
Subject: [LTP] 
 =?utf-8?b?8J+SpSBQQU5JQ0tFRDogVGVzdAlyZXBvcnQ/Zm9yP2tlcm5l?=
 =?utf-8?q?l_5=2E5=2E12-rc1-8b841eb=2Ecki_=28stable=29?=
In-Reply-To: <20200324114727.GA2333047@kroah.com>
References: <cki.936A32626F.M0L95JS69X@redhat.com>
 <20200324062213.GA1961100@kroah.com>
 <970614328.15180583.1585048327050.JavaMail.zimbra@redhat.com>
 <20200324111819.GA2234211@kroah.com>
 <1768018191.15186361.1585050272846.JavaMail.zimbra@redhat.com>
 <20200324114727.GA2333047@kroah.com>
Message-ID: <290791291.15199861.1585053755727.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Greg KH" <greg@kroah.com>
> To: "Veronika Kabatova" <vkabatov@redhat.com>
> Cc: "Memory Management" <mm-qe@redhat.com>, "Ondrej Mosnacek" <omosnace@redhat.com>, "Linux Stable maillist"
> <stable@vger.kernel.org>, "CKI Project" <cki-project@redhat.com>, "Jan Stancek" <jstancek@redhat.com>, "LTP Mailing
> List" <ltp@lists.linux.it>
> Sent: Tuesday, March 24, 2020 12:47:27 PM
> Subject: Re: ? PANICKED: Test	report?for?kernel 5.5.12-rc1-8b841eb.cki (stable)
> 
> On Tue, Mar 24, 2020 at 07:44:32AM -0400, Veronika Kabatova wrote:
> > 
> > 
> > ----- Original Message -----
> > > From: "Greg KH" <greg@kroah.com>
> > > To: "Veronika Kabatova" <vkabatov@redhat.com>
> > > Cc: "Memory Management" <mm-qe@redhat.com>, "Ondrej Mosnacek"
> > > <omosnace@redhat.com>, "Linux Stable maillist"
> > > <stable@vger.kernel.org>, "CKI Project" <cki-project@redhat.com>, "Jan
> > > Stancek" <jstancek@redhat.com>, "LTP Mailing
> > > List" <ltp@lists.linux.it>
> > > Sent: Tuesday, March 24, 2020 12:18:19 PM
> > > Subject: Re: ? PANICKED: Test report	for?kernel 5.5.12-rc1-8b841eb.cki
> > > (stable)
> > > 
> > > On Tue, Mar 24, 2020 at 07:12:07AM -0400, Veronika Kabatova wrote:
> > > > 
> > > > 
> > > > ----- Original Message -----
> > > > > From: "Greg KH" <greg@kroah.com>
> > > > > To: "CKI Project" <cki-project@redhat.com>
> > > > > Cc: "Memory Management" <mm-qe@redhat.com>, "Ondrej Mosnacek"
> > > > > <omosnace@redhat.com>, "Linux Stable maillist"
> > > > > <stable@vger.kernel.org>, "Jan Stancek" <jstancek@redhat.com>, "LTP
> > > > > Mailing List" <ltp@lists.linux.it>
> > > > > Sent: Tuesday, March 24, 2020 7:22:13 AM
> > > > > Subject: Re: ? PANICKED: Test report for	kernel
> > > > > 5.5.12-rc1-8b841eb.cki
> > > > > (stable)
> > > > > 
> > > > > On Tue, Mar 24, 2020 at 05:42:38AM -0000, CKI Project wrote:
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > We ran automated tests on a recent commit from this kernel tree:
> > > > > > 
> > > > > >        Kernel repo:
> > > > > >        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > > > >             Commit: 8b841eb697e1 - Linux 5.5.12-rc1
> > > > > > 
> > > > > > The results of these automated tests are provided below.
> > > > > > 
> > > > > >     Overall result: FAILED (see details below)
> > > > > >              Merge: OK
> > > > > >            Compile: OK
> > > > > >              Tests: PANICKED
> > > > > > 
> > > > > > All kernel binaries, config files, and logs are available for
> > > > > > download
> > > > > > here:
> > > > > > 
> > > > > >   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/23/502039
> > > > > > 
> > > > > > One or more kernel tests failed:
> > > > > > 
> > > > > >     ppc64le:
> > > > > >      ? xfstests - ext4
> > > > > > 
> > > > > >     aarch64:
> > > > > >      ? LTP
> > > > > > 
> > > > > >     x86_64:
> > > > > >      ? xfstests - ext4
> > > > > 
> > > > > Ok, it's time I start just blacklisting this report again, it's not
> > > > > being helpful in any way :(
> > > > > 
> > > > > Remember, if something starts breaking, I need some way to find out
> > > > > what
> > > > > caused it to break...
> > > > > 
> > > > 
> > > > Hi Greg,
> > > > 
> > > > do you have any specific suggestions about what to include to help you
> > > > out?
> > > > The linked console logs contain call traces for the panics [0]. Is
> > > > there
> > > > anything else that would help you with debugging those? We're planning
> > > > on
> > > > releasing core dumps, would those be helpful?
> > > 
> > > Bisection to find the offending commit would be best.
> > > 
> > 
> > This is going to be really tricky for hard to reproduce bugs but we'll do
> > some research on it, thanks!
> 
> I got about 8 "failed" emails today, it doesn't sound like it is hard to
> reproduce.

I meant in general, as we do catch a bunch of such problems. Those usually
require some input and testing from people who understand the subsystem to
create a reliable reproducer.

For this particular failure, do you want to try out the patches I linked
in the first email or should we waive them for now?

> 
> And if you can't reproduce it, why would you expect me to know what is
> going on?  :)
> 

Well you do know the kernel pretty well :) We also cc the test maintainers
to help out if it's needed since they understand the failed area, though
given the current situation around the world people's reactions might
understandably be slower.


Veronika

> thanks,
> 
> greg k-h
> 
> 
> 

