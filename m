From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 18 Feb 2020 13:55:06 +0530
Subject: [LTP] [PATCH 2/7] syscalls/fsopen: New tests
In-Reply-To: <CAEemH2caDii5LcOX7fbOcrJNY9=TL6RfEi6Y0ajybxMKNgw7ag@mail.gmail.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <e4955c8edfb29c1d0f74a8cd24b1dcc68f3b6814.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2emOw=Abnvk-3EOVFyCoY=c6HtC_1o0gih5n+aL-WfXLw@mail.gmail.com>
 <20200217133638.GB14410@rei>
 <CAEemH2caDii5LcOX7fbOcrJNY9=TL6RfEi6Y0ajybxMKNgw7ag@mail.gmail.com>
Message-ID: <20200218082506.2hbjglknpqdo3upm@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18-02-20, 09:15, Li Wang wrote:
> On Mon, Feb 17, 2020 at 9:36 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> 
> > ...
> > > > +static struct tst_test test = {
> > > > +       .min_kver = "5.2",
> > > >
> > >
> > > I suggest removing .min_kver check in all of the tests to let they can be
> > > running on many distributions(which backport the features).
> >
> > If we do that we have to explicitely check for ENOSYS errno in each
> > test, quite possibly with a dummy call to the tested syscall in test
> > setup, because once these calls gets libc wrappers we will no longer
> > call the tst_syscall() that checks for it.
> >
> 
> +1 add dummy call to the tested syscall in the setup.
> Agree, thanks for point out this.

Not sure if I understood it very clearly and don't want to spam everyone with an
incorrect patchset still missing this point and so asking here :)

How exactly would the setup() routine look like? Something like this ?

        syscall(#NR, ##__VA_ARGS__);

-- 
viresh
