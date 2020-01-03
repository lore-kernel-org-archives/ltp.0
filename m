From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 3 Jan 2020 17:30:22 +0100
Subject: [LTP] [PATCH 5.4 000/191] 5.4.8-stable review
In-Reply-To: <180c36d7-336b-f7a9-66d4-49703eca2aa9@roeck-us.net>
References: <20200102215829.911231638@linuxfoundation.org>
 <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
 <CAK8P3a1+Srey_7cUd0xfaO8HdMv5tkUcs6DeDXzcUKkUD-DnGQ@mail.gmail.com>
 <CAK8P3a24EkUXTu-K2c-5B3w-LZwY7zNcX0dZixb3gd59vRw_Kw@mail.gmail.com>
 <180c36d7-336b-f7a9-66d4-49703eca2aa9@roeck-us.net>
Message-ID: <20200103163022.GA1205191@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jan 03, 2020 at 07:48:49AM -0800, Guenter Roeck wrote:
> On 1/3/20 7:29 AM, Arnd Bergmann wrote:
> > On Fri, Jan 3, 2020 at 4:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > 
> > > On Fri, Jan 3, 2020 at 4:03 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > 
> > > > On Fri, 3 Jan 2020 at 03:42, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > -ENOENT is what you get when hugetlbfs is not mounted, so this hints to
> > > 
> > > 8fc312b32b2  mm/hugetlbfs: fix error handling when setting up mounts
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-5.4.y&id=3f549fb42a39bea3b29c0fc12afee53c4a01bec9
> > 
> > I see that Mike Kravetz suggested not putting this patch into stable in
> > 
> > https://lore.kernel.org/lkml/befca227-cb8a-8f47-617d-e3bf9972bfec@oracle.com/
> > 
> > but it was picked through the autosel mechanism later.
> > 
> 
> I think autosel is way too aggressive. This is an excellent example.

Why?  It fixes a bug, the text says so, and the code shows it.  This is
a great example of a patch that autosel _should_ be picking up.  Now the
fact that it happens to break existing functionality is not an
autosel-detectable thing.  Especially as that same functionality is now
broken in Linus's tree :)

Autosel assumes that patches are correct, it can't know that they are
buggy.  That should have been weeded out by the developers and testing
before they hit Linus's tree.

thanks,

greg k-h
