From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Feb 2018 16:17:55 +0100
Subject: [LTP] [PATCH] openposix: mmap/21-1: adjust the test to work
 with MAP_SHARED_VALIDATE
In-Reply-To: <a6a0ea9a-6552-bdf3-3b31-64e85cb09cbc@oracle.com>
References: <1518105323-12867-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20180208163453.GA2049@rei>
 <a6a0ea9a-6552-bdf3-3b31-64e85cb09cbc@oracle.com>
Message-ID: <20180212151755.GA23827@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +int is_valid(int flag)
> >> +{
> >> +	if (flag == MAP_SHARED || flag == MAP_PRIVATE || flag == MAP_FIXED)
> >> +		return 1;
> >> +
> >> +#ifdef __linux__
> >> +
> >> +#ifndef MAP_SHARED_VALIDATE
> >> +#define MAP_SHARED_VALIDATE 0x03
> >> +#endif
> >> +
> >> +	if (flag == MAP_SHARED_VALIDATE)
> >> +		return 1;
> >> +#endif
> >> +
> >> +	return 0;
> >> +}
> > 
> > Hmm, this probably does not scale up, what about setting the flag to
> > have all its bits set (i.e. passing ~0 to the mmap()) from the start
> > instead?
> > 
> 
> In main() we search for the first value of 'flag' for which the
> following statement is not true:
> 
> flag == MAP_SHARED || flag == MAP_PRIVATE || flag == MAP_FIXED || flag
> == MAP_SHARED_VALIDATE
> 
> where the last part is Linux-specific and likely needs an #ifdef.
> 
> We are not interested if flag has MAP_SHARED or other bits set, but we
> are interested when flag _equals_ MAP_SHARED or other values.
> 
> In order to make the code more readable (IMHO) I decided to move this
> check into a separate function.
> 
> I don't fully understand your proposal. Could you, please, elaborate a
> bit more?

We are trying to trigger EINVAL by passing an invalid flags value to
mmap. And given that the flags are likely to be allocated in increasing
manner starting with known flag and increasing it while it's equal to
other known flags will break again sooner or later and we will end up
adding more and more special cases for different systems.

Hence I suggest to use a value that is unlikely to be valid flag (all
bits set) and use that for the testing.

-- 
Cyril Hrubis
chrubis@suse.cz
