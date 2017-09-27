From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Sep 2017 12:11:50 +0200
Subject: [LTP] Issue running cpuset_base_ops_testset shell script
In-Reply-To: <1171612333.22940868.1506499575369.JavaMail.zimbra@redhat.com>
References: <CALhEcWHtmEd+VHOOSHCzpLppCRVAe8pUYrJD1+aGim=4oA2T7g@mail.gmail.com>
 <1171612333.22940868.1506499575369.JavaMail.zimbra@redhat.com>
Message-ID: <20170927101149.GD12153@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Good day, i'm trying to run this test script
> > "**cpuset_base_ops_testset.sh**" but when i do that i have multiple
> > errors related to some missing devices under **/dev/cpuset/** here is
> > the output:
> > ```
> > opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> > /dev/cpuset/cpus: Permission denied
> 
> And I assume you are running systemd, which mounts it elsewhere
> and test can't cope with that.
> 
> I think there was a patch posted:
>   http://lists.linux.it/pipermail/ltp/2017-April/004348.html
> but it looks it might have been forgotten after the last release.

My bad, I should have looked into that one. It looks more or less good
(minus some bashism and style). Most of it is just adding a prefix to
the paths anyway.

-- 
Cyril Hrubis
chrubis@suse.cz
