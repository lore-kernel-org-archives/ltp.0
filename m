From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 22 Jun 2021 15:49:04 +0200
Subject: [LTP] [PATCH v4 3/3] API: Remove TST_ERR usage from
 rtnetlink/netdevice
In-Reply-To: <87czsk51fc.fsf@suse.de>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
 <20210615074045.23974-3-rpalethorpe@suse.com> <YMirQoiYRYsDP7Sb@yuki>
 <87czsk51fc.fsf@suse.de>
Message-ID: <1e7ecce7-2e46-ea46-3c5b-357d53a238c3@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 15. 06. 21 9:40, Richard Palethorpe wrote:
> The test author is guaranteed that the library will not set TST_ERR
> except via the TEST macro and similar.

Hi, who decided to guarantee this and where is the guarantee documented?

I was planning to document that RTNL_SEND_VALIDATE() and
RTNL_CHECK_ACKS() will pass error codes found in rtnetlink ACK messages
through TST_ERR.

On 17. 06. 21 10:40, Richard Palethorpe wrote:
> Hello,
> 
> Cyril Hrubis <chrubis@suse.cz> writes:
>> I do not like this fix. If nothing else it's fragile and would make any
>> patch review for these libraries much harder.
>>
>> I would prefer having these functions modified to return the errors
>> instead even if I have to do the work.

Changing the return value to always return errno will be a major PITA
because 95% of error handling happens after some safe_syscall() which
clobbers errno by calling tst_brk() after failure. And if you only want
to return error codes from rtnetlink ACK messages, then there's the
problem what to return when a safe_syscall() fails during cleanup().

> I think there are some other issues here as well. Like the macros are
> not prefixed with SAFE_. A lot of the functions are not used or they are
> just used internally, but are not marked as static.

All the functions which are intended as internal-only are already static
in both tst_netlink.c and tst_netdevice.c. The macros are not prefixed
with SAFE_ because they're not simple syscall wrappers. They're prefixed
with RTNL_ and NETDEV_ instead.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
