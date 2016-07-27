From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 27 Jul 2016 08:15:14 -0700
Subject: [LTP] [PATCH V3 11/23] lapi: Use sig_t instead of sighandler_t
In-Reply-To: <20160727102218.GC10903@rei.lan>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-11-raj.khem@gmail.com> <20160727102218.GC10903@rei.lan>
Message-ID: <46510D01-1510-4C0E-BD03-7B8896652B55@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Jul 27, 2016, at 3:22 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> 
> Hi!
>> --- a/testcases/kernel/syscalls/rt_sigsuspend/Makefile
>> +++ b/testcases/kernel/syscalls/rt_sigsuspend/Makefile
>> @@ -19,4 +19,5 @@
>> top_srcdir		?= ../../../..
>> 
>> include $(top_srcdir)/include/mk/testcases.mk
>> +
>> include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 
> Again this added newline is unintended change that should not have been
> part of this patch.

overusing from my side. Do you want me to send a v4 ?


> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 204 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160727/39e052df/attachment.sig>
