From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Oct 2019 20:04:47 +0200
Subject: [LTP] [RFC PATCH] LTP Wrapper for Syzkaller reproducers
In-Reply-To: <CACT4Y+ZL8ocQPpwR-_8+0PdF=r3AkFZKvOR==+P0y0GF67w1Vg@mail.gmail.com>
References: <20191009142446.6997-1-rpalethorpe@suse.com>
 <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
 <20191009145416.GA5014@rei.lan>
 <CACT4Y+ZL8ocQPpwR-_8+0PdF=r3AkFZKvOR==+P0y0GF67w1Vg@mail.gmail.com>
Message-ID: <20191009180447.GD15291@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Indeed, it's removed recursively by the test library.
> 
> :popcorn:
> 
> It took me several years to figure out how to more or less reliably
> remove dirs after the fuzzer ;)
> (no, unlink won't do ;))

I guess that there are things such as immutable file attributes that has
to be cleared and many more. Do you have piece of code somewhere that we
can look into to spare us from reinventing the wheel?

-- 
Cyril Hrubis
chrubis@suse.cz
