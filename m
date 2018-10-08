From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Mon, 8 Oct 2018 11:43:36 -0300
Subject: [LTP] [PATCH v4] syscalls/membarrier: Add membarrier() initial
 test
In-Reply-To: <357830099.56894195.1539008719156.JavaMail.zimbra@redhat.com>
References: <243767154.55279006.1538383679362.JavaMail.zimbra@redhat.com>
 <20181008132914.8246-1-rafael.tinoco@linaro.org>
 <1320883984.56890565.1539007652586.JavaMail.zimbra@redhat.com>
 <75dc7e79-ddc2-f5ee-4fb5-dfcb7385e4df@linaro.org>
 <357830099.56894195.1539008719156.JavaMail.zimbra@redhat.com>
Message-ID: <54dd0c4a-e843-38b6-ee26-021353cbfb31@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/8/18 11:25 AM, Jan Stancek wrote:
>>> Looks good to me.
>>>
>>> We probably can drop linux/membarrier.h configure check, right?
>>> (since v4 doesn't include it and unsupported kernel should
>>> hit ENOSYS and TCONF)

>> Ooops, true. No need to check HAVE_LINUX_MEMBARRIER_H if we are
>> declaring all CMDs and will be given ENOSYS. Want me to send a v5 ?

> Let's give a couple days to other potential reviewers. If nothing
> else comes up, I can drop it before push.

Thanks a lot for reviewing this.

Best,
Rafael
