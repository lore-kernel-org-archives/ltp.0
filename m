From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 22 Jun 2021 16:25:02 +0200
Subject: [LTP] [PATCH v4 3/3] API: Remove TST_ERR usage from
 rtnetlink/netdevice
In-Reply-To: <YNHoS1L+0toUtAWT@yuki>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
 <20210615074045.23974-3-rpalethorpe@suse.com> <YMirQoiYRYsDP7Sb@yuki>
 <87czsk51fc.fsf@suse.de> <1e7ecce7-2e46-ea46-3c5b-357d53a238c3@suse.cz>
 <YNHoS1L+0toUtAWT@yuki>
Message-ID: <3dfda1bd-3829-7188-6add-e1755e91df4f@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 22. 06. 21 15:40, Cyril Hrubis wrote:
> Hi!
>>> The test author is guaranteed that the library will not set TST_ERR
>>> except via the TEST macro and similar.
>>
>> Hi, who decided to guarantee this and where is the guarantee documented?

Guaranteeing that TST_RET and TST_ERR will not be modified makes sense
for SAFE_SYSCALL()s because they will be used extensively throughout
test code. But the case is not so clear for primarily setup()/cleanup()
functions like the af_alg, rtnetlink and netdevice libraries. And note
that the rtnetlink library allows you to check ACKs manually without
calling the two functions which will modify TST_ERR.

So again, where is the extent of this guarantee documented? I haven't
found any mention of it in the doc/ dir and Richie didn't add any docs
changes in his patchset either. Documenting this is necessary for both
test writers and library maintainers.

>> Changing the return value to always return errno will be a major PITA
>> because 95% of error handling happens after some safe_syscall() which
>> clobbers errno by calling tst_brk() after failure. And if you only want
>> to return error codes from rtnetlink ACK messages, then there's the
>> problem what to return when a safe_syscall() fails during cleanup().
> 
> For the current code it would be as easy as:

That code will only result in RTNL_SEND_VALIDATE() always returning 0
regardless of success or failure, except when tst_brk() terminates the
whole program.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
