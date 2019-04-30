From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Apr 2019 11:05:48 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190429210708.GB30772@dell5510>
References: <20190418111812.GB3073@rei.lan> <20190426131258.GA18760@rei>
 <20190429102009.GC6952@dell5510> <20190429131331.GB6265@rei>
 <20190429143336.GD6265@rei> <20190429210708.GB30772@dell5510>
Message-ID: <20190430090547.GB30997@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > And I guess I found the problem.
> 
> > When I tried to fix the out-of-tree build by adding a rule to create the libs
> > directory I overlooked that there are all rules already in place and all that
> > had to be added was the dependency of libs-all on the builddir libs path. After
> > I added the rule that created the directory the libs-all targed was fulfilled
> > by a redefined target that only created the directory and haven't build the
> > libs directory before the rest of the source tree at all. We even got target
> > redefinition warnings because of that.
> 
> > Peter can you please test with this change:
> 
> Sure! While this one is ok [1], and also with previous patch [2].
> But when tested on real HW with 32 cores (with merged both commits), where it
> took me 6 iterations to trigger this error :( (5 iterations was needed to
> trigger error on the current master).

That means that the dependencies are still not correct and we still
fail to build the library before everything else.

-- 
Cyril Hrubis
chrubis@suse.cz
