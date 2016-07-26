From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 17:39:34 +0200
Subject: [LTP] [PATCH V3 04/23] Remove unused __BEGIN_DECLS and
 __END_DECLS
In-Reply-To: <20160722042656.22346-4-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-4-raj.khem@gmail.com>
Message-ID: <20160726153934.GA5868@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Replace __s32 definitions with int32_t
> its not a generally available typedef

Are you sure that __s32 is the only one missing?

Since all the __sXX and __uXX types are defined in a file included in
/usr/include/asm-generic/types.h (int-ll64.h on x86_64) which is a part
of linux-headers package. This rather looks like something is wrong with
your kernel headers.

-- 
Cyril Hrubis
chrubis@suse.cz
