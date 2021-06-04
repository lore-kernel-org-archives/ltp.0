From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jun 2021 11:48:53 +0200
Subject: [LTP] [RFC] Reduce LICENCE/COPYING files
In-Reply-To: <CAEemH2dTBbHbh5Vf9EQyYMsvHKs3p4sZvoNyR=uCFM0X5siYtQ@mail.gmail.com>
References: <YLeA8KOphpVg3IDP@pevik> <YLi3XqA3hLh7HWqn@yuki>
 <YLjDnXeWib2KSILF@pevik>
 <CAEemH2dTBbHbh5Vf9EQyYMsvHKs3p4sZvoNyR=uCFM0X5siYtQ@mail.gmail.com>
Message-ID: <YLn3BQHhZIq5vNId@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > > > I suppose it's safe to keep only single licence in testcases/open_posix_testsuite/,
> > > > but could we keep only COPYING in the root directory and delete the rest?
> > > > Or keep COPYING and testcases/open_posix_testsuite/COPYING only?

> > > Do we even need these files? Isn't SPDX identifier enough these days?
> > It be nice we don't need it, but not sure. Looking into kernel tree, there is
> > LICENSES folder [1] and they describe how they use SPDX [2]:

> My perspective is to stay on the safe side, keep one in the LTP root
> dir and one in the subproject(e.g. open_posix).
This makes sense. I'll send RFC patch with your ack.

> The general files go with the SPDX identifier header.
+1

Kind regards,
Petr
