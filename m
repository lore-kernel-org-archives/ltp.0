From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Jan 2021 17:28:54 +0100
Subject: [LTP] [PATCH 1/2] docparse: Replace \t with space
In-Reply-To: <YAmpuuYfNQLOpi67@pevik>
References: <20210121130033.20764-1-pvorel@suse.cz> <87mtx29wiq.fsf@suse.de>
 <YAmUwVWvm84w8ITB@yuki.lan> <YAmhO8gMJ1KZ4EHA@pevik>
 <87k0s69t6z.fsf@suse.de> <YAmpuuYfNQLOpi67@pevik>
Message-ID: <YAmrxoKsiIG8UzsS@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The Makefile doesn't seem to allow this. Although it is quite easy to
> > compile docparse without it.
> That'd be easy to change.
> 
> But, there is perl package dependency. If possible I'd allow people to compile
> LTP without bothering with CPAN (mainly due these embedded build source distros,
> e.g. Buildroot, Yocto).

I guess that we can easily catch any non-ascii characters in the C
docparse tool, no perl needed.

-- 
Cyril Hrubis
chrubis@suse.cz
