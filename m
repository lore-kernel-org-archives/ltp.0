From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 04 Apr 2019 15:19:12 -0400
Subject: [LTP] [PATCH 3/3] ima: Add overlay test
In-Reply-To: <20190404181901.GA22718@dell5510>
References: <20190327161638.7407-1-pvorel@suse.cz>
 <20190327161638.7407-4-pvorel@suse.cz>
 <1553856587.9420.44.camel@linux.ibm.com> <20190404181901.GA22718@dell5510>
Message-ID: <1554405552.3839.41.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, 2019-04-04 at 20:19 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> thanks for your comments!
> 
> > > +	grep -q ima_appraise_tcb /proc/cmdline || \
> > > +		tst_brk TCONF "Test requires ima_appraise_tcb kernel parameter"
> 
> > Instead of specifying individual policies separately, the newer method
> > of specifying builtin IMA policies on the boot command line is
> > "ima_policy=", with a list of policies.  The builtin appraise policy
> > would be specified as "ima_policy=appraise_tcb".  Refer to
> > Documentation/admin-guide/kernel-parameters.txt for the list of
> > builtin policies.
> I guess grep for any policy (ima_policy=) or ima_appraise_tcb shold e enough.
> Am I right?

Yes

> 
> BTW I guess ima_appraise_tcb should be deprecated in kernel-parameters.txt.

and yes

> 
> > > +}
> > > +
> > > +do_test()
> > > +{
> > > +	local file="foo.txt"
> > > +	local f
> > > +
> > > +	tst_mount
> > > +	mounted=1
> > > +
> > > +	ROD echo lower \> $lower/$file
> 
> > For some reason "mntpoint/lower" isn't loopback mounted.  With the
> > builtin appraise policy, because it is a tmpfs filesystem,
> > security.ima does not exist.  Writing to the merged directory then
> > fails.
> 
> > + df -T mntpoint/lower
> > Filesystem     Type  1K-blocks   Used Available Use% Mounted on
> > tmpfs          tmpfs   4020348 262316   3758032   7% /tmp
> My bad, I forged to add TST_NEEDS_DEVICE=1 to ima_overlay.sh (I'll add it into
> v2). That was the missing piece to enable loop device (in the end of ima_setup.sh)

thanks!
> 
> 
> > + getfattr -m '^security' --dump mntpoint/lower/foo.txt
> > # file: mntpoint/lower/foo.txt
> > security.evm=0sAq8niNi4X7cYntKSAki1Woc+Y5Yq
> > security.selinux="unconfined_u:object_r:user_tmp_t:s0"
> 
> 
> Kind regards,
> Petr
> 

