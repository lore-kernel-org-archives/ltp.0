From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 26 Apr 2021 11:53:57 +0530
Subject: [LTP] [PATCH] Fix the 64-bit macro definition of mips
 architecture
In-Reply-To: <YIZa4Ph81LmkEkLZ@pevik>
References: <20210422072609.9938-1-sujiaxun@uniontech.com>
 <YIZSzNd9uK8kItYb@pevik>
 <20210426055556.dmcogdykez2ddxn3@vireshk-i7>
 <YIZa4Ph81LmkEkLZ@pevik>
Message-ID: <20210426062357.i72js3urkoofvzcj@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26-04-21, 08:17, Petr Vorel wrote:
> Hi Viresh,
> 
> ...
> > > > -#if defined(__arch64__)
> > > > +#if defined(__mips64)
> > > So __arch64__ is not defined for mips 64 bit? (as it's defined for sparc 64bit?)
> > > __mips64 is obviously correct and better readable, but is it really required?
> 
> > I am not sure what you meant by "is it really required?" The #ifdef hackery here
> > ? It is as can be seen in include/uapi/asm-generic/shmbuf.h in Linux source.
> I mean if #if defined(__mips__) && defined(__arch64__) detect 64bit mips
> the patch would not be needed (although IMHO __mips64 is more descriptive than
> __arch64__, for which you need to search for which architecture it was defined).

Ahh, right.

Actually the kernel has this instead:

#if __BITS_PER_LONG == 64

> But I'm not sure myself if __arch64__ is defined for mips 64bit.

Neither do I.

-- 
viresh
