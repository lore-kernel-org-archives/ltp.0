From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Nov 2020 17:22:09 +0800
Subject: [LTP] [PATCH 1/1] travis: Add libefivar support
In-Reply-To: <20201110134625.GA6482@pevik>
References: <20201110120035.20543-1-pvorel@suse.cz>
 <20201110134625.GA6482@pevik>
Message-ID: <CAEemH2cP8Tub5UjBcRoo2Nkwtku7KjtUYP9U9v75GHEywe=aXw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 10, 2020 at 9:46 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > Travis CI:
> > https://travis-ci.org/github/pevik/ltp/builds/742684375
>
> Looks like Debian does not ship libefivar-dev for ppc64el
> https://travis-ci.org/github/pevik/ltp/jobs/742684377


From Travis CI, the CentOS8 reports miss efivar-devel package too.

Maybe fix it by the following?

--- a/travis/fedora.sh
+++ b/travis/fedora.sh
@@ -9,11 +9,11 @@ yum -y install \
        clang \
        gcc \
        findutils \
-       efivar-devel \
        libtirpc \
        libtirpc-devel \
        pkg-config \
        redhat-lsb-core

-# CentOS 8 doesn't have libmnl-devel
+# CentOS 8 doesn't have libmnl-devel and efivar-devel
 yum -y install libmnl-devel || yum -y install libmnl
+yum -y --skip-broken install efivar-devel

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201111/0d77aaab/attachment-0001.htm>
