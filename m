From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Mar 2018 11:43:13 +0200
Subject: [LTP] [PATCH] setregid: use common user and group names.
In-Reply-To: <20180326192956.GL72541@sspatil-desktop.mtv.corp.google.com>
References: <20180319200113.106692-1-sspatil@google.com>
 <20180326124200.GA311@x230>
 <20180326192956.GL72541@sspatil-desktop.mtv.corp.google.com>
Message-ID: <20180327094313.b6vetum2xitabi5u@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sandeep,

> On Mon, Mar 26, 2018 at 02:42:00PM +0200, Petr Vorel wrote:
> > Hi Sandeep,

> > > Android systems do not have groups names 'users' 'sys' etc. Replace them
> > > with 'nobody' and 'daemon' for the purposes of setregid0[34] tests and
> > > make the nomenclature across both of these tests more consistent.

> > > After the change, both setregid03 and setregid04 can run
> > > on Android systems.
> > I guess we don't care about older-but-still-quite-new releases and look for the future (as
> > 'daemon' was added to aosp quite recently, 'shell' would also work for older).

> 'shell' is not common though, e.g. it didn't exist by default on the
> debian system that I test the patches before I send them out after testing on
> Android.
Sorry I wasn't clear, I meant for older Android releases. Sure 'shell' isn't probably on
any linux distribution.

> The only other group that I could find that existed on both Android and my
> x86 workstation is 'audio'. I can change it to that if you like, but again, I
> don't know how portable that would be vs 'daemon'.

> Also, I wouldn't worry about the test breaking on slightly older Android. The
> vast majority of LTS tests are run through VTS, where these tests were disabled[1]
> due to the failure anyway. This change will allow us to start running them on
> all android devices now onwards ..

I thought that there could be preprocesor condition for Android defining different users
for it, but if you don't need it I'll merge it and just note your related commit in commit
message:
8e8648463 ("libcutils: Add "daemon" and "bin" users for testing only")

Kind regards,
Petr

> - ssp

> [1] https://android.googlesource.com/platform/test/vts-testcase/kernel/+/master/ltp/configs/disabled_tests.py#59


