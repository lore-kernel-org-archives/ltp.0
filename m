From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Oct 2020 13:47:38 +0800
Subject: [LTP] Broken Fedora build
In-Reply-To: <5F91163D.9030307@cn.fujitsu.com>
References: <20201021193547.GA49488@x230>
 <CAEemH2cAeMzbr6WWDOTTNYkU8b+1J+7WEHjGU283r3qWtXP8TA@mail.gmail.com>
 <5F90F214.20102@cn.fujitsu.com> <5F91163D.9030307@cn.fujitsu.com>
Message-ID: <CAEemH2eUfSgvmDB4EA6i3K6O9CCgiSa8CA5sKLQS2a_wOhDtXw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> >> I prefer to go replace ftime() by gettimeofday() or clock_gettime()
> >> way to solve this from root.
> > +1
> >
> > I have seen the hugetlb.c and trace_sched.c code, they all use the
> > time to generate a random value for ftok or sched_priority. So using
> > gettimeofday() also looks ok.
> Hi,
>
> It is fine for me to replace ftime(), but I wonder if we can remove
> fime() and srand()/srandom() directly? :-)
> It seems unnecessary to set the seed for random number.

That's true, but random() will generate the same number each time.
I slightly tend to keep setting the seed by srandom() to get a different
randomized number for test variety.

-- 
Regards,
Li Wang

