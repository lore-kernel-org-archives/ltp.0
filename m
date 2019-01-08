From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 8 Jan 2019 06:14:30 -0500 (EST)
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <20190107192226.GF15221@rei.lan>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181211145833.GB1180@rei>
 <124327317.93121782.1546516348350.JavaMail.zimbra@redhat.com>
 <20190107182514.GD15221@rei.lan>
 <500744608.93718432.1546887963138.JavaMail.zimbra@redhat.com>
 <20190107192226.GF15221@rei.lan>
Message-ID: <2095445076.93880979.1546946070949.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > > > We can always name the BUILD_BUG_ON() macro to be
> > > > > TST_BRK_ONLY_SUPPORTS_TCONF_TBROK_TFAIL() and be done with it.
> > > > > 
> > > > > I would rather avoided playing with specific compiler features etc.
> > > > > So
> > > > > this version looks good to me.
> > > > 
> > > > Pushed the original version for now.
> > > 
> > > FYI looks like we need to rename the BUILD_BUG_ON() after all:
> > 
> > LTP_BUILD_BUG_ON() or do you have something other in mind?
> 
> Most of the new library has TST_ prefix, but we can still rename it to
> TST_BRK_SUPPORTS_ONLY_TCONF_TBROK()...

OK, I pushed patch that renames it to above.

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
