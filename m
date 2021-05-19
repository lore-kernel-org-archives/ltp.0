From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 19 May 2021 13:03:40 +0200
Subject: [LTP] [PATCH 2/2] shell: Extend timeout tests,
 to run on multiple shells
In-Reply-To: <YKToUgBnK6ZQ5I0Q@yuki>
References: <20210519063109.224352-1-lkml@jv-coder.de>
 <20210519063109.224352-2-lkml@jv-coder.de> <YKToUgBnK6ZQ5I0Q@yuki>
Message-ID: <2f8e652b-aaa8-5f98-4f9d-5b7c138c17fa@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Cyril,

On 5/19/2021 12:28 PM, Cyril Hrubis wrote:
> Hi!
>> There are some differences especially in signal handling
>> between the shells, so execute the tests on as many
>> shells as possible.
> I'm not sure that we want to support anything but bash, dash and
> busybox and even these three are enough trouble.
>
> One of my friends once told me that it's easier to write a portable
> shell than portable shell code and it looks like he was right...
>
In general I would say: YES
But if at some point in the future there are features used, that really 
only work for one shell,
we can still reduce the tested shells for this script.

Btw: ksh is not really support, it complains about all local variables,
because it only allows them in "function <name>"-style functions.
But the timeout code still works even there.

J?rg
