From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Apr 2018 15:58:29 +0200
Subject: [LTP] [PATCH v3] *.py : convert python2 to python3
In-Reply-To: <5AE056FD.4000208@cn.fujitsu.com>
References: <20180419101038.22451-1-yosun@suse.com>
 <20180423081206.25470-1-yosun@suse.com>
 <20180424090521.ypic57umpsdfpilg@dell5510>
 <5AE056FD.4000208@cn.fujitsu.com>
Message-ID: <20180425135829.u6spezltihkfghtt@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Hi Petr,

> It seems that many distros still use python2 interpreter instead of python3 by default.
> Do you want to install python3 package forcely before testing python code in ltp?
Yes, LTP now depends optionally on Python3. Given short time for python2 [1], it didn't
make much sense to support both Python 2 & 3.

> Is it necessary to make sure all python3 code are compatible with python2 interpreter?
Current code is Python 3 compatible. Or have you find any issue?

Actually we've been thinking to remove all python from LTP because is not usually on
embedded Linux (well, Python can be cross-compiled for embedded [2], but 1) some devices
are still to slow to have it 2) it wouldn't be easy to install it on embedded device
yourself).

> Thanks,
> Xiao Yang

Kind regards,
Petr

[1] https://pythonclock.org/
[2] https://wiki.python.org/moin/EmbeddedPython
