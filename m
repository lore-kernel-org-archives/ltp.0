From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Feb 2019 13:33:46 -0500 (EST)
Subject: [LTP] [PATCH] adding s390x tests to ltp
In-Reply-To: <20190218182137.GA27553@dell5510>
References: <20190204161328.4616-1-elas@linux.vnet.ibm.com>
 <1740320205.101841684.1549543929404.JavaMail.zimbra@redhat.com>
 <20190218182137.GA27553@dell5510>
Message-ID: <1043798029.1537735.1550514826801.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan, Cyril,
> 
> > Maybe also: TST_NEEDS_CMDS="vmcp" ?
> > Not sure if all s390x distros have this command installed.
> 
> > But that should also be sufficient check to run this on any arch,
> > if command doesn't exist it will TCONF.
> 
> The reason, why I suggested to move these tests to upstream [1]
> is that testing "vmcp --version" or "vmcp --help" does not really depend on
> anyhow on SUT. Adding it to upstream into make check (there are none check
> yet)
> would bring 1) earlier catch of potencial bugs as upstream developers can run
> it
> for each commit (CI) and distros during package build.
> 
> We had some discussion before about removing some user space packages [2].
> Cyril suggested to to keep tests that are working with files (cp/df/ln)
> and remove at least unzip and wc.
> Doing some real testing (really using vmcp.ko) would make this tests useful
> to
> run on LTP, but current code IMHO does nothing with kernel. Or do I miss
> something?
> 
> Anyway, it looks like you have no objection about adding it to LTP

I don't. My only question was if runtest/commands would be more fitting
for the test, but people seemed to prefer s390x specific runtest-file instead.

Regards,
Jan

>, so I
> changed
> state of this test New. In that case, I suggest to
> 
> remove debugging:
> > +#set -x
> > +#
> 
> use tst_res TINFO instead of echo
> +	echo "verifyBasicVMCPCommands"
> +	echo "verifyErrorCondition"
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/ibm-s390-tools/s390-tools
> [2] https://patchwork.ozlabs.org/patch/905064/#1902070
> 
