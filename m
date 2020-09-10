From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Sep 2020 16:50:42 +0300
Subject: [LTP] [PATCH 00/10] Fanotify tests for v5.9
In-Reply-To: <CAOQ4uxjAwQcmSnsJ5=O88bi2zxAzAe8uXCgg4+5mF6qOmSBfGQ@mail.gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
 <20200910112730.GA7194@dell5510>
 <CAOQ4uxjAwQcmSnsJ5=O88bi2zxAzAe8uXCgg4+5mF6qOmSBfGQ@mail.gmail.com>
Message-ID: <CAOQ4uxi3fv-ONsJoXYwTh2iP5fM2Ssj7GgcrzcEGRtsEbYgNLw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 10, 2020 at 4:36 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Sep 10, 2020 at 2:27 PM Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Hi Amir,
> >
> > > Following are the tests that were used to develop the upcoming fanotify
> > > features in v5.9.
> >
> > > The inotify/dnotify tests and fanotify09 test case are regression tests
> > > for a mid series bug that has been fixed before the merge.
> > Patchset merged.
> >
> > > fanotify10 gets another set of test cases to catch yet another ignored
> > > mask logic bug. The fix commit will be too hard to backport IMO, so
> > > perhaps these test cases should go into a new test with .min_kver = "5.9".
> > Can we just skip particular test with tst_parse_kver() or tst_kvcmp()? Because
> > other tests are valid, thus why to skip them (which would be when using
> > .min_kver).
>
> Sure I did not know about tst_parse_kver() I will send a patch.
>
> BTW, sorry for the wrong commit id in the test.
> Your fix missed removing the old commit from comment:
>
>   * Test cases #17-#23 are regression tests for commit:
>   *
>   *     497b0c5a7c06 fsnotify: send event to parent and child with single...
>   *     eca4784cbb18 fsnotify: send event to parent and child with single...
>   */
>

Actually, I don't see any examples of tests that use tst_kvcmp()
Do you mind making and testing this change?

All the test cases in fanotify10 with non zero tc->ignored_onchild should be
skipped for kver < 5.9

Thanks,
Amir.
