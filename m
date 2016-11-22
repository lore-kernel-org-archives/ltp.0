From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 22 Nov 2016 17:34:33 +0800
Subject: [LTP] [PATCH] syscalls/getpriority01: exclude default priority
 check for PRIO_USER.
In-Reply-To: <20161122085616.GB7048@rei.lan>
References: <1479362570-12526-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161122085616.GB7048@rei.lan>
Message-ID: <58341129.4000003@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Thanks for your review.

On 11/22/2016 04:56 PM, Cyril Hrubis wrote:
> Hi!
>> The current user priority is various when testing,
>> we should not check it as default value.
> 
> What system does this happen on? It should probably be mentioned in the
> commit message.

It happens on Fedora20, RHEL5.11GA, RHEL6.8GA, RNEL7.3GA, testing returns
-20 and -11 for PRIO_USER as root and nobody respectively.

> 
> And we should probably as well just revert the change I've did and check
> only that errno wasn't set since the value may be set even to -1.

I think so, checking "TEST_ERRNO != 0" is adequate for the case.

Best Regards,
Guangwen Feng


