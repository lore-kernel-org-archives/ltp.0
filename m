From: Steve Muckle <smuckle@google.com>
Date: Wed, 13 Mar 2019 09:31:27 -0700
Subject: [LTP] [PATCH v1] rt_sigpending02: reuse code from sigpending02
In-Reply-To: <20190313114237.GA261142@google.com>
References: <20190308163832.212631-1-maennich@google.com>
 <64d5553d-ac2d-fd8a-03d1-7cd05d1deeeb@google.com>
 <20190313094228.GA24870@rei.lan> <20190313114237.GA261142@google.com>
Message-ID: <f2d20c15-6269-f386-ca7d-1c6c8f948867@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03/13/2019 04:42 AM, Matthias Maennich wrote:
> I am not sure multiplexing is the right approach here (not saying it is not!).
> In case of (rt_)sigpending, I would like to see them as separate binaries that
> effectively do disjunct things.

Ok I don't have a strong feeling either way, keeping them as separate 
binaries seems a little more complex as far as the build goes (i.e. 
Makefile stuff that has to reach into a sibling directory), but it's 
also slightly clearer there are tests for both syscalls when perusing 
the source.

> There might be the case that sigpending is not available on that
> particular kernel and rt_sigpending is. I would like the sigpending
> to fail with TCONF and the rt_sigpending to TPASS in that  case. Is
> that something that can be achieved with multiplexing?

Yep tests can return multiple results (have multiple sub-tests) so this 
is doable.

> I was already working on a v2 of this patch set to add a further test case and
> will send this out shortly. I would like to reconsider multiplexing at a later
> time and for now follow the pattern of other syscall related tests like
> sigwait, sigtimedwait, rt_sigtimedwait.

SGTM

cheers,
steve
