From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Nov 2017 11:25:37 +0100
Subject: [LTP] [PATCH 1/2] [mtest06] Fix race condition with signal
 handling
In-Reply-To: <1187592937.37117661.1510045232581.JavaMail.zimbra@redhat.com>
References: <20171103185941.17651-1-vkabatov@redhat.com>
 <20171106163809.GB1662@rei>
 <1187592937.37117661.1510045232581.JavaMail.zimbra@redhat.com>
Message-ID: <20171107102537.GB6126@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Maybe we can fix that by making sure that we got different address in
> > two subsequent mmaps in the map_write_unmap() loop (for instance by
> > unmaping the old one after we mapped a new one) then we can check the
> > si_addr in the siginfo_t in the signal handler. If the address is
> > different from the current one we know that the SEGFAULT has happened
> > before we mmaped() the file again. If that works we don't have to
> > implement any locking at all which would increase our chances of hitting
> > some race condition in the kernel...
> 
> This doesn't capture the state of mapped area. When you're in signal
> handler you wouldn't know if area was mapped or not when you got SIGSEGV.
>
> I'd modify it in this way:
> - use just one singal handler
> - write thread will set 'mapped' flag when it maps/unmaps the area
> - based on 'mapped' flag read thread tries to read from a specific range of addresses
>   e.g. odd vs even bytes or odd vs. even blocks of bytes, such that
>   those blocks don't overlap
> - when signal handler triggers, it checks si_addr, and based on value
>   it can tell if this was an attempt to read mapped or unmapped area
> - if we tried to read mapped area and got SIGSEGV -> FAIL
>   otherwise keep running

I like the idea of encoding the information about the mapped/unmapped
state into the actuall address we attempt to read, nice trick, let's do
that.

-- 
Cyril Hrubis
chrubis@suse.cz
