From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Nov 2018 17:03:20 +0100
Subject: [LTP] [PATCH 4/5] syscalls/fanotify03: add test for
 FAN_MARK_FILESYSTEM permission events
In-Reply-To: <CAOQ4uxjQQahvt0b=i50XeoG7Db8BzudqoXwaoHwMZ-qQHhWfxw@mail.gmail.com>
References: <20181116065119.6912-1-amir73il@gmail.com>
 <20181116065119.6912-5-amir73il@gmail.com>
 <20181121131448.GE2954@rei>
 <CAOQ4uxjQQahvt0b=i50XeoG7Db8BzudqoXwaoHwMZ-qQHhWfxw@mail.gmail.com>
Message-ID: <20181122160320.GD907@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that we depend on the order of the tcases[] array here, which is
> > not very nice.
> >
> 
> Indeed. It is a simplification. All test cases are permission events,
> so the order of failure types is not likely to change, but I could add a
> comment about the order near test cases definition.
> Would you rather that I did an explicit test for permission support at setup()
> time?

Either one would be fine.

-- 
Cyril Hrubis
chrubis@suse.cz
