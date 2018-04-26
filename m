From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Apr 2018 12:54:15 +0200
Subject: [LTP] [PATCH 1/2] *.py: Replace '#!/usr/bin/python3' with
 '#!/usr/bin/env python3'
In-Reply-To: <5AE19028.6050804@cn.fujitsu.com>
References: <1524725137-32739-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <5AE179C6.3050300@cn.fujitsu.com> <20180426080658.GA4482@x230>
 <20180426081639.GB4482@x230> <5AE19028.6050804@cn.fujitsu.com>
Message-ID: <20180426105414.cugq7rstaifqnxvn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> > > > On 2018/04/26 14:45, Xiao Yang wrote:
> > > > > If we install python3 in specific path(/usr/local/bin) rather than the
> > > > > default(/usr/bin), the standard shebang(#!/usr/bin/python3) cannot
> > > > > interpreter python code due to wrong path.  We should use env to
> > > > > search the correct path of python3 dynamically.
> > > > ----------------------------------------------------------------------------
> > > > # which python3
> > > > /usr/local/bin/python3
> > > > # ./in.py
> > > > -bash: ./in.py: /usr/bin/python3: bad interpreter: No such file or directory
> > > > ----------------------------------------------------------------------------
> > And is it really general RHEL6.9GA problem? Isn't it installable into standard path with
> > EPEL? [1]
> Hi Petr,

> Neither, i just install python3 into /usr/local/bin by Python-3.6.5.tgz on purpose.  :-P
And what prevent you to use either python34 from EPEL (which installs into standard
/usr/bin) or symlinking your compiled python3 into /usr/bin ?

Both are working solutions.

> Thanks,
> Xiao Yang


Kind regards,
Petr
