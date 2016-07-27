From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 16:17:25 +0200
Subject: [LTP] [PATCH V3 14/23] shmat1: Cover GNU specific code under
 __USE_GNU
In-Reply-To: <20160722042656.22346-14-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-14-raj.khem@gmail.com>
Message-ID: <20160727141725.GC11986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#if defined(__i386__) && defined(__USE_GNU)

Hmm, shouldn't this rather be defined(__GLIBC__) ?

As far as I can tell __USE_GNU is enabled if _GNU_SOURCE is defined
while __GLIBC__ is defined in glibc unconditionally.

-- 
Cyril Hrubis
chrubis@suse.cz
