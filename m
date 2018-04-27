From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Apr 2018 02:03:27 +0200
Subject: [LTP] [RFC PATCH v3 02/10] security/ima: Change order of tests
In-Reply-To: <1524759610.3647.13.camel@linux.vnet.ibm.com>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180419195503.7194-3-pvorel@suse.cz>
 <20180424180953.vbn2cancyxk7ghnk@dell5510>
 <1524753172.5349.7.camel@linux.vnet.ibm.com>
 <1524759610.3647.13.camel@linux.vnet.ibm.com>
Message-ID: <20180427000327.GA25413@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi,

> On Thu, 2018-04-26 at 10:32 -0400, Mimi Zohar wrote:
> > On Tue, 2018-04-24 at 20:09 +0200, Petr Vorel wrote:

> [...]
> > The original tests assumed a builtin IMA-measurement policy.  Either
> > the boot command line "ima_tcb" or "ima_policy=tcb" options should
> > work.  When checking the "ima_policy" for "tcb", it could be specified
> > anywhere in the list of builtin policies (eg.
> > ima_policy=appraise_tcb|secure_boot|ima).

> oops, ima_policy=appraise_tcb|secure_boot|tcb.
Thanks for clarification. I'll grep /proc/cmdline it in ima_setup.sh and TCONF if it's not met (I suppose this requirement/assumption is for all 4 tests).

> Mimi


Kind regards,
Petr

