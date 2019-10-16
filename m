From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Date: Wed, 16 Oct 2019 18:10:16 +0000
Subject: [LTP] ? FAIL: Test report for kernel 5.4.0-rc2-d6c2c23.cki
 (stable-next)
In-Reply-To: <20191016163528.GA27757@arm.com>
References: <cki.B4A567748F.PFM8G4WKXI@redhat.com>
 <805988176.6044584.1571038139105.JavaMail.zimbra@redhat.com>
 <CAAeHK+zxFWvCOgTYrMuD-oHJAFMn5DVYmQ6-RvU8NrapSz01mQ@mail.gmail.com>
 <20191014162651.GF19200@arrakis.emea.arm.com>
 <20191014213332.mmq7narumxtkqumt@willie-the-truck>
 <20191015152651.GG13874@arrakis.emea.arm.com>
 <20191015161453.lllrp2gfwa5evd46@willie-the-truck>
 <20191016042933.bemrrurjbghuiw73@willie-the-truck>
 <20191016144422.GZ27757@arm.com>
 <20191016145238.GL49619@arrakis.emea.arm.com>
 <20191016163528.GA27757@arm.com>
Message-ID: <ecf22341-bad2-e20b-f12c-cc80ebafda2a@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16/10/2019 17:35, Dave Martin wrote:
> On Wed, Oct 16, 2019 at 03:52:38PM +0100, Catalin Marinas wrote:
>> On Wed, Oct 16, 2019 at 03:44:25PM +0100, Dave P Martin wrote:
>>> On Wed, Oct 16, 2019 at 05:29:33AM +0100, Will Deacon wrote:
>>>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>>>> index b61b50bf68b1..c23c47360664 100644
>>>> --- a/arch/arm64/include/asm/memory.h
>>>> +++ b/arch/arm64/include/asm/memory.h
>>>> @@ -215,12 +215,18 @@ static inline unsigned long kaslr_offset(void)
>>>>   * up with a tagged userland pointer. Clear the tag to get a sane pointer to
>>>>   * pass on to access_ok(), for instance.
>>>>   */
>>>> -#define untagged_addr(addr)	\
>>>> +#define __untagged_addr(addr)	\
>>>>  	((__force __typeof__(addr))sign_extend64((__force u64)(addr), 55))
>>>>  
>>>> +#define untagged_addr(addr)	({					\
>>>
>>> Having the same informal name ("untagged") for two different address
>>> representations seems like a recipe for confusion.  Can we rename one of
>>> them?  (Say, untagged_address_if_user()?)
>>
>> I agree it's confusing. We can rename the __* one but the other is
>> spread around the kernel (it can be done, though as a subsequent
>> exercise; untagged_uaddr?).
>>
>>>> +	__addr &= __untagged_addr(__addr);				\
>>>> +	(__force __typeof__(addr))__addr;				\
>>>> +})
>>>
>>> Is there any reason why we can't just have
>>>
>>> #define untagged_addr ((__force __typeof__(addr))(	\
>>> 	(__force u64)(addr) & GENMASK_ULL(63, 56)))
>>
>> I guess you meant ~GENMASK_ULL(63,56) or GENMASK_ULL(55,0).
>>
>> This changes the overflow case for mlock() which would return -ENOMEM
>> instead of -EINVAL (not sure we have a test for it though). Does it
>> matter?
> 
> It looks like SUSv7 has m{,un}local() and mprotect() aligned with one
> another regarding ENOMEM versus EINVAL:
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/mprotect.html
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/mlock.html
> 
> So whatever we do, it should probably have the same effect on both
> calls.
> 
> 
> There's another wrinkle that occurrs to me though.  Rounding "kernel"
> addresses up can spuriously change ENOMEM to EINVAL -- but the fix for
> userspace addresses (i.e., rounding down) can likewise spuriously change
> EINVAL to ENOMEM.

well this was the point of the bit 55 check, to avoid both.
(with the assumption that getting EINVAL is not important if
overflow happens with len > 2^55 and 0 bit 55)

as far as i can tell the EINVAL for overflow is linux specific.

i think returning ENOMEM for invalid addr,len pairs should be
fine, i.e. zero extension is ok.

i think this is consistent with posix requirements, and arguably
even with current linux manual which documents EINVAL for overflow
in mlock, but also ENOMEM for unmapped pages in the range, so both
errors are ok on overflow.

so the bit 55 check only matters if something somewhere relies
on the error code in a significant way when calling syscalls with
nonsensical arguments.

> > Maybe this is OK -- the SUSv7 wording doesn't seem to call out address
> wraparound as a special case, and therefore supposedly doesn't require
> EINVAL to be returned for it.
> 
> The asymmetry is concerning though, and a bit ugly.
> 
> Cheers
> ---Dave
> 

