From: Li Wang <liwang@redhat.com>
Date: Wed, 2 Jan 2019 13:51:04 +0800
Subject: [LTP] [PATCH 3/3] travis: Use docker based builds
In-Reply-To: <20181219141415.3495-3-pvorel@suse.cz>
References: <20181219141415.3495-1-pvorel@suse.cz>
 <20181219141415.3495-3-pvorel@suse.cz>
Message-ID: <CAEemH2cMOJcvGG-B6Ab8DTXsVjRpe6m3LB=iY6xvqrJZ4TNvcQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Dec 19, 2018 at 10:14 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Previously we used 10 Trusty environment (VM) based travis jobs with
> different gcc and clang versions installed via ubuntu-toolchain-r apt
> repository.
>
> We agreed that testing just different gcc/clang versions isn't enough,
> it'd be good to test also different glibc and kernel headers, which are
> on different distros. Therefore now we test 15 jobs based on various
> distros (Debian, Ubuntu, Fedora, openSUSE, centOS).
> We still test both gcc/clang, out-of-tree and cross-compilation builds.

I have no more comment for this changes, patch set looks pretty good to me.

>
> Disadvantage of this approach is that it's not obvious compiler and libc
> version. Travis C testing environment implementation prints compiler
> version ($CC) before installing actually used compiler via docker.
> Therefore run ver_linux printing version info and print $CC version in
> build.sh.
>
> Implements: #448
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
