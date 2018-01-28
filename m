From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Sat, 27 Jan 2018 19:47:20 -0500
Subject: [LTP] [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
In-Reply-To: <20180126175110.boaepz6dqe3uojq6@dell5510>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <1516815417.3686.55.camel@linux.vnet.ibm.com>
 <20180125203057.mzzpilp6i43xftka@dell5510>
 <1516919365.6513.72.camel@linux.vnet.ibm.com>
 <20180126175110.boaepz6dqe3uojq6@dell5510>
Message-ID: <1517100440.29187.120.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, 2018-01-26 at 18:51 +0100, Petr Vorel wrote:

> > It would be nice to be able to define policies that limit testing to a
> > specific filesystem/device.  Without being able to limit IMA-appraisal 
> > testing to specific devices, things might stop working rather quickly.
> Not sure how to define it, I need to study the specification. Or can
> you be more specific?

These tests are for the IMA-measurement aspect only, not IMA-
appraisal.  Adding measurements to the measurement list won't cause
the system to stop working, unless keys are sealed to a particular TPM
PCR value.  Nobody is or should be sealing keys to PCR-10, since the
ordering of the measurements is non deterministic.

As we add IMA-appraisal tests requiring files to be signed, things
will fail if either the public key isn't on the IMA keyring or the
file isn't properly signed.  For this reason, limiting file IMA-
appraisal tests to a particular filesystem simplifies testing.

> BTW I suppose that kernel code supports both TPM 2.0 and the old 1.2.

Yes, Jarkko added TPM 2.0 support, including IMA support.

> > > > Originally IMA allowed a builtin policy to be replaced with a custom
> > > > policy, by simply cat'ing a file into the securityfs IMA policy file.
> > > > Currently, if new rules can be added to the custom policy (Kconfig
> > > > IMA_WRITE_POLICY enabled), the policy file must be signed.  Similarly,
> > > > if the builtin "secure-boot" policy is defined on the boot command
> > > > line, the custom policy must be signed.  Test "ima01 ima_policy.sh"
> > > > should first detect if the policy must be signed, before running the
> > > > tests.
> 
> > > Right, I'll check it. Is there other way how to detect it than reading
> > > /boot/config-$(uname -r) or /proc/config.gz ? I'm asking because IMA might be using on
> > > embedded devices (guessing from [2], [3]), which might not have either of them.
> This is important. As Cyril agreed with me grepping /boot/config-$(uname -r) or
> /proc/config.gz isn't good solution. I don't see any ioctl interface and
> security/integrity/ima/ima_fs.c which handles IMA sysfs doesn't have this functionality.
> Is it deliberate (security reason), that it's not exported to users?

This isn't really an IMA issue, but a TPM one.  The TPM device driver
would need to export this information.

Mimi

