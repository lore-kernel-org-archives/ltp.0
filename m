From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Apr 2020 13:49:26 +0200
Subject: [LTP] What is wrong with this program ?
In-Reply-To: <20200428100254.3oiu3weon3uyyvkl@vireshk-i7>
References: <20200428094745.io5fni2txzl6n37q@vireshk-i7>
 <20200428095222.GC6221@yuki.lan>
 <20200428100254.3oiu3weon3uyyvkl@vireshk-i7>
Message-ID: <20200428114926.GA14333@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > It fails with:
> > > 
> > > safe_macros.c:230: BROK: foo.c:9: open(file,66,01) failed: EACCES (13)
> > > 
> > > if run as a normal user and passes with sudo.
> > 
> > I guess that you forget to pass the mode argument to the first
> > SAFE_OPEN() and hence the second one fails because the garbage passed to
> > mode prevents normal users from opening the file.
> 
> Hmm, mode seems to be missing from a lot of syscall tests, which means that if
> they are run in a loop (with the cmdline way you mentioned earlier), then they
> will all fail.

If there is open() with O_CREAT without mode it's a bug.

-- 
Cyril Hrubis
chrubis@suse.cz
