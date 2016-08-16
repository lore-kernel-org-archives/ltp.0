From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 13:31:48 +0200
Subject: [LTP] [PATCH] syscalls/fcntl34: Use -D_FILE_OFFSET_BITS=64 for
 all cases
In-Reply-To: <CAFEAcA9DiMn=YE25Jk_MoQYHa_B3FxcdLWycAjoxH8neyzEvMA@mail.gmail.com>
References: <1471021912-29886-1-git-send-email-yuriy.kolerov@synopsys.com>
 <20160815120810.GC20680@rei.lan>
 <3ABF60118B9B784CA5BF7C841D2F00EC01000AF3@de02wembxa.internal.synopsys.com>
 <20160816100223.GA24312@rei.lan>
 <3ABF60118B9B784CA5BF7C841D2F00EC01000B69@de02wembxa.internal.synopsys.com>
 <CAFEAcA9DiMn=YE25Jk_MoQYHa_B3FxcdLWycAjoxH8neyzEvMA@mail.gmail.com>
Message-ID: <20160816113148.GC24312@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Actually both glibc and uClibc use fcntl64 by default and usually
> > fail when you try to pass 32-bit flock structure to it when you
> > use OFD locks. Then fcntl64 fails in fcntl_setlk64 routing while
> > checking l_pid field.
> 
> Given the cleverness glibc applies to flock(), it might be more
> useful for the LTP syscall tests to directly test the system calls
> avoiding the libc wrappers. That way you could know that you've
> definitely tested both flock and flock64 syscalls on platforms
> where they exist.

I guess that we should be testing both. As it stands now we do not test
the 32bit fcntl() at all.

-- 
Cyril Hrubis
chrubis@suse.cz
