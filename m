From: Greg KH <greg@kroah.com>
Date: Tue, 24 Mar 2020 13:48:07 +0100
Subject: [LTP] 
 =?utf-8?b?8J+SpSBQQU5JQ0tFRDogIFRlc3Q/cmVwb3J0P2Zvcj9rZXJu?=
 =?utf-8?q?el_5=2E5=2E12-rc1-8b841eb=2Ecki_=28stable=29?=
In-Reply-To: <290791291.15199861.1585053755727.JavaMail.zimbra@redhat.com>
References: <cki.936A32626F.M0L95JS69X@redhat.com>
 <20200324062213.GA1961100@kroah.com>
 <970614328.15180583.1585048327050.JavaMail.zimbra@redhat.com>
 <20200324111819.GA2234211@kroah.com>
 <1768018191.15186361.1585050272846.JavaMail.zimbra@redhat.com>
 <20200324114727.GA2333047@kroah.com>
 <290791291.15199861.1585053755727.JavaMail.zimbra@redhat.com>
Message-ID: <20200324124807.GA2401396@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 24, 2020 at 08:42:35AM -0400, Veronika Kabatova wrote:
> 
> 
> ----- Original Message -----
> > From: "Greg KH" <greg@kroah.com>
> > To: "Veronika Kabatova" <vkabatov@redhat.com>
> > Cc: "Memory Management" <mm-qe@redhat.com>, "Ondrej Mosnacek" <omosnace@redhat.com>, "Linux Stable maillist"
> > <stable@vger.kernel.org>, "CKI Project" <cki-project@redhat.com>, "Jan Stancek" <jstancek@redhat.com>, "LTP Mailing
> > List" <ltp@lists.linux.it>
> > Sent: Tuesday, March 24, 2020 12:47:27 PM
> > Subject: Re: ? PANICKED: Test	report?for?kernel 5.5.12-rc1-8b841eb.cki (stable)
> > 
> > On Tue, Mar 24, 2020 at 07:44:32AM -0400, Veronika Kabatova wrote:
> > > 
> > > 
> > > ----- Original Message -----
> > > > From: "Greg KH" <greg@kroah.com>
> > > > To: "Veronika Kabatova" <vkabatov@redhat.com>
> > > > Cc: "Memory Management" <mm-qe@redhat.com>, "Ondrej Mosnacek"
> > > > <omosnace@redhat.com>, "Linux Stable maillist"
> > > > <stable@vger.kernel.org>, "CKI Project" <cki-project@redhat.com>, "Jan
> > > > Stancek" <jstancek@redhat.com>, "LTP Mailing
> > > > List" <ltp@lists.linux.it>
> > > > Sent: Tuesday, March 24, 2020 12:18:19 PM
> > > > Subject: Re: ? PANICKED: Test report	for?kernel 5.5.12-rc1-8b841eb.cki
> > > > (stable)
> > > > 
> > > > On Tue, Mar 24, 2020 at 07:12:07AM -0400, Veronika Kabatova wrote:
> > > > > 
> > > > > 
> > > > > ----- Original Message -----
> > > > > > From: "Greg KH" <greg@kroah.com>
> > > > > > To: "CKI Project" <cki-project@redhat.com>
> > > > > > Cc: "Memory Management" <mm-qe@redhat.com>, "Ondrej Mosnacek"
> > > > > > <omosnace@redhat.com>, "Linux Stable maillist"
> > > > > > <stable@vger.kernel.org>, "Jan Stancek" <jstancek@redhat.com>, "LTP
> > > > > > Mailing List" <ltp@lists.linux.it>
> > > > > > Sent: Tuesday, March 24, 2020 7:22:13 AM
> > > > > > Subject: Re: ? PANICKED: Test report for	kernel
> > > > > > 5.5.12-rc1-8b841eb.cki
> > > > > > (stable)
> > > > > > 
> > > > > > On Tue, Mar 24, 2020 at 05:42:38AM -0000, CKI Project wrote:
> > > > > > > 
> > > > > > > Hello,
> > > > > > > 
> > > > > > > We ran automated tests on a recent commit from this kernel tree:
> > > > > > > 
> > > > > > >        Kernel repo:
> > > > > > >        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > > > > >             Commit: 8b841eb697e1 - Linux 5.5.12-rc1
> > > > > > > 
> > > > > > > The results of these automated tests are provided below.
> > > > > > > 
> > > > > > >     Overall result: FAILED (see details below)
> > > > > > >              Merge: OK
> > > > > > >            Compile: OK
> > > > > > >              Tests: PANICKED
> > > > > > > 
> > > > > > > All kernel binaries, config files, and logs are available for
> > > > > > > download
> > > > > > > here:
> > > > > > > 
> > > > > > >   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/23/502039
> > > > > > > 
> > > > > > > One or more kernel tests failed:
> > > > > > > 
> > > > > > >     ppc64le:
> > > > > > >      ? xfstests - ext4
> > > > > > > 
> > > > > > >     aarch64:
> > > > > > >      ? LTP
> > > > > > > 
> > > > > > >     x86_64:
> > > > > > >      ? xfstests - ext4
> > > > > > 
> > > > > > Ok, it's time I start just blacklisting this report again, it's not
> > > > > > being helpful in any way :(
> > > > > > 
> > > > > > Remember, if something starts breaking, I need some way to find out
> > > > > > what
> > > > > > caused it to break...
> > > > > > 
> > > > > 
> > > > > Hi Greg,
> > > > > 
> > > > > do you have any specific suggestions about what to include to help you
> > > > > out?
> > > > > The linked console logs contain call traces for the panics [0]. Is
> > > > > there
> > > > > anything else that would help you with debugging those? We're planning
> > > > > on
> > > > > releasing core dumps, would those be helpful?
> > > > 
> > > > Bisection to find the offending commit would be best.
> > > > 
> > > 
> > > This is going to be really tricky for hard to reproduce bugs but we'll do
> > > some research on it, thanks!
> > 
> > I got about 8 "failed" emails today, it doesn't sound like it is hard to
> > reproduce.
> 
> I meant in general, as we do catch a bunch of such problems. Those usually
> require some input and testing from people who understand the subsystem to
> create a reliable reproducer.
> 
> For this particular failure, do you want to try out the patches I linked
> in the first email or should we waive them for now?

As this must be something new introduced by my current queue, why not
find out what patch in there is causing the problem?

If this is caused by something NOT in my queue, and is also a problem
upstream in Linus's tree, then you need to notify the upstream
developers as there's nothing I can do about it, right?

If this is not upstream, but is a problem in the stable tree, then
please submit the patches that fix the issue as documented in the stable
kernel rules document for how to submit them.

To throw this horrible "something is BROKEN!" type email at me all the
time just makes me want to delete it as I have no context at all.

thanks,

greg k-h
