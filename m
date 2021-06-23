From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 23 Jun 2021 11:24:08 +0100
Subject: [LTP] [PATCH v4 3/3] API: Remove TST_ERR usage from
 rtnetlink/netdevice
In-Reply-To: <3dfda1bd-3829-7188-6add-e1755e91df4f@suse.cz>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
 <20210615074045.23974-3-rpalethorpe@suse.com> <YMirQoiYRYsDP7Sb@yuki>
 <87czsk51fc.fsf@suse.de> <1e7ecce7-2e46-ea46-3c5b-357d53a238c3@suse.cz>
 <YNHoS1L+0toUtAWT@yuki> <3dfda1bd-3829-7188-6add-e1755e91df4f@suse.cz>
Message-ID: <87wnqk516f.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Martin,

Martin Doucha <mdoucha@suse.cz> writes:

> On 22. 06. 21 15:40, Cyril Hrubis wrote:
>> Hi!
>>>> The test author is guaranteed that the library will not set TST_ERR
>>>> except via the TEST macro and similar.
>>>
>>> Hi, who decided to guarantee this and where is the guarantee documented?
>
> Guaranteeing that TST_RET and TST_ERR will not be modified makes sense
> for SAFE_SYSCALL()s because they will be used extensively throughout
> test code. But the case is not so clear for primarily setup()/cleanup()
> functions like the af_alg, rtnetlink and netdevice libraries. And note
> that the rtnetlink library allows you to check ACKs manually without
> calling the two functions which will modify TST_ERR.

Cyril said not to use it (on my CGroups patch set) and when I thought
about it, it made a lot of sense. I don't want to discuss it again here,
we can do that on a doc RFC.

>
> So again, where is the extent of this guarantee documented? I haven't
> found any mention of it in the doc/ dir and Richie didn't add any docs
> changes in his patchset either. Documenting this is necessary for both
> test writers and library maintainers.

Yes, it needs documenting, we should have done that once the discussions
concluded. I think this highlights a process issue. I don't really know
where to put such a rule. I can just arbitrarily put it in the API docs
somewhere, but that is suboptimal IMO.

As well as explanatory API documentation I think we need a simple
machine readable document which lists rules like this (e.g. CSV file
with ID and description columns). Then we can have a process for
deciding on rules like this. Where someone makes an RFC patch to update
the rule.

I also think we need an automated way of enforcing (some of) these rules
and making test authors aware of them. Which is why I'm trying to create
a SA tool specifically for LTP. In the SA error message we can list the
ID of the rule it violates.

I can add this to the Sparse patch set with the TEST macro and
TST_RET,TST_ERR rules.

The problem with documentation is that people do not read it once their
code works. Also it is easy to miss or forget about something like
TST_ERR being set.

>
>>> Changing the return value to always return errno will be a major PITA
>>> because 95% of error handling happens after some safe_syscall() which
>>> clobbers errno by calling tst_brk() after failure. And if you only want
>>> to return error codes from rtnetlink ACK messages, then there's the
>>> problem what to return when a safe_syscall() fails during cleanup().
>> 
>> For the current code it would be as easy as:
>
> That code will only result in RTNL_SEND_VALIDATE() always returning 0
> regardless of success or failure, except when tst_brk() terminates the
> whole program.


-- 
Thank you,
Richard.
