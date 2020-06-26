From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jun 2020 10:05:29 +0200
Subject: [LTP] [PATCH V2 1/2] libs: Import vdso parsing lib from kernel
 tree
In-Reply-To: <20200626035509.vag5m6fejs6rwl7x@vireshk-i7>
References: <0f1cc05d6d79238ed94b93417f300e9a026a2063.1591864369.git.viresh.kumar@linaro.org>
 <20200625132352.GA28350@yuki.lan>
 <20200626035509.vag5m6fejs6rwl7x@vireshk-i7>
Message-ID: <20200626080529.GA2631@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Pushed with minor changes, thanks.
> > 
> > * Moved the comment about the function usage to the header
> > 
> > * Fixed some compiler warnings
> 
> I avoided these so in future we can simply copy paste the file from
> kernel tree to get more updates, and so we keep the delta between them
> to none.

These were minor changes, so we can copy the file over and redo them.

Also it looks like the kernel Makefile does not enable warnings at all,
which probably is not optimal, but who am I to complain...

-- 
Cyril Hrubis
chrubis@suse.cz
