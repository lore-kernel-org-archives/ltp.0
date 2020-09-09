From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Sep 2020 15:27:03 +0200
Subject: [LTP] LTP release
In-Reply-To: <20200909131327.GA3241@yuki.lan>
References: <20200908073138.GB2475@yuki.lan>
 <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
 <20200908153659.GA16066@yuki.lan>
 <CAEemH2eq0fwF8zt1uez5vuwM0vtrLtoFd_45sFqE=iQ8hpudfQ@mail.gmail.com>
 <CAEemH2es3sMSfAar8Xj4_Vr+2nsD0isPws4v=8=csLyYROAQGQ@mail.gmail.com>
 <20200909131327.GA3241@yuki.lan>
Message-ID: <20200909132703.GB3241@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Also I would like to get rid of the -fno-optimize-sibling-calls in the
> Makefile, this makes the test a bit fragile and less portable.

What about this code:

#include <stdint.h>
#include <stdio.h>

static intptr_t addr_func(void) __attribute__((noinline));

static intptr_t addr_func(void)
{
	int a;

	return (intptr_t)&a;
}

/*
 * Returns negative number if stack grows down, possitive if stack grows up
 */
static int stack_dir(void)
{
	intptr_t addr = addr_func();

	printf("%p %p\n", &addr, (void*)addr);

	return addr - (intptr_t)&addr;
}

int main(void)
{
	printf("%i\n", stack_dir());

	return 0;
}

-- 
Cyril Hrubis
chrubis@suse.cz
