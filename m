From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Jan 2018 13:28:01 +0100
Subject: [LTP] More CI testing on git push
In-Reply-To: <1887263757.4869615.1515491297851.JavaMail.zimbra@redhat.com>
References: <20180108140856.w5qaavlzfavoamuf@dell5510>
 <1887263757.4869615.1515491297851.JavaMail.zimbra@redhat.com>
Message-ID: <20180109122801.ofgvqv4ldgxorkbn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> I'm not sure how much success you will have with uclibc - we stopped
> caring about it some time ago, so I'm assuming it's broken.
I'd like to have it at least compilable.
Buildroot people are building LTP last release with different combinations including
uclibc-ng and musl in their autobuild system [2]. They reported some issues, which I
integrated in the past.


> > Cyril, Jan, which glibc and kernel header versions would you like to test?

> Is there an option to use some older distro? e.g. glibc-2.12 + 2.6.32
> That's equivalent of RHEL6.2. I wouldn't go older than that - I still
> sometimes check with RHEL5, but that one is likely not worth the effort
> given that EOL is in couple years.
I'll try to find something. From the ones publicly available it could be one (or more) of these:
* Debian 6 squeeze (kernel 2.6.32, glibc 2.11.2)
* Ubuntu 10.04 LTS lucid (kernel 2.6.32, glibc 2.11.1)
* Centos 6.9 (kernel 2.6.32, glibc 2.12)
* openSUSE 11.3 (kernel 2.6.34, glibc 2.11.2)
* Fedora 13 goddard (kernel 2.6.33.3, glibc 2.12)
* Arch Linux (kernel 2.6.33.4, glibc 2.11.1)
We will definitely need docker based CI as we want too old releases (i.e. doozer.io is not
suitable for us).

> Other than that, I'd choose something very recent, like latest Fedora.
OK, Fedora and openSUSE Tumbleweed are candidates.


Kind regards,
Petr

> > [1] https://doozer.io/docs/doozerjson

[2] http://autobuild.buildroot.net/
