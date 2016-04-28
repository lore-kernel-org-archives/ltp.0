From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 28 Apr 2016 06:25:13 -0400 (EDT)
Subject: [LTP] LTP pre-release testing and freeze
In-Reply-To: <20160420143031.GB4004@rei>
References: <20160420143031.GB4004@rei>
Message-ID: <1728203866.1199576.1461839113790.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Wednesday, 20 April, 2016 4:30:31 PM
> Subject: [LTP] LTP pre-release testing and freeze
> 
> Hi!
> Are we ready for the git repository freeze and pre-release testing?
> 
> Are there any patches that were not reviewed/pushed yet that should be
> part of the next release?
> 
> Ideally I would like to proceed with the freeze at the end of this week
> then have at least a week for running the tests and if everything goes
> well the release would be carried on end of April or beginning of May.
> Does that sound reasonable?

Looks good from my side. I ran the usual set we use as smoke test
(syscalls, selection of mem/io/etc.) on
  RHEL6.2 through RHEL6.8 (i386, x86_64, ppc64, s390x)
  RHEL7.0 through RHEL7.2 (x86_64, ppc64, ppc64le, s390x, aarch64)
and ran mostly into known bugs in kernel / glibc.

Other than known issues, there were couple failures to note:

epoll_wait02
There is a tolerance, but it goes only one way (oversleep).
I occasionally see it waking up a ms earlier and then testcase
reports it as failure. This was new addition, so there are
no historical data for comparison.

personality01
PER_LINUX32 is masked on powerpc as PER_LINUX, so this
always fails.

arch/powerpc/kernel/syscalls.c:
long ppc64_personality(unsigned long personality)
{
        long ret;

        if (personality(current->personality) == PER_LINUX32
            && personality(personality) == PER_LINUX)
                personality = (personality & ~PER_MASK) | PER_LINUX32;
        ret = sys_personality(personality);
        if (personality(ret) == PER_LINUX32)
                ret = (ret & ~PER_MASK) | PER_LINUX;
        return ret;
}

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
