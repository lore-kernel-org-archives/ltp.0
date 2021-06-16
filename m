From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jun 2021 11:28:33 +0200
Subject: [LTP] [PATCH v2] syscalls/mallinfo2_01: Add a basic test for
 mallinfo2 when setting 2G size
In-Reply-To: <da3974e4-76ee-1eee-b730-c49953c21120@jv-coder.de>
References: <YKzX7FPWGGROn6kR@pevik>
 <1622713444-21197-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YMmiQfWgvqtCzOmg@pevik>
 <da3974e4-76ee-1eee-b730-c49953c21120@jv-coder.de>
Message-ID: <YMnEQSEAT5LTBSwN@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > BTW Cyril also suggested recently to drop out of tree support, because build
> > system dependencies are broken and fixing it would be much easier when
> > supporting only in tree build.
> Really? I got the feeling out-of-tree builds are becoming the new normal 
> and even complex pieces of software like the kernel, glibc and gcc are 
> able to be built out-of-tree or even enforce it.

The question here really if support of out-of-tree build is worth the
trouble. The problem is that the complexity it adds to the build system
is quite high. The way it's implemented in LTP the build system has to
work with absolute paths and you have to make sure you have the right
path to a file all the time and people are often confused by this. Also
it crashes and burns with cryptic error messages if you happen to have
characters interpreted by make in a directory name anywhere from the LTP
dir to the filesystems root (try adding : to a directory name for
instance). We used to have out-of-tree build broken for years, before we
set up a CI, and nobody complained. So considering all of this it may be
for the better to just get rid of it.

I'm not against out-of-tree build in principle but given that the way
it's implemented in LTP is subtly broken by design and that there does
not seem to be real users it does not make that much sense to keep it
maintained and spend any effort to keep it afloat.

> Maybe it is time to abandon autoconf/automake and switch to a better 
> build configuration systems like cmake instead of abandoning out-of-tree 
> builds.

I'm not againts this, the main problem is that this will take a
significant effort my guess is at least month to implement and and even
more to iron out all the corner cases. Also the choosen build systems
has to be generally available even on 10 years old system, but I guess
that cmake should classify easily here.

-- 
Cyril Hrubis
chrubis@suse.cz
