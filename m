From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 22 Jun 2017 08:02:16 -0400 (EDT)
Subject: [LTP] [PATCH 3/3] syscalls/shmat03.c: add new regression test
In-Reply-To: <594BA513.5010705@cn.fujitsu.com>
References: <1492164917-9329-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1492164917-9329-3-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170529145709.GC6618@rei.lan> <59300056.1020107@cn.fujitsu.com>
 <594B9768.8090108@cn.fujitsu.com> <594BA513.5010705@cn.fujitsu.com>
Message-ID: <1869831182.41262364.1498132936147.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Xiao Yang" <yangx.jy@cn.fujitsu.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>, "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 22 June, 2017 1:08:03 PM
> Subject: Re: [LTP] [PATCH 3/3] syscalls/shmat03.c: add new regression test
> 
> On 2017/06/22 18:09, Xiao Yang wrote:
> > On 2017/06/01 19:53, Xiao Yang wrote:
> >> On 2017/05/29 22:57, Cyril Hrubis wrote:
> >>> Hi!
> >>>> +    addr = shmat(shm_id, LOCATION, SHM_RND);
> >>>> +    if (addr != (void *)-1)
> >>>> +        tst_res(TINFO, "shmat() attached a nil-page unexpectedly");
> >>>> +    else
> >>>> +        tst_res(TINFO, "shmat() didn't attach a nil-page");
> >>>> +
> >>>> +    ((char *)addr)[0] = 'A';
> >>>
> >>> So if shmat() fails we try to write to (char*)-1 address, that does not
> >>> sound right. Why don't we exit the test with TPASS in that case and
> >>> skip
> >>> the part that tries to write to invalid address?
> >>>
> >>> Or at least dereference NULL here instead of the address returned from
> >>> shmat() since that is guaranteed to SEGFAULT.
> >> Hi Cyril
> >>
> >> I failed to call shmat() as root and returned EACCES if selinux is
> >> Enforcing.
> >> Do you know how to fix this problem?
> > Hi Cyril
> >
> > Sorry, I have fixed this issue, I will send v3 patch soon.
> Hi Cyril and jan
> 
> Sorry， i tried to fix this issue， but failed.  Could you help me to
> look into it? Thanks a lot! :-(
> shmat（） only attached a nil-page as root when selinux is not Enforcing.

Hi,

as Richard mentioned already, this appears to be same test as his:
  http://lists.linux.it/pipermail/ltp/2017-May/004568.html

so I guess we can drop 3/3 from your set, and use Richard's
version, which is doing what Cyril suggested.

Regards,
Jan
