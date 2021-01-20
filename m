From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jan 2021 16:06:41 +0100
Subject: [LTP] [PATCH] tst_pollute_memory(): Set minimal safety margin
 to 64MB
In-Reply-To: <CA+G9fYuDpnJOcHA5Me4KM4v+NaFW=2_3id=Am6skbDavb1iACw@mail.gmail.com>
References: <20210118163240.29558-1-mdoucha@suse.cz>
 <YAbT62ecN/lq12cT@yuki.lan>
 <CA+G9fYv_6tiMrF38jLPYK=C6D+LNBndun1XuGQJiOK60LhYRyA@mail.gmail.com>
 <YAhEEzWShFLlHrk1@yuki.lan>
 <CA+G9fYuDpnJOcHA5Me4KM4v+NaFW=2_3id=Am6skbDavb1iACw@mail.gmail.com>
Message-ID: <YAhHAWTedDb/6Hd/@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > I have applied your patch and rebuilt completely and retested
> > > ioctl_sg01 test case in a loop on three different devices.
> > >
> > > 1 PASS out of 20 runs with overcommit_memory 0 on x86_64.
> > > 1 PASS out of 20 runs with overcommit_memory 1 on x86_64.
> > >
> > > Which means 19 times the test case triggered oom-killer and the test was broken.
> >
> > So it looks like 64MB is not enough in your case.
> >
> > Does it work with 128MB or 256MB?
> >
> > i.e.:
> >
> > safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
> > safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 256 * 1024 * 1024);
> 
> 
> I will test with these changes and get back to you.
> 
> Meanwhile,
> 
> 20 PASS out of 20 runs with overcommit_memory 2 on x86_64.

That is to be expected, since with overcommit_memory=2 we fail the
mmap() when the kernel does  not think there is enough free memory. See
the part where we do:

	if (map_blocks[i] == MAP_FAILED) {
		map_count = i;
		break;
	}

It would be interesting to print the map_count and the value of i in
this fucntion and see where it breaks with overcommit_memory=2.

i.e.

	if (map_blocks[i] == MAP_FAILED) {
		tst_res(TINFO, "mmap() failed at %zu expected %zu",
		        i, map_count);
		map_count = i;
		break;
	}


-- 
Cyril Hrubis
chrubis@suse.cz
