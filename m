From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jul 2020 10:07:32 +0200
Subject: [LTP] [PATCH] Convert chdir01 to the new API
In-Reply-To: <20200723113317.GA18525@dell5510>
References: <20200717152450.10787-1-mdoucha@suse.cz>
 <2b209b61-2bbc-c35f-5704-7b84bab9254d@cn.fujitsu.com>
 <20200723113317.GA18525@dell5510>
Message-ID: <20200724080732.GA16478@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Honestly speak, I don't like merge chdir02 into chdir01 and we should
> > cleanup chdir02 case individually.

We usually tend to split test into possitive and negative testcases
in order to avoid overly complex code. In this case the code looks clean
enough though.

I guess that if we wanted to have a separate test for possitive tests,
we would do something more interesting. Maybe something that does
chdir() and getcwd() in a loop for a while for a random path from a set
of paths, e.g. $TMPDIR, /, "..", "." and would expect the getcwd() to
match the new path after successful chdir() and remain unchanged after
failure. It would probably even more interesting to run chdir() and
getcwd() in a loop in several different threads, in such case we would
expect a valid return from getcwd(), i.e. any of the paths we pass to
chdir().

> chdir02.c tests chdir("/"); and chdir("/tmp"). Not sure whether full path is
> more coverage than relative path from chdir01.c.
> If we consider these useful, we can just add it into chdir01.c.
> 
> Although it looks a bit strange to chroot into root, I'd use just that and avoid
> /tmp (it breaks at least for Android with no good reason).

I guess that we can add /etc or something that is generally present on
the system.

-- 
Cyril Hrubis
chrubis@suse.cz
