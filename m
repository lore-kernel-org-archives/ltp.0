From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Mar 2019 06:25:27 -0500 (EST)
Subject: [LTP] [PATCH v2] syscalls/readahead02: limit max readahead to
 backing device max_readahead_kb
In-Reply-To: <CAOQ4uxjAJYmUAX85LfFpYw+bGi4ozvSQNfz+v7afR0dp0KfWkQ@mail.gmail.com>
References: <CAOQ4uxi49WogvHDck_JXiUV8VfLDHhzu=EYVYWiTz+zagT41KA@mail.gmail.com>
 <CAOQ4uxiVkayLBWPAdPSz9W17hPNp7LagdtJ2k+vL98C0KgbKtA@mail.gmail.com>
 <20190306164256.GA570@dustball.usersys.redhat.com>
 <CAOQ4uxjO+jYKzor7_eqBd8HMGs=m-EKt3jd+jRtOhh_KNPzYXQ@mail.gmail.com>
 <1883827755.5820362.1551946723163.JavaMail.zimbra@redhat.com>
 <CAOQ4uxinA3x264gS=b5Wb7EkSF7EgF7DGe8Mj7LVWhK07RNsvw@mail.gmail.com>
 <982407679.5828214.1551950109663.JavaMail.zimbra@redhat.com>
 <CAOQ4uxjAJYmUAX85LfFpYw+bGi4ozvSQNfz+v7afR0dp0KfWkQ@mail.gmail.com>
Message-ID: <1016571882.5846458.1551957927293.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> > > Try to set bdi limit of test device on setup() to testfile_size before
> > > reading
> > > back the value?
> > > If that fails try testfile_size / 2 etc.
> >
> > Maybe, but we would need to start lower (2M). Kernels prior to
> > commit 600e19afc5f8a6c18ea49cee9511c5797db02391 will just ignore it.
> >
> 
> Ah. Thanks for the reference.
> But kernels prior to this commit SHOULD fail the test if they
> don't comply with explicit readahead() request that is below 2M

Yes, agreed.

> and bdi limit.

What I meant was, that we can try bumping bdi limit, but our
max readahead length has to be capped to MIN(bdi limit, 2M).

Does that make sense?

> That is the case that the commit sets to fix. No?
> 
> Thanks,
> Amir.
> 
