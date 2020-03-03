From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Mar 2020 12:41:44 +0100
Subject: [LTP] [PATCH v2] Add test for CVE 2017-10661
In-Reply-To: <20200303112725.GA24389@rei.lan>
References: <20200221120850.15874-1-mdoucha@suse.cz>
 <20200303104737.GA42129@gacrux.arch.suse.de>
 <20200303110249.GB42129@gacrux.arch.suse.de>
 <20200303112725.GA24389@rei.lan>
Message-ID: <20200303114144.GC42769@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> -lrt is required in LDLIBS for older libc that had all the posix
> realtime outside of the glibc.so, and it's harmless on newer glibc so
> for the time being we just need -lrt in LDLIBS for quite a lot of
> testcases...
I mean I'd put in the Makefile:

CFLAGS	+= -pthread
LDLIBS	+= -lrt

Kind regards,
Petr
