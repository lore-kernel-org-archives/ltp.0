From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Aug 2019 12:54:59 +0200
Subject: [LTP] [PATCH 2/2] runtest/numa: add migrate_pages*
In-Reply-To: <5D687F5A.80002@cn.fujitsu.com>
References: <1566987255-3010-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1566987255-3010-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190829204149.GB5711@dell5510> <5D687F5A.80002@cn.fujitsu.com>
Message-ID: <20190830105459.GB9330@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> On 2019/08/30 4:41, Petr Vorel wrote:
> > Hi Xu,

> > > Since migrate_pages must depend on numa, add it into
> > > runtest/numa.
> > > Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> > Thanks for the patch, merged.
> Hi Petr,

> Why don't sort numa tests alphabetically as my replied?
I'm sorry. I overlooked it as you put your commend to 1st commit
(this is a second commit). Feel free to fix it or I'll do it later today.

BTW I suggest also sort alphabetically Numa-testcases numa01.sh
and rename it to numa_testcases numa01.sh

Kind regards,
Petr
