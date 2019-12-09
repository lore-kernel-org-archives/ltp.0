From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Dec 2019 22:06:59 +0100
Subject: [LTP] [PATCH] cpuhotplug05.sh: Rewrite test case
In-Reply-To: <8f5e7d2a-34a8-5d2a-658c-a1f535fd1cc7@suse.cz>
References: <20191202101943.17335-1-ice_yangxiao@163.com>
 <7b7c1e8a-1db1-bf9f-96ff-01803416120e@suse.cz>
 <31fe4c0c-863e-4ba6-d8d7-1af909013fb7@163.com>
 <8f5e7d2a-34a8-5d2a-658c-a1f535fd1cc7@suse.cz>
Message-ID: <20191209210659.GA3820@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On 12/9/19 4:13 AM, Xiao Yang wrote:
> >> Your new scenario has two problems:

> >> - You have to run at least two test loops to verify that reactivating a
> >> CPU doesn't break /proc/stat entries.

> > I think running cpuhotplug05.sh with -i 2 can verfiy this point.

> > Perhaps we can add -i option to runtest/cpuhotplug, or do you prefer to
> > keep the original scenario?

> I'd prefer keeping the original scenario (with your version of cleanup).
> Running extra iterations of the same test should not be required to get
> the full intended test coverage.
Agree with Martin. Yang, could you, please, send new version, where you keep it?


Kind regards,
Petr
