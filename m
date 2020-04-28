From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 28 Apr 2020 12:09:24 +0200
Subject: [LTP] What is wrong with this program ?
In-Reply-To: <20200428100254.3oiu3weon3uyyvkl@vireshk-i7>
References: <20200428094745.io5fni2txzl6n37q@vireshk-i7>
 <20200428095222.GC6221@yuki.lan> <20200428100254.3oiu3weon3uyyvkl@vireshk-i7>
Message-ID: <2a840c1c-7013-c817-8bb6-255a4861e785@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 28. 04. 20 12:02, Viresh Kumar wrote:
> Hmm, mode seems to be missing from a lot of syscall tests, which 
> means that if they are run in a loop (with the cmdline way you 
> mentioned earlier), then they will all fail.

Allow me to quote from TFM:

> The mode argument specifies the file mode bits be applied when a new
> file is created. This argument must be supplied when O_CREAT or
> O_TMPFILE is specified in flags; if neither O_CREAT nor O_TMPFILE is
> specified, then mode is ignored. The effective mode is modified by
> the process's umask in the usual way: in the absence of a default
> ACL, the mode of the created file is (mode & ~umask). Note that this
> mode applies only to future accesses of the newly created file; the
> open() call that creates a read-only file may well return a
> read/write file descriptor.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
