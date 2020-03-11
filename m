From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Mar 2020 11:26:20 +0100
Subject: [LTP] [PATCH V5 01/10] tst_device: Add tst_is_mounted() helper
In-Reply-To: <CAEemH2drJyp5kU21jS7Ej+-q6hTysb5oDNM+3KiWsmPoLAbMQA@mail.gmail.com>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <2071e47d7d8cb3e7f8bc6558e86999eddd9c3762.1582779464.git.viresh.kumar@linaro.org>
 <20200306124546.GA3375@rei.lan>
 <CAEemH2drJyp5kU21jS7Ej+-q6hTysb5oDNM+3KiWsmPoLAbMQA@mail.gmail.com>
Message-ID: <20200311102620.GB3802@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also this does not even handle the case that the command is missing.
> >
> > Looking at the v4 version, all we need is to correctly parse each line
> > from from /proc/mounts. I would just use strsep() with space as a
> > delimited and took first token that starts with a slash i.e. '/', then
> > we can just strcmp() it against the path. Or do I miss something?
> >
> 
> I'm afraid strcmp() can not satisfy the requirement for us. As you know LTP
> creates the MNTPOINT in temp dir that means it could not accurately match
> the string path which extracts from /proc/mounts with a slash.
> 
> e.g
> #define MNTPOINT "fallocate"
> ...
> /dev/loop4 on /tmp/FPp7kh/fallocate type xfs
> (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> ...
> strcmp("/tmp/FPp7kh/fallocate", MNTPOINT) will never ruturn 0 to us.
> 
> What I can think of is to use strrchr() to cut the string after last '/',
> but that can only work for test mount fs in LTP ways. Other situations
> might not satisfy.

Hmm, for that we have to have compose the path for the comparsion
anyways, since unless we pass an absoule path we can never be user if we
have a right match or not. There may be leftover mount points from a
failed tests that have faile to cleanup properly as well.

So I guess that we need one more function, with tmpdir in name, that
would compose the right path for us and then call the tst_is_mntpoint().

I would have called that:

int tst_is_mntpoint_at_tmpdir(const char *path);

-- 
Cyril Hrubis
chrubis@suse.cz
