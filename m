From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jan 2017 16:05:51 +0100
Subject: [LTP] [PATCH 4/4] mmapstress03: Fix 32bit test on 64bit kernel
In-Reply-To: <1342382447.1910370.1484232088575.JavaMail.zimbra@redhat.com>
References: <1484227419-16955-1-git-send-email-chrubis@suse.cz>
 <1484227419-16955-4-git-send-email-chrubis@suse.cz>
 <1342382447.1910370.1484232088575.JavaMail.zimbra@redhat.com>
Message-ID: <20170112150550.GA5381@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  	/* Ask for a ridiculously large mmap region at a high address */
> > -	if (mmap((void*) (1UL << (POINTER_SIZE - 1)) - pagesize,
> > -		 (size_t) ((1UL << (POINTER_SIZE - 1)) - pagesize),
> > +	if (mmap((void*) (1UL << (kernel_bits - 1)) - pagesize,
> 
> Since this has same range as below, shouldn't it be also 1ULL?
> Entire series looks OK to me.

Hmm, that produces warnings in case that sizeof(void) == 4 and with
64bit kernel since the value is truncated. I guess that the addres
should be generated accordingly to the binary and not kernel after all
because of address space limitations.

Something as (((uintptr_t)1) << ((sizeof(void*)<<3) - 1) - pagesize)

-- 
Cyril Hrubis
chrubis@suse.cz
