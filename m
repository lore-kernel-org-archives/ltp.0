From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 17 Feb 2020 13:39:47 +0530
Subject: [LTP] [PATCH 2/7] syscalls/fsopen: New tests
In-Reply-To: <CAEemH2emOw=Abnvk-3EOVFyCoY=c6HtC_1o0gih5n+aL-WfXLw@mail.gmail.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <e4955c8edfb29c1d0f74a8cd24b1dcc68f3b6814.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2emOw=Abnvk-3EOVFyCoY=c6HtC_1o0gih5n+aL-WfXLw@mail.gmail.com>
Message-ID: <20200217080947.2x7peip36m3vwfi2@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16-02-20, 18:11, Li Wang wrote:
> > +static struct tst_test test = {
> > +       .min_kver = "5.2",
> >
> 
> I suggest removing .min_kver check in all of the tests to let they can be
> running on many distributions(which backport the features).

I never thought about that earlier, good point. All other comments look fine as
well. Thanks.

-- 
viresh
