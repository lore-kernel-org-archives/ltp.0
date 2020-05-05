From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 05 May 2020 11:36:36 +0200
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <20200505091554.eq7kzvb4twe2wgvl@wittgenstein> (Christian
 Brauner's message of "Tue, 5 May 2020 11:15:54 +0200")
References: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 <87pnbi4y8x.fsf@mid.deneb.enyo.de>
 <20200505083205.qwwdiotmmjl23aje@wittgenstein>
 <87a72m4uqm.fsf@mid.deneb.enyo.de>
 <20200505091554.eq7kzvb4twe2wgvl@wittgenstein>
Message-ID: <871rny4taz.fsf@mid.deneb.enyo.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Christian Brauner:
>> Have any flags been added recently?
>
> /* Flags for the clone3() syscall. */
> #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
> #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */

Are those flags expected to be compatible with the legacy clone
interface on 64-bit architectures?

>> > (Note, that CLONE_LEGACY_FLAGS is already defined as
>> > #define CLONE_LEGACY_FLAGS 0xffffffffULL
>> > and used in clone3().)
>> >
>> > So the better option might be to do what you suggested, Florian:
>> > if (clone_flags & ~CLONE_LEGACY_FLAGS)
>> > 	clone_flags = CLONE_LEGACY_FLAGS?
>> > and move on?
>> 
>> Not sure what you are suggesting here.  Do you mean an unconditional
>> masking of excess bits?
>> 
>>   clone_flags &= CLONE_LEGACY_FLAGS;
>> 
>> I think I would prefer this:
>> 
>>   /* Userspace may have passed a sign-extended int value. */
>>   if (clone_flags != (int) clone_flags) /* 
>>  	return -EINVAL;
>>   clone_flags = (unsigned) clone_flags;
>
> My worry is that this will cause regressions because clone() has never
> failed on invalid flag values. I was looking for a way to not have this
> problem. But given what you say below this change might be ok/worth
> risking?

I was under the impression that current kernels perform such a check,
causing the problem with sign extension.
