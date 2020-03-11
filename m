From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Mar 2020 11:20:38 +0100
Subject: [LTP] [PATCH V5 01/10] tst_device: Add tst_is_mounted() helper
In-Reply-To: <20200311073113.q7e7jauldjyizz2q@vireshk-i7>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <2071e47d7d8cb3e7f8bc6558e86999eddd9c3762.1582779464.git.viresh.kumar@linaro.org>
 <20200306124546.GA3375@rei.lan>
 <CAEemH2drJyp5kU21jS7Ej+-q6hTysb5oDNM+3KiWsmPoLAbMQA@mail.gmail.com>
 <20200311073113.q7e7jauldjyizz2q@vireshk-i7>
Message-ID: <20200311102038.GA3802@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I'm afraid strcmp() can not satisfy the requirement for us. As you know LTP
> > creates the MNTPOINT in temp dir that means it could not accurately match
> > the string path which extracts from /proc/mounts with a slash.
> > 
> > e.g
> > #define MNTPOINT "fallocate"
> > ...
> > /dev/loop4 on /tmp/FPp7kh/fallocate type xfs
> > (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> > ...
> > strcmp("/tmp/FPp7kh/fallocate", MNTPOINT) will never ruturn 0 to us.
> > 
> > What I can think of is to use strrchr() to cut the string after last '/',
> > but that can only work for test mount fs in LTP ways. Other situations
> > might not satisfy.
> 
> @Cyril, can we please finalize what you guys want me to do here ? I
> don't really want to repost the patch, which still has issues :)

Sorry for the back and forth.

I remmebered yesterday that there is setmntent() in libc, so i we call
that on /proc/mounts, the whole problem would be reduced to a path
comparsion.

-- 
Cyril Hrubis
chrubis@suse.cz
