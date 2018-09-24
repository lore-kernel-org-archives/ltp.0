From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Sep 2018 08:58:35 +0200
Subject: [LTP] [PATCH] change the default command file of network
In-Reply-To: <20180903094052.GA20693@dell5510>
References: <1536022690-17612-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1536022690-17612-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180903094052.GA20693@dell5510>
Message-ID: <20180924065835.GA16373@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sun,

> > From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>

> > The options -N of runltp means "Run all the networking tests", and when
> > exec  runltp -N and no command files were provied, the cmmand file of
> > "$LTPROOT/scenario_groups/network" should execute, so the the "$LTPROOT/
> > scenario_groups/network" should include the all the networking tests.

> > Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>

> Acked-by: Petr Vorel <pvorel@suse.cz>

> > ---
> >  scenario_groups/network | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
...

> Although, network.sh is preferred way to run network tests.

> + net_stress.multicast and net_stress.route needs remove dependency on rsh,
> so it's a question whether add them now.

Pushed (with net_stress.multicast and net_stress.route).


Kind regards,
Petr
