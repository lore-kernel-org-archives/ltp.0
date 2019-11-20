From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Nov 2019 01:51:38 -0500 (EST)
Subject: [LTP] [PATCH] lib: don't pass NULL to strcmp in safe_mount
In-Reply-To: <CAEemH2fiyODj=FedbVK8xtrgz1T3JWO5dBiSUbA1L24XOx2yqA@mail.gmail.com>
References: <1a623a82dfac64c8a6f9805c197fa72cb5e6f046.1574159295.git.jstancek@redhat.com>
 <CAEemH2fiyODj=FedbVK8xtrgz1T3JWO5dBiSUbA1L24XOx2yqA@mail.gmail.com>
Message-ID: <2022379807.13117932.1574232698559.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Tue, Nov 19, 2019 at 6:29 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> > Rachel reports, that pivot_root01 crashes on latest LTP:
> >   Thread 3.1 "pivot_root01" received signal SIGSEGV, Segmentation fault.
> >   0x00000000004062c4 in safe_mount (file=file@entry=0x413017
> > "pivot_root01.c"
> >   733             if (strcmp(filesystemtype, "ntfs")) {
> >
> > Don't pass NULL ptr to strcmp. Also fix return in unreachable path,
> > to suppress warning about returning uninitialized 'rval'.
> >
> 
> Good catch.
> 
> And shouldn't we give a "correct" fs_type in pivot_root01.c too? Otherwise,
> the test would be failed on an invalid mounted operation I guess.

Per man-page, it should be ignored.

