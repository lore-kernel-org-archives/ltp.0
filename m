From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 Sep 2017 04:06:15 -0400 (EDT)
Subject: [LTP] Issue running cpuset_base_ops_testset shell script
In-Reply-To: <CALhEcWHtmEd+VHOOSHCzpLppCRVAe8pUYrJD1+aGim=4oA2T7g@mail.gmail.com>
References: <CALhEcWHtmEd+VHOOSHCzpLppCRVAe8pUYrJD1+aGim=4oA2T7g@mail.gmail.com>
Message-ID: <1171612333.22940868.1506499575369.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> **LTP Version: 20160920

This is quite old.

> Kernel Version: 3.10.0-327.el7.x86_64
> OS: CentOS Linux release 7.2.1511 (Core)**
> 
> Good day, i'm trying to run this test script
> "**cpuset_base_ops_testset.sh**" but when i do that i have multiple
> errors related to some missing devices under **/dev/cpuset/** here is
> the output:
> ```
> opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/cpus: Permission denied

And I assume you are running systemd, which mounts it elsewhere
and test can't cope with that.

I think there was a patch posted:
  http://lists.linux.it/pipermail/ltp/2017-April/004348.html
but it looks it might have been forgotten after the last release.

Would you care to give it a try with latest LTP?

Regards,
Jan
